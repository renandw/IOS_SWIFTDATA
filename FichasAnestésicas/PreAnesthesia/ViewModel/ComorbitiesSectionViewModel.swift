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
    var musculoskeletalComorbities = false {didSet {musculoskeletalComorbitiesVisibility() } }
    var genitourologicalComorbities = false { didSet { genitourologicalComorbitiesVisibility() } }
    var gynecologicalComorbities = false { didSet { gynecologicalComorbitiesVisibility() } }
    var androgenicalComorbities = false { didSet { androgenicalComorbitiesVisibility() } }
    var neurologicalComorbities = false {didSet { neurologicalComorbitiesVisibility() } }
    var infectiousComorbities = false
    var oncologicComorbities = false
    var geneticSyndrome = false {didSet { geneticSyndromeVisibility() } }
    var healthyPatient = false {
        didSet {
            if healthyPatient == true && oldValue == false {
                healthyPatientComorbities()
            }
        }
    }
    
    //section
    var oncologyDetails: [OncologyComorbidityDetail] = []
    var cardiologyDetails: [CardiologyComorbidityDetail] = []
    var respiratoryDetails: [RespiratoryComorbidityDetail] = []
    
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
    
    var genitourologicalComorbitiesDetails: [GenitourinaryComorbities]?
    var genitourologicalComorbitiesCustomDetails: [String] = []
    var genitourologicalComorbitiesDetailsText: String?
    
    var gynecologicalComorbitiesDetails: [GynecologicComorbities]?
    var gynecologicalComorbitiesCustomDetails: [String] = []
    var gynecologicalComorbitiesDetailsText: String?
    
    var androgenicalComorbitiesDetails: [AndrologicComorbities]?
    var androgenicalComorbitiesCustomDetails: [String] = []
    var androgenicalComorbitiesDetailsText: String?
    
    var neurologicalComorbitiesDetails: [NeurologicalComorbities]?
    var neurologicalComorbitiesCustomDetails: [String] = []
    var neurologicalComorbitiesDetailsText: String?
    
    var geneticSyndromeComorbitiesDetails: [GeneticSyndrome]?
    var geneticSyndromeComorbitiesCustomDetails: [String] = []
    var geneticSyndromeComorbitiesDetailsText: String?
    
    var infectiousComorbitiesDetails: [InfectiousComorbities]?
    var infectiousComorbitiesCustomDetails: [String] = []
    var infectiousComorbitiesDetailsText: String?
    
    
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
        gynecologicalComorbities = e.gynecologicalComorbities ?? false
        androgenicalComorbities = e.androgenicalComorbities ?? false
        infectiousComorbities = e.infectiousComorbities ?? false
        oncologicComorbities = e.oncologicComorbities ?? false
        neurologicalComorbities = e.neurologicalComorbities
        geneticSyndrome = e.geneticSyndrome
        healthyPatient = e.healthyPatient ?? false
        //newsection
        oncologyDetails = e.oncologyDetails ?? []
        cardiologyDetails = e .cardiologyDetails ?? []
        respiratoryDetails = e .respiratoryDetails ?? []
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
        
        genitourologicalComorbitiesDetails = e.genitourologicalComorbitiesDetails ?? []
        genitourologicalComorbitiesCustomDetails = e.genitourologicalComorbitiesCustomDetails ?? []
        genitourologicalComorbitiesDetailsText = e.genitourologicalComorbitiesDetailsText
        gynecologicalComorbitiesDetails = e.gynecologicalComorbitiesDetails ?? []
        gynecologicalComorbitiesCustomDetails = e.gynecologicalComorbitiesCustomDetails ?? []
        gynecologicalComorbitiesDetailsText = e.gynecologicalComorbitiesDetailsText
        androgenicalComorbitiesDetails = e.androgenicalComorbitiesDetails ?? []
        androgenicalComorbitiesCustomDetails = e.androgenicalComorbitiesCustomDetails ?? []
        androgenicalComorbitiesDetailsText = e.androgenicalComorbitiesDetailsText
        neurologicalComorbitiesDetails = e.neurologicalComorbitiesDetails ?? []
        neurologicalComorbitiesCustomDetails = e.neurologicalComorbitiesCustomDetails ?? []
        neurologicalComorbitiesDetailsText = e.neurologicalComorbitiesDetailsText
        geneticSyndromeComorbitiesDetails = e.geneticSyndromeComorbitiesDetails ?? []
        geneticSyndromeComorbitiesCustomDetails = e.geneticSyndromeComorbitiesCustomDetails ?? []
        geneticSyndromeComorbitiesDetailsText = e.geneticSyndromeComorbitiesDetailsText
        
        infectiousComorbitiesDetails = e.infectiousComorbitiesDetails ?? []
        infectiousComorbitiesCustomDetails = e.infectiousComorbitiesCustomDetails ?? []
        infectiousComorbitiesDetailsText = e.infectiousComorbitiesDetailsText
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
        e.gynecologicalComorbities = gynecologicalComorbities
        e.androgenicalComorbities = androgenicalComorbities
        e.neurologicalComorbities = neurologicalComorbities
        e.infectiousComorbities = infectiousComorbities
        e.oncologicComorbities = oncologicComorbities
        e.geneticSyndrome = geneticSyndrome
        e.healthyPatient = healthyPatient
        //newSection
        e.oncologyDetails = oncologyDetails
        e.cardiologyDetails = cardiologyDetails
        e.respiratoryDetails = respiratoryDetails
        
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
        
        e.genitourologicalComorbitiesDetails = genitourologicalComorbitiesDetails
        e.genitourologicalComorbitiesCustomDetails = genitourologicalComorbitiesCustomDetails
        e.genitourologicalComorbitiesDetailsText = genitourologicalComorbitiesDetailsText
        e.gynecologicalComorbitiesDetails = gynecologicalComorbitiesDetails
        e.gynecologicalComorbitiesCustomDetails = gynecologicalComorbitiesCustomDetails
        e.gynecologicalComorbitiesDetailsText = gynecologicalComorbitiesDetailsText
        e.androgenicalComorbitiesDetails = androgenicalComorbitiesDetails
        e.androgenicalComorbitiesCustomDetails = androgenicalComorbitiesCustomDetails
        e.androgenicalComorbitiesDetailsText = androgenicalComorbitiesDetailsText
        e.neurologicalComorbitiesDetails = neurologicalComorbitiesDetails
        e.neurologicalComorbitiesCustomDetails = neurologicalComorbitiesCustomDetails
        e.neurologicalComorbitiesDetailsText = neurologicalComorbitiesDetailsText
        e.geneticSyndromeComorbitiesDetails = geneticSyndromeComorbitiesDetails
        e.geneticSyndromeComorbitiesCustomDetails = geneticSyndromeComorbitiesCustomDetails
        e.geneticSyndromeComorbitiesDetailsText = geneticSyndromeComorbitiesDetailsText
        
        e.infectiousComorbitiesDetails = infectiousComorbitiesDetails
        e.infectiousComorbitiesCustomDetails = infectiousComorbitiesCustomDetails
        e.infectiousComorbitiesDetailsText = infectiousComorbitiesDetailsText
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
            //isInfantComorbitiesDetails = [.healthy]
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
    
    func genitourologicalComorbitiesVisibility() {
        if genitourologicalComorbities == false {
            genitourologicalComorbitiesDetails = []
            genitourologicalComorbitiesDetailsText = ""
            genitourologicalComorbitiesCustomDetails = []
        }
    }
    func gynecologicalComorbitiesVisibility() {
        if gynecologicalComorbities == false {
            gynecologicalComorbitiesDetails = []
            gynecologicalComorbitiesDetailsText = ""
            gynecologicalComorbitiesCustomDetails = []
        }
    }
    func androgenicalComorbitiesVisibility() {
        if androgenicalComorbities == false {
            androgenicalComorbitiesDetails = []
            androgenicalComorbitiesDetailsText = ""
            androgenicalComorbitiesCustomDetails = []
        }
    }
    func neurologicalComorbitiesVisibility() {
        if neurologicalComorbities == false {
            neurologicalComorbitiesDetails = []
            neurologicalComorbitiesDetailsText = ""
            neurologicalComorbitiesCustomDetails = []
        }
    }
    func infectiousComorbitiesVisibility() {
        if infectiousComorbities == false {
            infectiousComorbitiesDetails = []
            infectiousComorbitiesDetailsText = ""
            infectiousComorbitiesCustomDetails = []
        }
    }
    func geneticSyndromeVisibility() {
        if geneticSyndrome == false {
            geneticSyndromeComorbitiesDetails = []
            geneticSyndromeComorbitiesDetailsText = ""
            geneticSyndromeComorbitiesCustomDetails = []
        }
    }
    
    func healthyPatientComorbities() {
        cardiacComorbities = false
        respiratoryComorbities = false
        endocrineComorbities = false
        gastrointestinalComorbities = false
        hematologicalComorbities = false
        imunologicalComorbities = false
        musculoskeletalComorbities = false
        genitourologicalComorbities = false
        oncologicComorbities = false
        infectiousComorbities = false
        gynecologicalComorbities = false
        androgenicalComorbities = false
        neurologicalComorbities = false
        geneticSyndrome = false
        if isInfant == true {
            isInfantComorbitiesDetails = [.healthy]
        }
        if isPregnant == true {
            isPregnantComorbitiesDetails = [.healthy]
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
    func addGenitourologicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !genitourologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        genitourologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeGenitourologicalComorbitiesCustomDetails(at index: Int) {
        guard genitourologicalComorbitiesCustomDetails.indices.contains(index) else { return }
        genitourologicalComorbitiesCustomDetails.remove(at: index)
    }
    func addGynecologicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !gynecologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        gynecologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeGynecologicalComorbitiesCustomDetails(at index: Int) {
        guard gynecologicalComorbitiesCustomDetails.indices.contains(index) else { return }
        gynecologicalComorbitiesCustomDetails.remove(at: index)
    }
    func addAndrogenicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !androgenicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        androgenicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeAndrogenicalComorbitiesCustomDetails(at index: Int) {
        guard androgenicalComorbitiesCustomDetails.indices.contains(index) else { return }
        androgenicalComorbitiesCustomDetails.remove(at: index)
    }
    func addNeurologicalComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !neurologicalComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        neurologicalComorbitiesCustomDetails.append(trimmed)
    }
    func removeNeurologicalComorbitiesCustomDetails(at index: Int) {
        guard neurologicalComorbitiesCustomDetails.indices.contains(index) else { return }
        neurologicalComorbitiesCustomDetails.remove(at: index)
    }
    func addInfectiousComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !infectiousComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        infectiousComorbitiesCustomDetails.append(trimmed)
    }

    func removeInfectiousComorbitiesCustomDetails(at index: Int) {
        guard infectiousComorbitiesCustomDetails.indices.contains(index) else { return }
        infectiousComorbitiesCustomDetails.remove(at: index)
    }
    
    func addGeneticSyndromeComorbitiesCustomDetails(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !geneticSyndromeComorbitiesCustomDetails.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        geneticSyndromeComorbitiesCustomDetails.append(trimmed)
    }
    func removeGeneticSyndromeComorbitiesCustomDetails(at index: Int) {
        guard geneticSyndromeComorbitiesCustomDetails.indices.contains(index) else { return }
        geneticSyndromeComorbitiesCustomDetails.remove(at: index)
    }
    
    
    
    func applyHealthyPatient() {
        healthyPatient = true
        cardiacComorbities = false
        respiratoryComorbities = false
        endocrineComorbities = false
        gastrointestinalComorbities = false
        hematologicalComorbities = false
        imunologicalComorbities = false
        musculoskeletalComorbities = false
        genitourologicalComorbities = false
        infectiousComorbities = false
        gynecologicalComorbities = false
        oncologicComorbities = false
        androgenicalComorbities = false
        neurologicalComorbities = false
        geneticSyndrome = false
        
        
        if isInfant {
            isInfantComorbitiesDetails = [.healthy]
        }
        
        
        if isPregnant {
            isPregnantComorbitiesDetails = [.healthy]
        }
    }
    
    var hasAnyInfo: Bool {
        return healthyPatient ||
               cardiacComorbities || respiratoryComorbities ||
               endocrineComorbities || gastrointestinalComorbities ||
               hematologicalComorbities || imunologicalComorbities ||
               musculoskeletalComorbities || genitourologicalComorbities ||
               gynecologicalComorbities || androgenicalComorbities ||
               neurologicalComorbities || geneticSyndrome ||
               oncologicComorbities || infectiousComorbities
    }
    
    var canSave: Bool {
        
        guard hasAnyInfo else { return false }
        
        if healthyPatient {
            if isInfant && !(isInfantComorbitiesDetails == [.healthy]) { return false }
            if isPregnant && !(isPregnantComorbitiesDetails == [.healthy]) { return false }
            
            return !cardiacComorbities &&
                   !respiratoryComorbities &&
                   !endocrineComorbities &&
                   !gastrointestinalComorbities &&
                   !hematologicalComorbities &&
                   !imunologicalComorbities &&
                   !musculoskeletalComorbities &&
                   !genitourologicalComorbities &&
                   !gynecologicalComorbities &&
                   !infectiousComorbities &&
                   !oncologicComorbities &&
                   !androgenicalComorbities &&
                   !neurologicalComorbities &&
                   !geneticSyndrome
        } else {
            if isInfant && (isInfantComorbitiesDetails?.isEmpty ?? true) && isInfantCustomDetails.isEmpty { return false }
            if isPregnant && (isPregnantComorbitiesDetails?.isEmpty ?? true) && isPregnantCustomDetails.isEmpty { return false }
            if cardiacComorbities && (cardiacComorbitiesDetails?.isEmpty ?? true) && cardiacComorbitiesCustomDetails.isEmpty { return false }
            if respiratoryComorbities && (respiratoryComorbitiesDetails?.isEmpty ?? true) && respiratoryComorbitiesCustomDetails.isEmpty { return false }
            if endocrineComorbities && (endocrineComorbitiesDetails?.isEmpty ?? true) && endocrineComorbitiesCustomDetails.isEmpty { return false }
            if gastrointestinalComorbities && (gastrointestinalComorbitiesDetails?.isEmpty ?? true) && gastrointestinalComorbitiesCustomDetails.isEmpty { return false }
            if hematologicalComorbities && (hematologicalComorbitiesDetails?.isEmpty ?? true) && hematologicalComorbitiesCustomDetails.isEmpty { return false }
            if imunologicalComorbities && (imunologicalComorbitiesDetails?.isEmpty ?? true) && imunologicalComorbitiesCustomDetails.isEmpty { return false }
            if musculoskeletalComorbities && (musculoskeletalComorbitiesDetails?.isEmpty ?? true) && musculoskeletalComorbitiesCustomDetails.isEmpty { return false }
            if genitourologicalComorbities && (genitourologicalComorbitiesDetails?.isEmpty ?? true) && genitourologicalComorbitiesCustomDetails.isEmpty { return false }
            if gynecologicalComorbities && (gynecologicalComorbitiesDetails?.isEmpty ?? true) && gynecologicalComorbitiesCustomDetails.isEmpty { return false }
            if androgenicalComorbities && (androgenicalComorbitiesDetails?.isEmpty ?? true) && androgenicalComorbitiesCustomDetails.isEmpty { return false }
            if neurologicalComorbities && (neurologicalComorbitiesDetails?.isEmpty ?? true) && neurologicalComorbitiesCustomDetails.isEmpty { return false }
            if geneticSyndrome && (geneticSyndromeComorbitiesDetails?.isEmpty ?? true) && geneticSyndromeComorbitiesCustomDetails.isEmpty { return false }
            
            return true
        }
    }
    
    var validationMessages: [String] {
        var messages: [String] = []
        if !hasAnyInfo {
            messages.append("Selecione se paciente saudável ou aponte um sistema com comorbidades")
            return messages
        }

        if healthyPatient {
            if isInfant && !(isInfantComorbitiesDetails == [.healthy]) {
                messages.append("Paciente saudável: marque apenas 'Saudável' em Infantil")
            }
            if isPregnant && !(isPregnantComorbitiesDetails == [.healthy]) {
                messages.append("Paciente saudável: marque apenas 'Saudável' em Gestante")
            }
            if cardiacComorbities || respiratoryComorbities || endocrineComorbities || gastrointestinalComorbities || hematologicalComorbities || imunologicalComorbities || musculoskeletalComorbities || genitourologicalComorbities || gynecologicalComorbities || androgenicalComorbities || neurologicalComorbities || geneticSyndrome {
                messages.append("Paciente saudável não pode ter outras comorbidades")
            }
        } else {
            if isInfant && (isInfantComorbitiesDetails?.isEmpty ?? true) && isInfantCustomDetails.isEmpty {
                messages.append("Adicione detalhes para Infantil")
            }
            if isPregnant && (isPregnantComorbitiesDetails?.isEmpty ?? true) && isPregnantCustomDetails.isEmpty {
                messages.append("Adicione detalhes para Gestante")
            }
            if cardiacComorbities && (cardiacComorbitiesDetails?.isEmpty ?? true) && cardiacComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades cardíacas")
            }
            if respiratoryComorbities && (respiratoryComorbitiesDetails?.isEmpty ?? true) && respiratoryComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades respiratórias")
            }
            if endocrineComorbities && (endocrineComorbitiesDetails?.isEmpty ?? true) && endocrineComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades endócrinas")
            }
            if gastrointestinalComorbities && (gastrointestinalComorbitiesDetails?.isEmpty ?? true) && gastrointestinalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades do trato gastrointestinais")
            }
            if hematologicalComorbities && (hematologicalComorbitiesDetails?.isEmpty ?? true) && hematologicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades hematológicas")
            }
            if imunologicalComorbities && (imunologicalComorbitiesDetails?.isEmpty ?? true) && imunologicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades imunológicas")
            }
            if musculoskeletalComorbities && (musculoskeletalComorbitiesDetails?.isEmpty ?? true) && musculoskeletalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades do sistema muscular e articulares")
            }
            if genitourologicalComorbities && (genitourologicalComorbitiesDetails?.isEmpty ?? true) && genitourologicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades do sistema genitourinário")
            }
            if gynecologicalComorbities && (gynecologicalComorbitiesDetails?.isEmpty ?? true) && gynecologicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades ginecológicas")
            }
            if androgenicalComorbities && (androgenicalComorbitiesDetails?.isEmpty ?? true) && androgenicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades androgenológicas")
            }
            if neurologicalComorbities && (neurologicalComorbitiesDetails?.isEmpty ?? true) && neurologicalComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para comorbidades neurológicas")
            }
            if geneticSyndrome && (geneticSyndromeComorbitiesDetails?.isEmpty ?? true) && geneticSyndromeComorbitiesCustomDetails.isEmpty {
                messages.append("Adicione detalhes para Síndromes Genéticas")
            }
        }

        return messages
    }
    
    var showValidationMessage: Bool {
        !validationMessages.isEmpty
    }
    
    
}
