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
//func migrateGastroIntestinalIfNeeded(context: ModelContext) throws {
//
//    print("🚀 Starting manual GastroIntestinal migration")
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
//        if let details = pre.gastroIntestinalDetails, !details.isEmpty {
//            print("⏭️ Already migrated, skipping")
//            continue
//        }
//
//        let hasOldEnums =
//            pre.gastrointestinalComorbitiesDetailsRaw?.isEmpty == false
//        let hasOldCustom =
//            pre.gastrointestinalComorbitiesCustomDetails?.isEmpty == false
//
//        if !hasOldEnums && !hasOldCustom {
//            print("⚠️ No old GastroIntestinal data, skipping")
//            continue
//        }
//
//        print("🧬 Old GastroIntestinal data found")
//
//        var details: [GastroIntestinalComorbidityDetail] = []
//        let notes = pre.gastrointestinalComorbitiesDetailsText
//
//        // enums antigos
//        if let raws = pre.gastrointestinalComorbitiesDetailsRaw {
//            for raw in raws {
//                if let type = GastrointestinalComorbities(rawValue: raw) {
//                    print("   ➕ enum:", type.rawValue)
//                    details.append(
//                        GastroIntestinalComorbidityDetail(
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
//        if let customs = pre.gastrointestinalComorbitiesCustomDetails {
//            for name in customs {
//                print("   ➕ custom:", name)
//                details.append(
//                    GastroIntestinalComorbidityDetail(
//                        customName: name,
//                        notes: notes
//                    )
//                )
//            }
//        }
//
//        if details.isEmpty {
//            print("⚠️ No valid GastroIntestinal details created")
//            continue
//        }
//
//        pre.gastroIntestinalDetails = details
//        print("✅ Migrated \(details.count) GastroIntestinal items")
//    }
//
//    try context.save()
//    print("💾 GastroIntestinal migration finished and saved")
//}
