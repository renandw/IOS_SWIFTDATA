//
//  MedicationsFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//


import SwiftUI

struct SRPAMedicationsFormView: View {
    @Bindable var viewModel: SRPAMedicationsFormViewModel
    let catalog: [MedicationCatalogItem]

    @Environment(\.dismiss) private var dismiss
    private enum EntryMode: String, CaseIterable { case manual = "Manual", presets = "Presets" }
    @State private var mode: EntryMode = .manual

    var body: some View {
        NavigationStack {
            if mode == .manual {
                Form {
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
                                Text("Medicação")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
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
                            .padding(.top, 8)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            LabeledContent {
                                Picker("", selection: Binding(
                                    get: { viewModel.category ?? .opioide },
                                    set: { viewModel.category = $0 }
                                )) {
                                    ForEach(MedicationCategory.allCases, id: \.self) { c in
                                        Text(c.rawValue).tag(c)
                                    }
                                }
                            } label: {
                                Text("Categoria")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
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
                            LabeledContent {
                                Picker("", selection: Binding(
                                    get: { viewModel.via ?? .EV },
                                    set: { viewModel.via = $0 }
                                )) {
                                    ForEach(AdministrationRoute.allCases, id: \.self) { r in
                                        Text(r.label).tag(r)
                                    }
                                }
                            } label: {
                                Text("Via")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
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
                            LabeledContent {
                                TextField("(ex.: 150mg)", text: $viewModel.dose)
                                    .multilineTextAlignment(.trailing)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .onChange(of: viewModel.dose, initial: false) { _, _ in
                                        viewModel.runValidations()
                                    }
                            } label: {
                                Text("Dose")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                            }
                            if let e = viewModel.doseError {
                                Text(e)
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }

                        HStack {
                            Text("Administração")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            DateTimePickerSheetButton(
                                date: Binding<Date?>(
                                    get: { viewModel.timestamp },
                                    set: { viewModel.timestamp = $0 ?? viewModel.timestamp }
                                ),
                                title: "Administração",
                                placeholder: "Selecionar",
                                minDate: viewModel.srpaStart,
                                maxDate: nil,
                                compactInRow: true,
                                onConfirm: {
                                    viewModel.runValidations()
                                }
                            )
                        }
                    } header: {
                        HStack {
                            Image(systemName: "pills.fill")
                            Text("Medicação")
                        }
                    } footer: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Doses, surgeridas automaticamente, para peso: \(String(format: "%.1f", viewModel.patientWeight)) kg")
                            Text("Início Anestesia: \(viewModel.srpaStart?.formatted(date: .numeric, time: .shortened) ?? "Não iniciada")")
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
                            Button("Fechar", systemImage: "xmark") { dismiss() }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !viewModel.isNew {
                            Button("Excluir", systemImage: "trash", role: .destructive) {
                                if viewModel.delete() { dismiss() }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Salvar", systemImage: "checkmark", role: .confirm) {
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
            }
        }
    }
}
