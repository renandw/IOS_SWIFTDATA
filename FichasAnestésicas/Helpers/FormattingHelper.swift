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

public extension Sex {
    /// Localized, user-facing description for the patient's sex.
    var sexStringDescription: String {
        switch self {
        case .male:
            return "Masculino"
        case .female:
            return "Feminino"
        }
    }
    
    var sexColor: Color {
        /// Standardized color associated with the patient's sex for SwiftUI.
        /// - Note: `.male` maps to blue; `.female` maps to pink.
        switch self {
        case .male:
            return .blue
        case .female:
            return .pink
        }
    }
    
    var sexImage: String {
        switch self {
        case .male:
            return "figure.stand"
        case .female:
            return "figure.stand.dress"
        }
    }
}

// Esqueleto para cálculo de idade com e sem contexto de cirurgia
// TODO: Quando @model Surgery estiver pronto, trocar o caso `.inSurgery(date:)` para `.inSurgery(Surgery)` e usar a data da cirurgia do modelo
enum AgeContext {
    case outSurgery
    case inSurgery(date: Date) // placeholder até termos o @model Surgery

    /// Retorna a idade em anos (inteiro) com base no contexto
    func ageInYears(from birthDate: Date) -> Int {
        switch self {
        case .outSurgery:
            return Calendar.current.dateComponents([.year], from: birthDate, to: .now).year ?? 0
        case .inSurgery(let surgeryDate):
            return Calendar.current.dateComponents([.year], from: birthDate, to: surgeryDate).year ?? 0
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
            case .inSurgery(let surgeryDate):
                return surgeryDate
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


// MARK: - Status UI Helpers
public extension Status {
    var displayName: String {
        switch self {
        case .scheduled: return "Agendada"
        case .inProgress: return "Em andamento"
        case .finished: return "Concluída"
        case .cancelled: return "Cancelada"
        case .notNecessary: return "Não Necessária"
        }
    }

    var tintColor: Color {
        switch self {
        case .scheduled: return .blue
        case .inProgress: return .orange
        case .finished: return .green
        case .cancelled: return .red
        case .notNecessary: return .gray
        }
    }

    var badgeLabel: String { "Status: \(displayName)" }

    @ViewBuilder
    var badgeView: some View {
        Text(displayName)
            .foregroundStyle(tintColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tintColor.opacity(0.15))
            .clipShape(Capsule())
    }
}
