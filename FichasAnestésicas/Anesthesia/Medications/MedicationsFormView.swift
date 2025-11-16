import SwiftUI

struct MedicationsFormView: View {
    @ObservedObject var viewModel: MedicationsFormViewModel
    let catalog: [MedicationCatalogItem]

    @Environment(\.dismiss) private var dismiss
    private enum EntryMode: String, CaseIterable { case manual = "Manual", presets = "Presets" }
    @State private var mode: EntryMode = .manual

    var body: some View {
        NavigationStack {
            if mode == .manual {
                Form {
                    if viewModel.isNew {
                        Section {
                            Picker("Modo", selection: $mode) {
                                ForEach(EntryMode.allCases, id: \.self) { m in
                                    Text(m.rawValue).tag(m)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Section {
                        // IDENTIFICAÇÃO
                        VStack(alignment: .leading, spacing: 4) {
                            LabeledContent {
                                TextField("Nome", text: $viewModel.searchQuery)
                                    .multilineTextAlignment(.trailing)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.default)
                                    .onChange(of: viewModel.searchQuery, initial: false) { oldValue, newValue in
                                        viewModel.name = newValue
                                        if newValue.trimmingCharacters(in: .whitespaces).count < 3 {
                                            viewModel.dismissSuggestions()
                                        }
                                        viewModel.suggestViaIfNeeded()
                                        viewModel.recalcDoseIfNeeded()
                                        viewModel.runValidations()
                                    }
                            } label: {
                                Label("Medicação", systemImage: "pills")
                            }
                            if let e = viewModel.nameError {
                                Text(e)
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }

                        if viewModel.showSuggestions {
                            AutocompleteSuggestionsView(
                                suggestions: viewModel.filteredCatalog,
                                onSelect: { item in
                                    viewModel.selectCatalogItem(item)
                                },
                                onDismiss: {
                                    viewModel.dismissSuggestions()
                                }
                            )
                            .padding(.top, 8)  // Espaçamento do TextField
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Picker("Categoria", selection: Binding(
                                get: { viewModel.category ?? .opioide },
                                set: { viewModel.category = $0 }
                            )) {
                                ForEach(MedicationCategory.allCases, id: \.self) { c in
                                    Text(c.rawValue).tag(c)
                                }
                            }
                            .onChange(of: viewModel.category, initial: false) { _, _ in
                                viewModel.dismissSuggestions()
                                viewModel.runValidations()
                            }
                            
                            if let e = viewModel.categoryError {
                                Text(e)
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Picker("Via", selection: Binding(
                                get: { viewModel.via ?? .EV },
                                set: { viewModel.via = $0 }
                            )) {
                                ForEach(AdministrationRoute.allCases, id: \.self) { r in
                                    Text(r.label).tag(r)
                                }
                            }
                            .onChange(of: viewModel.via, initial: false) { _, _ in
                                viewModel.dismissSuggestions()
                                viewModel.runValidations()
                            }
                            
                            if let e = viewModel.viaError {
                                Text(e)
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            LabeledContent("Dose") {
                                TextField("(ex.: 150mg)", text: $viewModel.dose)
                                    .multilineTextAlignment(.trailing)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .onChange(of: viewModel.dose, initial: false) { _, _ in
                                        viewModel.runValidations()
                                    }
                            }
                            if let e = viewModel.doseError {
                                Text(e)
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }

                        HStack {
                            Text("Administração")
                            Spacer()
                            DateTimePickerSheetButton(
                                date: Binding<Date?>(
                                    get: { viewModel.timestamp },
                                    set: { viewModel.timestamp = $0 ?? viewModel.timestamp }
                                ),
                                title: "Administração",
                                placeholder: "Selecionar",
                                minDate: viewModel.anesthesiaStart,
                                maxDate: nil,
                                compactInRow: true,
                                onConfirm: {
                                    viewModel.runValidations()
                                }
                            )
                        }
                    } header: {
                        Text("Medicação")
                    } footer: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Doses, surgeridas automaticamente, para peso: \(String(format: "%.1f", viewModel.patientWeight)) kg")
                            Text("Início Anestesia: \(viewModel.anesthesiaStart?.formatted(date: .numeric, time: .shortened) ?? "Não iniciada")")
                        }
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    }


                    if let msg = viewModel.errorMessage {
                        Section { Text(msg).foregroundStyle(.red) }
                    }
                }
                .navigationTitle(viewModel.isNew ? "Nova Medicação" : "Editar Medicação")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if viewModel.isNew {
                            Button("Fechar") { dismiss() }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !viewModel.isNew {
                            Button("Excluir", role: .destructive) {
                                if viewModel.delete() { dismiss() }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Salvar", role: .confirm) {
                            if viewModel.save() { dismiss() }
                        }
                        .disabled(!viewModel.isFormValid)
                    }
                }
                .onAppear {
                    if viewModel.category == nil { viewModel.category = .opioide }
                    if viewModel.via == nil { viewModel.via = .EV }
                    viewModel.runValidations()
                }
            } else {
                Form {
                    if viewModel.isNew {
                        Section {
                            Picker("Modo", selection: $mode) {
                                ForEach(EntryMode.allCases, id: \.self) { m in
                                    Text(m.rawValue).tag(m)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Section {
                        List(MedicationsHelper.medicationPresets, id: \.id) { preset in
                            NavigationLink(preset.name) {
                                MedicationPresetGroupView(preset: preset, viewModel: viewModel)
                            }
                        }
                    } header: {
                        Text("Grupos de Presets")
                    }
                }
                .navigationTitle(viewModel.isNew ? "Nova Medicação" : "Editar Medicação")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if viewModel.isNew {
                            Button("Fechar") { dismiss() }
                        }
                    }
                }
            }
        }
    }
}

struct MedicationPresetGroupsView: View {
    @ObservedObject var viewModel: MedicationsFormViewModel
    @State private var query = ""

    private var groups: [MedicationPreset] { MedicationsHelper.medicationPresets }

    private var filteredGroups: [MedicationPreset] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if q.isEmpty { return groups }
        return groups.filter { $0.name.lowercased().contains(q) || $0.medications.contains { $0.name.lowercased().contains(q) } }
    }

    var body: some View {
        List(filteredGroups, id: \.id) { preset in
            NavigationLink(preset.name) {
                MedicationPresetGroupView(preset: preset, viewModel: viewModel)
            }
        }
        .navigationTitle("Presets")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct MedicationPresetGroupView: View {
    let preset: MedicationPreset
    @ObservedObject var viewModel: MedicationsFormViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIDs: Set<UUID> = []

    private var items: [MedicationPresetItem] { preset.medications }

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Horário de Administração")
                    Spacer()
                    DateTimePickerSheetButton(
                        date: Binding<Date?>(
                            get: { viewModel.timestamp },
                            set: { viewModel.timestamp = $0 ?? viewModel.timestamp }
                        ),
                        title: "Administração",
                        placeholder: "Selecionar",
                        minDate: nil, // ou defina se precisar
                        maxDate: nil,
                        compactInRow: true
                    )
                }
            }
            
            Section(footer:
                Text("Medicações podem ser alteradas individualmente quando adicionadas")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            ) {
                ForEach(items) { item in
                    Button {
                        toggle(item.id)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                HStack(spacing: 6) {
                                    Text(item.category.rawValue)
                                    Text("•")
                                    Text(item.via.label)
                                    if !item.dose.isEmpty {
                                        Text("• \(item.dose)")
                                    }
                                }
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            }
                            Spacer()
                            if selectedIDs.contains(item.id) {
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
        }
        .navigationTitle(preset.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Adicionar") {
                    let selected = items.filter { selectedIDs.contains($0.id) }
                    if viewModel.createEntries(from: selected, at: viewModel.timestamp) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            // Seleciona todos por padrão ao abrir
            selectedIDs = Set(items.map(\.id))
        }
    }

    private func toggle(_ id: UUID) {
        if selectedIDs.contains(id) {
            selectedIDs.remove(id)
        } else {
            selectedIDs.insert(id)
        }
    }
}

// MARK: - Autocomplete Support

struct AutocompleteSuggestionsView: View {
    let suggestions: [MedicationCatalogItem]
    let onSelect: (MedicationCatalogItem) -> Void
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(suggestions) { item in
                        Button {
                            onSelect(item)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.name)
                                    Text(item.category.rawValue)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        
                        if item.id != suggestions.last?.id {
                            Divider()
                        }
                    }
                }
            }
            .frame(maxHeight: 250)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal, 16)
        .onTapGesture {
            // Previne dismiss ao clicar dentro
        }
        .background(
            Color.clear
                .contentShape(Rectangle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    onDismiss()
                }
                .ignoresSafeArea()
        )
    }
}
