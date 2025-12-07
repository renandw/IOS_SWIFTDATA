import SwiftUI
import SwiftData

struct FinancialDashboardView: View {
    let userId: String
    let surgeries: [Surgery]
    
    @Environment(SessionManager.self) var session
    
    
    var body: some View {
        if let user = session.currentUser {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack {
                            Text("Painel Financeiro")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        MonthStatSection(surgeries: surgeries)
                        
                        Text("Olá, \(user.name)")
                        Button("Encerrar Sessão") {
                            session.currentUser = nil
                        }
                        .buttonStyle(.glassProminent)
                        
                        NavigationLink("Navegar para Lista de Usuários") {
                            UserListView()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .navigationTitle("Financeiro")
                    .navigationBarTitleDisplayMode(.large)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color(.tertiarySystemGroupedBackground))
            }
        } else {
            ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
        }
    }
}
import SwiftUI

struct MonthStatSection: View {
    let surgeries: [Surgery]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Estatísticas:")
                .font(.headline)
                .fontWeight(.semibold)
            
            // Mês atual
            let calendar = Calendar.current
            let now = Date()
            let currentMonth = calendar.component(.month, from: now)
            let currentYear = calendar.component(.year, from: now)
            let currentStats = getMonthlyStats(for: currentMonth, year: currentYear)
            
            MonthStatCard(
                icon: "chart.line.uptrend.xyaxis",
                cardName: "Mês Atual",
                title: now.formatted(.dateTime.month(.wide).year()),
                stats: currentStats,
                iconColor: .blue
            )
            
            // Mês anterior
            let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: now) ?? now
            let previousMonth = calendar.component(.month, from: previousMonthDate)
            let previousYear = calendar.component(.year, from: previousMonthDate)
            let previousStats = getMonthlyStats(for: previousMonth, year: previousYear)
            
            MonthStatCard(
                icon: "calendar",
                cardName: "Mês Anterior",
                title: previousMonthDate.formatted(.dateTime.month(.wide).year()),
                stats: previousStats,
                iconColor: .green
            )
        }
    }
    
    // MARK: - Helper Methods
    
    private func getMonthlyStats(for month: Int, year: Int) -> MonthStats {
        var totalValue: Double = 0
        var totalPaid: Double = 0
        var totalDebts: Double = 0
        var totalOnHold: Double = 0
        var finalValue: Double = 0
        
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
            
            // finalValue: soma de todos os finalSurgeryValue (paid ou não)
            finalValue += surgeryFinalValue
            
            // totalDebts: soma de taxedValue + glosedAnesthesiaValue + glosedPreAnesthesiaValue
            let taxed = financial.taxedValue ?? 0
            let glosedAnesth = financial.glosedAnesthesiaValue ?? 0
            let glosedPreAnesth = financial.glosedPreAnesthesiaValue ?? 0
            totalDebts += taxed + glosedAnesth + glosedPreAnesth
        }
        
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
        VStack(alignment: .leading, spacing: 12) {
            // Header com ícone, nome do card e mês
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(cardName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                // Linha principal - Valor Total
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Valor Total")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(formatCurrency(stats.totalValue))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                
                // Linha secundária - Valor Pago
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Valor Pago")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(formatCurrency(stats.totalPaid))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    Spacer()
                }
                
                // Linha terciária - Valores detalhados
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Dívidas")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(formatCurrency(stats.totalDebts))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Em Aberto")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(formatCurrency(stats.totalOnHold))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Valor Final")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(formatCurrency(stats.finalValue))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(16)
        .glassEffect(in: .rect(cornerRadius: 16.0))
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}
