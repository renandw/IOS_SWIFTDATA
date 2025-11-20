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
}
