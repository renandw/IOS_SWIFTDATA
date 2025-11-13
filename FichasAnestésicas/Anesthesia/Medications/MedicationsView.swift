//
//  MedicationsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//

import SwiftUI

struct MedicationsView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    @State private var showingForm = false
    @State private var selectedMedication: MedicationEntry? = nil
    
    
    var body: some View {
        ScrollView {
            let grouped = Dictionary(grouping: anesthesia.medications) { $0.via.label }
            ForEach(grouped.keys.sorted(), id: \.self) { viaLabel in
                VStack(alignment: .leading, spacing: 8) {
                    // Group header
                    Text(viaLabel)
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 8)
                        //.glassEffect(.regular.interactive())
                    
                    // Items within the group, sorted by timestamp ascending
                    ForEach(grouped[viaLabel]!.sorted(by: { $0.timestamp < $1.timestamp }), id: \.medicationId) { medication in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(medication.name)
                                            .font(.headline)
                                        Text("\(medication.dose)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    Text("\(medication.category.label)")
                                        .font(.footnote)
                                        .foregroundStyle(.tertiary)
                                }
                                    
                                    Spacer()
                                VStack {
                                    Text(medication.timestamp.formatted(date: .omitted, time: .shortened))
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }

                        }
                        .padding()
                        .onTapGesture {
                            selectedMedication = medication
                            showingForm = true
                        }
                        .glassEffect(.regular.interactive())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .sheet(item: $selectedMedication, onDismiss: {
            selectedMedication = nil
        }) { medication in
            if let currentUser = session.currentUser {
                let viewModel = MedicationsFormViewModel(
                    anesthesia: anesthesia,
                    user: currentUser,
                    context: modelContext,
                    entry: medication
                )
                MedicationsFormView(
                    viewModel: viewModel,
                    catalog: MedicationsHelper.allMedications
                )
            }
        }
        .preference(
            key: CustomTopBarButtonPreferenceKey.self,
            value: CustomTopBarButtonPreference(
                id: "MedicationsView.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "MedicationsView.topbar.buttons.v\(anesthesia.medications.count)"
            )
        )
    }
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            Text("\(anesthesia.medications.count)")
                .padding(.horizontal)
                .glassEffect(.regular.interactive())
            
            Button(action: {
                if let currentUser = session.currentUser {
                    let repo = SwiftDataMedicationEntryRepository(context: modelContext)
                    try? repo.deleteAll(for: anesthesia, by: currentUser)
                } else {
                    anesthesia.medications.removeAll()
                }
            }) {
                Image(systemName: "trash")
            }
            .accessibilityLabel("Editar Paciente")
            .buttonStyle(.glass)
            .tint(.red)
            
            Button(action: {
                showingForm = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Adicionar Medicações")
            .buttonStyle(.glass)
            .tint(.blue)
        }
    }
}

