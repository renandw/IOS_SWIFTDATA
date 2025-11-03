//
//  IdentificationView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 03/11/25.
//

import SwiftUI

struct IdentificationView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    let patient: Patient
    let surgery: Surgery
    
    @State private var showingAnesthesiaForm = false
    
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
            
            
            Button(surgery.anesthesia == nil ? "Criar Anestesia" : "Editar Anestesia", systemImage: "plus") {
                showingAnesthesiaForm = true
            }
            .buttonStyle(.glassProminent)
            
        }
        .sheet(isPresented: $showingAnesthesiaForm) {
            if let currentUser = session.currentUser {
                let viewModel = AnesthesiaFormViewModel(
                    surgery: surgery,
                    user: currentUser,
                    context: modelContext,
                )
                AnesthesiaFormView(viewModel: viewModel)
            }
        }
    }
}
