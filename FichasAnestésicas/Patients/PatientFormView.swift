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
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PatientFormViewModel
    @State private var isSaving = false
    
    // Binding para retornar o paciente selecionado
    @Binding var selectedPatient: Patient?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nome", text: $viewModel.name)

                    TextField("CNS", text: $viewModel.cns)
                        .keyboardType(.numberPad)

                    DatePicker("Nascimento",
                               selection: $viewModel.birthDate,
                               displayedComponents: .date)

                    Picker("Sexo", selection: $viewModel.sex) {
                        ForEach(Sex.allCases, id: \.self) { sex in
                            Text(sex == .male ? "Masculino" : "Feminino")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
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
                        dismiss()
                    },
                    onSelect: { patient in
                        viewModel.selectExisting(patient)
                        selectedPatient = patient
                        dismiss()
                    },
                    onUpdate: { patient in
                        try? viewModel.updateExisting(patient)
                        dismiss()
                    }
                )
            }
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
            PatientRowView(patient: patient, ageContext: .outSurgery)
            
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
