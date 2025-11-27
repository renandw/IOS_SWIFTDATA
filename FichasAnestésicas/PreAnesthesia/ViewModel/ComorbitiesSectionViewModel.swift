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
   
    var isPregnant = false { didSet {isPregnantComorbitiesVisibility() } }
    var isInfant = false { didSet {isInfantComorbitiesVisibility() } }
    var cardiacComorbities = false { didSet {cardiacComorbitiesVisibility() } }
    var respiratoryComorbities = false
    var endocrineComorbities = false
    var gastrointestinalComorbities = false
    var hematologicalComorbities = false
    var imunologicalComorbities = false
    var musculoskeletalComorbities = false
    var genitourologicalComorbities = false
    var neurologicalComorbities = false
    var geneticSyndrome = false
    
    //one by one
    var isPregnantComorbitiesDetails: [PregnantComorbities]?
    var isPregnantDetailsText: String?
    var isPregnantAge: String?
    var isPregnantCustomDetails: [String] = []
    
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
        imunologicalComorbities = e.imunologicalComorbities ?? false
        musculoskeletalComorbities = e.musculoskeletalComorbities
        genitourologicalComorbities = e.genitourologicalComorbities
        neurologicalComorbities = e.neurologicalComorbities
        geneticSyndrome = e.geneticSyndrome
        //one by one
        isPregnantComorbitiesDetails = e.isPregnantComorbitiesDetails
        isPregnantDetailsText = e.isPregnantDetailsText
        isPregnantAge = e.isPregnantAge
        isPregnantCustomDetails = e.isPregnantCustomDetails ?? []
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
        e.imunologicalComorbities = imunologicalComorbities
        e.musculoskeletalComorbities = musculoskeletalComorbities
        e.genitourologicalComorbities = genitourologicalComorbities
        e.neurologicalComorbities = neurologicalComorbities
        e.geneticSyndrome = geneticSyndrome
        
        //one by one
        e.isPregnantComorbitiesDetails = isPregnantComorbitiesDetails
        e.isPregnantDetailsText = isPregnantDetailsText
        e.isPregnantAge = isPregnantAge
        e.isPregnantCustomDetails = isPregnantCustomDetails
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
    func isPregnantComorbitiesVisibility() {
        if isPregnant == false {
            isPregnantAge = ""
            isPregnantCustomDetails = []
            isPregnantDetailsText = ""
            isPregnantComorbitiesDetails = []
        }
    }
    
    func isInfantVisibility(patientAge: Int) {
        if patientAge > 1 {
            isInfant = false
        } else {
            isInfant = true
        }
    }
    
    func isInfantComorbitiesVisibility() {
        if isInfant == false {
            isInfantCustomDetails = []
            isInfantDetailsText = ""
            isInfantComorbitiesDetails = []
        }
    }
    
    func cardiacComorbitiesVisibility() {
        if cardiacComorbities == false {
            cardiacComorbitiesDetails = []
            cardiacComorbitiesDetailsText = ""
            cardiacComorbitiesCustomDetails = []
        }
    }
    
    func addPregnantCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !isPregnantCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        isPregnantCustomDetails.append(trimmed)
    }
    func removePregnantCustomDetails(at index: Int) {
        guard isPregnantCustomDetails.indices.contains(index) else { return }
        isPregnantCustomDetails.remove(at: index)
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

