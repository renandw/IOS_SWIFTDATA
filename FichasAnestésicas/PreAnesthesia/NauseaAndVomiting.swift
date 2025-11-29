//
//  NauseaAndVomiting.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 28/11/25.
//

import SwiftUI

// MARK: - Protocolo Comum
protocol ApfelScoreType: CaseIterable, Hashable, Identifiable where ID == Self {
    var displayName: String { get }
}

// MARK: - Componente Genérico Reutilizável
struct ApfelScoreTypeSection<T: ApfelScoreType>: View {
    let title: String
    let icon: String
    @Binding var selection: [T]
    
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
}

// MARK: - View Principal Refatorada
struct ApfelScoreFormView: View {
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
                
                ApfelScoreTypeSection(
                    title: "Riscos para Náusea e Vômito",
                    icon: "person.wave.2",
                    selection: binding(get: { viewModel.socialHabitsAndEnvironment.apfelScoreDetails }, set: { viewModel.socialHabitsAndEnvironment.apfelScoreDetails = $0 })
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

extension ApfelScore: ApfelScoreType {
    public var id: Self { self }
}
