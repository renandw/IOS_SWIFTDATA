//
//  AnesthesiaDescriptionFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import Observation   // para @Bindable

struct AnesthesiaDescriptionFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    @State private var isMonitoringSheetPresented: Bool = false
    @State private var isAdmissionSheetPresented: Bool = false
    @State private var isTechniquesSheetPresented: Bool = false
    @State private var isCompletionSheetPresented: Bool = false
    @State private var newCustomMonitoring: String = ""
    
    init(viewModel: AnesthesiaDescriptionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    MonitoringSummaryView(viewModel: viewModel, isPresented: $isMonitoringSheetPresented)
                } header: {
                    HStack {
                        Text("Monitorização")
                        Spacer()
                        Button {
                            viewModel.monitoring.applyMonitoringSuggestion(hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia)
                        } label: {
                            Label("Sugerir", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderless)
                        .controlSize(.mini)
                        .foregroundStyle(.tint)
                    }
                }
                Section {
                    AdmissionSummaryView(viewModel: viewModel, isPresented: $isAdmissionSheetPresented)
                } header: {
                    HStack {
                        Text("Admissão")
                        Spacer()
                        Button {
                            viewModel.admission.applyAdmissionSuggestion()
                        } label: {
                            Label("Sugerir", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderless)
                        .controlSize(.mini)
                        .foregroundStyle(.tint)
                    }
                }
                Section {
                    TechniquesSummaryView(viewModel: viewModel, isPresented: $isTechniquesSheetPresented)
                } header: {
                    HStack {
                        Text("Técnicas Anestésicas")
                        Spacer()
                        Button {
                            viewModel.monitoring.applyMonitoringSuggestion(hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia)
                            viewModel.admission.applyAdmissionSuggestion()
                            viewModel.techniques.applyTechinquesSuggestion(
                                hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia,
                                hasSpinalAnesthesia: viewModel.hasSpinalAnesthesia,
                                hasPeridualAnesthesia: viewModel.hasPeriduralAnesthesia,
                                hasPeripheralBlockAnesthesia: viewModel.hasPeripheralBlockAnesthesia,
                                hasSedationAnesthesia: viewModel.hasSedationAnesthesia,
                                hasLocalAnesthesia: viewModel.hasLocalAnesthesia,
                                patientAge: viewModel.patientAge,
                                patientWeight: viewModel.patientWeight,
                                patientSex: viewModel.patientSex
                            )
                        } label: {
                            Label("Sugerir", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderless)
                        .controlSize(.mini)
                        .foregroundStyle(.tint)
                    }
                }
                Section {
                    CompletionSummaryView(viewModel: viewModel, isPresented: $isCompletionSheetPresented)
                } header: {
                    HStack{
                        Text("Encerramento")
                        Spacer()
                        Button {
                            viewModel.completion.applyCompletionSuggestion()
                        } label: {
                            Label("Sugerir", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderless)
                        .controlSize(.mini)
                        .foregroundStyle(.tint)
                    }
                }
            }
            .navigationTitle("Descrição Anestésica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        }
                        catch {
                            print("Erro ao salvar AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sugerir", systemImage: "wand.and.stars") {
                        do {
                            viewModel.monitoring.applyMonitoringSuggestion(hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia)
                            viewModel.admission.applyAdmissionSuggestion()
                            viewModel.techniques.applyTechinquesSuggestion(
                                hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia,
                                hasSpinalAnesthesia: viewModel.hasSpinalAnesthesia,
                                hasPeridualAnesthesia: viewModel.hasPeriduralAnesthesia,
                                hasPeripheralBlockAnesthesia: viewModel.hasPeripheralBlockAnesthesia,
                                hasSedationAnesthesia: viewModel.hasSedationAnesthesia,
                                hasLocalAnesthesia: viewModel.hasLocalAnesthesia,
                                patientAge: viewModel.patientAge,
                                patientWeight: viewModel.patientWeight,
                                patientSex: viewModel.patientSex
                            )
                            viewModel.completion.applyCompletionSuggestion()
                            try viewModel.save()
                        }
                        catch {
                            print("Erro ao salvar AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Excluir", systemImage: "trash") {
                        do {
                            try viewModel.delete()
                            DispatchQueue.main.async {
                                dismiss()
                            }
                        }
                        catch {
                            print("Erro ao excluir AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isMonitoringSheetPresented) {
            MonitoringSectionView(
                viewModel: viewModel,
                newCustomMonitoring: $newCustomMonitoring
            )
        }
        .sheet(isPresented: $isAdmissionSheetPresented) {
            AdmissionSectionView(viewModel: viewModel)
        }
        .sheet(isPresented: $isTechniquesSheetPresented) {
            TechniquesSectionView(viewModel: viewModel)
        }
        .sheet(isPresented: $isCompletionSheetPresented) {
            CompletionSectionView(viewModel: viewModel)
        }
    }
    
    
}
