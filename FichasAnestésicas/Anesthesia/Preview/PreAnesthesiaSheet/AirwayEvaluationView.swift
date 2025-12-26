
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
                            .foregroundColor(.gray)
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
                    let pre = anesthesia.surgery.preanesthesia
                    let details = pre?.difficultAirwayDetails ?? []

                    let hasMallampati = pre?.mallampatiClassification != nil
                    let hasTraqueo = details.contains { $0.type == .traqueo }
                    let hasPredictors = !details.filter { $0.type != .traqueo }.isEmpty

                    let hasAnyDetails = hasMallampati || hasPredictors
                    if hasTraqueo {
                        Text("Paciente possui via aérea definitiva")
                            .font(.system(size: 9))
                            .fontWeight(.semibold)

                    } else if hasAnyDetails {
                        HStack(spacing: 6) {

                            Text("Avaliação de Vias Aéreas:")
                                .font(.system(size: 9))
                                .fontWeight(.semibold)

                            if let mallampati = pre?.mallampatiClassification {
                                HStack {
                                    Text("Mallampati:")
                                        .fontWeight(.semibold)
                                    Text(mallampati.displayName)
                                }
                                .font(.system(size: 9))
                            }

                            let predictors = details.filter { $0.type != .traqueo }

                            if predictors.isEmpty {
                                Text("Sem preditores via aérea difícil")
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            } else {
                                HStack(alignment: .top) {
                                    Text("Preditores:")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 9))

                                    VStack(alignment: .leading, spacing: 4) {
                                        ForEach(predictors) { detail in
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(detail.displayName())
                                                    .font(.system(size: 9))

                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.system(size: 9))
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
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
