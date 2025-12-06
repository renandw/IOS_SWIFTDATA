//
//  FinancialView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/12/25.
//

import SwiftUI

struct FinancialView: View {
    @Bindable var surgery: Surgery
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingFinancialForm = false
    
    var body: some View {
        List {
            if let financial = surgery.financial {
                Section {
                    if let valueAnesthesia = financial.valueAnesthesia {
                        HStack{
                            Text("Valor Anestesia")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(valueAnesthesia, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                        }
                    }
                    if let valueGlosedAnesthesia = financial.glosedAnesthesiaValue {
                        HStack{
                            Text("Valor Glosado Anesthesia")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(valueGlosedAnesthesia, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.red)
                        }
                    }
                    if let valuePreAnesthesia = financial.valuePreAnesthesia {
                        HStack{
                            Text("Valor Avaliação Pré-Anestésica")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(valuePreAnesthesia, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                        }
                    }
                    if let valueGlosedPreAnesthesia = financial.glosedPreAnesthesiaValue {
                        HStack{
                            Text("Valor Glosado Anesthesia")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(valueGlosedPreAnesthesia, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.red)
                        }
                    }
                    if let taxedValue = financial.taxedValue {
                        HStack{
                            Text("Impostos")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(taxedValue, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.red)
                        }
                    }
                } header: {
                    HStack{
                        Text("Valores Brutos")
                    }
                }
                if let valueSurgery = financial.finalSurgeryValue {
                    Section {
                        HStack{
                            Text("Valor Cirurgia")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(valueSurgery, format: .currency(code: "BRL"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.green)
                        }
                    } header : {
                        HStack{
                            Text("Valor Líquido")
                            Spacer()
                            Button("Editar Valores") {
                                showingFinancialForm = true
                            }
                        }
                    }
                }
                Section {
                    if financial.paid {
                        HStack {
                            Text("Pagamento")
                            Spacer()
                            Text("Pago")
                                .fontWeight(.semibold)
                                .foregroundStyle(.green)
                        }
                        if let payDay = financial.paymentDate {
                            HStack {
                                Text("Data")
                                Spacer()
                                Text(payDay.formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    } else {
                        HStack {
                            Text("Pagamento")
                            Spacer()
                            Text("Pendente")
                                .fontWeight(.semibold)
                                .foregroundStyle(.yellow)
                        }
                    }
                }
                
            } else {
                Button("Adicionar Valores") {
                    showingFinancialForm = true
                }
            }
        }
        .navigationTitle("Financeiro")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Editar Valores", systemImage: "brazilianrealsign.circle") {
                    showingFinancialForm = true
                }
            }
        }
        .sheet(isPresented: $showingFinancialForm) {
            if let currentUser = session.currentUser {
                let repository = SwiftDataFinancialRepository(context: modelContext, currentUser: currentUser)
                let viewModel = FinancialFormViewModel(
                    surgery: surgery,
                    financial: surgery.financial,
                    repository: repository
                )
                FinancialFormView(viewModel: viewModel)
            }
        }
    }
}
