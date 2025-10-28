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
