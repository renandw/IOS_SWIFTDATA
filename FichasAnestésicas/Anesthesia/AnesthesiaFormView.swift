import SwiftUI
import Observation

struct AnesthesiaFormView: View {
    enum Mode {
        case standalone   // usado como tela isolada
        case wizard       // usado dentro do fluxo NewAnesthesiaView
    }

    @Bindable var viewModel: AnesthesiaFormViewModel
    @Environment(\.dismiss) private var dismiss

    // MARK: - Bindings
    private var surgeryDate: Date { viewModel.surgeryDate }

    // Modo de funcionamento da view (padrão mantém comportamento atual)
    var mode: Mode = .standalone

    var body: some View {
        switch mode {
        case .standalone:
            standaloneBody
        case .wizard:
            wizardBody
        }
    }

    // Conteúdo básico do formulário (seções)
    private var formContent: some View {
        Form {
            // Período da Cirurgia (independente da anestesia)
            Section{
                HStack {
                    Text("Anestesia")
                    Spacer()
                    HStack{
                        DateTimePickerSheetButton(
                            date: $viewModel.start,
                            title: "Início da anestesia",
                            placeholder: "Selecionar"
                        )
                        if viewModel.start != nil {
                            Button(role: .destructive) {
                                viewModel.start = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar início da anestesia")
                        }
                    }
                }

                HStack {
                    Text("Cirurgia")
                    
                    Spacer()
                
                    HStack{
                        DateTimePickerSheetButton(
                            date: $viewModel.surgeryStart,
                            title: "Início da cirurgia",
                            placeholder: "Selecionar"
                        )
                        
                        if viewModel.surgeryStart != nil {
                            Button(role: .destructive) {
                                viewModel.surgeryStart = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar início da cirurgia")
                        }
                    }
                }
            } header: {
                VStack(alignment: .leading){
                    Text("Início do Procedimento")
                    VStack(alignment: .leading) {
                        if let e = viewModel.anesthesiaStartError {
                            Text(e)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                        if let e = viewModel.surgeryStartError {
                            Text(e)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }

        
            if viewModel.anesthesia != nil {
                Section {
                    HStack {
                        Text("Cirurgia")
                        Spacer()
                        HStack {
                            DateTimePickerSheetButton(
                                date: $viewModel.surgeryEnd,
                                title: "Fim da cirurgia",
                                placeholder: "Selecionar"
                            )
                            
                            if viewModel.surgeryEnd != nil {
                                Button(role: .destructive) {
                                    viewModel.surgeryEnd = nil
                                } label: {
                                    Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel("Limpar fim da cirurgia")
                            }
                        }
                    }
                    
                    
                        HStack {
                            Text("Anestesia")
                            Spacer()
                            HStack {
                                DateTimePickerSheetButton(
                                    date: $viewModel.end,
                                    title: "Fim da anestesia",
                                    placeholder: "Selecionar"
                                )
                                
                                if viewModel.end != nil {
                                    Button(role: .destructive) {
                                        viewModel.end = nil
                                    } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                                    }
                                    .buttonStyle(.plain)
                                    .accessibilityLabel("Limpar fim da anestesia")
                                }
                            }
                        }
                    } header: {
                        VStack(alignment: .leading) {
                            Text("Fim do Procedimento")
                            VStack(alignment: .leading) {
                                if let e = viewModel.surgeryEndError {
                                    Text(e)
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                }
                                if let e = viewModel.anesthesiaEndError {
                                    Text(e)
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                }
                            }
                    }
                }
            }

            Section {
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
            } header: {
                HStack {
                    Text("Técnicas")
                    if let e = viewModel.techniquesError {
                        Text(e)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
            }

            // ASA (classificação)
            Section {
                NavigationLink {
                    ASAPickerView(selection: $viewModel.asa)
                } label: {
                    HStack {
                        Text("Classificação ASA")
                        Spacer()
                        Text(viewModel.asa?.rawValue ?? "Nenhuma")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                }
            } header: {
                HStack {
                    Text("ASA")
                    if let e = viewModel.asaError {
                        Text(e)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
            }

            Section {
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
            } header: {
                HStack {
                    Text("Posição")
                    if let e = viewModel.positionError {
                        Text(e)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
            }
            // Erros
            if let error = viewModel.errorMessage {
                Section { Text(error).foregroundStyle(.red) }
            }
        }
    }

    // Form com validações reativas compartilhadas entre modos
    private var baseForm: some View {
        formContent
            .onChange(of: viewModel.start) { _, _ in
                viewModel.touched["anesthesiaStart"] = true
                viewModel.validateAnesthesiaStart()
            }
            .onChange(of: viewModel.end) { _, _ in
                viewModel.touched["anesthesiaEnd"] = true
                viewModel.validateAnesthesiaEnd()
            }
            .onChange(of: viewModel.surgeryStart) { _, _ in
                viewModel.touched["surgeryStart"] = true
                viewModel.validateSurgeryStart()
            }
            .onChange(of: viewModel.surgeryEnd) { _, _ in
                viewModel.touched["surgeryEnd"] = true
                viewModel.validateSurgeryEnd()
            }
            .onChange(of: viewModel.techniques) { _, _ in
                viewModel.touched["techniques"] = true
                viewModel.validateAnesthesiaTechnique()
            }
            .onChange(of: viewModel.asa) { _, _ in
                viewModel.touched["asa"] = true
                viewModel.validateASA()
            }
            .onChange(of: viewModel.position) { _, _ in
                viewModel.touched["position"] = true
                viewModel.validatePosition()
            }
    }

    // Modo standalone: com NavigationStack, título e toolbar (Excluir / Salvar)
    private var standaloneBody: some View {
        NavigationStack {
            baseForm
                .navigationTitle(viewModel.anesthesia == nil ? "Nova Anestesia" : "Editar Anestesia")
                .navigationBarTitleDisplayMode(.inline)
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
                        .disabled(!viewModel.isFormValid)
                    }
                }
        }
    }

    // Modo wizard: apenas o formulário, sem NavigationStack nem toolbar própria
    private var wizardBody: some View {
        NavigationStack {
            baseForm
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
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Técnicas Anestésicas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Opções", systemImage: "gear") {
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
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Posições")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Opções", systemImage: "gear") {
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

struct ASAPickerView: View {
    @Binding var selection: ASAClassification?

    private var allASA: [ASAClassification] {
        ASAClassification.allCases
    }

    var body: some View {
        List {
            ForEach(allASA, id: \.self) { asa in
                Button {
                    toggle(asa)
                } label: {
                    HStack {
                        Text(asa.rawValue)
                        Spacer()
                        if selection == asa {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("ASA")
        .navigationBarTitleDisplayMode(.inline)
        
    }

    private func toggle(_ asa: ASAClassification) {
        if selection == asa {
            selection = nil
        } else {
            selection = asa
        }
    }
}

