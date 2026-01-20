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
    
    @State private var randomizedDate: Date?

    var body: some View {
        let baseDate = anesthesia.end ?? Date()

        let finalDate: Date = {
            if let existing = randomizedDate {
                return existing
            } else {
                let randomMinutes = Int.random(in: 0...10)
                let newDate = Calendar.current.date(byAdding: .minute, value: randomMinutes, to: baseDate) ?? baseDate
                DispatchQueue.main.async {
                    self.randomizedDate = newDate
                }
                return newDate
            }
        }()

        let finishedDate = finalDate.formatted(date: .numeric, time: .omitted)
        let finishedTime = finalDate.formatted(date: .omitted, time: .shortened)

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
                    AssinaturaGovBRView(nome: anesthesia.surgery.createdBy.name, data: finalDate)
                        .offset(y: -75)
                        .scaleEffect(0.55)
                }
            }
        }
    }
}

