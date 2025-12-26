//
//  migrationoncology.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/12/25.
//

import SwiftData

@MainActor
func migrateInfantIfNeeded(context: ModelContext) throws {

    print("🚀 Starting manual InfantDetail migration")

    let fetch = FetchDescriptor<PreAnesthesia>()
    let all = try context.fetch(fetch)

    print("🔍 Found \(all.count) PreAnesthesia records")

    for pre in all {

        let surgeryId = pre.surgery.surgeryId
        print("➡️ Checking PreAnesthesia for surgery:", surgeryId)

        // já migrado
        if let details = pre.infantDetails, !details.isEmpty {
            print("⏭️ Already migrated, skipping")
            continue
        }

        let hasOldEnums =
            pre.isInfantComorbitiesDetails?.isEmpty == false
        let hasOldCustom =
            pre.isInfantComorbitiesDetails?.isEmpty == false

        if !hasOldEnums && !hasOldCustom {
            print("⚠️ No old InfantDetail data, skipping")
            continue
        }

        print("🧬 Old InfantDetail data found")

        var details: [InfantDetail] = []
        let notes = pre.isInfantDetailsText

        // enums antigos
        if let raws = pre.isInfantComorbitiesDetailsRaw {
            for raw in raws {
                if let type = InfantComorbities(rawValue: raw) {
                    print("   ➕ enum:", type.rawValue)
                    details.append(
                        InfantDetail(
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
        if let customs = pre.isInfantCustomDetails {
            for name in customs {
                print("   ➕ custom:", name)
                details.append(
                    InfantDetail(
                        customName: name,
                        notes: notes
                    )
                )
            }
        }

        if details.isEmpty {
            print("⚠️ No valid infant details created")
            continue
        }

        pre.infantDetails = details
        print("✅ Migrated \(details.count) infant items")
    }

    try context.save()
    print("💾 infant finished and saved")
}
