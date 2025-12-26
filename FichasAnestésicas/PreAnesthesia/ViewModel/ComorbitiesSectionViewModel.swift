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
    var infectiousComorbities = false { didSet { infectiousComorbitiesVisibility() } }
    var oncologicComorbities = false { didSet { oncologicComorbitiesVisibility() } }
    var geneticSyndrome = false {didSet { geneticSyndromeVisibility() } }
    var healthyPatient = false {
        didSet {
            if healthyPatient == true && oldValue == false {
                healthyPatientComorbities()
            }
        }
    }
    
    //section
    var pregnancyDetails: [PregnancyDetail] = []
    var infantDetails: [InfantDetail] = []
    
    var oncologyDetails: [OncologyComorbidityDetail] = []
    var cardiologyDetails: [CardiologyComorbidityDetail] = []
    var respiratoryDetails: [RespiratoryComorbidityDetail] = []
    var endocrineDetails: [EndocrineComorbidityDetail] = []
    var gastroIntestinalDetails: [GastroIntestinalComorbidityDetail] = []
    var hematologyDetails: [HematologyComorbidityDetail] = []
    var imunologyDetails: [ImunologyComorbidityDetail] = []
    var musculoskeletalDetails: [MusculoskeletalComorbidityDetail] = []
    var genitoUrinaryDetails: [GenitoUrinaryComorbidityDetail] = []
    var gynecologyDetails: [GynecologicComorbityDetail] = []
    var androgenyDetails: [AndrogenicComorbityDetail] = []
    var neurologyDetails: [NeurologyComorbityDetail] = []
    var infectiousDetails: [InfectiousComorbityDetail] = []
    var geneticSyndromeDetails: [GeneticSyndromeDetail] = []
    

    
    //one by one
    var isPregnantAge: String?

    
    
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
        pregnancyDetails = e.pregnancyDetails ?? []
        infantDetails = e.infantDetails ?? []
        
        oncologyDetails = e.oncologyDetails ?? []
        cardiologyDetails = e.cardiologyDetails ?? []
        respiratoryDetails = e.respiratoryDetails ?? []
        endocrineDetails = e.endocrineDetails ?? []
        gastroIntestinalDetails = e.gastroIntestinalDetails ?? []
        hematologyDetails = e.hematologyDetails ?? []
        imunologyDetails = e.imunologyDetails ?? []
        musculoskeletalDetails = e.musculoskeletalDetails ?? []
        genitoUrinaryDetails = e.genitoUrinaryDetails ?? []
        gynecologyDetails = e.gynecologyDetails ?? []
        androgenyDetails = e.androgenyDetails ?? []
        neurologyDetails = e.neurologyDetails ?? []
        infectiousDetails = e.infectiousDetails ?? []
        geneticSyndromeDetails = e.geneticSyndromeDetails ?? []
        
        
        //one by one
        isPregnantAge = e.isPregnantAge

        
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
        e.pregnancyDetails = pregnancyDetails
        e.infantDetails = infantDetails
        
        e.oncologyDetails = oncologyDetails
        e.cardiologyDetails = cardiologyDetails
        e.respiratoryDetails = respiratoryDetails
        e.endocrineDetails = endocrineDetails
        e.gastroIntestinalDetails = gastroIntestinalDetails
        e.hematologyDetails = hematologyDetails
        e.imunologyDetails = imunologyDetails
        e.musculoskeletalDetails = musculoskeletalDetails
        e.genitoUrinaryDetails = genitoUrinaryDetails
        e.gynecologyDetails = gynecologyDetails
        e.androgenyDetails = androgenyDetails
        e.neurologyDetails = neurologyDetails
        e.infectiousDetails = infectiousDetails
        e.geneticSyndromeDetails = geneticSyndromeDetails
        
        
        
        //one by one
        e.isPregnantAge = isPregnantAge
        
    }
    
    func isPregnantVisibility(patientSex: Sex) {
        if patientSex == .male {
            isPregnant = false
        }
    }
    func isPregnantComorbitiesVisibility() {
        if isPregnant == false {
            isPregnantAge = ""
            pregnancyDetails = []
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
            infantDetails = []
        }
    }
    
    func cardiacComorbitiesVisibility() {
        if cardiacComorbities == false {
            cardiologyDetails = []
        }
    }
    func respiratoryComorbitiesVisibility() {
        if respiratoryComorbities == false {
            respiratoryDetails = []
        }
    }
    func endocrineComorbitiesVisibility() {
        if endocrineComorbities == false {
            endocrineDetails = []
        }
    }
    func gastrointestinalComorbitiesVisibility() {
        if gastrointestinalComorbities == false {
            gastroIntestinalDetails = []
        }
    }
    func hematologicalComorbitiesVisibility() {
        if hematologicalComorbities == false {
            hematologyDetails = []
        }
    }
    func imunologicalComorbitiesVisibility() {
        if imunologicalComorbities == false {
            imunologyDetails = []
        }
    }
    func musculoskeletalComorbitiesVisibility() {
        if musculoskeletalComorbities == false {
            musculoskeletalDetails = []
        }
    }
    
    func genitourologicalComorbitiesVisibility() {
        if genitourologicalComorbities == false {
            genitoUrinaryDetails = []
        }
    }
    func gynecologicalComorbitiesVisibility() {
        if gynecologicalComorbities == false {
            gynecologyDetails = []
        }
    }
    func androgenicalComorbitiesVisibility() {
        if androgenicalComorbities == false {
            androgenyDetails = []
        }
    }
    func neurologicalComorbitiesVisibility() {
        if neurologicalComorbities == false {
            neurologyDetails = []
        }
    }
    func infectiousComorbitiesVisibility() {
        if infectiousComorbities == false {
            infectiousDetails = []
        }
    }
    func oncologicComorbitiesVisibility() {
        if oncologicComorbities == false {
            oncologyDetails = []
        }
    }
    func geneticSyndromeVisibility() {
        if geneticSyndrome == false {
            geneticSyndromeDetails = []
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
            infantDetails = [InfantDetail(type: .healthy, customName: nil)]
        }
        if isPregnant == true {
            pregnancyDetails = [PregnancyDetail(type: .healthy, customName: nil)]
        }
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
            infantDetails = [InfantDetail(type: .healthy, customName: nil)]
        }

        if isPregnant {
            pregnancyDetails = [PregnancyDetail(type: .healthy, customName: nil)]
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
    
    private func hasValidCardiologyDetails() -> Bool {
        cardiologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }

    private func hasValidRespiratoryDetails() -> Bool {
        respiratoryDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidEndocrineDetails() -> Bool {
        endocrineDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidGastroIntestinalDetails() -> Bool {
        gastroIntestinalDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidHematologyDetails() -> Bool {
        hematologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidImunologyDetails() -> Bool {
        imunologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidMusculoskeletalDetails() -> Bool {
        musculoskeletalDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidGenitoUrinaryDetails() -> Bool {
        genitoUrinaryDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidGynecologyDetails() -> Bool {
        gynecologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidAndrogenyDetails() -> Bool {
        androgenyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidNeurologyDetails() -> Bool {
        neurologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidInfectiousDetails() -> Bool {
        infectiousDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidOncologyDetails() -> Bool {
        oncologyDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    private func hasValidGeneticDetails() -> Bool {
        geneticSyndromeDetails.contains {
            $0.type != nil ||
            !($0.customName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
    }
    
    var canSave: Bool {
        
        guard hasAnyInfo else { return false }
        
        if healthyPatient {
//            if isInfant && !(isInfantComorbitiesDetails == [.healthy]) { return false }
//            if isPregnant && !(isPregnantComorbitiesDetails == [.healthy]) { return false }
            
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
            !geneticSyndrome &&
            cardiologyDetails.isEmpty &&
            respiratoryDetails.isEmpty
        } else {
//            if isInfant && (isInfantComorbitiesDetails?.isEmpty ?? true) && isInfantCustomDetails.isEmpty { return false }
//            if isPregnant && (isPregnantComorbitiesDetails?.isEmpty ?? true) && isPregnantCustomDetails.isEmpty { return false }
            if cardiacComorbities && !hasValidCardiologyDetails() {return false}
            if respiratoryComorbities && !hasValidRespiratoryDetails() {return false}
            if endocrineComorbities && !hasValidEndocrineDetails() {return false}
            if gastrointestinalComorbities && !hasValidGastroIntestinalDetails() {return false}
            if hematologicalComorbities && !hasValidHematologyDetails() {return false}
            if imunologicalComorbities && !hasValidImunologyDetails() {return false}
            if musculoskeletalComorbities && !hasValidMusculoskeletalDetails() {return false}
            if genitourologicalComorbities && !hasValidGenitoUrinaryDetails() {return false}
            if gynecologicalComorbities && !hasValidGynecologyDetails() {return false}
            if androgenicalComorbities && !hasValidAndrogenyDetails() {return false}
            if neurologicalComorbities && !hasValidNeurologyDetails() {return false}
            if oncologicComorbities && !hasValidOncologyDetails() {return false}
            if infectiousComorbities && !hasValidInfectiousDetails() {return false}
            if geneticSyndrome && !hasValidGeneticDetails() {return false}
            
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
//            if isInfant && !(isInfantComorbitiesDetails == [.healthy]) {
//                messages.append("Paciente saudável: marque apenas 'Saudável' em Infantil")
//            }
//            if isPregnant && !(isPregnantComorbitiesDetails == [.healthy]) {
//                messages.append("Paciente saudável: marque apenas 'Saudável' em Gestante")
//            }
            if cardiacComorbities || respiratoryComorbities || endocrineComorbities || gastrointestinalComorbities || hematologicalComorbities || imunologicalComorbities || musculoskeletalComorbities || genitourologicalComorbities || gynecologicalComorbities || androgenicalComorbities || neurologicalComorbities || geneticSyndrome {
                messages.append("Paciente saudável não pode ter outras comorbidades")
            }
        } else {
//            if isInfant && (isInfantComorbitiesDetails?.isEmpty ?? true) && isInfantCustomDetails.isEmpty {
//                messages.append("Adicione detalhes para Infantil")
//            }
//            if isPregnant && (isPregnantComorbitiesDetails?.isEmpty ?? true) && isPregnantCustomDetails.isEmpty {
//                messages.append("Adicione detalhes para Gestante")
//            }
            if cardiacComorbities && !hasValidCardiologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade cardíaca")
            }
            if respiratoryComorbities && !hasValidRespiratoryDetails() {
                messages.append("Adicione pelo menos uma comorbidade respiratória")
            }
            if endocrineComorbities && !hasValidRespiratoryDetails() {
                messages.append("Adicione pelo menos uma comorbidade endócrinas")
            }
            if gastrointestinalComorbities && !hasValidGastroIntestinalDetails() {
                messages.append("Adicione pelo menos uma comorbidade gastrointestinal")
            }
            if hematologicalComorbities && !hasValidHematologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade hematológica")
            }
            if imunologicalComorbities && !hasValidImunologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade imunológica")
            }
            if musculoskeletalComorbities && !hasValidMusculoskeletalDetails() {
                messages.append("Adicione pelo menos uma comorbidade músculo-esquelética")
            }
            if genitourologicalComorbities && !hasValidMusculoskeletalDetails() {
                messages.append("Adicione pelo menos uma comorbidade genitourinária")
            }
            if gynecologicalComorbities && !hasValidGynecologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade ginecológica")
            }
            if androgenicalComorbities && !hasValidAndrogenyDetails() {
                messages.append("Adicione pelo menos uma comorbidade andrológicas")
            }
            if neurologicalComorbities && !hasValidNeurologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade neurológica")
            }
            if infectiousComorbities && !hasValidInfectiousDetails() {
                messages.append("Adicione pelo menos uma comorbidade infecciosas")
            }
            if oncologicComorbities && !hasValidOncologyDetails() {
                messages.append("Adicione pelo menos uma comorbidade oncológica")
            }
            if geneticSyndrome && !hasValidGeneticDetails() {
                messages.append("Adicione pelo menos uma Síndrome Genética")
            }
        }

        return messages
    }
    
    var showValidationMessage: Bool {
        !validationMessages.isEmpty
    }
    
    
}

