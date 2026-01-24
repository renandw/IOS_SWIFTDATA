//
//  IdentificationView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//



import SwiftUI
import SwiftData

struct SRPAIdentificationView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var srpa: SRPA
    let ageContext: AgeContext
    
    @State private var showingAnesthesiaForm = false
    @State private var selectedSurgery: Surgery?
    @State private var showingForm = false
    @State private var editingPatient: Patient? = nil
    @State private var selectedPatient: Patient? = nil
    @State private var showingSRPAForm = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(srpa.surgery.patient.sex.sexColor)
                        Text("Paciente")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(srpa.surgery.patient.name),")
                                    .fontWeight(.bold)
                                Text("\(ageContext.ageString(from: srpa.surgery.patient.birthDate)),")
                                Text(srpa.surgery.patient.sex.sexStringDescription)
                            }
                            HStack {
                                Text("Nascimento: \(srpa.surgery.patient.birthDate, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits)),")
                                Text("Peso: \(srpa.surgery.weight, specifier: "%.1f") Kg")
                            }
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                Text("\(srpa.surgery.insuranceName)")
                                if srpa.surgery.insuranceName.lowercased() != "particular" {
                                    Text("-")
                                    Text("\(srpa.surgery.insuranceNumber)")
                                }
                            }
                            
                            if srpa.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true) != "000 0000 0000 0000"{
                                Text("CNS: \(srpa.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(alignment: .leading, spacing: 6) {
                    VStack(alignment: .leading) {
                        HStack{
                            Image(systemName: "stethoscope")
                                .foregroundStyle(.green)
                            Text("Cirurgia")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            srpa.surgery.status.badgeView
                        }
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Procedimento")
                                .fontWeight(.semibold)
                            Text("\(srpa.surgery.proposedProcedure)")
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("CBHPM")
                                .font(.headline)
                        }
                        if let procedures = srpa.surgery.cbhpmProcedures {
                            CBHPMProceduresList(procedures)
                        } else {
                            Text("Nenhum procedimento selecionado")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Hospital:")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("\(srpa.surgery.hospital)")
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Equipe Cirúrgica:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        HStack {
                            Image(systemName: "facemask")
                            Text("\(srpa.surgery.mainSurgeon)")
                        }
                        
                        if srpa.surgery.auxiliarySurgeons?.isEmpty == false {
                            HStack(alignment: .top) {
                                if let count = srpa.surgery.auxiliarySurgeons?.count, count > 0 {
                                    Image(systemName: count == 1 ? "person.2" : "person.3")
                                    // Text(count == 1 ? "Auxiliar:" :"Auxiliares:")
                                }
                                Text("\(srpa.surgery.auxiliarySurgeons?.joined(separator: ", ") ?? "-")")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "syringe.fill")
                            .foregroundStyle(.purple)
                        Text("Anestesia")
                            .font(.title3)
                            .fontWeight(.semibold)
                        if let asa = srpa.shared?.asa {
                            asa.badgeView
                        }
                        Spacer()
                        if let status = srpa.status {
                            status.badgeView
                        }
                    }
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                if isSameDay(surgeryDate: srpa.surgery.date, anesthesiaStart: srpa.surgery.anesthesia?.start, anesthesiaEnd: srpa.surgery.anesthesia?.end, surgeryStart: srpa.surgery.start, surgeryEnd: srpa.surgery.end) {
                        VStack(alignment: .leading,) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "calendar")
                                    Text("Data")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("\(srpa.surgery.date.formatted(date: .long, time: .omitted))")
                                        .font(.title3)
                                }
                                Divider()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Início")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        Text("Anestesia: \(srpa.start?.formatted(date: .omitted, time: .shortened) ?? "-" )")
                                        Text("Cirurgia: \(srpa.surgery.start?.formatted(date: .omitted, time: .shortened) ?? "-" )")
                                        
                                    }
                                    Spacer()
                                    if let anesthesiaEnd = srpa.surgery.anesthesia?.end, let surgeryEnd = srpa.surgery.end {
                                        VStack(alignment: .leading) {
                                            Text("Fim")
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                            Text("Cirurgia: \(surgeryEnd.formatted(date: .omitted, time: .shortened))")
                                            Text("Anestesia: \(anesthesiaEnd.formatted(date: .omitted, time: .shortened))")
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    } else {
                        VStack(alignment: .leading,) {
                            VStack(alignment: .leading, spacing: 4) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "calendar")
                                        Text("Data")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Text("\(srpa.surgery.date.formatted(date: .long, time: .omitted))")
                                            .font(.title3)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Início")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("Anestesia: \(srpa.surgery.anesthesia?.start?.formatted(date: .abbreviated, time: .shortened) ?? "-" )")
                                    Text("Cirurgia: \(srpa.surgery.start?.formatted(date: .abbreviated, time: .shortened) ?? "-" )")
                                    
                                }
                                if let anesthesiaEnd = srpa.surgery.anesthesia?.end, let surgeryEnd = srpa.surgery.end {
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
                                            .foregroundStyle(.secondary)
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingSRPAForm) {
                if let currentUser = session.currentUser {
                    let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
                    let viewModel = SRPAFormViewModel(
                        surgery: srpa.surgery,
                        user: currentUser,
                        context: modelContext,
                        sharedRepo: sharedRepo
                        
                    )
                    SRPAFormView(viewModel: viewModel, mode: .standalone)
                }
            }
            
            .sheet(item: $selectedSurgery) { surgery in
                let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
                let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
                let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
                let viewModel = SurgeryFormViewModel(patient: srpa.surgery.patient, surgery: srpa.surgery, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
                SurgeryFormView(viewModel: viewModel, mode: .standalone)
            }
            
            .sheet(isPresented: $showingForm) {
                if let user = session.currentUser {
                    let repository = SwiftDataPatientRepository(context: modelContext, currentUser: user)
                    PatientFormView(
                        viewModel: PatientFormViewModel(
                            repository: repository,
                            currentUser: user,
                            editingPatient: srpa.surgery.patient
                        ),
                        selectedPatient: $selectedPatient,
                        mode: .standalone
                    )
                } else {
                    ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
                }
            }

        }

        .preference(
            key: SRPACustomTopBarButtonPreferenceKey.self,
            value: SRPACustomTopBarButtonPreference(
                id: "SRPAIdentificationView.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "SRPAIdentificationView.topbar.buttons.v1"
            )
        )
    }
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            Button(action: {
                editingPatient = srpa.surgery.patient
                showingForm = true
            }) {
                Image(systemName: "person.fill")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Editar Paciente")
            .buttonStyle(.glass)
            .tint(.blue)

            Button(action: {
                selectedSurgery = srpa.surgery
            }) {
                Image(systemName: "stethoscope")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Editar Cirurgia")
            .buttonStyle(.glass)
            .tint(.green)

            Button(action: {
                showingSRPAForm = true
            }) {
                Image(systemName: "bed.double.fill")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Editar SRPA")
            .buttonStyle(.glass)
            .tint(.purple)
        }
    }
}
