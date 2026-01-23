//
//  OutBox.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/01/26.
//

import SwiftData
import Foundation

enum OutboxType: String, Codable {
    case createPatient
    case updatePatient
    case deletePatient
}

@Model
final class OutboxOperation {
    @Attribute(.unique) var opId: String
    var typeRaw: String
    var entityId: String
    var payloadJSON: Data?
    var createdAt: Date
    var attempts: Int
    var lastError: String?
    var lastTriedAt: Date?
    var isDone: Bool

    var type: OutboxType {
        get { OutboxType(rawValue: typeRaw) ?? .updatePatient }
        set { typeRaw = newValue.rawValue }
    }

    init(type: OutboxType, entityId: String, payloadJSON: Data? = nil) {
        self.opId = UUID().uuidString
        self.typeRaw = type.rawValue
        self.entityId = entityId
        self.payloadJSON = payloadJSON
        self.createdAt = .now
        self.attempts = 0
        self.lastError = nil
        self.lastTriedAt = nil
        self.isDone = false
    }
}
