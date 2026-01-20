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
            patientSection
            surgerySection
            medicalTeamSection
            financialSection
            anesthesiaSection
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
    
    private var patientSection: some View {
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
                HStack(spacing: 8){
                    Text("Carteirinha")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button {
                        UIPasteboard.general.string = surgery.insuranceNumber
                    } label: {
                        Image(systemName: "doc.on.doc")
                    }
                    Text(surgery.insuranceNumber)
                        .fontWeight(.semibold)
                }
            }
        } header : {
            HStack{
                Text("Dados do Paciente")
                    .foregroundStyle(.green)
                Spacer()
                NavigationLink {
                    PatientDetailsView(patient: surgery.patient)
                } label: {
                    Image(systemName: surgery.patient.sex.sexImage)
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.glass)
                .tint(surgery.patient.sex.sexColor)
            }
            
        }
    }
    private var surgerySection: some View {
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
            HStack {
                Text("Códigos")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(surgery.cbhpmProcedures?.count ?? 0)")
                    .fontWeight(.semibold)
            }
            if let cbhpmProcedures = surgery.cbhpmProcedures, !cbhpmProcedures.isEmpty {
                ForEach(Array(cbhpmProcedures.sorted(by: { $0.port > $1.port }).enumerated()), id: \.offset) { _, item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Porte Anestésico:")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Text(item.port)
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(item.code)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
//                        .padding(.horizontal, 6)
//                        .padding(.vertical, 8)
//                        .background(.ultraThinMaterial)
                        HStack(alignment: .top, spacing: 6) {
                            Text(item.procedure)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 2)
                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 6)

                }
            }
        } header: {
            HStack{
                Text("Cirurgia")
                    .foregroundStyle(.green)
                Text("-")
                    .foregroundStyle(.green)
                Text(surgery.date.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.green)
                Spacer()
                NavigationLink {
                    SurgeryMetadataView(surgery: surgery)
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.glass)
                .tint(.green)
            }
        }
    }
    private var medicalTeamSection: some View {
        Section {
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
        } header: {
            HStack {
                Text("Equipe Médica")
                    .foregroundStyle(.green)
            }
        }
    }
    private var financialSection: some View {
        Group {
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
                        Button {
                            showingFinancialForm = true
                        } label: {
                            HStack {
                                Spacer()
                                Text("Adicionar Dados Financeiros")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                                Spacer()
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Dados Financeiros")
                            .foregroundStyle(.green)
                        Spacer()
                        NavigationLink {
                            FinancialView(surgery: surgery)
                        } label: {
                            Image(systemName: "brazilianrealsign.circle")
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.glass)
                        .tint(.green)
                    }
                }
            }
        }
    }
    private var anesthesiaSection: some View {
        Group {
            if let anesthesia = surgery.anesthesia {
                Section {
                    HStack {
                        NavigationLink {
                            AnesthesiaDetailsView(anesthesia: anesthesia)
                        } label: {
                            HStack {
                                Text("Detalhes da Ficha Anestésica")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    if anesthesia.status == .finished {
                        HStack {
                            ShareLink(item: anesthesia.renderAnesthesiaPDF()) {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 16, weight: .regular))
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.purple)
                                    Text("Exportar Ficha Anestésica")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    Spacer()
                                }
                            }
                            .buttonStyle(.glass)
                        }
                    }
                } header : {
                    HStack {
                        Text("Anestesia")
                            .foregroundStyle(.purple)
                    }
                }
            } else {
                Section {
                    Button {
                        showingAnesthesiaForm = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Iniciar Ficha Anestésica")
                                .fontWeight(.bold)
                                .foregroundStyle(.purple)
                            Spacer()
                        }
                    }
                } header : {
                    HStack {
                        Text("Anestesia")
                            .foregroundStyle(.purple)
                    }
                }
            }
            if let preanesthesia = surgery.preanesthesia {
                Section {
                    NavigationLink {
                        PreAnesthesiaForSurgeryView(preanesthesia: preanesthesia)
                    } label: {
                        HStack {
                            Spacer()
                            Text("Detalhes da Avaliação Pré Anestesia")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }

                    if let anesthesia = surgery.anesthesia,
                       preanesthesia.status == .finished {
                        ShareLink(item: anesthesia.renderPreAnesthesiaPDF()) {
                            HStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.purple)
                                Text("Exportar Avaliação Pré-Anestésica")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.purple)
                                Spacer()
                            }
                        }
                    }
                } header: {
                    Text("Avaliação Pré-Anestésica - APA")
                        .foregroundStyle(.purple)
                }
            } else {
                Section {
                    Button {
                        presentNewForm()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Iniciar APA")
                                .fontWeight(.bold)
                                .foregroundStyle(.purple)
                            Spacer()
                        }
                    }
                } header: {
                    Text("Avaliação Pré-Anestésica - APA")
                        .foregroundStyle(.purple)
                }
            }
        }
    }
    
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

#Preview("Lista com samples") {
    let user = User.sampleUser
    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let cbhpm = CbhpmProcedure.samples(surgeries: surgeries)
    let financial = Financial.samples(surgeries: surgeries)
    let anesthesia = Anesthesia.samples(surgeries: surgeries, user: user)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let preanesthesia = PreAnesthesia.samples(surgeries: surgeries, shared: shared, user: user)


    let session = SessionManager()
    session.currentUser = user

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self, Patient.self, Surgery.self,
        configurations: config
    )
    let context = container.mainContext

    // Preload uma única vez
    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }
        financial.forEach { context.insert($0) }
        cbhpm.forEach { context.insert($0) }
        anesthesia.forEach { context.insert($0) }
        preanesthesia.forEach { context.insert($0) }
        try! context.save()
    }

    // Escolhe um paciente aleatório
    let randomPatient = patients.randomElement()!

    // Filtra apenas cirurgias do paciente aleatório que possuem anesthesia
    let surgeriesWithAnesthesiaForPatient = surgeries.filter { $0.patient.id == randomPatient.id && $0.anesthesia != nil }

    // Se o paciente não tiver cirurgias com anesthesia, tenta globalmente
    let surgeriesWithAnesthesia = surgeries.filter { $0.anesthesia != nil }

    // Escolhe uma cirurgia com anesthesia (primeiro do paciente, senão global)
    guard let randomSurgery = (surgeriesWithAnesthesiaForPatient.randomElement() ?? surgeriesWithAnesthesia.randomElement()) else {
        fatalError("Nenhuma cirurgia com anesthesia disponível nas amostras do preview.")
    }

    return NavigationStack {
        SurgeryDetailsView(surgery: randomSurgery)
            .environment(session)
    }
    .modelContainer(container)
}
