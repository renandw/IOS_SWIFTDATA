//
//  ShowSignatureKey.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/12/25.
//
import SwiftUI

private struct ShowSignatureKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var showSignature: Binding<Bool> {
        get { self[ShowSignatureKey.self] }
        set { self[ShowSignatureKey.self] = newValue }
    }
}
