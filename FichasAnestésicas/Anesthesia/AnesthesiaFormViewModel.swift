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
    @Published var position: [Positioning] = []
    @Published var surgeryStart: Date?
    @Published var surgeryEnd: Date?

    private let repository: AnesthesiaRepository
    private let user: User
    private let surgery: Surgery
    private let context: ModelContext

    init(surgery: Surgery, user: User, context: ModelContext) {
        self.surgery = surgery
        self.user = user
        self.context = context
        self.repository = SwiftDataAnesthesiaRepository(context: context)
        // Dados da cirurgia
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
        loadAnesthesia()
    }

    func loadAnesthesia() {
        let all = repository.getAll(for: surgery)
        anesthesia = all.first
        if let anesthesia = anesthesia {
            self.start = anesthesia.start
            self.end = anesthesia.end
            self.techniques = anesthesia.techniques
            self.position = anesthesia.position
        }
        // Garante que os campos da cirurgia reflitam o estado atual
        self.surgeryStart = surgery.start
        self.surgeryEnd = surgery.end
    }

    func save() -> Bool {
        if anesthesia == nil {
            let new = Anesthesia(
                anesthesiaId: UUID().uuidString,
                surgery: surgery,
                anesthesiaDescriptions: [],
                anesthesiaTechniqueRaw: techniques.map { $0.rawValue },
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
            self.anesthesia = new
        }

        guard let anesthesia = anesthesia else {
            errorMessage = "Anesthesia inválida."
            return false
        }

        // Sincroniza campos editáveis com o modelo antes de persistir
        anesthesia.start = start
        anesthesia.end = end
        anesthesia.techniques = techniques
        anesthesia.position = position

        // Atualiza os horários da cirurgia de forma independente da anestesia
        surgery.start = surgeryStart
        surgery.end = surgeryEnd

        do {
            if repository.get(by: anesthesia.anesthesiaId) != nil {
                try repository.update(anesthesia: anesthesia, for: surgery, by: user)
            } else {
                try repository.create(anesthesia: anesthesia, for: surgery, by: user)
            }
            loadAnesthesia()
            return true
        } catch {
            errorMessage = "Erro ao salvar anestesia: \(error.localizedDescription)"
            return false
        }
    }

    func delete() {
        guard let anesthesia = anesthesia else { return }

        do {
            try repository.delete(anesthesia: anesthesia, from: surgery)
            self.anesthesia = nil
        } catch {
            errorMessage = "Erro ao deletar anestesia: \(error.localizedDescription)"
        }
    }
}
