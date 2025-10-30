import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var patientContext
    @Query(sort: \Patient.name) private var patient: [Patient]
    
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil
    
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()
    
    
    init(session: SessionManager) {
        let uid = session.currentUser?.userId ?? ""
        _patient = Query(filter: #Predicate<Patient> {
            $0.createdBy.userId == uid
        })
    }
    
    var body: some View {
        List(patient) { patient in
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
                    selectedPatient: $selectedPatient
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
            Button("Adicionar Paciente", systemImage: "plus") {
                editingPatient = nil
                showingForm = true
            }
            .buttonStyle(.glassProminent)
        }
    }
}
