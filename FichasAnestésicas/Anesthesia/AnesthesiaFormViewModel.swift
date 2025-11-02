//
//  AnesthesiaFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

@MainActor
final class AnesthesiaFormViewModel: ObservableObject {
    @Published var anesthesia: Anesthesia?
    @Published var isEditing = false
    @Published var errorMessage: String?

    @Published var start: Date?
    @Published var end: Date?
    @Published var techniques: [AnesthesiaTechniqueKind] = []
    @Published var asa: ASAClassification? = nil
    @Published var position: [Positioning] = []
    @Published var surgeryStart: Date?
    @Published var surgeryEnd: Date?
    
    /// Validações e mensagens de erros:
    @Published var anesthesiaStartError: String?
    @Published var anesthesiaEndError: String?
    @Published var surgeryStartError: String?
    @Published var surgeryEndError: String?
    @Published var techniquesError: String?
    @Published var asaError: String?

    private let repository: AnesthesiaRepository
    private let sharedRepo: SharedPreAndAnesthesiaRepository
    private let user: User
    private let surgery: Surgery
    private let context: ModelContext
    private var isNew = false
    private let surgeryDate: Date
    
    

    init(surgery: Surgery, user: User, context: ModelContext) {
        self.surgery = surgery
        self.user = user
        self.context = context
        self.repository = SwiftDataAnesthesiaRepository(context: context)
        self.sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: context)
        // Dados da cirurgia
        self.surgeryDate = surgery.date
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
            // Prefer shared techniques if available
            let shared = sharedRepo.get(for: surgery) ?? anesthesia.shared
              if let shared {
                  self.techniques = shared.techniques
              } else {
                  self.techniques = anesthesia.techniques
              }

              if let shared {
                  self.asa = shared.asa
              } else {
                  self.asa = nil
              }
            self.position = anesthesia.position
        }
        
        
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
    }

    func save() -> Bool {
        // Validação do formulário antes de persistir (com side-effects)
        runValidations()
        guard isFormValid else {
            // Mensagens específicas já estão nos campos de erro
            return false
        }

        if anesthesia == nil {
            let new = Anesthesia(
                anesthesiaId: UUID().uuidString,
                surgery: surgery,
                anesthesiaDescriptions: [],
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
            return true
        } catch {
            errorMessage = "Erro ao salvar anestesia: \(error.localizedDescription)"
            return false
        }
    }

    func delete() {
        guard let anesthesia = anesthesia else { return }
        self.anesthesia = nil
        self.isNew = true
        do {
            try repository.delete(anesthesia: anesthesia, from: surgery)
        } catch {
            errorMessage = "Erro ao deletar anestesia: \(error.localizedDescription)"
        }
    }
    
    func runValidations() {
        // Atualiza mensagens de erro (efeitos colaterais)
        clearErrors()
        validateAnesthesiaStart()
        validateSurgeryStart()
        validateSurgeryEnd()
        validateAnesthesiaEnd()
        validateAnesthesiaTechnique()
        validateASA()
    }
    
    ///Validações

    var isFormValid: Bool {
        // Checagem pura: apenas lê erros e presença de campos obrigatórios
        let noErrors = [
            anesthesiaStartError,
            anesthesiaEndError,
            surgeryStartError,
            surgeryEndError,
            techniquesError,
            asaError
        ].allSatisfy { $0 == nil }

        if isNew {
            // Em criação: início de anestesia e início de cirurgia obrigatórios,
            // técnica e ASA obrigatórios segundo comentários.
            let requiredPresent = (start != nil) && (surgeryStart != nil) && !techniques.isEmpty && (asa != nil)
            return noErrors && requiredPresent
        } else {
            // Em edição: fim de cirurgia e fim de anestesia passam a ser obrigatórios
            let requiredPresent = (surgeryEnd != nil) && (end != nil)
            return noErrors && requiredPresent
        }
    }


    func validateAnesthesiaStart() {
        //não pode ser antes de surgeryDate
        //obrigatório para criação
        anesthesiaStartError = nil
        if isNew && start == nil {
            anesthesiaStartError = "Informe o início da anestesia."
            return
        }
        if let start {
            if start < surgeryDate {
                anesthesiaStartError = "Início da anestesia não pode ser antes da data da cirurgia."
            } else if let end, start > end {
                anesthesiaStartError = "Início da anestesia não pode ser após o término."
            }
        }
    }

    func validateSurgeryStart() {
        //não pode ser antes de anesthesia.start
        //obrigatório para criação
        surgeryStartError = nil
        if isNew && surgeryStart == nil {
            surgeryStartError = "Informe o início da cirurgia."
            return
        }
        if let surgeryStart {
            if let start, surgeryStart < start {
                surgeryStartError = "Cirurgia não pode iniciar antes da anestesia."
            }
            if surgeryStart < surgeryDate {
                // Regra adicional natural ao modelo (data mínima)
                surgeryStartError = "Início da cirurgia não pode ser antes da data da cirurgia."
            }
        }
    }

    func validateSurgeryEnd() {
        // não pode ser antes de surgery.start
        // não obrigatório para criação
        // obrigatório para edição
        surgeryEndError = nil
        if !isNew && surgeryEnd == nil {
            surgeryEndError = "Informe o término da cirurgia."
            return
        }
        if let surgeryEnd {
            if let surgeryStart, surgeryEnd < surgeryStart {
                surgeryEndError = "Término da cirurgia não pode ser antes do início."
            }
            if surgeryEnd < surgeryDate {
                surgeryEndError = "Término da cirurgia não pode ser antes da data da cirurgia."
            }
        }
    }

    func validateAnesthesiaEnd() {
        //não pode ser antes de surgery.end
        //não obrigatório para criação
        //obrigatório para edição
        anesthesiaEndError = nil
        if !isNew && end == nil {
            anesthesiaEndError = "Informe o término da anestesia."
            return
        }
        if let end {
            if let start, end < start {
                anesthesiaEndError = "Término da anestesia não pode ser antes do início."
            }
            if let surgeryEnd, end < surgeryEnd {
                anesthesiaEndError = "Término da anestesia não pode ser antes do término da cirurgia."
            }
            if end < surgeryDate {
                anesthesiaEndError = "Término da anestesia não pode ser antes da data da cirurgia."
            }
        }
    }

    func validateAnesthesiaTechnique() {
        //para criar, pelo menos uma technique precisa ser selecionada
        //obrigatório para criação
        techniquesError = nil
        if isNew && techniques.isEmpty {
            techniquesError = "Selecione ao menos uma técnica."
        }
    }

    func validateASA() {
        //para criar, ASA precisa estar selecionado
        //obrigatório para criação
        asaError = nil
        if isNew && asa == nil {
            asaError = "Selecione uma classificação ASA."
        }
    }
    
    private func clearErrors() {
        anesthesiaStartError = nil
        anesthesiaEndError = nil
        surgeryStartError = nil
        surgeryEndError = nil
        techniquesError = nil
        asaError = nil
    }
    
}


//todo: validations for every field.

