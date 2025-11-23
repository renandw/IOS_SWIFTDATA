//
//  SpinalAnesthesiaSectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/11/25.
//

import SwiftUI
import Observation

struct SpinalAnesthesiaSectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    spinalAnesthesiaPositionPicker
                    needlePicker
                    levelPicker
                    gaugePicker
                    
                    
                } header: {
                    HStack {
                        Text("Anestesia Geral")
                        Spacer()
                        Button("Sugerir", systemImage: "wand.and.sparkles"){
                            viewModel.techniques.applySpinalAnesthesiaSuggestion(patientAge: viewModel.patientAge)
                        }
                    }
                }
            }
            .navigationTitle("Raquianestesia")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluir") { dismiss() }
                }
            }
        }
    }
    
    private var spinalAnesthesiaPositionPicker: some View {
        Picker("Posicionamento", selection: $viewModel.techniques.raquiPosition) {
            Text("Não informado").tag(nil as SpinalAndEpiduralPosition?)
            ForEach(SpinalAndEpiduralPosition.allCases, id: \.self) { (kind: SpinalAndEpiduralPosition) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private let spinalAllowedNeedlesForRaqui: [SpinalAndEpiduralNeedle] = [
        .quincke, .whitacre
    ]
    
    private var needlePicker: some View {
        Picker("Agulha", selection: $viewModel.techniques.raquiNeedle) {
            Text("Não informado").tag(nil as SpinalAndEpiduralLevel?)
            ForEach(spinalAllowedNeedlesForRaqui, id: \.self) { (kind: SpinalAndEpiduralNeedle) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private let spinalAllowedLevelsForRaqui: [SpinalAndEpiduralLevel] = [
        .t11, .t12, .l1, .l2, .l3, .l4, .l5, .sacral
    ]
    
    private var levelPicker: some View {
        Picker("Nível", selection: $viewModel.techniques.raquiLevel) {
            Text("Não informado").tag(nil as SpinalAndEpiduralLevel?)
            ForEach(spinalAllowedLevelsForRaqui, id: \.self) { kind in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private let spinalAllowedGaugeKindsForRaqui: [SpinalAndEpiduralGaugeKind] = [
        .g22, .g24, .g25, .g26, .g27
    ]
    
    private var gaugePicker: some View {
        Picker("Calibre Agulha", selection: $viewModel.techniques.raquiNeedleGauge) {
            Text("Não informado").tag(nil as TubeType?)
            ForEach(spinalAllowedGaugeKindsForRaqui, id: \.self) { (kind: SpinalAndEpiduralGaugeKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
}

