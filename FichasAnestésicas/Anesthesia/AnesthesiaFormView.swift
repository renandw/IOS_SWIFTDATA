import SwiftUI

struct AnesthesiaFormView: View {
    @StateObject var viewModel: AnesthesiaFormViewModel
    @Environment(\.dismiss) private var dismiss

    // Controles locais pra ligar/desligar datas opcionais
    @State private var hasStart = false
    @State private var hasEnd = false

    var body: some View {
        NavigationStack {
            Form {
                // Período
                Section("Período") {
                    Toggle("Definir início", isOn: $hasStart)
                        .onChange(of: hasStart) { value in
                            viewModel.start = value ? (viewModel.start ?? Date()) : nil
                        }
                        .onAppear { hasStart = viewModel.start != nil }

                    if hasStart {
                        DatePicker("Início",
                                   selection: Binding<Date>(
                                       get: { viewModel.start ?? Date() },
                                       set: { viewModel.start = $0 }
                                   ),
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                    }

                    Toggle("Definir fim", isOn: $hasEnd)
                        .onChange(of: hasEnd) { value in
                            viewModel.end = value ? (viewModel.end ?? Date()) : nil
                        }
                        .onAppear { hasEnd = viewModel.end != nil }

                    if hasEnd {
                        DatePicker("Fim",
                                   selection: Binding<Date>(
                                       get: { viewModel.end ?? Date() },
                                       set: { viewModel.end = $0 }
                                   ),
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }

                // Técnicas (somente leitura por enquanto)
                Section("Técnicas") {
                    if viewModel.techniques.isEmpty {
                        Text("Nenhuma técnica selecionada").foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.techniques, id: \.self) { t in
                            Text(t.rawValue)
                        }
                    }
                }

                // Posição
                Section("Posição") {
                    TextField(
                        "Posição do paciente",
                        text: Binding<String>(
                            get: { viewModel.position ?? "" },
                            set: { viewModel.position = $0.isEmpty ? nil : $0 }
                        )
                    )
                    .textInputAutocapitalization(.words)
                }

                // Erros
                if let error = viewModel.errorMessage {
                    Section { Text(error).foregroundStyle(.red) }
                }
            }
            .navigationTitle("Ficha de Anestesia")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Excluir", role: .destructive) {
                        viewModel.delete()
                        dismiss()
                    }
                    .disabled(viewModel.anesthesia == nil)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        viewModel.save()
                        dismiss()
                    }
                }
            }
        }
    }
}
