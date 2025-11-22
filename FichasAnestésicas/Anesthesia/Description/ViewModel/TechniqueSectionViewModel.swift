//
//  TechniqueSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 21/11/25.
//
import SwiftUI

@Observable
final class TechniquesSectionViewModel {
    // High-level technique toggles and order
    var generalAnesthesia = false
    var spinalAnesthesia = false
    var sedationAnesthesia = false
    var periduralAnesthesia = false
    var peripheralAnesthesia = false
    var localAnesthesia = false
    var techOrder: [String] = []

    // General anesthesia – airway access
    var visualizationMethodRaw: String?
    var equipmentRaw: String?
    var totNumber: String?
    // Cormack is raw-backed in the entry, so keep a raw storage here as well
    var cormackRaw: String?
    var fixation: String?

    // Spinal (Raqui)
    var raquiPositionRaw: String?
    var raquiLevelRaw: String?
    var raquiNivelOutro: String?
    var raquiNeedleRaw: String?
    var raquiNeedleGaugeRaw: String?

    // Sedation
    var sedationTechniqueRaw: String?
    var sedationTypeRaw: String?
    var intraVenousSedationTypeRaw: String?
    var sedationOxygenSupplyRaw: String?

    // Peridural
    var periduralPositionRaw: String?
    var periduralLevelRaw: String?
    var periduralNeedleRaw: String?
    var periduralNeedleGaugeRaw: String?
    var periduralTechniqueRaw: String?
    var periduralCateterFixation: String?

    // Peripheral block
    var blockEquipmentRaw: String?
    var mmssTechinqueRaw: String?
    var mmiiTechniqueRaw: String?
    var abdominalToraxTechniqueRaw: String?
    var blockSideRaw: String?
    var blockOthers: String?

    func load(from e: AnesthesiaDescriptionEntry) {
        // Techniques
        generalAnesthesia = e.generalAnesthesia
        spinalAnesthesia = e.spinalAnesthesia
        sedationAnesthesia = e.sedationAnesthesia
        periduralAnesthesia = e.periduralAnesthesia
        peripheralAnesthesia = e.peripheralBlockAnesthesia
        localAnesthesia = e.localAnesthesia
        techOrder = e.techOrder

        // General anesthesia – airway access
        visualizationMethodRaw = e.visualizationMethodRaw
        equipmentRaw = e.equipmentRaw
        totNumber = e.totNumber
        cormackRaw = e.cormackRaw
        fixation = e.fixation

        // Spinal (Raqui)
        raquiPositionRaw = e.raquiPositionRaw
        raquiLevelRaw = e.raquiLevelRaw
        raquiNivelOutro = e.raquiNivelOutro
        raquiNeedleRaw = e.raquiNeedleRaw
        raquiNeedleGaugeRaw = e.raquiNeedleGaugeRaw

        // Sedation
        sedationTechniqueRaw = e.sedationTechniqueRaw
        sedationTypeRaw = e.sedationTypeRaw
        intraVenousSedationTypeRaw = e.intraVenousSedationTypeRaw
        sedationOxygenSupplyRaw = e.sedationOxygenSupplyRaw

        // Peridural
        periduralPositionRaw = e.periduralPositionRaw
        periduralLevelRaw = e.periduralLevelRaw
        periduralNeedleRaw = e.periduralNeedleRaw
        periduralNeedleGaugeRaw = e.periduralNeedleGaugeRaw
        periduralTechniqueRaw = e.periduralTechniqueRaw
        periduralCateterFixation = e.periduralCateterFixation

        // Peripheral block
        blockEquipmentRaw = e.blockEquipmentRaw
        mmssTechinqueRaw = e.mmssTechinqueRaw
        mmiiTechniqueRaw = e.mmiiTechniqueRaw
        abdominalToraxTechniqueRaw = e.abdominalToraxTechniqueRaw
        blockSideRaw = e.blockSideRaw
        blockOthers = e.blockOthers
    }

    func apply(to e: AnesthesiaDescriptionEntry) {
        // Techniques
        e.generalAnesthesia = generalAnesthesia
        e.spinalAnesthesia = spinalAnesthesia
        e.sedationAnesthesia = sedationAnesthesia
        e.periduralAnesthesia = periduralAnesthesia
        e.peripheralBlockAnesthesia = peripheralAnesthesia
        e.localAnesthesia = localAnesthesia
        e.techOrder = techOrder

        // General anesthesia – airway access
        e.visualizationMethodRaw = visualizationMethodRaw
        e.equipmentRaw = equipmentRaw
        e.totNumber = totNumber
        e.cormackRaw = cormackRaw
        e.fixation = fixation

        // Spinal (Raqui)
        e.raquiPositionRaw = raquiPositionRaw
        e.raquiLevelRaw = raquiLevelRaw
        e.raquiNivelOutro = raquiNivelOutro
        e.raquiNeedleRaw = raquiNeedleRaw
        e.raquiNeedleGaugeRaw = raquiNeedleGaugeRaw

        // Sedation
        e.sedationTechniqueRaw = sedationTechniqueRaw
        e.sedationTypeRaw = sedationTypeRaw
        e.intraVenousSedationTypeRaw = intraVenousSedationTypeRaw
        e.sedationOxygenSupplyRaw = sedationOxygenSupplyRaw

        // Peridural
        e.periduralPositionRaw = periduralPositionRaw
        e.periduralLevelRaw = periduralLevelRaw
        e.periduralNeedleRaw = periduralNeedleRaw
        e.periduralNeedleGaugeRaw = periduralNeedleGaugeRaw
        e.periduralTechniqueRaw = periduralTechniqueRaw
        e.periduralCateterFixation = periduralCateterFixation

        // Peripheral block
        e.blockEquipmentRaw = blockEquipmentRaw
        e.mmssTechinqueRaw = mmssTechinqueRaw
        e.mmiiTechniqueRaw = mmiiTechniqueRaw
        e.abdominalToraxTechniqueRaw = abdominalToraxTechniqueRaw
        e.blockSideRaw = blockSideRaw
        e.blockOthers = blockOthers
    }
    
    func resetTechniquesSelection() {
        generalAnesthesia = false
        spinalAnesthesia = false
        sedationAnesthesia = false
        periduralAnesthesia = false
        peripheralAnesthesia = false
        localAnesthesia = false
    }
}
