//
//  PreAnestheticPatientInfoView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//
import SwiftUI

struct PreAnestheticPatientInfoView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        // Precompute lightweight values to simplify the view tree
        let patientName = anesthesia.surgery.patient.name
        let surgeryDateText = anesthesia.surgery.date.formatted(date:.numeric, time: .omitted)
        let age = AgeContext.inSurgery(anesthesia.surgery).ageString(from: anesthesia.surgery.patient.birthDate)
        let sex = anesthesia.surgery.patient.sex.sexStringDescription
        let weight = "\(anesthesia.surgery.weight) kg"
        let isSUS = anesthesia.surgery.type == .sus
        let procedureText = anesthesia.surgery.proposedProcedure
        let mainSurgeonText = anesthesia.surgery.mainSurgeon
        let cnsText = anesthesia.surgery.patient.cns
        let hospitalRecordText = anesthesia.surgery.insuranceNumber
        let insuranceNameText = anesthesia.surgery.insuranceName
        let insuranceNumberText = anesthesia.surgery.insuranceNumber
        
        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Text("IDENTIFICAÇÃO DO PACIENTE")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                    Spacer()
                }
                .background(Color.blue)
                //.cornerRadius(4, corners: [.topLeft, .topRight])
                
                VStack(spacing: 8) {
                    // First row: Name, Date, Age
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("**Paciente:** \(patientName)")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .layoutPriority(1)

                        Spacer()

                        Text("**Idade:** \(age)")
                            .foregroundColor(.black)
                            .font(.system(size: 9))

                        Spacer()

                        Text("**Sexo:** \(sex)")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .frame(width: 80, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Second row: Peso + Identificação, com gaps por Spacer (intrínsecos)
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("**Data:** \(surgeryDateText)")
                            .foregroundColor(.black)
                            .font(.system(size: 9))

                        Spacer()
                        
                        Text("**Peso:** \(weight)")
                            .foregroundColor(.black)
                            .font(.system(size: 9))

                        Spacer()

                        if isSUS {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("**CNS:** \(cnsText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .layoutPriority(1)

                            Spacer()

                            VStack(alignment: .leading, spacing: 2) {
                                Text("**Registro:** \(hospitalRecordText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("**Convênio:** \(insuranceNameText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .layoutPriority(1)

                            Spacer()

                            VStack(alignment: .leading, spacing: 2) {
                                Text("**Carteirinha:** \(insuranceNumberText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    
                    // Procedure info
                    HStack {
                        if anesthesia.surgery.type == .convenio {
                            Text("**Procedimento:** \(procedureText)")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                            
                            Spacer()
                            
                            Text("**Cirurgião Principal:** \(mainSurgeonText)")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                        } else {
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("**Procedimento:** \(procedureText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                Spacer()
                                Text("**Cirurgião Principal:** \(mainSurgeonText)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .cornerRadius(4)
        )
    }
}
