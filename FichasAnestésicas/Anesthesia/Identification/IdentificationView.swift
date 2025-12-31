
import SwiftUI
import SwiftData

struct IdentificationView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
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
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(anesthesia.surgery.patient.sex.sexColor)
                        Text("Paciente")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(anesthesia.surgery.patient.name),")
                                    .fontWeight(.bold)
                                Text("\(ageContext.ageString(from: anesthesia.surgery.patient.birthDate)),")
                                Text(anesthesia.surgery.patient.sex.sexStringDescription)
                            }
                            HStack {
                                Text("Nascimento: \(anesthesia.surgery.patient.birthDate, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits)),")
                                Text("Peso: \(anesthesia.surgery.weight, specifier: "%.1f") Kg")
                            }
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                Text("\(anesthesia.surgery.insuranceName)")
                                if anesthesia.surgery.insuranceName.lowercased() != "particular" {
                                    Text("-")
                                    Text("\(anesthesia.surgery.insuranceNumber)")
                                }
                            }
                            
                            if anesthesia.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true) != "000 0000 0000 0000"{
                                Text("CNS: \(anesthesia.surgery.patient.cns.cnsFormatted(expectedLength: 15, digitsOnly: true))")
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
                            anesthesia.surgery.status.badgeView
                        }
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Procedimento")
                                .fontWeight(.semibold)
                            Text("\(anesthesia.surgery.proposedProcedure)")
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("CBHPM")
                                .font(.headline)
                        }
                        if let procedures = anesthesia.surgery.cbhpmProcedures {
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
                            Text("\(anesthesia.surgery.hospital)")
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Equipe Cirúrgica:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        HStack {
                            Image(systemName: "facemask")
                            Text("\(anesthesia.surgery.mainSurgeon)")
                        }
                        
                        if anesthesia.surgery.auxiliarySurgeons?.isEmpty == false {
                            HStack(alignment: .top) {
                                if let count = anesthesia.surgery.auxiliarySurgeons?.count, count > 0 {
                                    Image(systemName: count == 1 ? "person.2" : "person.3")
                                    // Text(count == 1 ? "Auxiliar:" :"Auxiliares:")
                                }
                                Text("\(anesthesia.surgery.auxiliarySurgeons?.joined(separator: ", ") ?? "-")")
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
                        if let asa = anesthesia.shared?.asa {
                            asa.badgeView
                        }
                        Spacer()
                        if let status = anesthesia.status {
                            status.badgeView
                        }
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Posicionamento:")
                                .fontWeight(.semibold)
                            Text("\(anesthesia.position.map(\.rawValue).joined(separator: ", "))")
                        }
                        HStack(alignment: .top) {
                            Text("Técnicas:")
                                .fontWeight(.semibold)
                            Text({
                                if let shared = anesthesia.shared {
                                    let list = shared.techniques
                                    return (list.isEmpty ? "-" : list.map(\.displayName).joined(separator: ", "))
                                } else {
                                    return ""
                                }
                            }())
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                    if isSameDay(surgeryDate: anesthesia.surgery.date, anesthesiaStart: anesthesia.start, anesthesiaEnd: anesthesia.end, surgeryStart: anesthesia.surgery.start, surgeryEnd: anesthesia.surgery.end) {
                        VStack(alignment: .leading,) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "calendar")
                                    Text("Data")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("\(anesthesia.surgery.date.formatted(date: .long, time: .omitted))")
                                        .font(.title3)
                                }
                                Divider()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Início")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        Text("Anestesia: \(anesthesia.start?.formatted(date: .omitted, time: .shortened) ?? "-" )")
                                        Text("Cirurgia: \(anesthesia.surgery.start?.formatted(date: .omitted, time: .shortened) ?? "-" )")
                                        
                                    }
                                    Spacer()
                                    if let anesthesiaEnd = anesthesia.end, let surgeryEnd = anesthesia.surgery.end {
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
                                        Text("\(anesthesia.surgery.date.formatted(date: .long, time: .omitted))")
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
                                if let anesthesiaEnd = anesthesia.end, let surgeryEnd = anesthesia.surgery.end {
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
            .sheet(isPresented: $showingAnesthesiaForm) {
                if let currentUser = session.currentUser {
                    let viewModel = AnesthesiaFormViewModel(
                        surgery: anesthesia.surgery,
                        user: currentUser,
                        context: modelContext,
                    )
                    AnesthesiaFormView(viewModel: viewModel, mode: .standalone)
                }
            }
            
            .sheet(item: $selectedSurgery) { surgery in
                let repository = SwiftDataSurgeryRepository(context: modelContext, currentUser: session.currentUser!)
                let financialRepository = SwiftDataFinancialRepository(context: modelContext, currentUser: session.currentUser!)
                let procedureRepository = SwiftDataCbhpmProcedureRepository(context: modelContext)
                let viewModel = SurgeryFormViewModel(patient: anesthesia.surgery.patient, surgery: anesthesia.surgery, repository: repository, financialRepository: financialRepository, procedureRepository: procedureRepository, modelContext: modelContext)
                SurgeryFormView(viewModel: viewModel, mode: .standalone)
            }
            
            .sheet(isPresented: $showingForm) {
                if let user = session.currentUser {
                    let repository = SwiftDataPatientRepository(context: modelContext, currentUser: user)
                    PatientFormView(
                        viewModel: PatientFormViewModel(
                            repository: repository,
                            currentUser: user,
                            editingPatient: anesthesia.surgery.patient
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
                editingPatient = anesthesia.surgery.patient
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
                selectedSurgery = anesthesia.surgery
            }) {
                Image(systemName: "stethoscope")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Editar Cirurgia")
            .buttonStyle(.glass)
            .tint(.green)

            Button(action: {
                showingAnesthesiaForm = true
            }) {
                Image(systemName: "syringe.fill")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Editar Anestesia")
            .buttonStyle(.glass)
            .tint(.purple)
        }
    }
}

#Preview("Identification • Para uso em Anesthesia DetailsView") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
    let preanesthesias = PreAnesthesia.samples(
        surgeries: surgeries,
        shared: shared,
        user: user
    )

    let session = SessionManager()
    session.currentUser = user

    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }
        preanesthesias.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!
    
    let pre = preanesthesias.randomElement()!

    return NavigationStack {
        IdentificationView(anesthesia: anesthesia, ageContext: .inSurgery(anesthesia.surgery))
            .environment(session)
    }
    .modelContainer(container)
}
