//
//  MedicationsFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//

import SwiftUI

struct MedicationsFormView: View {
    @ObservedObject var viewModel: MedicationsFormViewModel
    let catalog: [MedicationCatalogItem]  // name + category

    @Environment(\.dismiss) private var dismiss
    private enum EntryMode: String, CaseIterable { case manual = "Manual", presets = "Presets" }
    @State private var mode: EntryMode = .manual

    var body: some View {
        NavigationStack {
            Picker("Modo", selection: $mode) {
                ForEach(EntryMode.allCases, id: \.self) { m in
                    Text(m.rawValue).tag(m)
                }
            }
            .pickerStyle(.segmented)
            .padding([.horizontal, .top])

            if mode == .manual {
                Form {
                    // IDENTIFICAÇÃO
                    Section("Identificação") {
                        ZStack(alignment: .topLeading) {
                            VStack(alignment: .leading, spacing: 0) {
                                TextField("Nome", text: $viewModel.searchQuery)
                                    .onChange(of: viewModel.searchQuery) { newValue in
                                        viewModel.name = newValue
                                        if newValue.trimmingCharacters(in: .whitespaces).count < 3 {
                                            viewModel.dismissSuggestions()
                                        }
                                        viewModel.suggestViaIfNeeded()
                                        viewModel.recalcDoseIfNeeded()
                                        viewModel.runValidations()
                                    }
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
                        
                        Picker("Categoria", selection: Binding(
                            get: { viewModel.category ?? .opioide },
                            set: { viewModel.category = $0 }
                        )) {
                            ForEach(MedicationCategory.allCases, id: \.self) { c in
                                Text(c.rawValue).tag(c)
                            }
                        }
                        .onChange(of: viewModel.category) { _ in
                            viewModel.dismissSuggestions()
                            viewModel.runValidations()
                        }
                        
                        Picker("Via", selection: Binding(
                            get: { viewModel.via ?? .EV },
                            set: { viewModel.via = $0 }
                        )) {
                            ForEach(AdministrationRoute.allCases, id: \.self) { r in
                                Text(r.label).tag(r)
                            }
                        }
                        .onChange(of: viewModel.via) { _ in
                            viewModel.dismissSuggestions()
                            viewModel.runValidations()
                        }
                        
                        if let e = viewModel.nameError { Text(e).foregroundStyle(.red) }
                        if let e = viewModel.categoryError { Text(e).foregroundStyle(.red) }
                        if let e = viewModel.viaError { Text(e).foregroundStyle(.red) }
                    }

                    // DOSE
                    Section("Dose") {
                        Toggle("Calcular automaticamente", isOn: $viewModel.autoDose)
                            .onChange(of: viewModel.autoDose) { on in
                                if on { viewModel.recalcDoseIfNeeded() }
                                viewModel.runValidations()
                            }
                        TextField("Dose (ex.: 100mg ou 1–2 mg/kg)", text: $viewModel.dose)
                            .onChange(of: viewModel.dose) { _ in viewModel.runValidations() }
                        if let e = viewModel.doseError { Text(e).foregroundStyle(.red) }
                        Text("Peso: \(String(format: "%.1f", viewModel.patientWeight)) kg")
                            .font(.footnote).foregroundStyle(.secondary)
                    }

                    // HORÁRIO
                    Section("Horário") {
                        DatePicker("Aplicação", selection: $viewModel.timestamp, displayedComponents: [.date, .hourAndMinute])
                    }

                    if let msg = viewModel.errorMessage {
                        Section { Text(msg).foregroundStyle(.red) }
                    }
                }
                .navigationTitle(viewModel.isNew ? "Nova Medicação" : "Editar Medicação")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !viewModel.isNew {
                            Button("Excluir", role: .destructive) {
                                if viewModel.delete() { dismiss() }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Salvar") {
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
                // Presets list directly (no extra navigation step)
                MedicationPresetGroupsView { items in
                    if viewModel.createEntries(from: items) {
                        dismiss()
                    }
                }
                .navigationTitle("Presets")
            }
        }
    }
}

// Picker com busca + seleção
struct MedicationCatalogPicker: View {
    let catalog: [MedicationCatalogItem]
    let onPick: (MedicationCatalogItem) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""

    var filtered: [MedicationCatalogItem] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if q.isEmpty { return catalog }
        return catalog.filter { $0.name.lowercased().contains(q) }
    }

    var body: some View {
        List(filtered) { item in
            Button {
                onPick(item)
                dismiss()
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                    Text(item.category.rawValue).font(.footnote).foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(.primary)
        }
        .navigationTitle("Catálogo")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct MedicationPresetGroupsView: View {
    let onConfirmItems: ([MedicationPresetItem]) -> Void
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
                MedicationPresetGroupView(preset: preset, onConfirmItems: onConfirmItems)
            }
        }
        .navigationTitle("Presets")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct MedicationPresetGroupView: View {
    let preset: MedicationPreset
    let onConfirmItems: ([MedicationPresetItem]) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIDs: Set<UUID> = []

    private var items: [MedicationPresetItem] { preset.medications }

    var body: some View {
        List(items) { item in
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
                        Image(systemName: "checkmark")
                    }
                }
            }
            .foregroundStyle(.primary)
        }
        .navigationTitle(preset.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Adicionar selecionados") {
                    let selected = items.filter { selectedIDs.contains($0.id) }
                    onConfirmItems(selected)
                    dismiss()
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
