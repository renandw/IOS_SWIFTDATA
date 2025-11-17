//
//  MedicationEntryRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 16/11/25.
//
import Foundation
import SwiftData

protocol VitalSignsEntryRepository {
    func get(by id: String) -> VitalSignEntry?
    func getAll(for anesthesia: Anesthesia) -> [VitalSignEntry]
    func create(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws
    func update(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws
    func delete(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws
    func deleteAll(for anesthesia: Anesthesia, by user: User) throws
}

final class SwiftDataVitalSignsEntryRepository: VitalSignsEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func get(by id: String) -> VitalSignEntry? {
        let descriptor = FetchDescriptor<VitalSignEntry>(
            predicate: #Predicate { $0.vitalSignsId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for anesthesia: Anesthesia) -> [VitalSignEntry] {
        let aid = anesthesia.anesthesiaId
        let descriptor = FetchDescriptor<VitalSignEntry>(
            predicate: #Predicate { $0.anesthesia.anesthesiaId == aid },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func create(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.vitalSigns.append(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: VitalSignEntry, for anesthesia: Anesthesia, by user: User) throws {
        context.delete(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func deleteAll(for anesthesia: Anesthesia, by user: User) throws {
        let entries = getAll(for: anesthesia)
        for e in entries { context.delete(e) }
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }
}
