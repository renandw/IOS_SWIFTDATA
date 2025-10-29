//
//  SurgerySwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/10/25.
//

import Foundation
import SwiftData

// MARK: - Cirurgias
/// cada surgery precisa estar atrelada a um patient via relatioships

public enum Status: String, Codable, CaseIterable {
    case scheduled
    case inProgress
    case finished
    case cancelled
    case notNecessary
}

public enum SurgeryType: String, Codable, CaseIterable {
    case sus
    case convenio
}

@Model
final class Surgery {
    @Attribute(.unique) var surgeryId: String
    var date: Date
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date?
    var updatedBy: String?
    var lastActivityAt: Date
    var insuranceName: String
    var insuranceNumber: String
    var start: Date?
    var end: Date?
    var auxiliarySurgeons: [String]?
    var mainSurgeon: String
    var hospital: String
    var weight: Double
    var proposedProcedure: String
    var completeProcedure: String?
    private var statusRaw: String
    var status: Status {
            get { Status(rawValue: statusRaw)! }
            set { statusRaw = newValue.rawValue }
        }
    private var typeRaw: String
    var type: SurgeryType {
            get { SurgeryType(rawValue: typeRaw)! }
            set { typeRaw = newValue.rawValue }
        }
    
    @Relationship(deleteRule: .cascade, inverse: \CbhpmProcedure.surgery) var cbhpmProcedures: [CbhpmProcedure]?
    @Relationship(inverse: \Patient.surgeries) var patient: Patient
    @Relationship(deleteRule: .cascade, inverse: \Financial.surgery) var financial: Financial?
    
    init(surgeryId: String, date: Date, createdBy: String, createdAt: Date, updatedAt: Date? = nil, updatedBy: String? = nil, lastActivityAt: Date, insuranceName: String, insuranceNumber: String, start: Date? = nil, end: Date? = nil, auxiliarySurgeons: [String]? = nil, mainSurgeon: String, hospital: String, weight: Double, proposedProcedure: String, completeProcedure: String? = nil, statusRaw: String, typeRaw: String, cbhpmProcedures: [CbhpmProcedure]? = nil, patient: Patient, financial: Financial? = nil) {
        self.surgeryId = surgeryId
        self.date = date
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.updatedBy = updatedBy
        self.lastActivityAt = lastActivityAt
        self.insuranceName = insuranceName
        self.insuranceNumber = insuranceNumber
        self.start = start
        self.end = end
        self.auxiliarySurgeons = auxiliarySurgeons
        self.mainSurgeon = mainSurgeon
        self.hospital = hospital
        self.weight = weight
        self.proposedProcedure = proposedProcedure
        self.completeProcedure = completeProcedure
        self.statusRaw = statusRaw
        self.typeRaw = typeRaw
        self.cbhpmProcedures = cbhpmProcedures
        self.patient = patient
        self.financial = financial
    }
}


@Model
final class CbhpmProcedure {
    @Relationship var surgery: Surgery
    var code: String
    var procedure: String
    var port: String

    init(surgery: Surgery, code: String, procedure: String, port: String) {
        self.surgery = surgery
        self.code = code
        self.procedure = procedure
        self.port = port
    }
}


@Model
final class Financial {
    @Relationship var surgery: Surgery
    
    var valueAnesthesia: Double?
    var valuePreAnesthesia: Double?
    var finalSurgeryValue: Double?
    var glosaAnesthesia: Bool?
    var glosaPreanesthesia: Bool?
    var glosedAnesthesiaValue: Double?
    var glosedPreAnesthesiaValue: Double?
    var notes: String?
    var paid: Bool
    var paymentDate: Date?
    var billingDate: Date?
    var taxedValue: Double?
    var taxPercentage: Double?
    
    init(surgery: Surgery, valueAnesthesia: Double? = nil, valuePreAnesthesia: Double? = nil, finalSurgeryValue: Double? = nil, glosaAnesthesia: Bool? = nil, glosaPreanesthesia: Bool? = nil, glosedAnesthesiaValue: Double? = nil, glosedPreAnesthesiaValue: Double? = nil, notes: String? = nil, paid: Bool, paymentDate: Date? = nil, billingDate: Date? = nil, taxedValue: Double? = nil, taxPercentage: Double? = nil) {
        self.surgery = surgery
        self.valueAnesthesia = valueAnesthesia
        self.valuePreAnesthesia = valuePreAnesthesia
        self.finalSurgeryValue = finalSurgeryValue
        self.glosaAnesthesia = glosaAnesthesia
        self.glosaPreanesthesia = glosaPreanesthesia
        self.glosedAnesthesiaValue = glosedAnesthesiaValue
        self.glosedPreAnesthesiaValue = glosedPreAnesthesiaValue
        self.notes = notes
        self.paid = paid
        self.paymentDate = paymentDate
        self.billingDate = billingDate
        self.taxedValue = taxedValue
        self.taxPercentage = taxPercentage
    }
    
}
