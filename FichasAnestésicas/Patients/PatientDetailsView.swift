import SwiftUI
import SwiftData


struct PatientDetailsView: View {
    @Bindable var patient: Patient
    
    @Environment(\.modelContext) private var modelContext

    
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()

    var body: some View {
        List {
            Section("Dados do Paciente") {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Name")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("CNS")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Birth Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.birthDate, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("CreatedAt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("CreatedBy")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.createdBy.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                if let updatedBy = patient.updatedBy {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("UpdatedBy")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedBy.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                if let updatedAt = patient.updatedAt {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("UpdatedAt")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(updatedAt, format: dateStyle)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last Activity")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.lastActivityAt, format: dateStyle)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("PatientId")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(patient.patientId)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 4) {
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
                    NavigationLink(surgery.surgeryId) {
                        SurgeryDetailsView(surgery: surgery)
                    }
                }
            }
        }
        .toolbar {
            Button("Adicionar Cirurgia", systemImage: "plus") {
                addSurgery()
                
            }
        }
    }
    
    private func addSurgery() { let now = Date(); let surgery = Surgery( surgeryId: UUID().uuidString, date: now, createdBy: "Renan Dantas Wrobel", createdAt: now, lastActivityAt: now, insuranceName: "Unimed", insuranceNumber: "1234123412341234", mainSurgeon: "Dr. Eliakim", hospital: "Hospital 9 de Julho", weight: 75, proposedProcedure: "Colecistectomia VLP", statusRaw: "Concluída", typeRaw: "convenio", patient: patient ); modelContext.insert(surgery) }
}
