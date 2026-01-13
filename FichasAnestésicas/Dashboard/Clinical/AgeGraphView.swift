//
//  AgeGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//
import SwiftUI
import Charts
import SwiftData

struct AgeGraphView: View {
    let surgeries: [Surgery]
    let filters: ClinicalFilters

    private enum AgeGroup: String, CaseIterable {
        case newborn
        case infant
        case preschool
        case school
        case teen
        case youngAdult
        case adult
        case youngElderly
        case elderly
        case veryElderly
        
        var displayTitle: String {
            switch self {
            case .newborn: return "Recém Nascido"
            case .infant: return "Lactente"
            case .preschool: return "Pré-Escolar"
            case .school: return "Escolar"
            case .teen: return "Adolescente"
            case .youngAdult: return "Adulto Jovem"
            case .adult: return "Adulto"
            case .youngElderly: return "Idoso Jovem"
            case .elderly: return "Idoso"
            case .veryElderly: return "Idoso Longevo"
            }
        }
        var displaySubTitle: String {
            switch self {
            case .newborn: return "0-28 dias"
            case .infant: return "29 dias-2 anos"
            case .preschool: return "2-5 anos"
            case .school: return "6-12 anos"
            case .teen: return "12-18 anos"
            case .youngAdult: return "18-39 anos"
            case .adult: return "40-59 anos"
            case .youngElderly: return "60-69 anos"
            case .elderly: return "70-79 anos"
            case .veryElderly: return "80 anos +"
            }
        }
        
        var color: Color {
            switch self {
            case .newborn: return .pink
            case .infant: return .red
            case .preschool: return .orange
            case .school: return .yellow
            case .teen: return .green
            case .youngAdult: return .mint
            case .adult: return .cyan
            case .youngElderly: return .blue
            case .elderly: return .indigo
            case .veryElderly: return .purple
            }
        }
        
        var order: Int {
            switch self {
            case .newborn: return 0
            case .infant: return 1
            case .preschool: return 2
            case .school: return 3
            case .teen: return 4
            case .youngAdult: return 5
            case .adult: return 6
            case .youngElderly: return 7
            case .elderly: return 8
            case .veryElderly: return 9
            }
        }
        
        static func from(birthDate: Date, surgery: Surgery) -> AgeGroup {
            let agecontext = AgeContext.inSurgery(surgery)
            let years = agecontext.ageInYears(from: birthDate)
            let days = Calendar.current.dateComponents([.day], from: birthDate, to: surgery.date).day ?? 0
            
            if days <= 28 { return .newborn }
            if years < 2 { return .infant }
            if years < 6 { return .preschool }
            if years < 12 { return .school }
            if years < 18 { return .teen }
            if years < 40 { return .youngAdult }
            if years < 60 { return .adult }
            if years < 70 { return .youngElderly }
            if years < 80 { return .elderly }
            return .veryElderly
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
    
    private var ageDistribution: [(group: AgeGroup, count: Int, percentage: Double)] {
        let ages = filteredSurgeries.map {
            AgeGroup.from(birthDate: $0.patient.birthDate, surgery: $0)
        }
        
        guard !ages.isEmpty else { return [] }
        
        let total = Double(ages.count)
        let grouped = Dictionary(grouping: ages, by: { $0 })
        
        return grouped.map { (group: $0.key, count: $0.value.count, percentage: Double($0.value.count) / total * 100) }
            .sorted { $0.group.order < $1.group.order }
    }
        
        
    var body: some View {
        VStack(spacing: 16) {
            Text("Distribuição por Faixa Etária")
                .font(.title2)
                .bold()
            
            if ageDistribution.isEmpty {
                ContentUnavailableView(
                    "Sem dados",
                    systemImage: "chart.pie",
                    description: Text("Nenhuma cirurgia encontrada")
                )
            } else {
                HStack {
                    Chart(ageDistribution, id: \.group) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(item.group.color)
                    }
                    .frame(height: 190)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(ageDistribution, id: \.group) { item in
                            NavigationLink(
                                destination: SurgeryListView(
                                    title: item.group.displayTitle,
                                    surgeries: filteredSurgeries
                                        .filter {
                                            AgeGroup.from(birthDate: $0.patient.birthDate, surgery: $0) == item.group
                                        }
                                        .sorted { $0.date > $1.date }
                                )
                            ) {
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Circle()
                                            .fill(item.group.color)
                                            .frame(width: 12, height: 12)
                                        Text(item.group.displayTitle)
                                            .font(.subheadline)
                                            .bold()
                                        Image(systemName: "chevron.right.circle")
                                            .font(.caption)
                                            .foregroundStyle(.blue)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(item.group.displaySubTitle)
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.secondary)
                                    Text("\(item.count) (\(item.percentage, specifier: "%.1f")%)")
                                        .font(.caption)
                                        //.foregroundStyle(.secondary)
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
        AgeGraphView(
            surgeries: surgeries,
            filters: ClinicalFilters()
        )
        .environment(session)
    }
}
