//
//  EnumHelpersPreAnesthesia.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 25/11/25.
//
import SwiftUI

public enum ClearenceStatus: String, Codable, CaseIterable {
    case able
    case reevaluate
    case unable
    
    var displayName: String {
        switch self {
        case .able:
            return "Liberado"
        case .reevaluate:
            return "Liberado com ressalvas"
        case .unable:
            return "Não Liberado"
        }
    }
    
    var reportDisplayName: String {
        switch self {
        case .able:
            return "liberado sem ressalvas"
        case .reevaluate:
            return "liberado com ressalvas"
        case .unable:
            return "contraindicado ao ato anestésico"
        }
    }
    
    var color: Color {
        switch self {
        case .able:       .green
        case .reevaluate: .yellow
        case .unable:     .red
        }
    }
        
    var icon: String {
        switch self {
        case .able:       "checkmark.circle.fill"
        case .reevaluate: "exclamationmark.circle.fill"
        case .unable:     "xmark.circle.fill"
        }
    }
}

public enum RecommendationForRevaluationStatus: String, Codable, CaseIterable {
    case posIntensiveUnitCare
    case posIAMEnzimes
    case dialisesPre
    case asmaControl
    case IVASevaluation
    case labsImgRevaluation
    
    var displayName: String {
        switch self {
        case .posIntensiveUnitCare:       "UTI"
        case .posIAMEnzimes:              "Enzimas Cardíacas"
        case .dialisesPre:                "Diálise Pré-procedimento"
        case .asmaControl:                "Broncodilatadores"
        case .IVASevaluation:             "Reavaliação de IVAS"
        case .labsImgRevaluation:         "Reavaliação de exames"
        }
    }
    
    var reportDisplayName: String {
        switch self {
        case .posIntensiveUnitCare:       "pós operatório em UTI"
        case .posIAMEnzimes:              "seriar enzimas cardíacas pós procedimento"
        case .dialisesPre:                "diálise pré-procedimento recomendada"
        case .asmaControl:                "controle de quadro asmático com broncodilatadores em centro cirúrgico"
        case .IVASevaluation:             "reavaliação de quadro de IVAS em centro cirúrgico"
        case .labsImgRevaluation:         "reavaliar exames alterados em centro cirúrgico"
        }
    }
}

public enum CardiologicComorbities: String, Codable, CaseIterable {
    case hypercholesterolemia
    case hypertension
    case isquemicCardiopathy
    case arryhtmia
    case valvopathy
    case heartFailure
    case congenitalHeartDisease
    case pericarditis
    case cardiomyopathy
    
    var displayName: String {
        switch self {
        case .hypercholesterolemia:      "Dislipidemia"
        case .hypertension:              "HAS"
        case .isquemicCardiopathy:       "Miocardiopatia Isquêmica"
        case .arryhtmia:                 "Arritmia"
        case .valvopathy:                "Valvopatia"
        case .heartFailure:              "Insuficiência Cardíaca"
        case .congenitalHeartDisease:    "Cardiopatia Congênita"
        case .pericarditis:              "Pericardite"
        case .cardiomyopathy:            "Miocardiopatia"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .hypercholesterolemia:      "Dislipidemia"
        case .hypertension:              "Hipertensão Arterial Sistêmica"
        case .isquemicCardiopathy:       "Miocardiopatia Isquêmica"
        case .arryhtmia:                 "Arritmia"
        case .valvopathy:                "Valvopatia"
        case .heartFailure:              "Insuficiência Cardíaca"
        case .congenitalHeartDisease:    "Cardiopatia Congênita"
        case .pericarditis:              "Pericardite"
        case .cardiomyopathy:            "Miocardiopatia"
        }
    }
}

public enum InfantComorbities: String, Codable, CaseIterable {
    case prematureBirth
    case lowWeightAtBirth
    case fetalGrowthRestriction
    case fetalAbnormality
    case cSectionBirth
    case naturalBirth
    case birthComplications
    case healthy
    
    var displayName: String {
        switch self {
        case .prematureBirth:           "Prematuridade"
        case .lowWeightAtBirth:         "Baixo Peso ao Nascer"
        case .fetalGrowthRestriction:   "Crescimento Fetal Restrito"
        case .fetalAbnormality:         "Mal formação fetal"
        case .cSectionBirth:            "Parto Cesárea"
        case .naturalBirth:             "Parto Natural"
        case .birthComplications:       "Complicações do Parto"
        case .healthy:                  "Saudável"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .prematureBirth:           "Prematuridade"
        case .lowWeightAtBirth:         "Baixo Peso ao Nascer"
        case .fetalGrowthRestriction:   "Restrição de Crescimento Fetal"
        case .fetalAbnormality:         "Mal formação fetal"
        case .cSectionBirth:            "Parto Cesárea"
        case .naturalBirth:             "Parto Natural"
        case .birthComplications:       "Complicações do Parto"
        case .healthy:                   "Saudável"
        }
    }
}

public enum PregnantComorbities: String, Codable, CaseIterable {
    case diabetesGestationalis
    case hypartensionGestationalis
    case ectopicGestationalis
    case hellpSyndrome
    case eclapsisGestationalis
    case placentaPrevia
    case prematureLabor
    case healthy
    
    var displayName: String {
        switch self {
        case .diabetesGestationalis:           "Diabetes Gestacional"
        case .hypartensionGestationalis:       "Hipertensão Gestacional"
        case .ectopicGestationalis:            "Gestação Ectópica"
        case .hellpSyndrome:                   "Síndrome Hellp"
        case .eclapsisGestationalis:           "Ecâmpsia"
        case .placentaPrevia:                  "Acretismo Placentário"
        case .prematureLabor:                  "Trabalho de Parto Prematuro"
        case .healthy:                         "Saudável"
        }
    }
}

public enum RespiratoryComorbities: String, Codable, CaseIterable {
    case asthma
    case chronicBronchitis
    case emphysema
    case pneumonia
    case tuberculosis
    case DPCO
    case fibrosis
    case estenosisAirway
    case sleepDisorders
    
    var displayName: String {
        switch self {
        case .asthma:                         "Asma"
        case .chronicBronchitis:              "Bronquite Crónica"
        case .emphysema:                      "Emfísema"
        case .pneumonia:                      "Pneumonia"
        case .tuberculosis:                   "Tuberculose"
        case .DPCO:                           "DPOC"
        case .fibrosis:                       "Fibrose Pulmonar"
        case .estenosisAirway:                "Estenose Via Respiratória"
        case .sleepDisorders:                 "Distúrbios do Sono"
        }
    }
}

public enum EndocrineComorbities: String, Codable, CaseIterable {
    case diabetesType1
    case diabetesType2
    case hypothyroidism
    case cushingSyndrome
    case hyperthyroidism
    case methabolicSyndrome
    case hypogonadism
    
    var displayName: String {
        switch self {
        case .diabetesType1:                  "Diabetes T1"
        case .diabetesType2:                  "Diabetes T2"
        case .hypothyroidism:                 "Hipotiroidismo"
        case .cushingSyndrome:                "Síndrome de Cushing"
        case .hyperthyroidism:                "Hipertireoidismo"
        case .methabolicSyndrome:             "Síndrome Metabólica"
        case .hypogonadism:                   "Hipogonadismo"
        }
    }
}

public enum GastrointestinalComorbities: String, Codable, CaseIterable {
    case gastroesophagealReflux
    case crohnsDisease
    case colelitiasis
    case celiacDisease
    case fattyLiverDisease
    case cirrosis
    case diverticulitis
    case gastroparesis
    case varisisEsofagea
    
    var displayName: String {
        switch self {
        case .gastroesophagealReflux:         "Refluxo Gastroesofágico"
        case .crohnsDisease:                  "Doença de Crohn"
        case .colelitiasis:                   "Colelitíase"
        case .celiacDisease:                  "Doença Celíaca"
        case .fattyLiverDisease:              "Esteatose Hepática"
        case .cirrosis:                       "Cirrose Hepática"
        case .diverticulitis:                 "Diverticulite"
        case .gastroparesis:                  "Gastroparesia"
        case .varisisEsofagea:                "Varizes Esofágicas"
            
        }
    }
}

public enum HematologicComorbities: String, Codable, CaseIterable {
    case anemia
    case sickleCell
    case thalassemia
    case hemophilias
    case vonWillebrandDisease
    case thrombocytopenia
    case anticoagulantUse
    case thrombophilia
    case leukemia
    case lymphoma
    
    var displayName: String {
        switch self {
        case .anemia:                         "Anemia"
        case .sickleCell:                     "Anemia Falciforme"
        case .thalassemia:                    "Talassemia"
        case .hemophilias:                    "Hemofilia"
        case .vonWillebrandDisease:           "Doença de von Willebrand"
        case .thrombocytopenia:               "Trombocitopenia"
        case .anticoagulantUse:               "Uso de Anticoagulantes"
        case .thrombophilia:                  "Trombofilia"
        case .leukemia:                       "Leucemia"
        case .lymphoma:                       "Linfoma"
        }
    }
}

public enum ImmunologicComorbities: String, Codable, CaseIterable {
    case lupus
    case rheumatoidArthritis
    case organTransplant
    case immunosuppressiveTherapy
    case multipleMyeloma
    case vasculitis
    case psoriasis
    case inflammatoryBowelDisease
    
    var displayName: String {
        switch self {
        case .lupus:                          "Lúpus Eritematoso Sistêmico"
        case .rheumatoidArthritis:            "Artrite Reumatoide"
        case .organTransplant:                "Transplante de Órgão"
        case .immunosuppressiveTherapy:       "Terapia Imunossupressora"
        case .multipleMyeloma:                "Mieloma Múltiplo"
        case .vasculitis:                     "Vasculite"
        case .psoriasis:                      "Psoríase"
        case .inflammatoryBowelDisease:       "Doença Inflamatória Intestinal"
        }
    }
}

public enum MusculoskeletalComorbities: String, Codable, CaseIterable {
    case osteoarthritis
    case ankylosingSpondylitis
    case kyphoscoliosis
    case muscularDystrophy
    case myastheniaGravis
    case osteoporosis
    case fibromyalgia
    
    var displayName: String {
        switch self {
        case .osteoarthritis:                 "Osteoartrite"
        case .ankylosingSpondylitis:          "Espondilite Anquilosante"
        case .kyphoscoliosis:                 "Cifoescoliose"
        case .muscularDystrophy:              "Distrofia Muscular"
        case .myastheniaGravis:               "Miastenia Gravis"
        case .osteoporosis:                   "Osteoporose"
        case .fibromyalgia:                   "Fibromialgia"
        }
    }
}

public enum GenitourinaryComorbities: String, Codable, CaseIterable {
    case chronicKidneyDisease
    case dialysis
    case kidneyTransplant
    case nephroticSyndrome
    case anatomyAlterations
    case urolithiasis
    case polycysticKidneyDisease
    case glomerulonephritis
    case acuteKidneyInjury
    case neurogenicBladder
    case pyelonephritis
    case sdt
    
    var displayName: String {
        switch self {
        case .chronicKidneyDisease:           "Doença Renal Crônica"
        case .dialysis:                       "Diálise"
        case .kidneyTransplant:               "Transplante Renal"
        case .nephroticSyndrome:              "Síndrome Nefrótica"
        case .anatomyAlterations:             "Mal Formações Anatómicas"
        case .urolithiasis:                   "Urolitíase"
        case .polycysticKidneyDisease:        "Doença Renal Policística"
        case .glomerulonephritis:             "Glomerulonefrite"
        case .acuteKidneyInjury:              "Lesão Renal Aguda"
        case .neurogenicBladder:              "Bexiga Neurogênica"
        case .pyelonephritis:                 "Pielonefrite Crônica"
        case .sdt:                            "DST"
        }
    }
}

public enum GynecologicComorbities: String, Codable, CaseIterable {
    case polycysticOvarySyndrome
    case endometriosis
    case uterineFibroids
    case pelvicInflammatoryDisease
    case menorrhagia
    case pelvicOrganProlapse
    case chronicPelvicPain
    case ovariancCysts
    case adenomyosis
    
    var displayName: String {
        switch self {
        case .polycysticOvarySyndrome:        "Síndrome de Ovários Policísticos"
        case .endometriosis:                  "Endometriose"
        case .uterineFibroids:                "Miomatose"
        case .pelvicInflammatoryDisease:      "Doença Inflamatória Pélvica"
        case .menorrhagia:                    "Menorragia"
        case .pelvicOrganProlapse:            "Prolapso de Órgãos Pélvicos"
        case .chronicPelvicPain:              "Dor Pélvica Crônica"
        case .ovariancCysts:                  "Cistos Ovarianos"
        case .adenomyosis:                    "Adenomiose"
        }
    }
}

public enum AndrologicComorbities: String, Codable, CaseIterable {
    case benignProstaticHyperplasia
    case varicocele
    case hydrocele
    case peyronie
    case urethralStricture
    
    var displayName: String {
        switch self {
        case .benignProstaticHyperplasia:     "Hiperplasia Prostática Benigna"
        case .varicocele:                     "Varicocele"
        case .hydrocele:                      "Hidrocele"
        case .peyronie:                       "Doença de Peyronie"
        case .urethralStricture:              "Estenose Uretral"
        }
    }
}

public enum NeurologicalComorbities: String, Codable, CaseIterable {
    case stroke
    case transientIschemicAttack
    case epilepsy
    case parkinsonsDisease
    case multipleSclerosis
    case alzheimersDisease
    case guillainBarreSyndrome
    case cerebralAneurysm
    case arteriovenousMalformation
    case spinalCordInjury
    case hydrocephalus
    
    var displayName: String {
        switch self {
        case .stroke:                         "AVC"
        case .transientIschemicAttack:        "AIT"
        case .epilepsy:                       "Epilepsia"
        case .parkinsonsDisease:              "Doença de Parkinson"
        case .multipleSclerosis:              "Esclerose Múltipla"
        case .alzheimersDisease:              "Doença de Alzheimer"
        case .guillainBarreSyndrome:          "Síndrome de Guillain-Barré"
        case .cerebralAneurysm:               "Aneurisma Cerebral"
        case .arteriovenousMalformation:      "Malformação Arteriovenosa"
        case .spinalCordInjury:               "Lesão Medular"
        case .hydrocephalus:                  "Hidrocefalia"
        }
    }
}

public enum GeneticSyndrome: String, Codable, CaseIterable {
    case downSyndrome
    case turnerSyndrome
    case klinefelterSyndrome
    case marfanSyndrome
    case pierreRobinSequence
    case achondroplasia
    case osteogenesisImperfecta
    case malignantHyperthermia
    
    var displayName: String {
        switch self {
        case .downSyndrome:                   "Síndrome de Down"
        case .turnerSyndrome:                 "Síndrome de Turner"
        case .klinefelterSyndrome:            "Síndrome de Klinefelter"
        case .marfanSyndrome:                 "Síndrome de Marfan"
        case .pierreRobinSequence:            "Sequência de Pierre Robin"
        case .achondroplasia:                 "Acondroplasia"
        case .osteogenesisImperfecta:         "Osteogênese Imperfeita"
        case .malignantHyperthermia:          "Hipertermia Maligna"
        }
    }
}

public enum SurgeryHistorySpeciality: String, Codable, CaseIterable {
    case general
    case orthopedics
    case cardiac
    case neurosurgery
    case urology
    case gynecology
    case dentistry
    case ophthalmology
    case headAndNeck
    case oncology
    case thorax
    
    var displayName: String {
        switch self {
        case .general:                       "Cirurgia Geral"
        case .orthopedics:                   "Cirugia Ortopédica"
        case .cardiac:                       "Cirurgia Cardíaca"
        case .neurosurgery:                  "Neurocirurgia"
        case .urology:                       "Cirurgia Urológica"
        case .gynecology:                    "Cirurgia Ginecológica"
        case .dentistry:                     "Bucomaxilofacial"
        case .ophthalmology:                 "Cirurgia Oftalmológica"
        case .headAndNeck:                   "Cirurgia do Cabeça e Pescoço"
        case .oncology:                      "Cirurgia Oncológica"
        case .thorax:                        "Cirurgia Torácica"
        }
    }
}

public enum AnesthesiaComplicationsHistory: String, Codable, CaseIterable {
    case nausea
    case laryngospasm
    case broncospasm
    case cardiacArrest
    case neuropraxia
    case allergicReaction
    case spinalHeadache
    case difficultIntubation
    case shishivering
    case bronchoaspiration
    
    var displayName: String {
        switch self {
        case .nausea:                       "Náusea e Vômitos"
        case .laryngospasm:                 "Laringoespasmo"
        case .broncospasm:                  "Broncoespasmo"
        case .cardiacArrest:                "Parada Cardíaca"
        case .neuropraxia:                  "Neuropraxia"
        case .allergicReaction:             "Reação Alérgica"
        case .spinalHeadache:               "Cefaléia pós Raqui"
        case .difficultIntubation:          "Intubação Difícil"
        case .shishivering:                 "Tremores"
        case .bronchoaspiration:            "Bronchoaspiração"
        }
    }
}

public enum SocialHabitsAndEnvironment: String, Codable, CaseIterable {
    // Substâncias
    case alcoholConsumption
    case drugUse
    case tobaccoUse
    case tobaccoExposure
    case sedentaryLifestyle         // Sedentarismo
    case airPollutionExposure       // Exposição à poluição
    
    
    var displayName: String {
        switch self {
            // Substâncias
        case .alcoholConsumption:       "Consumo de Álcool"
        case .drugUse:                  "Uso de Drogas"
        case .tobaccoUse:               "Tabagismo"
        case .tobaccoExposure:          "Tabagismo Passivo"
        case .sedentaryLifestyle:       "Sedentarismo"
        case .airPollutionExposure:     "Exposição à Poluição"
        }
    }
}

enum ApfelScore: String, Codable, CaseIterable {
    case tobaccoUse
    case femaleSex
    case historyPONV
    case historyMotionSickness
    case postoperativeOpioids
    
    var displayName: String {
        switch self {
            // Substâncias
        case .femaleSex:                "Feminino"
        case .tobaccoUse:               "Tabagismo"
        case .historyPONV:              "História de NVPO"
        case .historyMotionSickness:    "Cinetose"
        case .postoperativeOpioids:     "Uso de opióide"
        }
    }
}


extension SocialHabitsAndEnvironment {
    func toApfelScore() -> ApfelScore? {
        switch self {
        case .tobaccoUse:
            return .tobaccoUse
        default:
            return nil
        }
    }
}

extension ApfelScore {
    func toSocialHabits() -> SocialHabitsAndEnvironment? {
        switch self {
        case .tobaccoUse:
            return .tobaccoUse
        default:
            return nil
        }
    }
}

