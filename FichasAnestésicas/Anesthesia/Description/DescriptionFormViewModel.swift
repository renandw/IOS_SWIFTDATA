////
////  DescriptionFormViewModel.swift
////  FichasAnestésicas
////
////  Created by Renan Wrobel on 20/11/25.
////
//
//import Foundation
//import SwiftData
//import SwiftUI
//import Combine
//
//@MainActor
//final class AnesthesiaDescriptionFormViewModel: ObservableObject {
//    // MARK: Dependencies
//    private let repository: AnesthesiaDescriptionEntryRepository
//    private let anesthesia: Anesthesia
//    private let user: User
//    let context: ModelContext
//    
//    
//    // MARK: - Monitoring
//    @Published var electrocardioscopy: Bool = false
//    @Published var oximetry: Bool = false
//    @Published var nonInvasiveBloodPressure: Bool = false
//    @Published var capnography: Bool = false
//    @Published var invasiveBloodPressure: Bool = false
//    @Published var centralVenousPressure: Bool = false
//    @Published var thermometer: Bool = false
//    @Published var bis: Bool = false
//    @Published var tof: Bool = false
//    @Published var customMonitorings: [String] = []
//    
//    // MARK: - Admission
//    // UI: Pickers para enums, TextField para fiO2Fraction
//    @Published var airway: AirwayKind?
//    @Published var consciousness: ConsciousnessKind?
//    @Published var ventilatory: VentilationMode?
//    @Published var mechanicalVentilation: MechanicalVentilationMode?
//    @Published var oxygenSupply: OxygenSupply?
//    @Published var fiO2Fraction: Double?
//    @Published var hemodynamic: HemodynamicKind?
//    @Published var veinAccess: VeinAccessKind?
//    @Published var veinGauge: VeinGaugeKind?
//    
//    
//    // MARK: Monitoring Functions
//    // Método para UI adicionar monitoring customizado
//    func addCustomMonitoring(_ name: String) {
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//        customMonitorings.append(name)
//    }
//    
//    func removeCustomMonitoring(at index: Int) {
//        guard customMonitorings.indices.contains(index) else { return }
//        customMonitorings.remove(at: index)
//    }
//
//    var shouldShowMechanicalVentilation: Bool {
//        ventilatory == .invasiveMechanicalVentilation ||
//        ventilatory == .nonInvasiveMechanicalVentilation
//    }
//
//    var shouldShowVeinGauge: Bool {
//        veinAccess != VeinAccessKind.none && veinAccess != nil
//    }
//}
