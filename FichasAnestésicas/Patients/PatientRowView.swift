//
//  PatientRowView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/10/25.
//

import SwiftUI

struct PatientRowView: View {
    let patient: Patient
    let ageContext: AgeContext
    //let surgery: Surgery? // será implementado quando tivermos o @model Surgery
    
    
    
    private func initials(from name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = trimmed.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        guard !parts.isEmpty else { return "" }
        if parts.count == 1 {
            if let firstChar = parts[0].first {
                return String(firstChar).uppercased()
            } else {
                return ""
            }
        } else {
            let firstPart = parts.first!
            let lastPart = parts.last!
            let firstInitial = firstPart.first.map { String($0) } ?? ""
            let lastInitial = lastPart.first.map { String($0) } ?? ""
            return (firstInitial + lastInitial).uppercased()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(patient.sex.sexColor)
                        .frame(width: 40, height: 40)
                    Text(initials(from: patient.name))
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                }
                VStack(alignment: .leading) {
                
                    Text(patient.name)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .truncationMode(.tail)
                
                
                    HStack {
//                        Image(systemName: patient.sex.sexImage)
//                            .foregroundStyle(patient.sex.sexColor)
                        
                        Text(patient.sex.sexStringDescription)
                            .font(.caption)
                        
                        Text("•")
                        
                        Text(patient.birthDate, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits))
                            .font(.caption)
                        
                        Text("•")
                        
                        Text(ageContext.ageString(from: patient.birthDate))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    HStack {
                        Text("Cns:")
                            .font(.caption)
                        Text(patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                            .font(.caption)
                            .foregroundStyle(patient.cns == "00000000000000" ? .orange : .primary)
                    }
                }

            }
            //.padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
}

