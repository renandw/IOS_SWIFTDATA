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
              Section("Mallampati") {
                  mallampatiPicker
              }
              
              NewComorbidityDetailSection<DifficultAirwayDetail, DifficultAirwayEvaluation>(
                title: "Preditores Via Aérea Difícil",
                icon: "face.smiling",
                isEnabled: .constant(nil),
                details: $viewModel.airway.difficultAirwayDetails,
                createDetail: { DifficultAirwayDetail(type: $0) },
                createCustomDetail: { DifficultAirwayDetail(customName: $0) }
              )
              
          }
          .navigationTitle("Avaliação Via Aérea")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir", systemImage: "checkmark") {
                      do {
                          try viewModel.save()
                          dismiss()
                      } catch {
                          print("Erro ao salvar: \(error)")
                      }
                  }
                  .disabled(!viewModel.airway.canSave)
              }
          }
      }
  }
    private var mallampatiPicker: some View {
        
            Picker("", selection: $viewModel.airway.mallampatiClassification) {
                ForEach(MallampatiClassification.allCases, id: \.self) { kind in
                    Text(kind.displayName).tag(Optional(kind))
                }
            }
            .pickerStyle(.segmented)
    }
}
