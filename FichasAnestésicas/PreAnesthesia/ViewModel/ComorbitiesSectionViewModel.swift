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
    var cardiacComorbities = false {didSet {cardiacComorbitiesVisibility() } }
    var respiratoryComorbities = false
    var endocrineComorbities = false
    var gastrointestinalComorbities = false
    var hematologicalComorbities = false
    var musculoskeletalComorbities = false
    var genitourologicalComorbities = false
    var neurologicalComorbities = false
    var geneticSyndrome = false
    
    //one by one
    var isInfantComorbitiesDetails: [InfantComorbities]?
    var isInfantDetailsText: String?
    var isInfantCustomDetails: [String] = []
    var cardiacComorbitiesDetails: [CardiologicComorbities]?
    var cardiacComorbitiesCustomDetails: [String] = []
    var cardiacComorbitiesDetailsText: String?
    
    
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
        //one by one
        isInfantComorbitiesDetails = e.isInfantComorbitiesDetails
        isInfantCustomDetails = e.isInfantCustomDetails ?? []
        isInfantDetailsText = e.isInfantDetailsText
        cardiacComorbitiesDetails = e.cardiacComorbitiesDetails
        cardiacComorbitiesCustomDetails = e.cardiacComorbitiesCustomDetails ?? []
        cardiacComorbitiesDetailsText = e.cardiacComorbitiesDetailsText
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
        
        //one by one
        e.isInfantComorbitiesDetails = isInfantComorbitiesDetails
        e.isInfantDetailsText = isInfantDetailsText
        e.isInfantCustomDetails = isInfantCustomDetails
        e.cardiacComorbitiesDetails = cardiacComorbitiesDetails
        e.cardiacComorbitiesCustomDetails = cardiacComorbitiesCustomDetails
        e.cardiacComorbitiesDetailsText = cardiacComorbitiesDetailsText
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
    func cardiacComorbitiesVisibility() {
        if cardiacComorbities == false {
            cardiacComorbitiesDetails = []
        }
    }
    
    func addInfantCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !isInfantCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        isInfantCustomDetails.append(trimmed)
    }
    func removeInfantCustomDetails(at index: Int) {
        guard isInfantCustomDetails.indices.contains(index) else { return }
        isInfantCustomDetails.remove(at: index)
    }
    func addCardiacComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !isInfantCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        isInfantCustomDetails.append(trimmed)
    }
    func removeCardiacComorbitiesCustomDetails(at index: Int) {
        guard cardiacComorbitiesCustomDetails.indices.contains(index) else { return }
        cardiacComorbitiesCustomDetails.remove(at: index)
    }
}

