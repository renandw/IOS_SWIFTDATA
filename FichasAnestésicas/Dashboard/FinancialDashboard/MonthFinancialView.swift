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
    
    private var insuranceCounts: [String: Int] {
        Dictionary(grouping: surgeries, by: { $0.insuranceName })
            .mapValues { $0.count }
    }

    private var sortedInsuranceCounts: [(key: String, value: Int)] {
        insuranceCounts.sorted {
            if $0.value != $1.value {
                return $0.value > $1.value // count desc
            } else {
                return $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending // name asc
            }
        }
    }

    private var insuranceRevenue: [String: Double] {
        Dictionary(grouping: surgeries, by: { $0.insuranceName })
            .mapValues { surgeries in
                surgeries.compactMap { $0.financial?.finalSurgeryValue }.reduce(0, +)
            }
    }
    
    private var particularSurgeries: [Surgery] {
        surgeries.filter { surgery in
            surgery.insuranceName.trimmingCharacters(in: .whitespacesAndNewlines)
                .localizedCaseInsensitiveCompare("particular") == .orderedSame
        }
    }

    private var surgeonCounts: [(key: String, value: Int)] {
        Dictionary(grouping: particularSurgeries, by: { $0.mainSurgeon })
            .mapValues { $0.count }
            .sorted {
                if $0.value != $1.value {
                    return $0.value > $1.value
                } else {
                    return $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending
                }
            }
    }

    private var surgeonRevenue: [String: Double] {
        Dictionary(grouping: particularSurgeries, by: { $0.mainSurgeon })
            .mapValues { surgeries in
                surgeries.compactMap { $0.financial?.finalSurgeryValue }.reduce(0, +)
            }
    }
    
    private func isParticularSurgeonFilterActive(_ surgeon: String) -> Bool {
        let currentSurgeon = filters.surgeon.trimmingCharacters(in: .whitespacesAndNewlines)
        let targetSurgeon = surgeon.trimmingCharacters(in: .whitespacesAndNewlines)

        let surgeonMatches = currentSurgeon.localizedCaseInsensitiveCompare(targetSurgeon) == .orderedSame
        let insuranceMatches = filters.insurance.trimmingCharacters(in: .whitespacesAndNewlines)
            .localizedCaseInsensitiveCompare("particular") == .orderedSame

        return surgeonMatches && insuranceMatches
    }

    private func toggleParticularSurgeonFilter(_ surgeon: String) {
        if isParticularSurgeonFilterActive(surgeon) {
            filters.surgeon = ""
            filters.insurance = ""
        } else {
            filters.surgeon = surgeon
            filters.insurance = "particular"
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
                    VStack(alignment: .leading, spacing: 6) {
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
                            
                            // MARK: Depois na UI:
                            ForEach(sortedInsuranceCounts, id: \.key) { insuranceName, count in
                                HStack(spacing: 8) {
                                    // Convênio
                                    Text(insuranceName)
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    // Cirurgias
                                    Text("\(count) cirurgia\(count > 1 ? "s" : "")")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .monospacedDigit()
                                        .frame(width: 120, alignment: .trailing)

                                    // Receita
                                    Text(formatCurrency(insuranceRevenue[insuranceName] ?? 0))
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .monospacedDigit()
                                        .frame(width: 120, alignment: .trailing)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding()
                        .glassEffect(in: .rect(cornerRadius: 12))
                        
                        
                        
                        Text("Cirurgias Particulares: \(particularSurgeries.count)")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        
                        // MARK: valores particulares por cirurgião
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible())],
                            spacing: 8
                        ) {
                            ForEach(surgeonCounts, id: \.key) { mainSurgeon, count in
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .font(.title3)
                                            .foregroundStyle(.blue)
                                        Spacer()
                                        Text(mainSurgeon)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Cirurgias")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            
                                            Text("\(count)")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.primary)
                                        }
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Receita")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            
                                            Text(formatCurrency(surgeonRevenue[mainSurgeon] ?? 0))
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.primary)
                                        }
                                    }
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .glassEffect(in: .rect(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isParticularSurgeonFilterActive(mainSurgeon) ? Color.blue : Color.clear, lineWidth: 2)
                                )
                                .scaleEffect(isParticularSurgeonFilterActive(mainSurgeon) ? 0.98 : 1.0)
                                .animation(.easeInOut(duration: 0.15), value: isParticularSurgeonFilterActive(mainSurgeon))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    toggleParticularSurgeonFilter(mainSurgeon)
                                }
                            }
                        }
                        
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
                                                    Text(payDate.formatted(date: .numeric, time: .omitted))
                                                        .font(.caption)
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.secondary)
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
                        .contentShape(Rectangle())
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
