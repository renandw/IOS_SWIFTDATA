//
//  Last12MonthsGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//

import SwiftUI
import Charts

struct Last12MonthsGraphView: View {
    let surgeries: [Surgery]
    
    struct MonthData: Identifiable, Hashable {
        let id = UUID()
        let month: Date
        let received: Double
        let scheduled: Double
    }
    
    private func getMonthlyStats(for month: Int, year: Int) -> MonthStats {
        var totalValue: Double = 0
        var totalPaid: Double = 0
        var totalDebts: Double = 0
        var totalOnHold: Double = 0
        
        let calendar = Calendar.current
        
        for surgery in surgeries {
            guard let financial = surgery.financial else { continue }
            
            let components = calendar.dateComponents([.month, .year], from: surgery.date)
            guard components.month == month && components.year == year else { continue }
            
            let anesthesiaValue = financial.valueAnesthesia ?? 0
            let preAnesthesiaValue = financial.valuePreAnesthesia ?? 0
            totalValue += anesthesiaValue + preAnesthesiaValue
            
            let surgeryFinalValue = financial.finalSurgeryValue ?? 0
            
            if financial.paid {
                totalPaid += surgeryFinalValue
            } else {
                totalOnHold += surgeryFinalValue
            }
            
            let taxed = financial.taxedValue ?? 0
            let glosedAnesth = financial.glosedAnesthesiaValue ?? 0
            let glosedPreAnesth = financial.glosedPreAnesthesiaValue ?? 0
            totalDebts += taxed + glosedAnesth + glosedPreAnesth
        }
        
        let finalValue = totalValue - totalDebts
        
        return MonthStats(
            totalValue: totalValue,
            totalPaid: totalPaid,
            totalDebts: totalDebts,
            finalValue: finalValue,
            totalOnHold: totalOnHold
        )
    }

    
    var body: some View {
        let calendar = Calendar.current
        let now = Date()
        let currentMonthComponents = calendar.dateComponents([.year, .month], from: now)
        
        // Generate last 12 months anchors (oldest to newest)
        let monthAnchors: [Date] = (0..<6).reversed().compactMap {
            calendar.date(byAdding: .month, value: -$0, to: calendar.date(from: currentMonthComponents) ?? now)
        }
        
        let monthData: [MonthData] = monthAnchors.map { date in
            let comps = calendar.dateComponents([.month, .year], from: date)
            let stats = getMonthlyStats(for: comps.month ?? 1, year: comps.year ?? 0)
            return MonthData(month: date, received: stats.totalPaid, scheduled: stats.totalValue )
        }
        
        // currentMonthPaid for header display
        let currentMonthValue = monthData.last?.scheduled ?? 0
        let currentMonthPaid = monthData.last?.received ?? 0
        
        VStack(alignment: .leading) {
            HStack() {
                Text("Último Semestre")
                    .font(.headline)
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(formatCurrency(currentMonthPaid))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                    }
                    HStack{
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(formatCurrency(currentMonthValue))
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    HStack {
                        Spacer()
                        Text("Mês atual")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Chart {
                ForEach(monthData) { data in
                    BarMark(
                        x: .value("Mês", data.month, unit: .month),
                        y: .value("Recebido", data.scheduled)
                    )
                    .foregroundStyle(
                        calendar.isDate(data.month, equalTo: now, toGranularity: .month)
                        ? .blue
                        : .blue.opacity(0.5)
                    )
                    .position(by: .value("Tipo", "Recebido"))
                    
                    BarMark(
                        x: .value("Mês", data.month, unit: .month),
                        y: .value("Pago", data.received)
                    )
                    .foregroundStyle(
                        calendar.isDate(data.month, equalTo: now, toGranularity: .month)
                        ? .green
                        : .green.opacity(0.5)
                    )
                    .position(by: .value("Tipo", "Pago"))
                    
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 170)
            .padding(.top, 5)
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: 16))
    }
}
#Preview("Last12MonthsGraphView") {
    // Minimal preview with empty surgeries; replace with real data as needed
    Last12MonthsGraphView(surgeries: [])
}
