//
//  SpecialInfoView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//
import SwiftUI

struct SpecialInfoView: View {
    let anesthesia: Anesthesia

    var body: some View {

        // Flags
        let isPregnant = anesthesia.surgery.preanesthesia?.isPregnant ?? false
        let isInfant = anesthesia.surgery.preanesthesia?.isInfant ?? false
        let hasSpecialInfo = isPregnant || isInfant
        if !hasSpecialInfo {
            return AnyView(EmptyView())
        }
        
        let age = AgeContext.inSurgery(anesthesia.surgery).ageString(from: anesthesia.surgery.patient.birthDate)

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)
                    Text("INFORMAÇÕES ESPECIAIS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.secondary)
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
                VStack(alignment: .leading, spacing: 4) {
                    if isPregnant {
                        HStack {
                            Text("Gestante:")
                                .bold()
                                .font(.system(size: 10))
                            if let pregnantAge = anesthesia.surgery.preanesthesia?.isPregnantAge {
                                Text(pregnantAge)
                                    .font(.system(size: 9))
                            }
                            NotesComorbiditiesRow(
                                title: "",
                                details: anesthesia.surgery.preanesthesia?.pregnancyDetails ?? [],
                                name: { $0.displayName() },
                                notes: { $0.notes }
                            )
                            
                        }
                            //Spacer()
                        
                    }
                    if isInfant {
                        HStack(alignment: .top) {
                            Text("**Lactente:** \(age)")
                                .font(.system(size: 10))
            
                            NotesComorbiditiesRow(
                                title: "",
                                details: anesthesia.surgery.preanesthesia?.infantDetails ?? [],
                                name: { $0.displayName() },
                                notes: { $0.notes }
                            )
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
            //.cornerRadius(4, corners: [.bottomLeft, .bottomRight])
        )
    }
}
