//
//  helper1.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


import Foundation
import Combine

// Note: 'cancellables' in VitalSignsFormViewModel must be at least internal (default) to be accessible from this file.
@MainActor
extension SRPAVitalSignsFormViewModel {
    func setupValidationBindings() {
            // Validate FC on change
            $fc
                .sink { [weak self] _ in
                    self?.validateFc()
                }
                .store(in: &cancellables)

            // Also revalidate when patientAge changes (if it can change dynamically)
            $patientAge
                .sink { [weak self] _ in
                    self?.validateFc()
                }
                .store(in: &cancellables)

            // Revalidate when touched flips to true
            $fcTouched
                .sink { [weak self] _ in
                    self?.validateFc()
                }
                .store(in: &cancellables)

            // Validate SpO2 on change
            $spo2
                .sink { [weak self] _ in
                    self?.validateSpo2()
                }
                .store(in: &cancellables)

            // Revalidate when SpO2 touched flips to true
            $spo2Touched
                .sink { [weak self] _ in
                    self?.validateSpo2()
                }
                .store(in: &cancellables)
            
            // Validate PA (PAS/PAD) on change
            $paS
                .sink { [weak self] _ in
                    self?.validatePa()
                }
                .store(in: &cancellables)

            $paD
                .sink { [weak self] _ in
                    self?.validatePa()
                }
                .store(in: &cancellables)

            // Revalidate when PAS/PAD touched flags change
            $paSTouched
                .sink { [weak self] _ in
                    self?.validatePa()
                }
                .store(in: &cancellables)

            $paDTouched
                .sink { [weak self] _ in
                    self?.validatePa()
                }
                .store(in: &cancellables)
        }

        func validateFc() {
            // Só mostra algo depois que o campo foi tocado
            guard fcTouched else {
                errorFc = nil
                return
            }

            // Se estiver vazio, tudo bem — não é erro, só não foi registrado agora
            guard let value = fc else {
                errorFc = "Campo não pode ficar em branco."
                return
            }

            // Regras puramente técnicas, não clínicas:
            if value < 0 {
                errorFc = "Frequência cardíaca não pode ser negativa."
                return
            }

            if value > 280 {
                errorFc = "Valor de FC muito alto, confirme se não houve erro de digitação."
                return
            }

            // Dentro da faixa técnica aceitável → sem erro
            errorFc = nil
        }
        
        func validateSpo2() {
            // Só mostra algo depois que o campo foi tocado
            guard spo2Touched else {
                errorSpo2 = nil
                return
            }

            // SpO₂ é obrigatório
            guard let value = spo2 else {
                errorSpo2 = "SpO₂ não pode ficar em branco."
                return
            }

            // Regras técnicas: 0–100%
            if value < 0 || value > 100 {
                errorSpo2 = "SpO₂ deve estar entre 0% e 100%."
                return
            }

            // Dentro da faixa aceitável → sem erro
            errorSpo2 = nil
        }
        
    func validatePa() {
        // Só mostra algo depois que pelo menos um dos campos foi tocado
        guard paSTouched || paDTouched else {
            errorPaS = nil
            errorPaD = nil
            return
        }
        
        // Limpa erros atuais; serão recalculados
        errorPaS = nil
        errorPaD = nil
        
        let sOpt = paS
        let dOpt = paD
        
        // Regras de obrigatoriedade por campo (somente se o campo foi tocado)
        if paSTouched && sOpt == nil {
            errorPaS = "PAS não pode ficar em branco."
        }
        
        if paDTouched && dOpt == nil {
            errorPaD = "PAD não pode ficar em branco."
        }
        
        // Regras técnicas independentes para cada campo (não dependem do outro)
        if let s = sOpt {
            if s < 0 {
                errorPaS = "PAS não pode ser negativa."
            } else if s > 300 {
                errorPaS = "PAS não pode ser maior que 300 mmHg."
            }
        }
        
        if let d = dOpt {
            if d < 0 {
                errorPaD = "PAD não pode ser negativa."
            } else if d > 200 {
                errorPaD = "PAD não pode ser maior que 200 mmHg."
            }
        }
        
        // Se ainda não temos os dois valores, não faz sentido aplicar regras relacionais
        guard let s = sOpt, let d = dOpt,
              errorPaS == nil, errorPaD == nil else {
            return
        }
        
        // A partir daqui, temos PAS e PAD válidos individualmente → aplicar regras de relação
        
        // Se PAS for 0, PAD precisa ser 0
        if s == 0 && d != 0 {
            let msg = "Se PAS for 0, PAD também deve ser 0."
            errorPaS = msg
            errorPaD = msg
            return
        }
        
        // Se PAD for 0, PAS precisa ser 0
        if d == 0 && s != 0 {
            let msg = "Se PAD for 0, PAS também deve ser 0."
            errorPaS = msg
            errorPaD = msg
            return
        }
        
        // PAS e PAD só podem ser iguais se ambas forem 0
        if s == d && s != 0 {
            let msg = "PAS e PAD só podem ser iguais se ambas forem 0."
            errorPaS = msg
            errorPaD = msg
            return
        }
        
        // Regra geral: PAS deve ser > PAD
        if s < d {
            let msg = "PAS deve ser maior que PAD."
            errorPaS = msg
            errorPaD = msg
            return
        }
        
        // Tudo ok → sem erros
        errorPaS = nil
        errorPaD = nil
    }
    
}
