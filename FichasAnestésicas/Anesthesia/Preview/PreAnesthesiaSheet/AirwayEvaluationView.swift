
//
//  AirwayEvaluation.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//

import SwiftUI

struct AirwayEvaluationView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        return AnyView(
            VStack(spacing: 0) {
                    HStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 4)
                        
                        Text("AVALIAÇÃO DA VIA AÉREA")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        
                        Spacer()
                    }
                    .background(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(topLeading: 4, topTrailing: 4)
                        )
                        .fill(Color.gray.opacity(0.2))
                    )
                    
                VStack(alignment: .leading, spacing: 2) {
                    let hasMallampatiDetails = (anesthesia.surgery.preanesthesia?.mallampatiClassification != nil)
                    let hasDetails = !(anesthesia.surgery.preanesthesia?.difficultAirwayEvaluation?.isEmpty ?? true)
                    let hasCustomDetails = !((anesthesia.surgery.preanesthesia?.difficultAirwayEvaluationCustomDetails ?? []).isEmpty)
                    let hasTextDetails = !(anesthesia.surgery.preanesthesia?.difficultAirwayEvaluationDetailsText?.isEmpty ?? true)
                    let hasTraqueo = (anesthesia.surgery.preanesthesia?.difficultAirwayEvaluation?.contains(.traqueo) ?? false)
                    let hasAnyDetails = hasMallampatiDetails || hasDetails || hasCustomDetails || hasTextDetails
                    
                    
                    if hasTraqueo {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Paciente possui via aérea definitiva")
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    } else if hasAnyDetails {
                        VStack(alignment: .leading) {
                            Text("Avaliação de Vias Aéreas:")
                                .fontWeight(.semibold)
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let mallampatiDetails = anesthesia.surgery.preanesthesia?.mallampatiClassification {
                                        HStack {
                                            Text("Mallampati:")
                                                .fontWeight(.semibold)
                                            Text(mallampatiDetails.displayName)
                                                .font(.system(size: 9))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                let defaultEvaluations = (anesthesia.surgery.preanesthesia?.difficultAirwayEvaluation ?? []).filter { $0 != .traqueo }
                                let defaultDetails = defaultEvaluations.map { $0.displayName }
                                let customDetails = (anesthesia.surgery.preanesthesia?.difficultAirwayEvaluationCustomDetails ?? [])
                                let all = defaultDetails + customDetails
                                if !all.isEmpty {
                                    
                                    HStack {
                                        Text("Preditores:")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 9))
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            
                                            if !all.isEmpty {
                                                Text(all.joined(separator: " • "))
                                                    .font(.system(size: 9))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                                            }
                                        }
                                    }
                                    HStack(alignment: .top) {
                                        if let difficultAirwayEvaluationDetailsText = anesthesia.surgery.preanesthesia?.difficultAirwayEvaluationDetailsText, !difficultAirwayEvaluationDetailsText.isEmpty {
                                            Text("Detalhes:")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 9))
                                            Spacer()
                                            Text(difficultAirwayEvaluationDetailsText)
                                                .font(.system(size: 9))
                                        }
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
