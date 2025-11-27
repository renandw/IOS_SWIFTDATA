//
//  PreAnesthesiaView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import SwiftUI
import SwiftData

struct PreAnesthesiaView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    
    @State private var isPresentingForm = false
    @State private var formViewModel: PreAnesthesiaViewModel?
    
    var body: some View {
        NavigationStack {
            Group {
                let surgery = anesthesia.surgery
                let pre = surgery.preanesthesia
                if pre != nil {
                    contentWhenAvailable
                } else {
                    contentUnavailable
                }
            }
            .navigationTitle("Descrição da anestesia")
            .preference(
                key: CustomTopBarButtonPreferenceKey.self,
                value: CustomTopBarButtonPreference(
                    id: "AnesthesiaDescriptionView.topbar.buttons",
                    view: AnyView(topBarButtons),
                    token: "AnesthesiaDescriptionView.topbar.buttons.\(anesthesia.surgery.preanesthesia == nil)"
                )
            )
            .sheet(item: $formViewModel) { vm in
                PreAnesthesiaFormView(viewModel: vm)
            }
        }
    }
    
    private var contentWhenAvailable: some View {
        let surgery = anesthesia.surgery
        let pre = surgery.preanesthesia
        return ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                apaCard(surgery: surgery)
                comorbiditiesCard(preanesthesia: pre)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var contentUnavailable: some View {
        ContentUnavailableView(
            "Sem Avaliação Pré-Anestésica",
            systemImage: "text.document.fill",
            description: Text("Crie uma avaliação para ver aqui.")
        )
        .overlay(
            VStack {
                Spacer()
                Button(action: { presentNewForm() }) {
                    Label("Adicionar Descrição", systemImage: "plus")
                }
                .buttonStyle(.glass)
                .tint(.blue)
                .padding()
            }
        )
    }
    
    private func apaCard(surgery: Surgery) -> some View {
        let patientSex = surgery.patient.sex
        let pre = surgery.preanesthesia
        return VStack(alignment: .leading) {
            HStack {
                if patientSex == .male {
                    Image(systemName: "figure.stand")
                        .foregroundStyle(patientSex.sexColor)
                } else {
                    Image(systemName: "figure.stand.dress")
                        .foregroundStyle(patientSex.sexColor)
                }
                Text("APA")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                if let status = pre?.status { status.badgeView }
            }
            Divider()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Classificação ASA:")
                        Spacer()
                        if let asa = anesthesia.shared?.asa { asa.badgeView }
                    }
                    HStack {
                        Text("Apto:")
                        Spacer()
                        if let clearanceStatus = pre?.clearenceStatus {
                            Text("\(clearanceStatus.displayName)")
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private func comorbiditiesCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "stethoscope")
                    .foregroundStyle(.green)
                Text("Comorbidades")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    if let isInfant = preanesthesia?.isInfant, isInfant {
                        Text("Menor de um ano")
                        Divider()
                    }
                    
                    if let isPregnant = preanesthesia?.isPregnant, isPregnant {
                        Text("Gestante")
                        Divider()
                    }
                    
                    if preanesthesia?.cardiacComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Cardiovasculares:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let cardiacDetails = preanesthesia?.cardiacComorbitiesDetails, !cardiacDetails.isEmpty {
                                        ForEach(cardiacDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customCardiacDetails = preanesthesia?.cardiacComorbitiesCustomDetails, !customCardiacDetails.isEmpty {
                                        ForEach(customCardiacDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let cardiacDetailsText = preanesthesia?.cardiacComorbitiesDetailsText, !cardiacDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(cardiacDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                }
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if let preanesthesia = anesthesia.surgery.preanesthesia {
                Button(action: {
                    presentEditForm(for: preanesthesia)
                }) {
                    Image(systemName: "pencil")
                }
                .accessibilityLabel("Editar Descrição")
                .buttonStyle(.glass)
                .tint(.blue)
            } else {
                Button(action: {
                    presentNewForm()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Adicionar Descrição")
                .buttonStyle(.glass)
                .tint(.blue)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func presentNewForm() {
        // Ajuste a forma de obter o usuário conforme a API real do seu SessionManager
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                newFor: anesthesia.surgery,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
    
    private func presentEditForm(for preanesthesia: PreAnesthesia) {
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                preanesthesia: preanesthesia,
                user: user,
                repo: repo,
                sharedRepo: sharedRepo
            )
            formViewModel = vm
            isPresentingForm = true
        }
    }
}

