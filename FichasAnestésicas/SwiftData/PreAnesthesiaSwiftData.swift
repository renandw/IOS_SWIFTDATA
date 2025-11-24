//
//  PreAnesthesiaSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import Foundation
import SwiftData

@Model
final class PreAnesthesia {
    @Attribute(.unique) var preanesthesiaId: String
    @Relationship var surgery: Surgery
    @Relationship var shared: SharedPreAndAnesthesia?
    //metadatafields
    var createdBy: User
    var updatedBy: User?
    var createdAt: Date
    var updatedAt: Date?
    
    var statusRaw: String?
    var status: Status? {
        get { statusRaw.flatMap(Status.init(rawValue:)) }
        set { statusRaw = newValue?.rawValue }
    }
    
    init(
        preanesthesiaId: String = UUID().uuidString,
        surgery: Surgery,
        shared: SharedPreAndAnesthesia? = nil,
        createdBy: User,
        updatedBy: User? = nil,
        createdAt: Date,
        updatedAt: Date? = nil,
        statusRaw: String? = nil
    ) {
        self.preanesthesiaId = preanesthesiaId
        self.surgery = surgery
        self.shared = shared
        self.statusRaw = statusRaw
        self.createdBy = createdBy
        self.updatedBy = updatedBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.statusRaw = statusRaw
    }
}
