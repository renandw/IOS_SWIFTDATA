//
//  FinancialFormViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//


import Foundation
import SwiftData

@Observable
final class FinancialFormViewModel {
    // MARK: - Properties
    let surgery: Surgery
    private let financial: Financial?
    private let repository: FinancialRepository
    
    var isEditing: Bool { financial != nil }
    var saveSuccess = false
    
    // Campos editáveis
    var valueAnesthesia: Double?
    var valuePreAnesthesia: Double?
    var finalSurgeryValue: Double?
    var glosaAnesthesia: Bool?
    var glosaPreanesthesia: Bool?
    var glosedAnesthesiaValue: Double?
    var glosedPreAnesthesiaValue: Double?
    var notes: String?
    var paid: Bool
    var paymentDate: Date?
    var billingDate: Date?
    var taxedValue: Double?
    var taxPercentage: Double?
    
    // MARK: - Validation
    var isValid: Bool {
        // Todos os campos são opcionais, então sempre válido
        true
    }
    
    // MARK: - Init
    init(surgery: Surgery, financial: Financial? = nil, repository: FinancialRepository) {
        self.surgery = surgery
        self.financial = financial
        self.repository = repository
        
        if let financial = financial {
            // Edição - popula com dados existentes
            self.valueAnesthesia = financial.valueAnesthesia
            self.valuePreAnesthesia = financial.valuePreAnesthesia
            self.finalSurgeryValue = financial.finalSurgeryValue
            self.glosaAnesthesia = financial.glosaAnesthesia
            self.glosaPreanesthesia = financial.glosaPreanesthesia
            self.glosedAnesthesiaValue = financial.glosedAnesthesiaValue
            self.glosedPreAnesthesiaValue = financial.glosedPreAnesthesiaValue
            self.notes = financial.notes
            self.paid = financial.paid
            self.paymentDate = financial.paymentDate
            self.billingDate = financial.billingDate
            self.taxedValue = financial.taxedValue
            self.taxPercentage = financial.taxPercentage
        } else {
            // Criação - valores padrão
            self.paid = false
        }
    }
    
    // MARK: - Save
    func save() throws {
        if isEditing {
            try updateExisting()
        } else {
            try createNew()
        }
        saveSuccess = true
    }
    
    private func createNew() throws {
        let newFinancial = Financial(
            surgery: surgery,
            valueAnesthesia: valueAnesthesia,
            valuePreAnesthesia: valuePreAnesthesia,
            finalSurgeryValue: finalSurgeryValue,
            glosaAnesthesia: glosaAnesthesia,
            glosaPreanesthesia: glosaPreanesthesia,
            glosedAnesthesiaValue: glosedAnesthesiaValue,
            glosedPreAnesthesiaValue: glosedPreAnesthesiaValue,
            notes: notes,
            paid: paid,
            paymentDate: paymentDate,
            billingDate: billingDate,
            taxedValue: taxedValue,
            taxPercentage: taxPercentage
        )
        
        try repository.create(newFinancial)
    }
    
    private func updateExisting() throws {
        guard let financial = financial else { return }
        
        financial.valueAnesthesia = valueAnesthesia
        financial.valuePreAnesthesia = valuePreAnesthesia
        financial.finalSurgeryValue = finalSurgeryValue
        financial.glosaAnesthesia = glosaAnesthesia
        financial.glosaPreanesthesia = glosaPreanesthesia
        financial.glosedAnesthesiaValue = glosedAnesthesiaValue
        financial.glosedPreAnesthesiaValue = glosedPreAnesthesiaValue
        financial.notes = notes
        financial.paid = paid
        financial.paymentDate = paymentDate
        financial.billingDate = billingDate
        financial.taxedValue = taxedValue
        financial.taxPercentage = taxPercentage
        
        try repository.update(financial)
    }
}
