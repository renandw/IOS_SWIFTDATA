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
    @Published var birthDate: Date = .now
    @Published var sex: Sex = .male

    // MARK: - Dependencies
    private let repository: PatientRepository
    private let currentUser: User
    private var editingPatient: Patient?

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
        if var patient = editingPatient {
            // Edit existing
            patient.name = name
            patient.cns = cns
            patient.birthDate = birthDate
            patient.sex = sex
            patient.updatedBy = currentUser
            try repository.update(patient)
        } else {
            // Create new
            let newPatient = Patient(
                patientId: UUID().uuidString,
                cns: cns,
                name: name,
                birthDate: birthDate,
                sex: sex,
                createdBy: currentUser
            )
            try repository.create(newPatient)
        }
    }

    // MARK: - Validation
    var isValid: Bool {
        !name.isEmpty && !cns.isEmpty
        // TODO: validar formato CNS, name e muitas outras validações.
    }
}
