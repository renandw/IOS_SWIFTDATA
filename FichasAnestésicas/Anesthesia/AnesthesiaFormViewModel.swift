import Foundation
import SwiftData
import SwiftUI
import Combine

private struct Validator {
    static func required<T>(_ value: T?, _ message: String) -> String? {
        value == nil ? message : nil
    }
    static func after(_ a: Date?, _ b: Date?, _ message: String) -> String? {
        guard let a, let b, a > b else { return nil }
        return message
    }
    static func before(_ a: Date?, _ b: Date?, _ message: String) -> String? {
        guard let a, let b, a < b else { return nil }
        return message
    }
}

@Observable
final class AnesthesiaFormViewModel {
    var anesthesia: Anesthesia?
    var isEditing = false
    var errorMessage: String?
    var saveSuccess: Bool = false
    var resolvedAnesthesia: Anesthesia?
    
    var suggestedSurgeryStart: Date?
    var suggestedSurgeryEnd: Date?

    var start: Date?
    var end: Date?
    var techniques: [AnesthesiaTechniqueKind] = []
    var asa: ASAClassification? = nil
    var position: [Positioning] = []
    var surgeryStart: Date?
    var surgeryEnd: Date?
    
    var anesthesiaStartError: String?
    var anesthesiaEndError: String?
    var surgeryStartError: String?
    var surgeryEndError: String?
    var techniquesError: String?
    var asaError: String?
    var positionError: String?
    var touched: [String: Bool] = [
        "anesthesiaStart": false,
        "anesthesiaEnd": false,
        "surgeryStart": false,
        "surgeryEnd": false,
        "techniques": false,
        "asa": false,
        "position": false
    ]

    private let repository: AnesthesiaRepository
    private let sharedRepo: SharedPreAndAnesthesiaRepository
    private let user: User
    private let surgery: Surgery
    private let context: ModelContext
    private var isNew = false
    let surgeryDate: Date

    init(
        surgery: Surgery,
        user: User,
        context: ModelContext
    ) {
        self.surgery = surgery
        self.user = user
        self.context = context
        self.repository = SwiftDataAnesthesiaRepository(context: context)
        self.sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: context)
        self.surgeryDate = Calendar.current.startOfDay(for: surgery.date)
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        loadAnesthesia()
    }

    func loadAnesthesia() {
        let all = repository.getAll(for: surgery)
        anesthesia = all.first
        isNew = (anesthesia == nil)
        
        if let anesthesia = anesthesia {
            self.start = anesthesia.start
            self.end = anesthesia.end
            let shared = sharedRepo.get(for: surgery) ?? anesthesia.shared
            if let shared {
                self.techniques = shared.techniques
                self.asa = shared.asa
            } else {
                self.asa = nil
            }
            self.position = anesthesia.position
        }
        
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        self.suggestedSurgeryStart = nil
        self.suggestedSurgeryEnd = nil
    }

    func save() -> Bool {
        saveSuccess = false
        resolvedAnesthesia = nil
        runValidations()
        guard isFormValid else {
            return false
        }

        if anesthesia == nil {
            let new = Anesthesia(
                anesthesiaId: UUID().uuidString,
                surgery: surgery,
                anesthesiaDescription: nil,
                anesthesiaTechniqueRaw: [],
                medications: [],
                vitalSigns: [],
                start: start,
                end: end,
                statusRaw: nil,
                createdBy: user,
                updatedBy: nil,
                createdAt: Date(),
                updatedAt: nil,
                positionRaw: position.map {$0.rawValue}
            )
            new.shared = sharedRepo.ensure(for: surgery)
            self.anesthesia = new
            self.isNew = true
        }

        guard let anesthesia = anesthesia else {
            errorMessage = "Anesthesia inválida."
            return false
        }

        anesthesia.start = start
        anesthesia.end = end
        
        let shared = sharedRepo.ensure(for: surgery)
        shared.techniques = techniques
        shared.asa = asa
        anesthesia.shared = shared
        anesthesia.position = position

        surgery.start = surgeryStart
        surgery.end = surgeryEnd

        do {
            if isNew {
                try repository.create(anesthesia: anesthesia, for: surgery, by: user)
            } else {
                try repository.update(anesthesia: anesthesia, for: surgery, by: user)
            }
            loadAnesthesia()
            self.isNew = false
            resolvedAnesthesia = self.anesthesia
            saveSuccess = true
            return true
        } catch {
            errorMessage = "Erro ao salvar anestesia: \(error.localizedDescription)"
            saveSuccess = false
            resolvedAnesthesia = nil
            return false
        }
    }

    func delete() {
        guard let anesthesia = anesthesia else { return }
        self.anesthesia = nil
        self.isNew = true
        resolvedAnesthesia = nil
        saveSuccess = false
        do {
            try repository.delete(anesthesia: anesthesia, from: surgery)
        } catch {
            errorMessage = "Erro ao deletar anestesia: \(error.localizedDescription)"
        }
    }
    
    func runValidations() {
        clearErrors()
        validateAnesthesiaStart()
        validateSurgeryStart()
        validateSurgeryEnd()
        validateAnesthesiaEnd()
        validateAnesthesiaTechnique()
        validateASA()
        validatePosition()
    }

    var isFormValid: Bool {
        let noErrors = [
            anesthesiaStartError,
            anesthesiaEndError,
            surgeryStartError,
            surgeryEndError,
            techniquesError,
            asaError,
            positionError,
        ].allSatisfy { $0 == nil }

        if isNew {
            let requiredPresent =
                (start != nil) &&
                (surgeryStart != nil) &&
                !techniques.isEmpty &&
                (asa != nil) &&
                !position.isEmpty
            return noErrors && requiredPresent
        } else {
            let requiredPresent =
                (start != nil) &&
                (surgeryStart != nil) &&
                !techniques.isEmpty &&
                (asa != nil) &&
                !position.isEmpty &&
                (surgeryEnd != nil) &&
                (end != nil)
            return noErrors && requiredPresent
        }
    }

    func validateAnesthesiaStart() {
        guard touched["anesthesiaStart"] == true else { return }
        anesthesiaStartError = nil
        if isNew {
            if let msg = Validator.required(start, "Informe o início da anestesia.") {
                anesthesiaStartError = msg
                return
            }
        }
        anesthesiaStartError =
            Validator.before(start, surgeryDate, "Início da anestesia não pode ser antes da data da cirurgia - \(surgeryDate).") ??
            Validator.after(start, end, "Início da anestesia não pode ser após o seu término.") ??
            Validator.after(start, surgeryStart, "Não pode ser após o início da cirurgia.") ??
            Validator.after(start, surgeryEnd, "Não pode ser após o fim da cirurgia.")
    }

    func validateSurgeryStart() {
        guard touched["surgeryStart"] == true else { return }
        surgeryStartError = nil
        if isNew && surgeryStart == nil {
            surgeryStartError = "Informe o início da cirurgia."
            return
        }
        if let surgeryStart {
            surgeryStartError =
                (Validator.after(surgeryStart, end, "Cirurgia não pode iniciar após da fim da anestesia.")) ??
                (Validator.after(surgeryStart, surgeryEnd, "Cirurgia não pode iniciar após da fim da cirurgia.")) ??
                (Validator.before(surgeryStart, start, "Cirurgia não pode iniciar antes da anestesia.")) ??
                (Validator.before(surgeryStart, surgeryDate, "Início da cirurgia não pode ser antes da data da cirurgia - \(surgeryDate)."))
        }
    }

    func validateSurgeryEnd() {
        guard touched["surgeryEnd"] == true else { return }
        surgeryEndError = nil
        if !isNew && surgeryEnd == nil {
            surgeryEndError = "Informe o término da cirurgia."
            return
        }
        if let surgeryEnd {
            surgeryEndError =
                (Validator.before(surgeryEnd, surgeryStart, "Término da cirurgia não pode ser antes do seu início.")) ??
                (Validator.after(surgeryEnd, end, "Término da cirurgia não pode ser após fim da anestesia.")) ??
                (Validator.before(surgeryEnd, start, "Término da cirurgia não pode ser antes do início da anestesia.")) ??
                (Validator.before(surgeryEnd, surgeryDate, "Término da cirurgia não pode ser antes da data da cirurgia - \(surgeryDate)."))
        }
    }

    func validateAnesthesiaEnd() {
        guard touched["anesthesiaEnd"] == true else { return }
        anesthesiaEndError = nil
        if !isNew && end == nil {
            anesthesiaEndError = "Informe o término da anestesia."
            return
        }
        if let end {
            anesthesiaEndError =
                (Validator.before(end, start, "Término da anestesia não pode ser antes do início.")) ??
                (Validator.before(end, surgeryEnd, "Término da anestesia não pode ser antes do término da cirurgia.")) ??
                (Validator.before(end, surgeryDate, "Término da anestesia não pode ser antes da data da cirurgia - \(surgeryDate)."))
        }
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
    
    func validatePosition() {
        guard touched["position"] == true else { return }
        positionError = nil
        if isNew && position.isEmpty {
            positionError = "Selecione ao menos uma posição cirúrgica."
        }
    }
    
    private func clearErrors() {
        anesthesiaStartError = nil
        anesthesiaEndError = nil
        surgeryStartError = nil
        surgeryEndError = nil
        techniquesError = nil
        asaError = nil
        positionError = nil
    }
    
    // Lógica de sugestões movida para funções explícitas
    func updateSuggestionsForStart() {
        guard let start else { return }
        let suggestion = Calendar.current.date(byAdding: .minute, value: 5, to: start)
        suggestedSurgeryStart = suggestion
        if touched["surgeryStart"] != true {
            surgeryStart = suggestion
        }
    }
    
    func updateSuggestionsForEnd() {
        guard let end else { return }
        let suggestion = Calendar.current.date(byAdding: .minute, value: -5, to: end)
        suggestedSurgeryEnd = suggestion
        if touched["surgeryEnd"] != true {
            surgeryEnd = suggestion
        }
    }
    
    func acceptSurgeryStartSuggestion() {
        if let suggestedSurgeryStart { surgeryStart = suggestedSurgeryStart }
        suggestedSurgeryStart = nil
    }

    func acceptSurgeryEndSuggestion() {
        if let suggestedSurgeryEnd { surgeryEnd = suggestedSurgeryEnd }
        suggestedSurgeryEnd = nil
    }

    func clearSuggestions() {
        suggestedSurgeryStart = nil
        suggestedSurgeryEnd = nil
    }
}
