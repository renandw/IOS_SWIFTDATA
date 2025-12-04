//
//  PreAnestheticFooterView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct PreAnestheticFooterView: View {
    let anesthesia: Anesthesia
    
    var body: some View {

        return AnyView(
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.bottom, 8)
                HStack {
                    Text("Realizada em \(anesthesia.surgery.preanesthesia?.createdAt.formatted(date: .numeric, time: .omitted) ?? "--")")
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("**Responsável:** \(anesthesia.surgery.createdBy.name) - CRM \(anesthesia.surgery.createdBy.crm) - RQE \(anesthesia.surgery.createdBy.rqe ?? "")")
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                }
            }
            // .overlay(alignment: .topTrailing) {
            //     AssinaturaGovBRViewPre(dto: dto)
            // .offset(y: -60)
            // }
        )
    }

}
