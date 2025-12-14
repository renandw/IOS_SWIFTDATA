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
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedSurgery: Surgery?
    @State private var showingSurgeryForm = false
    
    @State private var showingFinancialForm = false
    @State private var showingAnesthesiaForm = false
    
    @State private var isPresentingForm = false
    @State private var formViewModel: PreAnesthesiaViewModel?
    
    @State private var showDeleteAlert = false
    @State private var deleteErrorMessage: String? = nil
    
    var age: String {
        AgeContext.inSurgery(surgery).ageLongString(from: surgery.patient.birthDate)
    }
    
    var body: some View {
        List {
            Section{
                HStack{
                    Text("Nome")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.patient.name)
                        .fontWeight(.semibold)
                }
                HStack{
                    Text("Idade")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(age)
                        .fontWeight(.semibold)
                    Spacer()
                    Spacer()
                    Text("Peso")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(surgery.weight, specifier: "%.1f")")
                        .fontWeight(.semibold)
                    Text("kg")
                        .fontWeight(.semibold)
                }
                HStack{
                    if surgery.insuranceName == "SUS" {
                        Text("Número SUS")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                            .fontWeight(.semibold)
                        
                    } else {
                        Text("Convênio")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.insuranceName)
                            .fontWeight(.semibold)
                    }
                }
                if surgery.insuranceName == "SUS" {
                    HStack {
                        Text("Prontuário")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.insuranceNumber)
                            .fontWeight(.semibold)
                    }
                } else if surgery.insuranceName != "Particular" {
                    HStack {
                        Text("Carteirinha")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.insuranceNumber)
                            .fontWeight(.semibold)
                    }
                }
            } header : {
                HStack{
                    Text("Dados do Paciente")
                    Spacer()
                    NavigationLink {
                        PatientDetailsView(patient: surgery.patient)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .buttonStyle(.glass)
                }
                
            }
            Section{
                HStack{
                    Text("Cirurgia Proposta")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.proposedProcedure)
                        .fontWeight(.semibold)
                }
                HStack{
                    Text("Hospital")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.hospital)
                        .fontWeight(.semibold)
                }
            } header: {
                HStack{
                    Text("Cirurgia")
                    Text("-")
                    Text(surgery.date.formatted(date: .abbreviated, time: .omitted))
                    Spacer()
                    NavigationLink {
                        SurgeryMetadataView(surgery: surgery)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .buttonStyle(.glass)
                }
            }
            
            Section("Equipe Médica"){
                HStack{
                    Text("Anestesiologista")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.createdBy.name)
                        .fontWeight(.semibold)
                }
                HStack{
                    Text("Cirurgião Principal")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.mainSurgeon)
                        .fontWeight(.semibold)
                }
                if let auxiliarySurgeons = surgery.auxiliarySurgeons, !auxiliarySurgeons.isEmpty {
                    ForEach(auxiliarySurgeons, id: \.self) { aux in
                        HStack{
                            Text("Cirurgião Auxiliar")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(aux)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            if surgery.type == .convenio {
                Section {
                    if let financial = surgery.financial {
                        if let valueAnesthesia = financial.finalSurgeryValue {
                            HStack{
                                Text("Valor Anestesia")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(valueAnesthesia, format: .currency(code: "BRL"))
                                    .fontWeight(.semibold)
                            }
                        }
                    } else {
                        Button("Adicionar Valores") {
                            showingFinancialForm = true
                        }
                    }
                } header: {
                    HStack {
                        Text("Dados Financeiros")
                        Spacer()
                        NavigationLink {
                            FinancialView(surgery: surgery)
                        } label: {
                            Image(systemName: "brazilianrealsign.circle")
                        }
                        .buttonStyle(.glass)
                    }
                }
            }
            if let anesthesia = surgery.anesthesia {
                Section {
                    HStack {
                        NavigationLink {
                            AnesthesiaDetailsView(anesthesia: anesthesia)
                        } label: {
                            Text("Detalhes da Ficha Anestésica")
                                .fontWeight(.bold)
                        }
                    }
                    HStack {
                        ShareLink(item: anesthesia.renderAnesthesiaPDF()) {
                            Label("Ficha Anestésica", systemImage: "square.and.arrow.up.fill")
                        }
                        .buttonStyle(.glass)
                    }
                } header : {
                    HStack {
                        Text("Anestesia")
                    }
                }
            } else {
                Button("Cadastrar Anestesia") {
                    showingAnesthesiaForm = true
                }
            }
            if let preanesthesia = surgery.preanesthesia {
                Section {
                    HStack {
                        NavigationLink {
                            PreAnesthesiaForSurgeryView(preanesthesia: preanesthesia)
                        } label: {
                            Text("Detalhes da Avaliação Pré Anestesia")
                                .fontWeight(.bold)
                        }
                    }
                    if let anesthesia = surgery.anesthesia {
                            HStack {
                                ShareLink(item: anesthesia.renderPreAnesthesiaPDF()) {
                                    Label("Ficha APA", systemImage: "square.and.arrow.up.fill")
                                }
                            }
                        }
                } header : {
                    HStack {
                        Text("Avaliação Pré Anestésica")
                    }
                }
            } else {
                if let preanesthesia = surgery.preanesthesia {
                    Button("Editar Avaliação Pré Anestésica") {
                        presentEditForm(for: preanesthesia)
                    }
                } else {
                    Button("Criar Avaliação Pré Anestésica") {
                        presentNewForm()
                    }
                }
            }
        }
        .navigationTitle(surgery.surgeryId)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu("Opções", systemImage: "line.3.horizontal") {
                    Button("Editar Cirurgia") {
                        selectedSurgery = surgery
                    }
                    Button("Excluir Cirurgia", role: .destructive){
                        showDeleteAlert = true
                    }
                }
            }
        }
        
        .sheet(item: $selectedSurgery) { surgery in
            let repository = SwiftDataSurgeryRepository(
                context: modelContext,
                currentUser: session.currentUser!
            )
            let financialRepository = SwiftDataFinancialRepository(
                context: modelContext,
                currentUser: session.currentUser!
            )
            let procedureRepository = SwiftDataCbhpmProcedureRepository(
                context: modelContext
            )
            let viewModel = SurgeryFormViewModel(
                patient: surgery.patient,
                surgery: surgery,
                repository: repository,
                financialRepository: financialRepository,
                procedureRepository: procedureRepository,
                modelContext: modelContext
            )
            SurgeryFormView(
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $showingAnesthesiaForm) {
            if let currentUser = session.currentUser {
                let viewModel = AnesthesiaFormViewModel(
                    surgery: surgery,
                    user: currentUser,
                    context: modelContext,
                )
                AnesthesiaFormView(viewModel: viewModel, mode: .standalone)
            }
        }
        .sheet(item: $formViewModel) { vm in
            PreAnesthesiaFormView(viewModel: vm)
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
        
        .alert("Excluir Cirurgia?", isPresented: $showDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Excluir", role: .destructive) {
                guard let user = session.currentUser else { return }
                let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: user)
                do {
                    try repository.delete(surgery)
                    dismiss()
                } catch {
                    deleteErrorMessage = "Falha ao excluir: \(error.localizedDescription)"
                }
            }
        } message: {
            Text("Esta ação não pode ser desfeita.")
        }
        .alert("Erro", isPresented: .constant(deleteErrorMessage != nil), presenting: deleteErrorMessage) { _ in
            Button("OK", role: .cancel) { deleteErrorMessage = nil }
        } message: { msg in
            Text(msg)
        }
    }
    
    // MARK: - Helpers
    
    private func presentNewForm() {
        // Ajuste a forma de obter o usuário conforme a API real do seu SessionManager
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                newFor: surgery,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
    
    private func presentEditForm(for preanesthesia: PreAnesthesia) {
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                preanesthesia: preanesthesia,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
}

struct SurgeryMetadataView: View {
    @Bindable var surgery: Surgery
    
    var body: some View {
        List {
            Section("Metadados") {
                if surgery.start != nil {
                    HStack {
                        Text("Iniciado em")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.start?.formatted(date: .abbreviated, time: .shortened) ?? "")
                            .fontWeight(.semibold)
                    }
                }
                if surgery.end != nil {
                    HStack {
                        Text("Iniciado em")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(surgery.end?.formatted(date: .abbreviated, time: .shortened) ?? "")
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Criado em")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Criado por")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.createdBy.name)
                        .fontWeight(.semibold)
                }
                if let updatedBy = surgery.updatedBy {
                    HStack {
                        Text("Atualizado por")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(updatedBy.name)
                            .fontWeight(.semibold)
                    }
                }
                if let updatedAt = surgery.updatedAt {
                    HStack {
                        Text("Atualizado em")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(updatedAt.formatted(date: .abbreviated, time: .shortened))
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Últimas Atualização")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.lastActivityAt.formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("ID")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.surgeryId)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Status")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.status.displayName)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Tipo")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(surgery.type.rawValue)
                        .fontWeight(.semibold)
                }
            }
            .navigationTitle(surgery.surgeryId)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

