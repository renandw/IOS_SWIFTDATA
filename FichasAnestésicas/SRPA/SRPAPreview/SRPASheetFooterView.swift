//
//  AnesthesiaSheetFooterView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaSheetFooterView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI

struct SRPASheetFooterView: View {
    let srpa: SRPA
    @Environment(\.showSignature) var showSignature
    
    var body: some View {
        let finishedDate = (srpa.end ?? Date()).formatted(date: .numeric, time: .omitted)
        let finishedTime = (srpa.end ?? Date()).formatted(date: .omitted, time: .shortened)

        let responsavelName = srpa.surgery.createdBy.name
        let responsavelCRM  = srpa.surgery.createdBy.crm
        let responsavelRQE  = srpa.surgery.createdBy.rqe ?? ""
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
                    AssinaturaGovBRView(nome: responsavelName, data: srpa.end ?? Date())
                        .offset(y: -75)
                        .scaleEffect(0.55)
                }
            }
        }
    }
}

