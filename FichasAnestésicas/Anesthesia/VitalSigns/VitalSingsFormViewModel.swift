//
//  VitalSingsViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 16/11/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

@MainActor
final class VitalSignsFormViewModel: ObservableObject {
    // MARK: - Dependencies
    let repo: VitalSignsEntryRepository
    let anesthesia: Anesthesia
    let user: User
    let context: ModelContext
    
    // MARK: - Editing state
    @Published var existingEntry: VitalSignEntry?
    @Published var isNew: Bool = true
    @Published var timestamp: Date = .init()
    @Published var fc: Double? = nil
    @Published var paS: Double? = nil
    @Published var paD: Double? = nil
    @Published var pam: Double? = nil
    @Published var spo2: Double? = nil
    @Published var rhythm: String? = nil
    @Published var etco2: Double? = nil
    @Published var fio2: Double? = nil
    @Published var peep: Double? = nil
    @Published var volumeCorrente: Double? = nil
    @Published var bis: Double? = nil
    @Published var pupilas: String? = nil
    @Published var tof: Double? = nil
    @Published var pvc: Double? = nil
    @Published var debitCardiaco: Double? = nil
    @Published var glicemia: Double? = nil
    @Published var lactato: Double? = nil
    @Published var temperatura: Double? = nil
    @Published var diurese: Double? = nil
    @Published var sangramento: Double? = nil
    
    // Touched flags for validation/UI state
    @Published var fcTouched: Bool = false
    @Published var paSTouched: Bool = false
    @Published var paDTouched: Bool = false
    @Published var rhythmTouched: Bool = false
    @Published var etco2Touched: Bool = false
    @Published var spo2Touched: Bool = false
    
    //vem de @model surgery através de @relationships
    @Published var anesthesiaStart: Date?
    @Published var anesthesiaEnd: Date?
    @Published var surgeryStart: Date?
    @Published var surgeryEnd: Date?
    @Published var patientAge: Int
    //vem de @model surgery através de @relationships com @model SharedPreAndAnesthesia
    @Published var techniques: [AnesthesiaTechniqueKind] = []
    @Published var asaClassification: ASAClassification? = nil
    @Published var anesthesiaPosition: [Positioning] = []
    
    //errors
    @Published var errorPam: String? = nil
    @Published var errorFc: String? = nil
    @Published var errorPaS: String? = nil
    @Published var errorPaD: String? = nil
    @Published var errorRhythm: String? = nil
    @Published var errorEtco2: String? = nil
    @Published var errorSpo2: String? = nil
    @Published var errorFio2: String? = nil
    @Published var errorPeep: String? = nil
    @Published var errorVolumeCorrente: String? = nil
    @Published var errorBis: String? = nil
    @Published var errorPupilas: String? = nil
    @Published var errorTof: String? = nil
    @Published var errorPvc: String? = nil
    @Published var errorDebitCardiaco: String? = nil
    @Published var errorGlicemia: String? = nil
    @Published var errorLactato: String? = nil
    @Published var errorTemperatura: String? = nil
    @Published var errorDiurese: String? = nil
    @Published var errorSangramento: String? = nil

    @Published var shouldDismissAfterGenerateSeries: Bool = false

    enum SeriesGenerationError: LocalizedError {
        case notInCreationMode
        case missingRequiredFields
        case cannotInferDuration

        var errorDescription: String? {
            switch self {
            case .notInCreationMode:
                return "Gerar série só é permitido no modo de criação."
            case .missingRequiredFields:
                return "Para gerar uma série, FC, PAS, PAD e SpO₂ precisam estar preenchidos."
            case .cannotInferDuration:
                return "Não foi possível determinar a duração da série. Informe manualmente ou preencha início e fim da anestesia."
            }
        }
    }

    var cancellables: Set<AnyCancellable> = []
    
    init(
        repo: VitalSignsEntryRepository,
        anesthesia: Anesthesia,
        user: User,
        context: ModelContext,
        existingEntry: VitalSignEntry? = nil
    ) {
        self.repo = repo
        self.anesthesia = anesthesia
        self.user = user
        self.context = context
        
        // Dados do relacionamento
        self.anesthesiaStart = anesthesia.start
        self.anesthesiaEnd = anesthesia.end
        self.surgeryStart = anesthesia.surgery.start
        self.surgeryEnd = anesthesia.surgery.end
        self.techniques = anesthesia.surgery.shared?.techniques ?? []
        self.asaClassification = anesthesia.surgery.shared?.asa
        self.anesthesiaPosition = anesthesia.position
        
        // Calcular idade do paciente usando AgeContext
        let ageContext = AgeContext.inSurgery(anesthesia.surgery)
        self.patientAge = ageContext.ageInYears(from: anesthesia.surgery.patient.birthDate)
        
        if let entry = existingEntry {
            // Modo edição
            // Garante que usamos a instância gerenciada pelo mesmo ModelContext deste ViewModel
            let managedEntry: VitalSignEntry
            let id = entry.vitalSignsId
            if let fetched = try? context.fetch(
                FetchDescriptor<VitalSignEntry>(
                    predicate: #Predicate { $0.vitalSignsId == id }
                )
            ).first {
                managedEntry = fetched
            } else {
                // Fallback: usa a própria referência recebida
                managedEntry = entry
            }

            self.existingEntry = managedEntry
            self.isNew = false
            self.timestamp = managedEntry.timestamp
            self.fc = managedEntry.fc
            self.paS = managedEntry.paS
            self.paD = managedEntry.paD
            self.pam = managedEntry.pam
            self.rhythm = managedEntry.rhythm
            self.etco2 = managedEntry.etco2
            self.spo2 = managedEntry.spo2
            self.fio2 = managedEntry.fio2
            self.peep = managedEntry.peep
            self.volumeCorrente = managedEntry.volumeCorrente
            self.bis = managedEntry.bis
            self.pupilas = managedEntry.pupilas
            self.tof = managedEntry.tof
            self.pvc = managedEntry.pvc
            self.debitCardiaco = managedEntry.debitCardiaco
            self.glicemia = managedEntry.glicemia
            self.lactato = managedEntry.lactato
            self.temperatura = managedEntry.temperatura
            self.diurese = managedEntry.diurese
            self.sangramento = managedEntry.sangramento
            
            // Initialize touched flags based on existing values
            self.fcTouched = managedEntry.fc != nil
            self.paSTouched = managedEntry.paS != nil
            self.paDTouched = managedEntry.paD != nil
            self.rhythmTouched = managedEntry.rhythm != nil
            self.etco2Touched = managedEntry.etco2 != nil
            self.spo2Touched = managedEntry.spo2 != nil
        } else {
            // Modo criação - timestamp sugerido com base na âncora (início da anestesia) e no último registro
            self.timestamp = computeNextSuggestedTimestamp()
            
            // New entry: untouched fields
            self.fcTouched = false
            self.paSTouched = false
            self.paDTouched = false
            self.rhythmTouched = false
            self.etco2Touched = false
            self.spo2Touched = false
        }
        setupValidationBindings()
    }
    
    // MARK: - Validation
        
    // MARK: - Time suggestion helpers
    func lastRecordedTimestamp() -> Date? {
        repo.getAll(for: anesthesia)
            .sorted { $0.timestamp < $1.timestamp }
            .last?
            .timestamp
    }

    func nextSuggestedTime(anchor: Date, last: Date?) -> Date {
        // Se não houver último registro, o primeiro ponto usa a âncora
        guard let last else {
            return anchor
        }

        // Calcula tempo decorrido entre a âncora (início da anestesia) e o último registro
        let elapsedMinutes = last.timeIntervalSince(anchor) / 60

        // Regra:
        // - Se elapsed < 30 min -> incremento de 5 min
        // - Senão -> incremento de 10 min
        let incrementMinutes: Double = elapsedMinutes < 30 ? 5 : 10

        return last.addingTimeInterval(incrementMinutes * 60)
    }

    func computeNextSuggestedTimestamp() -> Date {
        let anchor = anesthesia.start ?? Date()
        let last = lastRecordedTimestamp()
        return nextSuggestedTime(anchor: anchor, last: last)
    }

    // MARK: - Mapping helpers
    func makeEntry(from id: String? = nil) -> VitalSignEntry {
        // Build according to @Model VitalSignEntry initializer
        let entry = VitalSignEntry(
            vitalSignsId: id ?? UUID().uuidString,
            anesthesia: anesthesia,
            timestamp: timestamp
        )
        // Assign optional properties after init
        entry.fc = fc
        entry.paS = paS
        entry.paD = paD
        entry.pam = calculatePam(paS: paS, paD: paD)
        entry.rhythm = rhythm
        entry.etco2 = etco2
        entry.spo2 = spo2
        entry.fio2 = fio2
        entry.peep = peep
        entry.volumeCorrente = volumeCorrente
        entry.bis = bis
        entry.pupilas = pupilas
        entry.tof = tof
        entry.pvc = pvc
        entry.debitCardiaco = debitCardiaco
        entry.glicemia = glicemia
        entry.lactato = lactato
        entry.temperatura = temperatura
        entry.diurese = diurese
        entry.sangramento = sangramento
        return entry
    }

    // MARK: - Gerar sinais vitais automaticamente
    
    

        // MARK: - Repository passthrough API

    func get(by id: String) -> VitalSignEntry? {
        let entry = repo.get(by: id)
        if let entry {
            // Load into form state for editing
            existingEntry = entry
            isNew = false
            timestamp = entry.timestamp
            fc = entry.fc
            paS = entry.paS
            paD = entry.paD
            pam = entry.pam
            rhythm = entry.rhythm
            etco2 = entry.etco2
            spo2 = entry.spo2
            fio2 = entry.fio2
            peep = entry.peep
            volumeCorrente = entry.volumeCorrente
            bis = entry.bis
            pupilas = entry.pupilas
            tof = entry.tof
            pvc = entry.pvc
            debitCardiaco = entry.debitCardiaco
            glicemia = entry.glicemia
            lactato = entry.lactato
            temperatura = entry.temperatura
            diurese = entry.diurese
            sangramento = entry.sangramento
            
            // Initialize touched flags based on loaded entry
            fcTouched = entry.fc != nil
            paSTouched = entry.paS != nil
            paDTouched = entry.paD != nil
            rhythmTouched = entry.rhythm != nil
            spo2Touched = entry.spo2 != nil
        }
        return entry
    }

    func getAll() -> [VitalSignEntry] {
        return repo.getAll(for: anesthesia)
    }

    func createCurrent() throws {
        // Build entry from current form state and create
        let entry = makeEntry()
        try repo.create(entry, for: anesthesia, by: user)
        existingEntry = entry
        isNew = false
    }

    func updateCurrent() throws {
        // Require an existing entry to update
        guard let current = existingEntry else {
            throw NSError(
                domain: "VitalSignsFormViewModel",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Nenhuma entrada existente para atualizar."]
            )
        }

        // Copia os valores do form para o objeto gerenciado pelo SwiftData
        current.timestamp       = timestamp
        current.fc              = fc
        current.paS             = paS
        current.paD             = paD
        current.pam             = calculatePam(paS: paS, paD: paD)
        current.rhythm          = rhythm
        current.spo2            = spo2
        current.fio2            = fio2
        current.etco2           = etco2
        current.peep            = peep
        current.volumeCorrente  = volumeCorrente
        current.bis             = bis
        current.pupilas         = pupilas
        current.tof             = tof
        current.pvc             = pvc
        current.debitCardiaco   = debitCardiaco
        current.glicemia        = glicemia
        current.lactato         = lactato
        current.temperatura     = temperatura
        current.diurese         = diurese
        current.sangramento     = sangramento

        // Persiste as alterações
        try repo.update(current, for: anesthesia, by: user)

        // Garante que o ViewModel continue apontando para a entrada atualizada
        existingEntry = current
    }

    func deleteCurrent() throws {
        guard let current = existingEntry else {
            throw NSError(domain: "VitalSignsFormViewModel", code: 2, userInfo: [NSLocalizedDescriptionKey: "Nenhuma entrada existente para deletar."])
        }
        try repo.delete(current, for: anesthesia, by: user)
        // Reset form state after deletion
        existingEntry = nil
        isNew = true
        timestamp = computeNextSuggestedTimestamp()
        fc = nil
        paS = nil
        paD = nil
        pam = nil
        spo2 = nil
        rhythm = nil
        etco2 = nil
        fio2 = nil
        peep = nil
        volumeCorrente = nil
        bis = nil
        pupilas = nil
        tof = nil
        pvc = nil
        debitCardiaco = nil
        glicemia = nil
        lactato = nil
        temperatura = nil
        diurese = nil
        sangramento = nil
        
        fcTouched = false
        paSTouched = false
        paDTouched = false
        rhythmTouched = false
        etco2Touched = false
        spo2Touched = false
    }

    func deleteAll() throws {
        try repo.deleteAll(for: anesthesia, by: user)
        // Optional: also reset local state
        existingEntry = nil
        isNew = true
        timestamp = computeNextSuggestedTimestamp()
        fc = nil
        paS = nil
        paD = nil
        pam = nil
        spo2 = nil
        rhythm = nil
        fio2 = nil
        etco2 = nil
        peep = nil
        volumeCorrente = nil
        bis = nil
        pupilas = nil
        tof = nil
        pvc = nil
        debitCardiaco = nil
        glicemia = nil
        lactato = nil
        temperatura = nil
        diurese = nil
        sangramento = nil
        
        fcTouched = false
        paSTouched = false
        paDTouched = false
        rhythmTouched = false
        etco2Touched = false
        spo2Touched = false
    }
    
    // MARK: - Touched helpers
    func markFcTouched() { fcTouched = true }
    func markPaSTouched() { paSTouched = true }
    func markPaDTouched() { paDTouched = true }
    func markRhythmTouched() { rhythmTouched = true }
    func markEtco2Touched() { etco2Touched = true }
    func markSpo2Touched() { spo2Touched = true }
    
    //to-do: validations for each input, automatic register with variations
    //criteria: 1- techniques; 2- asa; 3- patientAge

    func calculatePam(paS: Double?, paD: Double?) -> Double? {
        guard let s = paS, let d = paD else { return nil }
        return (s + 2 * d) / 3
    }
}

extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
