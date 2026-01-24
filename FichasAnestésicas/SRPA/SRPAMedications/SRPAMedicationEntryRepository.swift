//
//  MedicationEntryRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//



import SwiftData
import Foundation


protocol SRPAMedicationEntryRepository {
    func get(by id: String) -> SRPAMedicationEntry?
    func getAll(for srpa: SRPA) -> [SRPAMedicationEntry]
    func create(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws
    func update(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws
    func delete(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws
    func deleteAll(for srpa: SRPA, by user: User) throws
}

final class SwiftDataSRPAMedicationEntryRepository: SRPAMedicationEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func get(by id: String) -> SRPAMedicationEntry? {
        let descriptor = FetchDescriptor<SRPAMedicationEntry>(
            predicate: #Predicate { $0.srpaMedicationId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for srpa: SRPA) -> [SRPAMedicationEntry] {
        let aid = srpa.srpaId
        let descriptor = FetchDescriptor<SRPAMedicationEntry>(
            predicate: #Predicate { $0.srpa.srpaId == aid },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func create(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws {
        srpa.medications.append(entry)
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws {
        entry.timestamp = entry.timestamp // força o SwiftData detectar alteração
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: SRPAMedicationEntry, for srpa: SRPA, by user: User) throws {
        context.delete(entry)
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        try context.save()
    }

    func deleteAll(for srpa: SRPA, by user: User) throws {
        let entries = getAll(for: srpa)
        for e in entries { context.delete(e) }
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        try context.save()
    }
}
