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
                  Text("Raquianestesia")
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
    private var needlePicker: some View {
        Picker("Agulha", selection: $viewModel.techniques.raquiNeedle) {
            Text("Não informado").tag(nil as SpinalAndEpiduralLevel?)
            ForEach(SpinalAndEpiduralNeedle.allCases, id: \.self) { (kind: SpinalAndEpiduralNeedle) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var levelPicker: some View {
        Picker("Nível", selection: $viewModel.techniques.raquiLevel) {
            Text("Não informado").tag(nil as SpinalAndEpiduralLevel?)
            ForEach(SpinalAndEpiduralLevel.allCases, id: \.self) { (kind: SpinalAndEpiduralLevel) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var gaugePicker: some View {
        Picker("Calibre Agulha", selection: $viewModel.techniques.raquiNeedleGauge) {
            Text("Não informado").tag(nil as TubeType?)
            ForEach(SpinalAndEpiduralGaugeKind.allCases, id: \.self) { (kind: SpinalAndEpiduralGaugeKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
}

