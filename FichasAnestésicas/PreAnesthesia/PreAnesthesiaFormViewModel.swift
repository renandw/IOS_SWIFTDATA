//
//  PreAnesthesiaFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import SwiftUI
import SwiftData

@Observable
final class PreAnesthesiaViewModel: Identifiable {
    // MARK: - Repositório e modelos
    
    private let repo: PreAnesthesiaRepository
    private let sharedRepo: SharedPreAndAnesthesiaRepository
    private let preanesthesia: PreAnesthesia
    private let user: User
    
    
    private let isNew: Bool
    
    var techniques: [AnesthesiaTechniqueKind] = []
    var asa: ASAClassification?
    var textField: String?

    
    // MARK: init para edit
    init(
        preanesthesia: PreAnesthesia,
        user: User,
        repo: PreAnesthesiaRepository,
        sharedRepo: SharedPreAndAnesthesiaRepository
    ) {
        self.preanesthesia = preanesthesia
        self.sharedRepo = sharedRepo
        self.user = user
        self.repo = repo
        self.isNew = false
        
        load(from: preanesthesia)

    }
    // MARK: init para create
    init(
        newFor surgery: Surgery,
        user: User,
        repo: PreAnesthesiaRepository,
        sharedRepo: SharedPreAndAnesthesiaRepository
    ) {
        let newEntry = PreAnesthesia(
            surgery: surgery,
            createdBy: user,
            createdAt: Date()
        )
        
        self.preanesthesia = newEntry
        self.user = user
        self.repo = repo
        self.sharedRepo = sharedRepo
        self.isNew = true
    }
    
    // MARK: - Save (create ou update)
    func save() throws {
        apply(to: preanesthesia)
        
        let surgery = preanesthesia.surgery
        
        if isNew {
            try repo.create(preanesthesia: preanesthesia, for: surgery, by: user)
        } else {
            try repo.update(preanesthesia: preanesthesia, for: surgery, by: user)
        }
    }
    
    // MARK: - Delete
    func delete() throws {
        let surgery = preanesthesia.surgery
        try repo.delete(preanesthesia: preanesthesia, from: surgery)
    }
    
    
    
    
    func load(from p: PreAnesthesia) {
        textField = p.textField
        
        if let shared = p.shared {
            self.techniques = shared.techniques
            self.asa = shared.asa
        }
    }
    
    
    func apply(to p: PreAnesthesia) {
        p.textField = textField
        
        let shared = sharedRepo.ensure(for: p.surgery)
        try? sharedRepo.update(shared, techniques: techniques, asa: asa)
        
    }
}
