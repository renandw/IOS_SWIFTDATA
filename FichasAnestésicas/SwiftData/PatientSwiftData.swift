//
//  PatientSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/10/25.
//
import SwiftData
import SwiftUI

public enum Sex: String, Codable, CaseIterable {
    case male
    case female
}

@Model
final class Patient {

    @Attribute(.unique) var patientId: String
    var cns: String
    var name: String
    var birthDate: Date

    // Sexo armazenado como rawValue para flexibilidade de migração
    private var sexRaw: String
    var sex: Sex {
        get { Sex(rawValue: sexRaw) ?? .male }
        set { sexRaw = newValue.rawValue }
    }

    @Relationship var createdBy: User
    var createdAt: Date
    var updatedAt: Date?
    @Relationship var updatedBy: User?
    var lastActivityAt: Date
    @Relationship(deleteRule: .cascade, inverse: \Surgery.patient) var surgeries: [Surgery]?
    
    
    init(
        patientId: String,
        cns: String,
        name: String,
        birthDate: Date,
        sex: Sex,
        createdBy: User,
        createdAt: Date = .now,
        updatedAt: Date? = nil,
        updatedBy: User? = nil,
        lastActivityAt: Date = .now
    ) {
        self.patientId = patientId
        self.cns = cns
        self.name = name
        self.birthDate = birthDate
        self.sexRaw = sex.rawValue
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.updatedBy = updatedBy
        self.lastActivityAt = lastActivityAt
        self.surgeries = nil
    }

    init(
        patientId: String,
        cns: String,
        name: String,
        birthDate: Date,
        sexRaw: String,
        createdBy: User,
        createdAt: Date = .now,
        updatedAt: Date? = nil,
        updatedBy: User? = nil,
        lastActivityAt: Date = .now
    ) {
        self.patientId = patientId
        self.cns = cns
        self.name = name
        self.birthDate = birthDate
        self.sexRaw = sexRaw
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.updatedBy = updatedBy
        self.lastActivityAt = lastActivityAt
        self.surgeries = nil
    }
}

