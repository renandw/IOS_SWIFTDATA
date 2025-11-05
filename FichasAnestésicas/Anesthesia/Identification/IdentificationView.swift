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
        
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading) {
                    Text("Paciente")
                        .font(.title3)
                        .fontWeight(.semibold)
                    HStack {
                        Text("\(anesthesia.surgery.patient.name),")
                        Text("\(ageContext.ageString(from: anesthesia.surgery.patient.birthDate)),")
                        Text(patient.sex.sexStringDescription)
                    }
                    HStack {
                        Text("Nascimento: \(anesthesia.surgery.patient.birthDate, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits)),")
                        
                    }
                    if anesthesia.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true) != "000 0000 0000 0000"{
                        Text("CNS: \(anesthesia.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))")
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Cirurgia")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            anesthesia.surgery.status.badgeView
                            
                        }
                        HStack {
                            Text("Procedimento")
                            Text("\(anesthesia.surgery.proposedProcedure)")
                                .fontWeight(.semibold)
                        }
                        HStack {
                            Text("Convênio:")
                            Text("\(anesthesia.surgery.insuranceName)")
                            if anesthesia.surgery.insuranceName.lowercased() != "particular" {
                                Text("-")
                                Text("\(anesthesia.surgery.insuranceNumber)")
                            }
                        }
                        HStack {
                            
                            Text("Peso: \(anesthesia.surgery.weight, specifier: "%.1f") Kg")
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        Text("CBHPM")
                            .font(.headline)
                        if let procedures = anesthesia.surgery.cbhpmProcedures, !procedures.isEmpty {
                            ForEach(procedures) { p in
                                Text("\(p.code) - \(p.procedure) - Porte: \(p.port)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("Nenhum procedimento selecionado")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Hospital:")
                            Text("\(anesthesia.surgery.hospital)")
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Equipe Cirúrgica:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        HStack {
                            Text("Cirurgião:")
                            Text("\(anesthesia.surgery.mainSurgeon)")
                        }
                        
                        if anesthesia.surgery.auxiliarySurgeons?.isEmpty == false {
                            HStack {
                                Text(anesthesia.surgery.auxiliarySurgeons?.count == 1 ? "Auxiliar:" :"Auxiliares:")
                                Text("\(anesthesia.surgery.auxiliarySurgeons?.joined(separator: ", ") ?? "-")")
                            }
                        }
                    }
                    

                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Anestesia")
                            .font(.title3)
                            .fontWeight(.semibold)
                        if let asa = anesthesia.shared?.asa {
                            asa.badgeView
                        }
                        Spacer()
                        if let status = anesthesia.status {
                            status.badgeView
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Posicionamento: \(anesthesia.position.map(\.rawValue).joined(separator: ", "))")
                            if let asa = anesthesia.shared?.asa {
                                Text("ASA \(asa.rawValue)")
                            } else {
                                Text("ASA não definido")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Text({
                            if let shared = anesthesia.shared {
                                let list = shared.techniques
                                return "Técnicas: " + (list.isEmpty ? "-" : list.map(\.displayName).joined(separator: ", "))
                            } else {
                                return ""
                            }
                        }())
                    }
                }
                VStack(alignment: .leading,) {
                    VStack(alignment: .leading, spacing: 4) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Data")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text("\(anesthesia.surgery.date, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits)),")
                                    .font(.title3)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Início")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("Anestesia: \(anesthesia.start?.formatted(date: .abbreviated, time: .shortened) ?? "-" )")
                            Text("Cirurgia: \(anesthesia.surgery.start?.formatted(date: .abbreviated, time: .shortened) ?? "-" )")
                            
                        }
                        if let anesthesiaEnd = anesthesia.end, let surgeryEnd = surgery.end {
                            VStack(alignment: .leading) {
                                Text("Fim")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Text("Cirurgia: \(surgeryEnd.formatted(date: .abbreviated, time: .shortened))")
                                Text("Anestesia: \(anesthesiaEnd.formatted(date: .abbreviated, time: .shortened))")
                            }
                        } else {
                            VStack(alignment: .leading) {
                                Text("Edite a anestesia para cadastrar horários de finalização.")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
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
        .preference(
            key: CustomTopBarButtonPreferenceKey.self,
            value: CustomTopBarButtonPreference(
                id: "IdentificationView.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "IdentificationView.topbar.buttons.v1"
            )
        )
        
        
    }
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            Button(action: {
                editingPatient = patient
                showingForm = true
            }) {
                Image(systemName: "person.fill")
            }
            .accessibilityLabel("Editar Paciente")
            .buttonStyle(.glass)
            .tint(.blue)

            Button(action: {
                selectedSurgery = surgery
            }) {
                Image(systemName: "stethoscope")
            }
            .accessibilityLabel("Editar Cirurgia")
            .buttonStyle(.glass)
            .tint(.green)

            Button(action: {
                showingAnesthesiaForm = true
            }) {
                Image(systemName: surgery.anesthesia == nil ? "plus" : "syringe.fill")
            }
            .accessibilityLabel(surgery.anesthesia == nil ? "Criar Anestesia" : "Editar Anestesia")
            .buttonStyle(.glass)
            .tint(.purple)
        }
    }
}

