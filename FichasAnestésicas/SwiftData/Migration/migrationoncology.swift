////
////  migrationoncology.swift
////  FichasAnestésicas
////
////  Created by Renan Wrobel on 24/12/25.
////
//
//import SwiftData
//
//@MainActor
//func migrateOncologyIfNeeded(context: ModelContext) throws {
//
//    print("🚀 Starting manual oncology migration")
//
//    let fetch = FetchDescriptor<PreAnesthesia>()
//    let all = try context.fetch(fetch)
//
//    print("🔍 Found \(all.count) PreAnesthesia records")
//
//    for pre in all {
//
//        let surgeryId = pre.surgery.surgeryId
//        print("➡️ Checking PreAnesthesia for surgery:", surgeryId)
//
//        // já migrado
//        if let details = pre.oncologyDetails, !details.isEmpty {
//            print("⏭️ Already migrated, skipping")
//            continue
//        }
//
//        let hasOldEnums =
//            pre.oncologyComorbitiesDetailsRaw?.isEmpty == false
//        let hasOldCustom =
//            pre.oncologyComorbitiesCustomDetails?.isEmpty == false
//
//        if !hasOldEnums && !hasOldCustom {
//            print("⚠️ No old oncology data, skipping")
//            continue
//        }
//
//        print("🧬 Old oncology data found")
//
//        var details: [OncologyComorbidityDetail] = []
//        let notes = pre.oncologyComorbitiesDetailsText
//
//        // enums antigos
//        if let raws = pre.oncologyComorbitiesDetailsRaw {
//            for raw in raws {
//                if let type = OncologicComorbidities(rawValue: raw) {
//                    print("   ➕ enum:", type.rawValue)
//                    details.append(
//                        OncologyComorbidityDetail(
//                            type: type,
//                            notes: notes
//                        )
//                    )
//                } else {
//                    print("   ❌ invalid enum rawValue:", raw)
//                }
//            }
//        }
//
//        // customs antigos
//        if let customs = pre.oncologyComorbitiesCustomDetails {
//            for name in customs {
//                print("   ➕ custom:", name)
//                details.append(
//                    OncologyComorbidityDetail(
//                        customName: name,
//                        notes: notes
//                    )
//                )
//            }
//        }
//
//        if details.isEmpty {
//            print("⚠️ No valid oncology details created")
//            continue
//        }
//
//        pre.oncologyDetails = details
//        print("✅ Migrated \(details.count) oncology items")
//    }
//
//    try context.save()
//    print("💾 Oncology migration finished and saved")
//}
