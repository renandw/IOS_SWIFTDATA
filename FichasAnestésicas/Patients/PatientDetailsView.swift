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
                HStack {
                    Text("CNS")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Birth Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.birthDate, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("CreatedAt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("CreatedBy")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdBy.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let updatedBy = patient.updatedBy {
                    HStack {
                        Text("UpdatedBy")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedBy.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                if let updatedAt = patient.updatedAt {
                    HStack {
                        Text("UpdatedAt")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedAt, format: dateStyle)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Last Activity")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.lastActivityAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("PatientId")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.patientId)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                HStack {
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
            }
        }
        .navigationTitle(patient.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingSurgeryForm = true
                } label: {
                    Label("Adicionar Cirurgia", systemImage: "plus")
                }
                .tint(.blue)
            
            }
        }
        .sheet(isPresented: $showingSurgeryForm) {
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
            let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
            let viewModel = SurgeryFormViewModel(patient: patient, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
            SurgeryFormView(viewModel: viewModel)
        }
        .sheet(item: $selectedSurgery) { surgery in
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
            let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
            let viewModel = SurgeryFormViewModel(patient: patient, surgery: surgery, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
            SurgeryFormView(viewModel: viewModel)
        }
    }
}

