//
//  SocialHabitsAndEnvironmentFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 28/11/25.
//


import SwiftUI

// MARK: - Protocolo Comum
protocol SocialHabitsAndEnvironmentType: CaseIterable, Hashable, Identifiable where ID == Self {
    var displayName: String { get }
}

// MARK: - Componente Genérico Reutilizável
struct SocialHabitsAndEnvironmentTypeSection<T: SocialHabitsAndEnvironmentType>: View {
    let title: String
    let icon: String
    @Binding var selection: [T]
    @Binding var customDetails: [String]
    @Binding var detailsText: String?
    @State private var newCustomItem = ""
    
    var extraContent: (() -> AnyView)? = nil
    
    var sortedItems: [T] {
        T.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }
    
    var body: some View {
        Section {
            
                // Conteúdo extra (ex: idade gestacional)
                if let extra = extraContent {
                    extra()
                }
                
                // Items predefinidos
                ForEach(sortedItems) { item in
                    Button {
                        toggleSelection(item)
                    } label: {
                        HStack {
                            Text(item.displayName)
                            Spacer()
                            Image(systemName: selection.contains(item) ? "checkmark.circle.fill" : "circle.dashed")
                                .foregroundStyle(selection.contains(item) ? .blue : .gray)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                
                // Items customizados
                ForEach(customDetails, id: \.self) { name in
                    Button {
                        customDetails.removeAll { $0 == name }
                    } label: {
                        HStack {
                            Text(name)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                
                // Campo adicionar custom
                HStack {
                    TextField("Adicionar Especialidades", text: $newCustomItem)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .onSubmit {
                            addCustomItem()
                        }
                    if !newCustomItem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {
                            addCustomItem()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                
                // Campo de detalhes
                if !customDetails.isEmpty || !selection.isEmpty {
                    HStack {
                        Text("Detalhes")
                        TextField(
                            "Informações adicionais",
                            text: Binding<String>(
                                get: { detailsText ?? "" },
                                set: { detailsText = $0.isEmpty ? nil : $0 }
                            )
                        )
                        .multilineTextAlignment(.trailing)
                    }
                }
            
        } header: {
            Text(title)
        }
    }
    
    private func toggleSelection(_ item: T) {
        if let idx = selection.firstIndex(of: item) {
            selection.remove(at: idx)
        } else {
            selection.append(item)
        }
    }
    
    private func addCustomItem() {
        let trimmed = newCustomItem.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty && !customDetails.contains(trimmed) {
            customDetails.append(trimmed)
            newCustomItem = ""
        }
    }
}

// MARK: - View Principal Refatorada
struct SocialHabitsAndEnvironmentFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    private func binding<T>(get: @escaping () -> [T]?, set: @escaping ([T]?) -> Void) -> Binding<[T]> {
        Binding(
            get: { get() ?? [] },
            set: { newArray in set(newArray.isEmpty ? nil : newArray) }
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                
                // Cirurgias Prévias
                SocialHabitsAndEnvironmentTypeSection(
                    title: "Hábitos e Ambiente",
                    icon: "scissors.circle.fill",
                    selection: binding(get: { viewModel.socialHabitsAndEnvironment.socialHabitsAndEnvironmentDetails }, set: { viewModel.socialHabitsAndEnvironment.socialHabitsAndEnvironmentDetails = $0 }),
                    customDetails: $viewModel.socialHabitsAndEnvironment.socialHabitsAndEnvironmentCustomDetails,
                    detailsText: $viewModel.socialHabitsAndEnvironment.socialHabitsAndEnvironmentDetailsText
                )
                
                
                
            }
            .navigationTitle("Hábitos e Ambiente")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        } catch {
                            print("Erro ao salvar: \(error)")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Extensões para conformidade com o protocolo
extension SocialHabitsAndEnvironment: SocialHabitsAndEnvironmentType {
    public var id: Self { self }
}

