//
//  AdmissionSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//
import SwiftUI

@Observable
final class AdmissionSectionViewModel {
    var airway: AirwayKind? { didSet { updateVentilationOptions() } }
    var consciousness: ConsciousnessKind?
    var ventilatory: VentilationMode? { didSet { updateMechanicalVisibility() } }
    var mechanicalVentilation: MechanicalVentilationMode?
    var oxygenSupply: OxygenSupply? { didSet { updateFiO2() } }
    var fiO2Fraction: Double?
    var hemodynamic: HemodynamicKind?
    var veinAccess: VeinAccessKind? { didSet { updateVeinGaugeVisibility() } }
    var veinGauge: VeinGaugeKind?

    // MARK: - UI Rules (computed/helpers)

    /// Only spontaneous when airway in these cases:
    private var spontaneousOnlyAirways: [AirwayKind] {
        [.noDevice, .compromised, .oropharyngealGuedel, .nasopharyngeal]
    }

    private func updateVentilationOptions() {
        guard let airway else { return }
        if spontaneousOnlyAirways.contains(airway) {
            ventilatory = .spontaneous
        }
    }

    private func updateMechanicalVisibility() {
        if ventilatory == .spontaneous {
            mechanicalVentilation = nil
        }
    }

    private func updateFiO2() {
        if oxygenSupply == .ambientAir {
            fiO2Fraction = nil
        }
    }

    private func updateVeinGaugeVisibility() {
        if veinAccess == VeinAccessKind.none {
            veinGauge = nil
        }
    }

    func load(from e: AnesthesiaDescriptionEntry) {
        airway = e.airway
        consciousness = e.consciousness
        ventilatory = e.ventilatory
        mechanicalVentilation = e.mechanicalVentilation
        oxygenSupply = e.oxygenSupply
        fiO2Fraction = e.fiO2Fraction
        hemodynamic = e.hemodynamic
        veinAccess = e.veinAccess
        veinGauge = e.veinGauge
    }

    func apply(to e: AnesthesiaDescriptionEntry) {
        e.airway = airway
        e.consciousness = consciousness
        e.ventilatory = ventilatory
        e.mechanicalVentilation = mechanicalVentilation
        e.oxygenSupply = oxygenSupply
        e.fiO2Fraction = fiO2Fraction
        e.hemodynamic = hemodynamic
        e.veinAccess = veinAccess
        e.veinGauge = veinGauge
    }
    
    func applyAdmissionSuggestion() {
        airway = .noDevice
        consciousness = .alert
        ventilatory = .spontaneous
        oxygenSupply = .ambientAir
        hemodynamic = .stable
        veinAccess = .inOpRoom
        veinGauge = .g22
    }
    
    
    func generateAdmissionText(patientAge: Int) -> String {
        var parts: [String] = []
        
        if let airway = airway?.reportDisplayName {
            parts.append(airway)
        }
        
        if let consciousness = consciousness?.reportDisplayName(for: patientAge) {
            parts.append(consciousness)
        }
        
        if let ventilatory = ventilatory?.reportDisplayName {
            parts.append(ventilatory)
        }
        
        if let mechanicalVentilation = mechanicalVentilation?.reportDisplayName {
            parts.append(mechanicalVentilation)
        }
        
        if let oxygenSupply = oxygenSupply?.reportDisplayName {
            parts.append(oxygenSupply)
        }
        
        if let fiO2Fraction = fiO2Fraction {
            parts.append("FiO2 \(Int(fiO2Fraction))%")
        }
        
        if let hemodynamic = hemodynamic?.reportDisplayName {
            parts.append(hemodynamic)
        }
        
        if let veinAccess = veinAccess?.reportDisplayName(for: patientAge) {
            parts.append(veinAccess)
        }
        
        if let veinGauge = veinGauge?.reportDisplayName {
            parts.append(veinGauge)
        }
        
        guard !parts.isEmpty else { return "" }
        
        let base = patientAge < 12 ? "Paciente pediátrico admitido em sala cirúrgica" : "Paciente admitido em sala cirúrgica"
        return "\(base), \(parts.joined(separator: ", "))."
    }
}
