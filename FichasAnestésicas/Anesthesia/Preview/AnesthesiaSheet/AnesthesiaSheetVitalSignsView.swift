//
//  AnesthesiaSheetVitalSignsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI

struct AnesthesiaSheetVitalSignsView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
            VStack(spacing: 0) {
                // Title
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)
                    Text("SINAIS VITAIS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    Spacer()
                }
                .background(Color.gray.opacity(0.2))
                
                // Chart
                VStack(spacing: 0) {
                    VitalChartSheet(anesthesia: anesthesia)
                    
                }
                .frame(height: 200)
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .fixedSize(horizontal: false, vertical: true)
            
        }
}
