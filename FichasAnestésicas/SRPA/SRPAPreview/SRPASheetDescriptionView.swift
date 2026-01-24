//
//  AnesthesiaSheetDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaSheetDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct SRPASheetDescriptionView: View {
    let srpa: SRPA
    
    
    var body: some View {
        
        let finalDescription = srpa.descriptionText ?? "Sem descrição"
        VStack(spacing: 0) {
            // Title
            HStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 4)
                Text("DESCRIÇÃO ANESTÉSICA")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
            // Content
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    if !finalDescription.isEmpty {
                        Text(finalDescription)
                            .font(.system(size: 9))
                            .lineSpacing(2)
                            .padding(.top, 6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.black)
                    }
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

