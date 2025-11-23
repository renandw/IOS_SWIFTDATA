//
//  AnesthesiaDescriptionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//


import SwiftUI
import SwiftData

@Observable
final class AnesthesiaDescriptionViewModel: Identifiable {

    // MARK: - Repositório e modelos
    
    private let repo: AnesthesiaDescriptionEntryRepository
    private let anesthesia: Anesthesia
    private let user: User

    private(set) var entry: AnesthesiaDescriptionEntry
    private let isNew: Bool

    // Indica se há anestesia geral com base nas técnicas selecionadas
    var hasGeneralAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .geralBalanceada, .geralVenosaTotal, .geralInalatoria:
                return true
            default:
                return false
            }
        }
    }
    var hasSpinalAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .raquianestesia:
                return true
            default:
                return false
            }
        }
    }
    var hasPeriduralAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .peridural:
                return true
            default:
                return false
            }
        }
    }
    var hasPeripheralBlockAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .bloqueioPeriferico:
                return true
            default:
                return false
            }
        }
    }
    var hasSedationAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .sedacao:
                return true
            default:
                return false
            }
        }
    }
    var hasLocalAnesthesia: Bool {
        guard let shared = anesthesia.shared else { return false }
        return shared.techniques.contains { technique in
            switch technique {
            case .anestesiaLocal:
                return true
            default:
                return false
            }
        }
    }
    
    /// Idade do paciente em anos, calculada a partir do contexto (cirurgia ou fora dela)
    var patientAge: Int {
        let surgery = anesthesia.surgery
        let birthDate = surgery.patient.birthDate
        return AgeContext.inSurgery(surgery).ageInYears(from: birthDate)
    }
    var patientWeight: Double {
        let surgery = anesthesia.surgery
        let weight = surgery.weight
        return weight
    }
    var patientSex : Sex {
        let surgery = anesthesia.surgery
        let sex = surgery.patient.sex
        return sex
    }
    
    // MARK: - Sub-ViewModels
    var monitoring = MonitoringSectionViewModel()
    var admission = AdmissionSectionViewModel()
    var techniques = TechniquesSectionViewModel()
    var completion = CompletionSectionViewModel()

    // MARK: - Inicializador (edição)
    init(
        entry: AnesthesiaDescriptionEntry,
        anesthesia: Anesthesia,
        user: User,
        repo: AnesthesiaDescriptionEntryRepository
    ) {
        self.entry = entry
        self.anesthesia = anesthesia
        self.user = user
        self.repo = repo
        self.isNew = false

        monitoring.load(from: entry)
        admission.load(from: entry)
        techniques.load(from: entry)
        completion.load(from: entry)
    }

    // MARK: - Inicializador (novo)
    init(
        newFor anesthesia: Anesthesia,
        user: User,
        repo: AnesthesiaDescriptionEntryRepository
    ) {
        let newEntry = AnesthesiaDescriptionEntry(
            anesthesia: anesthesia,
            timestamp: Date()
        )

        self.entry = newEntry
        self.anesthesia = anesthesia
        self.user = user
        self.repo = repo
        self.isNew = true
    }

    // MARK: - Salvar (create ou update)
    func save() throws {
        monitoring.apply(to: entry)
        admission.apply(to: entry)
        techniques.apply(to: entry)
        completion.apply(to: entry)

        if isNew {
            try repo.create(entry, for: anesthesia, by: user)
        } else {
            try repo.update(entry, for: anesthesia, by: user)
        }
    }
    
    func delete() throws {
        try repo.delete(entry, for: anesthesia, by: user)
    }
    
}

