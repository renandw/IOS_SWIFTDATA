//
//  VitalPoint.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 18/11/25.
//

import Foundation

/// Ponto de dados agregado para o gráfico de sinais vitais
struct VitalPoint: Identifiable {
    let id = UUID()
    let time: Date
    let fc: Double?
    let pas: Double?
    let pad: Double?
    let pam: Double?
    let spo2: Double?
    let etco2: Double?
}

// MARK: - Extension para conversão VitalSignEntry → VitalPoint
extension VitalSignEntry {
    /// Converte uma entrada de sinais vitais para um ponto no gráfico
    func toVitalPoint() -> VitalPoint {
        VitalPoint(
            time: self.timestamp,
            fc: self.fc,
            pas: self.paS,
            pad: self.paD,
            pam: self.pam,
            spo2: self.spo2,
            etco2: self.etco2
        )
    }
}

// MARK: - Helper para conversão de arrays
extension Array where Element == VitalSignEntry {
    /// Converte e ordena array de VitalSignEntry para VitalPoint
    /// - Returns: Array ordenado por timestamp (mais antigo → mais recente)
    func toVitalPoints() -> [VitalPoint] {
        self
            .sorted { $0.timestamp < $1.timestamp }
            .map { $0.toVitalPoint() }
    }
}
