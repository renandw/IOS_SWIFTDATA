//
//  PreAnestheticHeaderView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//

import SwiftUI

struct PreAnestheticHeaderView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("AVALIAÇÃO PRÉ-ANESTÉSICA")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(anesthesia.surgery.surgeryId)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                    )
            }
            
            HStack {
                Text("**Hospital:** \(anesthesia.surgery.hospital)")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("**Responsável:** \(anesthesia.surgery.createdBy.name) - CRM \(anesthesia.surgery.createdBy.crm) - RQE \(anesthesia.surgery.createdBy.rqe ?? "")")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.bottom, 2)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.blue)
                .padding(.top, 40),
            alignment: .bottom
        )
    }
}
