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
    
    var displayName: String {
        switch self {
        case .prematureBirth:           "Prematuridade"
        case .lowWeightAtBirth:         "Baixo Peso ao Nascer"
        case .fetalGrowthRestriction:   "Crescimento Fetal Restrito"
        case .fetalAbnormality:         "Mal formação fetal"
        case .cSectionBirth:            "Parto Cesárea"
        case .naturalBirth:             "Parto Natural"
        case .birthComplications:       "Complicações do Parto"
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
    
    var displayName: String {
        switch self {
        case .diabetesGestationalis:           "Diabetes Gestacional"
        case .hypartensionGestationalis:       "Hipertensão Gestacional"
        case .ectopicGestationalis:            "Gestação Ectópica"
        case .hellpSyndrome:                   "Síndrome Hellp"
        case .eclapsisGestationalis:           "Ecâmpsia"
        case .placentaPrevia:                  "Acretismo Placentário"
        case .prematureLabor:                  "Trabalho de Parto Prematuro"
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
        }
    }
}

public enum EndocrineComorbities: String, Codable, CaseIterable {
    case diabetesType1
    case diabetesType2
    case hypothyroidism
    case cushingSyndrome
    case polycysticOvarySyndrome
    case hyperthyroidism
    case methabolicSyndrome
    
    var displayName: String {
        switch self {
        case .diabetesType1:                  "Diabetes T1"
        case .diabetesType2:                  "Diabetes T2"
        case .hypothyroidism:                 "Hipotiroidismo"
        case .cushingSyndrome:                "Síndrome de Cushing"
        case .polycysticOvarySyndrome:        "Síndrome de Ovários Policísticos"
        case .hyperthyroidism:                "Hipertireoidismo"
        case .methabolicSyndrome:             "Síndrome Metabólica"
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
