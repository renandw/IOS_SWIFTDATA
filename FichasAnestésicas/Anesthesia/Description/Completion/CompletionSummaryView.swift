//
//  CompletionSummaryView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/11/25.
//

import SwiftUI
import Observation

struct CompletionSummaryView: View {
  @Bindable var viewModel: AnesthesiaDescriptionViewModel
  @Binding var isPresented: Bool

    private var completionSummary: String {
        var result: [String] = []

        if viewModel.completion.standardEnd{
          result.append("Encerramento padrão")
        }
        if let endAnesthesia = viewModel.completion.endAnesthesia?.DisplayName {
            result.append("\(endAnesthesia)")
        }
        if let destinationAnesthesia = viewModel.completion.destinationAnesthesia?.DisplayName {
            result.append("\(destinationAnesthesia)")
        }
        if let adverseEvolution = viewModel.completion.adverseEvolution {
          result.append("\(adverseEvolution)")
        }
        if let finalDescription = viewModel.completion.finalDescription {
            result.append("\(finalDescription)")
        }
        return result.joined(separator: ", ")
      }

  var body: some View {
      HStack(spacing: 15) {
          Image(systemName: "document.circle.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 40)
              .foregroundColor(.purple)
          
          VStack(alignment: .leading) {
              Text("Encerramento")
                  .font(.headline)
              Text(completionSummary)
                  .font(.caption)
                  .foregroundColor(.secondary)
              Text(viewModel.completion.generateCompletionText())
          }
          Spacer()
          Image(systemName: "chevron.right")
              .foregroundColor(.secondary)
      }
    .contentShape(Rectangle())
    .onTapGesture {
      isPresented = true
    }
  }
}
