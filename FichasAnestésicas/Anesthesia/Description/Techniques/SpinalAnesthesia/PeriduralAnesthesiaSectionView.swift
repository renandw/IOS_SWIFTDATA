//
//  PeriduralAnesthesiaSectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/11/25.
//

import SwiftUI
import Observation

struct PeriduralAnesthesiaSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  periduralAnesthesiaPositionPicker
                  needlePicker
                  levelPicker
                  gaugePicker
                  cateterFixationField
                  
                  
              } header: {
                  HStack {
                      Text("Anestesia Peridural")
                      Spacer()
                      Button("Sugerir", systemImage: "wand.and.sparkles"){
                          viewModel.techniques.applyPeriduralAnesthesiaSuggestion(patientAge: viewModel.patientAge)
                      }
                  }
              }
          }
          .navigationTitle("Anestesia Peridural")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }

    private var periduralAnesthesiaPositionPicker: some View {
        Picker("Posicionamento", selection: $viewModel.techniques.periduralPosition) {
            Text("Não informado").tag(nil as SpinalAndEpiduralPosition?)
            ForEach(SpinalAndEpiduralPosition.allCases, id: \.self) { (kind: SpinalAndEpiduralPosition) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private let periduralAllowedNeedlesForRaqui: [SpinalAndEpiduralNeedle] = [
        .thuohy, .thuohysoho, .caudal
    ]
    private var needlePicker: some View {
        Picker("Agulha", selection: $viewModel.techniques.periduralNeedle) {
            Text("Não informado").tag(nil as SpinalAndEpiduralNeedle?)
            ForEach(periduralAllowedNeedlesForRaqui, id: \.self) { (kind: SpinalAndEpiduralNeedle) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var levelPicker: some View {
        Picker("Nível", selection: $viewModel.techniques.periduralLevel) {
            Text("Não informado").tag(nil as SpinalAndEpiduralLevel?)
            ForEach(SpinalAndEpiduralLevel.allCases, id: \.self) { (kind: SpinalAndEpiduralLevel) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private let periduralAllowedGaugeKindsForRaqui: [SpinalAndEpiduralGaugeKind] = [
        .g16, .g17, .g18, .g20, .g22
    ]
    private var gaugePicker: some View {
        Picker("Calibre Agulha", selection: $viewModel.techniques.periduralNeedleGauge) {
            Text("Não informado").tag(nil as SpinalAndEpiduralGaugeKind?)
            ForEach(periduralAllowedGaugeKindsForRaqui, id: \.self) { (kind: SpinalAndEpiduralGaugeKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var techniquePicker: some View {
        Picker("Técnica", selection: $viewModel.techniques.periduralNeedleGauge) {
            Text("Não informado").tag(nil as PeriduralTechniqueKind?)
            ForEach(PeriduralTechniqueKind.allCases, id: \.self) { (kind: PeriduralTechniqueKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var cateterFixationField: some View {
        HStack {
            Text("Fixação do Cateter")
            TextField("4cm", text: Binding(
                get: { viewModel.techniques.periduralCateterFixation ?? "" },
                set: { viewModel.techniques.periduralCateterFixation = $0 }
            ))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
}

