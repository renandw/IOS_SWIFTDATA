//
//  PhysicalExamView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct PhysicalExamView: View {
    let anesthesia: Anesthesia
    
    
    
    var body: some View {
        
        let physicalExam = anesthesia.surgery.preanesthesia?.physicalExaminationDetailsText ?? ""
        
        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("EXAME FÍSICO")
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
                    Text(physicalExam)
                        .font(.system(size: 10))
                        .lineSpacing(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 8)
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
