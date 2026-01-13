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
                        surgeries: patients.flatMap { $0.surgeries ?? [] },
                        filters: filters
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                    SexGraphView(
                        patients: filteredPatients
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                    InsuranceGraphView(
                        surgeries: patients.flatMap { $0.surgeries ?? [] },
                        filters: filters
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                    AgeGraphView(
                        surgeries: patients.flatMap { $0.surgeries ?? [] },
                        filters: filters
                    )
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 12))
                    AnesthesiaTechniqueGraphView(
                        anesthesias: patients
                                .flatMap { $0.surgeries ?? [] }
                                .compactMap { $0.anesthesia },
                        filters: filters
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

