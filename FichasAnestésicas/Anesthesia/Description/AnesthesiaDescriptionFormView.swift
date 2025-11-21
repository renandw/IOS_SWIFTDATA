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
                           //TODO - apply suggestions
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Excluir", systemImage: "trash") {
                        do {
                            try viewModel.delete()
                            dismiss()
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
    }
    
    
}
