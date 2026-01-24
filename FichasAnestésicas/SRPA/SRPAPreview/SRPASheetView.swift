
//
//  AnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//

import SwiftData
import SwiftUI

struct SRPASheetView: View {
    let srpa: SRPA

    // A4 dimensions in points (72 DPI): 200mm ≈ 567pt, 287mm ≈ 813pt
    private let pageWidth: CGFloat = 567
    private let pageHeight: CGFloat = 813
    private let padding: CGFloat = 28 // 10mm ≈ 28pt

    var body: some View {
        VStack(spacing: 0) {
            // Container with A4 dimensions
            VStack(spacing: 0) {
                SRPAHeaderView(srpa: srpa)
                SRPASheetPatientInfoView(srpa: srpa)
                SRPASheetMedicationsView(srpa: srpa)
                SRPASheetVitalSignsView(srpa: srpa)
                SRPASheetDescriptionView(srpa: srpa)
                SRPASheetViewTeamAndProcedure(srpa: srpa)
                Spacer()
                SRPASheetFooterView(srpa: srpa)
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
