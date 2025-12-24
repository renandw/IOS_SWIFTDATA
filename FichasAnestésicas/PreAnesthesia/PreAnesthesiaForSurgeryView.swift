//
//  PreAnesthesiaView 2.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 06/12/25.
//


//
//  PreAnesthesiaView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import SwiftUI
import SwiftData

struct PreAnesthesiaForSurgeryView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var preanesthesia: PreAnesthesia
    
    @State private var isPresentingForm = false
    @State private var formViewModel: PreAnesthesiaViewModel?
    
    var body: some View {
        NavigationStack {
            Group {
                let surgery = preanesthesia.surgery
                let pre = surgery.preanesthesia
                if pre != nil {
                    contentWhenAvailable
                } else {
                    contentUnavailable
                }
            }
            .navigationTitle("Avaliação Pré-Anestésica")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Editar Avaliação", systemImage: "pencil") {
                        presentEditForm(for: preanesthesia)
                    }
                }
            }
            .sheet(item: $formViewModel) { vm in
                PreAnesthesiaFormView(viewModel: vm)
            }
        }
    }
    
    private var contentWhenAvailable: some View {
        let surgery = preanesthesia.surgery
        let pre = preanesthesia
        return ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                apaCard(surgery: surgery)
                comorbiditiesCard(preanesthesia: pre)
                surgeryHistoryCard(preanesthesia: pre)
                apfelCard(preanesthesia: pre)
                socialAndEnvironmentCard(preanesthesia: pre)
                physicalExaminationCard(preanesthesia: pre)
                complementaryExamsCard(preanesthesia: pre)
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
                    if preanesthesia.shared?.asa != nil {
                        HStack {
                            Text("Classificação ASA:")
                                .fontWeight(.semibold)
                            Spacer()
                            if let asa = preanesthesia.shared?.asa { asa.badgeView }
                        }
                    }
                    if surgery.preanesthesia?.clearenceStatus != nil {
                        HStack {
                            Text("Apto:")
                                .fontWeight(.semibold)
                            Spacer()
                            if let clearanceStatus = pre?.clearenceStatus {
                                Text("\(clearanceStatus.displayName)")
                            }
                        }
                        if surgery.preanesthesia?.definitiveRecommendationForRevaluationStatus != nil || surgery.preanesthesia?.futherRecommendationForRevaluation != nil {
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
                    if surgery.shared?.techniques != nil {
                        HStack(alignment: .top) {
                            Text("Técnicas:")
                                .fontWeight(.semibold)
                            Spacer()
                            let techniques = (surgery.shared?.techniques ?? []).map { $0.displayName }
                            if !techniques.isEmpty {
                                Text(techniques.joined(separator: " • "))
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
                                    if let details = preanesthesia?.cardiologyDetails, !details.isEmpty {
                                        ForEach(details) { detail in
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(detail.displayName())
                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
                                    }
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
                                    if let details = preanesthesia?.respiratoryDetails, !details.isEmpty {
                                        ForEach(details) { detail in
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(detail.displayName())
                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
                                    }
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
                                    if let details = preanesthesia?.endocrineDetails, !details.isEmpty {
                                        ForEach(details) { detail in
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(detail.displayName())
                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.gastrointestinalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Gastrointestinais:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.gastroIntestinalDetails, !details.isEmpty {
                                        ForEach(details) { detail in
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(detail.displayName())
                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
                                    }
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
                    if preanesthesia?.infectiousComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Infecciosas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let infectiousDetails = preanesthesia?.infectiousComorbitiesDetails, !infectiousDetails.isEmpty {
                                        ForEach(infectiousDetails, id: \.self) { comorbidity in
                                            Text(comorbidity.displayName)
                                        }
                                    }
                                    if let customInfectiousDetails = preanesthesia?.infectiousComorbitiesCustomDetails, !customInfectiousDetails.isEmpty {
                                        ForEach(customInfectiousDetails, id: \.self) { customComorbity in
                                            Text(customComorbity)
                                        }
                                    }
                                    HStack {
                                        
                                    }
                                }
                            }
                            HStack(alignment: .top) {
                                if let infectiousDetailsText = preanesthesia?.infectiousComorbitiesDetailsText, !infectiousDetailsText.isEmpty {
                                    Text("Detalhes:")
                                        .fontWeight(.semibold)
                                        .font(.caption)
                                    Spacer()
                                    Text(infectiousDetailsText)
                                        .font(.caption)
                                }
                            }
                        }
                        Divider()
                    }
                    if preanesthesia?.oncologicComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Oncológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.oncologyDetails, !details.isEmpty {
                                        ForEach(details) { detail in
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(detail.displayName())
                                                if let notes = detail.notes, !notes.isEmpty {
                                                    Text(notes)
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        }
                                    }
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
                                Text("Genéticas:")
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
                Text("Cirurgias / Anestesias Prévias")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {

                    if preanesthesia?.surgeryHistory == true {
                        VStack(alignment: .leading, spacing: 12) {
                            let hasDefaultDetails = !(preanesthesia?.surgeryHistoryDetails?.isEmpty ?? true)
                            let hasCustomDetails = !((preanesthesia?.surgeryHistoryCustomDetails ?? []).isEmpty)
                            let hasTextDetails = !(preanesthesia?.surgeryHistoryDetailsText?.isEmpty ?? true)
                            let hasAnyDetails = hasDefaultDetails || hasCustomDetails || hasTextDetails
                            
                            
                            if !hasAnyDetails {
                                Text("Não houve eventos adversos em anestesias prévias")
                                    .fontWeight(.semibold)
                            } else {
                                Text("Cirurgias Prévias:")
                                    .fontWeight(.semibold)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            let defaultDetails = (preanesthesia?.surgeryHistoryDetails ?? []).map { $0.displayName }
                                            let customDetails = (preanesthesia?.surgeryHistoryCustomDetails ?? [])
                                            let allDetails = defaultDetails + customDetails
                                            
                                            if !allDetails.isEmpty {
                                                Text(allDetails.joined(separator: " • "))
                                                    .font(.subheadline)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fixedSize(horizontal: false, vertical: true)
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
                            .fontWeight(.semibold)
                    }
                    if preanesthesia?.anesthesiaHistory == true {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            let hasDefaultDetails = !(preanesthesia?.anesthesiaHistoryDetails?.isEmpty ?? true)
                            let hasCustomDetails = !((preanesthesia?.anesthesiaHistoryCustomDetails ?? []).isEmpty)
                            let hasTextDetails = !(preanesthesia?.anesthesiaHistoryDetailsText?.isEmpty ?? true)
                            let hasAnyDetails = hasDefaultDetails || hasCustomDetails || hasTextDetails
                                    
                            if !hasAnyDetails {
                                Text("Sem eventos adversos em anestesias prévias")
                                    .fontWeight(.semibold)
                            } else {
                                Text("Eventos adversos prévios:")
                                    .fontWeight(.semibold)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        let defaultDetails = (preanesthesia?.anesthesiaHistoryDetails ?? []).map { $0.displayName }
                                        let customDetails = (preanesthesia?.anesthesiaHistoryCustomDetails ?? [])
                                        let allDetails = defaultDetails + customDetails
                                        
                                        if !allDetails.isEmpty {
                                            Text(allDetails.joined(separator: " • "))
                                                .font(.subheadline)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
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
                            let apfelCount = preanesthesia?.apfelScoreDetails?.count ?? 0
                            HStack(spacing: 4){
                                Text("\(apfelCount)" )
                                    .fontWeight(.semibold)
                                if apfelCount == 1 {
                                    Text("Fator de risco")
                                        .fontWeight(.semibold)
                                } else {
                                    Text("Fatores de risco")
                                        .fontWeight(.semibold)
                                }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(alignment: .center) {
                                    let apfel = (preanesthesia?.apfelScoreDetails ?? []).map { $0.displayName}
                                    if !apfel.isEmpty {
                                        Text(apfel.joined(separator: " • "))
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
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
    
    private func socialAndEnvironmentCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cloud.sun.fill")
                    .foregroundStyle(.green)
                Text("Hábitos e Ambiente")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {
                    let socialHabitsAndEnvironmentDetails = !(preanesthesia?.socialHabitsAndEnvironmentDetails?.isEmpty ?? true)
                    if !socialHabitsAndEnvironmentDetails {
                        Text("Sem anotações relevantes quanto a hábitos sociais e ambiente.")
                            .fontWeight(.semibold)
                    } else {
                        VStack(alignment: .leading) {
                            Text("Hábitos Sociais")
                                .fontWeight(.semibold)
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 8) {
                                    let defaultDetails = (preanesthesia?.socialHabitsAndEnvironmentDetails ?? []).map { $0.displayName }
                                    let customDetails = (preanesthesia?.socialHabitsAndEnvironmentCustomDetails ?? [])
                                    let all = defaultDetails + customDetails

                                    if !all.isEmpty {
                                        Text(all.joined(separator: " • "))
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                                    }
                                }
                                HStack(alignment: .top) {
                                    if let socialHabitsAndEnvironmentDetailsText = preanesthesia?.socialHabitsAndEnvironmentDetailsText, !socialHabitsAndEnvironmentDetailsText.isEmpty {
                                        Text("Detalhes:")
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                        Spacer()
                                        Text(socialHabitsAndEnvironmentDetailsText)
                                            .font(.caption)
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
    
    private func physicalExaminationCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "stethoscope")
                    .foregroundStyle(.green)
                Text("Exame Físico e Via Aérea")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {
                    
                    let hasPhysicalExamination = !(preanesthesia?.physicalExaminationDetailsText?.isEmpty ?? true)
                    if !hasPhysicalExamination {
                        Text("Sem descrição do exame físico")
                            .fontWeight(.semibold)
                    } else {
                        VStack(alignment: .leading) {
                            Text("Exame Físico:")
                                .fontWeight(.semibold)
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let physicalExaminationDetailsText = preanesthesia?.physicalExaminationDetailsText, !physicalExaminationDetailsText.isEmpty {
                                        Text(physicalExaminationDetailsText)
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                                    }
                                }
                            }
                        }
                    }
                    
                    let hasMallampatiDetails = (preanesthesia?.mallampatiClassification != nil)
                    let hasDetails = !(preanesthesia?.difficultAirwayEvaluation?.isEmpty ?? true)
                    let hasCustomDetails = !((preanesthesia?.difficultAirwayEvaluationCustomDetails ?? []).isEmpty)
                    let hasTextDetails = !(preanesthesia?.difficultAirwayEvaluationDetailsText?.isEmpty ?? true)
                    let hasTraqueo = (preanesthesia?.difficultAirwayEvaluation?.contains(.traqueo) ?? false)
                    let hasAnyDetails = hasMallampatiDetails || hasDetails || hasCustomDetails || hasTextDetails
                    
                    
                    if hasTraqueo {
                        Text("Paciente possui via aérea definitiva")
                            .fontWeight(.semibold)
                    } else if hasAnyDetails {
                        VStack(alignment: .leading) {
                            Text("Avaliação de Vias Aéreas:")
                                .fontWeight(.semibold)
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let mallampatiDetails = preanesthesia?.mallampatiClassification {
                                        HStack {
                                            Text("Mallampati:")
                                                .fontWeight(.semibold)
                                            Text(mallampatiDetails.displayName)
                                                .font(.subheadline)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                            if hasTextDetails, hasCustomDetails, hasDetails {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Preditores:")
                                            .fontWeight(.semibold)
                                        VStack(alignment: .leading, spacing: 8) {
                                            let defaultEvaluations = (preanesthesia?.difficultAirwayEvaluation ?? []).filter { $0 != .traqueo }
                                            let defaultDetails = defaultEvaluations.map { $0.displayName }
                                            let customDetails = (preanesthesia?.difficultAirwayEvaluationCustomDetails ?? [])
                                            let all = defaultDetails + customDetails
                                            
                                            if !all.isEmpty {
                                                Text(all.joined(separator: " • "))
                                                    .font(.subheadline)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                                            }
                                        }
                                    }
                                    HStack(alignment: .top) {
                                        if let difficultAirwayEvaluationDetailsText = preanesthesia?.difficultAirwayEvaluationDetailsText, !difficultAirwayEvaluationDetailsText.isEmpty {
                                            Text("Detalhes:")
                                                .fontWeight(.semibold)
                                                .font(.caption)
                                            Spacer()
                                            Text(difficultAirwayEvaluationDetailsText)
                                                .font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // medicações e alergias
                    let hasCustomMedicationDetails = !((preanesthesia?.dailyMedicationsCustomDetails ?? []).isEmpty)
                    let hasAllergies = preanesthesia?.hasAllergies
                    let hasCustomAllergiesDetails = !((preanesthesia?.allergiesMedicationsCustomDetails ?? []).isEmpty)
                   
                    VStack(alignment: .leading, spacing: 12) {
                        if !hasCustomMedicationDetails {
                            Text("Não faz uso de medicações")
                                .fontWeight(.semibold)
                        } else {
                            VStack(alignment: .leading) {
                                Text("Medicamentos em uso:")
                                    .fontWeight(.semibold)
                                let customDetails = (preanesthesia?.dailyMedicationsCustomDetails ?? [])
                                if !customDetails.isEmpty {
                                    Text(customDetails.joined(separator: " • "))
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
                                }
                            }
                        }
                        if !(hasAllergies ?? false) {
                            Text("Sem história de alergias")
                                .fontWeight(.semibold)
                        } else if hasCustomAllergiesDetails {
                            HStack {
                                Text("Alergias à:")
                                    .fontWeight(.semibold)
                                let customDetails = (preanesthesia?.allergiesMedicationsCustomDetails ?? [])
                                if !customDetails.isEmpty {
                                    Text(customDetails.joined(separator: " • "))
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true) // garante quebra vertical
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
    // Adicione esta função após physicalExaminationCard

    private func complementaryExamsCard(preanesthesia: PreAnesthesia?) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chart.bar.doc.horizontal")
                    .foregroundStyle(.blue)
                Text("Exames Complementares")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 26) {
                
                // EXAMES LABORATORIAIS
                let labs = preanesthesia?.laboratoryExams
                let hasHemoglobin = labs?.hemoglobin != nil
                let hasUrea = labs?.urea != nil
                let hasCreatinine = labs?.creatinine != nil
                let hasSodium = labs?.sodium != nil
                let hasPotassium = labs?.potassium != nil
                let hasInr = labs?.inr != nil
                let hasGlucose = labs?.glucose != nil
                let hasAnyLabExam = hasHemoglobin || hasUrea || hasCreatinine || hasSodium || hasPotassium || hasInr || hasGlucose
                
                if !hasAnyLabExam {
                    Text("Sem exames laboratoriais registrados")
                        .fontWeight(.semibold)
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Exames Laboratoriais:")
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            if let hemoglobin = labs?.hemoglobin {
                                HStack {
                                    Text("Hemoglobina:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", hemoglobin)) g/dL")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let urea = labs?.urea {
                                HStack {
                                    Text("Ureia:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.0f", urea)) mg/dL")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let creatinine = labs?.creatinine {
                                HStack {
                                    Text("Creatinina:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.2f", creatinine)) mg/dL")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let sodium = labs?.sodium {
                                HStack {
                                    Text("Sódio:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.0f", sodium)) mEq/L")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let potassium = labs?.potassium {
                                HStack {
                                    Text("Potássio:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", potassium)) mEq/L")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let inr = labs?.inr {
                                HStack {
                                    Text("INR:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.2f", inr))")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                            
                            if let glucose = labs?.glucose {
                                HStack {
                                    Text("Glicemia:")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.0f", glucose)) mg/dL")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                            }
                        }
                    }
                }
                
                // EXAMES DE IMAGEM
                let imagingExams = preanesthesia?.imagingExams ?? []
                let customImagingExams = preanesthesia?.customImagingExams ?? []
                let hasImagingExams = !imagingExams.isEmpty
                let hasCustomImagingExams = !customImagingExams.isEmpty
                let hasAnyImagingExam = hasImagingExams || hasCustomImagingExams
                
                if !hasAnyImagingExam {
                    Text("Sem exames de imagem registrados")
                        .fontWeight(.semibold)
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Exames de Imagem:")
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            // Exames padrão com achados
                            ForEach(imagingExams) { exam in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(exam.type.displayName)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    if !exam.findings.isEmpty {
                                        let findingsText = exam.findings.map { finding in
                                            switch finding {
                                            case .chestXRay(let xrayFinding):
                                                return xrayFinding.displayName
                                            case .ecg(let ecgFinding):
                                                return ecgFinding.displayName
                                            case .echocardiogram(let echoFinding):
                                                return echoFinding.displayName
                                            }
                                        }.joined(separator: " • ")
                                        
                                        Text(findingsText)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    
                                    if let customFinding = exam.customFinding, !customFinding.isEmpty {
                                        Text(customFinding)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                            
                            // Exames customizados
                            if hasCustomImagingExams {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Outros exames:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Text(customImagingExams.joined(separator: " • "))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                }
                
                Divider()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    // MARK: - Helpers
    
    private func presentNewForm() {
        // Ajuste a forma de obter o usuário conforme a API real do seu SessionManager
        if let user = session.currentUser {
            let repo = SwiftDataPreAnesthesiaRepository(context: modelContext)
            let sharedRepo = SwiftDataSharedPreAndAnesthesiaRepository(context: modelContext)
            let vm = PreAnesthesiaViewModel(
                newFor: preanesthesia.surgery,
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

