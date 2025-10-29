import SwiftUI
import SwiftData

struct PatientDetailsView: View {
    let patient: Patient

    init(patientId: String, context: ModelContext) throws {
        let descriptor = FetchDescriptor<Patient>(
            predicate: #Predicate { $0.patientId == patientId },
            sortBy: []
        )
        if let found = try context.fetch(descriptor).first {
            self.patient = found
        } else {
            throw NSError(domain: "PatientDetailsView", code: 404, userInfo: [NSLocalizedDescriptionKey: "Patient not found"])
        }
    }

    init(userId: String, patientId: String, context: ModelContext) throws {
        try self.init(patientId: patientId, context: context)
    }
    
    private let dateStyle: Date.FormatStyle = .dateTime.year().month().day()
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading, spacing: 16) {
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
            }
            .navigationTitle(patient.name)
        }
    }
}

#Preview {
    // Uncomment and replace with a real Patient instance if available
    // PatientDetailsView(patient: Patient.mock)
    Text("PatientDetailsView Preview - Provide a Patient instance to preview")
}
