//
//  SexGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//
import SwiftUI
import Charts


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
                HStack {
                    Chart(sexDistribution, id: \.sex) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(item.sex.sexColor)
                    }
                    .frame(height: 190)
                    
                    // Legenda
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(sexDistribution, id: \.sex) { item in
                            NavigationLink(
                                destination: ListView(
                                    title: "Sexo \(item.sex.sexStringDescription)",
                                    patients: patients
                                        .filter { $0.sex == item.sex }
                                        .sorted { $0.name < $1.name }
                                )
                            ) {
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Image(systemName: item.sex.sexImage)
                                            .foregroundStyle(item.sex.sexColor)
                                            .frame(width: 20)
                                        Text(item.sex.sexStringDescription)
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
    
    let session = SessionManager()
    session.currentUser = user
    
    return NavigationStack {
        SexGraphView(
            patients: patients,
            //filters: ClinicalFilters()
        )
        .environment(session)
    }
}
