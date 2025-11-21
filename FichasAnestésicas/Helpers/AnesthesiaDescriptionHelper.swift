
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
}

extension VentilationMode {
    var displayName: String {
        switch self {
        case .spontaneous:                   "Espontânea"
        case .invasiveMechanicalVentilation: "VM invasiva"
        case .nonInvasiveMechanicalVentilation: "VM não invasiva"
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
}

extension HemodynamicKind {
    var displayName: String {
        switch self {
        case .stable:               "Estável"
        case .unstable:             "Instável"
        case .compensated:          "Compensada com drogas vasoativas"
        case .unstableDespiteDrugs: "Instável c/ drogas"
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
}
