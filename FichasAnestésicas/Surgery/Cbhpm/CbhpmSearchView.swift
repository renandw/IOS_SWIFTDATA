//
//  CbhpmSearchView.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import SwiftUI

struct CbhpmSearchView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedProcedures: [CbhpmCode]
    @State private var searchText = ""
    @State private var debouncedSearchText = ""
    @State private var isSearching = false
    
    private var searchResults: [CbhpmCode] {
        guard debouncedSearchText.count >= 3 else { return [] }
        return CbhpmManager.shared.search(query: debouncedSearchText)
    }
    
    var body: some View {
        // Results list
        List {
            if !selectedProcedures.isEmpty {
                Section(header: Text("Procedimentos Selecionados")) {
                    let grouped = Dictionary(grouping: selectedProcedures, by: { $0.codigo })
                    ForEach(grouped.keys.sorted(), id: \.self) { codigo in
                        if let items = grouped[codigo], let first = items.first {
                            ProcedureCard(
                                code: first,
                                count: items.count,
                                onAdd: { addSelection(first) },
                                onRemove: { removeSelection(first) }
                            )
                        }
                    }
                }
            }
            
            Section {
                if searchText.count < 3 && !isSearching && selectedProcedures.isEmpty {
                    Button("Sair", systemImage: "xmark") { dismiss() }
                    ContentUnavailableView(
                        "Nenhum procedimento encontrado",
                        systemImage: "exclamationmark.magnifyingglass",
                        description: Text("Inicie a busca pela barra de busca")
                    )
                    .id("empty-state")
                    
                } else if isSearching {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .id("loading")
                } else if debouncedSearchText.count >= 3 && searchResults.isEmpty {
                    Button("Sair", systemImage: "xmark") { dismiss() }
                    ContentUnavailableView(
                        "Nenhum procedimento encontrado",
                        systemImage: "exclamationmark.magnifyingglass",
                        description: Text("não encontrou-se procedimentos com o texto informado")
                    )
                    .id("no-results")
                } else {
                    ForEach(searchResults) { code in
                        Button {
                            toggleSelection(code)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .bottom) {
                                        Text("Código:")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("\(code.codigo)")
                                            .font(.subheadline)
                                            .foregroundStyle(.primary)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(code.procedimento)
                                            .font(.subheadline)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineLimit(nil)
                                    }
                                    Text("Porte Anestésico: \(code.porte_anestesico)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Button("Sair", systemImage: "xmark") { dismiss() }
                }
            }
        }
        .animation(.none, value: debouncedSearchText)
        .searchable(text: $searchText, placement: .toolbar, prompt: "Buscar procedimento ou código")
        .navigationTitle("Procedimentos CBHPM")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Concluir", systemImage: "checkmark") { dismiss() }
            }
        }
        .onAppear {
            debouncedSearchText = searchText
        }
        .onChange(of: searchText) { _, newValue in
            isSearching = true
            let current = newValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if current == searchText {
                    debouncedSearchText = current
                    isSearching = false
                }
            }
        }
    }
    
    private func toggleSelection(_ code: CbhpmCode) {
        // Allow duplicates: always append
        selectedProcedures.append(code)
        // Clear search after adding
        searchText = ""
        debouncedSearchText = ""
    }
    
    private func addSelection(_ code: CbhpmCode) {
        selectedProcedures.append(code)
    }
    
    private func removeSelection(_ code: CbhpmCode) {
        // Remove a single instance (one unit) of this code, if present
        if let idx = selectedProcedures.firstIndex(where: { $0.codigo == code.codigo }) {
            selectedProcedures.remove(at: idx)
        }
    }
}

// MARK: - ProcedureCard Component
struct ProcedureCard: View {
    let code: CbhpmCode
    let count: Int
    let onAdd: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Código: \(code.codigo)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(code.procedimento)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    
                    Text("Porte Anestésico: \(code.porte_anestesico)")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                VStack(alignment: .trailing) {
                    HStack(spacing: 12) {
                        Button(action: onRemove) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title3)
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.borderless)
                        
                        Text("×\(count)")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .frame(minWidth: 30)
                        
                        Button(action: onAdd) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                                .foregroundStyle(.blue)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack{
        CbhpmSearchView(selectedProcedures: .constant([]))
    }
}
