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
            isPregnant
            isInfant
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
        .navigationTitle("Recomendações")
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
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.isPregnant
        )
    }
    private var isInfant: some View {
        Toggle(
            "Menor de um ano",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.isInfant
        )
    }
    private var cardiacComorbities: some View {
        Toggle(
            "Comorbidades Cardiológicas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.cardiacComorbities
        )
    }
    private var respiratoryComorbities: some View {
        Toggle(
            "Comorbidades Respiratórias",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.respiratoryComorbities
        )
    }
    private var endocrinesComorbities: some View {
        Toggle(
            "Comorbidades Endócrinas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.endocrineComorbities
        )
    }
    private var musculoskeletalComorbities: some View {
        Toggle(
            "Comorbidades Musculoesqueléticas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.musculoskeletalComorbities
        )
    }
    private var gastrointestinalComorbities: some View {
        Toggle(
            "Comorbidades Gastrointestinais",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.gastrointestinalComorbities
        )
    }
    private var hematilogicalComorbities: some View {
        Toggle(
            "Comorbidades Hematológicas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.hematologicalComorbities
        )
    }
    private var neurologicalComorbities: some View {
        Toggle(
            "Comorbidades Neurológicas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.neurologicalComorbities
        )
    }
    private var genitourologicalComorbities: some View {
        Toggle(
            "Comorbidades Genitourológicas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.genitourologicalComorbities
        )
    }
    private var geneticSyndrome: some View {
        Toggle(
            "Síndromes Genéticas",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.comorbities.geneticSyndrome
        )
    }
    
}
