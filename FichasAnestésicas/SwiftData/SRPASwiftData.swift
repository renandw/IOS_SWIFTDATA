//
//  Anesthesia.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftData




@Model
final class SRPA {
    @Attribute(.unique) var srpaId: String
    @Relationship var surgery: Surgery
    
    @Relationship(deleteRule: .cascade, inverse: \SRPAMedicationEntry.srpa) var medications: [SRPAMedicationEntry]
    @Relationship(deleteRule: .cascade, inverse: \SRPAVitalSignEntry.srpa) var vitalSigns: [SRPAVitalSignEntry]

    var start: Date?
    var end: Date?
    var statusRaw: String?
    var status: Status? {
        get { statusRaw.flatMap(Status.init(rawValue:)) }
        set { statusRaw = newValue?.rawValue }
    }
    
    var createdBy: User
    var updatedBy: User?
    var createdAt: Date
    var updatedAt: Date?
    
    var descriptionText: String?
    
    @Relationship var shared: SharedPreAndAnesthesia?
    
    
    init(
        srpaId: String,
        surgery: Surgery,
        medications: [SRPAMedicationEntry],
        vitalSigns: [SRPAVitalSignEntry],
        start: Date? = nil,
        end: Date? = nil,
        statusRaw: String? = nil,
        createdBy: User,
        updatedBy: User? = nil,
        createdAt: Date,
        updatedAt: Date? = nil,
        descriptionText: String? = nil,
    ) {
        self.srpaId = srpaId
        self.surgery = surgery
        self.medications = medications
        self.vitalSigns = vitalSigns
        self.start = start
        self.end = end
        self.statusRaw = statusRaw
        self.createdBy = createdBy
        self.updatedBy = updatedBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.descriptionText = descriptionText
    }
}



// MARK: - Medicações

@Model
final class SRPAMedicationEntry {
    @Attribute(.unique) var srpaMedicationId: String
    @Relationship var srpa: SRPA

    var categoryRaw: String
    var category: MedicationCategory {
        get { MedicationCategory(rawValue: categoryRaw) ?? .opioide }
        set { categoryRaw = newValue.rawValue }
    }
    var viaRaw: String
    var via: AdministrationRoute {
        get { AdministrationRoute(rawValue: viaRaw) ?? .EV }
        set { viaRaw = newValue.rawValue }
    }
    var dose: String
    var name: String
    var timestamp: Date
    
    init(srpaMedicationId: String, srpa: SRPA, categoryRaw: String, viaRaw: String, dose: String, name: String, timestamp: Date) {
        self.srpaMedicationId = srpaMedicationId
        self.srpa = srpa
        self.categoryRaw = categoryRaw
        self.viaRaw = viaRaw
        self.dose = dose
        self.name = name
        self.timestamp = timestamp
    }
}

// MARK: - Sinais Vitais

@Model
final class SRPAVitalSignEntry {
    @Attribute(.unique) var srpaVitalSignsId: String
    @Relationship var srpa: SRPA

    var timestamp: Date
    var pam: Double?
    var fc: Double?
    var paS: Double?
    var paD: Double?
    var rhythm: String?
    var etco2: Double?
    var spo2: Double?
    var fio2: Double?
    var peep: Double?
    var volumeCorrente: Double?
    var bis: Double?
    var pupilas: String?
    var tof: Double?
    var pvc: Double?
    var debitCardiaco: Double?
    var glicemia: Double?
    var lactato: Double?
    var temperatura: Double?
    var diurese: Double?
    var sangramento: Double?

    init(
        srpaVitalSignsId: String = UUID().uuidString,
        srpa: SRPA,
        timestamp: Date = .init()
    ) {
        self.srpaVitalSignsId = srpaVitalSignsId
        self.srpa = srpa
        self.timestamp = timestamp
    }
}
