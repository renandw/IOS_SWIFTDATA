//
//  AnesthesiaSheetFooterView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI

struct AnesthesiaSheetFooterView: View {
    let anesthesia: Anesthesia
    
    
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
                    .foregroundColor(.secondary)
                Spacer()
                Text("Responsável: \(responsavelName) - CRM \(responsavelCRM) - RQE \(responsavelRQE)")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            // .overlay(alignment: .topTrailing) {
            //     AssinaturaGovBRView(data: data)
            //         .offset(y: -60)
            // }
        }
    }
}
