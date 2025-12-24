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
