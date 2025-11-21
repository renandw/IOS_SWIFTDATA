//
//  AnesthesiaSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftData


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

}

public enum VisualizationMethod: String, Codable, CaseIterable {
    case indirect
    case direct
}

public enum LaringoschopyEquipment: String, Codable, CaseIterable {
    case laringoscope
    case fibroscope
    case mirrorGarcia
    case videoLaryngoscope
}

public enum TubeCuff: String, Codable, CaseIterable {
    case with
    case without
}

public enum TubeRoute: String, Codable, CaseIterable {
    case nasal
    case oral
}

public enum TubeType: String, Codable, CaseIterable {
    case common
    case aramado
    case doubleLumen
    case eNasal
    case traqueal
}
public enum TubeAcess: String, Codable, CaseIterable {
    case inORInserted
    case previouslyInserted
}

enum CormackLehane: String, CaseIterable, Codable, Identifiable {
    case grade1        // glote totalmente visível
    case grade2a       // parte posterior da glote visível
    case grade2b       // apenas aritenoides / cartilagens visíveis
    case grade3        // somente epiglote visível
    case grade4        // nem epiglote visível
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .grade1:  return "Grau I – Glote totalmente visível"
        case .grade2a: return "Grau IIa – Parte da glote visível"
        case .grade2b: return "Grau IIb – Apenas aritenoides"
        case .grade3:  return "Grau III – Apenas epiglote"
        case .grade4:  return "Grau IV – Nada visível"
        }
    }
    
    var shortLabel: String {
        switch self {
        case .grade1:  return "I"
        case .grade2a: return "IIa"
        case .grade2b: return "IIb"
        case .grade3:  return "III"
        case .grade4:  return "IV"
        }
    }
}

public enum SpinalPosition: String, Codable, CaseIterable {
    case seated
    case lateralDecubitus
}

public enum SpinalLevel: String, Codable, CaseIterable {
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
public enum SpinalNeedle: String, Codable, CaseIterable {
    case whitacre
    case quincke
    case thuohy
    case tuohysoho
    case caudal
}

public enum SpinalGaugeKind: String, Codable, CaseIterable {
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
}

public enum SedationTechniqueKind: String, Codable, CaseIterable {
    case shallow
    case moderate
    case profound
}

public enum SedationType: String, Codable, CaseIterable {
    case intravenous
    case inalatory
    case combined
}

public enum SedationOxygenSupplyKind: String, Codable, CaseIterable {
    case cateterNasal
    case facialMask
    
    func displayName(for age: Int) -> String {
            let isChild = age < 12
            switch self {
            case .cateterNasal:
                return isChild ? "cateter nasal" : "cateter nasal"
                
            case .facialMask:
                return isChild ? "máscara facial em circuito Mappleson A" : "máscara facial"

            }
        }
}



@Model
final class Anesthesia {
    @Attribute(.unique) var anesthesiaId: String
    @Relationship var surgery: Surgery
    
    @Relationship(deleteRule: .cascade, inverse: \AnesthesiaDescriptionEntry.anesthesia) var anesthesiaDescription: AnesthesiaDescriptionEntry?
    var anesthesiaTechniqueRaw: [String]
    @Relationship(deleteRule: .cascade, inverse: \MedicationEntry.anesthesia) var medications: [MedicationEntry]
    @Relationship(deleteRule: .cascade, inverse: \VitalSignEntry.anesthesia) var vitalSigns: [VitalSignEntry]

    var start: Date?
    var end: Date?
    var statusRaw: String?
    var status: Status? {
        get { statusRaw.flatMap(Status.init(rawValue:)) }
        set { statusRaw = newValue?.rawValue }
    }
    
    var position: [Positioning] {
        get { positionRaw.compactMap(Positioning.init(rawValue:)) }
        set { positionRaw = newValue.map(\.rawValue)}
    }
    
    var createdBy: User
    var updatedBy: User?
    var createdAt: Date
    var updatedAt: Date?
    var positionRaw: [String]
    
    @Relationship var shared: SharedPreAndAnesthesia?
    
    
    init(anesthesiaId: String, surgery: Surgery, anesthesiaDescription: AnesthesiaDescriptionEntry?, anesthesiaTechniqueRaw: [String], medications: [MedicationEntry], vitalSigns: [VitalSignEntry], start: Date? = nil, end: Date? = nil, statusRaw: String? = nil, createdBy: User, updatedBy: User? = nil, createdAt: Date, updatedAt: Date? = nil, positionRaw: [String]) {
        self.anesthesiaId = anesthesiaId
        self.surgery = surgery
        self.anesthesiaDescription = anesthesiaDescription
        self.anesthesiaTechniqueRaw = anesthesiaTechniqueRaw
        self.medications = medications
        self.vitalSigns = vitalSigns
        self.start = start
        self.end = end
        self.statusRaw = statusRaw
        self.createdBy = createdBy
        self.updatedBy = updatedBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.positionRaw = positionRaw
    }
}


// MARK: - Descrição de Anestesia

@Model
final class AnesthesiaDescriptionEntry {
    @Relationship var anesthesia: Anesthesia
    @Attribute(.unique) var descriptionId: String

    //Monitoring
    var electrocardioscopy: Bool
    var oximetry: Bool
    var nonInvasiveBloodPressure: Bool
    var capnography: Bool
    var invasiveBloodPlessure: Bool
    var centralVenousPressure: Bool
    var thermometer: Bool
    var bis: Bool
    var tof: Bool
    var customMonitorings: [String]

    var timestamp: Date
    //Admission
    var airwayRaw: String?
    var airway: AirwayKind? { get { airwayRaw.flatMap(AirwayKind.init(rawValue:)) } set { airwayRaw = newValue?.rawValue } }
    
    var consciousnessRaw: String?
    var consciousness: ConsciousnessKind? { get { consciousnessRaw.flatMap(ConsciousnessKind.init(rawValue:)) } set { consciousnessRaw = newValue?.rawValue } }
    
    var ventilatoryRaw: String?
    var ventilatory: VentilationMode? { get { ventilatoryRaw.flatMap(VentilationMode.init(rawValue:)) } set { ventilatoryRaw = newValue?.rawValue } }
    
    var mechanicalVentilationRaw: String?
    var mechanicalVentilation: MechanicalVentilationMode? { get { mechanicalVentilationRaw.flatMap(MechanicalVentilationMode.init(rawValue:)) } set { mechanicalVentilationRaw = newValue?.rawValue}}
    
    var oxygenSupplyRaw: String?
    var oxygenSupply: OxygenSupply? { get { oxygenSupplyRaw.flatMap(OxygenSupply.init(rawValue:)) } set { oxygenSupplyRaw = newValue?.rawValue } }
    var fiO2Fraction: Double?
    
    var hemodynamicRaw: String?
    var hemodynamic: HemodynamicKind? { get { hemodynamicRaw.flatMap(HemodynamicKind.init(rawValue:)) } set { hemodynamicRaw = newValue?.rawValue } }
    
    var veinAccessRaw: String?
    var veinAccess: VeinAccessKind? { get { veinAccessRaw.flatMap(VeinAccessKind.init(rawValue:)) } set { veinAccessRaw = newValue?.rawValue } }
    
    var veinGaugeRaw: String?
    var veinGauge: VeinGaugeKind? { get { veinGaugeRaw.flatMap(VeinGaugeKind.init(rawValue:)) } set { veinGaugeRaw = newValue?.rawValue } }

    //Anesthesia Tecnique
    var generalAnesthesia: Bool
    var spinalAnesthesia: Bool
    var sedationAnesthesia: Bool
    var periduralAnesthesia: Bool
    var peripheralBlockAnesthesia: Bool
    var localAnesthesia: Bool
    var techOrder: [String]

    // Visualization and equipment used for airway access
    var visualizationMethodRaw: String?
    var visualizationMethod: VisualizationMethod? { get { visualizationMethodRaw.flatMap(VisualizationMethod.init(rawValue:)) } set { visualizationMethodRaw = newValue?.rawValue } }
    
    var equipmentRaw: String?
    var equipment: LaringoschopyEquipment? { get { equipmentRaw.flatMap(LaringoschopyEquipment.init(rawValue:)) } set { equipmentRaw = newValue?.rawValue } }
    var totNumber: String?
    var cormackRaw: String?
    var cormack: CormackLehane? { get { cormackRaw.flatMap(CormackLehane.init(rawValue:)) } set { cormackRaw = newValue?.rawValue } }
    var fixation: String?

    var raquiPosicao: String?
    var raquiNivel: String?
    var raquiNivelOutro: String?
    var raquiAgulhaTipo: String?
    var raquiAgulhaGauge: String?

    var sedacaoNivel: String?
    var sedacaoModo: String?
    var sedacaoOxigenio: String?
    var sedacaoCircuito: String?

    var peridPosicao: String?
    var peridNivel: String?
    var peridNivelOutro: String?
    var peridAgulhaGauge: String?
    var peridIdentificacao: String?
    var peridCateterCm: String?

    var perifGuia: String?
    var perifPlexoBraquial: [String]
    var perifMembroInferior: [String]
    var perifParedeToracAbd: [String]
    var perifOutros: [String]
    var perifOutroTexto: String?

    var standardEnd: Bool
    var destination: String?
    var adverseEvolution: String?
    var finalDescription: String?


    


    init(
        descriptionId: String = UUID().uuidString,
        anesthesia: Anesthesia,
        timestamp: Date,
        
        electrocardioscopy: Bool = false,
        oximetry: Bool = false,
        nonInvasiveBloodPressure: Bool = false,
        capnography: Bool = false,
        invasiveBloodPlessure: Bool = false,
        centralVenousPressure: Bool = false,
        thermometer: Bool = false,
        bis: Bool = false,
        tof: Bool = false,
        customMonitorings: [String] = [],
        
        airway: AirwayKind? = nil,
        consciousness: ConsciousnessKind? = nil,
        ventilatory: VentilationMode? = nil,
        mechanicalVentilation: MechanicalVentilationMode? = nil,
        oxygenSupply: OxygenSupply? = nil,
        fiO2Fraction: Double? = nil,
        hemodynamic: HemodynamicKind? = nil,
        veinAccess: VeinAccessKind? = nil,
        veinGauge: VeinGaugeKind? = nil,
        
        generalAnesthesia: Bool = false,
        spinalAnesthesia: Bool = false,
        sedationAnesthesia: Bool = false,
        periduralAnesthesia: Bool = false,
        peripheralBlockAnesthesia: Bool = false,
        localAnesthesia: Bool = false,
        techOrder: [String] = [],
        
        visualizationMethod: VisualizationMethod? = nil,
        equipment: LaringoschopyEquipment? = nil,
        totNumber: String? = nil,
        cormack: CormackLehane? = nil,
        fixation: String? = nil,
        
        raquiPosicao: String? = nil,
        raquiNivel: String? = nil,
        raquiNivelOutro: String? = nil,
        raquiAgulhaTipo: String? = nil,
        raquiAgulhaGauge: String? = nil,
        
        sedacaoNivel: String? = nil,
        sedacaoModo: String? = nil,
        sedacaoOxigenio: String? = nil,
        sedacaoCircuito: String? = nil,
        
        peridPosicao: String? = nil,
        peridNivel: String? = nil,
        peridNivelOutro: String? = nil,
        peridAgulhaGauge: String? = nil,
        peridIdentificacao: String? = nil,
        peridCateterCm: String? = nil,
        
        perifGuia: String? = nil,
        perifPlexoBraquial: [String] = [],
        perifMembroInferior: [String] = [],
        perifParedeToracAbd: [String] = [],
        perifOutros: [String] = [],
        perifOutroTexto: String? = nil,
        standardEnd: Bool = true,
        
        destination: String? = nil,
        adverseEvolution: String? = nil,
        finalDescription: String? = nil
    ) {
        self.descriptionId = descriptionId
        self.anesthesia = anesthesia
        self.timestamp = timestamp

        self.electrocardioscopy = electrocardioscopy
        self.oximetry = oximetry
        self.nonInvasiveBloodPressure = nonInvasiveBloodPressure
        self.capnography = capnography
        self.invasiveBloodPlessure = invasiveBloodPlessure
        self.centralVenousPressure = centralVenousPressure
        self.thermometer = thermometer
        self.bis = bis
        self.tof = tof
        self.customMonitorings = customMonitorings

        self.airwayRaw = airway?.rawValue
        self.consciousnessRaw = consciousness?.rawValue
        self.ventilatoryRaw = ventilatory?.rawValue
        self.mechanicalVentilationRaw = mechanicalVentilation?.rawValue
        self.oxygenSupplyRaw = oxygenSupply?.rawValue
        self.fiO2Fraction = fiO2Fraction
        self.hemodynamicRaw = hemodynamic?.rawValue
        self.veinAccessRaw = veinAccess?.rawValue
        self.veinGaugeRaw = veinGauge?.rawValue
        
        self.generalAnesthesia = generalAnesthesia
        self.spinalAnesthesia = spinalAnesthesia
        self.sedationAnesthesia = sedationAnesthesia
        self.periduralAnesthesia = periduralAnesthesia
        self.peripheralBlockAnesthesia = peripheralBlockAnesthesia
        self.localAnesthesia = localAnesthesia
        self.techOrder = techOrder

        self.visualizationMethodRaw = visualizationMethod?.rawValue
        self.equipmentRaw = equipment?.rawValue
        self.totNumber = totNumber
        self.cormackRaw = cormack?.rawValue
        self.fixation = fixation

        self.raquiPosicao = raquiPosicao
        self.raquiNivel = raquiNivel
        self.raquiNivelOutro = raquiNivelOutro
        self.raquiAgulhaTipo = raquiAgulhaTipo
        self.raquiAgulhaGauge = raquiAgulhaGauge

        self.sedacaoNivel = sedacaoNivel
        self.sedacaoModo = sedacaoModo
        self.sedacaoOxigenio = sedacaoOxigenio
        self.sedacaoCircuito = sedacaoCircuito

        self.peridPosicao = peridPosicao
        self.peridNivel = peridNivel
        self.peridNivelOutro = peridNivelOutro
        self.peridAgulhaGauge = peridAgulhaGauge
        self.peridIdentificacao = peridIdentificacao
        self.peridCateterCm = peridCateterCm

        self.perifGuia = perifGuia
        self.perifPlexoBraquial = perifPlexoBraquial
        self.perifMembroInferior = perifMembroInferior
        self.perifParedeToracAbd = perifParedeToracAbd
        self.perifOutros = perifOutros
        self.perifOutroTexto = perifOutroTexto

        self.standardEnd = standardEnd
        self.destination = destination
        self.adverseEvolution = adverseEvolution
        self.finalDescription = finalDescription
    }
}

// MARK: - Medicações

@Model
final class MedicationEntry {
    @Attribute(.unique) var medicationId: String
    @Relationship var anesthesia: Anesthesia

    var categoryRaw: String
    var category: MedicationCategory {
        get { MedicationCategory(rawValue: categoryRaw) ?? .opioide }
        set { categoryRaw = newValue.rawValue }
    }
    var viaRaw: String
    var via: AdministrationRoute {
        get { AdministrationRoute(rawValue: viaRaw) ?? .EV }
        set { viaRaw = newValue.rawValue }
    }
    var dose: String
    var name: String
    var timestamp: Date
    
    init(medicationId: String, anesthesia: Anesthesia, categoryRaw: String, viaRaw: String, dose: String, name: String, timestamp: Date) {
        self.medicationId = medicationId
        self.anesthesia = anesthesia
        self.categoryRaw = categoryRaw
        self.viaRaw = viaRaw
        self.dose = dose
        self.name = name
        self.timestamp = timestamp
    }
}

// MARK: - Sinais Vitais

@Model
final class VitalSignEntry {
    @Attribute(.unique) var vitalSignsId: String
    @Relationship var anesthesia: Anesthesia

    var timestamp: Date
    var pam: Double?
    var fc: Double?
    var paS: Double?
    var paD: Double?
    var rhythm: String?
    var etco2: Double?
    var spo2: Double?
    var fio2: Double?
    var peep: Double?
    var volumeCorrente: Double?
    var bis: Double?
    var pupilas: String?
    var tof: Double?
    var pvc: Double?
    var debitCardiaco: Double?
    var glicemia: Double?
    var lactato: Double?
    var temperatura: Double?
    var diurese: Double?
    var sangramento: Double?

    init(
        vitalSignsId: String = UUID().uuidString,
        anesthesia: Anesthesia,
        timestamp: Date = .init()
    ) {
        self.vitalSignsId = vitalSignsId
        self.anesthesia = anesthesia
        self.timestamp = timestamp
    }
}

@Model
final class SharedPreAndAnesthesia {
    var techniqueRaw: [String]
    var asaRaw: String?
    // computed
    var techniques: [AnesthesiaTechniqueKind] {
        get { techniqueRaw.compactMap(AnesthesiaTechniqueKind.init(rawValue:)) }
        set { techniqueRaw = newValue.map(\.rawValue) }
    }
    
    var asa: ASAClassification? {
        get { asaRaw.flatMap(ASAClassification.init(rawValue:)) }
        set { asaRaw = newValue?.rawValue }
    }
    
    @Relationship(inverse: \Surgery.shared) var surgery: Surgery?
    
    init(techniquesRaw: [String], asaRaw: String? = nil) {
        self.techniqueRaw = techniquesRaw
        self.asaRaw = asaRaw
    }
}

