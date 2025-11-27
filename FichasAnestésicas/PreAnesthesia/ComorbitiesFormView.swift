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
        NavigationStack {
            Form {
                if viewModel.patientSex == .female && viewModel.patientAge > 12 {
                    Section {
                        isPregnant
                    } header: {
                        Text("Gestação")
                    }
                }
                if viewModel.patientAge < 2{
                    Section {
                        isInfant
                    } header: {
                        Text("Lactente")
                    }
                }
                Section {
                    cardiacComorbities
                } header: {
                    Text("Cardíacas")
                }
                Section {
                    respiratoryComorbities
                } header: {
                    Text("Respiratórias")
                }
                Section {
                    endocrinesComorbities
                } header: {
                    Text("Endocrino e Metabólica")
                }
                Section {
                    gastrointestinalComorbities
                } header: {
                    Text("Gastrointestinal")
                }
                Section {
                    hematilogicalComorbities
                } header: {
                    Text("Hematológicas")
                }
                Section {
                    Text("Imunológicas - a ser implementado")
                } header: {
                    Text("Imunológicas")
                }
                Section {
                    musculoskeletalComorbities
                } header: {
                    Text("Músculoesquelético")
                }
                Section {
                    genitourologicalComorbities
                } header: {
                    Text("Genitourinárias")
                }
                Section {
                    neurologicalComorbities
                } header: {
                    Text("Neurológicas")
                }
                Section {
                    geneticSyndrome
                } header: {
                    Text("Síndromes Genéticas")
                }
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
            "Lactente",
            systemImage: "figure.child.circle.fill",
            isOn: $viewModel.comorbities.isInfant
        )
    }
    private var cardiacComorbities: some View {
        Toggle(
            "Cardiológicas",
            systemImage: "heart.circle.fill",
            isOn: $viewModel.comorbities.cardiacComorbities
        )
    }
    private var respiratoryComorbities: some View {
        Toggle(
            "Respiratórias",
            systemImage: "lungs.fill",
            isOn: $viewModel.comorbities.respiratoryComorbities
        )
    }
    private var endocrinesComorbities: some View {
        Toggle(
            "Endócrinas",
            systemImage: "syringe.fill",
            isOn: $viewModel.comorbities.endocrineComorbities
        )
    }
    private var musculoskeletalComorbities: some View {
        Toggle(
            "Musculoesqueléticas",
            systemImage: "figure.run.circle.fill",
            isOn: $viewModel.comorbities.musculoskeletalComorbities
        )
    }
    private var gastrointestinalComorbities: some View {
        Toggle(
            "Gastrointestinais",
            systemImage: "fork.knife.circle.fill",
            isOn: $viewModel.comorbities.gastrointestinalComorbities
        )
    }
    private var hematilogicalComorbities: some View {
        Toggle(
            "Hematológicas",
            systemImage: "ivfluid.bag",
            isOn: $viewModel.comorbities.hematologicalComorbities
        )
    }
    private var neurologicalComorbities: some View {
        Toggle(
            "Neurológicas",
            systemImage: "brain.head.profile.fill",
            isOn: $viewModel.comorbities.neurologicalComorbities
        )
    }
    private var genitourologicalComorbities: some View {
        Toggle(
            "Genitourológicas",
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
