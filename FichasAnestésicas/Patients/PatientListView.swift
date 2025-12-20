import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(SessionManager.self) var session
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
        let filtered = patientSearchText.isEmpty
            ? patient
            : patient.filter { $0.name.localizedCaseInsensitiveContains(patientSearchText) }
        
        switch sortOrder {
        case .alphabetical:
            return filtered.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case .recent:
            return filtered.sorted { $0.lastActivityAt > $1.lastActivityAt }
        }
    }
    
    
    init(session: SessionManager) {
        let uid = session.currentUser?.userId ?? ""
        _patient = Query(filter: #Predicate<Patient> {
            $0.createdBy.userId == uid
        })
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
                let repository = SwiftDataPatientRepository(context: patientContext, currentUser: user)
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
                    Label("Sair", systemImage: "arrow.up.arrow.down")
                }
            }
        }
    }
    private func handleDelete(at indexSet: IndexSet) {
        guard let user = session.currentUser else { return }
        let repository = SwiftDataPatientRepository(context: patientContext, currentUser: user)
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

