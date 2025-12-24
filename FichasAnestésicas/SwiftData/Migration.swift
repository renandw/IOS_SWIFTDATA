import SwiftData
import Foundation

// MARK: - Schema V1 (antes de oncologyDetails)

enum SchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [
            User.self,
            Patient.self,
            Surgery.self,
            PreAnesthesia.self,
            Anesthesia.self,
            CbhpmProcedure.self,
            Financial.self
        ]
    }
}

// MARK: - Schema V2 (com oncologyDetails)

enum SchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 1)

    static var models: [any PersistentModel.Type] {
        [
            User.self,
            Patient.self,
            Surgery.self,
            PreAnesthesia.self,
            OncologyComorbidityDetail.self,
            Anesthesia.self,
            CbhpmProcedure.self,
            Financial.self
        ]
    }
}

// MARK: - Migration Plan

enum PreAnesthesiaMigrationPlan: SchemaMigrationPlan {

    static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self, SchemaV2.self]
    }

    static var stages: [MigrationStage] {
        [
            .custom(
                fromVersion: SchemaV1.self,
                toVersion: SchemaV2.self,
                willMigrate: { context in
                    print("🔥 MIGRATION RAN: PreAnesthesia oncology")

                    let all = try context.fetch(
                        FetchDescriptor<PreAnesthesia>()
                    )

                    for pre in all {

                        // idempotência
                        if pre.oncologyDetails != nil {
                            continue
                        }

                        var details: [OncologyComorbidityDetail] = []
                        let notes = pre.oncologyComorbitiesDetailsText

                        // enums antigos
                        if let raws = pre.oncologyComorbitiesDetailsRaw {
                            for raw in raws {
                                if let type = OncologicComorbidities(rawValue: raw) {
                                    details.append(
                                        OncologyComorbidityDetail(
                                            type: type,
                                            notes: notes
                                        )
                                    )
                                }
                            }
                        }

                        // customs antigos
                        if let customs = pre.oncologyComorbitiesCustomDetails {
                            for name in customs {
                                details.append(
                                    OncologyComorbidityDetail(
                                        customName: name,
                                        notes: notes
                                    )
                                )
                            }
                        }

                        if !details.isEmpty {
                            pre.oncologyDetails = details
                        }
                    }
                },
                didMigrate: nil
            )
        ]
    }
}
