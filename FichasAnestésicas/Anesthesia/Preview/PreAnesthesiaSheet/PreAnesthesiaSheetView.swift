//
//  PreAnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//

import SwiftUI

struct PreanesthesiaSheetView: View {
    let anesthesia: Anesthesia
    
    private let pageWidth: CGFloat = 567
    private let pageHeight: CGFloat = 813
    private let padding: CGFloat = 28
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 1) {
                PreAnestheticHeaderView(anesthesia: anesthesia)
                PreAnestheticPatientInfoView(anesthesia: anesthesia)
                Spacer()
            }
            .padding(padding)
            .frame(width: pageWidth, height: pageHeight)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
