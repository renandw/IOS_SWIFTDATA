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
    func get(for anesthesia: Anesthesia) -> AnesthesiaDescriptionEntry?
    func create(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
    func update(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
    func delete(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws
}

final class SwiftDataAnesthesiaDescriptionEntryRepository: AnesthesiaDescriptionEntryRepository {
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

    func get(for anesthesia: Anesthesia) -> AnesthesiaDescriptionEntry? {
        let aid = anesthesia.anesthesiaId
        let descriptor = FetchDescriptor<AnesthesiaDescriptionEntry>(
            predicate: #Predicate { $0.anesthesia.anesthesiaId == aid }
        )
        return try? context.fetch(descriptor).first
    }

    func create(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.anesthesiaDescription = entry
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.anesthesiaDescription = entry
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: AnesthesiaDescriptionEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.anesthesiaDescription = nil
        context.delete(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }
}
