//
//  SRPAFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

private struct Validator {

    static func required<T>(_ value: T?, _ message: String) -> String? {
        value == nil ? message : nil
    }

    /// value não pode ser ANTES de reference
    static func cannotBeBefore(_ reference: Date?, _ value: Date?, _ message: String) -> String? {
        guard let reference, let value else { return nil }
        return value < reference ? message : nil
    }

    /// value não pode ser DEPOIS de reference
    static func cannotBeAfter(_ reference: Date?, _ value: Date?, _ message: String) -> String? {
        guard let reference, let value else { return nil }
        return value > reference ? message : nil
    }
}

@Observable
final class SRPAFormViewModel {
    var onDelete: (() -> Void)?
    
    var srpa: SRPA?
    var isEditing = false
    var errorMessage: String?
    var saveSuccess: Bool = false
    var resolvedSRPA: SRPA?
    
    var suggestedSurgeryStart: Date?
    var suggestedSurgeryEnd: Date?

    
    var techniques: [AnesthesiaTechniqueKind] = []
    var mmssBlocks: [MMSSTechnique] = []
    var mmiiBlocks: [MMIITechnique] = []
    var abdominalBlocks: [AbdominalToraxTechnique] = []
    var asa: ASAClassification? = nil

    var surgeryStart: Date?
    var surgeryEnd: Date?
    var srpaStart: Date?
    var srpaEnd: Date?
    var anesthesiaStart: Date?
    var anesthesiaEnd: Date?

    var statusRaw: String?
    var status: Status? {
        get { statusRaw.flatMap(Status.init(rawValue:)) }
        set { statusRaw = newValue?.rawValue }
    }
    var descriptionText: String?
    
    var srpaStartError: String?
    var srpaEndError: String?
    var techniquesError: String?
    var asaError: String?
    var touched: [String: Bool] = [
        "anesthesiaStart": false,
        "anesthesiaEnd": false,
        "srpaStart": false,
        "srpaEnd": false,
        "techniques": false,
        "asa": false,
    ]

    private let repository: SRPARepository
    private let sharedRepo: SharedPreAndAnesthesiaRepository
    private let user: User
    private let surgery: Surgery
    private let context: ModelContext
    private var isNew = false
    let surgeryDate: Date

    init(
        surgery: Surgery,
        user: User,
        context: ModelContext,
        sharedRepo: SharedPreAndAnesthesiaRepository
    ) {
        self.surgery = surgery
        self.user = user
        self.context = context
        self.repository = SwiftDataSRPARepository(context: context)
        self.sharedRepo = sharedRepo
        self.surgeryDate = Calendar.current.startOfDay(for: surgery.date)
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        self.anesthesiaEnd = surgery.anesthesia?.end
        self.anesthesiaStart = surgery.anesthesia?.start
        loadSRPA()
    }

    func loadSRPA() {
        let all = repository.getAll(for: surgery)
        srpa = all.first
        isNew = (srpa == nil)
        
        if let srpa = srpa {
            self.srpaStart = srpa.start
            self.srpaEnd = srpa.end
            self.statusRaw = srpa.statusRaw
            self.descriptionText = srpa.descriptionText
            let shared = sharedRepo.get(for: surgery) ?? srpa.shared
            if let shared {
                self.techniques = shared.techniques
                self.mmssBlocks = shared.mmssBlocks
                self.mmiiBlocks = shared.mmiiBlocks
                self.abdominalBlocks = shared.abdominalBlocks
                self.asa = shared.asa
            } else {
                self.asa = nil
            }
        }
        
        if isNew, let shared = surgery.shared {
            self.techniques = shared.techniques
            self.mmssBlocks = shared.mmssBlocks
            self.mmiiBlocks = shared.mmiiBlocks
            self.abdominalBlocks = shared.abdominalBlocks
            self.asa = shared.asa
        }
        
        self.anesthesiaStart = surgery.anesthesia?.start
        self.anesthesiaEnd = surgery.anesthesia?.end
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        self.suggestedSurgeryStart = nil
        self.suggestedSurgeryEnd = nil
        
    }

    func save() -> Bool {
        saveSuccess = false
        resolvedSRPA = nil
        runValidations()
        guard isFormValid else {
            return false
        }

        if srpa == nil {
            let new = SRPA(
                srpaId: UUID().uuidString,
                surgery: surgery,
                medications: [],
                vitalSigns: [],
                start: srpaStart,
                end: srpaEnd,
                statusRaw: self.statusRaw,
                createdBy: user,
                updatedBy: nil,
                createdAt: Date(),
                updatedAt: nil,
            )
            new.shared = sharedRepo.ensure(for: surgery)
            self.srpa = new
            self.isNew = true
        }

        guard let srpa = srpa else {
            errorMessage = "SRPA inválida."
            return false
        }

        srpa.start = srpaStart
        srpa.end = srpaEnd
        srpa.statusRaw = statusRaw
        srpa.descriptionText = descriptionText
        
        let shared = sharedRepo.ensure(for: surgery)
        shared.techniques = techniques
        shared.mmssBlocks = mmssBlocks
        shared.mmiiBlocks = mmiiBlocks
        shared.abdominalBlocks = abdominalBlocks
        shared.asa = asa
        srpa.shared = shared
    

        surgery.start = surgeryStart
        surgery.end = surgeryEnd

        do {
            if isNew {
                try repository.create(srpa: srpa, for: surgery, by: user)
            } else {
                try repository.update(srpa: srpa, for: surgery, by: user)
            }
            loadSRPA()
            self.isNew = false
            resolvedSRPA = self.srpa
            saveSuccess = true
            return true
        } catch {
            errorMessage = "Erro ao salvar SRPA: \(error.localizedDescription)"
            saveSuccess = false
            resolvedSRPA = nil
            return false
        }
    }

    func delete() {
        guard let srpa = srpa else { return }
        self.srpa = nil
        self.isNew = true
        resolvedSRPA = nil
        saveSuccess = false
        do {
            try repository.delete(srpa: srpa, from: surgery)
            onDelete?()
        } catch {
            errorMessage = "Erro ao deletar SRPA: \(error.localizedDescription)"
        }
        
    }
    
    func runValidations() {
        clearErrors()
        validateSRPAStart()
        validateSRPAEnd()
        validateAnesthesiaTechnique()
        validateASA()
    }

    var isFormValid: Bool {
        let noErrors = [
            srpaStartError,
            srpaEndError,
            techniquesError,
            asaError,
        ].allSatisfy { $0 == nil }

        if isNew {
            let requiredPresent =
                (srpaStart != nil)
            return noErrors && requiredPresent
        } else {
            let requiredPresent =
                (srpaStart != nil) &&
                (srpaEnd != nil)
            return noErrors && requiredPresent
        }
    }

    func validateSRPAStart() {
        guard touched["srpaStart"] == true else { return }

        srpaStartError = nil

        if isNew && srpaStart == nil {
            srpaStartError = "Informe o início da SRPA."
            return
        }

        guard let srpaStart else { return }

        srpaStartError =
            Validator.cannotBeBefore(anesthesiaEnd, srpaStart,
                "SRPA não pode iniciar antes do fim da anestesia.") ??
            Validator.cannotBeBefore(surgeryEnd, srpaStart,
                "SRPA não pode iniciar antes do fim da cirurgia.") ??
            Validator.cannotBeBefore(anesthesiaStart, srpaStart,
                "SRPA não pode iniciar antes da anestesia.") ??
            Validator.cannotBeBefore(surgeryDate, srpaStart,
                "Início da SRPA não pode ser antes da data da cirurgia - \(surgeryDate).")
    }

    func validateSRPAEnd() {
        guard touched["srpaEnd"] == true else { return }

        srpaEndError = nil

        if isNew && srpaEnd == nil {
            srpaEndError = "Informe o fim da SRPA."
            return
        }

        guard let srpaEnd else { return }

        srpaEndError =
            Validator.cannotBeBefore(srpaStart, srpaEnd,
                "SRPA não pode terminar antes de iniciar.") ??
            Validator.cannotBeBefore(anesthesiaStart, srpaEnd,
                "SRPA não pode terminar antes do início da anestesia.") ??
            Validator.cannotBeBefore(surgeryDate, srpaEnd,
                "Fim da SRPA não pode ser antes da data da cirurgia - \(surgeryDate).") ??
            Validator.cannotBeBefore(anesthesiaEnd, srpaEnd,
                "SRPA não pode terminar antes do fim da anestesia.") ??
            Validator.cannotBeBefore(surgeryEnd, srpaEnd,
                "SRPA não pode terminar antes do fim da cirurgia.")
    }

    func validateAnesthesiaTechnique() {
        guard touched["techniques"] == true else { return }
        techniquesError = nil
        if isNew && techniques.isEmpty {
            techniquesError = "Selecione ao menos uma técnica."
        }
    }

    func validateASA() {
        guard touched["asa"] == true else { return }
        asaError = nil
        if isNew && asa == nil {
            asaError = "Selecione uma classificação ASA."
        }
    }
    
    private func clearErrors() {
        srpaStartError = nil
        srpaEndError = nil
        techniquesError = nil
        asaError = nil
    }
    
    // Lógica de sugestões movida para funções explícitas
    func updateSuggestionsForStart() {
        guard let anesthesiaEnd else { return }
        let suggestion = Calendar.current.date(byAdding: .minute, value: 5, to: anesthesiaEnd)
        suggestedSurgeryStart = suggestion
        if touched["srpaStart"] != true {
            surgeryStart = suggestion
        }
    }
    
    func updateSuggestionsForEnd() {
        guard let srpaStart else { return }
        let suggestion = Calendar.current.date(byAdding: .minute, value: 60, to: srpaStart)
        suggestedSurgeryEnd = suggestion
        if touched["surgeryEnd"] != true {
            surgeryEnd = suggestion
        }
    }
}

