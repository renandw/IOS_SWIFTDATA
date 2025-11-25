//
//  PreAnesthesiaView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import SwiftUI
import SwiftData

struct PreAnesthesiaView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext

    @Bindable var anesthesia: Anesthesia

    @State private var isPresentingForm = false
    @State private var formViewModel: PreAnesthesiaViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let preanesthesia = anesthesia.surgery.preanesthesia {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Section("Descrição") {
                                Button {
                                    presentEditForm(for: preanesthesia)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(preanesthesia.createdAt, style: .date)
                                                .font(.headline)
                                            if let textField = preanesthesia.textField{
                                                Text(textField)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.tertiary)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    ContentUnavailableView(
                        "Sem Avaliação Pré-Anestésica",
                        systemImage: "text.document.fill",
                        description: Text("Crie uma avaliação para ver aqui.")
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
                    token: "AnesthesiaDescriptionView.topbar.buttons.\(anesthesia.surgery.preanesthesia == nil)"
                )
            )

            .sheet(item: $formViewModel) { vm in
                PreAnesthesiaFormView(viewModel: vm)
            }
        }
    }
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if let preanesthesia = anesthesia.surgery.preanesthesia {
                Button(action: {
                    presentEditForm(for: preanesthesia)
                }) {
                    Image(systemName: "pencil")
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
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                newFor: anesthesia.surgery,
                user: user,
                repo: repo,
                context: modelContext
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }

    private func presentEditForm(for preanesthesia: PreAnesthesia) {
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                preanesthesia: preanesthesia,
                user: user,
                repo: repo,
                context: modelContext
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
}

