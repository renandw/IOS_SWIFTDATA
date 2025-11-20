//
//  AdmissionSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//
import SwiftUI

@Observable
final class AdmissionSectionViewModel {
    var airway: AirwayKind?
    var consciousness: ConsciousnessKind?
    var ventilatory: VentilationMode?
    var mechanicalVentilation: MechanicalVentilationMode?
    var oxygenSupply: OxygenSupply?
    var fiO2Fraction: Double?
    var hemodynamic: HemodynamicKind?
    var veinAccess: VeinAccessKind?
    var veinGauge: VeinGaugeKind?

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
}
