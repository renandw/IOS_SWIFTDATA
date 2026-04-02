import SwiftUI

struct CBHPMSummaryView: View {
    @Binding var selectedProcedures: [CbhpmCode]

    var body: some View {
        List {
            Section("Ações") {
                NavigationLink {
                    CbhpmSearchView(selectedProcedures: $selectedProcedures)
                } label: {
                    Label("Buscar no Catálogo", systemImage: "magnifyingglass")
                }

                NavigationLink {
                    CBHPMManualInputView(selectedProcedures: $selectedProcedures)
                } label: {
                    Label("Inserir Manualmente", systemImage: "square.and.pencil")
                }
            }

            Section("Itens Selecionados") {
                if selectedProcedures.isEmpty {
                    Text("Nenhum procedimento selecionado")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(selectedProcedures.enumerated()), id: \.offset) { index, item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.procedimento)
                                .font(.subheadline.weight(.semibold))
                            Text("\(item.codigo) • Porte \(item.porte_anestesico)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                selectedProcedures.remove(at: index)
                            } label: {
                                Label("Remover", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Procedimentos CBHPM")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CBHPMSummaryView(selectedProcedures: .constant([
            CbhpmCode(codigo: "3.09.01.01-2", procedimento: "Exemplo", porte_anestesico: "2")
        ]))
    }
}
