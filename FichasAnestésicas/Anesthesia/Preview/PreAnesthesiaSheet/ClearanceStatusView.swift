//
//  ClearanceStatusView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//

import SwiftUI

struct ClearanceStatusView: View {
    let anesthesia: Anesthesia

    var body: some View {

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("PARECER DA AVALIAÇÃO")
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

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        VStack(alignment: .trailing, spacing: 4) {
                            if let status = anesthesia.surgery.preanesthesia?.clearenceStatus {
                                Text("**Parecer da Avaliação:** \(status.displayName)")
                                    .font(.system(size: 9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            if let asaText = anesthesia.surgery.shared?.asa?.displayName {
                                Text("**Classificação ASA:** \(asaText)")
                                    .font(.system(size: 9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    if let recommendations = anesthesia.surgery.preanesthesia?.definitiveRecommendationForRevaluationStatus,
                       !recommendations.isEmpty {
                        
                        let joined = recommendations.map { $0.reportDisplayName }.joined(separator: "; ")
                        
                        HStack(spacing: 4) {
                            Text("Recomendações:").bold()
                            Text(joined)
                            if let custom = anesthesia.surgery.preanesthesia?.futherRecommendationForRevaluation,
                               !custom.isEmpty {
                                Text("; \(custom.joined(separator: "; "))")
                            }
                        }
                        .font(.system(size: 9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(anesthesia.surgery.preanesthesia?.clearenceStatus?.color.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke((anesthesia.surgery.preanesthesia?.clearenceStatus?.color ?? .gray).opacity(0.3), lineWidth: 1)
                )
            }
            .fixedSize(horizontal: false, vertical: true)
            //.cornerRadius(4, corners: [.bottomLeft, .bottomRight])
        )
    }
}
