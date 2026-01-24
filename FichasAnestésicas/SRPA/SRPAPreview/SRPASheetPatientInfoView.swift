//
//  AnesthesiaSheetPatientInfoView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//
import SwiftUI

struct SRPASheetPatientInfoView: View {
    let srpa: SRPA
    
    var body: some View {
        // Compute fields
        let name = srpa.surgery.patient.name
        let age = AgeContext.inSurgery(srpa.surgery).ageString(from: srpa.surgery.patient.birthDate)
        let sex = srpa.surgery.patient.sex.sexStringDescription
        let weight = "\(srpa.surgery.weight) kg"
        let isSUS = srpa.surgery.type == .sus || srpa.surgery.insuranceName.lowercased().contains("sus")
        let label1 = isSUS ? "CNS" : "Convênio"
        let value1 = isSUS ? srpa.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true) : srpa.surgery.insuranceName
        let label2 = isSUS ? "Prontuário" : "Carteirinha"
        let value2 = isSUS ? srpa.surgery.insuranceNumber : srpa.surgery.insuranceNumber
        VStack(spacing: 0) {
            // Title
            HStack {
                Text("IDENTIFICAÇÃO DO PACIENTE")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                Spacer()
            }
            .background(Color.blue)
            //.cornerRadius(4, corners: [.topLeft, .topRight])
            // Content
            VStack(alignment: .leading, spacing: 4) {
                // First row: Name (flex), Sexo, Data, Idade (intrinsic)
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("**Paciente:** \(name)")
                            .font(.system(size: 10))
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.black)
                    }
                    .layoutPriority(1)

                    Spacer()

                    Text("**Sexo:** \(sex)")
                        .font(.system(size: 10))
                        .foregroundColor(.black)

                    Spacer()

                    Text("**Idade:** \(age)")
                        .font(.system(size: 10))
                        .foregroundColor(.black)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                // Second row: Peso, Identificações (CNS/Convênio e Prontuário/Carteirinha) e Período — com gaps via Spacer
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("**Peso:** \(weight)")
                        .font(.system(size: 10))
                        .frame(width: 80, alignment: .leading)
                        .foregroundColor(.black)

                    Spacer()

                    VStack(alignment: .leading, spacing: 2) {
                        Text("**\(label1):** \(value1)")
                            .font(.system(size: 10))
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.black)
                    }
                    .layoutPriority(1)

                    Spacer()

                    VStack(alignment: .leading, spacing: 2) {
                        Text("**\(label2):** \(value2)")
                            .font(.system(size: 10))
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.05))
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .fixedSize(horizontal: false, vertical: true)
        //.cornerRadius(4, corners: [.bottomLeft, .bottomRight])
    }
}
