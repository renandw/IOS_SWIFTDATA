//
//  ClearenceSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 25/11/25.
//

//
//  MonitoringSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//
import SwiftUI
import SwiftData

@Observable
final class ClearenceSectionViewModel {
    
    var clearenceStatus: ClearenceStatus? {didSet {recommendationsVisibility()}}
    var definitiveRecommendationForRevaluationStatus: [RecommendationForRevaluationStatus]?
    var futherRecommendationForRevaluation: [String] = []

    func load(from e: PreAnesthesia) {
        clearenceStatus = e.clearenceStatus
        definitiveRecommendationForRevaluationStatus = e.definitiveRecommendationForRevaluationStatus
        futherRecommendationForRevaluation = e.futherRecommendationForRevaluation ?? []

    }

    func apply(to e: PreAnesthesia) {
        e.clearenceStatus = clearenceStatus
        e.definitiveRecommendationForRevaluationStatus = definitiveRecommendationForRevaluationStatus
        e.futherRecommendationForRevaluation = futherRecommendationForRevaluation.isEmpty ? nil : futherRecommendationForRevaluation
    }
    
    func addCustomRecommendation(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !futherRecommendationForRevaluation.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        futherRecommendationForRevaluation.append(trimmed)
    }
    
    func removeCustomRecommendation(at index: Int) {
        guard futherRecommendationForRevaluation.indices.contains(index) else { return }
        futherRecommendationForRevaluation.remove(at: index)
    }
    
    func applyClearenceSuggestion(hasGeneralAnesthesia: Bool) {
        clearenceStatus = .able
        definitiveRecommendationForRevaluationStatus = nil
        futherRecommendationForRevaluation = []
    }
    
    func recommendationsVisibility() {
        if clearenceStatus == .able || clearenceStatus == .unable {
            definitiveRecommendationForRevaluationStatus = nil
            futherRecommendationForRevaluation = []
        }
    }
    
    
//    func generateMonitoringText() -> String {
//        var items: [String] = []
//        
//        let clearence: [(Bool, String)] = [
//           
//        ]
//        
//        items.append(contentsOf: clearence.filter { $0.0 }.map { $0.1 })
//        items.append(contentsOf: futherRecommendationForRevaluation)
//        guard !items.isEmpty else { return "" }
//        return "Checklist de materiais de anestesia. Monitorização: \(items.joined(separator: ", "))."
//    }
}
