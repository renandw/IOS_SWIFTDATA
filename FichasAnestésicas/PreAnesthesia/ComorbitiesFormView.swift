//
//  ComorbitiesFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 25/11/25.
//
import SwiftUI

struct ComorbitiesFormView: View {
    
    @Bindable var viewModel: PreAnesthesiaViewModel

    var body: some View {
        List {
            if viewModel.patientSex == .female && viewModel.patientAge > 12 {
                isPregnant
            }
            if viewModel.patientAge < 1{
                Text("\(viewModel.patientAge)")
                isInfant
            }
            cardiacComorbities
            respiratoryComorbities
            endocrinesComorbities
            gastrointestinalComorbities
            hematilogicalComorbities
            musculoskeletalComorbities
            genitourologicalComorbities
            neurologicalComorbities
            geneticSyndrome
        }
        .navigationTitle("Comorbidades")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Menu("Opções", systemImage: "gear") {
//                    Button("Selecionar tudo") { selection = recommendations }
//                    Button("Limpar seleção", role: .destructive) { selection.removeAll() }
//                }
//            }
        }
    }
    
    private var isPregnant: some View {
        Toggle(
            "Gestante",
            systemImage: "figure.seated.side.right.child.lap",
            isOn: $viewModel.comorbities.isPregnant
        )
    }
    private var isInfant: some View {
        Toggle(
            "Menor de um ano",
            systemImage: "figure.child.circle.fill",
            isOn: $viewModel.comorbities.isInfant
        )
    }
    private var cardiacComorbities: some View {
        Toggle(
            "Comorbidades Cardiológicas",
            systemImage: "heart.circle.fill",
            isOn: $viewModel.comorbities.cardiacComorbities
        )
    }
    private var respiratoryComorbities: some View {
        Toggle(
            "Comorbidades Respiratórias",
            systemImage: "lungs",
            isOn: $viewModel.comorbities.respiratoryComorbities
        )
    }
    private var endocrinesComorbities: some View {
        Toggle(
            "Comorbidades Endócrinas",
            systemImage: "syringe.fill",
            isOn: $viewModel.comorbities.endocrineComorbities
        )
    }
    private var musculoskeletalComorbities: some View {
        Toggle(
            "Comorbidades Musculoesqueléticas",
            systemImage: "figure.run.circle.fill",
            isOn: $viewModel.comorbities.musculoskeletalComorbities
        )
    }
    private var gastrointestinalComorbities: some View {
        Toggle(
            "Comorbidades Gastrointestinais",
            systemImage: "fork.knife.circle",
            isOn: $viewModel.comorbities.gastrointestinalComorbities
        )
    }
    private var hematilogicalComorbities: some View {
        Toggle(
            "Comorbidades Hematológicas",
            systemImage: "ivfluid.bag",
            isOn: $viewModel.comorbities.hematologicalComorbities
        )
    }
    private var neurologicalComorbities: some View {
        Toggle(
            "Comorbidades Neurológicas",
            systemImage: "brain.head.profile.fill",
            isOn: $viewModel.comorbities.neurologicalComorbities
        )
    }
    private var genitourologicalComorbities: some View {
        Toggle(
            "Comorbidades Genitourológicas",
            systemImage: "toilet.fill",
            isOn: $viewModel.comorbities.genitourologicalComorbities
        )
    }
    private var geneticSyndrome: some View {
        Toggle(
            "Síndromes Genéticas",
            systemImage: "apple.meditate.circle.fill",
            isOn: $viewModel.comorbities.geneticSyndrome
        )
    }
    
}
