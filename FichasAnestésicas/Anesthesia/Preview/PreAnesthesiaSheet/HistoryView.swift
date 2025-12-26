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
        let hasSurgeryHistory = anesthesia.surgery.preanesthesia?.surgeryHistory ?? false
        let hasAnesthesic = anesthesia.surgery.preanesthesia?.anesthesiaHistory ?? false
        let hasAnesthesicDetails = !(anesthesia.surgery.preanesthesia?.anesthesiaHistoricDetails?.isEmpty ?? true)
        
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
                    // Cirurgias
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
                        
                        if let details = anesthesia.surgery.preanesthesia?.surgeryHistoricDetails, !details.isEmpty {
                            Text(formatDetails(details))
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    // Anestesias
                    if hasAnesthesic == true && !hasAnesthesicDetails {
                        Text("Nega complicações anestésicas prévias")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else if hasAnesthesic == true && hasAnesthesicDetails {
                        if let details = anesthesia.surgery.preanesthesia?.anesthesiaHistoricDetails, !details.isEmpty {
                            Text(formatDetails(details))
                                .foregroundColor(.black)
                                .font(.system(size: 9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
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
    
    private func formatDetails<T: ComorbidityDetailProtocol>(_ details: [T]) -> String {
        details.map { detail in
            let name = detail.displayName()
            if let notes = detail.notes, !notes.isEmpty {
                return "\(name) (\(notes))"
            }
            return name
        }.joined(separator: " • ")
    }
}
