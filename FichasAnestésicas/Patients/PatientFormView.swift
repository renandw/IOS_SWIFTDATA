struct PatientFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PatientFormViewModel
    @State private var isSaving = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nome", text: $viewModel.name)

                    TextField("CNS", text: $viewModel.cns)
                        .keyboardType(.numberPad)
                        // TODO: aplicar máscara e validação CNS

                    DatePicker("Nascimento",
                               selection: $viewModel.birthDate,
                               displayedComponents: .date)

                    Picker("Sexo", selection: $viewModel.sex) {
                        ForEach(Sex.allCases, id: \.self) { sex in
                            Text(sex == .male ? "Masculino" : "Feminino")
                        }
                    }
                    .pickerStyle(.segmented) // ou .inline
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
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid || isSaving)
                }
            }
        }
    }
}

private extension PatientFormViewModel {
    var isEditing: Bool { editingPatient != nil }
}