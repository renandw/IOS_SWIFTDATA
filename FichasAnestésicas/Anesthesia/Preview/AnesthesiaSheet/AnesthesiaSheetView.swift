//
//  AnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//


import SwiftUI

struct AnesthesiaSheetView: View {
    let anesthesia: Anesthesia

    // A4 dimensions in points (72 DPI): 200mm ≈ 567pt, 287mm ≈ 813pt
    private let pageWidth: CGFloat = 595
    private let pageHeight: CGFloat = 842
    private let padding: CGFloat = 28 // 10mm ≈ 28pt

    var body: some View {
        VStack(spacing: 0) {
            // Container with A4 dimensions
            VStack(spacing: 4) {
                AnesthesiaHeaderView(anesthesia: anesthesia)
                AnesthesiaSheetPatientInfoView(anesthesia: anesthesia)
                //MedicationGroupsView(data: data)
                //VitalSignsView2(data: data)
                //AnesthesiaDescriptionView(data: data)
                //TeamAndProceduresView(data: data)
                Spacer()
                //FooterView(data: data)
                //AssinaturaGovBRView(data: data)
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
