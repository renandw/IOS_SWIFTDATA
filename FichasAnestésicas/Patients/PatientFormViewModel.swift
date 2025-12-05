//
//  PatientFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 27/10/25.
//

import Foundation
import Combine

@MainActor
final class PatientFormViewModel: ObservableObject {
    // MARK: - Form properties
    @Published var name: String = ""
    @Published var cns: String = ""
    @Published var birthDate: Date? = nil
    @Published var sex: Sex? = nil

    // MARK: - Duplicate Detection State
    @Published var duplicateStatus: DuplicateStatus?
    @Published var foundPatients: [Patient] = []
    @Published var showDuplicateSheet = false
    
    // MARK: - Success/Error State
    @Published var saveSuccess = false
    @Published var errorMessage: String?
    // Paciente resolvido para uso em fluxos externos (novo, selecionado ou atualizado)
    @Published var resolvedPatient: Patient?

    // MARK: - Dependencies
    private let repository: PatientRepository
    private let currentUser: User
    private var editingPatient: Patient?
    
    // Armazena o paciente temporário durante verificação
    private var pendingPatient: Patient?

    // MARK: - Init
    init(repository: PatientRepository, currentUser: User, editingPatient: Patient? = nil) {
        self.repository = repository
        self.currentUser = currentUser
        self.editingPatient = editingPatient

        if let patient = editingPatient {
            name = patient.name
            cns = patient.cns
            birthDate = patient.birthDate
            sex = patient.sex
        }
    }

    // MARK: - Actions
    func save() throws {
        if editingPatient != nil {
            // Update não checa duplicatas
            try performUpdate()
        } else {
            // Create novo - checa duplicatas
            try checkAndCreate()
        }
    }
    
    private func performUpdate() throws {
        guard var patient = editingPatient else { return }
        guard let bd = birthDate, let sx = sex else { return }
        patient.name = name
        patient.cns = cns
        patient.birthDate = bd
        patient.sex = sx
        try repository.update(patient)
        saveSuccess = true
    }
    
    private func checkAndCreate() throws {
        let patient = createPatientObject()
        pendingPatient = patient
        
        let status = try repository.checkForDuplicates(patient)
        duplicateStatus = status
        
        switch status {
        case .none:
            try repository.create(patient)
            saveSuccess = true
            resolvedPatient = patient
            
        case .exact(let patients):
            foundPatients = patients
            showDuplicateSheet = true
            
        case .similar(let patients):
            foundPatients = patients
            showDuplicateSheet = true
            
        case .homonym(let patients):
            foundPatients = patients
            showDuplicateSheet = true
        }
    }

    // MARK: - User Actions from Duplicate Sheet
    
    /// Opção 1: Criar novo paciente mesmo assim (ignora duplicatas)
    func forceCreateNew() throws {
        guard let patient = pendingPatient else { return }
        try repository.create(patient)
        saveSuccess = true
        resolvedPatient = patient
        closeDuplicateSheet()
    }
    
    /// Opção 2: Selecionar paciente existente (apenas navega/fecha)
    func selectExisting(_ patient: Patient) {
        // A View decide o que fazer (navegar, fechar, etc)
        // Além de fechar o sheet, expõe o paciente selecionado
        resolvedPatient = patient
        closeDuplicateSheet()
        clearForm()
    }
    
    /// Opção 3: Atualizar paciente existente com os novos dados
    func updateExisting(_ existingPatient: Patient) throws {
        guard let bd = birthDate, let sx = sex else { return }
        var patient = existingPatient
        patient.name = name
        patient.cns = cns
        patient.birthDate = bd
        patient.sex = sx
        try repository.update(patient)
        saveSuccess = true
        resolvedPatient = patient
        closeDuplicateSheet()
    }
    
    // MARK: - Helpers
    
    private func createPatientObject() -> Patient {
        precondition(birthDate != nil && sex != nil, "Expected non-nil birthDate and sex when creating Patient")
        return Patient(
            patientId: UUID().uuidString,
            cns: cns,
            name: name,
            birthDate: birthDate!,
            sex: sex!,
            createdBy: currentUser
        )
    }
    
    private func closeDuplicateSheet() {
        showDuplicateSheet = false
        foundPatients = []
        duplicateStatus = nil
        pendingPatient = nil
    }
    
    private func clearForm() {
        name = ""
        cns = ""
        birthDate = nil
        sex = nil
    }

    // MARK: - Validation
    var isValid: Bool {
        let digitCount = cns.filter { $0.isNumber }.count
        let hasName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return hasName && digitCount == 15 && birthDate != nil && sex != nil
    }

    // MARK: - Derived state
    var isEditing: Bool { editingPatient != nil }
    
    /// Mensagem contextual para o sheet baseado no tipo de duplicata
    var duplicateMessage: String {
        guard let status = duplicateStatus else { return "" }
        
        switch status {
        case .exact:
            return "Paciente idêntico já cadastrado"
        case .similar:
            return "Paciente semelhante encontrado (possível erro de digitação)"
        case .homonym:
            return "Paciente com mesmo nome mas dados diferentes encontrado"
        case .none:
            return ""
        }
    }
    
    // MARK: funções de formatação
    func formatName(_ name: String) -> String {
        let lowercasedWords = ["de", "da", "do", "das", "dos"]

        return name
            .lowercased()               
            .split(separator: " ")
            .map { word in
                let w = String(word)
                if lowercasedWords.contains(w) {
                    return w
                } else {
                    return w.capitalized
                }
            }
            .joined(separator: " ")
    }
    
    func formatCNS(_ cns: String) -> String {
        let numbers = cns.filter { $0.isNumber }.prefix(15)
        var result = ""
        
        for (index, char) in numbers.enumerated() {
            if index == 3 || index == 7 || index == 11 {
                result += " "
            }
            result.append(char)
        }
        
        return result
    }

}
