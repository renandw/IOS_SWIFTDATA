import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

public extension String {
    /// Returns a CNS string formatted in blocks (3 4 4 4), if possible.
    /// - Parameters:
    ///   - expectedLength: The expected number of digits for a CNS. Defaults to 15. If the digit count doesn't match, returns the original string.
    ///   - digitsOnly: When true, the function will strip all non-digit characters before attempting to format. Defaults to true.
    /// - Returns: A formatted CNS string like "123 4567 8901 234" if the input has the expected digit count; otherwise returns the original string (or the normalized digits if `digitsOnly` is true and length mismatches).
    func cnsFormatted(expectedLength: Int = 15, digitsOnly: Bool = true) -> String {
        let source: String = digitsOnly ? String(self.filter { $0.isNumber }) : self
        guard source.count == expectedLength else { return self }

        let start = source.prefix(3)
        let middle1 = source.dropFirst(3).prefix(4)
        let middle2 = source.dropFirst(7).prefix(4)
        let end = source.suffix(4)
        return "\(start) \(middle1) \(middle2) \(end)"
    }
}

// Esqueleto para cálculo de idade com e sem contexto de cirurgia
enum AgeContext {
    case outSurgery
    case inSurgery(Surgery)

    /// Retorna a idade em anos (inteiro) com base no contexto
    func ageInYears(from birthDate: Date) -> Int {
        switch self {
        case .outSurgery:
            return Calendar.current.dateComponents([.year], from: birthDate, to: .now).year ?? 0
        case .inSurgery(let surgery):
            return Calendar.current.dateComponents([.year], from: birthDate, to: surgery.date).year ?? 0
        }
    }

    /// Formata a idade de maneira compacta (estilo snippet):
    /// - < 1 ano: "Xm Yd"
    /// - 1–11 anos: "Xa Ym"
    /// - >= 12 anos: "Xa"
    func ageString(from birthDate: Date) -> String {
        // Define data de referência pelo contexto
        let now: Date = {
            switch self {
            case .outSurgery:
                return .now
            case .inSurgery(let surgery):
                return surgery.date
            }
        }()

        let calendar = Calendar.current
        let dob = birthDate

        // Anos completos entre dob e now
        let years = calendar.dateComponents([.year], from: dob, to: now).year ?? 0

        if years < 1 {
            // < 1 ano: meses e dias (Xm Yd)
            let monthsTotal = calendar.dateComponents([.month], from: dob, to: now).month ?? 0
            let months = max(0, monthsTotal)
            let dateAfterMonths = calendar.date(byAdding: .month, value: months, to: dob) ?? dob
            let daysRemainder = calendar.dateComponents([.day], from: dateAfterMonths, to: now).day ?? 0
            return "\(months)m \(max(0, daysRemainder))d"
        } else if years < 12 {
            // 1–11 anos: anos e meses (Xa Ym)
            let dateAfterYears = calendar.date(byAdding: .year, value: years, to: dob) ?? dob
            let monthsRemainder = calendar.dateComponents([.month], from: dateAfterYears, to: now).month ?? 0
            return "\(years)a \(max(0, monthsRemainder))m"
        } else {
            // >= 12 anos: anos (Xa)
            return "\(years)a"
        }
    }
}

enum numberCnsContex {
    case needed
    case notNeeded
}


func isSameDay(surgeryDate: Date, anesthesiaStart: Date?, anesthesiaEnd: Date?, surgeryStart: Date?, surgeryEnd: Date?) -> Bool {
    let calendar = Calendar.current
    
    // Extrai os componentes de dia/mês/ano da data de referência (surgeryDate)
    let referenceDateComponents = calendar.dateComponents([.year, .month, .day], from: surgeryDate)
    
    // Array com todas as datas opcionais a serem verificadas
    let datesToCheck: [Date?] = [anesthesiaStart, anesthesiaEnd, surgeryStart, surgeryEnd]
    
    // Verifica se todas as datas não-nulas são no mesmo dia que surgeryDate
    for date in datesToCheck {
        if let date = date {
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            if dateComponents != referenceDateComponents {
                return false
            }
        }
    }
    
    return true
}
