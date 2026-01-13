//
//  AnesthesiaTechniqueGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//
import SwiftUI
import Charts

struct AnesthesiaTechniqueGraphView: View {
    let anesthesias: [Anesthesia]
    let filters: ClinicalFilters
    
    @Environment(SessionManager.self) var session
    
    private var filteredAnesthesias: [Anesthesia] {
        anesthesias.filter { anesthesia in
            let surgery = anesthesia.surgery
            
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
    
    private var techniqueDistribution: [(techniques: [AnesthesiaTechniqueKind], count: Int, percentage: Double)] {
        let techniqueCombinations = filteredAnesthesias.compactMap { anesthesia -> [AnesthesiaTechniqueKind]? in
            guard let techniques = anesthesia.shared?.techniques, !techniques.isEmpty else { return nil }
            return techniques.sorted { $0.rawValue < $1.rawValue }
        }
        
        guard !techniqueCombinations.isEmpty else { return [] }
        
        let total = Double(techniqueCombinations.count)
        let grouped = Dictionary(grouping: techniqueCombinations, by: { $0 })
        
        return grouped.map { (techniques: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted {
                if $0.count == $1.count {
                    return $0.techniques.map(\.rawValue).joined() < $1.techniques.map(\.rawValue).joined()
                }
                return $0.count > $1.count
            }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Técnicas Anestésicas")
                .font(.title2)
                .bold()
            
            if techniqueDistribution.isEmpty {
                ContentUnavailableView(
                    "Sem dados",
                    systemImage: "chart.pie",
                    description: Text("Nenhuma técnica anestésica registrada")
                )
            } else {
                VStack {
                    Chart(techniqueDistribution, id: \.techniques) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(
                            LinearGradient(
                                colors: item.techniques.map { $0.color },
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    }
                    .frame(height: 190)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(techniqueDistribution, id: \.techniques) { item in
                            NavigationLink(
                                destination: SurgeryListView(
                                    title: item.techniques.map { $0.displayName }.joined(separator: " + "),
                                    surgeries: filteredAnesthesias
                                        .filter { anesthesia in
                                            let sorted = (anesthesia.shared?.techniques ?? []).sorted { $0.rawValue < $1.rawValue }
                                            return sorted == item.techniques
                                        }
                                        .map { $0.surgery }
                                        .sorted { $0.date > $1.date }
                                )
                            ) {
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(
                                                LinearGradient(
                                                    colors: item.techniques.map { $0.color },
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(width: 12, height: 12)
                                        
                                        Text(item.techniques.map { $0.displayName }.joined(separator: " + "))
                                            .font(.subheadline)
                                            .bold()
                                        
                                        Image(systemName: "chevron.right.circle")
                                            .font(.subheadline)
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
