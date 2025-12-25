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
                                NotesComorbiditiesRow(
                                    title: "Cardiológicas:",
                                    details: anesthesia.surgery.preanesthesia?.cardiologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }

                            if anesthesia.surgery.preanesthesia?.respiratoryComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Respiratórias:",
                                    details: anesthesia.surgery.preanesthesia?.respiratoryDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }

                            if anesthesia.surgery.preanesthesia?.endocrineComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Endócrinas:",
                                    details: anesthesia.surgery.preanesthesia?.endocrineDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }

                            if anesthesia.surgery.preanesthesia?.oncologicComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Oncológicas:",
                                    details: anesthesia.surgery.preanesthesia?.oncologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.gastrointestinalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Gastrointestinais:",
                                    details: anesthesia.surgery.preanesthesia?.gastroIntestinalDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.hematologicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Hematológico:",
                                    details: anesthesia.surgery.preanesthesia?.hematologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.imunologicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Hematológico:",
                                    details: anesthesia.surgery.preanesthesia?.imunologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.musculoskeletalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Músculo-Esquelético:",
                                    details: anesthesia.surgery.preanesthesia?.musculoskeletalDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.genitourologicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Genitourinário:",
                                    details: anesthesia.surgery.preanesthesia?.genitoUrinaryDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.gynecologicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Ginecológico:",
                                    details: anesthesia.surgery.preanesthesia?.gynecologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.androgenicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Andrológico:",
                                    details: anesthesia.surgery.preanesthesia?.androgenyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.infectiousComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Infeccioso:",
                                    details: anesthesia.surgery.preanesthesia?.infectiousDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.neurologicalComorbities == true {
                                NotesComorbiditiesRow(
                                    title: "Sistema Neurológico:",
                                    details: anesthesia.surgery.preanesthesia?.neurologyDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
                                )
                            }
                            if anesthesia.surgery.preanesthesia?.geneticSyndrome == true {
                                NotesComorbiditiesRow(
                                    title: "Síndromes Genéticas:",
                                    details: anesthesia.surgery.preanesthesia?.geneticSyndromeDetails ?? [],
                                    name: { $0.displayName() },
                                    notes: { $0.notes }
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


struct NotesComorbiditiesRow<D>: View {
    let title: String
    let details: [D]
    let name: (D) -> String
    let notes: (D) -> String?

    var body: some View {
        if !details.isEmpty {
            Text("**\(title)** \(formattedText)")
                .foregroundColor(.black)
                .font(.system(size: 9))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var formattedText: String {
        details.map { d in
            let n = name(d)
            if let no = notes(d), !no.isEmpty {
                return "\(n) (\(no))"
            }
            return n
        }
        .joined(separator: "; ")
    }
}
