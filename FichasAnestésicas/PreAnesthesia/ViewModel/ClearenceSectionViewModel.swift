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
    
    var clearenceStatus: ClearenceStatus?
    var recommendationForRevaluationStatus: RecommendationForRevaluationStatus?
    var futherRecommendationForRevaluation: [String] = []

    func load(from e: PreAnesthesia) {
        clearenceStatus = e.clearenceStatus
        recommendationForRevaluationStatus = e.recommendationForRevaluationStatus
        futherRecommendationForRevaluation = e.futherRecommendationForRevaluation ?? []

    }

    func apply(to e: PreAnesthesia) {
        e.clearenceStatus = clearenceStatus
        e.recommendationForRevaluationStatus = recommendationForRevaluationStatus
        e.futherRecommendationForRevaluation = futherRecommendationForRevaluation.isEmpty ? nil : futherRecommendationForRevaluation
    }
    
    func addCustomMonitoring(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !futherRecommendationForRevaluation.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        futherRecommendationForRevaluation.append(trimmed)
    }
    
    func removeCustomMonitoring(at index: Int) {
        guard futherRecommendationForRevaluation.indices.contains(index) else { return }
        futherRecommendationForRevaluation.remove(at: index)
    }
    
    func applyClearenceSuggestion(hasGeneralAnesthesia: Bool) {
        clearenceStatus = .able
        recommendationForRevaluationStatus = nil
        futherRecommendationForRevaluation = []
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
