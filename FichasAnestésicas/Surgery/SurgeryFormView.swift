//
//  SurgeryFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//

import SwiftUI
import SwiftData

struct SurgeryFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SessionManager.self) var session
    @Bindable var viewModel: SurgeryFormViewModel
    @State private var isSaving = false
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Dados Básicos
                Section("Dados Básicos") {
                    DatePicker("Data da Cirurgia",
                               selection: $viewModel.date,
                               displayedComponents: .date)
                    
                    Picker("Tipo", selection: $viewModel.type) {
                        ForEach(SurgeryType.allCases, id: \.self) { type in
                            Text(type == .sus ? "SUS" : "Convênio")
                        }
                    }
                    .pickerStyle(.segmented)
                
                    
                    if viewModel.type == .sus {
                        TextField("Convênio", text: $viewModel.insuranceName)
                        TextField("Prontuário", text: $viewModel.insuranceNumber)
                            .keyboardType(.numberPad)
                    } else if viewModel.type == .convenio {
                        TextField("Convênio", text: $viewModel.insuranceName)
                        TextField("Carteirinha", text: $viewModel.insuranceNumber)
                            .keyboardType(.numberPad)
                    }
                }
                if viewModel.insuranceName.lowercased() == "particular" {
                    Section("Dados Financeiros"){
                        TextField("Valor", value: $viewModel.valueAnesthesia, format: .currency(code: "BRL"))
                    }
                }
                
                // MARK: - Dados da Cirurgia
                Section("Dados da Cirurgia") {
                    TextField("Cirurgião Principal", text: $viewModel.mainSurgeon)
                    
                    TextField("Hospital", text: $viewModel.hospital)
                    
                    HStack {
                        Text("Peso (kg)")
                        Spacer()
                        TextField("Peso", value: $viewModel.weight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    TextField("Procedimento Proposto", text: $viewModel.proposedProcedure, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                // MARK: - Procedimentos CBHPM
                Section("Procedimentos CBHPM") {
                    NavigationLink {
                        CbhpmSearchView(selectedProcedures: $viewModel.selectedProcedures)
                            .navigationTitle("Selecionar Procedimentos")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        HStack {
                            Text("Procedimentos")
                            Spacer()
                            // Um resumo rápido do que já foi selecionado
                            if viewModel.selectedProcedures.isEmpty {
                                Text("Nenhum").foregroundStyle(.secondary)
                            } else {
                                Text("\(viewModel.selectedProcedures.count) selecionado(s)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                // MARK: - Campos Opcionais
                Section("Informações Adicionais") {
                    DatePicker("Início",
                               selection: Binding(
                                get: { viewModel.start ?? Date() },
                                set: { viewModel.start = $0 }
                               ),
                               displayedComponents: [.date, .hourAndMinute])
                    
                    DatePicker("Término",
                               selection: Binding(
                                get: { viewModel.end ?? Date() },
                                set: { viewModel.end = $0 }
                               ),
                               displayedComponents: [.date, .hourAndMinute])
                    
                    TextField("Procedimento Completo", 
                              text: Binding(
                                get: { viewModel.completeProcedure ?? "" },
                                set: { viewModel.completeProcedure = $0.isEmpty ? nil : $0 }
                              ),
                              axis: .vertical)
                        .lineLimit(3...6)
                    
                    // Auxiliar Surgeons (simplified - pode melhorar depois)
                    TextField("Cirurgiões Auxiliares (separados por vírgula)",
                              text: Binding(
                                get: { viewModel.auxiliarySurgeons?.joined(separator: ", ") ?? "" },
                                set: { 
                                    let surgeons = $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                                    viewModel.auxiliarySurgeons = surgeons.isEmpty ? nil : surgeons
                                }
                              ))
                }
            }
            .onChange(of: viewModel.type) { oldValue, newValue in
                if newValue == .sus {
                    viewModel.insuranceName = "SUS"
                } else if oldValue == .sus && viewModel.insuranceName == "SUS" {
                    // Clear the auto-filled value when leaving SUS to avoid unintended carryover
                    viewModel.insuranceName = ""
                }
            }
            .navigationTitle(viewModel.isEditing ? "Editar Cirurgia" : "Nova Cirurgia")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", systemImage: "xmark") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar", systemImage: "checkmark") {
                        Task {
                            guard let currentUser = session.currentUser else {
                                return
                            }
                            isSaving = true
                            try? viewModel.save(currentUser: currentUser)
                            isSaving = false
                            
                            if viewModel.saveSuccess {
                                dismiss()
                            }
                        }
                    }
                    .disabled(!viewModel.isValid || isSaving)
                }
            }
        }
    }
}

