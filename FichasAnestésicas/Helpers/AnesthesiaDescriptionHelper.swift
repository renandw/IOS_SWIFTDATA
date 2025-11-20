
import Foundation

extension ConsciousnessKind {
    var displayName: String {
        switch self {
        case .alert:              "Alerta"
        case .drowsy:             "Sonolento"
        case .lethargic:          "Letárgico"
        case .obtunded:           "Rebaixado"
        case .responsiveToPain:   "Responde à dor"
        case .unresponsive:       "Sem resposta"
        }
    }
}

extension AirwayKind {
    var displayName: String {
        switch self {
        case .noDevice:              "Sem dispositivo"
        case .oropharyngealGuedel:   "Guedel orofaríngeo"
        case .nasopharyngeal:        "Nasofaríngeo"
        case .lma:                   "LMA"
        case .maskLMA:               "Máscara + LMA"
        case .endotrachealTube:      "Tubo orotraqueal"
        case .tracheostomy:          "Traqueostomia"
        }
    }
}

extension VentilationMode {
    var displayName: String {
        switch self {
        case .expontaneus:                   "Espontânea"
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
