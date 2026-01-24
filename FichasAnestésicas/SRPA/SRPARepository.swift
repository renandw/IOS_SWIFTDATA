//
//  SRPARepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


import Foundation
import SwiftData

protocol SRPARepository {
    func create(srpa: SRPA, for surgery: Surgery, by user: User) throws
    func update(srpa: SRPA, for surgery: Surgery, by user: User) throws
    func delete(srpa: SRPA, from surgery: Surgery) throws
    func get(by id: String) -> SRPA?
    func getAll(for surgery: Surgery) -> [SRPA]
}

final class SwiftDataSRPARepository: SRPARepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func create(srpa: SRPA, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        surgery.status = .inProgress
        
        srpa.createdAt = now
        srpa.updatedAt = now
        srpa.updatedBy = user
        srpa.status = .inProgress
        
        surgery.srpa = srpa
        srpa.surgery = surgery

        context.insert(srpa)

        try context.save()

    }

    func update(srpa: SRPA, for surgery: Surgery, by user: User) throws {
        let now = Date()
        surgery.lastActivityAt = now
        srpa.updatedAt = now
        srpa.updatedBy = user
        
        try context.save()
    }

    func delete(srpa: SRPA, from surgery: Surgery) throws {
        surgery.lastActivityAt = Date()
        surgery.srpa = nil
        surgery.start = nil
        surgery.end = nil
        surgery.status = .scheduled
        context.delete(srpa)
        try context.save()
    }
    
    func finalizeStatus(srpa: SRPA, for surgery: Surgery, by user: User) throws {
        guard srpa.surgery === surgery else {
            throw SRPAError.inconsistentRelationship
        }
        
        let now = Date()
        
        surgery.lastActivityAt = now
        surgery.status = .finished
        
        srpa.status = .finished
        srpa.updatedAt = now
        srpa.updatedBy = user
        
        try context.save()
    }

    func get(by id: String) -> SRPA? {
        let descriptor = FetchDescriptor<SRPA>(
            predicate: #Predicate { $0.srpaId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for surgery: Surgery) -> [SRPA] {
        let surgeryId = surgery.surgeryId
        let descriptor = FetchDescriptor<SRPA>(
            predicate: #Predicate { $0.surgery.surgeryId == surgeryId }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    enum SRPAError: LocalizedError {
        case noSRPAFound
        case alreadyFinalized
        case inconsistentRelationship
        
        var errorDescription: String? {
            switch self {
            case .noSRPAFound:
                return "Nenhuma SRPA encontrada para esta cirurgia"
            case .alreadyFinalized:
                return "Cirurgia já está finalizada"
            case .inconsistentRelationship:
                return "SRPA não pertence a esta cirurgia"
            }
        }
    }
}
