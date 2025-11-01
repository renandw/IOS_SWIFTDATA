//
//  FinancialFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//


import SwiftUI
import SwiftData

// Parâmetros necessários:
// - viewModel: FinancialFormViewModel (contém surgery + financial opcional + repository)
//
// Pode ser chamada de:
// - SurgeryDetailsView (sheet ou navigation)
// - Tela de relatórios financeiros
// - Dashboard financeiro

struct FinancialFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: FinancialFormViewModel
    @State private var isSaving = false
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Valores
                Section("Valores") {
                    HStack {
                        Text("Anestesia")
                        Spacer()
                        TextField("Valor", value: $viewModel.valueAnesthesia, format: .currency(code: "BRL"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Pré-anestesia")
                        Spacer()
                        TextField("Valor", value: $viewModel.valuePreAnesthesia, format: .currency(code: "BRL"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Valor Final")
                        Spacer()
                        Text(viewModel.calculatedFinalValue, format: .currency(code: "BRL"))
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                // MARK: - Glosas
                Section("Glosas") {
                    Toggle("Glosa Anestesia", isOn: Binding(
                        get: { viewModel.glosaAnesthesia ?? false },
                        set: { viewModel.glosaAnesthesia = $0 }
                    ))
                    
                    if viewModel.glosaAnesthesia == true {
                        HStack {
                            Text("Valor Glosado")
                            Spacer()
                            TextField("Valor", value: $viewModel.glosedAnesthesiaValue, format: .currency(code: "BRL"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Toggle("Glosa Pré-anestesia", isOn: Binding(
                        get: { viewModel.glosaPreanesthesia ?? false },
                        set: { viewModel.glosaPreanesthesia = $0 }
                    ))
                    
                    if viewModel.glosaPreanesthesia == true {
                        HStack {
                            Text("Valor Glosado")
                            Spacer()
                            TextField("Valor", value: $viewModel.glosedPreAnesthesiaValue, format: .currency(code: "BRL"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                
                // MARK: - Pagamento
                Section("Pagamento") {
                    Toggle("Pago", isOn: $viewModel.paid)
                    
                    if viewModel.paid {
                        DatePicker("Data de Pagamento",
                                   selection: Binding(
                                    get: { viewModel.paymentDate ?? Date() },
                                    set: { viewModel.paymentDate = $0 }
                                   ),
                                   displayedComponents: .date)
                    }
                    
                    DatePicker("Data de Faturamento",
                               selection: Binding(
                                get: { viewModel.billingDate ?? Date() },
                                set: { viewModel.billingDate = $0 }
                               ),
                               displayedComponents: .date)
                }
                
                // MARK: - Impostos
                Section("Impostos") {
                    HStack {
                        Text("Percentual (%)")
                        Spacer()
                        TextField("", value: $viewModel.taxPercentage, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Valor do Imposto")
                        Spacer()
                        TextField("Valor", value: $viewModel.taxedValue, format: .currency(code: "BRL"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                // MARK: - Observações
                Section("Observações") {
                    TextField("Notas", 
                              text: Binding(
                                get: { viewModel.notes ?? "" },
                                set: { viewModel.notes = $0.isEmpty ? nil : $0 }
                              ),
                              axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle(viewModel.isEditing ? "Editar Financeiro" : "Adicionar Financeiro")
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
                            
                            if viewModel.saveSuccess {
                                dismiss()
                            }
                        }
                    }
                    .disabled(isSaving)
                }
            }
        }
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Patient.self, Surgery.self, User.self, Financial.self, configurations: config)
//    let context = container.mainContext
//    
//    // Mock User
//    let user = User(
//        userId: "user-1",
//        name: "Dr. Preview",
//        crm: "12345-SP",
//        rqe: nil,
//        phone: nil,
//        emailAddress: "preview@test.com"
//    )
//    context.insert(user)
//    
//    // Mock Patient
//    let patient = Patient(
//        patientId: "patient-1",
//        cns: "123456789012345",
//        name: "João da Silva",
//        birthDate: Date(),
//        sex: .male,
//        createdBy: user
//    )
//    context.insert(patient)
//    
//    // Mock Surgery
//    let surgery = Surgery(
//        surgeryId: "C-2025-12345",
//        date: Date(),
//        createdBy: user,
//        createdAt: Date(),
//        lastActivityAt: Date(),
//        insuranceName: "Unimed",
//        insuranceNumber: "123456",
//        mainSurgeon: "Dr. Silva",
//        hospital: "Hospital 9 de Julho",
//        weight: 70,
//        proposedProcedure: "Apendicectomia",
//        statusRaw: Status.scheduled.rawValue,
//        typeRaw: SurgeryType.convenio.rawValue,
//        patient: patient
//    )
//    context.insert(surgery)
//    
//    // Mock Repository
//    let repository = SwiftDataFinancialRepository(context: context, currentUser: user)
//    
//    // ViewModel
//    let viewModel = FinancialFormViewModel(surgery: surgery, repository: repository)
//    
//    FinancialFormView(viewModel: viewModel)
//        .modelContainer(container)
//}

