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
    var visualizationMethod: VisualizationMethod?
    var equipment: LaringoschopyEquipment?
    var tubeType: TubeType?
    var tubeAcess: TubeAcess?
    var tubeCuff: TubeCuff?
    var tubeRoute: TubeRoute?
    var totNumber: String?
    // Cormack is raw-backed in the entry, so keep a raw storage here as well
    var cormack: CormackLehane?
    var fixation: String?

    // Spinal (Raqui)
    var raquiPosition: SpinalAndEpiduralPosition?
    var raquiLevel: SpinalAndEpiduralLevel?
    var raquiNeedle: SpinalAndEpiduralNeedle?
    var raquiNeedleGauge: SpinalAndEpiduralGaugeKind?

    // Sedation
    var sedationTechnique: SedationTechniqueKind?
    var sedationType: SedationType? { didSet {intraVenousPickerVisibility() }}
    var intraVenousSedationType: IntraVenousSedationType?
    var sedationOxygenSupply: SedationOxygenSupplyKind?

    // Peridural
    var periduralPosition: SpinalAndEpiduralPosition?
    var periduralLevel: SpinalAndEpiduralLevel?
    var periduralNeedle: SpinalAndEpiduralNeedle?
    var periduralNeedleGauge: SpinalAndEpiduralGaugeKind?
    var periduralTechnique: PeriduralTechniqueKind?
    var periduralCateterFixation: String?

    // Peripheral block
    var blockEquipment: BlockEquipmentKind?
    var mmssTechnique: MMSSTechnique?
    var mmiiTechnique: MMIITechnique?
    var abdominalToraxTechnique: AbdominalToraxTechnique?
    var blockSide: BlockSide?
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
        visualizationMethod = e.visualizationMethod
        equipment = e.equipment
        tubeType = e.tubeType
        tubeAcess = e.tubeAcess
        tubeCuff = e.tubeCuff
        tubeRoute = e.tubeRoute
        totNumber = e.totNumber
        cormack = e.cormack
        fixation = e.fixation

        // Spinal (Raqui)
        raquiPosition = e.raquiPosition
        raquiLevel = e.raquiLevel
        raquiNeedle = e.raquiNeedle
        raquiNeedleGauge = e.raquiNeedleGauge

        // Sedation
        sedationTechnique = e.sedationTechnique
        sedationType = e.sedationType
        intraVenousSedationType = e.intraVenousSedationType
        sedationOxygenSupply = e.sedationOxygenSupply

        // Peridural
        periduralPosition = e.periduralPosition
        periduralLevel = e.periduralLevel
        periduralNeedle = e.periduralNeedle
        periduralNeedleGauge = e.periduralNeedleGauge
        periduralTechnique = e.periduralTechnique
        periduralCateterFixation = e.periduralCateterFixation

        // Peripheral block
        blockEquipment = e.blockEquipment
        mmssTechnique = e.mmssTechnique
        mmiiTechnique = e.mmiiTechnique
        abdominalToraxTechnique = e.abdominalToraxTechnique
        blockSide = e.blockSide
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
        e.visualizationMethod = visualizationMethod
        e.tubeType = tubeType
        e.tubeAcess = tubeAcess
        e.tubeCuff = tubeCuff
        e.tubeRoute = tubeRoute
        e.equipment = equipment
        e.totNumber = totNumber
        e.cormack = cormack
        e.fixation = fixation

        // Spinal (Raqui)
        e.raquiPosition = raquiPosition
        e.raquiLevel = raquiLevel
        e.raquiNeedle = raquiNeedle
        e.raquiNeedleGauge = raquiNeedleGauge

        // Sedation
        e.sedationTechnique = sedationTechnique
        e.sedationType = sedationType
        e.intraVenousSedationType = intraVenousSedationType
        e.sedationOxygenSupply = sedationOxygenSupply

        // Peridural
        e.periduralPosition = periduralPosition
        e.periduralLevel = periduralLevel
        e.periduralNeedle = periduralNeedle
        e.periduralNeedleGauge = periduralNeedleGauge
        e.periduralTechnique = periduralTechnique
        e.periduralCateterFixation = periduralCateterFixation

        // Peripheral block
        e.blockEquipment = blockEquipment
        e.mmssTechnique = mmssTechnique
        e.mmiiTechnique = mmiiTechnique
        e.abdominalToraxTechnique = abdominalToraxTechnique
        e.blockSide = blockSide
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
    
    //Sedation
    
    func applySedationSuggestion(patientAge: Int) {
        sedationTechnique = .minimal
        if patientAge < 12 {
            sedationType = .combined
        } else {
            sedationType = .intravenous
        }
        intraVenousSedationType = .intermitent
        sedationOxygenSupply = .cateterNasal
    }
    
    func intraVenousPickerVisibility() {
        if sedationType == .inalatory {
            intraVenousSedationType = nil
        }
    }

}
