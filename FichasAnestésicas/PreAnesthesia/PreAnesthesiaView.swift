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
                if anesthesia.surgery.preanesthesia != nil {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading) {
                                HStack {
                                    if anesthesia.surgery.patient.sex == .male {
                                        Image(systemName: "figure.stand")
                                            .foregroundStyle(anesthesia.surgery.patient.sex.sexColor)
                                    } else {
                                        Image(systemName: "figure.stand.dress")
                                            .foregroundStyle(anesthesia.surgery.patient.sex.sexColor)
                                    }
                                    Text("APA")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()    
                                    
                                    if let status = anesthesia.surgery.preanesthesia?.status{
                                        status.badgeView
                                    }

                                }
                                Divider()
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Classificação ASA:")
                                            Spacer()
                                            if let asa = anesthesia.shared?.asa {
                                                asa.badgeView
                                            }
                                        }
                                        HStack {
                                            Text("Apto:")
                                            Spacer()
                                            if let clearanceStatus = anesthesia.surgery.preanesthesia?.clearenceStatus {
                                                Text("\(clearanceStatus.displayName)")
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "stethoscope")
                                        .foregroundStyle(.green)
                                    Text("Comorbidades")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                Divider()
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Cardiovasculares:")
                                        }
                                        HStack {
                                            Text("Respiratórias:")
                                            Spacer()
                                            Text("Asma")
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

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
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                newFor: anesthesia.surgery,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }

    private func presentEditForm(for preanesthesia: PreAnesthesia) {
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                preanesthesia: preanesthesia,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
}

