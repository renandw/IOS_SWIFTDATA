//
//  AnesthesiaRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//


import Foundation
import SwiftData

protocol AnesthesiaRepository {
    func create(anesthesia: Anesthesia, for surgery: Surgery, by user: User) throws
    func update(anesthesia: Anesthesia, for surgery: Surgery, by user: User) throws
    func delete(anesthesia: Anesthesia, from surgery: Surgery) throws
    func get(by id: String) -> Anesthesia?
    func getAll(for surgery: Surgery) -> [Anesthesia]
}

final class SwiftDataAnesthesiaRepository: AnesthesiaRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func create(anesthesia: Anesthesia, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        surgery.status = .inProgress
        
        anesthesia.createdAt = now
        anesthesia.updatedAt = now
        anesthesia.updatedBy = user
        anesthesia.status = .inProgress
        
        surgery.anesthesia = anesthesia
        context.insert(anesthesia)
        try context.save()
    }

    func update(anesthesia: Anesthesia, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        anesthesia.updatedAt = now
        anesthesia.updatedBy = user
        
        try context.save()
    }

    func delete(anesthesia: Anesthesia, from surgery: Surgery) throws {
        surgery.lastActivityAt = Date()
        surgery.anesthesia = nil
        context.delete(anesthesia)
        try context.save()
    }

    func get(by id: String) -> Anesthesia? {
        let descriptor = FetchDescriptor<Anesthesia>(
            predicate: #Predicate { $0.anesthesiaId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for surgery: Surgery) -> [Anesthesia] {
        let surgeryId = surgery.surgeryId
        let descriptor = FetchDescriptor<Anesthesia>(
            predicate: #Predicate { $0.surgery.surgeryId == surgeryId }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    
}
