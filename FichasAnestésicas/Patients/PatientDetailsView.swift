import SwiftUI
import SwiftData


struct PatientDetailsView: View {
    @Bindable var patient: Patient

    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingSurgeryForm = false
    @State private var selectedSurgery: Surgery?
    
    @State private var showingPatientForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil

    @State private var showDeleteAlert = false
    @State private var deleteErrorMessage: String? = nil
    
    init(patient: Patient) {
        self._patient = Bindable(wrappedValue: patient)
        _editingPatient = State(initialValue: patient)
        _selectedPatient = State(initialValue: patient)
    }
    var age: String {
        AgeContext.outSurgery.ageLongString(from: patient.birthDate)
    }

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Nome")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.name)
                        .fontWeight(.semibold)
                }
                if patient.cns != "000000000000000" {
                    HStack {
                        Text("CNS")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Nascimento")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.birthDate.formatted(date: .abbreviated, time: .omitted))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Idade (hoje)")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(age)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Sexo")
                        .foregroundStyle(.secondary)
                    Spacer()
                    HStack(spacing: 8) {
                        Image(systemName: patient.sex.sexImage)
                            .foregroundColor(patient.sex.sexColor)
                            .font(.system(size: 16, weight: .regular))
                            .frame(width: 20, height: 20)
                        Text(patient.sex.sexStringDescription)
                            .fontWeight(.semibold)
                    }
                }
            } header: {
                HStack{
                    Text("Informações do Paciente")
                    Spacer()
                    NavigationLink {
                        MetadataView(patient: patient)
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .regular))
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(.glass)
                    .tint(.blue)
                }
            }
            
            Section {
                if patient.surgeries == [] {
                    Text("Nenhuma cirurgia registrada.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(patient.surgeries ?? []) { surgery in
                        NavigationLink(surgery.proposedProcedure) {
                            SurgeryDetailsView(surgery: surgery)
                        }
                        .swipeActions {
                            Button("Editar") {
                                selectedSurgery = surgery
                            }
                        }
                    }
                }
            } header : {
                HStack{
                    Text("Cirurgias")
                    Spacer()
                    Button{
                        showingSurgeryForm = true
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 20, height: 20)
                            Text("Nova cirurgia")
                                .fontWeight(.semibold)
                                
                        }
                    }
                    .buttonStyle(.glass)
                    .tint(.green)
                }
            }
        }
        .navigationTitle(patient.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu("Opções", systemImage: "line.3.horizontal") {
                    Button("Editar paciente", systemImage: "pencil") {
                        editingPatient = patient
                        selectedPatient = patient
                        showingPatientForm = true
                    }
                    
                    Button("Excluir paciente", systemImage: "trash", role: .destructive) {
                        showDeleteAlert = true
                    }
                }
                
            }
        }
        .sheet(isPresented: $showingSurgeryForm) {
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
            let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
            let viewModel = SurgeryFormViewModel(patient: patient, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
            SurgeryFormView(viewModel: viewModel, mode: .standalone)
        }
        .sheet(item: $selectedSurgery) { surgery in
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
            let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
            let viewModel = SurgeryFormViewModel(patient: patient, surgery: surgery, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
            SurgeryFormView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingPatientForm) {
            if let user = session.currentUser {
                let repository = SwiftDataPatientRepository(context: modelContext, currentUser: user)
                PatientFormView(
                    viewModel: PatientFormViewModel(
                        repository: repository,
                        currentUser: user,
                        editingPatient: editingPatient
                    ),
                    selectedPatient: $selectedPatient,
                    mode: .standalone
                )
            }
        }
        .alert("Excluir paciente?", isPresented: $showDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Excluir", role: .destructive) {
                guard let user = session.currentUser else { return }
                let repository = SwiftDataPatientRepository(context: modelContext, currentUser: user)
                do {
                    try repository.delete(patient)
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
}

struct MetadataView: View {
    @Bindable var patient: Patient
    
    var body: some View {
        List {
            Section("Metadados") {
                HStack {
                    Text("Criado em")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Criado por")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.createdBy.name)
                        .fontWeight(.semibold)
                }
                if let updatedAt = patient.updatedAt {
                    HStack {
                        Text("Atualizado em")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(updatedAt.formatted(date: .abbreviated, time: .shortened))
                            .fontWeight(.semibold)
                    }
                }
                if let updatedBy = patient.updatedBy {
                    HStack {
                        Text("Atualizado por")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(updatedBy.name)
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Última Atualização")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.lastActivityAt.formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("ID")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(patient.patientId)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .navigationTitle(patient.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



#Preview("Lista com samples") {
    // Usa o mesmo usuário dos samples para que o filtro por userId funcione
    let samples = Patient.samplePatients
    let randomIndex = Int.random(in: 1...103)
    let patient = samples[randomIndex]
    let sampleUser = samples.first?.createdBy
    let session = SessionManager()
    session.currentUser = sampleUser

    // Container SwiftData em memória e preload com samples
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Patient.self, User.self, configurations: config)
    let context = container.mainContext

    // Insere os samples apenas uma vez
    if try! context.fetch(FetchDescriptor<Patient>()).isEmpty {
        for p in samples { context.insert(p) }
        try! context.save()
    }

    return NavigationStack {
        PatientDetailsView(patient: patient)
            .environment(session)
    }
    .modelContainer(container)
}
