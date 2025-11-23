//
//  AnesthesiaTechniqueKind.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 21/11/25.
//


import SwiftUI

// MARK: Patients

public enum Sex: String, Codable, CaseIterable {
    case male
    case female
    
    var sexStringDescription: String {
        switch self {
        case .male:
            return "Masculino"
        case .female:
            return "Feminino"
        }
    }
    
    var sexColor: Color {
        /// Standardized color associated with the patient's sex for SwiftUI.
        /// - Note: `.male` maps to blue; `.female` maps to pink.
        switch self {
        case .male:
            return .blue
        case .female:
            return .pink
        }
    }
    
    var sexImage: String {
        switch self {
        case .male:
            return "figure.stand"
        case .female:
            return "figure.stand.dress"
        }
    }
}

// MARK: - Cirurgias
/// cada surgery precisa estar atrelada a um patient via relatioships

public enum Status: String, Codable, CaseIterable {
    case scheduled
    case inProgress
    case finished
    case cancelled
    case notNecessary
    
    var displayName: String {
        switch self {
        case .scheduled: return "Agendada"
        case .inProgress: return "Em andamento"
        case .finished: return "Concluída"
        case .cancelled: return "Cancelada"
        case .notNecessary: return "Não Necessária"
        }
    }

    var tintColor: Color {
        switch self {
        case .scheduled: return .blue
        case .inProgress: return .orange
        case .finished: return .green
        case .cancelled: return .red
        case .notNecessary: return .gray
        }
    }

    var badgeLabel: String { "Status: \(displayName)" }

    @ViewBuilder
    var badgeView: some View {
        Text(displayName)
            .foregroundStyle(tintColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tintColor.opacity(0.15))
            .clipShape(Capsule())
    }
}

public enum SurgeryType: String, Codable, CaseIterable {
    case sus
    case convenio
}


// MARK: Anesthesia

public enum AnesthesiaTechniqueKind: String, Codable, CaseIterable {
    case geralBalanceada = "Geral Balanceada"
    case geralVenosaTotal = "Geral Venosa Total"
    case geralInalatoria = "Geral Inalatória"
    case raquianestesia = "Raquianestesia"
    case peridural = "Peridural"
    case sedacao = "Sedação"
    case bloqueioPeriferico = "Bloqueio Periférico"
    case anestesiaLocal = "Local"
    
    var displayName: String { rawValue }
}

public enum Positioning: String, Codable, CaseIterable {
    case decubitoDorsal = "Decúbito Dorsal"
    case decubitoVentral = "Decúbito Ventral"
    case decubitoLateralDireito = "Decúbito Lateral Direito"
    case decubitoLateralEsquerdo = "Decúbito Lateral Esquerdo"
    case trendelenburg = "Trendelenburg"
    case proclive = "Proclive"
    case canivete = "Canivete"
    case litotomia = "Litotomia"
    case cadeiraDePraia = "Cadeira de Praia"

}


public enum ConsciousnessKind: String, Codable, CaseIterable {
    case alert
    case drowsy
    case lethargic
    case responsiveToPain
    case unresponsive
}


public enum AirwayKind: String, Codable, CaseIterable {
    case noDevice
    case compromised
    case oropharyngealGuedel
    case nasopharyngeal
    case lma
    case endotrachealTube
    case tracheostomy
}

public enum VentilationMode: String, Codable, CaseIterable {
    case spontaneous
    case invasiveMechanicalVentilation
    case nonInvasiveMechanicalVentilation
}

public enum MechanicalVentilationMode: String, Codable, CaseIterable {
    case CPAP
    case BiPAP
    case VCV
    case PCV
    case SIMV
    case PSV
}

public enum OxygenSupply: String, Codable, CaseIterable {
    case ambientAir
    case nasalCateter
    case venturiMask
    case nonReinalantMask
}

struct AirwayDeviceInfo: Codable {
    var kind: AirwayKind
    var size: Double?
}

public enum HemodynamicKind: String, Codable, CaseIterable {
    case stable
    case unstable
    case compensated
    case unstableDespiteDrugs
}

public enum VeinAccessKind: String, Codable, CaseIterable {
    case none
    case inOpRoom
    case previouslyInserted
}

public enum VeinGaugeKind: String, Codable, CaseIterable {
        case g14 = "14g"
        case g18 = "18g"
        case g20 = "20g"
        case g22 = "22g"
        case g24 = "24g"
        case cdl = "acesso venoso central"
}

public enum ASAClassification: String, Codable, CaseIterable {
    case I
    case II
    case III
    case IV
    case V
    case VI
    case Ie
    case IIe
    case IIIe
    case IVe
    case Ve
    
    var displayName: String {
        switch self {
        case .I: return "ASA I"
        case .II: return "ASA II"
        case .III: return "ASA III"
        case .IV: return "ASA IV"
        case .V: return "ASA V"
        case .VI: return "ASA VI"
        case .Ie: return "ASA Ie"
        case .IIe: return "ASA IIe"
        case .IIIe: return "ASA IIIe"
        case .IVe: return "ASA IVe"
        case .Ve: return "ASA Ve"
        
        }
    }

    var tintColor: Color {
        switch self {
        case .I: return Color.green
        case .II: return Color.yellow
        case .III: return Color.orange
        case .IV: return Color.red
        case .V: return Color.purple
        case .VI: return Color.gray
        case .Ie: return Color.green.opacity(0.7)
        case .IIe: return Color.yellow.opacity(0.7)
        case .IIIe: return Color.orange.opacity(0.7)
        case .IVe: return Color.red.opacity(0.7)
        case .Ve: return Color.purple.opacity(0.7)
        }
    }
    @ViewBuilder
    var badgeView: some View {
        Text(displayName)
            .foregroundStyle(tintColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tintColor.opacity(0.15))
            .clipShape(Capsule())
    }

}

public enum VisualizationMethod: String, Codable, CaseIterable {
    case indirect
    case direct
    
    var DisplayName: String {
        switch self {
        case .indirect: return "Indireta"
        case .direct: return "Direta"
        }
    }
}

public enum LaringoschopyEquipment: String, Codable, CaseIterable {
    case laringoscope
    case fibroscope
    case mirrorGarcia
    case videoLaryngoscope
    
    var DisplayName: String {
        switch self {
        case .laringoscope: return "Laringoscópio"
        case .fibroscope: return "Fibroscópio"
        case .mirrorGarcia: return "Mirror de García"
        case .videoLaryngoscope: return "Videolaringoscópio"
        }
    }
}

public enum TubeCuff: String, Codable, CaseIterable {
    case with
    case without
    
    var DisplayName: String {
        switch self {
        case .with: return "Com cuff"
        case .without: return "Sem cuff"
        }
    }
}

public enum TubeRoute: String, Codable, CaseIterable {
    case nasal
    case oral
    
    var DisplayName: String {
        switch self {
        case .nasal: return "Nasal"
        case .oral: return "Oral"
        }
    }
}

public enum TubeType: String, Codable, CaseIterable {
    case common
    case aramado
    case doubleLumen
    case eNasal
    case traqueal
    
    var DisplayName: String {
        switch self {
        case .common: return "Comum"
        case .aramado: return "Aramado"
        case .doubleLumen: return "Duplo Lumen"
        case .eNasal: return "eNasal"
        case .traqueal: return "Traqueóstomo"
        }
    }
}
public enum TubeAcess: String, Codable, CaseIterable {
    case inORInserted
    case previouslyInserted
    
    var DisplayNameReport: String {
        switch self {
        case .inORInserted: return "Entubado em sala operatória"
        case .previouslyInserted: return "Recebo paciente com via aérea definitiva préviamente"
        }
    }
    var DisplayName: String {
        switch self {
        case .inORInserted: return "Via aérea definitiva em SO"
        case .previouslyInserted: return "Via aérea definitiva prévia"
        }
    }
}

enum CormackLehane: String, CaseIterable, Codable, Identifiable {
    case grade1        // glote totalmente visível
    case grade2a       // parte posterior da glote visível
    case grade2b       // apenas aritenoides / cartilagens visíveis
    case grade3        // somente epiglote visível
    case grade4        // nem epiglote visível
    
    var id: String { rawValue }
    
    var DisplayName: String {
        switch self {
        case .grade1:  return "Grau I – Glote totalmente visível"
        case .grade2a: return "Grau IIa – Parte da glote visível"
        case .grade2b: return "Grau IIb – Apenas aritenoides"
        case .grade3:  return "Grau III – Apenas epiglote"
        case .grade4:  return "Grau IV – Nada visível"
        }
    }
    
    var ShortLabel: String {
        switch self {
        case .grade1:  return "I"
        case .grade2a: return "IIa"
        case .grade2b: return "IIb"
        case .grade3:  return "III"
        case .grade4:  return "IV"
        }
    }
}

public enum SpinalAndEpiduralPosition: String, Codable, CaseIterable {
    case seated
    case lateralDecubitus
    
    var DisplayName: String {
        switch self {
        case .seated:      return "Sentado"
        case .lateralDecubitus: return "Decúbito lateral"
        }
    }
}

public enum SpinalAndEpiduralLevel: String, Codable, CaseIterable {
    case t1
    case t2
    case t3
    case t4
    case t5
    case t6
    case t7
    case t8
    case t9
    case t10
    case t11
    case t12
    case l1
    case l2
    case l3
    case l4
    case l5
    case sacral
    case coccyx

    var DisplayName: String {
        switch self {
        case .t1:  return "T1-T2"
        case .t2:  return "T2-T3"
        case .t3:  return "T3-T4"
        case .t4:  return "T4-T5"
        case .t5:  return "T5-T6"
        case .t6:  return "T6-T7"
        case .t7:  return "T7-T8"
        case .t8:  return "T8-T9"
        case .t9:  return "T9-T10"
        case .t10: return "T10-T11"
        case .t11: return "T11-T12"
        case .t12: return "T12-L1"
        case .l1:  return "L1-L2"
        case .l2:  return "L2-L3"
        case .l3:  return "L3-L4"
        case .l4:  return "L4-L5"
        case .l5:  return "L5-Sacral"
        case .sacral: return "Sacral"
        case .coccyx: return "Coccyx"
        }
    }
}
public enum SpinalAndEpiduralNeedle: String, Codable, CaseIterable {
    case whitacre
    case quincke
    case thuohy
    case thuohysoho
    case caudal
    
    var DisplayName: String {
        switch self {
            case .whitacre:  return "Whitacre"
            case .quincke:  return "Quincke"
            case .thuohy:  return "Thuohy"
            case .thuohysoho:  return "Thuohy SOHO"
            case .caudal:  return "Caudal"
        }
    }
}

public enum SpinalAndEpiduralGaugeKind: String, Codable, CaseIterable {
    case g16
    case g17
    case g18
    case g20
    case g22
    case g24
    case g25
    case g26
    case g27
    
    var DisplayName: String {
        switch self {
        case .g16:  return "16G"
        case .g17:  return "17G"
        case .g18:  return "18G"
        case .g20:  return "20G"
        case .g22:  return "22G"
        case .g24:  return "24G"
        case .g25:  return "25G"
        case .g26:  return "26G"
        case .g27:  return "27G"
        }
    }
}

public enum PeriduralTechniqueKind: String, Codable, CaseIterable {
    case dogliotti
    case gutierrez
    
    var DisplayName: String {
        switch self {
        case .dogliotti:  return "Dogliotti"
        case .gutierrez:  return "Gutierrez"
        }
    }
}

public enum SedationTechniqueKind: String, Codable, CaseIterable {
    case minimal
    case moderate
    case deep
    
    var DisplayName: String {
        switch self {
        case .minimal:  return "Minima"
        case .moderate:  return "Moderada"
        case .deep:  return "Profunda"
        }
    }
}

public enum SedationType: String, Codable, CaseIterable {
    case intravenous
    case inalatory
    case combined
    
    var DisplayName: String {
        switch self {
        case .intravenous:  return "Intravenosa"
        case .inalatory:  return "Inalatória"
        case .combined:  return "Combinada"
        }
    }
}

public enum IntraVenousSedationType: String, Codable, CaseIterable {
    case tiva
    case intermitent
    
    var DisplayName: String {
        switch self {
            case .tiva:  return "TIVA"
            case .intermitent:  return "Bôlus Intermitente"
        }
    }
}

public enum SedationOxygenSupplyKind: String, Codable, CaseIterable {
    case cateterNasal
    case facialMask
    
    func DisplayName(for age: Int) -> String {
            let isChild = age < 12
            switch self {
            case .cateterNasal:
                return isChild ? "cateter nasal" : "cateter nasal"
                
            case .facialMask:
                return isChild ? "máscara facial em circuito Mappleson A" : "máscara facial"

            }
        }
}


public enum BlockEquipmentKind: String, Codable, CaseIterable {
    case usg
    case usgAndNeuralStimulation
    case neuralStimulationOnly
    case landmarks
    
    var DisplayName: String {
        switch self {
        case .usg:
            return "Ultrassonografia"
        case .usgAndNeuralStimulation:
            return "Ultrassonografia + Estimulação Neural"
        case .neuralStimulationOnly:
            return "Estimulação Neural"
        case .landmarks:
            return "Marcos Anatômicos"
        }
    }
}

public enum MMSSTechnique: String, Codable, CaseIterable {
    case interescalenical
    case supraclavian
    case subclavian
    case axilar
    
    var DisplayNameReport: String {
        switch self {
        case .interescalenical:
            return "Bloqueio plexo braquial via Interescalênico"
        case .supraclavian:
            return "Bloqueio plexo braquial via Supraclavicular"
        case .subclavian:
            return "Bloqueio plexo braquial via  Infraclavicular"
        case .axilar:
            return "Bloqueio plexo braquial via  Axilar"
        }
    }
    var DisplayName: String {
        switch self {
        case .interescalenical:
            return "Interescalênico"
        case .supraclavian:
            return "Supraclavicular"
        case .subclavian:
            return "Infraclavicular"
        case .axilar:
            return "Axilar"
        }
    }
}

public enum MMIITechnique: String, Codable, CaseIterable {
    case femoral
    case adutor
    case sciatic_gluteal
    case sciatic_poplitean
    
    var DisplayNameReport: String {
        switch self {
        case .femoral:
            return "Bloqueio nervo femoral"
        case .adutor:
            return "Bloqueio plexo lombar ao nível Adutor"
        case .sciatic_gluteal:
            return "Bloqueio nervo ciático ao nível de glúteos"
        case . sciatic_poplitean:
            return "Bloqueio nervo ciático ao nível de artéria poplítea"
        }
    }
    var DisplayName: String {
        switch self {
        case .femoral:
            return "Femoral"
        case .adutor:
            return "Adutor"
        case .sciatic_gluteal:
            return "Cíatico - Glúteo"
        case .sciatic_poplitean:
            return "Ciático - Poplítea"
        }
    }
}

public enum AbdominalToraxTechnique: String, Codable, CaseIterable {
    case tap
    case quadrado_lombar
    case pecs1
    case pecs2
    case serratus
    case paravertebral
    case ilioinguinal
    
    var DisplayNameReport: String {
        switch self {
        case .tap:
            return "Bloqueio ao nível de músculo transverso"
        case .quadrado_lombar:
            return "Bloqueio ao nível de Quadrado lombar"
        case .pecs1:
            return "PECs 1"
        case .pecs2:
            return "PECs 2"
        case .serratus:
            return "Serratus anterior"
        case .paravertebral:
            return "Paravertebral"
        case .ilioinguinal:
            return "Iliopsoas e Inguinalis"
        }
    }
    var DisplayName: String {
        switch self {
        case .tap:
            return "TAP"
        case .quadrado_lombar:
            return "Quadrado lombar"
        case .pecs1:
            return "PEC 1"
        case .pecs2:
            return "PEC 2"
        case .serratus:
            return "Serrátil"
        case .paravertebral:
            return "Paravertebral"
        case .ilioinguinal:
            return "Ilioinguinal"
        }
    }
}

public enum BlockSide: String, Codable, CaseIterable {
    case left
    case right
    case bilateral
    
    var DisplayName: String {
        switch self {
        case .left:
            return "Esquerda"
        case .right:
            return "Direita"
        case .bilateral:
            return "Bilateral"
        }
    }
}

public enum DestinationAnesthesia: String, Codable, CaseIterable {
    case rpa
    case uti
    
    var DisplayName: String {
        switch self {
        case .rpa:
            return "RPA"
        case .uti:
            return "UTI"
        }
    }
}

public enum EndAnesthesia: String, Codable, CaseIterable {
    case noComplication
    case complication
    
    var DisplayName: String {
        switch self {
        case .noComplication:
            return "Sem intercorrências"
        case .complication:
            return "Intercorrências"
        }
    }
}
