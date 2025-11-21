//
//  MedicationsFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//
import Foundation
import SwiftData
import SwiftUI
import Combine

@MainActor
@Observable
final class MedicationsFormViewModel {
    // MARK: - Dependencies
    private let repo: MedicationEntryRepository
    private let anesthesia: Anesthesia
    private let user: User
    private let context: ModelContext

    // MARK: - Editing state
    var existingEntry: MedicationEntry?
    var isNew: Bool = true

    // MARK: - Form fields
    var name: String = ""
    var dose: String = ""
    var via: AdministrationRoute? = nil
    var category: MedicationCategory? = nil
    var timestamp: Date = .init()

    var patientWeight: Double = 0
    var anesthesiaStart: Date?
    var autoDose: Bool = true

    // MARK: - Errors
    var nameError: String?
    var doseError: String?
    var viaError: String?
    var categoryError: String?
    var errorMessage: String?
    
    // MARK: - AutoComplete
    var searchQuery: String = "" {
        didSet { scheduleFilter() }
    }
    var showSuggestions: Bool = false
    var filteredCatalog: [MedicationCatalogItem] = []
    
    private var filterTask: Task<Void, Never>?
    private let catalog: [MedicationCatalogItem]

    // MARK: - Init
    init(
        anesthesia: Anesthesia,
        user: User,
        context: ModelContext,
        catalog: [MedicationCatalogItem],
        repo: MedicationEntryRepository? = nil,
        entry: MedicationEntry? = nil
    ) {
        self.anesthesia = anesthesia
        self.user = user
        self.context = context
        self.catalog = catalog
        self.repo = repo ?? SwiftDataMedicationEntryRepository(context: context)
        self.existingEntry = entry
        self.isNew = (entry == nil)
        self.patientWeight = anesthesia.surgery.weight
        self.anesthesiaStart = anesthesia.start
        
        if let entry {
            self.name = entry.name
            self.dose = entry.dose
            self.via = entry.via
            self.category = entry.category
            self.timestamp = entry.timestamp
            self.searchQuery = entry.name
        } else {
            self.timestamp = anesthesia.start ?? Date()
        }
    }

    // MARK: - Autocomplete (debounce via Task)
    private func scheduleFilter() {
        filterTask?.cancel()
        filterTask = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(150))
            guard !Task.isCancelled else { return }
            self?.filterCatalog()
        }
    }

    private func filterCatalog() {
        let trimmed = searchQuery.trimmingCharacters(in: .whitespaces)
        
        if trimmed.count < 3 {
            filteredCatalog = []
            showSuggestions = false
            return
        }
        
        if catalog.contains(where: { $0.name.lowercased() == trimmed.lowercased() }) {
            filteredCatalog = []
            showSuggestions = false
            return
        }
        
        let lowercased = trimmed.lowercased()
        filteredCatalog = Array(catalog.filter {
            $0.name.lowercased().contains(lowercased)
        }.prefix(7))
        showSuggestions = !filteredCatalog.isEmpty
    }

    // MARK: - Presets & Suggestions
    func applyPreset(_ item: MedicationPresetItem) {
        name = item.name
        category = item.category
        via = item.via
        dose = item.dose
        recalcDoseIfNeeded()
    }

    func suggestViaIfNeeded() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        via = MedicationsHelper.getSuggestedVia(for: name)
    }

    func recalcDoseIfNeeded() {
        guard autoDose else { return }
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
                entry.name = name
                entry.dose = dose
                entry.via = via ?? entry.via
                entry.category = category ?? entry.category
                entry.timestamp = timestamp
                try repo.update(entry, for: anesthesia, by: user)
            } else {
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
    }

    @discardableResult
    func createEntries(from items: [MedicationPresetItem], at date: Date = .init()) -> Bool {
        guard !items.isEmpty else { return true }

        do {
            for item in items {
                let entry = item.makeEntry(for: anesthesia, at: date, weight: anesthesia.surgery.weight)
                try repo.create(entry, for: anesthesia, by: user)
            }
            return true
        } catch {
            self.errorMessage = error.localizedDescription
            return false
        }
    }

    func selectCatalogItem(_ item: MedicationCatalogItem) {
        name = item.name
        searchQuery = item.name
        category = item.category
        showSuggestions = false
        suggestViaIfNeeded()
        recalcDoseIfNeeded()
        runValidations()
    }

    func dismissSuggestions() {
        showSuggestions = false
    }
}
