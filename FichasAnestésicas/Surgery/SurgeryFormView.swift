//
//  SurgeryFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//

import SwiftUI
import SwiftData

struct SurgeryFormView: View {
    enum Mode {
        case standalone   // usado como sheet/fluxo isolado
        case wizard       // usado dentro do fluxo NewAnesthesiaView
    }
    @Environment(\.dismiss) private var dismiss
    @Environment(SessionManager.self) var session
    @Bindable var viewModel: SurgeryFormViewModel
    
    @FocusState private var isFocusedMS: Bool
    @FocusState private var isFocusedH: Bool
    @State private var newAuxSurgeon: String = ""
    @FocusState private var isFocusedAuxInput: Bool
    
    @State private var isSaving = false
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

    // Conteúdo comum do formulário
    private var formContent: some View {
        Form {
            // MARK: - Dados Básicos
            Section("Dados Básicos") {
                HStack(alignment: .center) {
                    Text("Data da Cirurgia")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    OnlyDatePickerSheetButton(
                        date: Binding<Date?>(
                            get: { viewModel.date },
                            set: { viewModel.date = $0 ?? viewModel.date }
                        ),
                        title: "Data da Cirurgia",
                        placeholder: "Selecionar",
                        minDate: nil,
                        maxDate: Date(),
                        compactInRow: true
                    )
                }
                HStack(alignment: .center){
                    Text("Tipo")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Picker("Tipo", selection: $viewModel.type) {
                        ForEach(SurgeryType.allCases, id: \.self) { type in
                            Text(type == .sus ? "SUS" : "Convênio")
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 200)
                }
                
                if viewModel.type == .sus {
                    HStack(alignment: .center){
                        Text("Convênio SUS")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("SUS", text: $viewModel.insuranceName)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack(alignment: .center){
                        Text("Prontuário")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Prontuário", text: $viewModel.insuranceNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                } else if viewModel.type == .convenio {
                    HStack(alignment: .center){
                        Text("Convênio")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Convênio", text: $viewModel.insuranceName)
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                    }
                    HStack(alignment: .center){
                        Text("Carteirinha")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Carteirinha", text: $viewModel.insuranceNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            if viewModel.insuranceName.lowercased() == "particular" {
                Section("Dados Financeiros"){
                    HStack(alignment: .center){
                        Text("Valor")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("R$ 2100,00", value: $viewModel.valueAnesthesia, format: .currency(code: "BRL"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            // MARK: - Dados da Cirurgia
            Section("Dados da Cirurgia") {
                
                HStack(alignment: .center){
                    Text("Hospital")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    TextField("Hospital", text: $viewModel.hospital)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .focused($isFocusedH)
                        .onChange(of: isFocusedH) { _, focused in
                            if !focused {
                                viewModel.hospital = viewModel.formatName(viewModel.hospital)
                            }
                        }
                }
                HStack {
                    Text("Peso do Paciente")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("Peso", value: $viewModel.weight, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    if viewModel.weight != 0 {
                        Text("kg")
                            .font(.caption)
                    }
                }
                HStack(alignment: .center){
                    Text("Cirurgia Proposta")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    TextField("Cirurgia", text: $viewModel.proposedProcedure)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                }
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
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
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
            Section("Equipe Cirúrgica") {
                HStack(alignment: .center){
                    Text("Cirurgião Principal")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    TextField("Cirurgião Principal", text: $viewModel.mainSurgeon)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .focused($isFocusedMS)
                        .onChange(of: isFocusedMS) { _, focused in
                            if !focused {
                                viewModel.mainSurgeon = viewModel.formatName(viewModel.mainSurgeon)
                            }
                        }
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center){
                        Text("Auxiliares")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        HStack(spacing: 8) {
                            TextField("Adicionar Auxiliar", text: $newAuxSurgeon)
                                .multilineTextAlignment(.trailing)
                                .textInputAutocapitalization(.words)
                                .autocorrectionDisabled()
                                .focused($isFocusedAuxInput)
                                .onSubmit {
                                    let trimmed = viewModel.formatName(newAuxSurgeon.trimmingCharacters(in: .whitespacesAndNewlines))
                                    guard !trimmed.isEmpty else { return }
                                    var list = viewModel.auxiliarySurgeons ?? []
                                    list.append(trimmed)
                                    viewModel.auxiliarySurgeons = list
                                    newAuxSurgeon = ""
                                }
                            if !newAuxSurgeon.isEmpty {
                                Button {
                                    let trimmed = viewModel.formatName(newAuxSurgeon.trimmingCharacters(in: .whitespacesAndNewlines))
                                    guard !trimmed.isEmpty else { return }
                                    var list = viewModel.auxiliarySurgeons ?? []
                                    list.append(trimmed)
                                    viewModel.auxiliarySurgeons = list
                                    newAuxSurgeon = ""
                                    isFocusedAuxInput = true
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundStyle(.tint)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel("Adicionar cirurgião auxiliar")
                            }
                        }
                        .frame(maxWidth: 360)
                    }

                    // Lista de cirurgiões auxiliares adicionados
                    if let surgeons = viewModel.auxiliarySurgeons, !surgeons.isEmpty {
                        VStack(alignment: .trailing, spacing: 8) {
                            ForEach(surgeons.indices, id: \.self) { index in
                                let name = surgeons[index]
                                HStack {
                                    Text(name)
                                    Spacer()
                                    Button {
                                        var list = surgeons
                                        list.remove(at: index)
                                        viewModel.auxiliarySurgeons = list.isEmpty ? nil : list
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundStyle(.red)
                                    }
                                    .buttonStyle(.plain)
                                    .accessibilityLabel("Remover cirurgião auxiliar")
                                }
                            }
                        }
                        .padding(.top, 4)
                    }
                }
            }
        }
    }

    // Modo standalone: com NavigationStack próprio e toolbar (Cancelar/Salvar)
    private var standaloneBody: some View {
        NavigationStack {
            formContent
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

    // Modo wizard: apenas o formulário, sem NavigationStack nem toolbar própria
    private var wizardBody: some View {
        formContent
            .onChange(of: viewModel.type) { oldValue, newValue in
                if newValue == .sus {
                    viewModel.insuranceName = "SUS"
                } else if oldValue == .sus && viewModel.insuranceName == "SUS" {
                    viewModel.insuranceName = ""
                }
            }
    }
}


