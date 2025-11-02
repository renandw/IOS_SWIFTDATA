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

public enum AirwayKind: String, Codable, CaseIterable {
    case mascara
    case cannula
    case tot
    case lma
    case traqueostomia
    case espontanea
    case outro
}

public enum ConsciousnessKind: String, Codable, CaseIterable {
    case alerta
    case sedadoLeve
    case sedadoProfundo
    case anestesiado
    case outro
}

public enum VentilatoryKind: String, Codable, CaseIterable {
    case espontanea
    case vmAC
    case vmVCV
    case vmPCV
    case vni
    case outro
}

public enum OxygenKind: String, Codable, CaseIterable {
    case arAmbiente
    case cateter
    case mascara
    case venturi
    case reinalacao
    case tubo
    case traqueo
}

public enum HemodynamicKind: String, Codable, CaseIterable {
    case estavel
    case hipotenso
    case hipertenso
    case taquicardico
    case bradicardico
    case instavel
}

public enum ASAClassification: String, Codable, CaseIterable {
    case I
    case II
    case III
    case IV
    case V
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
    
    @Relationship(deleteRule: .cascade, inverse: \AnesthesiaDescription.anesthesia) var anesthesiaDescriptions: [AnesthesiaDescription]
    var anesthesiaTechniqueRaw: [String]
    @Relationship(deleteRule: .cascade, inverse: \MedicationEntry.anesthesia) var medications: [MedicationEntry]
    @Relationship(deleteRule: .cascade, inverse: \VitalSignEntry.anesthesia) var vitalSigns: [VitalSignEntry]

    var start: Date?
    var end: Date?
    var statusRaw: String?

    var techniques: [AnesthesiaTechniqueKind] {
        get { anesthesiaTechniqueRaw.compactMap(AnesthesiaTechniqueKind.init(rawValue:)) }
        set { anesthesiaTechniqueRaw = newValue.map(\.rawValue) }
    }

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
    
    init(anesthesiaId: String, surgery: Surgery, anesthesiaDescriptions: [AnesthesiaDescription], anesthesiaTechniqueRaw: [String], medications: [MedicationEntry], vitalSigns: [VitalSignEntry], start: Date? = nil, end: Date? = nil, statusRaw: String? = nil, createdBy: User, updatedBy: User? = nil, createdAt: Date, updatedAt: Date? = nil, positionRaw: [String]) {
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
final class AnesthesiaDescription {
    @Relationship var anesthesia: Anesthesia
    @Attribute(.unique) var descriptionId: String

    var cardioscopia: Bool
    var oximetria: Bool
    var pani: Bool
    var capnografia: Bool
    var pai: Bool
    var pvc: Bool
    var termometro: Bool
    var bis: Bool
    var tof: Bool
    var customMonitorings: [String]

    var airwayRaw: String?
    var consciousnessRaw: String?
    var ventilatoryRaw: String?
    var oxygenRaw: String?
    var hemodynamicRaw: String?


    var geral: Bool
    var raquianestesia: Bool
    var sedacao: Bool
    var peridural: Bool
    var periferico: Bool
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


    var airway: AirwayKind? { get { airwayRaw.flatMap(AirwayKind.init(rawValue:)) } set { airwayRaw = newValue?.rawValue } }
    var consciousness: ConsciousnessKind? { get { consciousnessRaw.flatMap(ConsciousnessKind.init(rawValue:)) } set { consciousnessRaw = newValue?.rawValue } }
    var ventilatory: VentilatoryKind? { get { ventilatoryRaw.flatMap(VentilatoryKind.init(rawValue:)) } set { ventilatoryRaw = newValue?.rawValue } }
    var oxygen: OxygenKind? { get { oxygenRaw.flatMap(OxygenKind.init(rawValue:)) } set { oxygenRaw = newValue?.rawValue } }
    var hemodynamic: HemodynamicKind? { get { hemodynamicRaw.flatMap(HemodynamicKind.init(rawValue:)) } set { hemodynamicRaw = newValue?.rawValue } }

    init(
        descriptionId: String = UUID().uuidString,
        anesthesia: Anesthesia,
        cardioscopia: Bool = false, oximetria: Bool = false, pani: Bool = false, capnografia: Bool = false, pai: Bool = false, pvc: Bool = false,
        termometro: Bool = false, bis: Bool = false, tof: Bool = false, customMonitorings: [String] = [],
        airway: AirwayKind? = nil, consciousness: ConsciousnessKind? = nil, ventilatory: VentilatoryKind? = nil, oxygen: OxygenKind? = nil, hemodynamic: HemodynamicKind? = nil,
        geral: Bool = false, raquianestesia: Bool = false, sedacao: Bool = false, peridural: Bool = false, periferico: Bool = false, techOrder: [String] = [],
        instrumentoAcesso: String? = nil, totNumber: String? = nil, cormack: String? = nil, fixacao: String? = nil,
        raquiPosicao: String? = nil, raquiNivel: String? = nil, raquiNivelOutro: String? = nil, raquiAgulhaTipo: String? = nil, raquiAgulhaGauge: String? = nil,
        sedacaoNivel: String? = nil, sedacaoModo: String? = nil, sedacaoOxigenio: String? = nil, sedacaoCircuito: String? = nil,
        peridPosicao: String? = nil, peridNivel: String? = nil, peridNivelOutro: String? = nil, peridAgulhaGauge: String? = nil, peridIdentificacao: String? = nil, peridCateterCm: String? = nil,
        perifGuia: String? = nil, perifPlexoBraquial: [String] = [], perifMembroInferior: [String] = [], perifParedeToracAbd: [String] = [], perifOutros: [String] = [], perifOutroTexto: String? = nil,
        standardEnd: Bool = true, destination: String? = nil, adverseEvolution: String? = nil, finalDescription: String? = nil
    ) {
        self.descriptionId = descriptionId
        self.anesthesia = anesthesia

        self.cardioscopia = cardioscopia; self.oximetria = oximetria; self.pani = pani; self.capnografia = capnografia; self.pai = pai; self.pvc = pvc
        self.termometro = termometro; self.bis = bis; self.tof = tof; self.customMonitorings = customMonitorings

        self.airwayRaw = airway?.rawValue; self.consciousnessRaw = consciousness?.rawValue
        self.ventilatoryRaw = ventilatory?.rawValue; self.oxygenRaw = oxygen?.rawValue; self.hemodynamicRaw = hemodynamic?.rawValue

        self.geral = geral; self.raquianestesia = raquianestesia; self.sedacao = sedacao; self.peridural = peridural; self.periferico = periferico
        self.techOrder = techOrder

        self.instrumentoAcesso = instrumentoAcesso; self.totNumber = totNumber; self.cormack = cormack; self.fixacao = fixacao

        self.raquiPosicao = raquiPosicao; self.raquiNivel = raquiNivel; self.raquiNivelOutro = raquiNivelOutro; self.raquiAgulhaTipo = raquiAgulhaTipo; self.raquiAgulhaGauge = raquiAgulhaGauge

        self.sedacaoNivel = sedacaoNivel; self.sedacaoModo = sedacaoModo; self.sedacaoOxigenio = sedacaoOxigenio; self.sedacaoCircuito = sedacaoCircuito

        self.peridPosicao = peridPosicao; self.peridNivel = peridNivel; self.peridNivelOutro = peridNivelOutro; self.peridAgulhaGauge = peridAgulhaGauge; self.peridIdentificacao = peridIdentificacao; self.peridCateterCm = peridCateterCm

        self.perifGuia = perifGuia; self.perifPlexoBraquial = perifPlexoBraquial; self.perifMembroInferior = perifMembroInferior; self.perifParedeToracAbd = perifParedeToracAbd; self.perifOutros = perifOutros; self.perifOutroTexto = perifOutroTexto

        self.standardEnd = standardEnd; self.destination = destination; self.adverseEvolution = adverseEvolution; self.finalDescription = finalDescription
    }
}

// MARK: - Medicações

@Model
final class MedicationEntry {
    @Attribute(.unique) var medicationId: String
    @Relationship var anesthesia: Anesthesia

    var category: String?
    var dose: String?
    var name: String
    var timestamp: Date
    var via: String?

    init(
        medicationId: String = UUID().uuidString,
        anesthesia: Anesthesia,
        category: String? = nil,
        dose: String? = nil,
        name: String,
        timestamp: Date = .init(),
        via: String? = nil
    ) {
        self.medicationId = medicationId
        self.anesthesia = anesthesia
        self.category = category
        self.dose = dose
        self.name = name
        self.timestamp = timestamp
        self.via = via
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
