//
//  ComorbitiesSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 25/11/25.
//
import SwiftUI
import SwiftData

@Observable
final class ComorbitiesSectionViewModel {
   
    var isPregnant = false
    var isInfant = false
    var cardiacComorbities = false
    var respiratoryComorbities = false
    var endocrineComorbities = false
    var gastrointestinalComorbities = false
    var hematologicalComorbities = false
    var musculoskeletalComorbities = false
    var genitourologicalComorbities = false
    var neurologicalComorbities = false
    var geneticSyndrome = false
    
    func load(from e: PreAnesthesia) {
        isPregnant = e.isPregnant ?? false
        isInfant = e.isInfant ?? false
        cardiacComorbities = e.cardiacComorbities ?? false
        respiratoryComorbities = e.respiratoryComorbities ?? false
        endocrineComorbities = e.endocrineComorbities ?? false
        gastrointestinalComorbities = e.gastrointestinalComorbities ?? false
        hematologicalComorbities = e.hematologicalComorbities ?? false
        musculoskeletalComorbities = e.musculoskeletalComorbities ?? false
        genitourologicalComorbities = e.genitourologicalComorbities ?? false
        neurologicalComorbities = e.neurologicalComorbities ?? false
        geneticSyndrome = e.geneticSyndrome ?? false
    }
    
    func apply(to e: PreAnesthesia) {
        e.isPregnant = isPregnant
        e.isInfant = isInfant
        e.cardiacComorbities = cardiacComorbities
        e.respiratoryComorbities = respiratoryComorbities
        e.endocrineComorbities = endocrineComorbities
        e.gastrointestinalComorbities = gastrointestinalComorbities
        e.hematologicalComorbities = hematologicalComorbities
        e.musculoskeletalComorbities = musculoskeletalComorbities
        e.genitourologicalComorbities = genitourologicalComorbities
        e.neurologicalComorbities = neurologicalComorbities
        e.geneticSyndrome = geneticSyndrome
    }
}

