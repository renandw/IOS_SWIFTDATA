//
//  FinancialRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//

import Foundation
import SwiftData

protocol FinancialRepository {
    func create(_ financial: Financial) throws
    func update(_ financial: Financial) throws
    func delete(_ financial: Financial) throws
    func get(for surgery: Surgery) throws -> Financial?
}

@MainActor
final class SwiftDataFinancialRepository: FinancialRepository {
    private let context: ModelContext
    private let currentUser: User

    init(context: ModelContext, currentUser: User) {
        self.context = context
        self.currentUser = currentUser
    }

    func create(_ financial: Financial) throws {
        let now = Date.now
        financial.surgery.updatedAt = now
        financial.surgery.lastActivityAt = now
        financial.surgery.patient.lastActivityAt = now
        financial.surgery.updatedBy = currentUser
        
        context.insert(financial)
        try context.save()
    }

    func update(_ financial: Financial) throws {
        let now = Date.now
        financial.surgery.updatedAt = now
        financial.surgery.lastActivityAt = now
        financial.surgery.patient.lastActivityAt = now
        financial.surgery.updatedBy = currentUser
        
        try context.save()
    }

    func delete(_ financial: Financial) throws {
        let now = Date.now
        financial.surgery.lastActivityAt = now
        financial.surgery.patient.lastActivityAt = now
        
        context.delete(financial)
        try context.save()
    }

    func get(for surgery: Surgery) throws -> Financial? {
        let surgeryId = surgery.surgeryId
        return try context.fetch(
            FetchDescriptor<Financial>(
                predicate: #Predicate { $0.surgery.surgeryId == surgeryId }
            )
        ).first
    }
}
