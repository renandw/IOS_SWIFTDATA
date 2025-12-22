//
//  LabResultsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct LabsResultsView: View {
    let anesthesia: Anesthesia
    
    var body: some View {

        let labs = anesthesia.surgery.preanesthesia?.laboratoryExams
        let hasHemoglobin = labs?.hemoglobin != nil
        let hasHematocrit = labs?.hct != nil
        let hasUrea = labs?.urea != nil
        let hasCreatinine = labs?.creatinine != nil
        let hasSodium = labs?.sodium != nil
        let hasPotassium = labs?.potassium != nil
        let hasInr = labs?.inr != nil
        let hasGlucose = labs?.glucose != nil
        let hasAnyLabExam = hasHemoglobin || hasHematocrit || hasUrea || hasCreatinine || hasSodium || hasPotassium || hasInr || hasGlucose

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("EXAMES COMPLEMENTARES")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)

                    Spacer()
                }
                .background(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(topLeading: 4, topTrailing: 4)
                    )
                    .fill(Color.gray.opacity(0.2))
                )
                VStack(alignment: .leading, spacing: 2) {
                    if !hasAnyLabExam {
                        Text("Sem exames laboratoriais registrados")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                        
                    } else {
                        HStack(alignment: .top, spacing: 4) {
                            Text("Exames Laboratoriais:")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                            
                            let labItems: [String] = [
                                labs?.hemoglobin.map { "Hb: \(String(format: "%.1f", $0)) g/dL" },
                                labs?.hemoglobin.map { "Ht: \(String(format: "%.1f", $0)) g/dL" },
                                labs?.urea.map { "Ur: \(String(format: "%.0f", $0)) mg/dL" },
                                labs?.creatinine.map { "Cr: \(String(format: "%.2f", $0)) mg/dL" },
                                labs?.sodium.map { "Na: \(String(format: "%.0f", $0)) mEq/L" },
                                labs?.potassium.map { "K: \(String(format: "%.1f", $0)) mEq/L" },
                                labs?.inr.map { "INR: \(String(format: "%.2f", $0))" },
                                labs?.glucose.map { "Glicemia: \(String(format: "%.0f", $0)) mg/dL" }
                            ].compactMap { $0 }
                            
                            Text(labItems.joined(separator: " • "))
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                    }
                    
                    let imagingExams = anesthesia.surgery.preanesthesia?.imagingExams ?? []
                    let customImagingExams = anesthesia.surgery.preanesthesia?.customImagingExams ?? []
                    let hasImagingExams = !imagingExams.isEmpty
                    let hasCustomImagingExams = !customImagingExams.isEmpty
                    let hasAnyImagingExam = hasImagingExams || hasCustomImagingExams
                    
                    if !hasAnyImagingExam {
                        Text("Sem outros exames complementares registrados")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                    } else {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Exames Complementares:")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                            
                            HStack(alignment: .top, spacing: 4) {
                                // Exames padrão com achados
                                ForEach(imagingExams) { exam in
                                    HStack(alignment: .top, spacing: 4) {
                                        Text(exam.type.displayName)
                                            .foregroundColor(.black)
                                            .font(.system(size: 9))
                                            .fontWeight(.medium)
                                        
                                        if !exam.findings.isEmpty {
                                            let findingsText = exam.findings.map { finding in
                                                switch finding {
                                                case .chestXRay(let xrayFinding):
                                                    return xrayFinding.displayName
                                                case .ecg(let ecgFinding):
                                                    return ecgFinding.displayName
                                                case .echocardiogram(let echoFinding):
                                                    return echoFinding.displayName
                                                }
                                            }.joined(separator: " • ")
                                            
                                            Text(findingsText)
                                                .foregroundColor(.black)
                                                .font(.system(size: 9))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        
                                        if let customFinding = exam.customFinding, !customFinding.isEmpty {
                                            Text(customFinding)
                                                .font(.system(size: 9))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                }
                                
                                // Exames customizados
                                if hasCustomImagingExams {
                                    HStack(alignment: .top, spacing: 4) {
                                        Text("Outros exames:")
                                            .foregroundColor(.black)
                                            .font(.system(size: 9))
                                            .fontWeight(.medium)
                                        
                                        Text(customImagingExams.joined(separator: " • "))
                                            .font(.system(size: 9))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                
            }
            .fixedSize(horizontal: false, vertical: true)
        )
    }
}

