//
//  migrationoncology.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/12/25.
//

import SwiftData

@MainActor
func migrateSurgeryIfNeeded(context: ModelContext) throws {

    print("🚀 Starting manual surgeryHistoric migration")

    let fetch = FetchDescriptor<PreAnesthesia>()
    let all = try context.fetch(fetch)

    print("🔍 Found \(all.count) PreAnesthesia records")

    for pre in all {

        let surgeryId = pre.surgery.surgeryId
        print("➡️ Checking PreAnesthesia for surgery:", surgeryId)

        // já migrado
        if let details = pre.surgeryHistoricDetails, !details.isEmpty {
            print("⏭️ Already migrated, skipping")
            continue
        }

        let hasOldEnums =
            pre.surgeryHistoryDetails?.isEmpty == false
        let hasOldCustom =
            pre.surgeryHistoryDetails?.isEmpty == false

        if !hasOldEnums && !hasOldCustom {
            print("⚠️ No old surgeryHistoric data, skipping")
            continue
        }

        print("🧬 Old surgeryHistoric data found")

        var details: [SurgeryHistoryDetail] = []
        let notes = pre.surgeryHistoryDetailsText

        // enums antigos
        if let raws = pre.surgeryHistoryDetailsRaw {
            for raw in raws {
                if let type = SurgeryHistorySpeciality(rawValue: raw) {
                    print("   ➕ enum:", type.rawValue)
                    details.append(
                        SurgeryHistoryDetail(
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
        if let customs = pre.surgeryHistoryCustomDetails {
            for name in customs {
                print("   ➕ custom:", name)
                details.append(
                    SurgeryHistoryDetail(
                        customName: name,
                        notes: notes
                    )
                )
            }
        }

        if details.isEmpty {
            print("⚠️ No valid surgeryHistoric details created")
            continue
        }

        pre.surgeryHistoricDetails = details
        print("✅ Migrated \(details.count) surgeryHistoric items")
    }

    try context.save()
    print("💾 surgeryHistoric finished and saved")
}
