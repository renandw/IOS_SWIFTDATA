import SwiftUI
import SwiftData


struct PatientDetailsView: View {
    @Bindable var patient: Patient

    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingSurgeryForm = false
    @State private var selectedSurgery: Surgery?

    
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()

    var body: some View {
        List {
            Section("Dados do Paciente") {
                HStack {
                    Text("Name")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("CNS")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("Birth Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.birthDate, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("CreatedAt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("CreatedBy")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdBy.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let updatedBy = patient.updatedBy {
                    VStack(alignment: .leading) {
                        Text("UpdatedBy")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedBy.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                if let updatedAt = patient.updatedAt {
                    VStack(alignment: .leading) {
                        Text("UpdatedAt")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedAt, format: dateStyle)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Last Activity")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.lastActivityAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("PatientId")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.patientId)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading) {
                    Text("Sex")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 8) {
                        Image(systemName: patient.sex.sexImage)
                            .foregroundColor(patient.sex.sexColor)
                        Text(patient.sex.sexStringDescription)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
            Section("Lista de Cirurgias") {
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
                .sheet(item: $selectedSurgery) { surgery in
                    let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
                    let viewModel = SurgeryFormViewModel(patient: patient, surgery: surgery, repository: repository)
                    SurgeryFormView(viewModel: viewModel)
                }
            }
        }
        .toolbar {
            Button("Adicionar Cirurgia", systemImage: "plus") {
                showingSurgeryForm = true
            }
        }
        .sheet(isPresented: $showingSurgeryForm) {
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let viewModel = SurgeryFormViewModel(patient: patient, repository: repository)
            SurgeryFormView(viewModel: viewModel)
        }
    }
    
    private func addSurgery() {
        guard let currentUser = session.currentUser else {
            // Handle missing user appropriately (e.g., show an alert or return)
            return
        }
        let now = Date()
        let surgery = Surgery(
            surgeryId: UUID().uuidString,
            date: now,
            createdBy: currentUser,
            createdAt: now,
            lastActivityAt: now,
            insuranceName: "Unimed",
            insuranceNumber: "1234123412341234",
            mainSurgeon: "Dr. Eliakim",
            hospital: "Hospital 9 de Julho",
            weight: 75,
            proposedProcedure: "Colecistectomia VLP",
            statusRaw: Status.finished.rawValue,
            typeRaw: SurgeryType.convenio.rawValue,
            patient: patient
        )
        modelContext.insert(surgery)
        try? modelContext.save()
    }
}

