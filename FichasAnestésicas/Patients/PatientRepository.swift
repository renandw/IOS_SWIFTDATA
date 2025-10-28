//
//  PatientRepository.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 27/10/25.
//

import Foundation
import SwiftData

enum DuplicateStatus {
    case none
    case exact([Patient])      // duplicata exata
    case similar([Patient])    // possível misspelling
    case homonym([Patient])    // homônimo com dados diferentes
}

protocol PatientRepository {
    func create(_ patient: Patient) throws
    func update(_ patient: Patient) throws
    func delete(_ patient: Patient) throws
    func get(by id: UUID) throws -> Patient?
    func checkForDuplicates(_ patient: Patient) throws -> DuplicateStatus
    func getAll() throws -> [Patient]
}

@MainActor
final class SwiftDataPatientRepository: PatientRepository {
    private let context: ModelContext
    private let currentUser: User

    init(context: ModelContext, currentUser: User) {
        self.context = context
        self.currentUser = currentUser
    }

    func create(_ patient: Patient) throws {
        patient.createdAt = .now
        patient.updatedAt = .now
        patient.lastActivityAt = .now
        patient.updatedBy = currentUser
        context.insert(patient)
        try context.save()
    }

    func update(_ patient: Patient) throws {
        patient.updatedAt = .now
        patient.lastActivityAt = .now
        patient.updatedBy = currentUser
        try context.save()
    }

    func delete(_ patient: Patient) throws {
        context.delete(patient)
        try context.save()
    }

    func get(by id: UUID) throws -> Patient? {
        let idString = id.uuidString
        return try context.fetch(
            FetchDescriptor<Patient>(
                predicate: #Predicate { $0.patientId == idString }
            )
        ).first
    }
    
    func checkForDuplicates(_ patient: Patient) throws -> DuplicateStatus {
        let allPatients = try getAll()
        
        // Helper para verificar se CNS é placeholder
        let isPlaceholder = { (cns: String) -> Bool in
            cns == "00000000000000" || cns.isEmpty
        }
        
        // 1. Duplicata EXATA (CNS válido idêntico)
        if !isPlaceholder(patient.cns) {
            let exactCNS = allPatients.filter {
                $0.cns == patient.cns && !isPlaceholder($0.cns)
            }
            if !exactCNS.isEmpty {
                return .exact(exactCNS)
            }
        }
        
        // 2. Nome exato + data nascimento + sexo
        let exactMatch = allPatients.filter {
            $0.name.lowercased() == patient.name.lowercased() &&
            $0.birthDate == patient.birthDate &&
            $0.sex == patient.sex
        }
        if !exactMatch.isEmpty {
            return .exact(exactMatch)
        }
        
        // 3. SIMILAR (possível misspelling)
        let similar = allPatients.filter { candidate in
            let similarity = calculateSimilarity(patient.name, candidate.name)
            return similarity > 0.75 &&
                   similarity < 1.0 &&
                   candidate.birthDate == patient.birthDate
        }
        if !similar.isEmpty {
            return .similar(similar)
        }
        
        // 4. HOMÔNIMOS (nome igual, mas dados diferentes)
        let homonyms = allPatients.filter {
            $0.name.lowercased() == patient.name.lowercased() &&
            ($0.birthDate != patient.birthDate || $0.sex != patient.sex)
        }
        if !homonyms.isEmpty {
            return .homonym(homonyms)
        }
        
        return .none
    }

    // MARK: - Métodos Auxiliares Privados

    private func calculateSimilarity(_ str1: String, _ str2: String) -> Double {
        let s1 = str1.lowercased()
        let s2 = str2.lowercased()
        
        let distance = levenshteinDistance(s1, s2)
        let maxLength = Double(max(s1.count, s2.count))
        
        return maxLength > 0 ? 1.0 - (Double(distance) / maxLength) : 1.0
    }

    private func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
        let a1 = Array(s1)
        let a2 = Array(s2)
        var dist = [[Int]](
            repeating: [Int](repeating: 0, count: a2.count + 1),
            count: a1.count + 1
        )
        
        for i in 0...a1.count { dist[i][0] = i }
        for j in 0...a2.count { dist[0][j] = j }
        
        for i in 1...a1.count {
            for j in 1...a2.count {
                let cost = a1[i-1] == a2[j-1] ? 0 : 1
                dist[i][j] = min(
                    dist[i-1][j] + 1,
                    dist[i][j-1] + 1,
                    dist[i-1][j-1] + cost
                )
            }
        }
        
        return dist[a1.count][a2.count]
    }

    func getAll() throws -> [Patient] {
        try context.fetch(FetchDescriptor<Patient>())
    }
}
