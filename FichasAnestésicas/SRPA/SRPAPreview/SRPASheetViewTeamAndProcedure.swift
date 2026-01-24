//
//  AnesthesiaSheetViewTeamAndProcedure.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaSheetViewTeamAndProcedure.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct SRPASheetViewTeamAndProcedure: View {
    let srpa: SRPA
    
    
    var body: some View {
        // Compute fields
        let mainSurgeon = srpa.surgery.mainSurgeon
        let auxSurgeons = (srpa.surgery.auxiliarySurgeons ?? []).joined(separator: ", ")
        let auxSurgeonsDisplay = auxSurgeons.isEmpty ? "" : auxSurgeons


        let isSUS = srpa.surgery.type == .sus
        let procLabel = isSUS ? "Cirurgia proposta" : "Procedimento"
        let procValue = isSUS ? srpa.surgery.proposedProcedure : srpa.surgery.proposedProcedure
        let codes = (srpa.surgery.cbhpmProcedures ?? []).map(\.code)
        let portes = (srpa.surgery.cbhpmProcedures ?? []).map(\.port)
        VStack(spacing: 0) {
            // Title
            HStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 4)
                Text("EQUIPE CIRÚRGICA E PROCEDIMENTOS")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
            // Content
            VStack(alignment: .leading, spacing: 4) {
                 HStack(spacing: 12) {
                Text("**Cirurgião Principal:** \(mainSurgeon)")
                    .font(.system(size: 9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                if !auxSurgeons.isEmpty{
                Text("**Auxiliares:** \(auxSurgeonsDisplay)")
                    .font(.system(size: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                 }
                }
                Text("**\(procLabel):** \(procValue)")
                    .font(.system(size: 9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
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
