//
//  MedicationsHelper.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//

import Foundation
import SwiftUI

public enum MedicationCategory: String, CaseIterable, Codable {
    case anestesicoInalatório = "Anestésico Inalatório"
    case hipnotico = "Hipnótico"
    case benzodiazepínico = "Benzodiazepínico"
    case alfa2Agonista = "Alfa-2 Agonista"
    case neuroléptico = "Neuroléptico"
    case bloqueadorNeuromuscular = "Bloqueador Neuromuscular"
    case vasopressor = "Vasopressor"
    case inotrópico = "Inotrópico"
    case hipotensor = "Hipotensor"
    case opioide = "Opioide"
    case analgésico = "Analgésico"
    case aine = "AINE"
    case antiemético = "Antiemético"
    case corticoide = "Corticoide"
    case antibiótico = "Antibiótico"
    case anticonvulsivante = "Anticonvulsivante"
    case antiarritmico = "Antiarritmico"
    case reversor = "Reversor"
    case betabloqueador = "Betabloqueador"
    case beta2Agonista = "Beta-2 Agonista"
    case hidroeletrolítico = "Hidroeletrolítico"
    case antialérgico = "Antialérgico"
    case cristalóide = "Cristalóide"
    case hemoderivados = "Hemoderivados"
    case colinérgico = "Colinérgico"
    case anticolinérgico = "Anticolinérgico"
    case anestésicoLocal = "Anestésico Local"
    case gasFresco = "Gases Frescos"
    case hormonal = "Hormonal"
    
    var label: String {
        return self.rawValue
    }
    
    var medicationColor: Color {
        switch self {
        case .hipnotico:
            return Color(.systemPurple)
        case .opioide:
            return Color(.systemPurple)
        case .bloqueadorNeuromuscular:
            return Color(.systemBlue)
        case .aine:
            return Color(.systemYellow)
        case .anestésicoLocal:
            return Color(.systemYellow)
        case .antiemético:
            return Color(.systemGreen)
        case .corticoide:
            return Color(.systemOrange)
        case .antibiótico:
            return Color(.systemRed)
        case .vasopressor:
            return Color(.systemOrange)
        case .cristalóide:
            return Color(.systemMint)
        case .analgésico:
            return Color(.systemCyan)
        case .gasFresco:
            return Color(.systemBrown)
        case .anestesicoInalatório:
            return Color(.systemBrown)
        case .benzodiazepínico:
            return Color(.systemIndigo)
        case .alfa2Agonista:
            return Color(.systemTeal)
        case .neuroléptico:
            return Color(.systemPink)
        case .inotrópico:
            return Color(.systemOrange)
        case .hipotensor:
            return Color(.systemBlue)
        case .anticonvulsivante:
            return Color(.systemRed)
        case .antiarritmico:
            return Color(.systemRed)
        case .reversor:
            return Color(.systemGreen)
        case .betabloqueador:
            return Color(.systemBlue)
        case .beta2Agonista:
            return Color(.systemCyan)
        case .hidroeletrolítico:
            return Color(.systemMint)
        case .antialérgico:
            return Color(.systemPink)
        case .hemoderivados:
            return Color(.systemRed)
        case .colinérgico:
            return Color(.systemGreen)
        case .anticolinérgico:
            return Color(.systemOrange)
        case .hormonal:
            return Color(.systemPurple)
        }
    }
}

public enum AdministrationRoute: String, CaseIterable, Codable {
    case EV, IM, IT, PD, PN, SC, SL, IN, TOP, VO, VR

    var label: String {
        switch self {
        case .EV:  return "Endovenoso"
        case .IM:  return "Intramuscular"
        case .IT:  return "Intratecal"
        case .PD:  return "Peridural"
        case .PN:  return "Perineural"
        case .SC:  return "Subcutâneo"
        case .SL:  return "Sublingual"
        case .IN:  return "Intranasal"
        case .TOP: return "Tópico"
        case .VO:  return "Via Oral"
        case .VR:  return "Via Respiratória"
        }
    }
}

// MARK: - Equality by Identity (event-level)
extension MedicationEntry: Equatable {
    static func ==(lhs: MedicationEntry, rhs: MedicationEntry) -> Bool {
        lhs.medicationId == rhs.medicationId &&
        lhs.name == rhs.name &&
        lhs.dose == rhs.dose &&
        lhs.via == rhs.via &&
        lhs.category == rhs.category
    }
}

struct MedicationPreset: Identifiable, Codable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let medications: [MedicationPresetItem]
    
    enum CodingKeys: String, CodingKey {
        case name, medications
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: MedicationPreset, rhs: MedicationPreset) -> Bool {
        lhs.name == rhs.name && lhs.medications == rhs.medications
    }
}

struct MedicationPresetItem: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let dose: String
    let category: MedicationCategory
    let via: AdministrationRoute

    func makeEntry(for anesthesia: Anesthesia,
                   at date: Date = .init(),
                   id: String = UUID().uuidString) -> MedicationEntry {
        MedicationEntry(
            medicationId: id,
            anesthesia: anesthesia,
            categoryRaw: category.rawValue,
            viaRaw: via.rawValue,
            dose: dose,
            name: name,
            timestamp: date
        )
    }
}

struct MedicationCatalogItem: Identifiable, Codable, Equatable {
  let id = UUID()
  let name: String
  let category: MedicationCategory
}

// MARK: - Classe Principal
class MedicationsHelper {
    
    // MARK: - Função auxiliar para normalização sem diacríticos, removendo pontuação e normalizando espaços
    private static func normalizeMedicationString(_ string: String) -> String {
        var s = string
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let allowed = CharacterSet.alphanumerics.union(.whitespaces)
        s = String(s.unicodeScalars.filter { allowed.contains($0) })
        // 3) reduzir múltiplos espaços para um só
        let parts = s.split { $0.isWhitespace }
        s = parts.joined(separator: " ")
        return s
    }
    
    
    static let adultThresholdKg: Double = 40


    static let adultFixedDoseByName: [String: String] = [
        "haloperidol": "2.5mg",
        "tenoxicam": "20mg",
        "propofol": "120mg",
        "fentanil": "150mcg",
        "rocuronio": "50mg",
        "morfina": "6mg",
        "cetamina": "50mg",
        "midazolam": "5mg",
        "succinilcolina": "100mg",
        "dipirona": "2g",
        "cetoprofeno": "100mg",
        "dimenidrato": "30mg",
        "metoclopramida": "10mg",
        "ondansetrona": "8mg",
        "dexametasona": "8mg",
        "dexmedetomidina": "70mcg",
        "diazepam": "10mg",
        "cisatracurio": "5mg",
        "paracetamol": "700mg",
        "atracurio": "10mg",
        "cefalotina": "2g",
        "tramadol": "100mg",
        "metronidazol": "500mg",
        "ciprofloxacino": "400mg",
        "cefazolina": "2g",
        "clonidina": "100mcg",
        "flumazenil": "0,5mg",
        "fenitoína": "1g",
        "sugammadex": "200mg",
        "ceftriaxona": "2g"
    ]


    static let adultFixedDoseByNameNormalized: [String: String] = {
        var dict: [String: String] = [:]
        for (k, v) in adultFixedDoseByName {
            dict[normalizeMedicationString(k)] = v
        }
        return dict
    }()
    
    // MARK: - Doses Baseadas no Peso
    static func getWeightBasedDose(medication: String, weight: Double) -> String {
        let normalizedMedication = normalizeMedicationString(medication)
        
        if weight >= adultThresholdKg, let fixed = adultFixedDoseByNameNormalized[normalizedMedication] {
            return fixed
        }
        
        
        switch normalizedMedication {
        case "propofol":
            return "\(Int(round(weight * 3)))mg"
        case "fentanil":
            return "\(Int(round(weight * 3)))mcg"
        case "rocuronio":
            return "\(Int(round(weight * 0.5)))mg"
        case "morfina":
            return "\(Int(round(weight * 0.1)))mg"
        case "cetamina":
            return "\(Int(round(weight * 1)))mg"
        case "midazolam":
            return "\(Int(round(weight * 0.15)))mg"
        case "succinilcolina":
            return "\(Int(round(weight * 1)))mg"
        case "dipirona":
            return "\(Int(round(weight * 50)))mg"
        case "cetoprofeno":
            return "\(Int(round(weight * 1)))mg"
        case "dimenidrato":
            return "\(Int(round(weight * 1.25)))mg"
        case "metoclopramida":
            return "\(Int(round(weight * 0.15)))mg"
        case "ondansetrona":
            return "\(Int(round(weight * 0.1)))mg"
        case "dexametasona":
            return "\(Int(round(weight * 0.1)))mg"
        case "dexmedetomidina":
            return "\(Int(weight * 1))mcg"
        case "diazepam":
            return "\(Int(round(weight * 0.1)))mg"
        case "haloperidol":
            return "2.5mg"
        case "cisatracurio":
            return "\(Int(round(weight * 0.15)))mg"
        case "paracetamol":
            return "\(Int(round(weight * 15)))mg"
        case "atracurio":
            return "\(Int(round(weight * 0.5)))mg"
        case "adrenalina":
            return String(format: "%.2f", weight * 0.01) + "mg"
        case "tramadol":
            return "\(Int(round(weight * 1.5)))mg"
        case "tenoxicam":
            return "20mg"
        case "escopolamina":
            return "0.5mg"
        case "bromoprida":
            return "\(Int(min(3000, weight * 0.5)))mg"
        case "cefazolina":
            return "\(Int(min(3000, weight * 30)))mg"
        case "cefalotina":
            return "\(Int(min(3000, weight * 50)))mg"
        case "cefuroxima":
            return "\(Int(min(1500, weight * 30)))mg"
        case "ceftriaxona":
            return "\(Int(min(2000, weight * 50)))mg"
        case "clindamicina":
            return "\(Int(min(900, weight * 10)))mg"
        case "metronidazol":
            return "\(Int(min(500, weight * 30)))mg"
        case "gentamicina":
            return "\(Int(round(weight * 5)))mg"
        case "ciprofloxacino":
            return "\(Int(round(weight * 6)))mg"
        case "ampicilina":
            return "\(Int(round(weight * 50)))mg"
        case "fenitoina":
            return "\(Int(round(weight * 15)))mg"
        case "clonidina":
            return "\(Int(round(weight * 2)))mcg"
        case "naloxona":
            return "\(Int(round(weight * 0.01)))mg"
        case "flumazenil":
            return String(format: "%.2f", weight * 0.01) + "mg"
        case "prometazina":
            return "\(Int(min(50, weight * 0.5)))mg"
        case "sulfato de magnesio":
            return "\(Int(round(weight * 30)))mg"
        case "hidrocortisona":
            return "\(Int(round(weight * 2)))mg"
        case "lidocaina":
            return "\(Int(round(weight * 2)))mg"
        case "atropina":
            return String(format: "%.2f", weight * 0.01) + "mg"
        default:
            return ""
        }
    }
    
    // MARK: - Via Sugerida
    static func getSuggestedVia(for medicationName: String) -> AdministrationRoute {
        let name = normalizeMedicationString(medicationName)
        
        // Anestésicos endovenosos
        if name.contains("propofol") || name.contains("etomidato") || name.contains("cetamina") {
            return .EV
        }
        
        // Benzodiazepínicos - geralmente EV em anestesia
        if name.contains("midazolam") || name.contains("diazepam") {
            return .EV
        }
        
        // Opioides - contexto determina via
        if name.contains("fentanil") || name.contains("remifentanil") || name.contains("sufentanil") {
            return .EV
        }
        if name.contains("morfina") {
            return .EV // Padrão EV, mas pode ser IT
        }
        
        // Bloqueadores neuromusculares - sempre EV
        if name.contains("rocuronio") || name.contains("atracurio") || name.contains("vecuronio") ||
           name.contains("cisatracurio") || name.contains("pancuronio") || name.contains("succinilcolina") {
            return .EV
        }
        
        // Vasopressores/Inotrópicos - sempre EV
        if name.contains("noradrenalina") || name.contains("adrenalina") || name.contains("fenilefrina") ||
           name.contains("efedrina") || name.contains("metaraminol") || name.contains("dopamina") || name.contains("dobutamina") ||
           name.contains("vasopressina") || name.contains("nitroprusseto") || name.contains("nitroglicerina") {
            return .EV
        }
        
        // Anestésicos locais - dependem do contexto
        if name.contains("pesada") || name.contains("isobarica") {
            if name.contains("sem vasoconstritor") {
                return .IT // Sem vaso geralmente é para neuroeixo
            }
            return .PN // Com vaso geralmente é para bloqueios
        }
        if name.contains("lidocaina") {
            if name.contains("adrenalina") {
                return .PN // Com adrenalina geralmente bloqueios/infiltração
            }
            return .EV // Lidocaína sem adrenalina pode ser EV
        }
        
        // Antieméticos - geralmente EV
        if name.contains("ondansetrona") || name.contains("metoclopramida") || name.contains("droperidol") ||
           name.contains("dimenidrinato") || name.contains("bromoprida") {
            return .EV
        }
        
        // Corticoides - geralmente EV
        if name.contains("dexametasona") {
            return .EV
        }
        
        // Analgésicos não-opioides
        if name.contains("dipirona") || name.contains("paracetamol") {
            return .EV
        }
        if name.contains("cetorolaco") || name.contains("cetoprofeno") || name.contains("tenoxicam") ||
           name.contains("dexketoprofeno") {
            return .EV
        }
        
        // Antibióticos - geralmente EV
        if name.contains("cefazolina") || name.contains("cefuroxima") || name.contains("ceftriaxona") ||
           name.contains("clindamicina") || name.contains("vancomicina") || name.contains("metronidazol") ||
           name.contains("gentamicina") || name.contains("ciprofloxacino") {
            return .EV
        }
        
        // Reversores - sempre EV
        if name.contains("neostigmina") || name.contains("sugammadex") || name.contains("atropina") {
            return .EV
        }
        
        // Alfa-2 agonistas
        if name.contains("dexmedetomidina") {
            return .EV
        }
        
        // Anestésicos inalatórios
        if name.contains("sevoflurano") || name.contains("desflurano") || name.contains("oxigenio") ||
           name.contains("ar comprimido") || name.contains("isoflurano") {
            return .VR
        }
        
        // Padrão para medicações não categorizadas
        return .EV
    }
    
    // MARK: - Presets de Medicações
    static let medicationPresets: [MedicationPreset] = [
        MedicationPreset(
            name: "Anestesia Geral",
            medications: [
                MedicationPresetItem(name: "Propofol", dose: "200mg", category: .hipnotico, via: .EV),
                MedicationPresetItem(name: "Fentanil", dose: "250mcg", category: .opioide, via: .EV),
                MedicationPresetItem(name: "Rocurônio", dose: "50mg", category: .bloqueadorNeuromuscular, via: .EV),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "1L/min", category: .gasFresco, via: .VR),
                MedicationPresetItem(name: "Ar Comprimido", dose: "1L/min", category: .gasFresco, via: .VR),
                MedicationPresetItem(name: "Sevoflurano", dose: "10mL", category: .anestesicoInalatório, via: .VR)
            ]
        ),
        
        MedicationPreset(
            name: "Profilaxia Dor e NVPO",
            medications: [
                MedicationPresetItem(name: "Dipirona", dose: "2g", category: .analgésico, via: .EV),
                MedicationPresetItem(name: "Metoclopramida", dose: "10mg", category: .antiemético, via: .EV),
                MedicationPresetItem(name: "Ondansetrona", dose: "8mg", category: .antiemético, via: .EV),
                MedicationPresetItem(name: "Dexametasona", dose: "10mg", category: .corticoide, via: .EV),
                MedicationPresetItem(name: "Dimenidrinato", dose: "30mg", category: .antiemético, via: .EV),
                MedicationPresetItem(name: "Cetoprofeno", dose: "100mg", category: .aine, via: .EV)
            ]
        ),
        
        MedicationPreset(
            name: "Raquianestesia - Pesada",
            medications: [
                MedicationPresetItem(name: "Bupivacaina Pesada", dose: "15mg", category: .anestésicoLocal, via: .IT),
                MedicationPresetItem(name: "Morfina", dose: "80mcg", category: .opioide, via: .IT),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "3L/min", category: .gasFresco, via: .VR)
            ]
        ),
        
        MedicationPreset(
            name: "Raquianestesia - Isobárica",
            medications: [
                MedicationPresetItem(name: "Bupivacaina Isobárica", dose: "15mg", category: .anestésicoLocal, via: .IT),
                MedicationPresetItem(name: "Morfina", dose: "80mcg", category: .opioide, via: .IT),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "3L/min", category: .gasFresco, via: .VR)
            ]
        ),
        
        MedicationPreset(
            name: "Anestesia Peridural",
            medications: [
                MedicationPresetItem(name: "Levobupivacaina", dose: "20ml", category: .anestésicoLocal, via: .PD),
                MedicationPresetItem(name: "Fentanil", dose: "100mcg", category: .opioide, via: .PD),
                MedicationPresetItem(name: "Morfina", dose: "2mg", category: .opioide, via: .PD),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "3L/min", category: .gasFresco, via: .VR),
            ]
        ),
        
        MedicationPreset(
            name: "Sedação Ambulatorial",
            medications: [
                MedicationPresetItem(name: "Propofol", dose: "70mg", category: .hipnotico, via: .EV),
                MedicationPresetItem(name: "Fentanil", dose: "50mcg", category: .opioide, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "3L/min", category: .gasFresco, via: .VR)
            ]
        ),
        
        MedicationPreset(
            name: "Bloqueio Periférico",
            medications: [
                MedicationPresetItem(name: "Levobupivacaina", dose: "50mg", category: .anestésicoLocal, via: .PN),
                MedicationPresetItem(name: "Lidocaina", dose: "100mg", category: .anestésicoLocal, via: .PN),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL", category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "3L/min", category: .gasFresco, via: .VR)
            ]
        ),
        
        MedicationPreset(
            name: "Indução Rápida (RSI)",
            medications: [
                MedicationPresetItem(name: "Etomidato", dose: "20mg", category: .hipnotico, via: .EV),
                MedicationPresetItem(name: "Succinilcolina", dose: "100mg", category: .bloqueadorNeuromuscular, via: .EV),
                MedicationPresetItem(name: "Fentanil", dose: "100mcg", category: .opioide, via: .EV),
                MedicationPresetItem(name: "Lidocaina", dose: "100mg", category: .anestésicoLocal, via: .EV),
                MedicationPresetItem(name: "Cefazolina", dose: "2g", category: .antibiótico, via: .EV),
                MedicationPresetItem(name: "Cloreto de Sódio 0,9%", dose: "100mL",category: .cristalóide, via: .EV),
                MedicationPresetItem(name: "Oxigênio", dose: "1L/min", category: .gasFresco, via: .VR)
            ]
        )
    ]
    
    // MARK: - Lista de Todas as Medicações
    static let allMedications: [MedicationCatalogItem] = [
        // Anestésicos Inalatórios
        MedicationCatalogItem(name: "Sevoflurano", category: .anestesicoInalatório),
        MedicationCatalogItem(name: "Desflurano", category: .anestesicoInalatório),
        MedicationCatalogItem(name: "Isoflurano", category: .anestesicoInalatório),
        MedicationCatalogItem(name: "Óxido nitroso", category: .anestesicoInalatório),
        MedicationCatalogItem(name: "Oxigênio", category: .gasFresco),
        MedicationCatalogItem(name: "Ar Comprimido", category: .gasFresco),
        
        // Anestésicos Endovenosos
        MedicationCatalogItem(name: "Propofol", category: .hipnotico),
        MedicationCatalogItem(name: "Etomidato", category: .hipnotico),
        MedicationCatalogItem(name: "Cetamina", category: .hipnotico),
        MedicationCatalogItem(name: "Midazolam", category: .benzodiazepínico),
        MedicationCatalogItem(name: "Dexmedetomidina", category: .alfa2Agonista),
        MedicationCatalogItem(name: "Diazepam", category: .benzodiazepínico),
        MedicationCatalogItem(name: "Haloperidol", category: .neuroléptico),
        
        // Bloqueadores Neuromusculares
        MedicationCatalogItem(name: "Succinilcolina", category: .bloqueadorNeuromuscular),
        MedicationCatalogItem(name: "Rocurônio", category: .bloqueadorNeuromuscular),
        MedicationCatalogItem(name: "Vecurônio", category: .bloqueadorNeuromuscular),
        MedicationCatalogItem(name: "Cisatracúrio", category: .bloqueadorNeuromuscular),
        MedicationCatalogItem(name: "Atracúrio", category: .bloqueadorNeuromuscular),
        MedicationCatalogItem(name: "Pancurônio", category: .bloqueadorNeuromuscular),
        
        // Vasopressores / Hipotensores
        MedicationCatalogItem(name: "Noradrenalina", category: .vasopressor),
        MedicationCatalogItem(name: "Fenilefrina", category: .vasopressor),
        MedicationCatalogItem(name: "Efedrina", category: .vasopressor),
        MedicationCatalogItem(name: "Adrenalina", category: .vasopressor),
        MedicationCatalogItem(name: "Dopamina", category: .vasopressor),
        MedicationCatalogItem(name: "Dobutamina", category: .inotrópico),
        MedicationCatalogItem(name: "Vasopressina", category: .vasopressor),
        MedicationCatalogItem(name: "Nitroprusseto de Sódio", category: .hipotensor),
        MedicationCatalogItem(name: "Nitroglicerina", category: .hipotensor),
        MedicationCatalogItem(name: "Metaraminol", category: .vasopressor),
        
        // Analgésicos Opioides
        MedicationCatalogItem(name: "Fentanil", category: .opioide),
        MedicationCatalogItem(name: "Remifentanil", category: .opioide),
        MedicationCatalogItem(name: "Sufentanil", category: .opioide),
        MedicationCatalogItem(name: "Morfina", category: .opioide),
        MedicationCatalogItem(name: "Tramadol", category: .opioide),
        
        // Analgésicos Não-opioides
        MedicationCatalogItem(name: "Dipirona", category: .analgésico),
        MedicationCatalogItem(name: "Paracetamol", category: .analgésico),
        MedicationCatalogItem(name: "Cetorolaco", category: .aine),
        MedicationCatalogItem(name: "Dexketoprofeno", category: .aine),
        MedicationCatalogItem(name: "Cetoprofeno", category: .aine),
        MedicationCatalogItem(name: "Tenoxicam", category: .aine),
        
        // Antieméticos
        MedicationCatalogItem(name: "Ondansetrona", category: .antiemético),
        MedicationCatalogItem(name: "Dexametasona", category: .corticoide),
        MedicationCatalogItem(name: "Droperidol", category: .antiemético),
        MedicationCatalogItem(name: "Metoclopramida", category: .antiemético),
        MedicationCatalogItem(name: "Dimenidrinato", category: .antiemético),
        MedicationCatalogItem(name: "Escopolamina", category: .antiemético),
        MedicationCatalogItem(name: "Bromoprida", category: .antiemético),
        
        // Antibióticos
        MedicationCatalogItem(name: "Cefazolina", category: .antibiótico),
        MedicationCatalogItem(name: "Cefalotina", category: .antibiótico),
        MedicationCatalogItem(name: "Cefuroxima", category: .antibiótico),
        MedicationCatalogItem(name: "Ceftriaxona", category: .antibiótico),
        MedicationCatalogItem(name: "Clindamicina", category: .antibiótico),
        MedicationCatalogItem(name: "Vancomicina", category: .antibiótico),
        MedicationCatalogItem(name: "Metronidazol", category: .antibiótico),
        MedicationCatalogItem(name: "Gentamicina", category: .antibiótico),
        MedicationCatalogItem(name: "Ciprofloxacino", category: .antibiótico),
        MedicationCatalogItem(name: "Ampicilina", category: .antibiótico),
        
        // Anticonvulsivantes
        MedicationCatalogItem(name: "Fenitoína", category: .anticonvulsivante),
        MedicationCatalogItem(name: "Fenobarbital", category: .anticonvulsivante),
        
        // Antiarritmicos
        MedicationCatalogItem(name: "Amiodarona", category: .antiarritmico),
        
        // Miscelânia
        MedicationCatalogItem(name: "Clonidina", category: .alfa2Agonista),
        MedicationCatalogItem(name: "Ocitocina", category: .hormonal),
        MedicationCatalogItem(name: "Flumazenil", category: .reversor),
        MedicationCatalogItem(name: "Naloxona", category: .reversor),
        MedicationCatalogItem(name: "Esmolol", category: .betabloqueador),
        MedicationCatalogItem(name: "Metoprolol", category: .betabloqueador),
        MedicationCatalogItem(name: "Bisoprolol", category: .betabloqueador),
        MedicationCatalogItem(name: "Hidralazina", category: .hipotensor),
        MedicationCatalogItem(name: "Salbutamol (inalado)", category: .beta2Agonista),
        MedicationCatalogItem(name: "Hidrocortisona", category: .corticoide),
        MedicationCatalogItem(name: "Sulfato de Magnésio", category: .hidroeletrolítico),
        MedicationCatalogItem(name: "Prometazina", category: .antialérgico),
        MedicationCatalogItem(name: "Gluconato de Cálcio 10%", category: .hidroeletrolítico),
        MedicationCatalogItem(name: "Bicarbonato de Sódio 8,4%", category: .hidroeletrolítico),
        MedicationCatalogItem(name: "Cloreto de Sódio 0,9%", category: .cristalóide),
        MedicationCatalogItem(name: "Soro Glicosado 5%", category: .cristalóide),
        MedicationCatalogItem(name: "Ringer Lactato", category: .cristalóide),
        MedicationCatalogItem(name: "Concentrado de Hemácias", category: .hemoderivados),
        MedicationCatalogItem(name: "Plaquetas", category: .hemoderivados),
        MedicationCatalogItem(name: "Plasma Fresco Congelado", category: .hemoderivados),
        
        // Reversores
        MedicationCatalogItem(name: "Neostigmina", category: .colinérgico),
        MedicationCatalogItem(name: "Atropina", category: .anticolinérgico),
        MedicationCatalogItem(name: "Sugammadex", category: .reversor),
        MedicationCatalogItem(name: "Metilergometrina", category: .hormonal),
        
        // Anestésicos Locais
        MedicationCatalogItem(name: "Lidocaina + adrenalina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Bupivacaina + adrenalina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Ropivacaina + adrenalina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Lidocaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Bupivacaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Bupivacaina Pesada", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Bupivacaina Isobárica", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Ropivacaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Mepivacaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Prilocaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Levobupivacaina", category: .anestésicoLocal),
        MedicationCatalogItem(name: "Levobupivacaina + adrenalina", category: .anestésicoLocal)
    ]
}
