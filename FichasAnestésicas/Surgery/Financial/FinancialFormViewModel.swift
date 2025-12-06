//
//  FinancialFormViewModel.swift
//  FichasAnestésicas
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
    
    // Valores internos para tax
    private var _taxedValue: Double?
    private var _taxPercentage: Double?
    
    // Flag para evitar loops infinitos
    private var isUpdatingTax = false
    
    var taxedValue: Double? {
        get { _taxedValue }
        set {
            guard !isUpdatingTax else { return }
            isUpdatingTax = true
            _taxedValue = newValue
            
            // Se limpar o campo (nil ou 0), limpa a porcentagem também
            if newValue == nil || newValue == 0 {
                _taxPercentage = nil
            } else if let newValue = newValue {
                // Calcula a porcentagem baseada no valor
                let baseValue = calculatedBaseValue
                if baseValue > 0 {
                    _taxPercentage = (newValue / baseValue) * 100
                }
            }
            
            isUpdatingTax = false
        }
    }

    var taxPercentage: Double? {
        get { _taxPercentage }
        set {
            guard !isUpdatingTax else { return }
            isUpdatingTax = true
            _taxPercentage = newValue
            
            // Se limpar o campo (nil ou 0), limpa o valor também
            if newValue == nil || newValue == 0 {
                _taxedValue = nil
            } else if let newValue = newValue {
                // Calcula o valor baseado na porcentagem
                let baseValue = calculatedBaseValue
                _taxedValue = (baseValue * newValue) / 100
            }
            
            isUpdatingTax = false
        }
    }
    
    // Valor base para cálculo dos impostos (anestesia + pré-anestesia - glosas)
    private var calculatedBaseValue: Double {
        let anesthesia = (valueAnesthesia ?? 0) - (glosedAnesthesiaValue ?? 0)
        let preAnesthesia = (valuePreAnesthesia ?? 0) - (glosedPreAnesthesiaValue ?? 0)
        return anesthesia + preAnesthesia
    }
    
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
            self._taxedValue = financial.taxedValue
            self._taxPercentage = financial.taxPercentage
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
            taxedValue: _taxedValue,
            taxPercentage: _taxPercentage
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
        financial.taxedValue = _taxedValue
        financial.taxPercentage = _taxPercentage
        
        try repository.update(financial)
    }
    
    var calculatedFinalValue: Double {
        let anesthesia = (valueAnesthesia ?? 0) - (glosedAnesthesiaValue ?? 0)
        let preAnesthesia = (valuePreAnesthesia ?? 0) - (glosedPreAnesthesiaValue ?? 0)
        let taxed = _taxedValue ?? 0
        return anesthesia + preAnesthesia - taxed
    }
}
