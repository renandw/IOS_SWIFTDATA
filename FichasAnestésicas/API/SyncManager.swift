import SwiftUI
import SwiftData
import Foundation

@Observable
class SyncManager {
    var isSyncing = false
    var lastSyncDate: Date?
    
    private let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()
    
    private let outboxDecoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()
    
    func sync(context: ModelContext) async {
        print("🔄 SYNC START")
        guard !isSyncing else { return }
        isSyncing = true
        defer { isSyncing = false }

        do {
            // 1️⃣ UPLOAD — process Outbox in FIFO order
            let outboxDescriptor = FetchDescriptor<OutboxOperation>(
                predicate: #Predicate { !$0.isDone },
                sortBy: [SortDescriptor(\.createdAt)]
            )
            let operations = try context.fetch(outboxDescriptor)
            print("📦 Outbox ops:", operations.map { "\($0.type) | \($0.entityId)" })

            var uploadHadFailure = false

            for op in operations {
                do {
                    print("➡️ Processing op:", op.type, op.entityId)
                    switch op.type {
                    case .createPatient:
                        print("🌐 API createPatient")
                        guard let data = op.payloadJSON else { continue }
                        let request = try outboxDecoder.decode(PatientCreateRequest.self, from: data)
                        try await APIService.shared.createPatient(request)

                    case .updatePatient:
                        print("🌐 API updatePatient")
                        guard let data = op.payloadJSON else { continue }

                        struct UpdatePayload: Codable {
                            let cns: String
                            let name: String
                            let birthDate: Date
                            let sex: String
                        }

                        let payload = try outboxDecoder.decode(UpdatePayload.self, from: data)
                        try await APIService.shared.updatePatient(
                            patientId: op.entityId,
                            cns: payload.cns,
                            name: payload.name,
                            birthDate: payload.birthDate,
                            sex: payload.sex
                        )

                    case .deletePatient:
                        print("🌐 API deletePatient")
                        try await APIService.shared.deletePatient(patientId: op.entityId)
                    }

                    op.isDone = true
                    op.lastError = nil
                } catch {
                    print("❌ UPLOAD FAILED on", op.type, op.entityId, "→", error)
                    op.attempts += 1
                    op.lastError = error.localizedDescription
                    op.lastTriedAt = .now
                    uploadHadFailure = true
                    break // stop on first failure (preserves order)
                }
            }

            try context.save()
            if uploadHadFailure {
                print("⏹️ Skipping download because upload failed")
                return
            }

            // 2️⃣ DOWNLOAD — pull server changes
            print("⬇️ DOWNLOAD changes since:", String(describing: lastSyncDate))
            let response = try await APIService.shared.syncPatientsChanges(lastSyncedAt: lastSyncDate)
            print("⬇️ DOWNLOAD received:", response.patients.count, "patients")

            if let serverCursor = isoFormatter.date(from: response.serverTime)
                ?? ISO8601DateFormatter().date(from: response.serverTime) {
                print("⏱️ Advancing cursor to serverTime:", response.serverTime)
                lastSyncDate = serverCursor
            }

            for dto in response.patients {
                let descriptor = FetchDescriptor<Patient>(
                    predicate: #Predicate { $0.patientId == dto.patientId }
                )
                let existing = try? context.fetch(descriptor).first

                if let patient = existing {
                    if dto.lastActivityAt > patient.lastActivityAt {
                        patient.name = dto.name
                        patient.cns = dto.cns
                        patient.birthDate = dto.birthDate
                        patient.sexRaw = dto.sex
                        patient.lastActivityAt = dto.lastActivityAt
                        patient.lastSyncedAt = .now
                    }
                } else {
                    let userDescriptor = FetchDescriptor<User>(
                        predicate: #Predicate { $0.userId == dto.createdByUserId }
                    )
                    guard let creator = try? context.fetch(userDescriptor).first else { continue }

                    let newPatient = Patient(
                        patientId: dto.patientId,
                        cns: dto.cns,
                        name: dto.name,
                        birthDate: dto.birthDate,
                        sexRaw: dto.sex,
                        createdBy: creator,
                        createdAt: dto.createdAt,
                        updatedAt: dto.updatedAt,
                        lastActivityAt: dto.lastActivityAt,
                        lastSyncedAt: .now
                    )

                    context.insert(newPatient)
                }
            }

            try context.save()

        } catch {
            print("🔥 SYNC ABORTED:", error)
        }
    }
}
