//
//  AnestheticTechniqueView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//

import SwiftUI
struct AnestheticTechniqueView: View {
    let anesthesia: Anesthesia
    
    var body: some View {

        let techniques = (anesthesia.surgery.shared?.techniques ?? []).map { $0.displayName }
        
        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)
                    Text("TÉCNICAS ANESTÉSICA PROPOSTA")
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
                if !techniques.isEmpty {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("**Técnicas Anestésicas:** \(techniques.joined(separator: ", "))")
                            .font(.system(size: 9))
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                
            }
            .fixedSize(horizontal: false, vertical: true)
            
        )
    }
}
