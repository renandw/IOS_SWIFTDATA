//
//  LabsAndImageExamsFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import Observation

struct LabsAndImageExamsFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    @State private var selectedExamType: ImagingExamType?
    @State private var showingAddExamSheet = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Exames Laboratoriais") {
                    laboratoryExamsContent
                }
                
                Section {
                    imagingExamsContent
                } header: {
                    Text("Exames de Imagem")
                } footer: {
                    Button {
                        showingAddExamSheet = true
                    } label: {
                        Label("Adicionar Exame de Imagem", systemImage: "plus.circle")
                    }
                }
            }
            .navigationTitle("Exames Lab. e Imagem")
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
                }
            }
            .sheet(isPresented: $showingAddExamSheet) {
                addExamTypeSheet
            }
        }
    }
    
    // MARK: - Laboratory Exams
    
    private var laboratoryExamsContent: some View {
        Group {
            HStack {
                Text("Hemoglobina")
                Spacer()
                TextField("g/dL", value: $viewModel.labsAndImage.hemoglobin, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("Ureia")
                Spacer()
                TextField("mg/dL", value: $viewModel.labsAndImage.urea, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("Creatinina")
                Spacer()
                TextField("mg/dL", value: $viewModel.labsAndImage.creatinine, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("Sódio")
                Spacer()
                TextField("mEq/L", value: $viewModel.labsAndImage.sodium, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("Potássio")
                Spacer()
                TextField("mEq/L", value: $viewModel.labsAndImage.potassium, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("INR")
                Spacer()
                TextField("", value: $viewModel.labsAndImage.inr, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
            
            HStack {
                Text("Glicose")
                Spacer()
                TextField("mg/dL", value: $viewModel.labsAndImage.glucose, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
            }
        }
    }
    
    // MARK: - Imaging Exams
    
    private var imagingExamsContent: some View {
        Group {
            if viewModel.labsAndImage.imagingExams.isEmpty {
                Text("Nenhum exame de imagem adicionado")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.labsAndImage.imagingExams) { exam in
                    NavigationLink {
                        ImagingExamDetailView(
                            viewModel: viewModel,
                            exam: exam
                        )
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exam.type.displayName)
                                .font(.headline)
                            if !exam.findings.isEmpty || exam.customFinding != nil {
                                Text(examSummary(for: exam))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.labsAndImage.removeImagingExam(at: index)
                    }
                }
            }
        }
    }
    
    private var addExamTypeSheet: some View {
        NavigationStack {
            List(ImagingExamType.allCases, id: \.self) { type in
                Button {
                    viewModel.labsAndImage.addImagingExam(type: type)
                    showingAddExamSheet = false
                } label: {
                    Text(type.displayName)
                }
            }
            .navigationTitle("Selecionar Exame")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showingAddExamSheet = false
                    }
                }
            }
        }
    }
    
    private func examSummary(for exam: ImagingExam) -> String {
        var parts: [String] = []
        
        if !exam.findings.isEmpty {
            let findingNames = exam.findings.compactMap { finding -> String? in
                switch finding {
                case .chestXRay(let f): return f.displayName
                case .ecg(let f): return f.displayName
                case .echocardiogram(let f): return f.displayName
                }
            }
            parts.append(contentsOf: findingNames)
        }
        
        if let custom = exam.customFinding, !custom.isEmpty {
            parts.append(custom)
        }
        
        return parts.isEmpty ? "Sem achados registrados" : parts.joined(separator: ", ")
    }
}

// MARK: - Imaging Exam Detail View

struct ImagingExamDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: PreAnesthesiaViewModel
    let exam: ImagingExam
    
    @State private var selectedFindings: Set<String> = []
    @State private var customFinding: String = ""
    
    var body: some View {
        Form {
            Section("Achados") {
                findingsContent
            }
            
            Section("Achado Customizado") {
                TextField("Descrever achado", text: $customFinding, axis: .vertical)
                    .lineLimit(3...6)
            }
        }
        .navigationTitle(exam.type.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    saveFindings()
                    dismiss()
                }
            }
        }
        .onAppear {
            loadCurrentFindings()
        }
    }
    
    @ViewBuilder
    private var findingsContent: some View {
        switch exam.type {
        case .chestXRay:
            ForEach(ChestXRayFinding.allCases, id: \.rawValue) { finding in
                findingToggle(finding.displayName, rawValue: finding.rawValue)
            }
        case .ecg:
            ForEach(ecgFinding.allCases, id: \.rawValue) { finding in
                findingToggle(finding.displayName, rawValue: finding.rawValue)
            }
        case .echocardiogram:
            ForEach(echocardiogramFinding.allCases, id: \.rawValue) { finding in
                findingToggle(finding.displayName, rawValue: finding.rawValue)
            }
        }
    }
    
    private func findingToggle(_ displayName: String, rawValue: String) -> some View {
        Toggle(isOn: Binding(
            get: { selectedFindings.contains(rawValue) },
            set: { isSelected in
                if isSelected {
                    selectedFindings.insert(rawValue)
                } else {
                    selectedFindings.remove(rawValue)
                }
            }
        )) {
            Text(displayName)
        }
    }
    
    private func loadCurrentFindings() {
        selectedFindings = Set(exam.findings.compactMap { finding -> String? in
            switch finding {
            case .chestXRay(let f): return f.rawValue
            case .ecg(let f): return f.rawValue
            case .echocardiogram(let f): return f.rawValue
            }
        })
        customFinding = exam.customFinding ?? ""
    }
    
    private func saveFindings() {
        var findings: [ImagingFinding] = []
        
        switch exam.type {
        case .chestXRay:
            findings = selectedFindings.compactMap { rawValue in
                ChestXRayFinding(rawValue: rawValue).map { .chestXRay($0) }
            }
        case .ecg:
            findings = selectedFindings.compactMap { rawValue in
                ecgFinding(rawValue: rawValue).map { .ecg($0) }
            }
        case .echocardiogram:
            findings = selectedFindings.compactMap { rawValue in
                echocardiogramFinding(rawValue: rawValue).map { .echocardiogram($0) }
            }
        }
        
        let finalCustomFinding = customFinding.trimmingCharacters(in: .whitespacesAndNewlines)
        
        viewModel.labsAndImage.updateImagingExam(
            id: exam.id,
            findings: findings,
            customFinding: finalCustomFinding.isEmpty ? nil : finalCustomFinding
        )
    }
}
