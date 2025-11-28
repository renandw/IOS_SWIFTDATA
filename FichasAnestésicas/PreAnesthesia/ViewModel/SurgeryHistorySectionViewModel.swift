//
//  SurgeryHistorySectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 28/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class SurgeryHistorySectionViewModel {

    //to be implemented
    var surgeryHistory = false
    
    var surgeryHistoryDetails: [SurgeryHistorySpeciality]?
    var surgeryHistoryCustomDetails: [String] = []
    var surgeryHistoryDetailsText: String?
    
    func load(from e: PreAnesthesia) {
        surgeryHistory = e.surgeryHistory ?? false
        
        surgeryHistoryDetails = e.surgeryHistoryDetails ?? []
        surgeryHistoryCustomDetails = e.surgeryHistoryCustomDetails ?? []
        surgeryHistoryDetailsText = e.surgeryHistoryDetailsText
    }
    
    func apply(to e: PreAnesthesia) {
        e.surgeryHistory = surgeryHistory
        
        e.surgeryHistoryDetails = surgeryHistoryDetails
        e.surgeryHistoryCustomDetails = surgeryHistoryCustomDetails
        e.surgeryHistoryDetailsText = surgeryHistoryDetailsText
    }
    
    //to be uncommented when available
//    func addGeneticSyndromeComorbitiesCustomDetails(_ name: String) {
//        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !trimmed.isEmpty else { return }
//        guard !geneticSyndromeComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
//        geneticSyndromeComorbitiesCustomDetails.append(trimmed)
//    }
//    func removeGeneticSyndromeComorbitiesCustomDetails(at index: Int) {
//        guard geneticSyndromeComorbitiesCustomDetails.indices.contains(index) else { return }
//        geneticSyndromeComorbitiesCustomDetails.remove(at: index)
//    }
}

