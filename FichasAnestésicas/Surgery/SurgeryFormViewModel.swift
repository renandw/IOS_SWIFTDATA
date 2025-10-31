//
//  SurgeryFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//

//
//  SurgeryFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import Foundation
import SwiftData

@Observable
final class SurgeryFormViewModel {
    // MARK: - Properties
    let patient: Patient
    private let surgery: Surgery?
    private let repository: SurgeryRepository
    
    var isEditing: Bool { surgery != nil }
    var saveSuccess = false
    
    // Campos obrigatórios
    var date: Date
    var insuranceName: String
    var insuranceNumber: String
    var mainSurgeon: String
    var hospital: String
    var weight: Double?
    var proposedProcedure: String
    
    // Campos opcionais
    var start: Date?
    var end: Date?
    var auxiliarySurgeons: [String]?
    var completeProcedure: String?
    var status: Status
    var type: SurgeryType
    
    // Procedures
    var selectedProcedures: [CbhpmCode] = []
    
    // MARK: - Validation
    var isValid: Bool {
        !insuranceName.isEmpty &&
        !insuranceNumber.isEmpty &&
        !mainSurgeon.isEmpty &&
        !hospital.isEmpty &&
        ((weight ?? 0) > 0) &&
        !proposedProcedure.isEmpty
    }
    
    // MARK: - Init
    init(patient: Patient, surgery: Surgery? = nil, repository: SurgeryRepository) {
        self.patient = patient
        self.surgery = surgery
        self.repository = repository
        
        if let surgery = surgery {
            // Edição - popula com dados existentes
            self.date = surgery.date
            self.insuranceName = surgery.insuranceName
            self.insuranceNumber = surgery.insuranceNumber
            self.mainSurgeon = surgery.mainSurgeon
            self.hospital = surgery.hospital
            self.weight = surgery.weight
            self.proposedProcedure = surgery.proposedProcedure
            self.start = surgery.start
            self.end = surgery.end
            self.auxiliarySurgeons = surgery.auxiliarySurgeons
            self.completeProcedure = surgery.completeProcedure
            self.status = surgery.status
            self.type = surgery.type
            
            // Carrega procedures existentes
            if let cbhpmProcedures = surgery.cbhpmProcedures {
                self.selectedProcedures = cbhpmProcedures.map {
                    CbhpmCode(codigo: $0.code, procedimento: $0.procedure, porte_anestesico: $0.port)
                }
            }
        } else {
            // Criação - valores padrão
            self.date = Date()
            self.insuranceName = ""
            self.insuranceNumber = ""
            self.mainSurgeon = ""
            self.hospital = ""
            self.weight = nil
            self.proposedProcedure = ""
            self.status = .scheduled
            self.type = .convenio
        }
    }
    
    // MARK: - Save
    func save(currentUser: User) throws {
        if isEditing {
            try updateExisting()
        } else {
            try createNew(currentUser: currentUser)
        }
        saveSuccess = true
    }
    
    private func createNew(currentUser: User) throws {
        let newSurgery = Surgery(
            surgeryId: "", // Será gerado pelo repository
            date: date,
            createdBy: currentUser,
            createdAt: Date(),
            lastActivityAt: Date(),
            insuranceName: insuranceName,
            insuranceNumber: insuranceNumber,
            start: start,
            end: end,
            auxiliarySurgeons: auxiliarySurgeons,
            mainSurgeon: mainSurgeon,
            hospital: hospital,
            weight: weight ?? 0.0,
            proposedProcedure: proposedProcedure,
            completeProcedure: completeProcedure,
            statusRaw: status.rawValue,
            typeRaw: type.rawValue,
            patient: patient
        )
        
        try repository.create(newSurgery)
        
        // Adiciona procedures
        if !selectedProcedures.isEmpty {
            let cbhpmProcedures = selectedProcedures.map {
                CbhpmProcedure(
                    surgery: newSurgery,
                    code: $0.codigo,
                    procedure: $0.procedimento,
                    port: $0.porte_anestesico
                )
            }
            newSurgery.cbhpmProcedures = cbhpmProcedures
        }
    }
    
    private func updateExisting() throws {
        guard let surgery = surgery else { return }
        
        surgery.date = date
        surgery.insuranceName = insuranceName
        surgery.insuranceNumber = insuranceNumber
        surgery.mainSurgeon = mainSurgeon
        surgery.hospital = hospital
        surgery.weight = weight ?? surgery.weight
        surgery.proposedProcedure = proposedProcedure
        surgery.start = start
        surgery.end = end
        surgery.auxiliarySurgeons = auxiliarySurgeons
        surgery.completeProcedure = completeProcedure
        surgery.status = status
        surgery.type = type
        
        // Atualiza procedures
        surgery.cbhpmProcedures = selectedProcedures.map {
            CbhpmProcedure(
                surgery: surgery,
                code: $0.codigo,
                procedure: $0.procedimento,
                port: $0.porte_anestesico
            )
        }
        
        try repository.update(surgery)
    }
}

