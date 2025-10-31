//
//  CbhpmSearchView.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import SwiftUI

struct CbhpmSearchView: View {
    @Binding var selectedProcedures: [CbhpmCode]
    @State private var searchText = ""
    
    private var searchResults: [CbhpmCode] {
        CbhpmManager.shared.search(query: searchText)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Selected procedures (chips)
            if !selectedProcedures.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(selectedProcedures) { procedure in
                            HStack {
                                Text(procedure.codigo)
                                    .font(.caption)
                                Button {
                                    removeSelection(procedure)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 40)
            }
            
            // Results list
            List(searchResults) { code in
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
                        Spacer()
                        if isSelected(code) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Buscar procedimento ou código")
        .navigationTitle("Procedimentos CBHPM")
    }
    
    private func isSelected(_ code: CbhpmCode) -> Bool {
        selectedProcedures.contains(where: { $0.codigo == code.codigo })
    }
    
    private func toggleSelection(_ code: CbhpmCode) {
        if let index = selectedProcedures.firstIndex(where: { $0.codigo == code.codigo }) {
            selectedProcedures.remove(at: index)
        } else {
            selectedProcedures.append(code)
        }
    }
    
    private func removeSelection(_ code: CbhpmCode) {
        selectedProcedures.removeAll(where: { $0.codigo == code.codigo })
    }
}

#Preview {
    @Previewable @State var selectedProcedures: [CbhpmCode] = [
        CbhpmCode(codigo: "4.02.01.28-7", procedimento: "Ureteroscopia rígida unilateral", porte_anestesico: "3")
    ]
    
    return CbhpmSearchView(selectedProcedures: $selectedProcedures)
}
