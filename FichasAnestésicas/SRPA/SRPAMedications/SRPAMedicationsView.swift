//
//  MedicationSheet.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import SwiftUI
import SwiftData

enum SRPAMedicationSheet: Identifiable {
    case create
    case edit(SRPAMedicationEntry)

    var id: String {
        switch self {
        case .create:
            return "create"
        case .edit(let entry):
            return entry.srpaMedicationId
        }
    }
}

struct SRPAMedicationsView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var srpa: SRPA
    @State private var sheetState: SRPAMedicationSheet? = nil
    
    
    var body: some View {
        Group {
            if srpa.medications.isEmpty {
                ContentUnavailableView(
                    "Sem medicações",
                    systemImage: "pills",
                    description: Text("Adicione as medicações administradas durante a anestesia.")
                )
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            sheetState = .create
                        }) {
                            Label("Adicionar Medicação", systemImage: "plus")
                        }
                        .buttonStyle(.glass)
                        .tint(.blue)
                        .padding()
                    }
                )
            } else {
                ScrollView {
                    let grouped = Dictionary(grouping: srpa.medications) { $0.via.label }
                    ForEach(grouped.keys.sorted(), id: \.self) { viaLabel in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viaLabel)
                                .font(.title3)
                                .bold()
                                .padding(.horizontal)
                                .padding(.top, 8)
                            ForEach(grouped[viaLabel]!.sorted(by: { $0.timestamp < $1.timestamp }), id: \.srpaMedicationId) { medication in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(alignment: .center) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(medication.name)
                                                    .font(.headline)
                                                Text("\(medication.dose)")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.primary)
                                            }
                                            Text("\(medication.category.label)")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "clock.fill")
                                                .foregroundStyle(Color(medication.category.medicationColor))
                                            Text(medication.timestamp.formatted(date: .omitted, time: .shortened))
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                .padding()
                                .onTapGesture {
                                    sheetState = .edit(medication)
                                }
                                .glassEffect(.regular.tint(medication.category.medicationColor.opacity(0.11)).interactive())
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .sheet(item: $sheetState, onDismiss: {
            sheetState = nil
        }) { state in
            if let currentUser = session.currentUser {
                switch state {
                case .create:
                    let viewModel = SRPAMedicationsFormViewModel(
                        srpa: srpa,
                        user: currentUser,
                        context: modelContext,
                        catalog: MedicationsHelper.allMedications,
                        entry: nil
                    )
                    SRPAMedicationsFormView(
                        viewModel: viewModel,
                        catalog: MedicationsHelper.allMedications
                    )
                case .edit(let medication):
                    let viewModel = SRPAMedicationsFormViewModel(
                        srpa: srpa,
                        user: currentUser,
                        context: modelContext,
                        catalog: MedicationsHelper.allMedications,
                        entry: medication
                    )
                    SRPAMedicationsFormView(
                        viewModel: viewModel,
                        catalog: MedicationsHelper.allMedications
                    )
                }
            }
        }
        .preference(
            key: SRPACustomTopBarButtonPreferenceKey.self,
            value: SRPACustomTopBarButtonPreference(
                id: "SRPAMedicationsView.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "SRPAMedicationsView.topbar.buttons.v\(srpa.medications.count)"
            )
        )
    }
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if !srpa.medications.isEmpty {
                Text("\(srpa.medications.count)")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .glassEffect(.regular.interactive())
                    .clipShape(Capsule())
            }

            
            Spacer()
            
            if !srpa.medications.isEmpty {
                Button(action: {
                    if let currentUser = session.currentUser {
                        let repo = SwiftDataSRPAMedicationEntryRepository(context: modelContext)
                        try? repo.deleteAll(for: srpa, by: currentUser)
                    } else {
                        srpa.medications.removeAll()
                    }
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Editar Paciente")
                .buttonStyle(.glass)
                .tint(.red)
            }
            
            
            Button(action: {
                sheetState = .create
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Adicionar Medicações")
            .buttonStyle(.glass)
            .tint(.blue)
        }
    }
}

#Preview("Medication • Para uso em Anesthesia DetailsView") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
    let medications = MedicationEntry.samples(anesthesias: anesthesias)
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
        medications.forEach { context.insert($0) }
        preanesthesias.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!

    return NavigationStack {
        MedicationsView(anesthesia: anesthesia)
            .environment(session)
    }
    .modelContainer(container)
}

