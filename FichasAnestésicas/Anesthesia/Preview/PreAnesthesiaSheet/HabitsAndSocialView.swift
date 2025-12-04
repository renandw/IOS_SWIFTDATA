//
//  HabitsAndSocial.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct HabitsAndSocialView: View {
    let anesthesia: Anesthesia

    var body: some View {
        

        // PONV — histórico
        let hasRiskFactors = !(anesthesia.surgery.preanesthesia?.apfelScoreDetails?.isEmpty ?? false)
        let apfelScoreDetails = anesthesia.surgery.preanesthesia?.apfelScoreDetails ?? []
        let hasPONV = (anesthesia.surgery.preanesthesia?.apfelScoreDetails?.contains(where: { $0 == .historyPONV }) ?? false)
        let hasSocialDetails = !(anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentDetails?.isEmpty ?? true)
        let hasSocialCustomDetails = !(anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentCustomDetails?.isEmpty ?? true)
        let hasSocialText = !(anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentDetailsText?.isEmpty ?? true)
        let hasSocialAndEnvironment = hasSocialText || hasSocialCustomDetails || hasSocialDetails

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("NVPO E HÁBITOS DE VIDA")
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

                VStack(alignment: .leading, spacing: 0) {
                    if hasPONV {
                        Text("**Histórico de Naúsea e Vômitos:** Sim")
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if !hasRiskFactors {
                        Text("Sem fatores de risco para náusea e vômitos no perioperatório.")
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("**Fatores de Risco para Náuseas e Vômitos PO:**")
                                .font(.system(size: 9))
                            if !apfelScoreDetails.isEmpty {
                                Text(apfelScoreDetails.map { $0.reportDisplayName }.joined(separator: ", "))
                                    .font(.system(size: 9))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    if !hasSocialAndEnvironment {
                        Text("Sem anotações relevantes quanto a hábitos sociais e ambiente.")
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("Hábitos Sociais e Fatores Ambientais:")
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                VStack(alignment: .leading, spacing: 1) {
                                    VStack(alignment: .leading, spacing: 1) {
                                        
                                        let defaultDetails = (anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentDetails ?? []).map { $0.reportDisplayName }
                                        let customDetails = (anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentCustomDetails ?? [])
                                        let allDetails = defaultDetails + customDetails
                                        
                                        if !allDetails.isEmpty {
                                            Text(allDetails.joined(separator: " • "))
                                                .font(.system(size: 9))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        HStack(alignment: .top, spacing: 8) {
                            if let socialAndEnvironmentDetailsText = anesthesia.surgery.preanesthesia?.socialHabitsAndEnvironmentDetailsText, !socialAndEnvironmentDetailsText.isEmpty {
                                Text("Detalhes:")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 9))
                                Text(socialAndEnvironmentDetailsText)
                                    .font(.system(size: 9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
