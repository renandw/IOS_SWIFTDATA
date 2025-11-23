
import Foundation

extension ConsciousnessKind {
    func displayName(for age: Int) -> String {
        let isChild = age < 12
        switch self {
        case .alert:
            return isChild ? "ativo e reativo" : "lúcido e orientado"
            
        case .drowsy:
            return isChild ? "hipoativo e reativo" : "sonolento"
            
        case .lethargic:
            return isChild ? "hipoativo e hiporeativo" : "letárgico"
            
        case .responsiveToPain:
            return isChild ? "chora ao estimulo doloroso" : "resposta a dor"
            
        case .unresponsive:
            return isChild ? "sem resposta" : "sem resposta"
            
        case .sedated:
            return "sob efeito de sedação"
        }
    }
    func reportDisplayName(for age: Int) -> String {
        let isChild = age < 12
        switch self {
        case .alert:
            return isChild ? "ativo e reativo" : "lúcido e orientado"
            
        case .drowsy:
            return isChild ? "hipoativo e reativo" : "sonolento"
            
        case .lethargic:
            return isChild ? "hipoativo e hiporeativo" : "letárgico"
            
        case .responsiveToPain:
            return isChild ? "chora ao estimulo doloroso" : "resposta a dor"
            
        case .unresponsive:
            return isChild ? "sem resposta" : "sem resposta"
        
        case .sedated:
            return "sob efeito de sedação"
            
        }
    }
}


extension AirwayKind {
    var displayName: String {
        switch self {
        case .noDevice:              "pérvia"
        case .compromised:            "potencialmente comprometida"
        case .oropharyngealGuedel:   "guedel orofaríngeo"
        case .nasopharyngeal:        "dispositivo nasofaríngeo"
        case .lma:                   "máscara laríngea"
        case .endotrachealTube:      "Tubo orotraqueal"
        case .tracheostomy:          "Traqueostomia"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .noDevice:              "via aérea pérvia sem dispositivos"
        case .compromised:           "via aérea potencialmente comprometida"
        case .oropharyngealGuedel:   "via aérea parcialmente protegida por cânula de guedel orofaríngea"
        case .nasopharyngeal:        "via aérea parcialmente protegida por cânula de guedel nasofaríngeo"
        case .lma:                   "via aérea protegida por máscara laríngea"
        case .endotrachealTube:      "via aérea parcialmente protegida por tubo endotraqueal"
        case .tracheostomy:          "via aérea parcialmente protegida por traqueóstomo"
        }
    }
}

extension VentilationMode {
    var displayName: String {
        switch self {
        case .spontaneous:                   "Espontânea"
        case .invasiveMechanicalVentilation: "VM invasiva"
        case .nonInvasiveMechanicalVentilation: "VM não invasiva"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .spontaneous:                       "em ventilação espontânea"
        case .invasiveMechanicalVentilation:     "em ventilação mecânica invasiva"
        case .nonInvasiveMechanicalVentilation:  "em ventilação mecânica não invasiva"
            
        }
    }
}

extension MechanicalVentilationMode {
    var displayName: String {
        switch self {
        case .CPAP: "CPAP"
        case .BiPAP: "BiPAP"
        case .VCV: "VCV"
        case .PCV: "PCV"
        case .SIMV: "SIMV"
        case .PSV: "PSV"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .CPAP: "modo CPAP"
        case .BiPAP: "modo BiPAP"
        case .VCV: "modo VCV"
        case .PCV: "modo PCV"
        case .SIMV: "modo SIMV"
        case .PSV: "modo PSV"
    }
}
}

extension OxygenSupply {
    var displayName: String {
        switch self {
        case .ambientAir:       "Ar ambiente"
        case .nasalCateter:     "Cateter nasal"
        case .venturiMask:      "Máscara de Venturi"
        case .nonReinalantMask: "Máscara não reinalante"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .ambientAir:       "sob ar ambiente"
        case .nasalCateter:     "oxigênio complementar sob cateter nasal"
        case .venturiMask:      "oxigênio complementar sob máscara de Venturi"
        case .nonReinalantMask: "oxigênio complementar sob máscara não reinalante"
        }
    }
}

extension HemodynamicKind {
    var displayName: String {
        switch self {
        case .stable:               "Estável"
        case .unstable:             "Instável"
        case .compensated:          "Compensada com DVA"
        case .unstableDespiteDrugs: "Instável com DVA"
        }
    }
    var reportDisplayName: String {
        switch self {
        case .stable:               "hemodinamicamente estável"
        case .unstable:             "hemodinamicamente instável"
        case .compensated:          "hemodinamicamente estável às custas de drogas vasoativas"
        case .unstableDespiteDrugs: "hemodinamicamente instável a despeito de drogas vasoativas"
        }
    }
}

extension VeinAccessKind {
    var displayName: String {
        switch self {
        case .none:              "Nenhum"
        case .inOpRoom:          "Puncionado na SO"
        case .previouslyInserted:"Prévio"
        }
    }
    func reportDisplayName(for age: Int) -> String {
        let isChild = age < 12
        switch self {
        case .none:
            return "sem acesso venoso"
        case .inOpRoom: 
            return isChild ? "venóclise sob sedação com sevoflurano sob máscara fáciala" : "venóclise em sala"
        case .previouslyInserted:
            return "checo venóclise previamente instalado"
        }
    }
}

extension VeinGaugeKind {
    var displayName: String {
        switch self {
        case .g14: "14G"
        case .g18: "18G"
        case .g20: "20G"
        case .g22: "22G"
        case .g24: "24G"
        case .cdl: "Acesso venoso central"
        }
    }
    var reportDisplayName: String {
        switch self {
            case .g14: "14G"
            case .g18: "18G"
            case .g20: "20G"
            case .g22: "22G"
            case .g24: "24G"
            case .cdl: "cateter dúplo lúmen"
        }
    }
}
