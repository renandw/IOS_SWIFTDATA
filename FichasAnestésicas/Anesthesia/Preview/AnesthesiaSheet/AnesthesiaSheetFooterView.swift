//
//  AnesthesiaSheetFooterView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI

struct AnesthesiaSheetFooterView: View {
    let anesthesia: Anesthesia
    @Environment(\.showSignature) var showSignature
    
    var body: some View {
        let finishedDate = (anesthesia.end ?? Date()).formatted(date: .numeric, time: .omitted)
        let finishedTime = (anesthesia.end ?? Date()).formatted(date: .omitted, time: .shortened)

        let responsavelName = anesthesia.surgery.createdBy.name
        let responsavelCRM  = anesthesia.surgery.createdBy.crm
        let responsavelRQE  = anesthesia.surgery.createdBy.rqe ?? ""
        VStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.bottom, 8)
            HStack {
                Text("Ficha finalizada em \(finishedTime) \(finishedDate)")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                Spacer()
                Text("Responsável: \(responsavelName) - CRM \(responsavelCRM) - RQE \(responsavelRQE)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .overlay(alignment: .topTrailing) {
                if showSignature.wrappedValue {
                    AssinaturaGovBRView(nome: anesthesia.surgery.createdBy.name, data: anesthesia.end ?? Date())
                        .offset(y: -75)
                        .scaleEffect(0.55)
                }
            }
        }
    }
}

