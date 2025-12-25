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

@Model
final class EndocrineComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: EndocrineComorbities? {
        get { typeRaw.flatMap(EndocrineComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: EndocrineComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class GastroIntestinalComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: GastrointestinalComorbities? {
        get { typeRaw.flatMap(GastrointestinalComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: GastrointestinalComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class HematologyComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: HematologicComorbities? {
        get { typeRaw.flatMap(HematologicComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: HematologicComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class ImunologyComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: ImmunologicComorbities? {
        get { typeRaw.flatMap(ImmunologicComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: ImmunologicComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class MusculoskeletalComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: MusculoskeletalComorbities? {
        get { typeRaw.flatMap(MusculoskeletalComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: MusculoskeletalComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class GenitoUrinaryComorbidityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: GenitourinaryComorbities? {
        get { typeRaw.flatMap(GenitourinaryComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: GenitourinaryComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class GynecologicComorbityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: GynecologicComorbities? {
        get { typeRaw.flatMap(GynecologicComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: GynecologicComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class AndrogenicComorbityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: AndrologicComorbities? {
        get { typeRaw.flatMap(AndrologicComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: AndrologicComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class NeurologyComorbityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: NeurologicalComorbities? {
        get { typeRaw.flatMap(NeurologicalComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: NeurologicalComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class InfectiousComorbityDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: InfectiousComorbities? {
        get { typeRaw.flatMap(InfectiousComorbities.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: InfectiousComorbities? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class GeneticSyndromeDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: GeneticSyndrome? {
        get { typeRaw.flatMap(GeneticSyndrome.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: GeneticSyndrome? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}

@Model
final class SurgeryHistoryDetail: ComorbidityDetailProtocol {
    var typeRaw: String?
    var type: SurgeryHistorySpeciality? {
        get { typeRaw.flatMap(SurgeryHistorySpeciality.init(rawValue:)) }
        set { typeRaw = newValue?.rawValue }
    }
    var customName: String?
    var notes: String?
    
    init(type: SurgeryHistorySpeciality? = nil, customName: String? = nil, notes: String? = nil) {
        self.typeRaw = type?.rawValue
        self.customName = customName
        self.notes = notes
    }
    
    func displayName() -> String {
        type?.displayName ?? customName ?? ""
    }
}
