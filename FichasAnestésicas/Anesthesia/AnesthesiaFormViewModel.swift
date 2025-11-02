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
    
    
    ///Validações
    
    var canSave: Bool {
        // Sem erros e requisitos mínimos atendidos
    }
    
    
    func validateAnesthesiaStart() {
        //não pode ser antes de surgeryDate
        //obrigatório para criação
    }
    
    func validateSurgeryStart() {
        //não pode ser antes de anesthesia.start
        //obrigatório para criação
    }
    
    func validateSurgeryEnd() {
        // não pode ser antes de surgery.start
        // não obrigatório para criação
        //obrigatório para edição
    }
    
    func validateAnesthesiaEnd() {
        //não pode ser antes de surgery.end
        //não obrigatório para criação
        //obrigatório para edição
    }
    
    func validateAnesthesiaTechnique() {
        //para criar, pelo menos uma technique precisa ser selecionada
        //obrigatório para criação
    }
    
    func validateASA() {
        //para criar, ASA precisa estar selecionado
        //obrigatório para criação
    }
    
}


//todo: validations for every field.
