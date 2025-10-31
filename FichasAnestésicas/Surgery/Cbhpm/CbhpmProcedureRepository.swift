//
//  CbhpmProcedureRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 31/10/25.
//

import Foundation
import SwiftData

protocol CbhpmProcedureRepository {
    func create(_ procedure: CbhpmProcedure) throws
    func update(_ procedure: CbhpmProcedure) throws
    func delete(_ procedure: CbhpmProcedure) throws
    func get(by id: String) throws -> CbhpmProcedure?
    func getAll(for surgery: Surgery) throws -> [CbhpmProcedure]
    func replaceAll(for surgery: Surgery, with codes: [CbhpmCode]) throws
}

@MainActor
final class SwiftDataCbhpmProcedureRepository: CbhpmProcedureRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func create(_ procedure: CbhpmProcedure) throws {
        context.insert(procedure)
        try context.save()
    }

    func update(_ procedure: CbhpmProcedure) throws {
        try context.save()
    }

    func delete(_ procedure: CbhpmProcedure) throws {
        context.delete(procedure)
        try context.save()
    }

    func get(by id: String) throws -> CbhpmProcedure? {
        try context.fetch(
            FetchDescriptor<CbhpmProcedure>(
                predicate: #Predicate { $0.cbhpmId == id }
            )
        ).first
    }

    func getAll(for surgery: Surgery) throws -> [CbhpmProcedure] {
        let surgeryId = surgery.surgeryId
        return try context.fetch(
            FetchDescriptor<CbhpmProcedure>(
                predicate: #Predicate { $0.surgery.surgeryId == surgeryId }
            )
        )
    }
    
    func replaceAll(for surgery: Surgery, with codes: [CbhpmCode]) throws {
            // 1. Deleta antigos
            let oldProcedures = try getAll(for: surgery)
            for proc in oldProcedures {
                context.delete(proc)
            }
            
            // 2. Cria novos
            for code in codes {
                let procedure = CbhpmProcedure(
                    surgery: surgery,
                    code: code.codigo,
                    procedure: code.procedimento,
                    port: code.porte_anestesico
                )
                context.insert(procedure)
            }
            
            try context.save()
        }
}
