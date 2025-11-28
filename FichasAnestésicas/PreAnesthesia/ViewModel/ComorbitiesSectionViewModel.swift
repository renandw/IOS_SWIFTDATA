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
    var respiratoryComorbities = false { didSet {respiratoryComorbitiesVisibility() } }
    var endocrineComorbities = false { didSet { endocrineComorbitiesVisibility() } }
    var gastrointestinalComorbities = false {didSet { gastrointestinalComorbitiesVisibility() } }
    var hematologicalComorbities = false {didSet { hematologicalComorbitiesVisibility() } }
    var imunologicalComorbities = false {didSet {imunologicalComorbitiesVisibility() } }
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
    
    var respiratoryComorbitiesDetails: [RespiratoryComorbities]?
    var respiratoryComorbitiesCustomDetails: [String] = []
    var respiratoryComorbitiesDetailsText: String?
    
    var endocrineComorbitiesDetails: [EndocrineComorbities]?
    var endocrineComorbitiesCustomDetails: [String] = []
    var endocrineComorbitiesDetailsText: String?
    
    var gastrointestinalComorbitiesDetails: [GastrointestinalComorbities]?
    var gastrointestinalComorbitiesCustomDetails: [String] = []
    var gastrointestinalComorbitiesDetailsText: String?
    
    var hematologicalComorbitiesDetails: [HematologicComorbities]?
    var hematologicalComorbitiesCustomDetails: [String] = []
    var hematologicalComorbitiesDetailsText: String?
    
    var imunologicalComorbitiesDetails: [ImmunologicComorbities]?
    var imunologicalComorbitiesCustomDetails: [String] = []
    var imunologicalComorbitiesDetailsText: String?
    
    var musculoskeletalComorbitiesDetails: [MusculoskeletalComorbities]?
    var musculoskeletalComorbitiesCustomDetails: [String] = []
    var musculoskeletalComorbitiesDetailsText: String?
    
    
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
        respiratoryComorbitiesDetails = e.respiratoryComorbitiesDetails ?? []
        respiratoryComorbitiesCustomDetails = e.respiratoryComorbitiesCustomDetails ?? []
        respiratoryComorbitiesDetailsText = e.respiratoryComorbitiesDetailsText
        endocrineComorbitiesDetails = e.endocrineComorbitiesDetails ?? []
        endocrineComorbitiesCustomDetails = e.endocrineComorbitiesCustomDetails ?? []
        endocrineComorbitiesDetailsText = e.endocrineComorbitiesDetailsText
        gastrointestinalComorbitiesDetails = e.gastrointestinalComorbitiesDetails ?? []
        gastrointestinalComorbitiesCustomDetails = e.gastrointestinalComorbitiesCustomDetails ?? []
        gastrointestinalComorbitiesDetailsText = e.gastrointestinalComorbitiesDetailsText
        hematologicalComorbitiesDetails = e.hematologicalComorbitiesDetails ?? []
        hematologicalComorbitiesCustomDetails = e.hematologicalComorbitiesCustomDetails ?? []
        hematologicalComorbitiesDetailsText = e.hematologicalComorbitiesDetailsText
        imunologicalComorbitiesDetails = e.imunologicalComorbitiesDetails ?? []
        imunologicalComorbitiesCustomDetails = e.imunologicalComorbitiesCustomDetails ?? []
        imunologicalComorbitiesDetailsText = e.imunologicalComorbitiesDetailsText
        musculoskeletalComorbitiesDetails = e.musculoskeletalComorbitiesDetails ?? []
        musculoskeletalComorbitiesCustomDetails = e.musculoskeletalComorbitiesCustomDetails ?? []
        musculoskeletalComorbitiesDetailsText = e.musculoskeletalComorbitiesDetailsText
        
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
        e.respiratoryComorbitiesDetails = respiratoryComorbitiesDetails
        e.respiratoryComorbitiesCustomDetails = respiratoryComorbitiesCustomDetails
        e.respiratoryComorbitiesDetailsText = respiratoryComorbitiesDetailsText
        e.endocrineComorbitiesDetails = endocrineComorbitiesDetails
        e.endocrineComorbitiesCustomDetails = endocrineComorbitiesCustomDetails
        e.endocrineComorbitiesDetailsText = endocrineComorbitiesDetailsText
        e.gastrointestinalComorbitiesDetails = gastrointestinalComorbitiesDetails
        e.gastrointestinalComorbitiesCustomDetails = gastrointestinalComorbitiesCustomDetails
        e.gastrointestinalComorbitiesDetailsText = gastrointestinalComorbitiesDetailsText
        e.hematologicalComorbitiesDetails = hematologicalComorbitiesDetails
        e.hematologicalComorbitiesCustomDetails = hematologicalComorbitiesCustomDetails
        e.hematologicalComorbitiesDetailsText = hematologicalComorbitiesDetailsText
        e.imunologicalComorbitiesDetails = imunologicalComorbitiesDetails
        e.imunologicalComorbitiesCustomDetails = imunologicalComorbitiesCustomDetails
        e.imunologicalComorbitiesDetailsText = imunologicalComorbitiesDetailsText
        e.musculoskeletalComorbitiesDetails = musculoskeletalComorbitiesDetails
        e.musculoskeletalComorbitiesCustomDetails = musculoskeletalComorbitiesCustomDetails
        e.musculoskeletalComorbitiesDetailsText = musculoskeletalComorbitiesDetailsText
        
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
    func respiratoryComorbitiesVisibility() {
        if respiratoryComorbities == false {
            respiratoryComorbitiesDetails = []
            respiratoryComorbitiesDetailsText = ""
            respiratoryComorbitiesCustomDetails = []
        }
    }
    func endocrineComorbitiesVisibility() {
        if endocrineComorbities == false {
            endocrineComorbitiesDetails = []
            endocrineComorbitiesDetailsText = ""
            endocrineComorbitiesCustomDetails = []
        }
    }
    func gastrointestinalComorbitiesVisibility() {
        if gastrointestinalComorbities == false {
            gastrointestinalComorbitiesDetails = []
            gastrointestinalComorbitiesDetailsText = ""
            gastrointestinalComorbitiesCustomDetails = []
        }
    }
    func hematologicalComorbitiesVisibility() {
        if hematologicalComorbities == false {
            hematologicalComorbitiesDetails = []
            hematologicalComorbitiesDetailsText = ""
            hematologicalComorbitiesCustomDetails = []
        }
    }
    func imunologicalComorbitiesVisibility() {
        if imunologicalComorbities == false {
            imunologicalComorbitiesDetails = []
            imunologicalComorbitiesDetailsText = ""
            imunologicalComorbitiesCustomDetails = []
        }
    }
    func musculoskeletalComorbitiesVisibility() {
        if musculoskeletalComorbities == false {
            musculoskeletalComorbitiesDetails = []
            musculoskeletalComorbitiesDetailsText = ""
            musculoskeletalComorbitiesCustomDetails = []
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
        guard !cardiacComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        cardiacComorbitiesCustomDetails.append(trimmed)
    }
    func removeCardiacComorbitiesCustomDetails(at index: Int) {
        guard cardiacComorbitiesCustomDetails.indices.contains(index) else { return }
        cardiacComorbitiesCustomDetails.remove(at: index)
    }
    func addRespiratoryComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !respiratoryComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        respiratoryComorbitiesCustomDetails.append(trimmed)
    }
    func removeRespiratoryComorbitiesCustomDetails(at index: Int) {
        guard respiratoryComorbitiesCustomDetails.indices.contains(index) else { return }
        respiratoryComorbitiesCustomDetails.remove(at: index)
    }
    func addEndocrineComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !endocrineComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        endocrineComorbitiesCustomDetails.append(trimmed)
    }
    func removeEndocrineComorbitiesCustomDetails(at index: Int) {
        guard endocrineComorbitiesCustomDetails.indices.contains(index) else { return }
        endocrineComorbitiesCustomDetails.remove(at: index)
    }
    func addGastrointestinalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !gastrointestinalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        gastrointestinalComorbitiesCustomDetails.append(trimmed)
    }
    func removeGastrointestinalComorbitiesCustomDetails(at index: Int) {
        guard gastrointestinalComorbitiesCustomDetails.indices.contains(index) else { return }
        gastrointestinalComorbitiesCustomDetails.remove(at: index)
    }
    func addHematologicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !hematologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        hematologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeHematologicalComorbitiesCustomDetails(at index: Int) {
        guard hematologicalComorbitiesCustomDetails.indices.contains(index) else { return }
        hematologicalComorbitiesCustomDetails.remove(at: index)
    }
    
    func addImunologicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !imunologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        imunologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeImunologicalComorbitiesCustomDetails(at index: Int) {
        guard imunologicalComorbitiesCustomDetails.indices.contains(index) else { return }
        imunologicalComorbitiesCustomDetails.remove(at: index)
    }
    
    func addmMsculoskeletalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !imunologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        imunologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeMusculoskeletalComorbitiesCustomDetails(at index: Int) {
        guard musculoskeletalComorbitiesCustomDetails.indices.contains(index) else { return }
        musculoskeletalComorbitiesCustomDetails.remove(at: index)
    }
    
    
}

