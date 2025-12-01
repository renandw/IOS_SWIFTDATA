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
            .navigationTitle("Avaliação Pré-Anestésica")
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
                surgeryHistoryCard(preanesthesia: pre)
                apfelCard(preanesthesia: pre)
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
                    if anesthesia.shared?.asa != nil {
                        HStack {
                            Text("Classificação ASA:")
                                .fontWeight(.semibold)
                            Spacer()
                            if let asa = anesthesia.shared?.asa { asa.badgeView }
                        }
                    }
                    if anesthesia.surgery.preanesthesia?.clearenceStatus != nil {
                        HStack {
                            Text("Apto:")
                                .fontWeight(.semibold)
                            Spacer()
                            if let clearanceStatus = pre?.clearenceStatus {
                                Text("\(clearanceStatus.displayName)")
                            }
                        }
                        if anesthesia.surgery.preanesthesia?.definitiveRecommendationForRevaluationStatus != nil || anesthesia.surgery.preanesthesia?.futherRecommendationForRevaluation != nil {
                            VStack(alignment: .leading) {
                                Text("Recomendações:")
                                    .fontWeight(.semibold)
                                HStack(alignment: .top) {
                                    if let recommendations = pre?.definitiveRecommendationForRevaluationStatus, !recommendations.isEmpty {
                                        let joined = recommendations.map { $0.reportDisplayName }.joined(separator: "; ")
                                        Text(joined)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                HStack(alignment: .top) {
                                    if let customRecommendations = pre?.futherRecommendationForRevaluation, !customRecommendations.isEmpty {
                                        Text(customRecommendations.joined(separator: "; "))
                                    }
                                }
                            }
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
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    if let healthyPatient = preanesthesia?.healthyPatient, healthyPatient {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Paciente Sem Comorbidades")
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    }
                    
                    if let isInfant = preanesthesia?.isInfant, isInfant {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Menor de um ano:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let isInfantDetails = preanesthesia?.isInfantComorbitiesDetails, !isInfantDetails.isEmpty {
                                        ForEach(isInfantDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customIsInfantDetails = preanesthesia?.isInfantCustomDetails, !customIsInfantDetails.isEmpty {
                                        ForEach(customIsInfantDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let isInfantDetailsText = preanesthesia?.isInfantDetailsText, !isInfantDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(isInfantDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    
                    if preanesthesia?.isPregnant == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Gestante:")
                                    .font(.headline)
                                if let isPregnantAge = preanesthesia?.isPregnantAge, !isPregnantAge.isEmpty {
                                    Text(isPregnantAge)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let isPregnantDetails = preanesthesia?.isPregnantComorbitiesDetails, !isPregnantDetails.isEmpty {
                                        ForEach(isPregnantDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customIsPregnantDetails = preanesthesia?.isPregnantCustomDetails, !customIsPregnantDetails.isEmpty {
                                        ForEach(customIsPregnantDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let isPregnantDetailsText = preanesthesia?.isPregnantDetailsText, !isPregnantDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(isPregnantDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    
                    if preanesthesia?.cardiacComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Cardiológicas:")
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
                    if preanesthesia?.respiratoryComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Respiratórias:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let respiratoryDetails = preanesthesia?.respiratoryComorbitiesDetails, !respiratoryDetails.isEmpty {
                                        ForEach(respiratoryDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customRespiratoryDetails = preanesthesia?.respiratoryComorbitiesCustomDetails, !customRespiratoryDetails.isEmpty {
                                        ForEach(customRespiratoryDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let respiratoryDetailsText = preanesthesia?.respiratoryComorbitiesDetailsText, !respiratoryDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(respiratoryDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.endocrineComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Endócrinas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let endocrineDetails = preanesthesia?.endocrineComorbitiesDetails, !endocrineDetails.isEmpty {
                                        ForEach(endocrineDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customEndocrineDetails = preanesthesia?.endocrineComorbitiesCustomDetails, !customEndocrineDetails.isEmpty {
                                        ForEach(customEndocrineDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let endocrineDetailsText = preanesthesia?.endocrineComorbitiesDetailsText, !endocrineDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(endocrineDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.gastrointestinalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Respiratórias:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let gastrointestinalDetails = preanesthesia?.gastrointestinalComorbitiesDetails, !gastrointestinalDetails.isEmpty {
                                        ForEach(gastrointestinalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customGastrointestinalDetails = preanesthesia?.gastrointestinalComorbitiesCustomDetails, !customGastrointestinalDetails.isEmpty {
                                        ForEach(customGastrointestinalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let gastrointestinalDetailsText = preanesthesia?.gastrointestinalComorbitiesDetailsText, !gastrointestinalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(gastrointestinalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.hematologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Hematológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let hematologicalDetails = preanesthesia?.hematologicalComorbitiesDetails, !hematologicalDetails.isEmpty {
                                        ForEach(hematologicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customHematologicalDetails = preanesthesia?.hematologicalComorbitiesCustomDetails, !customHematologicalDetails.isEmpty {
                                        ForEach(customHematologicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let hematologicalDetailsText = preanesthesia?.hematologicalComorbitiesDetailsText, !hematologicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(hematologicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.imunologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Imunológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let imunologicalDetails = preanesthesia?.imunologicalComorbitiesDetails, !imunologicalDetails.isEmpty {
                                        ForEach(imunologicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customImunologicalDetails = preanesthesia?.imunologicalComorbitiesCustomDetails, !customImunologicalDetails.isEmpty {
                                        ForEach(customImunologicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let imunologicalDetailsText = preanesthesia?.imunologicalComorbitiesDetailsText, !imunologicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(imunologicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.musculoskeletalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Musculoesqueléticas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let musculoskeletalDetails = preanesthesia?.musculoskeletalComorbitiesDetails, !musculoskeletalDetails.isEmpty {
                                        ForEach(musculoskeletalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customMusculoskeletalDetails = preanesthesia?.musculoskeletalComorbitiesCustomDetails, !customMusculoskeletalDetails.isEmpty {
                                        ForEach(customMusculoskeletalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let musculoskeletalDetailsText = preanesthesia?.musculoskeletalComorbitiesDetailsText, !musculoskeletalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(musculoskeletalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    
                    if preanesthesia?.genitourologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Genitourológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let genitourologicalDetails = preanesthesia?.genitourologicalComorbitiesDetails, !genitourologicalDetails.isEmpty {
                                        ForEach(genitourologicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customGenitourologicalDetails = preanesthesia?.genitourologicalComorbitiesCustomDetails, !customGenitourologicalDetails.isEmpty {
                                        ForEach(customGenitourologicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let genitourologicalDetailsText = preanesthesia?.genitourologicalComorbitiesDetailsText, !genitourologicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(genitourologicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.gynecologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Ginecológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let gynecologicalDetails = preanesthesia?.gynecologicalComorbitiesDetails, !gynecologicalDetails.isEmpty {
                                        ForEach(gynecologicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customGynecologicalDetails = preanesthesia?.gynecologicalComorbitiesCustomDetails, !customGynecologicalDetails.isEmpty {
                                        ForEach(customGynecologicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let gynecologicalDetailsText = preanesthesia?.gynecologicalComorbitiesDetailsText, !gynecologicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(gynecologicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.androgenicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Andrológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let androgenicalDetails = preanesthesia?.androgenicalComorbitiesDetails, !androgenicalDetails.isEmpty {
                                        ForEach(androgenicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customAndorlogicalDetails = preanesthesia?.androgenicalComorbitiesCustomDetails, !customAndorlogicalDetails.isEmpty {
                                        ForEach(customAndorlogicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let androgenicalDetailsText = preanesthesia?.androgenicalComorbitiesDetailsText, !androgenicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(androgenicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.neurologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Neurológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let neurologicalDetails = preanesthesia?.neurologicalComorbitiesDetails, !neurologicalDetails.isEmpty {
                                        ForEach(neurologicalDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customNeurologicalDetails = preanesthesia?.neurologicalComorbitiesCustomDetails, !customNeurologicalDetails.isEmpty {
                                        ForEach(customNeurologicalDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let neurologicalDetailsText = preanesthesia?.neurologicalComorbitiesDetailsText, !neurologicalDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(neurologicalDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.geneticSyndrome == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Neurológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let geneticSyndromeDetails = preanesthesia?.geneticSyndromeComorbitiesDetails, !geneticSyndromeDetails.isEmpty {
                                        ForEach(geneticSyndromeDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customGeneticSyndromeDetails = preanesthesia?.geneticSyndromeComorbitiesCustomDetails, !customGeneticSyndromeDetails.isEmpty {
                                        ForEach(customGeneticSyndromeDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let geneticSyndromeDetailsText = preanesthesia?.geneticSyndromeComorbitiesDetailsText, !geneticSyndromeDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(geneticSyndromeDetailsText)
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
    
    
    private func surgeryHistoryCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "scissors")
                    .foregroundStyle(.green)
                Text("Cirurgias Prévias")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {

                    if preanesthesia?.surgeryHistory == true {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            // Mostrar mensagem padrão quando todos os campos estiverem vazios
                            let hasDetailsList = !(preanesthesia?.surgeryHistoryDetails?.isEmpty ?? true)
                            let hasCustomList = !((preanesthesia?.surgeryHistoryCustomDetails ?? []).isEmpty)
                            let hasText = !(preanesthesia?.surgeryHistoryDetailsText?.isEmpty ?? true)
                            
                            if !hasDetailsList && !hasCustomList && !hasText {
                                Text("Não houve eventos adversos em anestesias prévias")
                                    .font(.headline)
                            } else {
                                Text("Cirurgias Prévias:")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                        HStack(alignment: .center) {
                                            if let surgeryHistoryDetails = preanesthesia?.surgeryHistoryDetails, !surgeryHistoryDetails.isEmpty {
                                                ForEach(surgeryHistoryDetails, id: \.self) { comorbidity in
                                                    Text(comorbidity.displayName)
                                                    Text("•")
                                                }
                                            }
                                            
                                            if let customSurgeryHistoryDetails = preanesthesia?.surgeryHistoryCustomDetails, !customSurgeryHistoryDetails.isEmpty {
                                                ForEach(customSurgeryHistoryDetails, id: \.self) { customComorbity in
                                                    Text(customComorbity)
                                                }
                                            }
                                        }
                                    HStack(alignment: .top, spacing: 8) {
                                        if let surgeryHistoryDetailsText = preanesthesia?.surgeryHistoryDetailsText, !surgeryHistoryDetailsText.isEmpty {
                                            Text("Detalhes:")
                                                .fontWeight(.semibold)
                                                .font(.caption)
                                            Spacer()
                                            Text(surgeryHistoryDetailsText)
                                                .font(.caption)
                                        }
                                    }
                                    .padding(.bottom, 8)
                                }
                            }
                        }
                    } else if preanesthesia?.surgeryHistory == false {
                        Text("Paciente não tem histórico de ter realizado cirurgias")
                    } else {
                        Text("Histórico cirúrgico não informado")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    
                    if preanesthesia?.anesthesiaHistory == true {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            // Mostrar mensagem padrão quando todos os campos estiverem vazios
                            let hasDetailsList = !(preanesthesia?.anesthesiaHistoryDetails?.isEmpty ?? true)
                            let hasCustomList = !((preanesthesia?.anesthesiaHistoryCustomDetails ?? []).isEmpty)
                            let hasText = !(preanesthesia?.anesthesiaHistoryDetailsText?.isEmpty ?? true)
                            
                            if !hasDetailsList && !hasCustomList && !hasText {
                                Text("Sem eventos adversos em anestesias prévias")
                                    .font(.headline)
                            } else {
                                Text("Eventos adversos prévios:")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .center) {
                                        if let anesthesiaHistoryDetails = preanesthesia?.anesthesiaHistoryDetails, !anesthesiaHistoryDetails.isEmpty {
                                            ForEach(anesthesiaHistoryDetails, id: \.self) { comorbidity in
                                                Text(comorbidity.displayName)
                                                Text("•")
                                            }
                                        }
                                        if let customAnesthesiaHistoryDetails = preanesthesia?.anesthesiaHistoryCustomDetails, !customAnesthesiaHistoryDetails.isEmpty {
                                            ForEach(customAnesthesiaHistoryDetails, id: \.self) { customComorbity in
                                                Text(customComorbity)
                                            }
                                        }
                                        HStack { }
                                    }
                                }
                                
                                HStack(alignment: .top) {
                                    if let anesthesiaHistoryDetailsText = preanesthesia?.anesthesiaHistoryDetailsText, !anesthesiaHistoryDetailsText.isEmpty {
                                        Text("Detalhes:")
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                        Spacer()
                                        Text(anesthesiaHistoryDetailsText)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    } else if preanesthesia?.anesthesiaHistory == false {
                        Text("Paciente não tem histórico anestésico")
                    } else {
                        Text("Histórico anestésico não informado")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    
                    Divider()
                }
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private func apfelCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.and.background.striped.horizontal")
                    .foregroundStyle(.green)
                Text("Avaliação NVPO")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {
                    
                    let apfelDetais = !(preanesthesia?.apfelScoreDetails?.isEmpty ?? true)
                    if !apfelDetais {
                        Text("Não há fatores de risco para náusea e vômitos perioperatórios.")
                            .font(.headline)
                    } else {
                        VStack(alignment: .leading) {
                            HStack(spacing: 4){
                                Text("\(preanesthesia?.apfelScoreDetails?.count ?? 0)" )
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Fatores de risco")
                                    .font(.subheadline)
                            }
                            Text("Fatores de risco:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(alignment: .center) {
                                    if let apfel = preanesthesia?.apfelScoreDetails, !apfel.isEmpty {
                                        ForEach(apfel, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                            Text("•")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Divider()
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
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
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

