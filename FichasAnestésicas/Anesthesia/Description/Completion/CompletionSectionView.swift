//
//  CompletionSectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/11/25.
//

import SwiftUI
import Observation

struct CompletionSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  stantardEnd
                  destinationAnesthesiaPicker
                  endAnesthesiaPicker
                  if viewModel.completion.endAnesthesia == .complication {
                      adverseEvolution
                  }
                  

              } header: {
                  Text("Encerramento")
              }
          }
          .navigationTitle("Encerramento")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }
    private var stantardEnd: some View {
        Toggle(
            "Encerramento padrão",
            systemImage: "flag.pattern.checkered",
            isOn: $viewModel.completion.standardEnd
        )
    }
    private var destinationAnesthesiaPicker: some View {
        Picker("Destino", selection: $viewModel.completion.destinationAnesthesia) {
            Text("Não informado").tag(nil as DestinationAnesthesia?)
            ForEach(DestinationAnesthesia.allCases, id: \.self) { (kind: DestinationAnesthesia) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var endAnesthesiaPicker: some View {
        Picker("Intercorrências", selection: $viewModel.completion.endAnesthesia) {
            Text("Não informado").tag(nil as EndAnesthesia?)
            ForEach(EndAnesthesia.allCases, id: \.self) { (kind: EndAnesthesia) in
                Text(kind.DisplayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var adverseEvolution: some View {
        HStack {
            Text("Eventos adversos")
            TextField(
                "laringoespasmo …",
                text: Binding<String>(
                    get: { viewModel.completion.adverseEvolution ?? "" },
                    set: { newValue in
                        viewModel.completion.adverseEvolution = newValue.isEmpty ? nil : newValue
                    }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
}

