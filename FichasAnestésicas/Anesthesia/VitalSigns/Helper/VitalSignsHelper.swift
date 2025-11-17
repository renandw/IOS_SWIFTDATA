//
//  VitalSignsHelper.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 16/11/25.
//
import SwiftUI

enum HeartRateRange {
    case normal
    case bradycardia
    case tachycardia
    
    var color: Color {
        switch self {
        case .normal: return .green
        case .bradycardia: return .blue
        case .tachycardia: return .orange
        }
    }
    
    var label: String {
        switch self {
        case .normal: return "Normal"
        case .bradycardia: return "Bradicardia"
        case .tachycardia: return "Taquicardia"
        }
    }
}

struct HeartRateNorms {
    let minNormal: Int
    let maxNormal: Int
    
    func classify(heartRate: Double) -> HeartRateRange {
        let hr = Int(heartRate)
        if hr < minNormal {
            return .bradycardia
        } else if hr > maxNormal {
            return .tachycardia
        } else {
            return .normal
        }
    }
    
    var rangeDescription: String {
        return "\(minNormal)-\(maxNormal) bpm"
    }
    
    static func forAge(_ age: Int) -> HeartRateNorms {
        switch age {
        case 0:  // Neonato (0-1 mês)
            return HeartRateNorms(minNormal: 100, maxNormal: 160)
        case 1..<1:  // 1-12 meses
            return HeartRateNorms(minNormal: 100, maxNormal: 150)
        case 1..<3:  // 1-2 anos
            return HeartRateNorms(minNormal: 90, maxNormal: 140)
        case 3..<6:  // 3-5 anos
            return HeartRateNorms(minNormal: 80, maxNormal: 120)
        case 6..<12: // 6-11 anos
            return HeartRateNorms(minNormal: 70, maxNormal: 110)
        case 12..<18: // 12-17 anos (adolescente)
            return HeartRateNorms(minNormal: 60, maxNormal: 100)
        default: // ≥18 anos (adulto)
            return HeartRateNorms(minNormal: 60, maxNormal: 100)
        }
    }
}


