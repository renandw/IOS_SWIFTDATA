//
//  PreAnesthesiaFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
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
                    clearenceStatusPicker
                    if [.unable, .reevaluate].contains(viewModel.clearence.clearenceStatus) {
                        NavigationLink {
                            RecommendationForRevaluationStatusView(
                                selection: Binding(
                                    get: { viewModel.clearence.definitiveRecommendationForRevaluationStatus ?? [] },
                                    set: { newArray in
                                        viewModel.clearence.definitiveRecommendationForRevaluationStatus = newArray.isEmpty ? nil : newArray
                                    }
                                ),
                                viewModel: viewModel
                            )
                        } label: {
                            HStack {
                                Text("Selecionar Recomendações")
                                Spacer()
                                let items = viewModel.clearence.definitiveRecommendationForRevaluationStatus ?? []
                                let subtitle = items.isEmpty ? "Nenhuma" : items.map(\.displayName).joined(separator: ", ")
                                Text(subtitle)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                } header: {
                    Text("Liberação")
                }
                Section {
                    NavigationLink {
                        ComorbitiesFormView(
                            viewModel: viewModel
                        )
                    } label : {
                        HStack {
                            Text("Selecionar Comorbidades")
                            Spacer()
                            
                        }
                    }
                } header: {
                    Text("Comorbidades")
                }
                Section {
                    NavigationLink {
                        SurgeryHistoryTypeFormView(
                            viewModel: viewModel
                        )
                    } label : {
                        HStack {
                            Text("Selecionar Cirurgias")
                            Spacer()
                            
                        }
                    }
                } header: {
                    Text("Histórico Cirúrgico")
                }
                Section {
                    NavigationLink {
                        AnesthesiaHistoryTypeFormView(
                            viewModel: viewModel
                        )
                    } label : {
                        HStack {
                            Text("Selecionar Anestesias")
                            Spacer()
                            
                        }
                    }
                } header: {
                    Text("Histórico Anestésico")
                }
                Section {
                    NavigationLink {
                        SocialHabitsAndEnvironmentFormView(
                            viewModel: viewModel
                        )
                    } label : {
                        HStack {
                            Text("Hábitos e Ambiente")
                            Spacer()
                            
                        }
                    }
                } header: {
                    Text("Hábitos e Ambiente")
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
                        Text("Técnicas Anestésicas")
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
                        Text("Classificação ASA")
                    }
                }
            }
            .navigationTitle("Avaliação Pré-Anestésica")
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
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    @State private var newCustomRecommendation = ""
    
    private var recommendations: [RecommendationForRevaluationStatus] {
        RecommendationForRevaluationStatus.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }

    var body: some View {
        List {
            if viewModel.clearence.clearenceStatus == .able || viewModel.clearence.clearenceStatus == .reevaluate {
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
            ForEach(viewModel.clearence.futherRecommendationForRevaluation, id: \.self) { name in
                Button {
                    if let index = viewModel.clearence.futherRecommendationForRevaluation.firstIndex(of: name) {
                        viewModel.clearence.removeCustomRecommendation(at: index)
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
            
            if viewModel.clearence.clearenceStatus == .unable || viewModel.clearence.clearenceStatus == .reevaluate {
                Section {
                    HStack {
                        TextField("Adicionar recomendações", text: $newCustomRecommendation)
                            .autocorrectionDisabled(true)
                            .submitLabel(.done)
                            .onSubmit {
                                viewModel.clearence.addCustomRecommendation(newCustomRecommendation)
                                newCustomRecommendation = ""
                            }
                        if !newCustomRecommendation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Button {
                                viewModel.clearence.addCustomRecommendation(newCustomRecommendation)
                                newCustomRecommendation = ""
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                }
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

