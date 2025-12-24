//
//  PreAnesthesiaComorbitiesSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/12/25.
//
import Foundation
import SwiftData

protocol ComorbidityDetailProtocol: AnyObject, Identifiable {
    var notes: String? { get set }
    func displayName() -> String
}

@Model
final class OncologyComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: OncologicComorbidities? {
        get { typeRaw.flatMap(OncologicComorbidities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: OncologicComorbidities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class CardiologyComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: CardiologicComorbities? {
        get { typeRaw.flatMap(CardiologicComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: CardiologicComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class RespiratoryComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: RespiratoryComorbities? {
        get { typeRaw.flatMap(RespiratoryComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: RespiratoryComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}
