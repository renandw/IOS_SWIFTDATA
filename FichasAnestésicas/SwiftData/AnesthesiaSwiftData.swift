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
    case obtunded
    case responsiveToPain
    case unresponsive
}


public enum AirwayKind: String, Codable, CaseIterable {
    case noDevice
    case oropharyngealGuedel
    case nasopharyngeal
    case lma
    case maskLMA
    case endotrachealTube
    case tracheostomy
}

public enum VentilationMode: String, Codable, CaseIterable {
    case expontaneus
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

struct AirwauDeviceInfo: Codable {
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

@Model
final class Anesthesia {
    @Attribute(.unique) var anesthesiaId: String
    @Relationship var surgery: Surgery
    
    @Relationship(deleteRule: .cascade, inverse: \AnesthesiaDescriptionEntry.anesthesia) var anesthesiaDescriptions: [AnesthesiaDescriptionEntry]
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
    
    init(anesthesiaId: String, surgery: Surgery, anesthesiaDescriptions: [AnesthesiaDescriptionEntry], anesthesiaTechniqueRaw: [String], medications: [MedicationEntry], vitalSigns: [VitalSignEntry], start: Date? = nil, end: Date? = nil, statusRaw: String? = nil, createdBy: User, updatedBy: User? = nil, createdAt: Date, updatedAt: Date? = nil, positionRaw: [String]) {
        self.anesthesiaId = anesthesiaId
        self.surgery = surgery
        self.anesthesiaDescriptions = anesthesiaDescriptions
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

    var instrumentoAcesso: String?
    var totNumber: String?
    var cormack: String?
    var fixacao: String?

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
        
        instrumentoAcesso: String? = nil,
        totNumber: String? = nil,
        cormack: String? = nil,
        fixacao: String? = nil,
        
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

        self.instrumentoAcesso = instrumentoAcesso
        self.totNumber = totNumber
        self.cormack = cormack
        self.fixacao = fixacao

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

