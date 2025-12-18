//
//  FormatCurrency.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//

import SwiftUI

public func formatCurrency(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "BRL"
    formatter.locale = Locale(identifier: "pt_BR")
    return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
}

struct MonthlyStatsHelper {
    
    /// Calcula as estatísticas financeiras de um mês específico
    /// - Parameters:
    ///   - month: Mês (1-12)
    ///   - year: Ano
    ///   - surgeries: Array de cirurgias para calcular
    /// - Returns: MonthStats com todos os valores calculados
    static func getMonthlyStats(for month: Int, year: Int, from surgeries: [Surgery]) -> MonthStats {
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
