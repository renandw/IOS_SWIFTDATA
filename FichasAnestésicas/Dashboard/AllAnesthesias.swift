//
//  AllAnesthesias.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/11/25.
//

import SwiftUI

struct AllAnesthesias: View {
    @State private var searchText: String = ""
    let anesthesias: [Anesthesia]
    
    var allAnesthesias: [Anesthesia] {
        let base = anesthesias
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }
        // Ajuste os campos abaixo conforme seu modelo `Anesthesia`
        return base.filter { anesthesia in
            // Exemplo: filtrando por nome do paciente ou outros campos
            let haystack = [
                // Substitua/adicione campos reais do seu modelo aqui
                anesthesia.surgery.patient.name,
                anesthesia.surgery.proposedProcedure,
                anesthesia.surgery.mainSurgeon,
            ]
            .compactMap { $0?.lowercased() }
            .joined(separator: " ")
            return haystack.contains(trimmed.lowercased())
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if allAnesthesias.isEmpty {
                    ContentUnavailableView(
                        "Nenhuma ficha anestésica",
                        systemImage: "doc.text",
                        description: Text("As fichas anestésicas criadas aparecerão aqui")
                    )
                    .frame(height: 200)
                } else {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(allAnesthesias) { anesthesia in
                            RecentAnesthesiaCard(anesthesia: anesthesia)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .navigationTitle("Todas Anestesias")
            .navigationBarTitleDisplayMode(.automatic)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Buscar anestesias")
        }
        
    }
}

