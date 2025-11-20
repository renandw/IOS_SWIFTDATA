//
//  DescriptionRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//
import Foundation
import SwiftData


protocol AnesthesiaDescriptionEntryRepository {
    func get(by id: String) -> AnesthesiaDescriptionEntry?
    func getAll(for anesthesia: Anesthesia) -> [AnesthesiaDescriptionEntry]
    func create(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
    func update(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
    func delete(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
    func deleteAll(for anesthesia: Anesthesia, by user: User) throws
}

final class SwiftDataAnesthesiaDescriptionEntryRepositoryRepository: AnesthesiaDescriptionEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func get(by id: String) -> AnesthesiaDescriptionEntry? {
        let descriptor = FetchDescriptor<AnesthesiaDescriptionEntry>(
            predicate: #Predicate { $0.descriptionId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for anesthesia: Anesthesia) -> [AnesthesiaDescriptionEntry] {
        let aid = anesthesia.anesthesiaId
        let descriptor = FetchDescriptor<AnesthesiaDescriptionEntry>(
            predicate: #Predicate { $0.anesthesia.anesthesiaId == aid },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func create(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.anesthesiaDescriptions.append(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
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
