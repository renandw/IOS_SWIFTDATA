//
//  AnesthesiaDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftUI

struct AnesthesiaDetailsView: View {
    @Bindable var anesthesia: Anesthesia

    var body: some View {
        VStack(alignment: .leading) {
            Text("Método: \(anesthesia.shared?.techniques)")
            
            Text("Asa: \(anesthesia.shared?.asa)")
            Text("lastactivity: \(anesthesia.surgery.patient.lastActivityAt)")
            Text("Surgerylastactivity: \(anesthesia.surgery.lastActivityAt)")
            Text("Status: \(anesthesia.status?.displayName)")
            Text("Start: \(anesthesia.start)")
            Text("End: \(anesthesia.end)")
            Text("Position: \(anesthesia.position)")
            Text("SurgeryStart: \(anesthesia.surgery.start)")
            Text("SurgeryEnd: \(anesthesia.surgery.end)")
        }
        .padding()
        .navigationTitle("Detalhes da Anestesia")
    }
}
