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
    
    var difficultAirwayEvaluation: [DifficultAirwayEvaluation]?
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
}
