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
    var adverseEvolution: String?
    var finalDescription: String?
    
    func load(from e: AnesthesiaDescriptionEntry) {
        standardEnd = e.standardEnd
        destinationAnesthesia = e.destinationAnesthesia
        endAnesthesia = e.endAnesthesia
        adverseEvolution = e.adverseEvolution
        finalDescription = e.finalDescription
    }
    func apply(to e: AnesthesiaDescriptionEntry) {
        e.standardEnd = standardEnd
        e.destinationAnesthesia = destinationAnesthesia
        e.endAnesthesia = endAnesthesia
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
        }
    }
    func standardEndVisibility() {
        if standardEnd == true {
            destinationAnesthesia = .rpa
            endAnesthesia = .noComplication
        }
        
    }
}
