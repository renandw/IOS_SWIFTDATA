//
//  AnesthesiaDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import SwiftData

struct AnesthesiaDescriptionView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext

    @Bindable var anesthesia: Anesthesia

    @State private var isPresentingForm = false
    @State private var formViewModel: AnesthesiaDescriptionViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let anesthesiaDescription = anesthesia.anesthesiaDescription {
                    ScrollView {                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(anesthesia.surgery.patient.sex.sexColor)
                                Text("Descrição")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        if let descriptionFinal = anesthesiaDescription.veryEndDescriptionText?.trimmingCharacters(in: .whitespacesAndNewlines), !descriptionFinal.isEmpty {
                                            Text(descriptionFinal)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                } else {
                    ContentUnavailableView(
                        "Sem Descrição",
                        systemImage: "text.document.fill",
                        description: Text("Adicione as medicações administradas durante a anestesia.")
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            Button(action: {
                                presentNewForm()
                            }) {
                                Label("Adicionar Descrição", systemImage: "plus")
                            }
                            .buttonStyle(.glass)
                            .tint(.blue)
                            .padding()
                        }
                    )
                }
            }
            .navigationTitle("Descrição da anestesia")
            .preference(
                key: CustomTopBarButtonPreferenceKey.self,
                value: CustomTopBarButtonPreference(
                    id: "AnesthesiaDescriptionView.topbar.buttons",
                    view: AnyView(topBarButtons),
                    token: "AnesthesiaDescriptionView.topbar.buttons.\(anesthesia.anesthesiaDescription == nil)"
                )
            )

            .sheet(item: $formViewModel) { vm in
                AnesthesiaDescriptionFormView(viewModel: vm)
            }
        }
    }
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if let anesthesiaDescription = anesthesia.anesthesiaDescription {
                Button(action: {
                    presentEditForm(for: anesthesiaDescription)
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Editar Descrição")
                .buttonStyle(.glass)
                .tint(.blue)
            } else {
                Button(action: {
                    presentNewForm()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Adicionar Descrição")
                .buttonStyle(.glass)
                .tint(.blue)
            }
        }
    }

    // MARK: - Helpers

    private func presentNewForm() {
        // Ajuste a forma de obter o usuário conforme a API real do seu SessionManager
        if let user = session.currentUser {
            let repo = SwiftDataAnesthesiaDescriptionEntryRepository(context: modelContext)
            let vm = AnesthesiaDescriptionViewModel(
                newFor: anesthesia,
                user: user,
                repo: repo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }

    private func presentEditForm(for entry: AnesthesiaDescriptionEntry) {
        if let user = session.currentUser {
            let repo = SwiftDataAnesthesiaDescriptionEntryRepository(context: modelContext)
            let vm = AnesthesiaDescriptionViewModel(
                entry: entry,
                anesthesia: anesthesia,
                user: user,
                repo: repo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
}

