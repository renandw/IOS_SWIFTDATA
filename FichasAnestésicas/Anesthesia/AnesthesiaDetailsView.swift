//
//  AnesthesiaDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftUI
import SwiftData

enum anesthesiaDetailsSection: Int, CaseIterable, Hashable {
    case identificationSection, apaSection, medicationsSection, vitalSignsSection, descriptionSection, previewSection

    var sectionTitle: String {
        switch self {
        case .identificationSection:    return "Identificação"
        case .apaSection:               return "A. Pré-Anestésica"
        case .medicationsSection:       return "Medicações"
        case .vitalSignsSection:        return "Sinais Vitais"
        case .descriptionSection:       return "Descrição Anestésica"
        case .previewSection:           return "Visualização"
        }
    }

    var sectionIcon: String {
        switch self {
        case .identificationSection:    return "person.text.rectangle"
        case .apaSection:               return "doc.text.magnifyingglass"
        case .medicationsSection:       return "pills"
        case .vitalSignsSection:        return "waveform.path.ecg"
        case .descriptionSection:       return "square.and.pencil"
        case .previewSection:           return "eye"
        }
    }
}



struct AnesthesiaDetailsView: View {
    @Bindable var anesthesia: Anesthesia
    
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @State private var activeSection: anesthesiaDetailsSection = .identificationSection
    @State private var customTitleBarButton: AnyView? = nil
    
    @State private var showStartEndForm = false
    
    private var canShowFinalizeButton: Bool {
        !anesthesia.medications.isEmpty &&
        !anesthesia.vitalSigns.isEmpty &&
        !(anesthesia.anesthesiaDescription?.veryEndDescriptionText?.isEmpty ?? true)
    }
    private var canShowClockButton: Bool {
        anesthesia.end == nil &&
        anesthesia.surgery.end == nil
    }

    private var canFinalize: Bool {
        anesthesia.status != .finished &&
        anesthesia.surgery.status != .finished
    }

    private func finalize() {
        guard let user = session.currentUser else { return }
        let repository = SwiftDataAnesthesiaRepository(context: modelContext)
        do {
            try repository.finalizeStatus(
                anesthesia: anesthesia,
                for: anesthesia.surgery,
                by: user
            )
        } catch {
            print("Erro ao finalizar: \(error)")
            // TODO: mostrar alerta
        }
    }

    var body: some View {
        contentSectionView
            .safeAreaInset(edge: .top) {
                headerSection
                    .background(.ultraThinMaterial)
            }
            .navigationTitle("Ficha Anestésica")
            .navigationBarTitleDisplayMode(.inline)
            .onPreferenceChange(CustomTopBarButtonPreferenceKey.self) { pref in
                customTitleBarButton = pref?.view
            }
            .toolbar {
                if canShowFinalizeButton && !canShowClockButton {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            if canFinalize { finalize() }
                        } label: {
                            if canFinalize {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            } else {
                                Text("Concluído")
                            }
                        }
                    }
                } else if canShowClockButton {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showStartEndForm = true
                        } label: {
                            Image(systemName: "clock")
                        }
                    }
                }
            }
            .sheet(isPresented: $showStartEndForm) {
                if let currentUser = session.currentUser {
                    let viewModel = AnesthesiaFormViewModel(
                        surgery: anesthesia.surgery,
                        user: currentUser,
                        context: modelContext,
                    )
                    AnesthesiaFormView(viewModel: viewModel, mode: .onlyTime)
                }
            }
            
    }
    
    
    private var pickerSection: some View {
        Picker("Secção", selection: $activeSection) {
            ForEach(anesthesiaDetailsSection.allCases, id: \.self) { section in
                Image(systemName: section.sectionIcon)
                    .tag(section)
                    .accessibilityLabel(section.sectionTitle)
            }
        }
        .pickerStyle(.segmented)
        .tint(.indigo)
        .padding(.top, 8)
        .padding(.horizontal, 6)
    }
    
    private var titleSection: some View {
        HStack(spacing: 8) {
            Text(activeSection.sectionTitle)
                .font(.title2).bold()
                .accessibilityAddTraits(.isHeader)
            Spacer()

            if let button = customTitleBarButton {
                button
            } else {
                Color.clear
                    .frame(width: 1, height: 1) // placeholder mínimo
            }
        }
        .frame(minHeight: 44, alignment: .center) // ajuste esse valor à sua UI
        .padding(.horizontal, 16)
    }

    
    private var headerSection: some View {
            VStack(spacing: 16) {
                pickerSection
                titleSection
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
        }
    
    private var contentSectionView: some View {
        SectionContent(
            anesthesia: anesthesia,
            patient: anesthesia.surgery.patient,
            surgery: anesthesia.surgery,
            section: activeSection

        )
        //.padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .id(activeSection)
        
    }
}
struct CustomTopBarButtonPreference: Equatable {
    let id: AnyHashable
    let view: AnyView
    let token: AnyHashable
    
    static func == (lhs: CustomTopBarButtonPreference, rhs: CustomTopBarButtonPreference) -> Bool {
        lhs.id == rhs.id && lhs.token == rhs.token
    }
}

struct CustomTopBarButtonPreferenceKey: PreferenceKey {
    static var defaultValue: CustomTopBarButtonPreference? = nil
    static func reduce(value: inout CustomTopBarButtonPreference?, nextValue: () -> CustomTopBarButtonPreference?) {
        if let next = nextValue() {
            value = next
        }
    }
}

struct SectionContent: View {
    @Bindable var anesthesia: Anesthesia
    let patient: Patient
    let surgery: Surgery
    let section: anesthesiaDetailsSection
    
    var body: some View {
        switch section {
        case .identificationSection:
            IdentificationView(anesthesia: anesthesia, ageContext: .inSurgery(anesthesia.surgery))
        case .apaSection:
            PreAnesthesiaView(anesthesia: anesthesia)
        case .medicationsSection:
            MedicationsView(anesthesia: anesthesia)
        case .vitalSignsSection:
            VitalSignsView(anesthesia: anesthesia)
        case .descriptionSection:
            AnesthesiaDescriptionView(anesthesia: anesthesia)
        case .previewSection:
            ContentView(anesthesia: anesthesia)
            //ContentUnavailableView("Preview To be implemented", image: "plus")
        }
    }
    
}

//to-do : se anesthesia == nil -> navegar para dashboardview -> proteger subviews em sectioncontent

#Preview("Anesthesia • completo") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let cbhpm = CbhpmProcedure.samples(surgeries: surgeries)
    let financial = Financial.samples(surgeries: surgeries)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
    let vitalSigns = VitalSignEntry.samples(anesthesias: anesthesias)
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
        cbhpm.forEach { context.insert($0) }
        financial.forEach { context.insert($0) }
        preanesthesias.forEach { context.insert($0) }
        vitalSigns.forEach{ context.insert($0) }
        medications.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!


    return NavigationStack {
        AnesthesiaDetailsView(anesthesia: anesthesia)
            .environment(session)
    }
    .modelContainer(container)
}
