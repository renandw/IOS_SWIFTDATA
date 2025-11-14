//
//  MedicationsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//

import SwiftUI

enum MedicationSheet: Identifiable {
    case create
    case edit(MedicationEntry)

    var id: String {
        switch self {
        case .create:
            return "create"
        case .edit(let entry):
            return entry.medicationId
        }
    }
}

struct MedicationsView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    @State private var sheetState: MedicationSheet? = nil
    
    
    var body: some View {
        Group {
            if anesthesia.medications.isEmpty {
                ContentUnavailableView(
                    "Sem medicações",
                    systemImage: "pills",
                    description: Text("Adicione as medicações administradas durante a anestesia.")
                )
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            sheetState = .create
                        }) {
                            Label("Adicionar Medicação", systemImage: "plus")
                        }
                        .buttonStyle(.glass)
                        .tint(.blue)
                        .padding()
                    }
                )
            } else {
                ScrollView {
                    let grouped = Dictionary(grouping: anesthesia.medications) { $0.via.label }
                    ForEach(grouped.keys.sorted(), id: \.self) { viaLabel in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viaLabel)
                                .font(.title3)
                                .bold()
                                .padding(.horizontal)
                                .padding(.top, 8)
                            ForEach(grouped[viaLabel]!.sorted(by: { $0.timestamp < $1.timestamp }), id: \.medicationId) { medication in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(alignment: .center) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(medication.name)
                                                    .font(.headline)
                                                Text("\(medication.dose)")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.primary)
                                            }
                                            Text("\(medication.category.label)")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "clock.fill")
                                                .foregroundStyle(Color(medication.category.medicationColor))
                                            Text(medication.timestamp.formatted(date: .omitted, time: .shortened))
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                .padding()
                                .onTapGesture {
                                    sheetState = .edit(medication)
                                }
                                .glassEffect(.regular.tint(medication.category.medicationColor.opacity(0.11)).interactive())
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .sheet(item: $sheetState, onDismiss: {
            sheetState = nil
        }) { state in
            if let currentUser = session.currentUser {
                switch state {
                case .create:
                    let viewModel = MedicationsFormViewModel(
                        anesthesia: anesthesia,
                        user: currentUser,
                        context: modelContext,
                        catalog: MedicationsHelper.allMedications,
                        entry: nil
                    )
                    MedicationsFormView(
                        viewModel: viewModel,
                        catalog: MedicationsHelper.allMedications
                    )
                case .edit(let medication):
                    let viewModel = MedicationsFormViewModel(
                        anesthesia: anesthesia,
                        user: currentUser,
                        context: modelContext,
                        catalog: MedicationsHelper.allMedications,
                        entry: medication
                    )
                    MedicationsFormView(
                        viewModel: viewModel,
                        catalog: MedicationsHelper.allMedications
                    )
                }
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
                .fontWeight(.black)
                .padding(.horizontal)
                .padding(.vertical, 4)
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
                sheetState = .create
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Adicionar Medicações")
            .buttonStyle(.glass)
            .tint(.blue)
        }
    }
}

