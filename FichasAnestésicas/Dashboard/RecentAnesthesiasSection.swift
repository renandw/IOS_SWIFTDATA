//
//  RecentAnesthesiasSection.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 14/11/25.
//
import SwiftData
import SwiftUI

// MARK: - Recent Anesthesias Section
struct RecentAnesthesiasSection: View {
    let anesthesias: [Anesthesia]
    
    var recentAnesthesias: [Anesthesia] {
        Array(anesthesias.prefix(10))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Anestesias Recentes")
                .font(.title3)
                .fontWeight(.semibold)
            
            if recentAnesthesias.isEmpty {
                ContentUnavailableView(
                    "Nenhuma ficha anestésica",
                    systemImage: "doc.text",
                    description: Text("As fichas anestésicas criadas aparecerão aqui")
                )
                .frame(height: 200)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(recentAnesthesias) { anesthesia in
                        RecentAnesthesiaCard(anesthesia: anesthesia)
                    }
                }
            }
        }
        .padding(.vertical, 12)
    }
}

struct RecentAnesthesiaCard: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        NavigationLink(destination: AnesthesiaDetailsView(anesthesia: anesthesia)) {
            VStack(alignment:.leading, spacing: 8) {
                HStack(spacing: 12) {
                    VStack(alignment: .leading) {
                        Text(anesthesia.surgery.patient.name)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    anesthesia.status?.badgeView
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text(anesthesia.surgery.proposedProcedure)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Text(anesthesia.surgery.surgeryId)
                    Text("•")
                    Text(anesthesia.surgery.insuranceName)
                    Text("•")
                    if let start = anesthesia.start {
                        Text(start.formatted(date: .numeric, time: .shortened))
                    }
                }
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                
                Divider()
                
                HStack {
                    Button("Ficha Anestésica", systemImage: "square.and.arrow.up.fill") {
                        //todo - compartilhar ficha anestésica
                    }
                    .font(.caption)
                    .buttonStyle(.glass)
                    .tint(.blue)

                    Spacer()

                    Button("Ficha APA", systemImage: "square.and.arrow.up.fill") {
                        //todo - compartilhar ficha anestésica
                    }
                    .font(.caption)
                    .buttonStyle(.glass)
                    .tint(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .glassEffect(in: .rect(cornerRadius: 16.0))
        }
        .buttonStyle(.plain)
    }
}

