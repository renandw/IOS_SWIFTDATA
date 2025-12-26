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
                    if anesthesia.surgery.shared?.techniques != nil {
                        HStack(alignment: .top) {
                            Text("Técnicas:")
                                .fontWeight(.semibold)
                            Spacer()
                            let techniques = (anesthesia.surgery.shared?.techniques ?? []).map { $0.displayName }
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
                    if preanesthesia?.isInfant == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Menor de 1 ano:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.infantDetails, !details.isEmpty {
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
                                    if let details = preanesthesia?.pregnancyDetails, !details.isEmpty {
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
                                    if let details = preanesthesia?.hematologyDetails, !details.isEmpty {
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
                    if preanesthesia?.imunologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Imunológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.imunologyDetails, !details.isEmpty {
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
                    if preanesthesia?.musculoskeletalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Músculo-esqueléticos:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.musculoskeletalDetails, !details.isEmpty {
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
                    if preanesthesia?.genitourologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Genitourinárias:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.genitoUrinaryDetails, !details.isEmpty {
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
                    if preanesthesia?.gynecologicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Ginecológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.gynecologyDetails, !details.isEmpty {
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
                    if preanesthesia?.androgenicalComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Andrológicas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.androgenyDetails, !details.isEmpty {
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
                    if preanesthesia?.infectiousComorbities == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Infecciosas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.infectiousDetails, !details.isEmpty {
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
                                    if let details = preanesthesia?.neurologyDetails, !details.isEmpty {
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
                    if preanesthesia?.geneticSyndrome == true {
                        VStack(alignment: .trailing, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("Genéticas:")
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let details = preanesthesia?.geneticSyndromeDetails, !details.isEmpty {
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
                // Histórico Cirúrgico
                if preanesthesia?.surgeryHistory == true {
                    VStack(alignment: .leading, spacing: 12) {
                        if let details = preanesthesia?.surgeryHistoricDetails, !details.isEmpty {
                            Text("Cirurgias Prévias:")
                                .fontWeight(.semibold)
                            
                            Text(formatDetails(details))
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("Não houve eventos adversos em anestesias prévias")
                                .fontWeight(.semibold)
                        }
                    }
                } else if preanesthesia?.surgeryHistory == false {
                    Text("Paciente não tem histórico de ter realizado cirurgias")
                } else {
                    Text("Histórico cirúrgico não informado")
                        .fontWeight(.semibold)
                }
                
                // Histórico Anestésico
                if preanesthesia?.anesthesiaHistory == true {
                    VStack(alignment: .leading, spacing: 12) {
                        if let details = preanesthesia?.anesthesiaHistoricDetails, !details.isEmpty {
                            Text("Eventos adversos prévios:")
                                .fontWeight(.semibold)
                            
                            Text(formatDetails(details))
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("Sem eventos adversos em anestesias prévias")
                                .fontWeight(.semibold)
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }


    private func formatDetails<T: ComorbidityDetailProtocol>(_ details: [T]) -> String {
        details.map { detail in
            let name = detail.displayName()
            if let notes = detail.notes, !notes.isEmpty {
                return "\(name) (\(notes))"
            }
            return name
        }.joined(separator: " • ")
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

