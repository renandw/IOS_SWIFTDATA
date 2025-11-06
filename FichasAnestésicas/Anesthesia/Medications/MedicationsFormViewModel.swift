//
//  MedicationsFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//
import Foundation
import SwiftData
import SwiftUI
import Combine

@MainActor
final class MedicationsFormViewModel: ObservableObject {
    // MARK: - Dependencies
    private let repo: MedicationEntryRepository
    private let anesthesia: Anesthesia
    private let user: User
    private let context: ModelContext

    // MARK: - Editing state
    @Published var existingEntry: MedicationEntry?
    @Published var isNew: Bool = true

    // MARK: - Form fields
    @Published var name: String = ""
    @Published var dose: String = ""
    @Published var via: AdministrationRoute? = nil
    @Published var category: MedicationCategory? = nil
    @Published var timestamp: Date = .init()

    ///patientWeigth vem do @model Surgery através de @relationships
    @Published var patientWeight: Double = 0
    /// Controle: recalcular dose automaticamente ao mudar peso/nome
    @Published var autoDose: Bool = true

    // MARK: - Errors
    @Published var nameError: String?
    @Published var doseError: String?
    @Published var viaError: String?
    @Published var categoryError: String?
    @Published var errorMessage: String?

    // MARK: - Init
    init(anesthesia: Anesthesia, user: User, context: ModelContext, repo: MedicationEntryRepository? = nil, entry: MedicationEntry? = nil) {
        self.anesthesia = anesthesia
        self.user = user
        self.context = context
        self.repo = repo ?? SwiftDataMedicationEntryRepository(context: context)
        self.existingEntry = entry
        self.isNew = (entry == nil)
        self.patientWeight = anesthesia.surgery.weight
        

        if let entry {
            self.name = entry.name
            self.dose = entry.dose
            self.via = entry.via
            self.category = entry.category
            self.timestamp = entry.timestamp
        } else {
            // Sugestões iniciais vazias; timestamp = agora
            self.timestamp = Date()
            
        }
    }

    // MARK: - Presets & Suggestions
    func applyPreset(_ item: MedicationPresetItem) {
        name = item.name
        category = item.category
        via = item.via
        dose = item.dose
        // Recalcular dose conforme peso se autoDose ativo
        recalcDoseIfNeeded()
    }

    func suggestViaIfNeeded() {
        guard via == nil, !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        via = MedicationsHelper.getSuggestedVia(for: name)
    }

    func recalcDoseIfNeeded() {
        guard autoDose else { return }
        // Usa o peso da cirurgia
        let weight = anesthesia.surgery.weight
        let calculated = MedicationsHelper.getWeightBasedDose(medication: name, weight: weight)
        if !calculated.isEmpty { dose = calculated }
    }

    // MARK: - Validation
    func runValidations() {
        clearErrors()
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            nameError = "Informe o nome da medicação."
        }
        if dose.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            doseError = "Informe a dose."
        }
        if via == nil {
            viaError = "Selecione a via."
        }
        if category == nil {
            categoryError = "Selecione a categoria."
        }
    }

    var isFormValid: Bool {
        let noErrors = [nameError, doseError, viaError, categoryError].allSatisfy { $0 == nil }
        let required = !name.isEmpty && !dose.isEmpty && via != nil && category != nil
        return noErrors && required
    }

    private func clearErrors() {
        nameError = nil
        doseError = nil
        viaError = nil
        categoryError = nil
        errorMessage = nil
    }

    // MARK: - Persistence
    @discardableResult
    func save() -> Bool {
        runValidations()
        guard isFormValid else { return false }

        do {
            if let entry = existingEntry {
                // Update
                entry.name = name
                entry.dose = dose
                entry.via = via ?? entry.via
                entry.category = category ?? entry.category
                entry.timestamp = timestamp
                try repo.update(entry, for: anesthesia, by: user)
            } else {
                // Create
                let new = MedicationEntry(
                    medicationId: UUID().uuidString,
                    anesthesia: anesthesia,
                    categoryRaw: (category ?? .opioide).rawValue,
                    viaRaw: (via ?? .EV).rawValue,
                    dose: dose,
                    name: name,
                    timestamp: timestamp
                )
                try repo.create(new, for: anesthesia, by: user)
                self.existingEntry = new
                self.isNew = false
            }
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    @discardableResult
    func delete() -> Bool {
        guard let entry = existingEntry else { return false }
        do {
            try repo.delete(entry, for: anesthesia, by: user)
            existingEntry = nil
            isNew = true
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    @discardableResult
    func deleteAll() -> Bool {
        do {
            try repo.deleteAll(for: anesthesia, by: user)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func reset() {
        name = ""
        dose = ""
        via = nil
        category = nil
        timestamp = Date()
        clearErrors()
        // mantém isNew conforme contexto do formulário
    }
    // Cria várias medicações a partir de itens de preset
    @discardableResult
    func createEntries(from items: [MedicationPresetItem], at date: Date = .init()) -> Bool {
        guard !items.isEmpty else { return true }

        do {
            for item in items {
                let entry = item.makeEntry(for: anesthesia, at: date)
                try repo.create(entry, for: anesthesia, by: user)
            }
            return true
        } catch {
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}
