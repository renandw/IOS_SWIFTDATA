//
//  SurgeryRepository.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import Foundation
import SwiftData

enum SurgeryRepositoryError: Error {
    case failedToGenerateUniqueId
}

protocol SurgeryRepository {
    func create(_ surgery: Surgery) throws
    func update(_ surgery: Surgery) throws
    func delete(_ surgery: Surgery) throws
    func get(by id: String) throws -> Surgery?
    func getAllForPatient(_ patient: Patient) throws -> [Surgery]
}

@MainActor
final class SwiftDataSurgeryRepository: SurgeryRepository {
    private let context: ModelContext
    private let currentUser: User

    init(context: ModelContext, currentUser: User) {
        self.context = context
        self.currentUser = currentUser
    }

    func create(_ surgery: Surgery) throws {
        var attempts = 0
        let maxAttempts = 10
        
        while attempts < maxAttempts {
            surgery.surgeryId = generateUniqueSurgeryId()
            let now = Date.now
            surgery.createdAt = now
            surgery.updatedAt = now
            surgery.lastActivityAt = now
            surgery.patient.lastActivityAt = now
            surgery.updatedBy = currentUser
            
            context.insert(surgery)
            
            do {
                try context.save()
                return // Sucesso!
            } catch {
                context.delete(surgery) // Remove tentativa falha
                attempts += 1
                
                if attempts >= maxAttempts {
                    throw SurgeryRepositoryError.failedToGenerateUniqueId
                }
            }
        }
    }

    func update(_ surgery: Surgery) throws {
        let now = Date.now
        surgery.updatedAt = now
        surgery.lastActivityAt = now
        surgery.patient.lastActivityAt = now
        surgery.updatedBy = currentUser
        try context.save()
    }

    func delete(_ surgery: Surgery) throws {
        surgery.patient.lastActivityAt = Date.now
        context.delete(surgery)
        try context.save()
    }

    func get(by id: String) throws -> Surgery? {
        try context.fetch(
            FetchDescriptor<Surgery>(
                predicate: #Predicate { $0.surgeryId == id }
            )
        ).first
    }

    func getAllForPatient(_ patient: Patient) throws -> [Surgery] {
        let patientId = patient.patientId
        return try context.fetch(
            FetchDescriptor<Surgery>(
                predicate: #Predicate { $0.patient.patientId == patientId }
            )
        )
    }

    // MARK: - Private Helpers

    private func generateUniqueSurgeryId() -> String {
        let year = Calendar.current.component(.year, from: Date())
        // Generate a random base36 string and normalize to 5 chars
        var value: UInt64 = 0
        for _ in 0..<5 { // 5 bytes of randomness
            value = (value << 8) | UInt64(UInt8.random(in: 0...255))
        }
        let base36 = String(value, radix: 36, uppercase: true)
        let padded = String(repeating: "0", count: max(0, 5 - base36.count)) + base36
        let code = String(padded.suffix(5))
        return "C\(year)-\(code)"
    }
}
