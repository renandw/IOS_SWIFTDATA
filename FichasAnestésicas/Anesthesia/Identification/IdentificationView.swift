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
    let ageContext: AgeContext
    
    @State private var showingAnesthesiaForm = false
    @State private var selectedSurgery: Surgery?
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("Paciente: \(anesthesia.surgery.patient.name)")
            Text("Idade: \(ageContext.ageString(from: anesthesia.surgery.patient.birthDate))")
            Text("Asa: \(anesthesia.shared?.asa)")
            Text("lastactivity: \(anesthesia.surgery.patient.lastActivityAt)")
            Text("Surgerylastactivity: \(anesthesia.surgery.lastActivityAt)")
            Text("Status: \(anesthesia.status?.displayName)")
            Text("Start: \(anesthesia.start)")
            Text("End: \(anesthesia.end)")
            Text("Position: \(anesthesia.position)")
            Text("SurgeryStart: \(anesthesia.surgery.start)")
            Text("SurgeryEnd: \(anesthesia.surgery.end)")
            
            
            Button(surgery.anesthesia == nil ? "Criar Anestesia" : "Editar Anestesia", systemImage: surgery.anesthesia == nil ? "plus" : "pencil",) {
                showingAnesthesiaForm = true
            }
            .buttonStyle(.glassProminent)
            
            Button("Editar", systemImage: "pencil") {
                selectedSurgery = surgery
            }
            
            Button {
                editingPatient = patient
                showingForm = true
            } label: {
                Label("Adicionar Paciente", systemImage: "plus")
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
        
        .sheet(item: $selectedSurgery) { surgery in
            let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
            let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
            let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
            let viewModel = SurgeryFormViewModel(patient: patient, surgery: surgery, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
            SurgeryFormView(viewModel: viewModel)
        }
        
        .sheet(isPresented: $showingForm) {
            if let user = session.currentUser {
                let repository = SwiftDataPatientRepository(context: modelContext, currentUser: user)
                PatientFormView(
                    viewModel: PatientFormViewModel(
                        repository: repository,
                        currentUser: user,
                        editingPatient: patient
                    ),
                    selectedPatient: $selectedPatient
                )
            } else {
                ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
            }
        }
    }
}
