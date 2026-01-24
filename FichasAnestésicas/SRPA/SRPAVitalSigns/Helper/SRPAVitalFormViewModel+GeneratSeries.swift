//
//  SRPAVitalFormViewModel+GeneratSeries.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import Foundation

// MARK: - Gerador de Série

struct SRPAVitalSignsSeriesGenerator {
    let srpa: SRPA
    let timestamps: [Date]
    let baseFc: Double
    let basePaS: Double
    let basePaD: Double
    let baseSpo2: Double
    let baseEtco2: Double?
    let baseVt: Double?
    let baseBis: Double?
    let basePvc: Double?
    let baseTemp: Double?
    let patientAge: Int
    let techniques: [AnesthesiaTechniqueKind]

    func generate() -> [SRPAVitalSignEntry] {
        guard !timestamps.isEmpty else { return [] }
        
        // Removed isInfant, profile, duration, phase calculation and targets calculation
        
        // Estado inicial
        var lastFc = baseFc
        var lastPaS = basePaS
        var lastPaD = basePaD
        var lastSpo2 = baseSpo2
        var lastEtco2 = baseEtco2
        var lastVt = baseVt
        var lastBis = baseBis
        var lastPvc = basePvc
        var lastTemp = baseTemp
        
        var entries: [SRPAVitalSignEntry] = []
        
        for (index, timestamp) in timestamps.enumerated() {
            // Simplified target calculation without phases or profile
            let targetFc = baseFc + Double.random(in: -2...2)
            let targetPaS = basePaS + Double.random(in: -3...3)
            let targetPaD = basePaD + Double.random(in: -2...2)
            let targetSpo2 = (baseSpo2 + Double.random(in: -1...0)).clamped(to: 90...100)
            let targetEtco2 = baseEtco2
            let targetVt = baseVt
            let targetBis = baseBis
            let targetPvc = basePvc
            let targetTemp = baseTemp
            
            // Suavização exponencial com ruído fisiológico
            
            let newPaS = smoothValue(
                last: lastPaS,
                target: targetPaS,
                alpha: 0.4,
                range: (basePaS - 15)...(basePaS + 15),
                noise: -3...3
            ).rounded()
            
            let newPaD = smoothValue(
                last: lastPaD,
                target: targetPaD,
                alpha: 0.4,
                range: (basePaD - 10)...(basePaD + 10),
                noise: -2...2
            ).rounded()
            
            let newFc = smoothValue(
                last: lastFc,
                target: targetFc,
                alpha: 0.3,
                range: (baseFc - 8)...(baseFc + 8),
                noise: -2...2
            ).rounded()
            
            let newSpo2 = smoothValue(
                last: lastSpo2,
                target: targetSpo2,
                alpha: 0.3,
                range: 90...100,
                noise: -1...1
            ).rounded()
            
            var newEtco2: Double? = nil
            if let lastE = lastEtco2, let targetE = targetEtco2 {
                let range = (targetE - 2)...(targetE + 2)
                newEtco2 = smoothValue(last: lastE, target: targetE, alpha: 0.3, range: range, noise: -1...1).rounded()
                lastEtco2 = newEtco2
            }
            
            var newVt: Double? = nil
            if let lastV = lastVt, let targetV = targetVt {
                let delta = max(15.0, targetV * 0.15)
                let range = max(0, targetV - delta)...(targetV + delta)
                newVt = smoothValue(last: lastV, target: targetV, alpha: 0.4, range: range, noise: -5...5).rounded()
                lastVt = newVt
            }
            
            var newBis: Double? = nil
            if let lastB = lastBis, let targetB = targetBis {
                let range = (targetB - 5)...(targetB + 5)
                newBis = smoothValue(last: lastB, target: targetB, alpha: 0.35, range: range, noise: -1...1).rounded()
                lastBis = newBis
            }
            
            var newPvc: Double? = nil
            if let lastP = lastPvc, let targetP = targetPvc {
                let range = (targetP - 3)...(targetP + 3)
                newPvc = smoothValue(last: lastP, target: targetP, alpha: 0.4, range: range, noise: -0.5...0.5).rounded()
                lastPvc = newPvc
            }
            
            var newTemp: Double? = nil
            if let lastT = lastTemp, let targetT = targetTemp {
                let range = (targetT - 0.8)...(targetT + 0.3)
                var value = smoothValue(last: lastT, target: targetT, alpha: 0.15, range: range, noise: -0.05...0.05)
                value = (value * 10).rounded() / 10 // 1 casa decimal
                newTemp = value
                lastTemp = value
            }
            
            // Garante PAM > PAD
            var finalPaS = newPaS
            var finalPaD = newPaD
            if finalPaS <= finalPaD {
                finalPaS = (finalPaD + 5).rounded()
            }
            
            // Criar entrada
            let entry = SRPAVitalSignEntry(
                srpaVitalSignsId: UUID().uuidString,
                srpa: srpa,
                timestamp: timestamp
            )
            
            entry.fc = newFc
            entry.paS = finalPaS
            entry.paD = finalPaD
            entry.pam = calculatePam(paS: finalPaS, paD: finalPaD)
            entry.spo2 = newSpo2
            entry.etco2 = newEtco2
            entry.volumeCorrente = newVt
            entry.bis = newBis
            entry.pvc = newPvc
            entry.temperatura = newTemp
            
            entries.append(entry)
            
            // Atualiza estado
            lastFc = newFc
            lastPaS = finalPaS
            lastPaD = finalPaD
            lastSpo2 = newSpo2
        }
        
        return entries
    }
    
    // Removed determinePhase and calculateTargets methods
    
    private func smoothValue(last: Double, target: Double, alpha: Double, range: ClosedRange<Double>, noise: ClosedRange<Double>) -> Double {
        // Suavização exponencial: (1-alpha) * último + alpha * target
        // alpha = 0 → máxima suavização (valor não muda)
        // alpha = 1 → sem suavização (pula direto pro target)
        let smoothed = (1 - alpha) * last + alpha * target
        
        // Adiciona ruído fisiológico (micro-variações)
        let physiologicalNoise = Double.random(in: noise)
        let withNoise = smoothed + physiologicalNoise
        
        return withNoise.clamped(to: range)
    }
    
    private func calculatePam(paS: Double?, paD: Double?) -> Double? {
        guard let s = paS, let d = paD else { return nil }
        return ((s + 2 * d) / 3).rounded()
    }
}

// MARK: - ViewModel Extension

@MainActor
extension SRPAVitalSignsFormViewModel {
    func generateSeries(durationMinutes: Int? = nil) throws {
        // 1. Só disponível em modo criação
        guard isNew, existingEntry == nil else {
            throw SeriesGenerationError.notInCreationMode
        }

        // 2. Campos obrigatórios
        guard let baseFc = fc,
              let basePaS = paS,
              let basePaD = paD,
              let baseSpo2 = spo2 else {
            throw SeriesGenerationError.missingRequiredFields
        }

        // 3. Determinar duração em minutos
        let duration: Int
        if let explicitDuration = durationMinutes, explicitDuration > 0 {
            duration = explicitDuration
        } else if let start = srpa.start, let end = srpa.end, end > start {
            duration = Int(end.timeIntervalSince(start) / 60)
        } else {
            throw SeriesGenerationError.cannotInferDuration
        }

        // Se a duração for zero ou negativa, não há o que gerar
        guard duration > 0 else {
            shouldDismissAfterGenerateSeries = true
            return
        }

        // 4. Âncora e fim da janela da série
        let anchor = srpa.start ?? Date()
        let seriesEnd = anchor.addingTimeInterval(TimeInterval(duration * 60))

        // 5. Descobrir último registro já persistido (pode ser nil) e construir a lista de timestamps
        var timestamps: [Date] = []
        var last = lastRecordedTimestamp()
        var currentTimestamp = nextSuggestedTime(anchor: anchor, last: last)

        while currentTimestamp <= seriesEnd {
            timestamps.append(currentTimestamp)
            last = currentTimestamp
            currentTimestamp = nextSuggestedTime(anchor: anchor, last: last)
        }

        // Se não houver nenhum timestamp válido, apenas dispensar o formulário
        guard !timestamps.isEmpty else {
            shouldDismissAfterGenerateSeries = true
            return
        }

        // 6. Delegar geração dos registros para o gerador
        let generator = SRPAVitalSignsSeriesGenerator(
            srpa: srpa,
            timestamps: timestamps,
            baseFc: baseFc,
            basePaS: basePaS,
            basePaD: basePaD,
            baseSpo2: baseSpo2,
            baseEtco2: etco2,
            baseVt: volumeCorrente,
            baseBis: bis,
            basePvc: pvc,
            baseTemp: temperatura,
            patientAge: patientAge,
            techniques: techniques
        )

        let entries = generator.generate()

        // 7. Persistir os registros gerados
        for entry in entries {
            // Campos que não fazem parte da variação da série, mas devem se repetir
            entry.rhythm = rhythm
            entry.fio2 = fio2
            entry.peep = peep
            entry.pupilas = pupilas
            entry.tof = tof
            entry.debitCardiaco = debitCardiaco
            entry.glicemia = glicemia
            entry.lactato = lactato
            entry.diurese = diurese
            entry.sangramento = sangramento

            try repo.create(entry, for: srpa, by: user)
        }

        // Após gerar a série completa, sinaliza para a tela dispensar o formulário
        shouldDismissAfterGenerateSeries = true
    }
}

