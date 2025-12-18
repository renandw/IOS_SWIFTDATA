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
