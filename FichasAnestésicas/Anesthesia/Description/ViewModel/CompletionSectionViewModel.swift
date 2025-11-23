//
//  CompletionSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class CompletionSectionViewModel {
    var standardEnd = false {didSet{standardEndVisibility() } }
    var destinationAnesthesia: DestinationAnesthesia?
    var endAnesthesia: EndAnesthesia? {didSet {adverseEndVisibility() } }
    var complications: [String] = []
    var adverseEvolution: String?
    var finalDescription: String?
    
    func load(from e: AnesthesiaDescriptionEntry) {
        standardEnd = e.standardEnd
        destinationAnesthesia = e.destinationAnesthesia
        endAnesthesia = e.endAnesthesia
        adverseEvolution = e.adverseEvolution
        finalDescription = e.finalDescription
        complications = e.complications
    }
    func apply(to e: AnesthesiaDescriptionEntry) {
        e.standardEnd = standardEnd
        e.destinationAnesthesia = destinationAnesthesia
        e.endAnesthesia = endAnesthesia
        e.complications = complications
        e.adverseEvolution = adverseEvolution
        e.finalDescription = finalDescription
    }
    
    func resetCompletionSection() {
        standardEnd = false
        destinationAnesthesia = nil
        endAnesthesia = nil
        adverseEvolution = nil
    }
    
    func applyCompletionSuggestion() {
        standardEnd = true
        destinationAnesthesia = .rpa
        endAnesthesia = .noComplication
        adverseEvolution = nil
    }
    func adverseEndVisibility() {
        if endAnesthesia == .noComplication {
            adverseEvolution = nil
            complications = []
        }
    }
    func standardEndVisibility() {
        if standardEnd == true {
            destinationAnesthesia = .rpa
            endAnesthesia = .noComplication
        }
        
    }
    
    func addComplications(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !complications.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        complications.append(trimmed)
    }
    
    func removeComplications(at index: Int) {
        guard complications.indices.contains(index) else { return }
        complications.remove(at: index)
    }
    
    func generateCompletionText() -> String {
        var parts: [String] = []
        
        if standardEnd {
            parts.append("paciente com respiração espontânea, obedecendo comandos, boa mecânica ventilatória e oximetria estável.")
        }
        
        if let destinationAnesthesia = destinationAnesthesia?.reportDisplayName {
            parts.append(destinationAnesthesia)
        }
        
        if let endAnesthesia = endAnesthesia?.reportDisplayName {
            parts.append(endAnesthesia)
        }

        parts.append(contentsOf: complications)
        guard !parts.isEmpty else { return "" }
        return "Ao término da cirurgia\(parts.joined(separator: ", ")),."
        
    }
}
