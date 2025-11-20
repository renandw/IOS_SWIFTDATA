//
//  VitalSignsFormViewModel+GenerateSeries.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 18/11/25.
//

import Foundation

// MARK: - Fase da Anestesia

enum AnesthesiaPhase {
    case induction    // 0-15 min
    case maintenance  // meio do caso
    case emergence    // últimos 20 min
    case shortCase    // casos < 40 min (sem fases distintas)
}

// MARK: - Perfil de Técnica Anestésica

struct TechniqueProfile {
    let fcVariability: Double        // desvio máximo de FC
    let paVariability: Double        // desvio máximo de PA
    let spo2Range: ClosedRange<Double> // range de SpO2
    let inductionPaDrop: Double      // % queda PA na indução (0.0 a 1.0)
    let inductionFcChange: Double    // % mudança FC na indução (pode ser negativo)
    let emergencePaRise: Double      // % subida PA no despertar
    let emergenceFcRise: Double      // % subida FC no despertar
    let smoothingFactor: Double      // 0.0 (máxima suavização) a 1.0 (sem suavização)
    
    static func forTechniques(_ techniques: [AnesthesiaTechniqueKind], isInfant: Bool) -> TechniqueProfile {
        // Raquianestesia: queda importante de PA, FC pode compensar
        if techniques.contains(.raquianestesia) {
            return TechniqueProfile(
                fcVariability: 8,
                paVariability: 15,
                spo2Range: 96...100,
                inductionPaDrop: 0.25,      // queda de 25% na PA
                inductionFcChange: 0.15,    // FC sobe 15% (compensação)
                emergencePaRise: 0.10,
                emergenceFcRise: 0.05,
                smoothingFactor: 0.4
            )
        }
        
        // Anestesia geral: muito estável após indução
        let hasGeneral = techniques.contains {
            $0 == .geralBalanceada || $0 == .geralVenosaTotal || $0 == .geralInalatoria
        }
        
        if hasGeneral {
            return TechniqueProfile(
                fcVariability: 3,
                paVariability: 8,
                spo2Range: isInfant ? 96...100 : 98...100,
                inductionPaDrop: 0.15,
                inductionFcChange: -0.10,   // FC cai um pouco
                emergencePaRise: 0.15,
                emergenceFcRise: 0.20,      // FC sobe mais no despertar
                smoothingFactor: 0.25       // muito suave
            )
        }
        
        // Sedação: mais variabilidade, mantém reflexos
        if techniques.contains(.sedacao) {
            return TechniqueProfile(
                fcVariability: 6,
                paVariability: 10,
                spo2Range: 95...100,
                inductionPaDrop: 0.05,
                inductionFcChange: 0.05,
                emergencePaRise: 0.05,
                emergenceFcRise: 0.08,
                smoothingFactor: 0.5        // mais variável
            )
        }
        
        // Bloqueio de plexo / local: mínimas alterações
        return TechniqueProfile(
            fcVariability: 5,
            paVariability: 8,
            spo2Range: 96...100,
            inductionPaDrop: 0.05,
            inductionFcChange: 0.0,
            emergencePaRise: 0.03,
            emergenceFcRise: 0.05,
            smoothingFactor: 0.4
        )
    }
}

// MARK: - Gerador de Série

struct VitalSignsSeriesGenerator {
    let anesthesia: Anesthesia
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

    func generate() -> [VitalSignEntry] {
        guard !timestamps.isEmpty else { return [] }
        
        let isInfant = patientAge <= 1
        let profile = TechniqueProfile.forTechniques(techniques, isInfant: isInfant)
        let duration = Int(timestamps.last!.timeIntervalSince(timestamps.first!) / 60)
        
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
        
        var entries: [VitalSignEntry] = []
        
        for (index, timestamp) in timestamps.enumerated() {
            let phase = determinePhase(
                timestamp: timestamp,
                anchor: timestamps.first!,
                duration: duration
            )
            
            // Calcula targets ajustados pela fase
            let targets = calculateTargets(
                phase: phase,
                profile: profile,
                baseFc: baseFc,
                basePaS: basePaS,
                basePaD: basePaD,
                baseSpo2: baseSpo2,
                baseEtco2: baseEtco2,
                baseVt: baseVt,
                baseBis: baseBis,
                basePvc: basePvc,
                baseTemp: baseTemp,
                isInfant: isInfant
            )
            
            // Suavização exponencial com ruído fisiológico
            // PA: mais variável (alpha maior + ruído)
            let newPaS = smoothValue(
                last: lastPaS,
                target: targets.paS,
                alpha: profile.smoothingFactor + 0.2, // PA mais reativa
                range: (basePaS - profile.paVariability)...(basePaS + profile.paVariability),
                noise: -3...3 // ±3 mmHg de ruído
            ).rounded()
            
            let newPaD = smoothValue(
                last: lastPaD,
                target: targets.paD,
                alpha: profile.smoothingFactor + 0.2,
                range: (basePaD - profile.paVariability * 0.7)...(basePaD + profile.paVariability * 0.7),
                noise: -2...2 // ±2 mmHg de ruído
            ).rounded()
            
            // FC: moderadamente variável
            let newFc = smoothValue(
                last: lastFc,
                target: targets.fc,
                alpha: profile.smoothingFactor,
                range: (baseFc - profile.fcVariability)...(baseFc + profile.fcVariability),
                noise: -2...2 // ±2 bpm de ruído
            ).rounded()
            
            // SpO2: estável mas não fixo
            let newSpo2 = smoothValue(
                last: lastSpo2,
                target: targets.spo2,
                alpha: 0.3,
                range: profile.spo2Range,
                noise: -1...1 // pequena oscilação
            ).rounded()
            
            // EtCO2: se presente, variação mínima
            var newEtco2: Double? = nil
            if let lastE = lastEtco2, let targetE = targets.etco2 {
                let range = (targetE - 2)...(targetE + 2)
                newEtco2 = smoothValue(last: lastE, target: targetE, alpha: 0.3, range: range, noise: -1...1).rounded()
                lastEtco2 = newEtco2
            }
            
            // Volume corrente: variação mínima se em VM
            var newVt: Double? = nil
            if let lastV = lastVt, let targetV = targets.vt {
                let delta = isInfant ? 5.0 : max(15.0, targetV * 0.15)
                let range = max(0, targetV - delta)...(targetV + delta)
                newVt = smoothValue(last: lastV, target: targetV, alpha: 0.4, range: range, noise: -5...5).rounded()
                lastVt = newVt
            }
            
            // BIS: se presente, varia conforme fase
            var newBis: Double? = nil
            if let lastB = lastBis, let targetB = targets.bis {
                let range = (targetB - 5)...(targetB + 5)
                newBis = smoothValue(last: lastB, target: targetB, alpha: 0.35, range: range, noise: -1...1).rounded()
                lastBis = newBis
            }
            
            // PVC: variação mínima
            var newPvc: Double? = nil
            if let lastP = lastPvc, let targetP = targets.pvc {
                let range = (targetP - 3)...(targetP + 3)
                newPvc = smoothValue(last: lastP, target: targetP, alpha: 0.4, range: range, noise: -0.5...0.5).rounded()
                lastPvc = newPvc
            }
            
            // Temperatura: drift lento (hipotermia gradual)
            var newTemp: Double? = nil
            if let lastT = lastTemp, let targetT = targets.temp {
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
            let entry = VitalSignEntry(
                vitalSignsId: UUID().uuidString,
                anesthesia: anesthesia,
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
    
    // MARK: - Funções Auxiliares
    
    private func determinePhase(timestamp: Date, anchor: Date, duration: Int) -> AnesthesiaPhase {
        guard duration > 40 else { return .shortCase }
        
        let elapsed = timestamp.timeIntervalSince(anchor) / 60 // minutos
        
        if elapsed < 15 {
            return .induction
        } else if elapsed > Double(duration - 20) {
            return .emergence
        } else {
            return .maintenance
        }
    }
    
    private func calculateTargets(
        phase: AnesthesiaPhase,
        profile: TechniqueProfile,
        baseFc: Double,
        basePaS: Double,
        basePaD: Double,
        baseSpo2: Double,
        baseEtco2: Double?,
        baseVt: Double?,
        baseBis: Double?,
        basePvc: Double?,
        baseTemp: Double?,
        isInfant: Bool
    ) -> (fc: Double, paS: Double, paD: Double, spo2: Double, etco2: Double?, vt: Double?, bis: Double?, pvc: Double?, temp: Double?) {
        
        var targetFc = baseFc
        var targetPaS = basePaS
        var targetPaD = basePaD
        var targetSpo2 = baseSpo2
        var targetBis = baseBis
        var targetTemp = baseTemp
        
        switch phase {
        case .induction:
            // Queda de PA e ajuste de FC
            targetPaS = basePaS * (1 - profile.inductionPaDrop)
            targetPaD = basePaD * (1 - profile.inductionPaDrop)
            targetFc = baseFc * (1 + profile.inductionFcChange)
            
            // BIS cai na indução
            if let bis = baseBis {
                targetBis = max(40, bis - 15)
            }
            
            // Adiciona pequena variação aleatória
            targetFc += Double.random(in: -2...2)
            targetPaS += Double.random(in: -3...3)
            targetPaD += Double.random(in: -2...2)
            
        case .maintenance:
            // Manutenção: valores próximos da base com mínima variação
            targetFc = baseFc + Double.random(in: -1...1)
            targetPaS = basePaS + Double.random(in: -2...2)
            targetPaD = basePaD + Double.random(in: -1...1)
            targetSpo2 = baseSpo2 // SpO2 fixo na manutenção
            
            // Temperatura cai lentamente (hipotermia)
            if let temp = baseTemp {
                targetTemp = temp - 0.3 // drift de -0.3°C ao longo da manutenção
            }
            
        case .emergence:
            // Despertar: PA e FC sobem
            targetPaS = basePaS * (1 + profile.emergencePaRise)
            targetPaD = basePaD * (1 + profile.emergencePaRise * 0.7)
            targetFc = baseFc * (1 + profile.emergenceFcRise)
            
            // BIS sobe no despertar
            if let bis = baseBis {
                targetBis = min(95, bis + 20)
            }
            
            targetFc += Double.random(in: -3...3)
            targetPaS += Double.random(in: -4...4)
            targetPaD += Double.random(in: -2...2)
            
        case .shortCase:
            // Casos curtos: apenas pequena variabilidade
            targetFc = baseFc + Double.random(in: -2...2)
            targetPaS = basePaS + Double.random(in: -3...3)
            targetPaD = basePaD + Double.random(in: -2...2)
            targetSpo2 = baseSpo2
        }
        
        return (
            fc: targetFc,
            paS: targetPaS,
            paD: targetPaD,
            spo2: targetSpo2,
            etco2: baseEtco2,
            vt: baseVt,
            bis: targetBis,
            pvc: basePvc,
            temp: targetTemp
        )
    }
    
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
        let generator = VitalSignsSeriesGenerator(
            anesthesia: anesthesia,
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

            try repo.create(entry, for: anesthesia, by: user)
        }

        // Após gerar a série completa, sinaliza para a tela dispensar o formulário
        shouldDismissAfterGenerateSeries = true
    }
}

