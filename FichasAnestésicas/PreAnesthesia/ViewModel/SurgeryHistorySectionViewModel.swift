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

    weak var socialHabitsVM: SocialHabitsAndEnvironmentSectionViewModel?
    

    var surgeryHistory = false {
        didSet {
            if surgeryHistory == false && oldValue == true {
                surgeryHistoryVisibility()
            } else {
                whenSurgeryHistory()
            }
        }
    }
    var anesthesiaHistory = false {
        didSet {
            if anesthesiaHistory == false && oldValue == true {
                anesthesiaHistoryVisibility()
            }
        }
    }
    
    var surgeryHistoricDetails: [SurgeryHistoryDetail] = []
    var anesthesiaHistoricDetails: [AnesthesiaHistoryDetail] = [] {
        didSet { syncHistoryToApfel() }
    }
    
    var surgeryHistoryDetails: [SurgeryHistorySpeciality]?
    var surgeryHistoryCustomDetails: [String] = []
    var surgeryHistoryDetailsText: String?
    var anesthesiaHistoryDetails: [AnesthesiaComplicationsHistory]? {
        didSet { syncHistoryToApfel() }
    }
    var anesthesiaHistoryCustomDetails: [String] = []
    var anesthesiaHistoryDetailsText: String?

    
    
    func load(from e: PreAnesthesia) {
        surgeryHistory = e.surgeryHistory ?? false
        anesthesiaHistory = e.anesthesiaHistory ?? false
        
        surgeryHistoricDetails = e.surgeryHistoricDetails ?? []
        anesthesiaHistoricDetails = e.anesthesiaHistoricDetails ?? []
        
        surgeryHistoryDetails = e.surgeryHistoryDetails ?? []
        surgeryHistoryCustomDetails = e.surgeryHistoryCustomDetails ?? []
        surgeryHistoryDetailsText = e.surgeryHistoryDetailsText
        anesthesiaHistoryDetails = e.anesthesiaHistoryDetails ?? []
        anesthesiaHistoryCustomDetails = e.anesthesiaHistoryCustomDetails ?? []
        anesthesiaHistoryDetailsText = e.anesthesiaHistoryDetailsText
    }
    
    func apply(to e: PreAnesthesia) {
        e.surgeryHistory = surgeryHistory
        e.anesthesiaHistory = anesthesiaHistory
        
        e.surgeryHistoricDetails = surgeryHistoricDetails
        e.anesthesiaHistoricDetails = anesthesiaHistoricDetails
        
        e.surgeryHistoryDetails = surgeryHistoryDetails
        e.surgeryHistoryCustomDetails = surgeryHistoryCustomDetails
        e.surgeryHistoryDetailsText = surgeryHistoryDetailsText
        e.anesthesiaHistoryDetails = anesthesiaHistoryDetails
        e.anesthesiaHistoryCustomDetails = anesthesiaHistoryCustomDetails
        e.anesthesiaHistoryDetailsText = anesthesiaHistoryDetailsText
    }
    
    func surgeryHistoryVisibility() {
        if surgeryHistory == false {
            surgeryHistoricDetails = []
        }
    }
    func whenSurgeryHistory() {
        anesthesiaHistory = true
    }
    
    func anesthesiaHistoryVisibility() {
        if anesthesiaHistory == false {
            anesthesiaHistoricDetails = []
            
        }
    }
    
    var canSave: Bool {
        var ok = true
        if surgeryHistory {
            ok = ok && !surgeryHistoricDetails.isEmpty
        }
        if anesthesiaHistory {
            ok = ok && !anesthesiaHistoricDetails.isEmpty
        }
        return ok
    }
    
    private var syncing = false

    private func syncHistoryToApfel() {
        guard !syncing, let socialVM = socialHabitsVM else { return }
        syncing = true
        
        var apfel = socialVM.apfelScoreDetails ?? []
        
        let hasNausea = anesthesiaHistoricDetails.contains { $0.type == .nausea }
        
        if hasNausea {
            if !apfel.contains(.historyPONV) {
                apfel.append(.historyPONV)
            }
        } else {
            apfel.removeAll { $0 == .historyPONV }
        }
        
        socialVM.apfelScoreDetails = apfel
        syncing = false
    }
}

