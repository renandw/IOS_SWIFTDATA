//
//  EditRowWithOptions.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/02/26.
//
import SwiftUI

struct EditRowWithOptions: View {
    let label: String
    @Binding var value: String
    let options: [String]
    
    @State private var showingPicker = false
    @State private var searchText = ""
    
    private var filteredOptions: [String] {
        if searchText.isEmpty {
            return options
        }
        return options.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        Button {
            searchText = ""
            showingPicker = true
        } label: {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Spacer()
                Text(value.isEmpty ? "Selecionar" : value)
                    .foregroundStyle(value.isEmpty ? .secondary : .primary)
                    .multilineTextAlignment(.trailing)
                if !value.isEmpty {
                    Button {
                       value = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Limpar \(label)")
                }
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showingPicker) {
            NavigationStack {
                List {
                    // Opção de usar o texto digitado (se não existe nas opções)
                    if !searchText.isEmpty && !options.contains(where: { $0.lowercased() == searchText.lowercased() }) {
                        Button {
                            value = searchText
                            showingPicker = false
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.green)
                                Text("Adicionar \"\(searchText)\"")
                            }
                        }
                    }
                    
                    // Opções filtradas
                    ForEach(filteredOptions, id: \.self) { option in
                        Button {
                            value = option
                            showingPicker = false
                        } label: {
                            HStack {
                                Text(option)
                                Spacer()
                                if value == option {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                            .contentShape(.rect)
                        }
                        
                        .buttonStyle(.plain)
                    }
                }
                .searchable(text: $searchText, prompt: "Buscar ou adicionar")
                .navigationTitle(label)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            showingPicker = false
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    @Previewable @State var insurance = "Destiny"

    Form{
        Section {
            EditRowWithOptions(
                label: "Convênio",
                value: $insurance,
                options: [
                    "Particular",
                    "Unimed",
                    "Bradesco",
                    "Amil",
                    "Sulamerica",
                    "Saúde Caixa"
                ]
            )
        }
    }
}
