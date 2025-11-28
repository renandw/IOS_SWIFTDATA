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
    var surgeryHistory = false {
        didSet {
            if surgeryHistory == false && oldValue == true {
                surgeryHistoryVisibility()
            }
        }
    }
    var anesthesiaHistory = false
    
    var surgeryHistoryDetails: [SurgeryHistorySpeciality]?
    var surgeryHistoryCustomDetails: [String] = []
    var surgeryHistoryDetailsText: String?
    var anesthesiaHistoryDetails: [AnesthesiaComplicationsHistory]?
    var anesthesiaHistoryCustomDetails: [String] = []
    var anesthesiaHistoryDetailsText: String?
    
    func load(from e: PreAnesthesia) {
        surgeryHistory = e.surgeryHistory ?? false
        
        surgeryHistoryDetails = e.surgeryHistoryDetails ?? []
        surgeryHistoryCustomDetails = e.surgeryHistoryCustomDetails ?? []
        surgeryHistoryDetailsText = e.surgeryHistoryDetailsText
        anesthesiaHistoryDetails = e.anesthesiaHistoryDetails ?? []
        anesthesiaHistoryCustomDetails = e.anesthesiaHistoryCustomDetails ?? []
        anesthesiaHistoryDetailsText = e.anesthesiaHistoryDetailsText
    }
    
    func apply(to e: PreAnesthesia) {
        e.surgeryHistory = surgeryHistory
        
        e.surgeryHistoryDetails = surgeryHistoryDetails
        e.surgeryHistoryCustomDetails = surgeryHistoryCustomDetails
        e.surgeryHistoryDetailsText = surgeryHistoryDetailsText
        e.anesthesiaHistoryDetails = anesthesiaHistoryDetails
        e.anesthesiaHistoryCustomDetails = anesthesiaHistoryCustomDetails
        e.anesthesiaHistoryDetailsText = anesthesiaHistoryDetailsText
    }
    
    func surgeryHistoryVisibility() {
        if surgeryHistory == false {
            surgeryHistoryCustomDetails = []
            surgeryHistoryDetailsText = ""
            surgeryHistoryDetails = []
        }
    }
    func anesthesiaHistoryVisibility() {
        if anesthesiaHistory == false {
            anesthesiaHistoryCustomDetails = []
            anesthesiaHistoryDetailsText = ""
            anesthesiaHistoryDetails = []
        }
    }
    
    
    func addSurgeryHistoryCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !surgeryHistoryCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        surgeryHistoryCustomDetails.append(trimmed)
    }
    func removeSurgeryHistoryCustomDetails(at index: Int) {
        guard surgeryHistoryCustomDetails.indices.contains(index) else { return }
        surgeryHistoryCustomDetails.remove(at: index)
    }
}

