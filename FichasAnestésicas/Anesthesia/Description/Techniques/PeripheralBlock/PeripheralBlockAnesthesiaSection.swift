//
//  PeripheralBlockAnesthesiaSection.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 22/11/25.
//

import SwiftUI
import Observation

struct PeripheralBlockAnesthesiaSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  blockEquipmentPicker
                  mmssTechniquePicker
                  mmiiTechniquePicker
                  abdominalToraxPicker
                  blockSidePicker
                  blockOthersField
                  
              } header: {
                  HStack {
                      Text("Bloqueios Periféricos")
                      Spacer()
                      Button("Sugerir", systemImage: "wand.and.sparkles"){
                          viewModel.techniques.applyPeripheralBlockAnesthesiaSuggestion()
                      }
                  }
              }
          }
          .navigationTitle("Bloqueios Periféricos")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }

    private var blockEquipmentPicker: some View {
        Picker("Equipamento", selection: $viewModel.techniques.blockEquipment) {
            Text("Não informado").tag(nil as BlockEquipmentKind?)
            ForEach(BlockEquipmentKind.allCases, id: \.self) { (kind: BlockEquipmentKind) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    private var mmssTechniquePicker: some View {
        Picker("Membros Superiores", selection: $viewModel.techniques.mmssTechnique) {
            Text("Não informado").tag(nil as MMSSTechnique?)
            ForEach(MMSSTechnique.allCases, id: \.self) { (kind: MMSSTechnique) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var mmiiTechniquePicker: some View {
        Picker("Membros Inferiores", selection: $viewModel.techniques.mmiiTechnique) {
            Text("Não informado").tag(nil as MMIITechnique?)
            ForEach(MMIITechnique.allCases, id: \.self) { (kind: MMIITechnique) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }
    
    private var abdominalToraxPicker: some View {
        Picker("Tórax e Abdomen", selection: $viewModel.techniques.abdominalToraxTechnique) {
            Text("Não informado").tag(nil as AbdominalToraxTechnique?)
            ForEach(AbdominalToraxTechnique.allCases, id: \.self) { (kind: AbdominalToraxTechnique) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var blockSidePicker: some View {
        Picker("Lateralidade", selection: $viewModel.techniques.blockSide) {
            Text("Não informado").tag(nil as BlockSide?)
            ForEach(BlockSide.allCases, id: \.self) { (kind: BlockSide) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var blockOthersField: some View {
        HStack {
            Text("Outros Bloqueios")
            TextField("Descreva Outros Bloqueios", text: Binding(
                get: { viewModel.techniques.blockOthers ?? ""},
                set: { viewModel.techniques.blockOthers = $0 }
            ))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
}

