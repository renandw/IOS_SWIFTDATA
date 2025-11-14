import SwiftUI

struct AnesthesiaFormView: View {
    @ObservedObject var viewModel: AnesthesiaFormViewModel
    @Environment(\.dismiss) private var dismiss

    // MARK: - Bindings
    private var surgeryDate: Date { viewModel.surgeryDate }

    private var startBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.start ?? surgeryDate },
            set: { viewModel.start = $0 }
        )
    }

    private var endBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.end ?? surgeryDate },
            set: { viewModel.end = $0 }
        )
    }

    private var surgeryStartBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.surgeryStart ?? surgeryDate },
            set: { viewModel.surgeryStart = $0 }
        )
    }

    private var surgeryEndBinding: Binding<Date> {
        Binding<Date>(
            get: { viewModel.surgeryEnd ?? surgeryDate },
            set: { viewModel.surgeryEnd = $0 }
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                // Período da Cirurgia (independente da anestesia)
                Section{
                    HStack {
                        Text("Anestesia")
                        Spacer()
                        HStack{
                            DateTimePickerSheetButton(
                                date: startBinding,
                                title: "Início da anestesia",
                                onConfirm: {
                                    if viewModel.start == nil { viewModel.start = surgeryDate }
                                }
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
                                date: surgeryStartBinding,
                                title: "Início da cirurgia",
                                onConfirm: {
                                    if viewModel.surgeryStart == nil { viewModel.surgeryStart = surgeryDate }
                                }
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
                                    date: surgeryEndBinding,
                                    title: "Fim da cirurgia",
                                    onConfirm: {
                                        if viewModel.surgeryEnd == nil { viewModel.surgeryEnd = surgeryDate }
                                    }
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
                                        date: endBinding,
                                        title: "Fim da anestesia",
                                        onConfirm: {
                                            if viewModel.end == nil { viewModel.end = surgeryDate }
                                        }
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
                            Image(systemName: "checkmark")
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
                            Image(systemName: "checkmark")
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


struct DateTimePickerSheetButton: View {
    @Binding var date: Date
    var title: String
    var minDate: Date? = nil
    var maxDate: Date? = nil
    var compactInRow: Bool = true
    var onConfirm: (() -> Void)? = nil
    @State private var showPicker = false
    @State private var tempDate: Date? = nil

    var body: some View {
        Button {
            tempDate = date
            showPicker = true
        } label: {
            Group {
                if compactInRow {
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .foregroundStyle(.secondary)
                        Text(Self.inlineFormatter.string(from: date))
                            .foregroundStyle(.tint)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .contentShape(Rectangle())
                } else {
                    HStack {
                        Text(title)
                        Spacer()
                        Text(Self.inlineFormatter.string(from: date))
                            .foregroundStyle(.tint)
                            .monospacedDigit()
                            .fontWeight(.semibold)
                    }
                    .font(.body)
                    .padding(.vertical, 6)
                    .contentShape(Rectangle())
                }
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showPicker) {
            NavigationStack {
                VStack {
                    DatePicker(
                        "",
                        selection: Binding<Date>(
                            get: { tempDate ?? date },
                            set: { tempDate = $0 }
                        ),
                        in: (minDate ?? .distantPast)...(maxDate ?? .distantFuture),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: "pt_BR"))
                }
                .navigationTitle(title.isEmpty ? "Selecionar" : title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { showPicker = false }
                            .tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("OK") {
                            if let confirmed = tempDate {
                                date = confirmed
                            }
                            onConfirm?()
                            showPicker = false
                        }
                        .tint(.blue)
                    }
                }
                .padding()
            }
            .presentationDetents([.fraction(0.35)])
            .presentationDragIndicator(.visible)
        }
    }

    static let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    static let inlineFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateFormat = "dd/MM/yyyy HH:mm"
        return f
    }()
}

