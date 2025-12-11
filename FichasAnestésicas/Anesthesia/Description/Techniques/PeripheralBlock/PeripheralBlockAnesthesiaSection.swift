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
                  NavigationLink("Membros Superiores") {
                      MMSSSelectionView(viewModel: viewModel)
                  }
                  NavigationLink("Membros Inferiores") {
                      MMIISelectionView(viewModel: viewModel)
                  }
                  NavigationLink("Abdome e Tórax") {
                      AbdominalToraxSelectionView(viewModel: viewModel)
                  }
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
        Section("Membros Superiores") {
            ForEach(MMSSTechnique.allCases, id: \.self) { technique in
                Button {
                    toggleMMSS(technique)
                } label: {
                    HStack {
                        Text(technique.DisplayName)
                        Spacer()
                        if (viewModel.techniques.mmssTechnique == technique) {
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
        }
    }
    
    private var mmiiTechniquePicker: some View {
        Section("Membros Inferiores") {
            ForEach(MMIITechnique.allCases, id: \.self) { technique in
                Button {
                    toggleMMII(technique)
                } label: {
                    HStack {
                        Text(technique.DisplayName)
                        Spacer()
                        if (viewModel.techniques.mmiiTechnique == technique) {
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
        }
    }
    
    private var abdominalToraxPicker: some View {
        Section("Abdome e Tórax") {
            ForEach(AbdominalToraxTechnique.allCases, id: \.self) { technique in
                Button {
                    toggleAbdominal(technique)
                } label: {
                    HStack {
                        Text(technique.DisplayName)
                        Spacer()
                        if (viewModel.techniques.abdominalToraxTechnique == technique) {
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

    private func toggleMMSS(_ technique: MMSSTechnique) {
        if viewModel.techniques.mmssTechnique == technique {
            viewModel.techniques.mmssTechnique = nil
        } else {
            viewModel.techniques.mmssTechnique = technique
        }
    }

    private func toggleMMII(_ technique: MMIITechnique) {
        if viewModel.techniques.mmiiTechnique == technique {
            viewModel.techniques.mmiiTechnique = nil
        } else {
            viewModel.techniques.mmiiTechnique = technique
        }
    }

    private func toggleAbdominal(_ technique: AbdominalToraxTechnique) {
        if viewModel.techniques.abdominalToraxTechnique == technique {
            viewModel.techniques.abdominalToraxTechnique = nil
        } else {
            viewModel.techniques.abdominalToraxTechnique = technique
        }
    }
}

private struct MMSSSelectionView: View {
    @Bindable var viewModel: AnesthesiaDescriptionViewModel

    var body: some View {
        Form {
            Section("Membros Superiores") {
                ForEach(MMSSTechnique.allCases, id: \.self) { technique in
                    Button {
                        toggleMMSS(technique)
                    } label: {
                        HStack {
                            Text(technique.DisplayName)
                            Spacer()
                            if (viewModel.techniques.mmssTechnique == technique) {
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
            }
        }
        .navigationTitle("Membros Superiores")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleMMSS(_ technique: MMSSTechnique) {
        if viewModel.techniques.mmssTechnique == technique {
            viewModel.techniques.mmssTechnique = nil
        } else {
            viewModel.techniques.mmssTechnique = technique
        }
    }
}

private struct MMIISelectionView: View {
    @Bindable var viewModel: AnesthesiaDescriptionViewModel

    var body: some View {
        Form {
            Section("Membros Inferiores") {
                ForEach(MMIITechnique.allCases, id: \.self) { technique in
                    Button {
                        toggleMMII(technique)
                    } label: {
                        HStack {
                            Text(technique.DisplayName)
                            Spacer()
                            if (viewModel.techniques.mmiiTechnique == technique) {
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
            }
        }
        .navigationTitle("Membros Inferiores")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleMMII(_ technique: MMIITechnique) {
        if viewModel.techniques.mmiiTechnique == technique {
            viewModel.techniques.mmiiTechnique = nil
        } else {
            viewModel.techniques.mmiiTechnique = technique
        }
    }
}

private struct AbdominalToraxSelectionView: View {
    @Bindable var viewModel: AnesthesiaDescriptionViewModel

    var body: some View {
        Form {
            Section("Abdome e Tórax") {
                ForEach(AbdominalToraxTechnique.allCases, id: \.self) { technique in
                    Button {
                        toggleAbdominal(technique)
                    } label: {
                        HStack {
                            Text(technique.DisplayName)
                            Spacer()
                            if (viewModel.techniques.abdominalToraxTechnique == technique) {
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
            }
        }
        .navigationTitle("Abdome e Tórax")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleAbdominal(_ technique: AbdominalToraxTechnique) {
        if viewModel.techniques.abdominalToraxTechnique == technique {
            viewModel.techniques.abdominalToraxTechnique = nil
        } else {
            viewModel.techniques.abdominalToraxTechnique = technique
        }
    }
}
