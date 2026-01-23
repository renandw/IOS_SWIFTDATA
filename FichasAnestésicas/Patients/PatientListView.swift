import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(SessionManager.self) var session
    @Environment(SyncManager.self) var syncManager
    @Environment(\.modelContext) private var patientContext
    @Query(sort: \Patient.name) private var patient: [Patient]
    
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil
    
    @State private var sortOrder: SortOrder = .recent
    
    @State private var patientSearchText = ""
    
    enum SortOrder {
        case alphabetical, recent
    }
    
    var filteredPatients: [Patient] {
        let userFiltered = patient.filter {
            $0.createdBy.userId == (session.currentUser?.userId ?? "")
        }
        
        let searchFiltered = patientSearchText.isEmpty
        ? userFiltered
        : userFiltered.filter { $0.name.localizedStandardContains(patientSearchText) }
        
        
        // Finalmente ordena
        switch sortOrder {
        case .alphabetical:
            return searchFiltered.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case .recent:
            return searchFiltered.sorted { $0.lastActivityAt > $1.lastActivityAt }
        }
    }
    
    var body: some View {
        List {
            
                if patient.isEmpty {
                    ContentUnavailableView(
                        "Nenhum Paciente",
                        systemImage: "person.2.slash",
                        description: Text("Toque em + para adicionar o primeiro paciente.")
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                } else if filteredPatients.isEmpty {
                    ContentUnavailableView(
                        "Nenhum Resultado",
                        systemImage: "magnifyingglass",
                        description: Text("Nenhum paciente encontrado para '\(patientSearchText)'")
                    )
                } else {
                    Section {
                        ForEach(filteredPatients) { patient in
                            NavigationLink {
                                PatientDetailsView(patient: patient)
                            } label: {
                                PatientRowView(
                                    patient: patient,
                                    numberCnsContext: .notNeeded,
                                    ageContext: .outSurgery
                                )
                                .contentShape(Rectangle())
                            }
                        }
                        .onDelete { indexSet in
                            handleDelete(at: indexSet)
                        }
                    } header: {
                        HStack {
                            Text("Total")
                            Text("\(filteredPatients.count)")
                        }
                }
            }
        }
        .searchable(text: $patientSearchText, placement: .toolbar, prompt: "Buscar paciente")
        .navigationTitle("Pacientes")
        .sheet(isPresented: $showingForm) {
            if let user = session.currentUser {
                let repository = SwiftDataPatientRepository(
                    context: patientContext,
                    currentUser: user,
                    syncManager: syncManager
                )
                PatientFormView(
                    viewModel: PatientFormViewModel(
                        repository: repository,
                        currentUser: user,
                        editingPatient: editingPatient
                    ),
                    selectedPatient: $selectedPatient,
                    mode: .standalone
                    
                )
            } else {
                ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    editingPatient = nil
                    showingForm = true
                } label: {
                    Label("Adicionar Paciente", systemImage: "plus")
                }
                .tint(.blue)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Alfabética") { sortOrder = .alphabetical }
                    Button("Recentes") { sortOrder = .recent }
                } label: {
                    Label("Ordenar", systemImage: "arrow.up.arrow.down")
                }
                .tint(.blue)
            }
        }
    }
    private func handleDelete(at indexSet: IndexSet) {
        guard let user = session.currentUser else { return }
        let repository = SwiftDataPatientRepository(
            context: patientContext,
            currentUser: user,
            syncManager: syncManager
        )
        for index in indexSet {
            let p = filteredPatients[index]
            do {
                try repository.delete(p)
            } catch {
                print("Erro ao excluir paciente: \(error)")
            }
        }
    }
}

#Preview("Lista vazia") {
    let user = User.sampleUser
    let session = SessionManager()
    session.currentUser = user

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self, Patient.self,
        configurations: config
    )
    let context = container.mainContext
    
    // Insere apenas o usuário, SEM pacientes
    context.insert(user)
    try! context.save()

    return NavigationStack {
        PatientListView()
            .environment(session)
    }
    .modelContainer(container)
}

#Preview("Lista com samples") {
    let user = User.sampleUser
    let patients = Patient.samples(createdBy: user)
    let session = SessionManager()
    session.currentUser = user

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self, Patient.self,
        configurations: config
    )
    let context = container.mainContext

    context.insert(user)
    patients.forEach { context.insert($0) }
    try! context.save()

    return NavigationStack {
        PatientListView()
            .environment(session)
    }
    .modelContainer(container)
}
