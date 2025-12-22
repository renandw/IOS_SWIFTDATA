//
//  AnesthesiaHeaderView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct AnesthesiaHeaderView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        
        let hospital = anesthesia.surgery.hospital
        let code = anesthesia.surgery.surgeryId
        let doctor = anesthesia.surgery.createdBy.name
        let doctorCRM = anesthesia.surgery.createdBy.crm
        let doctorRQE = anesthesia.surgery.createdBy.rqe ?? ""
        let date = anesthesia.surgery.date.formatted(date: .numeric, time: .omitted)
        let start = anesthesia.start?.formatted(date: .omitted, time: .shortened) ?? "-"
        let end = anesthesia.end?.formatted(date: .omitted, time: .shortened) ?? "-"
        
        
        VStack(spacing: 8) {
            HStack {
                Text("FICHA ANESTÉSICA")
                    .font(.system(size: 16, weight: .bold))
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
