//
//  MedicationsAndAllergiesViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//


import SwiftUI
import SwiftData

@Observable
final class MedicationsAndAllergiesSectionViewModel {
    
    
    var dailyMedications: [DailyMedications]?
    var dailyMedicationsDetailsText: String?
    var dailyMedicationsCustomDetails: [String] = []
    
    var hasAllergies = false
    var allergiesMedicationsCustomDetails: [String] = []
    
    
    func load(from e: PreAnesthesia) {
        
        dailyMedications = e.dailyMedications
        dailyMedicationsCustomDetails = e.dailyMedicationsCustomDetails ?? []
        dailyMedicationsDetailsText = e.dailyMedicationsDetailsText
        
        hasAllergies = e.hasAllergies ?? false
        allergiesMedicationsCustomDetails = e.allergiesMedicationsCustomDetails ?? []
        
    }
    
    func apply(to e: PreAnesthesia) {
        e.dailyMedications = dailyMedications
        e.dailyMedicationsCustomDetails = dailyMedicationsCustomDetails
        e.allergiesMedicationsCustomDetails = allergiesMedicationsCustomDetails
        e.hasAllergies = hasAllergies
    }
    
    func addDailyMedicationsCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !dailyMedicationsCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        dailyMedicationsCustomDetails.append(trimmed)
    }
    func removeDailyMedicationsCustomDetails(at index: Int) {
        guard dailyMedicationsCustomDetails.indices.contains(index) else { return }
        dailyMedicationsCustomDetails.remove(at: index)
    }
    
    func addAllergiesMedicationsCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !allergiesMedicationsCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        allergiesMedicationsCustomDetails.append(trimmed)
    }
    func removeAllergiesMedicationsCustomDetails(at index: Int) {
        guard allergiesMedicationsCustomDetails.indices.contains(index) else { return }
        allergiesMedicationsCustomDetails.remove(at: index)
    }
    
    var canSave: Bool {
        if hasAllergies {
            return allergiesMedicationsCustomDetails.isEmpty == false
        }
        return true
    }
    
    func applyHealthyPatient() {
        hasAllergies = false
        dailyMedicationsDetailsText = ""
        dailyMedicationsCustomDetails = []
    }
}

