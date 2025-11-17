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
    private let repo: VitalSignsEntryRepository
    private let anesthesia: Anesthesia
    private let user: User
    private let context: ModelContext
    
    // MARK: - Editing state
    @Published var existingEntry: VitalSignEntry?
    @Published var isNew: Bool = true
    @Published var timestamp: Date = .init()
    @Published var fc: Double? = nil
    @Published var paS: Double? = nil
    @Published var paD: Double? = nil
    @Published var spo2: Double? = nil
    @Published var rhythm: String? = nil
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
    
    //vem de @model surgery através de @relationships
    @Published var anesthesiaStart: Date?
    @Published var anesthesiaEnd: Date?
    @Published var surgeryStart: Date?
    @Published var surgeryEnd: Date?
    //vem de @model surgery através de @relationships com @model SharedPreAndAnesthesia
    @Published var techniques: [AnesthesiaTechniqueKind] = []
    @Published var asaClassification: ASAClassification? = nil
    
    //errors
    @Published var errorPam: String? = nil
    @Published var errorFc: String? = nil
    @Published var errorPaS: String? = nil
    @Published var errorPaD: String? = nil
    @Published var errorRhythm: String? = nil
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
        
        if let entry = existingEntry {
            // Modo edição
            self.existingEntry = entry
            self.isNew = false
            self.timestamp = entry.timestamp
            self.fc = entry.fc
            self.paS = entry.paS
            self.paD = entry.paD
            self.rhythm = entry.rhythm
            self.spo2 = entry.spo2
            self.fio2 = entry.fio2
            self.peep = entry.peep
            self.volumeCorrente = entry.volumeCorrente
            self.bis = entry.bis
            self.pupilas = entry.pupilas
            self.tof = entry.tof
            self.pvc = entry.pvc
            self.debitCardiaco = entry.debitCardiaco
            self.glicemia = entry.glicemia
            self.lactato = entry.lactato
            self.temperatura = entry.temperatura
            self.diurese = entry.diurese
            self.sangramento = entry.sangramento
        } else {
            // Modo criação - timestamp com fallback
            self.timestamp = anesthesia.start ?? Date()
        }
    }
    
    // MARK: - Mapping helpers
    private func makeEntry(from id: String? = nil) -> VitalSignEntry {
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
        entry.rhythm = rhythm
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
            rhythm = entry.rhythm
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
        // Require an existing entry id to update
        guard let current = existingEntry else {
            throw NSError(domain: "VitalSignsFormViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Nenhuma entrada existente para atualizar."])
        }
        let updated = makeEntry(from: current.vitalSignsId)
        try repo.update(updated, for: anesthesia, by: user)
        existingEntry = updated
    }

    func deleteCurrent() throws {
        guard let current = existingEntry else {
            throw NSError(domain: "VitalSignsFormViewModel", code: 2, userInfo: [NSLocalizedDescriptionKey: "Nenhuma entrada existente para deletar."])
        }
        try repo.delete(current, for: anesthesia, by: user)
        // Reset form state after deletion
        existingEntry = nil
        isNew = true
        timestamp = anesthesia.start ?? Date()
        fc = nil
        paS = nil
        paD = nil
        spo2 = nil
        rhythm = nil
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
    }

    func deleteAll() throws {
        try repo.deleteAll(for: anesthesia, by: user)
        // Optional: also reset local state
        existingEntry = nil
        isNew = true
        timestamp = anesthesia.start ?? Date()
        fc = nil
        paS = nil
        paD = nil
        spo2 = nil
        rhythm = nil
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
    }

}
