//
//  AllSurgeries.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 13/01/26.
//

import SwiftUI

struct AllSurgeries: View {
    @State private var searchText: String = ""
    let surgeries: [Surgery]
    
    var allSurgeries: [Surgery] {
        let base = surgeries
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }
        
        return base.filter { surgery in
            
            let haystack = [
                
                surgery.patient.name,
                surgery.proposedProcedure,
                surgery.mainSurgeon,
                surgery.surgeryId,
            ]
            .compactMap { $0?.lowercased() }
            .joined(separator: " ")
            return haystack.contains(trimmed.lowercased())
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if allSurgeries.isEmpty {
                    ContentUnavailableView(
                        "Nenhuma Cirurgia",
                        systemImage: "doc.text",
                        description: Text("As cirurgias criadas aparecerão aqui")
                    )
                    .frame(height: 200)
                } else {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(allSurgeries) { surgery in
                            RecentSurgeryCard(surgery: surgery)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .searchable(text: $searchText, placement: .toolbar, prompt: "Buscar pacientes, procedimentos, cirurgiões")
            .navigationTitle("Todas Cirurgias")
            .navigationBarTitleDisplayMode(.automatic)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Buscar cirurgias")
        }
        
    }
}

