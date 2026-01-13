//
//  InsuranceGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//
import SwiftUI
import Charts

struct InsuranceGraphView: View {
    let surgeries: [Surgery]
    let filters: ClinicalFilters
    
    @Environment(SessionManager.self) var session
    
    private enum InsuranceKind: String, CaseIterable, Hashable {
        case particular = "Particular"
        case convenio = "Convênio"
        
        var color: Color {
            switch self {
            case .particular: return .green
            case .convenio: return .orange
            }
        }
    }
    
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
    
    private var insuranceDistribution: [(kind: InsuranceKind, count: Int, percentage: Double)] {
        let kinds: [InsuranceKind] = filteredSurgeries.map { surgery in
            let name = surgery.insuranceName.trimmingCharacters(in: .whitespacesAndNewlines)
            return name.localizedCaseInsensitiveCompare("particular") == .orderedSame ? .particular : .convenio
        }
        
        guard !kinds.isEmpty else { return [] }
        
        let total = Double(kinds.count)
        let grouped = Dictionary(grouping: kinds, by: { $0 })
        
        return grouped.map { (kind: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted { $0.kind.rawValue < $1.kind.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Distribuição por Convênio")
                .font(.title2)
                .bold()
            
            if insuranceDistribution.isEmpty {
                ContentUnavailableView(
                    "Sem dados",
                    systemImage: "chart.pie",
                    description: Text("Nenhuma cirurgia com informação de pagamento")
                )
            } else {
                HStack {
                    Chart(insuranceDistribution, id: \.kind) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(item.kind.color)
                    }
                    .frame(height: 190)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(insuranceDistribution, id: \.kind) { item in
                            NavigationLink(
                                destination: SurgeryListView(
                                    title: item.kind.rawValue,
                                    surgeries: filteredSurgeries
                                        .filter { surgery in
                                            let name = surgery.insuranceName.trimmingCharacters(in: .whitespacesAndNewlines)
                                            let surgeryKind: InsuranceKind = name.localizedCaseInsensitiveCompare("particular") == .orderedSame ? .particular : .convenio
                                            return surgeryKind == item.kind
                                        }
                                        .sorted { $0.date > $1.date }
                                )
                            ) {
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Circle()
                                            .fill(item.kind.color)
                                            .frame(width: 12, height: 12)
                                        
                                        Text(item.kind.rawValue)
                                            .font(.subheadline)
                                            .bold()
                                        Image(systemName: "chevron.right.circle")
                                            .font(.caption)
                                            .foregroundStyle(.blue)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
    
    let session = SessionManager()
    session.currentUser = user
    
    return NavigationStack {
        InsuranceGraphView(
            surgeries: surgeries,
            filters: ClinicalFilters()
        )
        .environment(session)
    }
}
