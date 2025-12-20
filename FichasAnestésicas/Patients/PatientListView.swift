import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var patientContext
    @Query(sort: \Patient.name) private var patient: [Patient]
    
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil
    
    @State private var patientSearchText = ""
    
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()
    
    var filteredPatients: [Patient] {
        if patientSearchText.isEmpty {
            return patient
        }
        return patient.filter { $0.name.localizedCaseInsensitiveContains(patientSearchText) }
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
            } else {
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
        .onChange(of: selectedPatient) { _, newPatient in
            if let patient = newPatient {
                // Paciente foi selecionado da lista de duplicatas
                // Aqui você pode fazer o que quiser com ele
                // Por exemplo: navegar para detalhes, mostrar um toast, etc.
                print("✅ Paciente selecionado: \(patient.name)")
                
                // Limpa a seleção após processar
                selectedPatient = nil
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
        }
    }
    
    private func handleDelete(at indexSet: IndexSet) {
        guard let user = session.currentUser else { return }
        let repository = SwiftDataPatientRepository(context: patientContext, currentUser: user)
        for index in indexSet {
            let p = patient[index]
            do {
                try repository.delete(p)
            } catch {
                // You may replace this with an alert/toast if you have one
                print("Erro ao excluir paciente: \(error)")
            }
        }
    }
}

