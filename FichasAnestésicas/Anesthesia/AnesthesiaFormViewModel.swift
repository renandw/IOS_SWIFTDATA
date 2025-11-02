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

    private let repository: AnesthesiaRepository
    private let sharedRepo: SharedPreAndAnesthesiaRepository
    private let user: User
    private let surgery: Surgery
    private let context: ModelContext
    private var isNew = false

    init(surgery: Surgery, user: User, context: ModelContext) {
        self.surgery = surgery
        self.user = user
        self.context = context
        self.repository = SwiftDataAnesthesiaRepository(context: context)
        self.sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: context)
        // Dados da cirurgia
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        loadAnesthesia()
    }

    func loadAnesthesia() {
        print("[AnesthesiaVM] loadAnesthesia() iniciado")
        let all = repository.getAll(for: surgery)
        print("[AnesthesiaVM] Encontradas \(all.count) anestesias para a cirurgia")
        anesthesia = all.first
        isNew = (anesthesia == nil)
        print("[AnesthesiaVM] Selecionada anesthesia: \(String(describing: anesthesia?.anesthesiaId))")
        if let anesthesia = anesthesia {
            self.start = anesthesia.start
            self.end = anesthesia.end
            print("[AnesthesiaVM] Carregado start=\(String(describing: self.start)), end=\(String(describing: self.end))")
            // Prefer shared techniques if available
            let shared = sharedRepo.get(for: surgery) ?? anesthesia.shared
            print("[AnesthesiaVM] Shared encontrado? \(shared != nil)")

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
            print("[AnesthesiaVM] Técnicas=\(self.techniques), ASA=\(String(describing: self.asa))")
            self.position = anesthesia.position
            print("[AnesthesiaVM] Posição=\(self.position)")
        }
        
        
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        print("[AnesthesiaVM] Cirurgia: start=\(String(describing: self.surgeryStart)), end=\(String(describing: self.surgeryEnd))")
        print("[AnesthesiaVM] loadAnesthesia() concluído")
    }

    func save() -> Bool {
        print("[AnesthesiaVM] save() iniciado")
        if anesthesia == nil {
            print("[AnesthesiaVM] Criando Anesthesia em memória (novo registro)")
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
            print("[AnesthesiaVM] Novo anesthesiaId: \(new.anesthesiaId)")
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
        print("[AnesthesiaVM] Dados preparados: start=\(String(describing: start)), end=\(String(describing: end))")
        
        let shared = sharedRepo.ensure(for: surgery)
        shared.techniques = techniques
        shared.asa = asa
        anesthesia.shared = shared
        
        anesthesia.position = position
        print("[AnesthesiaVM] Shared atualizado: techniques=\(techniques), asa=\(String(describing: asa)), position=\(position)")

        surgery.start = surgeryStart
        surgery.end = surgeryEnd
        print("[AnesthesiaVM] Cirurgia: start=\(String(describing: surgeryStart)), end=\(String(describing: surgeryEnd))")

        do {
            if isNew {
                print("[AnesthesiaVM] Create: anesthesiaId=\(anesthesia.anesthesiaId)")
                try repository.create(anesthesia: anesthesia, for: surgery, by: user)
            } else {
                print("[AnesthesiaVM] Update: anesthesiaId=\(anesthesia.anesthesiaId)")
                try repository.update(anesthesia: anesthesia, for: surgery, by: user)
            }
            print("[AnesthesiaVM] Persistência OK, recarregando...")
            loadAnesthesia()
            print("[AnesthesiaVM] save() concluído com sucesso")
            self.isNew = false
            return true
        } catch {
            print("[AnesthesiaVM][Erro] \(error.localizedDescription)")
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
}


//todo: validations for every field.
