//
//  MonitoringSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//
import SwiftUI
import SwiftData

@Observable
final class MonitoringSectionViewModel {

    
    var electrocardioscopy = false
    var oximetry = false
    var nonInvasiveBloodPressure = false
    var capnography = false
    var invasiveBloodPlessure = false
    var centralVenousPressure = false
    var thermometer = false
    var bis = false
    var tof = false
    var customMonitorings: [String] = []

    func load(from e: AnesthesiaDescriptionEntry) {
        electrocardioscopy = e.electrocardioscopy
        oximetry = e.oximetry
        nonInvasiveBloodPressure = e.nonInvasiveBloodPressure
        capnography = e.capnography
        invasiveBloodPlessure = e.invasiveBloodPlessure
        centralVenousPressure = e.centralVenousPressure
        thermometer = e.thermometer
        bis = e.bis
        tof = e.tof
        customMonitorings = e.customMonitorings
    }

    func apply(to e: AnesthesiaDescriptionEntry) {
        e.electrocardioscopy = electrocardioscopy
        e.oximetry = oximetry
        e.nonInvasiveBloodPressure = nonInvasiveBloodPressure
        e.capnography = capnography
        e.invasiveBloodPlessure = invasiveBloodPlessure
        e.centralVenousPressure = centralVenousPressure
        e.thermometer = thermometer
        e.bis = bis
        e.tof = tof
        e.customMonitorings = customMonitorings
    }
    
    func addCustomMonitoring(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !customMonitorings.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        customMonitorings.append(trimmed)
    }
    
    func removeCustomMonitoring(at index: Int) {
        guard customMonitorings.indices.contains(index) else { return }
        customMonitorings.remove(at: index)
    }
    
    // Sugere monitorização baseada no tipo de anestesia
    func applyMonitoringSuggestion(hasGeneralAnesthesia: Bool) {
        // Sempre recomendados
        electrocardioscopy = true
        oximetry = true
        nonInvasiveBloodPressure = true
        
        // Recomendado apenas em anestesia geral
        capnography = hasGeneralAnesthesia
    }
}
