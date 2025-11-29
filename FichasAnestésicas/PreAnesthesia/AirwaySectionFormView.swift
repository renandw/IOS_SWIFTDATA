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
    
    @Binding var selection: [DifficultAirwayEvaluation]
        @State private var newCustomDifficultAirwayEvaluation = ""

  var body: some View {
      NavigationStack {
          Form {
              Section("Mallampati") {
                  mallampatiPicker
              }
              Section {
                  
                  difficultAirwayContent
                  
              } header: {
                  Text("Preditores")
              }
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
    private var difficultAirwayContent: some View {
            Group {
                ForEach(difficultAirwayDetails, id: \.self) { kind in
                    Button {
                        toggle(kind)
                    } label: {
                        HStack {
                            Text(kind.displayName)
                            Spacer()
                            if selection.contains(kind) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.blue)
                            } else {
                                Image(systemName: "circle.dashed")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
                ForEach(viewModel.airway.difficultAirwayEvaluationCustomDetails, id: \.self) { name in
                    Button {
                        if let index = viewModel.airway.difficultAirwayEvaluationCustomDetails.firstIndex(of: name) {
                            viewModel.airway.removeDifficultEvaluationCustomDetails(at: index)
                        }
                    } label: {
                        HStack {
                            Text(name)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                HStack {
                    TextField("Adicionar Comorbidades", text: $newCustomDifficultAirwayEvaluation)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .onSubmit {
                            viewModel.airway.addDifficultEvaluationCustomDetails(newCustomDifficultAirwayEvaluation)
                            newCustomDifficultAirwayEvaluation = ""
                        }
                    if !newCustomDifficultAirwayEvaluation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {
                            viewModel.airway.addDifficultEvaluationCustomDetails(newCustomDifficultAirwayEvaluation)
                            newCustomDifficultAirwayEvaluation = ""
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                }
                if !viewModel.airway.difficultAirwayEvaluationCustomDetails.isEmpty || ((viewModel.airway.difficultAirwayEvaluation?.isEmpty == false)) {
                    difficultAirwayDetailsText
                }
            }
        }
        
        private var difficultAirwayDetails: [DifficultAirwayEvaluation] {
            DifficultAirwayEvaluation.allCases.sorted { a, b in
                a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
            }
        }
        
        private func toggle(_ kind: DifficultAirwayEvaluation) {
            if let idx = selection.firstIndex(of: kind) {
                selection.remove(at: idx)
            } else {
                selection.append(kind)
            }
        }
        
        private var difficultAirwayDetailsText: some View {
            HStack {
                Text("Detalhes")
                TextField(
                    "Informações adicionais",
                    text: Binding<String>(
                        get: { viewModel.airway.difficultAirwayEvaluationDetailsText ?? "" },
                        set: { newValue in
                            viewModel.airway.difficultAirwayEvaluationDetailsText = newValue.isEmpty ? nil : newValue
                        }
                    )
                )
                .multilineTextAlignment(.trailing)
            }
        }

    
}
