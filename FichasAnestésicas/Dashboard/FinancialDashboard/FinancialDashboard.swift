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
            (!filters.useDateFilter || (surgery.date >= filters.startDate && surgery.date <= filters.endDate))
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

        return VStack(alignment: .leading, spacing: 16) {
            Text("Estatísticas Mensais:")
                .font(.headline)
                .fontWeight(.semibold)

            ForEach(sortedMonthDates, id: \.self) { monthDate in
                let components = calendar.dateComponents([.month, .year], from: monthDate)
                if let month = components.month, let year = components.year {
                    let stats = getMonthlyStats(for: month, year: year)
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
    
    // MARK: - Helper Methods
    
    private func getMonthlyStats(for month: Int, year: Int) -> MonthStats {
        var totalValue: Double = 0
        var totalPaid: Double = 0
        var totalDebts: Double = 0
        var totalOnHold: Double = 0
        
        let calendar = Calendar.current
        
        for surgery in surgeries {
            guard let financial = surgery.financial else { continue }
            
            // Usa a data da cirurgia como referência
            let components = calendar.dateComponents([.month, .year], from: surgery.date)
            
            // Verifica se é do mês e ano corretos
            guard components.month == month && components.year == year else { continue }
            
            // totalValue: soma de valueAnesthesia + valuePreAnesthesia
            let anesthesiaValue = financial.valueAnesthesia ?? 0
            let preAnesthesiaValue = financial.valuePreAnesthesia ?? 0
            totalValue += anesthesiaValue + preAnesthesiaValue
            
            // finalSurgeryValue para este registro
            let surgeryFinalValue = financial.finalSurgeryValue ?? 0
            
            if financial.paid {
                // totalPaid: soma de finalSurgeryValue quando paid == true
                totalPaid += surgeryFinalValue
            } else {
                // totalOnHold: soma de finalSurgeryValue quando paid == false
                totalOnHold += surgeryFinalValue
            }
            
            // totalDebts: soma de taxedValue + glosedAnesthesiaValue + glosedPreAnesthesiaValue
            let taxed = financial.taxedValue ?? 0
            let glosedAnesth = financial.glosedAnesthesiaValue ?? 0
            let glosedPreAnesth = financial.glosedPreAnesthesiaValue ?? 0
            totalDebts += taxed + glosedAnesth + glosedPreAnesth
        }
        
        // finalValue: calcula DEPOIS do loop, quando todos os valores já foram somados
        let finalValue = totalValue - totalDebts
        
        return MonthStats(
            totalValue: totalValue,
            totalPaid: totalPaid,
            totalDebts: totalDebts,
            finalValue: finalValue,
            totalOnHold: totalOnHold
        )
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
                        .font(.caption2)
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
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Líquido")
                        .font(.caption2)
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
