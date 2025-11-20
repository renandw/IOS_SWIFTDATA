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
            List {
                if anesthesia.anesthesiaDescriptions.isEmpty {
                    Section {
                        Text("Nenhuma descrição cadastrada.")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Section("Descrições") {
                        ForEach(anesthesia.anesthesiaDescriptions) { entry in
                            Button {
                                presentEditForm(for: entry)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(entry.timestamp, style: .date)
                                            .font(.headline)
                                        Text(entry.timestamp, style: .time)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.tertiary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Descrição da anestesia")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        presentNewForm()
                    } label: {
                        Label("Nova descrição", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingForm) {
                if let vm = formViewModel {
                    AnesthesiaDescriptionFormView(viewModel: vm)
                }
            }
        }
    }

    // MARK: - Helpers

    private func presentNewForm() {
        // Ajuste a forma de obter o usuário conforme a API real do seu SessionManager
        if let user = session.currentUser {
            let repo = SwiftDataAnesthesiaDescriptionEntryRepositoryRepository(context: modelContext)
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
            let repo = SwiftDataAnesthesiaDescriptionEntryRepositoryRepository(context: modelContext)
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
