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
//func migrateSurgeryIfNeeded(context: ModelContext) throws {
//
//    print("🚀 Starting manual anesthesiaHistoric migration")
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
//        if let details = pre.anesthesiaHistoricDetails, !details.isEmpty {
//            print("⏭️ Already migrated, skipping")
//            continue
//        }
//
//        let hasOldEnums =
//            pre.anesthesiaHistoryDetails?.isEmpty == false
//        let hasOldCustom =
//            pre.anesthesiaHistoryDetails?.isEmpty == false
//
//        if !hasOldEnums && !hasOldCustom {
//            print("⚠️ No old anesthesiaHistoric data, skipping")
//            continue
//        }
//
//        print("🧬 Old anesthesiaHistoric data found")
//
//        var details: [AnesthesiaHistoryDetail] = []
//        let notes = pre.anesthesiaHistoryDetailsText
//
//        // enums antigos
//        if let raws = pre.anesthesiaHistoryDetailsRaw {
//            for raw in raws {
//                if let type = AnesthesiaComplicationsHistory(rawValue: raw) {
//                    print("   ➕ enum:", type.rawValue)
//                    details.append(
//                        AnesthesiaHistoryDetail(
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
//        if let customs = pre.anesthesiaHistoryCustomDetails {
//            for name in customs {
//                print("   ➕ custom:", name)
//                details.append(
//                    AnesthesiaHistoryDetail(
//                        customName: name,
//                        notes: notes
//                    )
//                )
//            }
//        }
//
//        if details.isEmpty {
//            print("⚠️ No valid anesthesiaHistoric details created")
//            continue
//        }
//
//        pre.anesthesiaHistoricDetails = details
//        print("✅ Migrated \(details.count) anesthesiaHistoric items")
//    }
//
//    try context.save()
//    print("💾 anesthesiaHistoric finished and saved")
//}
