//
//  MonthFinancial.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 07/12/25.
//

import SwiftUI



struct MonthFinancialView: View {
    let monthDate: Date
    let stats: MonthStats
    let surgeries: [Surgery]
    
    @State private var filters = SurgeryFilters()
    
    @State private var isFilterSheetPresented = false
    
    var filteredSurgeries: [Surgery] {
        surgeries.filter { surgery in
            (filters.patient.isEmpty || surgery.patient.name.localizedCaseInsensitiveContains(filters.patient)) &&
            (filters.hospital.isEmpty || surgery.hospital.localizedCaseInsensitiveContains(filters.hospital)) &&
            (filters.surgeon.isEmpty || surgery.mainSurgeon.localizedCaseInsensitiveContains(filters.surgeon)) &&
            (filters.insurance.isEmpty || surgery.insuranceName.localizedCaseInsensitiveContains(filters.insurance))
        }
    }
    
    var body: some View {
        let monthTitle = monthDate.formatted(.dateTime.month(.wide).year())
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(monthTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                
                MonthStatCard(
                    icon: "calendar",
                    cardName: monthTitle,
                    title: monthTitle,
                    stats: stats,
                    iconColor: .blue
                )
                
                if surgeries.isEmpty {
                    ContentUnavailableView(
                        "Nenhuma cirurgia neste mês",
                        systemImage: "calendar.badge.exclamationmark"
                    )
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Estatísticas")
                                .font(.headline)
                            Spacer ()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("Cirurgias: \(surgeries.count)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Contagem Por Convênio")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            // Cria um dicionário [String: Int] com as contagens por convênio
                            let insuranceCounts = Dictionary(grouping: surgeries, by: { $0.insuranceName })
                                .mapValues { $0.count }
                            
                            // Se quiser ordenar por nome do convênio:
                            let sortedInsuranceCounts = insuranceCounts.sorted { $0.value > $1.value }
                            
                            let insuranceRevenue = Dictionary(grouping: surgeries, by: { $0.insuranceName })
                                .mapValues { surgeries in
                                    surgeries.compactMap { $0.financial?.finalSurgeryValue }.reduce(0, +)
                                }
                            
                            // Depois na UI:
                            ForEach(sortedInsuranceCounts, id: \.key) { insuranceName, count in
                                HStack {
                                    Text(insuranceName)
                                    Spacer()
                                    Spacer()
                                    Text("\(count)")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(String(format: "R$ %.2f", insuranceRevenue[insuranceName] ?? 0))
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding()
                        .glassEffect(in: .rect(cornerRadius: 12))
                    }
                    
                    
                    HStack {
                        Text("Cirurgias: \(filteredSurgeries.count)")
                            .font(.headline)
                        Spacer()
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "line.3.horizontal.decrease.circle")
                                .labelStyle(.iconOnly)
                        }
                    }
                    .padding(.top, 8)
                    
                    ForEach(filteredSurgeries) { surgery in
                        HStack{
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(surgery.patient.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    if let financial = surgery.financial {
                                        if financial.paid {
                                            VStack {
                                                HStack {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.green)
                                                    Text("Pago")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.green)
                                                }
                                                if let payDate = financial.paymentDate {
                                                    Text(payDate, style: .date)
                                                        .font(.caption)
                                                        .fontWeight(.heavy)
                                                }
                                            }
                                        } else {
                                            HStack{
                                                Image(systemName: "exclamationmark.circle.fill")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.orange)
                                                Text("Pendente")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.orange)
                                            }
                                        }
                                    }
                                }
                                
                                HStack {
                                    Text(surgery.proposedProcedure)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                    Text ("-")
                                    Text(surgery.mainSurgeon)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                }
                                
                                Text(surgery.date, style: .date)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Text("Convênio:")
                                        .font(.subheadline)
                                    Text(surgery.insuranceName)
                                        .font(.subheadline)
                                    Spacer()
                                    if let financial = surgery.financial {
                                        Text("\(formatCurrency(financial.finalSurgeryValue ?? 0))")
                                            .font(.footnote)
                                            .fontWeight(.black)
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding(.bottom, 2)
                                
                                Divider()
                                HStack {
                                    HStack(alignment: .top) {
                                        NavButton(title: "Paciente",
                                                  icon: "person.circle",
                                                  destination: PatientDetailsView(patient: surgery.patient))
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        NavButton(title: "Cirurgia",
                                                  icon: "stethoscope.circle",
                                                  destination: SurgeryDetailsView(surgery:surgery))
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        NavButton(title: "Valores",
                                                  icon: "brazilianrealsign.circle",
                                                  destination: FinancialView(surgery:surgery))
                                    }
                                }
                                .padding(.top, 4)
                                
                            }
                        }
                        .padding()
                        .glassEffect(in: .rect(cornerRadius: 12))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(monthTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.tertiarySystemGroupedBackground))
        .sheet(isPresented: $isFilterSheetPresented) {
            FilterSheetView(
                filters: $filters,
                showDateFilter: false,
                isFilterSheetPresented: $isFilterSheetPresented
            )
            .presentationDetents([.height(365), .large])
        }
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}

struct NavButton<Destination: View>: View {
    let title: String
    let icon: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .glassEffect(.regular.interactive())
        }
    }
}
