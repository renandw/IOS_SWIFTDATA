//
//  ASAGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//
import SwiftUI
import Charts

struct ASAGraphView: View {
    let surgeries: [Surgery]
    let filters: ClinicalFilters
    
    @Environment(SessionManager.self) var session
    
    private var filteredSurgeries: [Surgery] {
        surgeries.filter { surgery in
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
    }
    
    private var asaDistribution: [(asa: ASAClassification, count: Int, percentage: Double)] {
        let asaValues = filteredSurgeries.compactMap { $0.shared?.asa }
        guard !asaValues.isEmpty else { return [] }
        
        let total = Double(asaValues.count)
        let grouped = Dictionary(grouping: asaValues, by: { $0 })
        
        return grouped.map { (asa: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted { $0.asa.rawValue < $1.asa.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 2) {
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
                HStack {
                    Chart(asaDistribution, id: \.asa) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(item.asa.tintColor)
                    }
                    .frame(height: 190)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(asaDistribution, id: \.asa) { item in
                            NavigationLink(
                                destination: SurgeryListView(
                                    title: item.asa.displayName,
                                    surgeries: filteredSurgeries
                                        .filter { $0.shared?.asa == item.asa }
                                        .sorted { $0.date > $1.date }
                                )
                            ) {
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack(alignment: .center) {
                                        Circle()
                                            .fill(item.asa.tintColor)
                                            .frame(width: 12, height: 12)
                                        
                                        Text(item.asa.displayName)
                                            .font(.subheadline)
                                            .bold()
                                        Image(systemName: "chevron.right.circle")
                                            .font(.caption)
                                            .foregroundStyle(.blue)
                                        
                                        Spacer()
                                    }
                                    Text("\(item.count) (\(item.percentage, specifier: "%.1f")%)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
                
            }
            
        }
        .padding()
    }
}

#Preview("Age Distribution") {
    let user = User.sampleUser
    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    
    let session = SessionManager()
    session.currentUser = user
    
    return NavigationStack {
        ASAGraphView(
            surgeries: surgeries,
            filters: ClinicalFilters()
        )
        .environment(session)
    }
}
