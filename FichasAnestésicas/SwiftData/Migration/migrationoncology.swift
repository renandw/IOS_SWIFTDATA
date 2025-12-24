//
//  migrationoncology.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/12/25.
//

import SwiftData

@MainActor
func migrateRespiratoryIfNeeded(context: ModelContext) throws {

    print("🚀 Starting manual respiratory migration")

    let fetch = FetchDescriptor<PreAnesthesia>()
    let all = try context.fetch(fetch)

    print("🔍 Found \(all.count) PreAnesthesia records")

    for pre in all {

        let surgeryId = pre.surgery.surgeryId
        print("➡️ Checking PreAnesthesia for surgery:", surgeryId)

        // já migrado
        if let details = pre.respiratoryDetails, !details.isEmpty {
            print("⏭️ Already migrated, skipping")
            continue
        }

        let hasOldEnums =
            pre.respiratoryComorbitiesDetailsRaw?.isEmpty == false
        let hasOldCustom =
            pre.respiratoryComorbitiesCustomDetails?.isEmpty == false

        if !hasOldEnums && !hasOldCustom {
            print("⚠️ No old respiratory data, skipping")
            continue
        }

        print("🧬 Old respiratory data found")

        var details: [RespiratoryComorbidityDetail] = []
        let notes = pre.respiratoryComorbitiesDetailsText

        // enums antigos
        if let raws = pre.respiratoryComorbitiesDetailsRaw {
            for raw in raws {
                if let type = RespiratoryComorbities(rawValue: raw) {
                    print("   ➕ enum:", type.rawValue)
                    details.append(
                        RespiratoryComorbidityDetail(
                            type: type,
                            notes: notes
                        )
                    )
                } else {
                    print("   ❌ invalid enum rawValue:", raw)
                }
            }
        }

        // customs antigos
        if let customs = pre.respiratoryComorbitiesCustomDetails {
            for name in customs {
                print("   ➕ custom:", name)
                details.append(
                    RespiratoryComorbidityDetail(
                        customName: name,
                        notes: notes
                    )
                )
            }
        }

        if details.isEmpty {
            print("⚠️ No valid respiratory details created")
            continue
        }

        pre.respiratoryDetails = details
        print("✅ Migrated \(details.count) respiratory items")
    }

    try context.save()
    print("💾 Respiratory migration finished and saved")
}
