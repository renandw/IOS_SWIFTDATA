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
