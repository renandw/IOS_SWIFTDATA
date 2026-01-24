//
//  AnesthesiaDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


//
//  AnesthesiaDescriptionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import SwiftData

struct SRPADescriptionView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext

    @Bindable var srpa: SRPA

    @State private var isPresentingForm = false
    @State private var formViewModel: SRPAFormViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let anesthesiaDescription = srpa.descriptionText {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(srpa.surgery.patient.sex.sexColor)
                                Text("Descrição")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        if let descriptionFinal = srpa.descriptionText?.trimmingCharacters(in: .whitespacesAndNewlines), !descriptionFinal.isEmpty {
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
                key: SRPACustomTopBarButtonPreferenceKey.self,
                value: SRPACustomTopBarButtonPreference(
                    id: "AnesthesiaDescriptionView.topbar.buttons",
                    view: AnyView(topBarButtons),
                    token: "AnesthesiaDescriptionView.topbar.buttons.\(srpa.descriptionText == nil)"
                )
            )

            .sheet(isPresented: $isPresentingForm) {
                if let vm = formViewModel {
                    SRPAFormView(
                        viewModel: vm,
                        mode: .onlyDescription
                    )
                }
            }
        }
    }
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if let anesthesiaDescription = srpa.descriptionText {
                Button(action: {
                    presentEditForm(for: srpa)
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
        if let user = session.currentUser {
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = SRPAFormViewModel(
                surgery: srpa.surgery,
                user: user,
                context: modelContext,
                sharedRepo: sharedRepo
            )
            self.formViewModel = vm
            self.isPresentingForm = true
        }
    }
    private func presentEditForm(for entry: SRPA) {
        if let user = session.currentUser {
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let viewModel = SRPAFormViewModel(
                surgery: srpa.surgery,
                user: user,
                context: modelContext,
                sharedRepo: sharedRepo
            )
            self.formViewModel = viewModel
            self.isPresentingForm = true
        }
    }
}

