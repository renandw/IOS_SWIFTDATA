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
    
    var difficultAirwayEvaluation: [DifficultAirwayEvaluation]? {didSet {hasTraqueoVisibility()} }
    var difficultAirwayEvaluationCustomDetails: [String] = []
    var difficultAirwayEvaluationDetailsText: String?
    
    
    func load(from e: PreAnesthesia) {
        
        mallampatiClassification = e.mallampatiClassification
        difficultAirwayEvaluation = e.difficultAirwayEvaluation ?? []
        difficultAirwayEvaluationCustomDetails = e.difficultAirwayEvaluationCustomDetails ?? []
        difficultAirwayEvaluationDetailsText = e.difficultAirwayEvaluationDetailsText
        
    }
    
    func apply(to e: PreAnesthesia) {
        
        e.mallampatiClassification = mallampatiClassification
        e.difficultAirwayEvaluation = difficultAirwayEvaluation
        e.difficultAirwayEvaluationCustomDetails = difficultAirwayEvaluationCustomDetails
        e.difficultAirwayEvaluationDetailsText = difficultAirwayEvaluationDetailsText
        
    }
    
    func addDifficultEvaluationCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !difficultAirwayEvaluationCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        difficultAirwayEvaluationCustomDetails.append(trimmed)
    }
    func removeDifficultEvaluationCustomDetails(at index: Int) {
        guard difficultAirwayEvaluationCustomDetails.indices.contains(index) else { return }
        difficultAirwayEvaluationCustomDetails.remove(at: index)
    }
    
    var canSave: Bool {
        if difficultAirwayEvaluation?.contains(.traqueo) == true {
            return true
        }
        return mallampatiClassification != nil
    }
    
        
    func applyHealthyPatient() {
        mallampatiClassification = .I
        difficultAirwayEvaluationCustomDetails = []
        difficultAirwayEvaluationDetailsText = nil
    }
    
    func hasTraqueoVisibility() {
        if difficultAirwayEvaluation == [.traqueo] {
            mallampatiClassification = nil
        }
    }
}
