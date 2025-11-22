//
//  GeneralAnesthesiaSectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/11/25.
//

import SwiftUI
import Observation

struct GeneralAnesthesiaSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  tubeAcessPicker
                  visualizationMethodPicker
                  equipmentMethodPicker
                  commarckPicker
                  tubeTypePicker
                  tubeCuffPicker
                  tubeRoutePicker
                  totNumberField
                  totFixationField
                  
              } header: {
                  Text("Anestesia Geral")
              }
          }
          .navigationTitle("Anestesia Geral")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }

    private var visualizationMethodPicker: some View {
        Picker("Visualização", selection: $viewModel.techniques.visualizationMethod) {
            Text("Não informado").tag(nil as VisualizationMethod?)
            ForEach(VisualizationMethod.allCases, id: \.self) { (kind: VisualizationMethod) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var equipmentMethodPicker: some View {
        Picker("Equipamento", selection: $viewModel.techniques.equipment) {
            Text("Não informado").tag(nil as LaringoschopyEquipment?)
            ForEach(LaringoschopyEquipment.allCases, id: \.self) { (kind: LaringoschopyEquipment) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var commarckPicker: some View {
        Picker("Cormarck-Lehane", selection: $viewModel.techniques.cormack) {
            Text("Não informado").tag(nil as CormackLehane?)
            ForEach(CormackLehane.allCases, id: \.self) { (kind: CormackLehane) in
                Text(kind.ShortLabel)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var tubeTypePicker: some View {
        Picker("Tipo de tubo", selection: $viewModel.techniques.tubeType) {
            Text("Não informado").tag(nil as TubeType?)
            ForEach(TubeType.allCases, id: \.self) { (kind: TubeType) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var tubeAcessPicker: some View {
        Picker("Entubação", selection: $viewModel.techniques.tubeAcess) {
            Text("Não informado").tag(nil as TubeAcess?)
            ForEach(TubeAcess.allCases, id: \.self) { (kind: TubeAcess) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var tubeCuffPicker: some View {
        Picker("Cuff", selection: $viewModel.techniques.tubeCuff) {
            Text("Não informado").tag(nil as TubeCuff?)
            ForEach(TubeCuff.allCases, id: \.self) { (kind: TubeCuff) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var tubeRoutePicker: some View {
        Picker("Oral/Nasal", selection: $viewModel.techniques.tubeRoute) {
            Text("Não informado").tag(nil as TubeRoute?)
            ForEach(TubeRoute.allCases, id: \.self) { (kind: TubeRoute) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var totNumberField: some View {
        HStack {
            Text("Diâmetro do tubo")
            TextField("7,5", text: Binding(
                get: { viewModel.techniques.totNumber ?? "" },
                set: { viewModel.techniques.totNumber = $0 }
            ))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
    private var totFixationField: some View {
        HStack {
            Text("Fixação do tubo")
            TextField("22", text: Binding(
                get: { viewModel.techniques.fixation ?? "" },
                set: { viewModel.techniques.fixation = $0 }
            ))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
    
}

