//
//  ComorbiditiesView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/12/25.
//
import SwiftUI

struct ComorbiditiesView: View {
    let anesthesia: Anesthesia

    private func hasComorbidities() -> Bool {
        return !(anesthesia.surgery.preanesthesia?.healthyPatient ?? false)
    }

    var body: some View {

        let hasAny = hasComorbidities()

        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)

                    Text("COMORBIDADES")
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

                Group {
                    if hasAny {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), alignment: .topLeading),
                            GridItem(.flexible(), alignment: .topLeading)
                        ], spacing: 2) {
                            if anesthesia.surgery.preanesthesia?.cardiacComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Cardiológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.cardiacComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.cardiacComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.cardiacComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.respiratoryComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Respiratório:",
                                    enumItems: anesthesia.surgery.preanesthesia?.respiratoryComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.respiratoryComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.respiratoryComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.endocrineComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Endócrino:",
                                    enumItems: anesthesia.surgery.preanesthesia?.endocrineComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.endocrineComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.endocrineComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.hematologicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Hematológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.hematologicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.hematologicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.hematologicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.gastrointestinalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Gastrointestinal:",
                                    enumItems: anesthesia.surgery.preanesthesia?.gastrointestinalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.gastrointestinalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.gastrointestinalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.imunologicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Imunológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.imunologicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.imunologicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.imunologicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.musculoskeletalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Músculo Esquelético:",
                                    enumItems: anesthesia.surgery.preanesthesia?.musculoskeletalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.musculoskeletalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.musculoskeletalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.genitourologicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Genitourinário:",
                                    enumItems: anesthesia.surgery.preanesthesia?.genitourologicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.genitourologicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.genitourologicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.gynecologicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Ginecológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.gynecologicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.gynecologicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.gynecologicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.androgenicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Andrológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.androgenicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.androgenicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.androgenicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.infectiousComorbities == true {
                                ComorbiditiesRow(
                                    title: "Infeccioso:",
                                    enumItems: anesthesia.surgery.preanesthesia?.infectiousComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.infectiousComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.infectiousComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.oncologicComorbities == true {
                                NewComorbiditiesRow(
                                    title: "Oncológicas:",
                                    details: anesthesia.surgery.preanesthesia?.oncologyDetails ?? []
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.neurologicalComorbities == true {
                                ComorbiditiesRow(
                                    title: "Sistema Neurológico:",
                                    enumItems: anesthesia.surgery.preanesthesia?.neurologicalComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.neurologicalComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.neurologicalComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.geneticSyndrome == true {
                                ComorbiditiesRow(
                                    title: "Sindromes Genéticas:",
                                    enumItems: anesthesia.surgery.preanesthesia?.geneticSyndromeComorbitiesDetails,
                                    customItems: anesthesia.surgery.preanesthesia?.geneticSyndromeComorbitiesCustomDetails ?? [],
                                    detailsText: anesthesia.surgery.preanesthesia?.geneticSyndromeComorbitiesDetailsText,
                                    displayName: { $0.displayName }
                                )
                            }
                        }
                    } else {
                        Text("Paciente nega diagnóstico prévio de alguma comorbidade")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                            .frame(maxWidth: .infinity, alignment: .leading)
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

struct ComorbiditiesRow<T>: View {
    let title: String
    let enumItems: [T]?
    let customItems: [String]
    let detailsText: String?
    let displayName: (T) -> String
    
    var body: some View {
        let items = buildItems()
        
        if !items.isEmpty || detailsText != nil {
            VStack(alignment: .leading, spacing: 4) {
                if !items.isEmpty {
                    Text("**\(title)** \(items.joined(separator: ", "))")
                        .foregroundColor(.black)
                        .font(.system(size: 9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if let details = detailsText, !details.isEmpty {
                    HStack(alignment: .top) {
                        Text("Detalhes:")
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                        Text(details)
                            .foregroundColor(.black)
                            .font(.system(size: 9))
                    }
                }
            }
        }
    }
    
    private func buildItems() -> [String] {
        var items: [String] = []
        
        if let enumItems = enumItems {
            items = enumItems.map { displayName($0) }
        }
        
        items.append(contentsOf: customItems)
        
        return items
    }
}


struct NewComorbiditiesRow: View {
    let title: String
    let details: [OncologyComorbidityDetail]
    
    var body: some View {
        if !details.isEmpty {
            Text("**\(title)** \(formattedText)")
                .foregroundColor(.black)
                .font(.system(size: 9))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var formattedText: String {
        details.map { detail in
            let name = detail.displayName()
            if let notes = detail.notes, !notes.isEmpty {
                return "\(name) (\(notes))"
            }
            return name
        }.joined(separator: "; ")
    }
}
