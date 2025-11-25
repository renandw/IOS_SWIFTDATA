//
//  PreAnesthesiaFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//

//
//  AnesthesiaDescriptionFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import Observation   // para @Bindable

struct PreAnesthesiaFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: PreAnesthesiaViewModel
    @State private var isMonitoringSheetPresented: Bool = false
    @State private var isAdmissionSheetPresented: Bool = false
    @State private var isTechniquesSheetPresented: Bool = false
    @State private var isCompletionSheetPresented: Bool = false
    @State private var newCustomMonitoring: String = ""
    @State private var newComplications: String = ""
    
    init(viewModel: PreAnesthesiaViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    //
                    //                } header: {
                    //                    HStack {
                    //                        Text("Asa")
                    //                        Spacer()
                    //                        TextField("Texto teste", text: Binding(
                    //                            get: { viewModel.textField ?? "" },
                    //                            set: { viewModel.textField = $0.isEmpty ? nil : $0 }
                    //                        ))
                    //
                    //                    }
                    //                }
                    clearenceStatusPicker
                }
                
                Section {
                    NavigationLink {
                        RecommendationForRevaluationStatusView(selection: Binding<[RecommendationForRevaluationStatus]>(
                            get: { viewModel.clearence.definitiveRecommendationForRevaluationStatus ?? [] },
                            set: { newArray in
                                viewModel.clearence.definitiveRecommendationForRevaluationStatus = newArray.isEmpty ? nil : newArray
                            }
                        ))
                    } label: {
                        HStack {
                            Text("Selecionar Recomendações")
                            Spacer()
                            Text({
                                let items = viewModel.clearence.definitiveRecommendationForRevaluationStatus ?? []
                                return items.isEmpty ? "Nenhuma" : items.map(\.displayName).joined(separator: ", ")
                            }())
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                        }
                    }
                } header: {
                    HStack {
                        Text("Recomendações")
                    }
                }
                
                Section {
                    NavigationLink {
                        AnesthesiaTechniquePickerView(selection: $viewModel.techniques)
                    } label: {
                        HStack {
                            Text("Selecionar técnicas")
                            Spacer()
                            Text(viewModel.techniques.isEmpty
                                 ? "Nenhuma"
                                 : viewModel.techniques.map(\.rawValue).joined(separator: ", "))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                        }
                    }
                } header: {
                    HStack {
                        Text("Técnicas")
                    }
                }
                Section {
                    NavigationLink {
                        ASAPickerView(selection: $viewModel.asa)
                    } label: {
                        HStack {
                            Text("Classificação ASA")
                            Spacer()
                            Text(viewModel.asa?.rawValue ?? "Nenhuma")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } header: {
                    HStack {
                        Text("ASA")
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
            Text("Vamos ver se funciona")
        }
    }
    
    
    private var clearenceStatusPicker: some View {
        Picker("Liberação", selection: $viewModel.clearence.clearenceStatus) {
            Text("Não informado").tag(nil as ClearenceStatus?)
            ForEach(ClearenceStatus.allCases, id: \.self) { (kind: ClearenceStatus) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }
}

struct RecommendationForRevaluationStatusView: View {
    @Binding var selection: [RecommendationForRevaluationStatus]

    private var recommendations: [RecommendationForRevaluationStatus] {
        RecommendationForRevaluationStatus.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }

    var body: some View {
        List {
            ForEach(recommendations, id: \.self) { kind in
                Button {
                    toggle(kind)
                } label: {
                    HStack {
                        Text(kind.displayName)
                        Spacer()
                        if selection.contains(kind) {
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
        .navigationTitle("Recomendações")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Opções", systemImage: "gear") {
                    Button("Selecionar tudo") { selection = recommendations }
                    Button("Limpar seleção", role: .destructive) { selection.removeAll() }
                }
            }
        }
    }

    private func toggle(_ kind: RecommendationForRevaluationStatus) {
        if let idx = selection.firstIndex(of: kind) {
            selection.remove(at: idx)
        } else {
            selection.append(kind)
        }
    }
}

