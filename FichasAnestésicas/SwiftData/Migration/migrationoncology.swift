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
//func migrateAirwayIfNeeded(context: ModelContext) throws {
//
//    print("🚀 Starting manual Airway migration")
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
//        if let details = pre.difficultAirwayDetails, !details.isEmpty {
//            print("⏭️ Already migrated, skipping")
//            continue
//        }
//
//        let hasOldEnums =
//            pre.difficultAirwayEvaluation?.isEmpty == false
//        let hasOldCustom =
//            pre.difficultAirwayEvaluation?.isEmpty == false
//
//        if !hasOldEnums && !hasOldCustom {
//            print("⚠️ No old Airway data, skipping")
//            continue
//        }
//
//        print("🧬 Old Airway data found")
//
//        var details: [DifficultAirwayDetail] = []
//        let notes = pre.difficultAirwayEvaluationDetailsText
//
//        // enums antigos
//        if let raws = pre.difficultAirwayEvaluationRaw {
//            for raw in raws {
//                if let type = DifficultAirwayEvaluation(rawValue: raw) {
//                    print("   ➕ enum:", type.rawValue)
//                    details.append(
//                        DifficultAirwayDetail(
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
//        if let customs = pre.difficultAirwayEvaluationCustomDetails {
//            for name in customs {
//                print("   ➕ custom:", name)
//                details.append(
//                    DifficultAirwayDetail(
//                        customName: name,
//                        notes: notes
//                    )
//                )
//            }
//        }
//
//        if details.isEmpty {
//            print("⚠️ No valid Airway details created")
//            continue
//        }
//
//        pre.difficultAirwayDetails = details
//        print("✅ Migrated \(details.count) Airway items")
//    }
//
//    try context.save()
//    print("💾 Airway finished and saved")
//}
