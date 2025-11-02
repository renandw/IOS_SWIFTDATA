import SwiftUI

struct AnesthesiaFormView: View {
    @StateObject var viewModel: AnesthesiaFormViewModel
    @Environment(\.dismiss) private var dismiss

    // Controles locais pra ligar/desligar datas opcionais
    @State private var hasStart = false
    @State private var hasEnd = false
    @State private var hasSurgeryStart = false
    @State private var hasSurgeryEnd = false

    // MARK: - Bindings
    private var startBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.start ?? Date() },
            set: { viewModel.start = $0 }
        )
    }

    private var endBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.end ?? Date() },
            set: { viewModel.end = $0 }
        )
    }

    private var hasStartBinding: Binding<Bool> {
        Binding<Bool>(
            get: { hasStart },
            set: { newValue in
                hasStart = newValue
                viewModel.start = newValue ? (viewModel.start ?? Date()) : nil
            }
        )
    }

    private var hasEndBinding: Binding<Bool> {
        Binding<Bool>(
            get: { hasEnd },
            set: { newValue in
                hasEnd = newValue
                viewModel.end = newValue ? (viewModel.end ?? Date()) : nil
            }
        )
    }

    private var surgeryStartBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.surgeryStart ?? Date() },
            set: { viewModel.surgeryStart = $0 }
        )
    }

    private var surgeryEndBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.surgeryEnd ?? Date() },
            set: { viewModel.surgeryEnd = $0 }
        )
    }

    private var hasSurgeryStartBinding: Binding<Bool> {
        Binding<Bool>(
            get: { hasSurgeryStart },
            set: { newValue in
                hasSurgeryStart = newValue
                viewModel.surgeryStart = newValue ? (viewModel.surgeryStart ?? Date()) : nil
            }
        )
    }

    private var hasSurgeryEndBinding: Binding<Bool> {
        Binding<Bool>(
            get: { hasSurgeryEnd },
            set: { newValue in
                hasSurgeryEnd = newValue
                viewModel.surgeryEnd = newValue ? (viewModel.surgeryEnd ?? Date()) : nil
            }
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                // Período da Cirurgia (independente da anestesia)
                Section("Período da Cirurgia") {
                    Toggle("Definir início da cirurgia", isOn: hasSurgeryStartBinding)
                    if hasSurgeryStart {
                        DatePicker(
                            "Início da cirurgia",
                            selection: surgeryStartBinding,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }

                    Toggle("Definir fim da cirurgia", isOn: hasSurgeryEndBinding)
                    if hasSurgeryEnd {
                        DatePicker(
                            "Fim da cirurgia",
                            selection: surgeryEndBinding,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }

                // Período da Anestesia
                Section("Período da Anestesia") {
                    Toggle("Definir início da anestesia", isOn: hasStartBinding)
                    if hasStart {
                        DatePicker(
                            "Início da anestesia",
                            selection: startBinding,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }

                    Toggle("Definir fim da anestesia", isOn: hasEndBinding)
                    if hasEnd {
                        DatePicker(
                            "Fim da anestesia",
                            selection: endBinding,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }

                // Técnicas (navegação para seleção com checkmarks)
                Section("Técnicas") {
                    NavigationLink {
                        AnesthesiaTechniquePickerView(selection: $viewModel.techniques)
                    } label: {
                        HStack {
                            Text("Selecionar técnicas")
                            Spacer()
                            Text(viewModel.techniques.isEmpty
                                 ? "Nenhuma"
                                 : viewModel.techniques.map(\.rawValue).joined(separator: ", "))
                            .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }

                // Posição (navegação para multi-seleção com checkmarks)
                Section("Posição") {
                    NavigationLink {
                        PositionPickerView(selection: $viewModel.position)
                    } label: {
                        HStack {
                            Text("Selecionar posições")
                            Spacer()
                            Text(viewModel.position.isEmpty
                                 ? "Nenhuma"
                                 : viewModel.position.map(\.rawValue).joined(separator: ", "))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }

                // Erros
                if let error = viewModel.errorMessage {
                    Section { Text(error).foregroundStyle(.red) }
                }
            }
            .onAppear {
                hasStart = viewModel.start != nil
                hasEnd = viewModel.end != nil
                hasSurgeryStart = viewModel.surgeryStart != nil
                hasSurgeryEnd = viewModel.surgeryEnd != nil
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
                        if viewModel.save() {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AnesthesiaTechniquePickerView: View {
    @Binding var selection: [AnesthesiaTechniqueKind]

    private var allTechniques: [AnesthesiaTechniqueKind] {
        AnesthesiaTechniqueKind.allCases.sorted { a, b in
            a.rawValue.localizedCaseInsensitiveCompare(b.rawValue) == .orderedAscending
        }
    }

    var body: some View {
        List {
            ForEach(allTechniques, id: \.self) { kind in
                Button {
                    toggle(kind)
                } label: {
                    HStack {
                        Text(kind.rawValue)
                        Spacer()
                        if selection.contains(kind) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Técnicas Anestésicas")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Opções") {
                    Button("Selecionar tudo") { selection = allTechniques }
                    Button("Limpar seleção", role: .destructive) { selection.removeAll() }
                }
            }
        }
    }

    private func toggle(_ kind: AnesthesiaTechniqueKind) {
        if let idx = selection.firstIndex(of: kind) {
            selection.remove(at: idx)
        } else {
            selection.append(kind)
        }
    }
}

struct PositionPickerView: View {
    @Binding var selection: [Positioning]

    private var allPositions: [Positioning] {
        Positioning.allCases.sorted { a, b in
            a.rawValue.localizedCaseInsensitiveCompare(b.rawValue) == .orderedAscending
        }
    }

    var body: some View {
        List {
            ForEach(allPositions, id: \.self) { pos in
                Button {
                    toggle(pos)
                } label: {
                    HStack {
                        Text(pos.rawValue)
                        Spacer()
                        if selection.contains(pos) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Posições")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Opções") {
                    Button("Selecionar tudo") { selection = allPositions }
                    Button("Limpar seleção", role: .destructive) { selection.removeAll() }
                }
            }
        }
    }

    private func toggle(_ pos: Positioning) {
        if let idx = selection.firstIndex(of: pos) {
            selection.remove(at: idx)
        } else {
            selection.append(pos)
        }
    }
}
