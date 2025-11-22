//
//  SedationAnesthesiaSectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/11/25.
//

import SwiftUI
import Observation

struct SedationAnesthesiaSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  sedationTechniquePicker
                  sedationTypeMethodPicker
                  if viewModel.techniques.sedationType != .inalatory {
                      intraVenousSedationTypePicker
                  }
                  sedationOxygenSupplyPicker
                  
              } header: {
                  HStack {
                      Text("Sedação")
                      Spacer()
                      Button("Sugerir", systemImage: "wand.and.sparkles"){
                          viewModel.techniques.applySedationSuggestion(patientAge: viewModel.patientAge)
                      }
                  }
              }
          }
          .navigationTitle("Sedação")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }

    private var sedationTechniquePicker: some View {
        Picker("Nível", selection: $viewModel.techniques.sedationTechnique) {
            Text("Não informado").tag(nil as SedationTechniqueKind?)
            ForEach(SedationTechniqueKind.allCases, id: \.self) { (kind: SedationTechniqueKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var sedationTypeMethodPicker: some View {
        Picker("Tipo", selection: $viewModel.techniques.sedationType) {
            Text("Não informado").tag(nil as SedationType?)
            ForEach(SedationType.allCases, id: \.self) { (kind: SedationType) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var intraVenousSedationTypePicker: some View {
        Picker("Intravenosa", selection: $viewModel.techniques.intraVenousSedationType) {
            Text("Não informado").tag(nil as IntraVenousSedationType?)
            ForEach(IntraVenousSedationType.allCases, id: \.self) { (kind: IntraVenousSedationType) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var sedationOxygenSupplyPicker: some View {
        Picker("Suporte de Oxigênio", selection: $viewModel.techniques.sedationOxygenSupply) {
            Text("Não informado").tag(nil as SedationOxygenSupplyKind?)
            ForEach(SedationOxygenSupplyKind.allCases, id: \.self) { (kind: SedationOxygenSupplyKind) in
                Text(kind.DisplayName(for: viewModel.patientAge))
                    .tag(Optional(kind))
            }
        }
    }
}

