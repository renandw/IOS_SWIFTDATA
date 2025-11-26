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
    
    
    func load(from e: PreAnesthesia, patientSex: Sex, patientAge: Int) {
        isInfantVisibility(patientAge: patientAge)
        isPregnantVisibility(patientSex: patientSex)
        
        isPregnant = e.isPregnant
        isInfant = e.isInfant
        cardiacComorbities = e.cardiacComorbities
        respiratoryComorbities = e.respiratoryComorbities
        endocrineComorbities = e.endocrineComorbities
        gastrointestinalComorbities = e.gastrointestinalComorbities
        hematologicalComorbities = e.hematologicalComorbities
        musculoskeletalComorbities = e.musculoskeletalComorbities
        genitourologicalComorbities = e.genitourologicalComorbities
        neurologicalComorbities = e.neurologicalComorbities
        geneticSyndrome = e.geneticSyndrome
    }
    
    func apply(to e: PreAnesthesia, patientSex: Sex, patientAge: Int) {
        
        isInfantVisibility(patientAge: patientAge)
        isPregnantVisibility(patientSex: patientSex)
        
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
    
    func isPregnantVisibility(patientSex: Sex) {
        if patientSex == .male {
            isPregnant = false
        }
    }
    func isInfantVisibility(patientAge: Int) {
        if patientAge > 1 {
            isInfant = false
        } else {
            isInfant = true
        }
    }
}

