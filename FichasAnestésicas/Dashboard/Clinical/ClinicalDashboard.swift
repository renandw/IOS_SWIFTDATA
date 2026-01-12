//
//  ClinicalDashboard.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 11/01/26.
//

import SwiftUI
import SwiftData
import Charts

struct ClinicalDashboardView: View {
    let userId: String
    let patients: [Patient]
    
    @Environment(SessionManager.self) var session
    @State private var filters = ClinicalFilters()
    @State private var isFilterSheetPresented = false
    
    private var hasActiveFilters: Bool {
        filters.hasActiveFilters
    }
    
    var filteredPatients: [Patient] {
        Array(
            Set(
                patients
                    .flatMap { $0.surgeries ?? [] }
                    .filter { surgery in
                        let matchesPatient = filters.patient.isEmpty ||
                            surgery.patient.name.localizedCaseInsensitiveContains(filters.patient)

                        let matchesSex = filters.sex == nil ||
                            surgery.patient.sex == filters.sex

                        let matchesASA = filters.asa == nil ||
                            surgery.shared?.asa == filters.asa

                        let matchesWeight = filters.weight == nil ||
                            surgery.weight == filters.weight

                        let matchesHospital = filters.hospital.isEmpty ||
                            surgery.hospital.localizedCaseInsensitiveContains(filters.hospital)

                        let matchesProcedure = filters.procedure.isEmpty ||
                            surgery.proposedProcedure.localizedCaseInsensitiveContains(filters.procedure)

                        let matchesSurgeon = filters.surgeon.isEmpty ||
                            surgery.mainSurgeon.localizedCaseInsensitiveContains(filters.surgeon)

                        let matchesInsurance = filters.insurance.isEmpty ||
                            surgery.insuranceName.localizedCaseInsensitiveContains(filters.insurance)

                        let matchesDateRange = !filters.useDateFilter ||
                            (surgery.date >= filters.startDate &&
                             surgery.date <= filters.endDate)

                        let matchesPaid = filters.paid == nil ||
                            surgery.financial?.paid == filters.paid

                        return matchesPatient && matchesSex && matchesASA &&
                               matchesWeight && matchesHospital &&
                               matchesProcedure && matchesSurgeon &&
                               matchesInsurance && matchesDateRange &&
                               matchesPaid
                    }
                    .map(\.patient)
            )
        )
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("Painel Clínico")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    ASAGraphView(
                        patients: filteredPatients,
                        filters: filters
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                    SexGraphView(
                        patients: filteredPatients
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                }
                .padding()
                .navigationTitle("Estatísticas Clínicas")
                .navigationBarTitleDisplayMode(.large)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(.tertiarySystemGroupedBackground))
        }
        .toolbar {
            ToolbarItem {
                if !patients.isEmpty{
                    if filters.hasActiveFilters {
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass")
                        }
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            ClinicalFilterSheetView(
                filters: $filters,
                showDateFilter: true,
                isFilterSheetPresented: $isFilterSheetPresented
            )
            .presentationDetents([.height(filters.useDateFilter ? 550 : 400), .large])
        }
    }
}

struct ASAGraphView: View {
    let patients: [Patient]
    let filters: ClinicalFilters
    
    @Environment(SessionManager.self) var session
    
    private var asaDistribution: [(asa: ASAClassification, count: Int, percentage: Double)] {
        let allSurgeries = patients.flatMap { $0.surgeries ?? [] }
        let filteredSurgeries = allSurgeries.filter { surgery in
            let matchesPatient = filters.patient.isEmpty || surgery.patient.name.localizedCaseInsensitiveContains(filters.patient)
            let matchesSex = filters.sex == nil || surgery.patient.sex == filters.sex
            let matchesASA = filters.asa == nil || surgery.shared?.asa == filters.asa
            let matchesWeight = filters.weight == nil || surgery.weight == filters.weight
            let matchesHospital = filters.hospital.isEmpty || surgery.hospital.localizedCaseInsensitiveContains(filters.hospital)
            let matchesProcedure = filters.procedure.isEmpty || surgery.proposedProcedure.localizedCaseInsensitiveContains(filters.procedure)
            let matchesSurgeon = filters.surgeon.isEmpty || surgery.mainSurgeon.localizedCaseInsensitiveContains(filters.surgeon)
            let matchesInsurance = filters.insurance.isEmpty || surgery.insuranceName.localizedCaseInsensitiveContains(filters.insurance)
            let matchesDateRange = !filters.useDateFilter || (surgery.date >= filters.startDate && surgery.date <= filters.endDate)
            let matchesPaid = filters.paid == nil || surgery.financial?.paid == filters.paid
            
            return matchesPatient && matchesSex && matchesASA && matchesWeight && matchesHospital && matchesProcedure && matchesSurgeon && matchesInsurance && matchesDateRange && matchesPaid
        }
        
        let asaValues = filteredSurgeries.compactMap { $0.shared?.asa }
        guard !asaValues.isEmpty else { return [] }
        
        let total = Double(asaValues.count)
        let grouped = Dictionary(grouping: asaValues, by: { $0 })
        
        return grouped.map { (asa: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted { $0.asa.rawValue < $1.asa.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Distribuição ASA")
                .font(.title2)
                .bold()
            
            if asaDistribution.isEmpty {
                ContentUnavailableView(
                    "Sem dados",
                    systemImage: "chart.pie",
                    description: Text("Nenhuma classificação ASA registrada")
                )
            } else {
                Chart(asaDistribution, id: \.asa) { item in
                    SectorMark(
                        angle: .value("Count", item.count),
                        innerRadius: .ratio(0.5),
                        angularInset: 1.5
                    )
                    .cornerRadius(5)
                    .foregroundStyle(item.asa.tintColor)
                }
                .frame(height: 150)
                
                // Legenda
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(asaDistribution, id: \.asa) { item in
                        HStack {
                            Circle()
                                .fill(item.asa.tintColor)
                                .frame(width: 12, height: 12)
                            
                            Text(item.asa.displayName)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text("\(item.count) (\(item.percentage, specifier: "%.1f")%)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
        }
        .padding()
    }
}

struct SexGraphView: View {
    let patients: [Patient]
    
    @Environment(SessionManager.self) var session
    
    private var sexDistribution: [(sex: Sex, count: Int, percentage: Double)] {
        let sexValues = patients.map { $0.sex }
        guard !sexValues.isEmpty else { return [] }
        
        let total = Double(sexValues.count)
        let grouped = Dictionary(grouping: sexValues, by: { $0 })
        
        return grouped.map { (sex: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted { $0.sex.rawValue < $1.sex.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Distribuição por Sexo")
                .font(.title2)
                .bold()
            
            if sexDistribution.isEmpty {
                ContentUnavailableView(
                    "Sem dados",
                    systemImage: "chart.pie",
                    description: Text("Nenhum paciente registrado")
                )
            } else {
                Chart(sexDistribution, id: \.sex) { item in
                    SectorMark(
                        angle: .value("Count", item.count),
                        innerRadius: .ratio(0.5),
                        angularInset: 1.5
                    )
                    .cornerRadius(5)
                    .foregroundStyle(item.sex.sexColor)
                }
                .frame(height: 150)
                
                // Legenda
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(sexDistribution, id: \.sex) { item in
                        HStack {
                            Image(systemName: item.sex.sexImage)
                                .foregroundStyle(item.sex.sexColor)
                                .frame(width: 20)
                            
                            Text(item.sex.sexStringDescription)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text("\(item.count) (\(item.percentage, specifier: "%.1f")%)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
        }
        .padding()
    }
}

#Preview("Anesthesia • completo") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let cbhpm = CbhpmProcedure.samples(surgeries: surgeries)
    let financial = Financial.samples(surgeries: surgeries)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
    let vitalSigns = VitalSignEntry.samples(anesthesias: anesthesias)
    let medications = MedicationEntry.samples(anesthesias: anesthesias)
    let preanesthesias = PreAnesthesia.samples(
        surgeries: surgeries,
        shared: shared,
        user: user
    )

    let session = SessionManager()
    session.currentUser = user

    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }
        cbhpm.forEach { context.insert($0) }
        financial.forEach { context.insert($0) }
        preanesthesias.forEach { context.insert($0) }
        vitalSigns.forEach{ context.insert($0) }
        medications.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!


    return NavigationStack {
        ClinicalDashboardView(userId: user.userId, patients: patients)
            .environment(session)
    }
    .modelContainer(container)
}
