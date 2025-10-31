//
//  SurgeryDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/10/25.
//
import SwiftData
import SwiftUI

struct SurgeryDetailsView: View {
    @Bindable var surgery: Surgery
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingFinancialForm = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Tipo: \(surgery.type)")
            Text("Criado por: \(surgery.createdBy.name)")
            VStack(alignment: .leading, spacing: 4) {
                Text("CBHPM")
                    .font(.headline)
                if let procedures = surgery.cbhpmProcedures, !procedures.isEmpty {
                    ForEach(procedures) { p in
                        Text("\(p.code) - \(p.procedure) (\(p.port))")
                            .font(.subheadline)
                    }
                } else {
                    Text("Nenhum procedimento selecionado")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
            if let f = surgery.financial {
                HStack(spacing: 8) {
                    Text("Financeiro:")
                        .fontWeight(.semibold)
                    Text(f.paid ? "Pago" : "Pendente")
                    if let final = f.finalSurgeryValue {
                        Text("• Valor final: \(final, format: .currency(code: "BRL"))")
                    }
                }
            } else {
                Text("Financeiro: não cadastrado")
                    .foregroundStyle(.secondary)
            }
            Text("Data: \(surgery.date.formatted(date: .abbreviated, time: .omitted))")
            
            Spacer()
        }
        .toolbar {
            Button("Adicionar Financeiro", systemImage: "plus") {
                showingFinancialForm = true
            }
        }
        .sheet(isPresented: $showingFinancialForm) {
            if let currentUser = session.currentUser {
                let repository = SwiftDataFinancialRepository(context: modelContext, currentUser: currentUser)
                let viewModel = FinancialFormViewModel(
                    surgery: surgery,
                    financial: surgery.financial, // Se já existe, edita; senão, cria
                    repository: repository
                )
                FinancialFormView(viewModel: viewModel)
            }
        }
        .padding()
        .navigationTitle("Detalhes da Cirurgia")
    }
}
