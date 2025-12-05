//
//  PatientFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 27/10/25.
//
import Foundation
import SwiftData
import SwiftUI

struct PatientFormView: View {
    enum Mode {
        case standalone   // usado como sheet isolado
        case wizard       // usado dentro do fluxo NewAnesthesiaView
    }

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PatientFormViewModel
    @State private var isSaving = false
    
    @FocusState private var isFocused: Bool
    
    
    // Binding para retornar o paciente selecionado
    @Binding var selectedPatient: Patient?
    
    // Modo de funcionamento da view (padrão mantém o comportamento atual)
    var mode: Mode = .standalone

    var body: some View {
        switch mode {
        case .standalone:
            standaloneBody
        case .wizard:
            wizardBody
        }
    }

    // Conteúdo comum do formulário (campos)
    private var formContent: some View {
        Form {
            Section(
                header:
                    HStack{
                        Image(systemName: "person")
                        Text("Identificação do Paciente")
                    }
                    .foregroundStyle(.blue),
                footer:
                    Text("Use 000 0000 0000 0000, se CNS desconhecido")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
            ) {
                HStack(alignment: .center){
                    Text("Nome")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    TextField("John Appleseed", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .focused($isFocused)
                        .onChange(of: isFocused) { _, focused in
                            if !focused {
                                viewModel.name = viewModel.formatName(viewModel.name)
                            }
                        }
                }
                HStack(alignment: .center){
                    Text("Número SUS")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    TextField("000 0000 0000 0000", text: Binding(
                        get: { viewModel.formatCNS(viewModel.cns) },
                        set: { newValue in
                            viewModel.cns = newValue.filter { $0.isNumber }
                        }
                    ))
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.cns) { _, newValue in
                        if newValue.count > 15 {
                            viewModel.cns = String(newValue.prefix(15))
                        }
                    }
                    .multilineTextAlignment(.trailing)
                }
                HStack(alignment: .center){
                    Text("Data de Nascimento")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    OnlyDatePickerSheetButton(
                        date: Binding<Date?>(
                            get: { viewModel.birthDate },
                            set: { viewModel.birthDate = $0 ?? viewModel.birthDate }
                        ),
                        title: "Data de Nascimento",
                        placeholder: "Selecionar",
                        minDate: nil,
                        maxDate: Date(),
                        compactInRow: true
                    )
                }
                HStack(alignment: .center){
                    Text("Sexo")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Picker("Sexo", selection: $viewModel.sex) {
                        ForEach(Sex.allCases, id: \.self) { sex in
                            Text(sex == .male ? "Masculino" : "Feminino")
                        }
                    }
                    .frame(maxWidth: 230)
                }
                .pickerStyle(.segmented)
            }
        }
    }

    // Modo sheet standalone (com navegação própria e dismiss)
    private var standaloneBody: some View {
        NavigationStack {
            formContent
                .navigationTitle(viewModel.isEditing ? "Editar Paciente" : "Novo Paciente")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar") {
                            Task {
                                isSaving = true
                                try? viewModel.save()
                                isSaving = false
                                
                                // Se salvou com sucesso, fecha
                                if viewModel.saveSuccess {
                                    // expõe o paciente resolvido (novo/selecionado/atualizado)
                                    selectedPatient = viewModel.resolvedPatient
                                    dismiss()
                                }
                            }
                        }
                        .disabled(!viewModel.isValid || isSaving)
                    }
                }
                .sheet(isPresented: $viewModel.showDuplicateSheet) {
                    DuplicatePatientSheet(
                        message: viewModel.duplicateMessage,
                        foundPatients: viewModel.foundPatients,
                        onCreateNew: {
                            try? viewModel.forceCreateNew()
                            selectedPatient = viewModel.resolvedPatient
                            dismiss()
                        },
                        onSelect: { patient in
                            viewModel.selectExisting(patient)
                            selectedPatient = patient
                            dismiss()
                        },
                        onUpdate: { patient in
                            try? viewModel.updateExisting(patient)
                            selectedPatient = viewModel.resolvedPatient
                            dismiss()
                        }
                    )
                }
        }
    }

    // Modo wizard: sem dismiss da view, apenas resolve o paciente
    private var wizardBody: some View {
        formContent
            .sheet(isPresented: $viewModel.showDuplicateSheet) {
                DuplicatePatientSheet(
                    message: viewModel.duplicateMessage,
                    foundPatients: viewModel.foundPatients,
                    onCreateNew: {
                        try? viewModel.forceCreateNew()
                        selectedPatient = viewModel.resolvedPatient
                        // Não faz dismiss() aqui; o fluxo/wizard decide avançar ou fechar
                    },
                    onSelect: { patient in
                        viewModel.selectExisting(patient)
                        selectedPatient = patient
                        // Sem dismiss do formulário
                    },
                    onUpdate: { patient in
                        try? viewModel.updateExisting(patient)
                        selectedPatient = viewModel.resolvedPatient
                        // Sem dismiss do formulário
                    }
                )
            }
    }
}

// MARK: - Duplicate Patient Sheet

struct DuplicatePatientSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let message: String
    let foundPatients: [Patient]
    let onCreateNew: () -> Void
    let onSelect: (Patient) -> Void
    let onUpdate: (Patient) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header com mensagem
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.orange)
                    
                    Text(message)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGroupedBackground))
                
                // Lista de pacientes encontrados
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(foundPatients, id: \.patientId) { patient in
                            PatientDuplicateCard(
                                patient: patient,
                                onSelect: { onSelect(patient) },
                                onUpdate: { onUpdate(patient) }
                            )
                        }
                    }
                    .padding()
                }
                
                // Botão criar novo (fixo no rodapé)
                VStack(spacing: 0) {
                    Divider()
                    
                    Button(role: .destructive) {
                        onCreateNew()
                    } label: {
                        Label("Criar Novo Mesmo Assim", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color(.systemBackground))
                }
            }
            .navigationTitle("Pacientes Encontrados")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Patient Duplicate Card

struct PatientDuplicateCard: View {
    let patient: Patient
    let onSelect: () -> Void
    let onUpdate: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            PatientRowView(patient: patient, numberCnsContext: .needed, ageContext: .outSurgery)
            
            // Botões de ação
            HStack(spacing: 12) {
                // Botão primário - Selecionar
                Button {
                    onSelect()
                } label: {
                    Text("Selecionar Existente")
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                
                // Botão secundário - Atualizar
                Button {
                    onUpdate()
                } label: {
                    Text("Atualizar")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

