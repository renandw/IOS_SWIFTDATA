import SwiftUI
import SwiftData
import Charts

struct FinancialDashboardView: View {
    let userId: String
    let surgeries: [Surgery]
    
    @Environment(SessionManager.self) var session
    @State private var filters = SurgeryFilters()
    @State private var isFilterSheetPresented = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("Painel Financeiro")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Last12MonthsGraphView(
                        surgeries: surgeries
                    )
                    MonthStatSection(
                        surgeries: surgeries,
                        filters: $filters,
                        isFilterSheetPresented: $isFilterSheetPresented
                    )
                    
                }
                .padding()
                .navigationTitle("Financeiro")
                .navigationBarTitleDisplayMode(.large)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(.tertiarySystemGroupedBackground))
        }
        .toolbar {
            ToolbarItem {
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
        .sheet(isPresented: $isFilterSheetPresented) {
            FilterSheetView(
                filters: $filters,
                showDateFilter: true,
                isFilterSheetPresented: $isFilterSheetPresented
            )
            .presentationDetents([.height(filters.useDateFilter ? 550 : 400), .large])
        }
    }
}


struct MonthStatSection: View {
    let surgeries: [Surgery]
    @Binding var filters: SurgeryFilters
    @Binding var isFilterSheetPresented: Bool
    
    private var hasActiveFilters: Bool {
        filters.hasActiveFilters
    }
    
    var filteredSurgeries: [Surgery] {
        surgeries.filter { surgery in
            (filters.patient.isEmpty || surgery.patient.name.localizedCaseInsensitiveContains(filters.patient)) &&
            (filters.hospital.isEmpty || surgery.hospital.localizedCaseInsensitiveContains(filters.hospital)) &&
            (filters.surgeon.isEmpty || surgery.mainSurgeon.localizedCaseInsensitiveContains(filters.surgeon)) &&
            (filters.insurance.isEmpty || surgery.insuranceName.localizedCaseInsensitiveContains(filters.insurance)) &&
            (!filters.useDateFilter || (surgery.date >= filters.startDate && surgery.date <= filters.endDate)) &&
            (filters.paid == nil || surgery.financial?.paid == filters.paid)
            
        }
    }
    
    private var particularSurgeries: [Surgery] {
        surgeries.filter { surgery in
            surgery.insuranceName.trimmingCharacters(in: .whitespacesAndNewlines)
                .localizedCaseInsensitiveCompare("particular") == .orderedSame
            && surgery.financial?.paid == false
        }
    }
    
    private var insuranceSurgeries: [Surgery] {
        surgeries.filter { surgery in
            surgery.insuranceName.trimmingCharacters(in: .whitespacesAndNewlines)
                .localizedCaseInsensitiveCompare("particular") != .orderedSame
            && surgery.financial?.paid != true
        }
    }
    
    private var insuranceCounts: [(key: String, value: Int)] {
        Dictionary(grouping: insuranceSurgeries, by: {$0.insuranceName})
            .mapValues { $0.count }
            .sorted {
                if $0.value != $1.value {
                    return $0.value > $1.value
                } else {
                    return $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending
                }
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
    
    private var insuranceRevenue: [String: Double] {
        Dictionary(grouping: insuranceSurgeries, by: { $0.insuranceName})
            .mapValues { surgeries in
                surgeries.compactMap { $0.financial?.finalSurgeryValue }.reduce(0, +)
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
    
    private func isInsuranceFilterActive(_ insurance: String) -> Bool {
        let currentInsurance = filters.insurance.trimmingCharacters(in: .whitespacesAndNewlines)
        let targetInsurance = insurance.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let insuranceMatches = currentInsurance.localizedCaseInsensitiveCompare(targetInsurance) == .orderedSame

        
        return insuranceMatches
    }
    
    private func toggleParticularSurgeonFilter(_ surgeon: String) {
        if isParticularSurgeonFilterActive(surgeon) {
            filters.surgeon = ""
            filters.insurance = ""
            filters.paid = nil
        } else {
            filters.surgeon = surgeon
            filters.insurance = "particular"
            filters.paid = false
        }
    }
    
    private func toggleInsuranceFilter(_ insurance: String) {
        if isInsuranceFilterActive(insurance) {
            filters.insurance = ""
        } else {
            filters.insurance = insurance
        }
    }
    
    var body: some View {
        let calendar = Calendar.current
        
        // Agrupa cirurgias por mês/ano (somente meses que têm cirurgias entram no dicionário)
        let groupedByMonth = Dictionary(grouping: surgeries.filter{$0.type == .convenio}) { surgery in
            calendar.date(from: calendar.dateComponents([.year, .month], from: surgery.date)) ?? surgery.date
        }
        
        // Ordena os meses (mais recente primeiro)
        let sortedMonthDates = groupedByMonth.keys.sorted(by: >)
        let recentMonths = Array(sortedMonthDates.prefix(6))
        
        return VStack(alignment: .leading, spacing: 16) {
            Text("Estatísticas Mensais:")
                .font(.headline)
                .fontWeight(.semibold)
            
            ForEach(recentMonths, id: \.self) { monthDate in
                let components = calendar.dateComponents([.month, .year], from: monthDate)
                if let month = components.month, let year = components.year {
                    let stats = MonthlyStatsHelper.getMonthlyStats(for: month, year: year, from: surgeries)
                    let surgeriesForMonth = groupedByMonth[monthDate] ?? []
                    
                    NavigationLink {
                        MonthFinancialView(
                            monthDate: monthDate,
                            stats: stats,
                            surgeries: surgeriesForMonth
                        )
                    } label: {
                        MonthStatCard(
                            icon: "calendar",
                            cardName: monthDate.formatted(.dateTime.month(.wide).year()),
                            title: monthDate.formatted(.dateTime.month(.wide).year()),
                            stats: stats,
                            iconColor: .blue
                        )
                    }
                }
            }
            
            NavigationLink {
                AllMonthsView(surgeries: surgeries)
            } label: {
                HStack {
                    Text("Ver todos os meses")
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                
            }
            .buttonStyle(.glass)
            
            Text("Cirurgias Particulares Pendentes: \(particularSurgeries.count)")
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
            
            
            Text("Cirurgias Convênio Pendentes: \(insuranceSurgeries.count)")
                .font(.headline)
                .fontWeight(.semibold)
            
            
            // MARK: valores por convênio
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {
                ForEach(insuranceCounts, id: \.key) { insuranceName, count in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "building.2.fill")
                                .font(.title3)
                                .foregroundStyle(.blue)
                            Spacer()
                            Text(insuranceName)
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
                                
                                Text(formatCurrency(insuranceRevenue[insuranceName] ?? 0))
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
                            .stroke(isInsuranceFilterActive(insuranceName) ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .scaleEffect(isInsuranceFilterActive(insuranceName) ? 0.98 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: isInsuranceFilterActive(insuranceName))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleInsuranceFilter(insuranceName)
                    }
                }
            }
            
            
            
            VStack(alignment: .leading, spacing: 16) {
                if hasActiveFilters {
                    HStack {
                        Text("Cirurgias")
                            .font(.headline)
                        Spacer()
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass.circle.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                    ForEach(filteredSurgeries) { surgery in
                        SurgeryFinancialCard(surgery: surgery)                    }
                } else {
                    HStack {
                        Text("Encontrar Cirurgias")
                            .font(.headline)
                        Spacer()
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass.circle")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Types

struct MonthStats {
    let totalValue: Double
    let totalPaid: Double
    let totalDebts: Double
    let finalValue: Double
    let totalOnHold: Double
}

struct MonthStatCard: View {
    let icon: String
    let cardName: String
    let title: String
    let stats: MonthStats
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: - HEADER
            HStack(spacing: 10) {
                Spacer()
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(iconColor)

                Text(cardName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                
            }
            Divider()
            
            // MARK: - RECEBIDO (HERÓI)
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Faturado")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalValue))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Descontos")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalDebts))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Líquido")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.finalValue))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pendente")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalOnHold))
                        
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Recebido")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalPaid))
                        
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
               
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .glassEffect(in: .rect(cornerRadius: 16.0))
    }
}

#Preview {
    MonthStatCard(
        icon: "calendar",
        cardName: "Outubro de 2025",
        title: "Outubro de 2025",
        stats: MonthStats(
            totalValue: 10000,
            totalPaid: 8000,
            totalDebts: 2000,
            finalValue: 8000,
            totalOnHold: 0000,
        ),
        iconColor: .green
    )
}
