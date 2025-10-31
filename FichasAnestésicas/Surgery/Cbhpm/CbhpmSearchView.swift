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
    
    private var searchResults: [CbhpmCode] {
        guard debouncedSearchText.count >= 3 else { return [] }
        return CbhpmManager.shared.search(query: debouncedSearchText)
    }
    
    var body: some View {
        // Results list
        List {
            if !selectedProcedures.isEmpty {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // Group by codigo to show counts
                            let grouped = Dictionary(grouping: selectedProcedures, by: { $0.codigo })
                            ForEach(grouped.keys.sorted(), id: \.self) { codigo in
                                if let items = grouped[codigo], let first = items.first {
                                    HStack(spacing: 6) {
                                        Text(first.codigo)
                                            .font(.caption)
                                        if items.count > 1 {
                                            Text("×\(items.count)")
                                                .font(.caption2)
                                                .foregroundStyle(.secondary)
                                        }
                                        Button {
                                            // Remove a single unit
                                            removeSelection(first)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 40)
                }
            }
            if searchText.count < 3 && selectedProcedures.isEmpty {
                Section {
                    ContentUnavailableView(
                        "Nenhum procedimento encontrado",
                        systemImage: "exclamationmark.magnifyingglass",
                        description: Text("Inicie a busca pela barra de busca")
                    )
                }
            } else {
                ForEach(searchResults) { code in
                    Button {
                        toggleSelection(code)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Código do Procedimento: \(code.codigo)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                VStack(alignment: .leading) {
                                    Text("Procedimento:")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text(code.procedimento)
                                        .font(.body)
                                }
                                Text("Porte Anestésico: \(code.porte_anestesico)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar procedimento ou código")
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
            // Simple debounce using DispatchQueue; adjust delay if needed
            let current = newValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if current == searchText { // still the latest value
                    debouncedSearchText = current
                }
            }
        }
    }
    
    private func toggleSelection(_ code: CbhpmCode) {
        // Allow duplicates: always append
        selectedProcedures.append(code)
    }
    
    private func removeSelection(_ code: CbhpmCode) {
        // Remove a single instance (one unit) of this code, if present
        if let idx = selectedProcedures.firstIndex(where: { $0.codigo == code.codigo }) {
            selectedProcedures.remove(at: idx)
        }
    }
}

#Preview {
    NavigationStack{
        CbhpmSearchView(selectedProcedures: .constant([]))
    }
}
