//
//  TechniqueSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 21/11/25.
//
import SwiftUI

@Observable
final class TechniquesSectionViewModel {
    //shared
    var mmssBlocks: [MMSSTechnique] = []
    var mmiiBlocks: [MMIITechnique] = []
    var abdominalBlocks: [AbdominalToraxTechnique] = []
    
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
    var tubeType: TubeType? {didSet { tubeTypeeNasalVisibility(); tubeTypeDoubleLumenVisibility(); tubeTypeVisibility()  } }
    var tubeAcess: TubeAcess? { didSet {tubeAcessVisibility() } }
    var tubeCuff: TubeCuff? {didSet {tubeTypeAramadoVisibility() } }
    var tubeRoute: TubeRoute? {didSet {tubeRouteVisibility() } }
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
        //shared
        mmssBlocks = e.shared?.mmssBlocks ?? []
        mmiiBlocks = e.shared?.mmiiBlocks ?? []
        abdominalBlocks = e.shared?.abdominalBlocks ?? []
        
        print("e.shared:", String(describing: e.shared))
        print("mmssBlocks count:", e.shared?.mmssBlocks.count ?? 0)
        
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
    
    func resetSedationSelection() {
        sedationTechnique = nil
        sedationType = nil
        intraVenousSedationType = nil
        sedationOxygenSupply = nil
    }
    
    // GeneralAnesthesia
    
    func applyGeneralAnesthesiaSuggestion(patientAge: Int, patientWeight: Double, patientSex: Sex) {
        tubeAcess = .inORInserted
        equipment = .laringoscope
        tubeType = .common
        visualizationMethod = .direct
        cormack = .grade2a
        tubeRoute = .oral
        tubeCuff = .with
        
        if patientAge > 12 {
            // Adulto
            if patientSex == .male {
                totNumber = "7.5"
                fixation = "22"
            } else {
                totNumber = "7"
                fixation = "21"
            }
        } else if patientAge >= 2 {
            // Pediátrico (2-12 anos)
            let calculatedTube = (Double(patientAge) / 4.0) + 3.5
            let roundedTube = (calculatedTube * 2).rounded() / 2
            totNumber = String(format: "%.1f", roundedTube)
            fixation = String(format: "%.0f", roundedTube * 3.0)
        } else {
            // < 2 anos: baseado no peso
            let tube: Double
            switch patientWeight {
            case ..<1:
                tube = 2.5
            case 1..<2:
                tube = 3.0
            case 2..<3.5:
                tube = 3.0
            case 3.5..<7:
                tube = 3.5
            case 7..<10:
                tube = 3.5
            case 10...:
                tube = 4.0
            default:
                tube = 3.0
            }
            totNumber = String(format: "%.1f", tube)
            fixation = String(format: "%.0f", tube * 3.0)
        }
    }
    
    func tubeAcessVisibility(){
        if tubeAcess == .previouslyInserted {
            visualizationMethod = nil
            cormack = nil
            equipment = nil
        }
    }
    func tubeTypeVisibility(){
        if tubeType == .traqueal {
            tubeRoute = nil
            tubeCuff = nil
            fixation = nil
            tubeRoute = nil
            visualizationMethod = nil
            cormack = nil
            equipment = nil
            totNumber = nil
        }
    }
    func tubeTypeAramadoVisibility(){
        if tubeType == .aramado {
            tubeCuff = .with
        }
    }
    func tubeRouteVisibility(){
        if tubeRoute == .nasal {
            fixation = nil
        }
    }
    func tubeTypeeNasalVisibility(){
        if tubeType == .eNasal {
            tubeRoute = .nasal
        }
    }
    func tubeTypeDoubleLumenVisibility(){
        if tubeType == .doubleLumen {
            tubeRoute = .oral
        }
    }
    func resetGeneralAnesthesia(){
        visualizationMethod = nil
        equipment = nil
        tubeType = nil
        tubeAcess = nil
        tubeCuff = nil
        tubeRoute = nil
        totNumber = nil
        cormack = nil
        fixation = nil
    }
    
    // SpinalAnesthesia
    
    func applySpinalAnesthesiaSuggestion(patientAge: Int){
        raquiPosition = .seated
        raquiNeedle = .quincke
        if patientAge < 12 {
            raquiLevel = .l4
            raquiNeedleGauge = .g27
        } else {
            raquiLevel = .l3
            raquiNeedleGauge = .g26
        }
    }
    
    func resetSpinalAnesthesia(){
        raquiPosition = nil
        raquiLevel = nil
        raquiNeedle = nil
        raquiNeedleGauge = nil
    }
    
    //PeriduralAnesthesia
    
    func applyPeriduralAnesthesiaSuggestion(patientAge: Int){
        periduralPosition = .seated
        periduralLevel = .l4
        periduralNeedle = .thuohy
        periduralTechnique = .dogliotti
        periduralCateterFixation = nil
        if patientAge < 12 {
            periduralNeedleGauge = .g22
        } else {
            periduralNeedleGauge = .g18
        }
    }
    
    func resetPeriduralAnesthesia(){
        periduralPosition = nil
        periduralLevel = nil
        periduralNeedle = nil
        periduralTechnique = nil
        periduralCateterFixation = nil
        periduralNeedleGauge = nil
    }
    
    // PeripheralBlockAnesthesia
    
    func applyPeripheralBlockAnesthesiaSuggestion(){
        blockEquipment = .usg
    }
    
    func resetPeripheralBlockAnesthesia(){
        blockEquipment = nil
        mmssTechnique = nil
        mmiiTechnique = nil
        abdominalToraxTechnique = nil
        blockSide = nil
        blockOthers = nil
    }
    
    // geral
    
    func applyTechinquesSuggestion(hasGeneralAnesthesia: Bool, hasSpinalAnesthesia: Bool, hasPeridualAnesthesia: Bool, hasPeripheralBlockAnesthesia: Bool, hasSedationAnesthesia: Bool, hasLocalAnesthesia: Bool, patientAge: Int, patientWeight: Double, patientSex: Sex) {
        localAnesthesia = hasLocalAnesthesia
        
        if hasGeneralAnesthesia {
            generalAnesthesia = hasGeneralAnesthesia
            applyGeneralAnesthesiaSuggestion(patientAge: patientAge, patientWeight: patientWeight, patientSex: patientSex)
        }
        if hasSedationAnesthesia {
            sedationAnesthesia = hasSedationAnesthesia
            applySedationSuggestion(patientAge: patientAge)
        }
        if hasSpinalAnesthesia {
            spinalAnesthesia = hasSpinalAnesthesia
            applySpinalAnesthesiaSuggestion(patientAge: patientAge)
        }
        if hasPeridualAnesthesia {
            periduralAnesthesia = hasPeridualAnesthesia
            applyPeriduralAnesthesiaSuggestion(patientAge: patientAge)
        }
        if hasPeripheralBlockAnesthesia {
            peripheralAnesthesia = hasPeripheralBlockAnesthesia
            applyPeripheralBlockAnesthesiaSuggestion()
        }
    }
    
    //GeneralAnesthesiaText
    
    func generateTechniqueGeneralAnesthesiaText(patientAge: Int) -> String {
        var parts: [String] = []
        
        if let tubeAccess = tubeAcess?.reportDisplayName {
            parts.append(tubeAccess)
        }
        
        if let equipment = equipment?.reportDisplayName {
            parts.append(equipment)
        }
        
        if let visualizationMethod = visualizationMethod?.reportDisplayName {
            parts.append(visualizationMethod)
        }
        
        if let cormack = cormack?.reportDisplayName {
            parts.append(cormack)
        }

        if let tubeRoute = tubeRoute?.reportDisplayName {
            parts.append(tubeRoute)
        }
        
        if let tubeType = tubeType?.reportDisplayName {
            parts.append(tubeType)
        }
        
        if let totNumber = totNumber {
            parts.append("nº \(totNumber)")
        }
        
        if let tubeCuff = tubeCuff?.reportDisplayName {
            parts.append(tubeCuff)
        }
        
        if let fixation = fixation {
            parts.append("fixado a \(fixation)cm da rima labial")
        }

        guard !parts.isEmpty else { return "" }
        
        if tubeAcess == .previouslyInserted {
            return "Anestesia geral: \(parts.joined(separator: ", ")), infusão de medicações descritas na seção de medicamentos."
        } else {
            return "Anestesia geral: pré-oxigenação O2 100%, infusão de medicações descritas na seção de medicamentos, \(parts.joined(separator: ", "))."
        }
    }
    
    //SedationAnesthesiaText
    func generateTechniqueSedationAnesthesiaText(patientAge: Int) -> String {
        var parts: [String] = []
        
        if let sedationTechnique = sedationTechnique?.reportDisplayName {
            parts.append(sedationTechnique)
        }
        
        if let sedationType = sedationType?.reportDisplayName {
            parts.append(sedationType)
        }
        
        if let intraVenousSedationType = intraVenousSedationType?.reportDisplayName {
            parts.append(intraVenousSedationType)
        }
        
        if let sedationOxygenSupply = sedationOxygenSupply?.reportDisplayName(for: patientAge) {
            parts.append(sedationOxygenSupply)
        }

        guard !parts.isEmpty else { return "" }
        return "Sedoanalgesia: \(parts.joined(separator: ", ")), infusão de medicações descritas na seção de medicamentos."
        
    }

    func generateTechniqueSpinalAnesthesiaText() -> String {
        var parts: [String] = []
        
        if let raquiPosition = raquiPosition?.reportDisplayName {
            parts.append(raquiPosition)
        }
        
        if let raquiNeedle = raquiNeedle?.reportDisplayName {
            parts.append(raquiNeedle)
        }
        
        if let raquiLevel = raquiLevel?.reportDisplayName {
            parts.append(raquiLevel)
        }
        
        if let raquiNeedleGauge = raquiNeedleGauge?.DisplayName {
            parts.append(raquiNeedleGauge)
        }

        // Se não houver nenhum dado preenchido, não retorna texto
        guard !parts.isEmpty else { return "" }
        
        let partAssepsia = "assepsia e antissepsia de mãos e de dorso do paciente, punção única de espaço subaracnóide via paramediana"
        parts.insert(partAssepsia, at: min(1, parts.count))

        return "Raquianestesia: \(parts.joined(separator: ", ")), LCR límpido, claro, sem presença de sangue, sem acidentes de punção. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores."
    }
    
    func generateTechniquePeriduralAnesthesiaText() -> String {
        var parts: [String] = []
        
        if let periduralPosition = periduralPosition?.reportDisplayName {
            parts.append(periduralPosition)
        }
        
        if let periduralNeedle = periduralNeedle?.reportDisplayName {
            parts.append(periduralNeedle)
        }
        
        if let periduralLevel = periduralLevel?.reportDisplayName {
            parts.append(periduralLevel)
        }
        
        if let periduralNeedleGauge = periduralNeedleGauge?.DisplayName {
            parts.append(periduralNeedleGauge)
        }
        
        if let periduralTechnique = periduralTechnique?.DisplayName {
            parts.append(periduralTechnique)
        }
        
        if let periduralCateterFixation = periduralCateterFixation {
            parts.append("insiro cateter peridural sem intercorrências, fixado na marca de: \(periduralCateterFixation)cm da pele")
        }
        
        // Se não houver nenhum dado preenchido, não retorna texto
        guard !parts.isEmpty else { return "" }
        
        let partAssepsia = "assepsia e antissepsia de mãos e de dorso do paciente, punção única de espaço peridural via paramediana"
        parts.insert(partAssepsia, at: min(1, parts.count))

        return "Peridural: \(parts.joined(separator: ", ")),sem presença de sangue e sem acidentes de punção.Após injeção de dose teste com adrenalina. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores."
    }
    
    func generateTechniquePeripheralBlockAnesthesiaText(patientAge: Int) -> String {
        var parts: [String] = []
        
        if let blockEquipment = blockEquipment?.reportDisplayName {
            parts.append(blockEquipment)
        }
        
        print("mmssBlocks na geração:", mmssBlocks) // ← Adicione
        print("mmiiBlocks na geração:", mmiiBlocks)
        print("abdominalBlocks na geração:", abdominalBlocks)
        
        parts += mmssBlocks.map { $0.reportDisplayName }
        parts += mmiiBlocks.map { $0.reportDisplayName }
        parts += abdominalBlocks.map { $0.reportDisplayName }
        
        print("Parts após bloqueios:", parts)
        
        if let blockOthers = blockOthers {
            parts.append("\(blockOthers)")
        }
        
        if let blockSide = blockSide?.DisplayName{
            parts.append(blockSide)
        }
        
        guard !parts.isEmpty else { return "" }
        return "Bloqueios de nervos periféricos: assepsia e antissepsia de mãos e do paciente \(parts.joined(separator: ", ")),sem presença de sangue e sem acidentes de punção.Após injeção de dose teste com adrenalina. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores. "
        
    }
    
    func generateTechniqueLocalAnesthesiaText(patientAge: Int) -> String {

        var parts: [String] = []
        
        if localAnesthesia {
            parts.append("anestesia local")
        }
    

        guard !parts.isEmpty else { return "" }
        return "Foi realizado\(parts.joined(separator: ", ")) pela equipe cirúrgica. Procedimento sem intercorrências "
        
    }
}

