//
//  MedicationsAndAllergiesFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import Observation

struct MedicationsAndAllergiesFormView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: PreAnesthesiaViewModel
    
    
    @Binding var selection: [DailyMedications]
    @State private var newCustomDailyMedication = ""

  var body: some View {
      NavigationStack {
          Form {
              Section("Alergias") {
                  hasAllergies
                  if viewModel.medicationAndAllergies.hasAllergies {
                      hasAllergiesCustomDetais
                  }
              }
              Section {
                  
                  dailyMedicationsContent
                  
              } header: {
                  Text("Uso de Medicações")
              }
          }
          .navigationTitle("Uso de Medicações")
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
                  .disabled(!viewModel.medicationAndAllergies.canSave)
              }
          }
      }
  }
    private var hasAllergies: some View {
        Toggle(
            "Tem Alergias",
            systemImage: "exclamationmark.triangle.text.page.fill",
            isOn: $viewModel.medicationAndAllergies.hasAllergies
        )
    }
    
    private var hasAllergiesCustomDetais: some View {
        Group {
            ForEach(viewModel.medicationAndAllergies.allergiesMedicationsCustomDetails, id: \.self) { name in
                Button {
                    if let index = viewModel.medicationAndAllergies.allergiesMedicationsCustomDetails.firstIndex(of: name) {
                        viewModel.medicationAndAllergies.removeAllergiesMedicationsCustomDetails(at: index)
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
                TextField("Penicilina", text: $newCustomDailyMedication)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.medicationAndAllergies.addAllergiesMedicationsCustomDetails(newCustomDailyMedication)
                        newCustomDailyMedication = ""
                    }
                if !newCustomDailyMedication.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button {
                        viewModel.medicationAndAllergies.addAllergiesMedicationsCustomDetails(newCustomDailyMedication)
                        newCustomDailyMedication = ""
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                
            }
        }
    }
    
    private var dailyMedicationsContent: some View {
            Group {
                ForEach(viewModel.medicationAndAllergies.dailyMedicationsCustomDetails, id: \.self) { name in
                    Button {
                        if let index = viewModel.medicationAndAllergies.dailyMedicationsCustomDetails.firstIndex(of: name) {
                            viewModel.medicationAndAllergies.removeDailyMedicationsCustomDetails(at: index)
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
                    TextField("Medicação", text: $newCustomDailyMedication)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .onSubmit {
                            viewModel.medicationAndAllergies.addDailyMedicationsCustomDetails(newCustomDailyMedication)
                            newCustomDailyMedication = ""
                        }
                    if !newCustomDailyMedication.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {
                            viewModel.medicationAndAllergies.addDailyMedicationsCustomDetails(newCustomDailyMedication)
                            newCustomDailyMedication = ""
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                }
            }
        }
}
