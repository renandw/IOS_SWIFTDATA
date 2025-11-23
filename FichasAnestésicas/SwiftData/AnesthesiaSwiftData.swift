//
//  AnesthesiaSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftData




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

    // Visualization and equipment used for airway access in general anesthesia
    var visualizationMethodRaw: String?
    var visualizationMethod: VisualizationMethod? { get { visualizationMethodRaw.flatMap(VisualizationMethod.init(rawValue:)) } set { visualizationMethodRaw = newValue?.rawValue } }
    
    var equipmentRaw: String?
    var equipment: LaringoschopyEquipment? { get { equipmentRaw.flatMap(LaringoschopyEquipment.init(rawValue:)) } set { equipmentRaw = newValue?.rawValue } }
    var tubeTypeRaw: String?
    var tubeType: TubeType? { get { tubeTypeRaw.flatMap(TubeType.init(rawValue:)) } set { tubeTypeRaw = newValue?.rawValue } }
    var tubeAcessRaw: String?
    var tubeAcess: TubeAcess? { get { tubeAcessRaw.flatMap(TubeAcess.init(rawValue:)) } set { tubeAcessRaw = newValue?.rawValue } }
    var tubeCuffRaw: String?
    var tubeCuff: TubeCuff? { get { tubeCuffRaw.flatMap(TubeCuff.init(rawValue:)) } set { tubeCuffRaw = newValue?.rawValue } }
    var tubeRouteRaw: String?
    var tubeRoute: TubeRoute? { get { tubeRouteRaw.flatMap(TubeRoute.init(rawValue:)) } set { tubeRouteRaw = newValue?.rawValue } }
    
    var totNumber: String?
    var cormackRaw: String?
    var cormack: CormackLehane? { get { cormackRaw.flatMap(CormackLehane.init(rawValue:)) } set { cormackRaw = newValue?.rawValue } }
    var fixation: String?

    // Raqui - SpinalAnesthesia
    var raquiPositionRaw: String?
    var raquiPosition: SpinalAndEpiduralPosition? { get { raquiPositionRaw.flatMap(SpinalAndEpiduralPosition.init(rawValue:)) } set { raquiPositionRaw = newValue?.rawValue } }

    var raquiLevelRaw: String?
    var raquiLevel: SpinalAndEpiduralLevel? { get { raquiLevelRaw.flatMap(SpinalAndEpiduralLevel.init(rawValue:)) } set { raquiLevelRaw = newValue?.rawValue } }
    var raquiNivelOutro: String?

    var raquiNeedleRaw: String?
    var raquiNeedle: SpinalAndEpiduralNeedle? { get { raquiNeedleRaw.flatMap(SpinalAndEpiduralNeedle.init(rawValue:)) } set { raquiNeedleRaw = newValue?.rawValue } }

    var raquiNeedleGaugeRaw: String?
    var raquiNeedleGauge: SpinalAndEpiduralGaugeKind? { get { raquiNeedleGaugeRaw.flatMap(SpinalAndEpiduralGaugeKind.init(rawValue:)) } set { raquiNeedleGaugeRaw = newValue?.rawValue } }
    

    // Sedation
    var sedationTechniqueRaw: String?
    var sedationTechnique: SedationTechniqueKind? { get { sedationTechniqueRaw.flatMap(SedationTechniqueKind.init(rawValue:)) } set { sedationTechniqueRaw = newValue?.rawValue } }
    
    var sedationTypeRaw: String?
    var sedationType: SedationType? { get { sedationTypeRaw.flatMap(SedationType.init(rawValue:)) } set { sedationTypeRaw = newValue?.rawValue } }
    
    var intraVenousSedationTypeRaw: String?
    var intraVenousSedationType: IntraVenousSedationType? { get { intraVenousSedationTypeRaw.flatMap(IntraVenousSedationType.init(rawValue:)) } set { intraVenousSedationTypeRaw = newValue?.rawValue } }
    
    var sedationOxygenSupplyRaw: String?
    var sedationOxygenSupply: SedationOxygenSupplyKind? { get { sedationOxygenSupplyRaw.flatMap(SedationOxygenSupplyKind.init(rawValue:)) } set { sedationOxygenSupplyRaw = newValue?.rawValue } }

    
    // PeriduralAnesthesia
    var periduralPositionRaw: String?
    var periduralPosition: SpinalAndEpiduralPosition? { get { periduralPositionRaw.flatMap(SpinalAndEpiduralPosition.init(rawValue:)) } set { periduralPositionRaw = newValue?.rawValue } }
    
    var periduralLevelRaw: String?
    var periduralLevel: SpinalAndEpiduralLevel? { get { periduralLevelRaw.flatMap(SpinalAndEpiduralLevel.init(rawValue:)) } set { periduralLevelRaw = newValue?.rawValue } }
    
    var periduralNeedleRaw: String?
    var periduralNeedle: SpinalAndEpiduralNeedle? { get { periduralNeedleRaw.flatMap(SpinalAndEpiduralNeedle.init(rawValue:)) } set { periduralNeedleRaw = newValue?.rawValue } }
    
    var periduralNeedleGaugeRaw: String?
    var periduralNeedleGauge: SpinalAndEpiduralGaugeKind? { get { periduralNeedleGaugeRaw.flatMap(SpinalAndEpiduralGaugeKind.init(rawValue:)) } set { periduralNeedleGaugeRaw = newValue?.rawValue } }
    
    var periduralTechniqueRaw: String?
    var periduralTechnique: PeriduralTechniqueKind? { get { periduralTechniqueRaw.flatMap(PeriduralTechniqueKind.init(rawValue:)) } set { periduralTechniqueRaw = newValue?.rawValue } }
    
    var periduralCateterFixation: String?
    
    
    // Peripheral Block
    var blockEquipmentRaw: String?
    var blockEquipment: BlockEquipmentKind? { get { blockEquipmentRaw.flatMap(BlockEquipmentKind.init(rawValue:)) } set { blockEquipmentRaw = newValue?.rawValue } }

    var mmssTechniqueRaw: String?
    var mmssTechnique: MMSSTechnique? { get { mmssTechniqueRaw.flatMap(MMSSTechnique.init(rawValue:)) } set { mmssTechniqueRaw = newValue?.rawValue } }
    var mmiiTechniqueRaw: String?
    var mmiiTechnique: MMIITechnique? { get { mmiiTechniqueRaw.flatMap(MMIITechnique.init(rawValue:)) } set { mmiiTechniqueRaw = newValue?.rawValue } }

    var abdominalToraxTechniqueRaw: String?
    var abdominalToraxTechnique: AbdominalToraxTechnique? { get { abdominalToraxTechniqueRaw.flatMap(AbdominalToraxTechnique.init(rawValue:)) } set { abdominalToraxTechniqueRaw = newValue?.rawValue } }
    var blockSideRaw: String?
    var blockSide: BlockSide? { get { blockSideRaw.flatMap(BlockSide.init(rawValue:)) } set { blockSideRaw = newValue?.rawValue } }

    var blockOthers: String?
    
    
    
    // completion
    var standardEnd: Bool
    var destinationAnesthesiaRaw: String?
    var destinationAnesthesia: DestinationAnesthesia? { get { destinationAnesthesiaRaw.flatMap(DestinationAnesthesia.init(rawValue:)) } set { destinationAnesthesiaRaw = newValue?.rawValue} }
    var endAnesthesiaRaw: String?
    var endAnesthesia: EndAnesthesia? { get { endAnesthesiaRaw.flatMap(EndAnesthesia.init(rawValue:)) } set { endAnesthesiaRaw = newValue?.rawValue} }
    //var complications: [String]
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
        tubeType: TubeType? = nil,
        tubeAcess: TubeAcess? = nil,
        tubeCuff: TubeCuff? = nil,
        tubeRoute: TubeRoute? = nil,
        totNumber: String? = nil,
        cormack: CormackLehane? = nil,
        fixation: String? = nil,
        
        raquiPosition: SpinalAndEpiduralPosition? = nil,
        raquiLevel: SpinalAndEpiduralLevel? = nil,
        raquiNeedle: SpinalAndEpiduralNeedle? = nil,
        raquiNeedleGauge: SpinalAndEpiduralGaugeKind? = nil,
        
        sedationTechnique: SedationTechniqueKind? = nil,
        sedationType: SedationType? = nil,
        intraVenousSedationType: IntraVenousSedationType? = nil,
        sedationOxygenSupply: SedationOxygenSupplyKind? = nil,
        
        periduralPosition: SpinalAndEpiduralPosition? = nil,
        periduralLevel: SpinalAndEpiduralLevel? = nil,
        periduralNeedle: SpinalAndEpiduralNeedle? = nil,
        periduralNeedleGauge: SpinalAndEpiduralGaugeKind? = nil,
        periduralTechnique: PeriduralTechniqueKind? = nil,
        periduralCateterFixation: String? = nil,
        
        blockEquipment: BlockEquipmentKind? = nil,
        mmssTechnique: MMSSTechnique? = nil,
        mmiiTechnique: MMIITechnique? = nil,
        abdominalToraxTechnique: AbdominalToraxTechnique? = nil,
        blockSide: BlockSide? = nil,
        blockOthers: String? = nil,
        
        
        standardEnd: Bool = false,
        destinationAnesthesia: DestinationAnesthesia? = nil,
        endAnesthesia: EndAnesthesia? = nil,
        //complications: [String] = [],
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

        self.raquiPositionRaw = raquiPosition?.rawValue
        self.raquiLevelRaw = raquiLevel?.rawValue
        self.raquiNeedleRaw = raquiNeedle?.rawValue
        self.raquiNeedleGaugeRaw = raquiNeedleGauge?.rawValue
        
        self.sedationTechniqueRaw = sedationTechnique?.rawValue
        self.sedationTypeRaw = sedationType?.rawValue
        self.intraVenousSedationTypeRaw = intraVenousSedationType?.rawValue
        self.sedationOxygenSupplyRaw = sedationOxygenSupply?.rawValue
        
        self.periduralPositionRaw = periduralPosition?.rawValue
        self.periduralLevelRaw = periduralLevel?.rawValue
        self.periduralNeedleRaw = periduralNeedle?.rawValue
        self.periduralNeedleGaugeRaw = periduralNeedleGauge?.rawValue
        self.periduralTechniqueRaw = periduralTechnique?.rawValue
        self.periduralCateterFixation = periduralCateterFixation

        self.blockEquipmentRaw = blockEquipment?.rawValue
        self.mmssTechniqueRaw = mmssTechnique?.rawValue
        self.mmiiTechniqueRaw = mmiiTechnique?.rawValue
        self.abdominalToraxTechniqueRaw = abdominalToraxTechnique?.rawValue
        self.blockSideRaw = blockSide?.rawValue
        self.blockOthers = blockOthers
        
        self.standardEnd = standardEnd
        self.destinationAnesthesiaRaw = destinationAnesthesia?.rawValue
        self.endAnesthesiaRaw = endAnesthesia?.rawValue
        //self.complications = complications
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
