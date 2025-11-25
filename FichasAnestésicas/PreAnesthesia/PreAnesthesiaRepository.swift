//
//  PreAnesthesiaRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import Foundation
import SwiftData

protocol PreAnesthesiaRepository {
    func create(preanesthesia: PreAnesthesia, for surgery: Surgery, by user: User) throws
    func update(preanesthesia: PreAnesthesia, for surgery: Surgery, by user: User) throws
    func delete(preanesthesia: PreAnesthesia, from surgery: Surgery) throws
    func get(by id: String) -> PreAnesthesia?
    func getAll(for surgery: Surgery) -> [PreAnesthesia]
}

final class SwiftDataPreAnesthesiaRepository: PreAnesthesiaRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func create(preanesthesia: PreAnesthesia, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        surgery.status = .inProgress
        preanesthesia.createdAt = now
        preanesthesia.updatedAt = now
        preanesthesia.updatedBy = user
        preanesthesia.status = .inProgress
        
        
        surgery.preanesthesia = preanesthesia
        preanesthesia.surgery = surgery

        context.insert(preanesthesia)

        try context.save()

    }

    func update(preanesthesia: PreAnesthesia, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        preanesthesia.updatedAt = now
        preanesthesia.updatedBy = user
        
        try context.save()
    }

    func delete(preanesthesia: PreAnesthesia, from surgery: Surgery) throws {
        surgery.lastActivityAt = Date()
        surgery.preanesthesia = nil
        preanesthesia.status = nil
        context.delete(preanesthesia)
        try context.save()
    }

    func get(by id: String) -> PreAnesthesia? {
        let descriptor = FetchDescriptor<PreAnesthesia>(
            predicate: #Predicate { $0.preanesthesiaId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for surgery: Surgery) -> [PreAnesthesia] {
        let surgeryId = surgery.surgeryId
        let descriptor = FetchDescriptor<PreAnesthesia>(
            predicate: #Predicate { $0.surgery.surgeryId == surgeryId }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
}
