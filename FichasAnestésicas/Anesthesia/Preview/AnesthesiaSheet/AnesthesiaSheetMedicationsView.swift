//
//  AnesthesiaSheetMedicationsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI
import Foundation

struct AnesthesiaSheetMedicationsView: View {
    var anesthesia: Anesthesia

    private var combinedMedicationsText: Text {
        
        func itemText(_ m: MedicationEntry) -> String {
            let time = m.timestamp.formatted(date: .omitted, time: .shortened)
            return "\(m.name) \(m.dose) (\(time))"
        }

        var bucketVR: [MedicationEntry] = []
        var bucketCristaloide: [MedicationEntry] = []
        var bucketHemoderivados: [MedicationEntry] = []
        var bucketEV: [MedicationEntry] = []
        var otherByRoute: [AdministrationRoute: [MedicationEntry]] = [:]
        var otherByRouteOrder: [AdministrationRoute] = [] // preserve first-seen order

        for m in anesthesia.medications.sorted(by: { $0.timestamp < $1.timestamp }) {
            
            if m.via == .VR {
                bucketVR.append(m)
                continue
            }
            
            if m.category == .cristalóide {
                bucketCristaloide.append(m)
                continue
            }
            
            if m.category == .hemoderivados {
                bucketHemoderivados.append(m)
                continue
            }
            
            if m.via == .EV {
                bucketEV.append(m)
                continue
            }
            
            if otherByRoute[m.via] == nil {
                otherByRoute[m.via] = []
                otherByRouteOrder.append(m.via)
            }
            otherByRoute[m.via]?.append(m)
        }

        
        var segments: [Text] = []

        func makeSegment(title: String, items: [MedicationEntry]) -> Text? {
            guard !items.isEmpty else { return nil }
            let joinedItems = items.map { itemText($0) }.joined(separator: ", ")
            return Text("\(Text(title).bold()): \(joinedItems)")
        }

        if let t = makeSegment(title: AdministrationRoute.VR.label, items: bucketVR) { segments.append(t) }
        if let t = makeSegment(title: MedicationCategory.cristalóide.label, items: bucketCristaloide) { segments.append(t) }
        if let t = makeSegment(title: MedicationCategory.hemoderivados.label, items: bucketHemoderivados) { segments.append(t) }
        if let t = makeSegment(title: AdministrationRoute.EV.label, items: bucketEV) { segments.append(t) }

        
        let predefined: [AdministrationRoute] = [.IM, .IT, .PD, .PN, .SC, .SL, .IN, .TOP, .VO]
        var consumed: Set<AdministrationRoute> = []
        for route in predefined {
            if let items = otherByRoute[route], !items.isEmpty {
                if let t = makeSegment(title: route.label, items: items) { segments.append(t) }
                consumed.insert(route)
            }
        }
        
        for route in otherByRouteOrder where !consumed.contains(route) {
            if let items = otherByRoute[route], !items.isEmpty {
                if let t = makeSegment(title: route.label, items: items) { segments.append(t) }
            }
        }

        
        if segments.isEmpty { return Text("") }
        let joinedText = segments.enumerated().reduce(Text("")) { acc, pair in
            let (index, segment) = pair
            return index == 0 ? segment : Text("\(acc); \(segment)")
        }
        return joinedText
    }
    
    
    var body: some View {
        
        
            VStack(spacing: 0) {
                // Title
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)
                    Text("MEDICAÇÕES E FLUIDOS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    Spacer()
                }
                .background(Color.gray.opacity(0.2))
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    combinedMedicationsText
                        .font(.system(size: 10))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .fixedSize(horizontal: false, vertical: true)
        }
}
