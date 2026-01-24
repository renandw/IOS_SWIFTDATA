//
//  AnesthesiaHeaderView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaHeaderView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct SRPAHeaderView: View {
    let srpa: SRPA
    
    var body: some View {
        
        let hospital = srpa.surgery.hospital
        let code = srpa.surgery.surgeryId
        let doctor = srpa.surgery.createdBy.name
        let doctorCRM = srpa.surgery.createdBy.crm
        let doctorRQE = srpa.surgery.createdBy.rqe ?? ""
        let date = srpa.surgery.date.formatted(date: .numeric, time: .omitted)
        let start = srpa.start?.formatted(date: .omitted, time: .shortened) ?? "-"
        let end = srpa.end?.formatted(date: .omitted, time: .shortened) ?? "-"
        
        
        VStack(spacing: 8) {
            HStack {
                Text("FICHA RECUPERAÇÃO ANESTÉSICA")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                Spacer()

                Text("**Data:** \(date)")
                    .font(.system(size: 10))
                
                Spacer()

                Text("**Período:** \(start) → \(end)")
                    .font(.system(size: 10))
                
                Spacer()
            
                Text(code)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.blue.opacity(0.3), lineWidth: 1))
            }
            HStack {
                Text("**Hospital:** \(hospital)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Spacer()
                Text("**Responsável:** \(doctor) - CRM \(doctorCRM) - RQE \(doctorRQE)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
        }
        .padding(.bottom, 4)
        .overlay(Rectangle().frame(height: 2).foregroundColor(.blue).padding(.top, 40), alignment: .bottom)
    }
}
