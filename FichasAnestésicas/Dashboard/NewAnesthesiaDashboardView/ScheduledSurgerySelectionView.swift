//
//  ScheduledSurgerySelectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 06/01/26.
//

import SwiftUI
import SwiftData
// MARK: - Scheduled Surgery Selection View

struct ScheduledSurgerySelectionView: View {
    let surgeries: [Surgery]
    let onSelectSurgery: (Surgery) -> Void
    let onCreateNew: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header explicativo
            VStack(spacing: 8) {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: 40))
                    .foregroundStyle(.blue)
                
                Text("Cirurgias Agendadas")
                    .font(.headline)
                
                Text("Selecione uma cirurgia agendada ou crie uma nova")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
            
            // Lista de cirurgias agendadas
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(surgeries, id: \.surgeryId) { surgery in
                        ScheduledSurgeryCard(
                            surgery: surgery,
                            onSelect: { onSelectSurgery(surgery) }
                        )
                    }
                    .glassEffect(in: .rect(cornerRadius: 16.0))
                }
                
                .padding()
            }
            //.background(.black)
            
            // Botão criar nova (fixo no rodapé)
            VStack(spacing: 0) {
                Divider()
                
                Button {
                    onCreateNew()
                } label: {
                    Label("Criar Nova Cirurgia", systemImage: "plus.circle.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color(.systemBackground))
            }
        }
    }
}

// MARK: - Scheduled Surgery Card

struct ScheduledSurgeryCard: View {
    let surgery: Surgery
    let onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Informações da cirurgia
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text(surgery.proposedProcedure)
                        .font(.title3)
                        .bold()
                        .lineLimit(2)
                    Spacer()
                    Text(surgery.surgeryId)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                Divider()
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.blue)
                        .font(.title3)
                    Text(surgery.date, style: .date)
                        .font(.headline.weight(.semibold))
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "person")
                    Text(surgery.mainSurgeon)
                        .font(.headline)
                }
                .padding(.bottom, 10)
            }
            
            // Botão selecionar
            Button {
                onSelect()
            } label: {
                Text("Selecionar Cirurgia")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

#Preview("Card"){
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)

    let session = SessionManager()
    session.currentUser = user
    let surgery = surgeries[0]
    
    return ScheduledSurgeryCard(
        surgery: surgery,
        onSelect: {
            print("Surgery selecionada: \(surgery.surgeryId)")
        }
    )
    .padding()
}

#Preview("Selection View") {
    let user = User.sampleUser
    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    
    let session = SessionManager()
    session.currentUser = user
    
    // Filtra apenas as scheduled (ou usa as primeiras 3 do sample)
    let scheduledSurgeries = Array(surgeries.prefix(1))
    
    return ScheduledSurgerySelectionView(
        surgeries: scheduledSurgeries,
        onSelectSurgery: { surgery in
            print("✅ Selecionada: \(surgery.surgeryId)")
        },
        onCreateNew: {
            print("➕ Criar nova cirurgia")
        }
    )
}
