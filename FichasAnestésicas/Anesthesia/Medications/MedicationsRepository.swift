
import SwiftData
import Foundation


protocol MedicationEntryRepository {
    func get(by id: String) -> MedicationEntry?
    func getAll(for anesthesia: Anesthesia) -> [MedicationEntry]
    func create(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws
    func update(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws
    func delete(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws
    func deleteAll(for anesthesia: Anesthesia, by user: User) throws
}

final class SwiftDataMedicationEntryRepository: MedicationEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func get(by id: String) -> MedicationEntry? {
        let descriptor = FetchDescriptor<MedicationEntry>(
            predicate: #Predicate { $0.medicationId == id }
        )
        return try? context.fetch(descriptor).first
    }

    func getAll(for anesthesia: Anesthesia) -> [MedicationEntry] {
        let aid = anesthesia.anesthesiaId
        let descriptor = FetchDescriptor<MedicationEntry>(
            predicate: #Predicate { $0.anesthesia.anesthesiaId == aid },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func create(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws {
        anesthesia.medications.append(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        context.insert(entry)
        try context.save()
    }

    func update(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws {
        entry.timestamp = entry.timestamp // força o SwiftData detectar alteração
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func delete(_ entry: MedicationEntry, for anesthesia: Anesthesia, by user: User) throws {
        context.delete(entry)
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }

    func deleteAll(for anesthesia: Anesthesia, by user: User) throws {
        let entries = getAll(for: anesthesia)
        for e in entries { context.delete(e) }
        anesthesia.updatedAt = Date()
        anesthesia.updatedBy = user
        anesthesia.surgery.lastActivityAt = Date()
        try context.save()
    }
}
