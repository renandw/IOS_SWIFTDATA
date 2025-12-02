//
//  PhysicalExaminationFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/11/25.
//

//
//  MedicationsAndAllergiesFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import Observation

struct PhysicalExaminationFormView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: PreAnesthesiaViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section("Exame Físico") {
                  physicalExamination
              }
              Button("Paciente Saudável") {
                  viewModel.physicalExamination.applyPatientHealthy()
              }
          }
          .navigationTitle("Exame Físico")
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
                 // .disabled(!viewModel.physicalExamination.canSave)
              }
          }
      }
  }
    private var physicalExamination: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Descrição do Exame Físico")
                .font(.headline)

            // Create a non-optional Binding<String> from an optional source
            let detailsBinding = Binding<String>(
                get: { viewModel.physicalExamination.physicalExaminationDetailsText ?? "" },
                set: { newValue in
                    viewModel.physicalExamination.physicalExaminationDetailsText = newValue.isEmpty ? nil : newValue
                }
            )

            TextEditor(text: detailsBinding)
                .frame(minHeight: 400, alignment: .topLeading)
                .overlay(
                    Group {
                        if (viewModel.physicalExamination.physicalExaminationDetailsText ?? "").isEmpty {
                            Text("Descreva os achados do exame físico")
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                )
        }
    }
    
}
