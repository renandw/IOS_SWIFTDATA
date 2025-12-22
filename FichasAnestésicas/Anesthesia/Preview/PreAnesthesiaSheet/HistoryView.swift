//
//  HistoryView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct HistoryView: View {
    let anesthesia: Anesthesia

    var body: some View {
        
        // Decide if this section should render
        let hasSurgeryHistory = anesthesia.surgery.preanesthesia?.surgeryHistory ?? false
        let hasAnesthesic = anesthesia.surgery.preanesthesia?.anesthesiaHistory ?? false
        let hasAnesthesicDetails = !(anesthesia.surgery.preanesthesia?.anesthesiaHistoryDetails?.isEmpty ?? true)
        let hasAnesthesicCustomComplications = !((anesthesia.surgery.preanesthesia?.anesthesiaHistoryCustomDetails ?? []).isEmpty)
        let hasAnesthesicTextComplications = !((anesthesia.surgery.preanesthesia?.anesthesiaHistoryDetailsText?.isEmpty ?? true))
        let hasAnesthesicComplications = hasAnesthesicDetails || hasAnesthesicCustomComplications || hasAnesthesicTextComplications
        
        if !hasSurgeryHistory {
            return AnyView(EmptyView())
        }

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("HISTÓRICO CIRÚRGICO/ANESTÉSICO")
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
                    if hasSurgeryHistory == false {
                        Text("Nega cirurgias prévias")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("Cirurgias Prévias:")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .fontWeight(.semibold)
                                                        
                        VStack(alignment: .leading, spacing: 2) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 2) {
                                    
                                    let defaultDetails = (anesthesia.surgery.preanesthesia?.surgeryHistoryDetails ?? []).map { $0.displayName }
                                    let customDetails = (anesthesia.surgery.preanesthesia?.surgeryHistoryCustomDetails ?? [])
                                    let allDetails = defaultDetails + customDetails
                                    
                                    if !allDetails.isEmpty {
                                        Text(allDetails.joined(separator: " • "))
                                            .foregroundColor(.black)
                                            .font(.system(size: 9))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                HStack(alignment: .top, spacing: 2) {
                                    if let surgeryHistoryDetailsText = anesthesia.surgery.preanesthesia?.surgeryHistoryDetailsText, !surgeryHistoryDetailsText.isEmpty {
                                        Text("Detalhes:")
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 9))
                                        Text(surgeryHistoryDetailsText)
                                            .font(.system(size: 9))
                                    }
                                }
                                .padding(.bottom, 2)
                            }
                            
                        }
                    }

                    if hasAnesthesic == true && !hasAnesthesicComplications {
                        Text("Nega complicações anestésicas prévias")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else if hasAnesthesic == true && hasAnesthesicComplications {
                        let defaultDetails = (anesthesia.surgery.preanesthesia?.anesthesiaHistoryDetails ?? []).map { $0.displayName }
                        let customDetails = (anesthesia.surgery.preanesthesia?.anesthesiaHistoryCustomDetails ?? [])
                        let allDetails = defaultDetails + customDetails
                        
                        if !allDetails.isEmpty {
                            Text(allDetails.joined(separator: " • "))
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            HStack(alignment: .top) {
                                if let anesthesiaHistoryDetailsText = anesthesia.surgery.preanesthesia?.anesthesiaHistoryDetailsText, !anesthesiaHistoryDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 9))
                                    Text(anesthesiaHistoryDetailsText)
                                        .foregroundColor(.black)
                                        .font(.system(size: 9))
                                }
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
