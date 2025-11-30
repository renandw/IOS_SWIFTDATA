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
    
    var patientSex : Sex {
        let surgery = preanesthesia.surgery
        let sex = surgery.patient.sex
        return sex
    }
    
    var patientAge: Int {
        let surgery = preanesthesia.surgery
        let birthDate = surgery.patient.birthDate
        return AgeContext.inSurgery(surgery).ageInYears(from: birthDate)
    }
    
    var clearence = ClearenceSectionViewModel()
    var comorbities = ComorbitiesSectionViewModel()
    var surgeryHistory = SurgeryHistorySectionViewModel()
    var socialHabitsAndEnvironment = SocialHabitsAndEnvironmentSectionViewModel()
    var airway = AirwaySectionViewModel()
    var medicationAndAllergies = MedicationsAndAllergiesSectionViewModel()
    
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
        
        clearence.load(from: preanesthesia)
        comorbities.load(from: preanesthesia, patientSex: patientSex, patientAge: patientAge)
        surgeryHistory.load(from: preanesthesia)
        socialHabitsAndEnvironment.load(from: preanesthesia)
        airway.load(from: preanesthesia)
        medicationAndAllergies.load(from: preanesthesia)
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
        
        if let shared = surgery.shared {
            self.techniques = shared.techniques
            self.asa = shared.asa
        }
        let sex = surgery.patient.sex
        let age = AgeContext.inSurgery(surgery).ageInYears(from: surgery.patient.birthDate)
        comorbities.isInfantVisibility(patientAge: age)
        comorbities.isPregnantVisibility(patientSex: sex)
    }
    
    // MARK: - Save (create ou update)
    func save() throws {
        clearence.apply(to: preanesthesia)
        comorbities.apply(to: preanesthesia, patientSex: patientSex, patientAge: patientAge)
        surgeryHistory.apply(to: preanesthesia)
        socialHabitsAndEnvironment.apply(to: preanesthesia)
        airway.apply(to: preanesthesia)
        medicationAndAllergies.apply(to: preanesthesia)
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
        let shared = sharedRepo.get(for: p.surgery) ?? p.shared
        if let shared {
            self.techniques = shared.techniques
            self.asa = shared.asa
        }
    }
    
    func apply(to p: PreAnesthesia) {
        p.textField = textField
        
        let shared = sharedRepo.ensure(for: p.surgery)  // ← "p.surgery"
        try? sharedRepo.update(shared, techniques: techniques, asa: asa)
        
    }
}
