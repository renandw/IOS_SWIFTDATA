import SwiftUI
import SwiftData

struct PatientListView: View {
    let userId: String
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var patientContext
    @Query(sort: \Patient.name) private var patients: [Patient]
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil  // NOVO
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()
    
    init(userId: String) {
        self.userId = userId
        _patients = Query(
            filter: #Predicate<Patient> { $0.createdBy.userId == userId },
            sort: [SortDescriptor(\.name)]
        )
    }

    var body: some View {
        if let user = session.currentUser {
            NavigationStack {
                List(patients, id: \.patientId) { patient in
                    NavigationLink(destination: try? PatientDetailsView(patientId: patient.patientId, context: patientContext)) {
                        PatientRowView(patient: patient, ageContext: .outSurgery)
                    }
                    .contextMenu {
                        Button("Editar") {
                            editingPatient = patient
                            showingForm = true
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Editar") {
                            editingPatient = patient
                            showingForm = true
                        }.tint(.blue)
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
            }
            .toolbar {
                Button("Adicionar Paciente", systemImage: "plus") {
                    editingPatient = nil
                    showingForm = true
                }
                .buttonStyle(.glassProminent)
            }
        } else {
            ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
        }
    }
}

