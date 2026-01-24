//
//  VitalSignsEntryRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//



import Foundation
import SwiftData

protocol SRPAVitalSignsEntryRepository {
    func get(by id: String) -> SRPAVitalSignEntry?
    func getAll(for srpa: SRPA) -> [SRPAVitalSignEntry]
    func create(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws
    func update(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws
    func delete(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws
    func deleteAll(for srpa: SRPA, by user: User) throws
}

final class SwiftDataSRPAVitalSignsEntryRepository: SRPAVitalSignsEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func get(by id: String) -> SRPAVitalSignEntry? {
        let descriptor = FetchDescriptor<SRPAVitalSignEntry>(
            predicate: #Predicate { $0.srpaVitalSignsId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for srpa: SRPA) -> [SRPAVitalSignEntry] {
        let aid = srpa.srpaId
        let descriptor = FetchDescriptor<SRPAVitalSignEntry>(
            predicate: #Predicate { $0.srpa.srpaId == aid },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func create(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws {
        srpa.vitalSigns.append(entry)
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws {
        srpa.updatedAt = Date()
        srpa.updatedBy = user
        srpa.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: SRPAVitalSignEntry, for srpa: SRPA, by user: User) throws {
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
