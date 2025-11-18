//
//  VitalSignsFormViewModel+GenerateSeries.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 18/11/25.
//

import Foundation

@MainActor
extension VitalSignsFormViewModel {
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
            } else if let start = anesthesia.start, let end = anesthesia.end, end > start {
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
            let anchor = anesthesia.start ?? Date()
            let seriesEnd = anchor.addingTimeInterval(TimeInterval(duration * 60))

            // 5. Descobrir último registro já persistido (pode ser nil)
            var last = lastRecordedTimestamp()

            // Primeiro timestamp sugerido
            var currentTimestamp = nextSuggestedTime(anchor: anchor, last: last)

            // Se o primeiro timestamp já estiver além do fim da janela, nada a fazer
            guard currentTimestamp <= seriesEnd else {
                shouldDismissAfterGenerateSeries = true
                return
            }

            // 6. Definir faixas "normais" em torno dos valores base
            let fcRange   = (baseFc - 10)...(baseFc + 10)
            let paSRange  = (basePaS - 15)...(basePaS + 15)
            let paDRange  = (basePaD - 10)...(basePaD + 10)
            let spo2Range = (baseSpo2 - 2)...(baseSpo2 + 2)

            // Variáveis opcionais: se estiverem preenchidas, também serão variáveis na série
            let baseEtco2 = etco2
            let baseVt = volumeCorrente
            let baseBis = bis
            let basePvc = pvc
            let baseTemp = temperatura

            let etco2Range: ClosedRange<Double>? = baseEtco2.map { ($0 - 2)...($0 + 2) }

            var vtRange: ClosedRange<Double>? = nil
            var vtStep: Double? = nil
            if let baseVt {
                let absoluteDelta = 15.0
                let relativeDelta = baseVt * 0.15
                let maxDelta = max(5.0, min(absoluteDelta, relativeDelta))
                vtRange = max(baseVt - maxDelta, 0)...(baseVt + maxDelta)
                vtStep = maxDelta / 3.0
            }

            let bisRange: ClosedRange<Double>? = baseBis.map { ($0 - 5)...($0 + 5) }
            let pvcRange: ClosedRange<Double>? = basePvc.map { ($0 - 5)...($0 + 5) }
            let tempRange: ClosedRange<Double>? = baseTemp.map { ($0 - 0.75)...($0 + 0.75) }

            // Começamos o "random walk" a partir dos valores base
            var lastFc = baseFc
            var lastPaS = basePaS
            var lastPaD = basePaD
            var lastSpo2 = baseSpo2

            var lastEtco2 = baseEtco2
            var lastVt = baseVt
            var lastBis = baseBis
            var lastPvc = basePvc
            var lastTemp = baseTemp

            // 7. Loop de geração
            while currentTimestamp <= seriesEnd {
                var newEtco2: Double? = nil
                var newVt: Double? = nil
                var newBis: Double? = nil
                var newPvc: Double? = nil
                var newTemp: Double? = nil
                // Pequenas flutuações em torno do valor anterior, já clampadas e arredondadas
                var newFc   = (lastFc   + Double.random(in: -3...3)).clamped(to: fcRange).rounded()
                var newPaS  = (lastPaS  + Double.random(in: -5...5)).clamped(to: paSRange).rounded()
                var newPaD  = (lastPaD  + Double.random(in: -3...3)).clamped(to: paDRange).rounded()
                var newSpo2 = (lastSpo2 + Double.random(in: -0.5...0.5)).clamped(to: spo2Range).rounded()

                // Garantir relação PAS > PAD (mantendo suave)
                if newPaS <= newPaD {
                    let adjustedPaS = newPaD + 5
                    newPaS = min(adjustedPaS, paSRange.upperBound).rounded()
                }

                // Variar EtCO2, se disponível (inteiro, variação pequena)
                if let etco2Range, let last = lastEtco2 {
                    let candidate = (last + Double.random(in: -0.5...0.5)).clamped(to: etco2Range)
                    let value = candidate.rounded()
                    newEtco2 = value
                    lastEtco2 = value
                }

                // Variar volume corrente (adulto/bebê) se disponível
                if let vtRange, let vtStep, let last = lastVt {
                    let candidate = (last + Double.random(in: -vtStep...vtStep)).clamped(to: vtRange)
                    let value = candidate.rounded()
                    newVt = value
                    lastVt = value
                }

                // Variar BIS, se disponível
                if let bisRange, let last = lastBis {
                    let candidate = (last + Double.random(in: -2...2)).clamped(to: bisRange)
                    let value = candidate.rounded()
                    newBis = value
                    lastBis = value
                }

                // Variar PVC, se disponível
                if let pvcRange, let last = lastPvc {
                    let candidate = (last + Double.random(in: -2...2)).clamped(to: pvcRange)
                    let value = candidate.rounded()
                    newPvc = value
                    lastPvc = value
                }

                // Variar temperatura, se disponível (mantém decimal, arredonda para 1 casa)
                if let tempRange, let last = lastTemp {
                    var candidate = (last + Double.random(in: -0.2...0.2)).clamped(to: tempRange)
                    candidate = (candidate * 10).rounded() / 10
                    newTemp = candidate
                    lastTemp = candidate
                }

                // 8. Criar entrada para esse timestamp
                let entry = VitalSignEntry(
                    vitalSignsId: UUID().uuidString,
                    anesthesia: anesthesia,
                    timestamp: currentTimestamp
                )

                entry.fc = newFc
                entry.paS = newPaS
                entry.paD = newPaD
                entry.pam = calculatePam(paS: newPaS, paD: newPaD)
                entry.spo2 = newSpo2

                // Copia os demais campos opcionais do estado atual do formulário (se existirem)
                entry.rhythm = rhythm
                entry.etco2 = newEtco2 ?? etco2
                entry.fio2 = fio2
                entry.peep = peep
                entry.volumeCorrente = newVt ?? volumeCorrente
                entry.bis = newBis ?? bis
                entry.pupilas = pupilas
                entry.tof = tof
                entry.pvc = newPvc ?? pvc
                entry.debitCardiaco = debitCardiaco
                entry.glicemia = glicemia
                entry.lactato = lactato
                entry.temperatura = newTemp ?? temperatura
                entry.diurese = diurese
                entry.sangramento = sangramento

                // Persiste a entrada
                try repo.create(entry, for: anesthesia, by: user)

                // Atualiza "últimos" para a próxima iteração
                lastFc = newFc
                lastPaS = newPaS
                lastPaD = newPaD
                lastSpo2 = newSpo2

                last = currentTimestamp
                currentTimestamp = nextSuggestedTime(anchor: anchor, last: last)
            }

            // Após gerar a série completa, sinaliza para a tela dispensar o formulário
            shouldDismissAfterGenerateSeries = true
        }
}
