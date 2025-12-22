//
//  MedicationsAllergiesView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct MedicationsAllergiesView: View {
    let anesthesia: Anesthesia
    
    var body: some View {


        let hasAllergies = (anesthesia.surgery.preanesthesia?.hasAllergies ?? false)
        let allergiesMedications = (anesthesia.surgery.preanesthesia?.allergiesMedicationsCustomDetails ?? [])
        let hasCustomAllergiesDetails = !((anesthesia.surgery.preanesthesia?.allergiesMedicationsCustomDetails ?? []).isEmpty)
        
        let dailyMedications = (anesthesia.surgery.preanesthesia?.dailyMedicationsCustomDetails ?? [])
        let hasCustomMedicationDetails = !((anesthesia.surgery.preanesthesia?.dailyMedicationsCustomDetails ?? []).isEmpty)

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("MEDICAMENTOS E ALERGIAS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)

                    Spacer()
                }
                .background(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(topLeading: 4, topTrailing: 4)
                    )
                    .fill(Color.gray.opacity(0.2))
                )

                VStack(alignment: .leading, spacing: 2) {
                    if !(hasAllergies) {
                        Text("Sem história de alergias")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else if hasCustomAllergiesDetails && hasAllergies {
                        HStack {
                            Text("Alergias à:")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                            let customDetails = (allergiesMedications)
                            if !customDetails.isEmpty {
                                Text(customDetails.joined(separator: " • "))
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                            }
                        }
                    }
                    
                    if !hasCustomMedicationDetails {
                        Text("Não faz uso de medicações")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        VStack(alignment: .leading) {
                            Text("Medicamentos em uso:")
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .fontWeight(.semibold)
                            let customDetails = (dailyMedications)
                            if !customDetails.isEmpty {
                                Text(customDetails.joined(separator: " • "))
                                    .foregroundColor(.black)
                                    .font(.system(size: 9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                            }
                        }
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .fixedSize(horizontal: false, vertical: true)
        )
    }
}
