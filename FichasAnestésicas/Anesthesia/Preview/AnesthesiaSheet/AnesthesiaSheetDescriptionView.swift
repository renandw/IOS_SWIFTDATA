//
//  AnesthesiaSheetDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct AnesthesiaSheetDescriptionView: View {
    let anesthesia: Anesthesia
    
    
    var body: some View {
        
        let positioning = (anesthesia.position.map(\.rawValue).joined(separator: ", "))
        let techniques = ((anesthesia.shared?.techniques ?? []).map(\.displayName).joined(separator: ", "))
        

        let finalDescription = anesthesia.anesthesiaDescription?.veryEndDescriptionText ?? "Sem descrição"
        VStack(spacing: 0) {
            // Title
            HStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 4)
                Text("DESCRIÇÃO ANESTÉSICA")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
            // Content
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    if !techniques.isEmpty {
                        if techniques.count == 1 {
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("Técnica Anestésica:")
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("\(techniques)")
                                    .font(.system(size: 9))
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } else if techniques.count > 1 {
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("Técnicas Anestésicas:")
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("\(techniques)")
                                    .font(.system(size: 9))
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    if !positioning.isEmpty {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Posicionamento:")
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                                .lineSpacing(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(positioning)")
                                .font(.system(size: 9))
                                .lineSpacing(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer(minLength: 0)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                
                }
                if !finalDescription.isEmpty {
                    Text(finalDescription)
                        .font(.system(size: 9))
                        .lineSpacing(2)
                        .padding(.top, 6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(12)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .fixedSize(horizontal: false, vertical: true)

    }
}

