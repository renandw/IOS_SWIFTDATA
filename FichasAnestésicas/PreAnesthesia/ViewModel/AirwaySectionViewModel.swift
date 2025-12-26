//
//  AirWaySectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class AirwaySectionViewModel {
    
    
    var mallampatiClassification: MallampatiClassification?
    var difficultAirwayDetails: [DifficultAirwayDetail] = [] {
        didSet {
            hasTraqueoVisibility()
        }
    }
    
    func load(from e: PreAnesthesia) {
        difficultAirwayDetails = e.difficultAirwayDetails ?? []
        
        mallampatiClassification = e.mallampatiClassification
        
    }
    
    func apply(to e: PreAnesthesia) {
        e.difficultAirwayDetails = difficultAirwayDetails
        
        e.mallampatiClassification = mallampatiClassification

        
    }
    
    var canSave: Bool {
        if difficultAirwayDetails == [DifficultAirwayDetail(type: .traqueo, customName: nil)] {
            return true
        }
        return mallampatiClassification != nil
    }
    
    func applyHealthyPatient() {
        mallampatiClassification = .I
        difficultAirwayDetails = []
    }
    func hasTraqueoVisibility() {
        if difficultAirwayDetails == [DifficultAirwayDetail(type: .traqueo, customName: nil)] {
            mallampatiClassification = nil
        }
    }
}
