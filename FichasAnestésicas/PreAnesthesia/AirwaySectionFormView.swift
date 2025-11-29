//
//  AirwaySectionFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import Observation

struct AirwaySectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: PreAnesthesiaViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  mallampatiPicker
                  difficultAirwayPicker
                  
              } header: {
                  Text("Avaliação Via Aérea")
              }
          }
          .navigationTitle("Avaliação Via Aérea")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }
    private var mallampatiPicker: some View {
        Picker("Mallampati", selection: $viewModel.airway.mallampatiClassification) {
            Text("Não informado").tag(nil as MallampatiClassification?)
            ForEach(MallampatiClassification.allCases, id: \.self) { (kind: MallampatiClassification) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var difficultAirwayPicker: some View {
        Picker("Preditivos VA Difícil", selection: $viewModel.airway.difficultAirwayEvaluation) {
            Text("Não informado").tag(nil as DifficultAirwayEvaluation?)
            ForEach(DifficultAirwayEvaluation.allCases, id: \.self) { (kind: DifficultAirwayEvaluation) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    
}

