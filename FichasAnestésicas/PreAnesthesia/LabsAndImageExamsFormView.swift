//
//  LabsAndImageExamsFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import Observation

struct LabsAndImageExamsFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Exames Laboratoriais") {
                    laboratoryExamsContent
                }
                
                Section("Exames de Imagem") {
                    imagingExamTogglesContent
                }
                
                if !viewModel.labsAndImage.imagingExams.isEmpty {
                    Section("Achados dos Exames") {
                        imagingExamsContent
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
    
    // MARK: - Imaging Exam Toggles
    
    private var imagingExamTogglesContent: some View {
        ForEach(ImagingExamType.allCases, id: \.self) { type in
            Toggle(isOn: Binding(
                get: {
                    viewModel.labsAndImage.imagingExams.contains { $0.type == type }
                },
                set: { isOn in
                    if isOn {
                        viewModel.labsAndImage.addImagingExam(type: type)
                    } else {
                        if let index = viewModel.labsAndImage.imagingExams.firstIndex(where: { $0.type == type }) {
                            viewModel.labsAndImage.removeImagingExam(at: index)
                        }
                    }
                }
            )) {
                Text(type.displayName)
                
            }
        }
    }
    
    // MARK: - Imaging Exams
    
    private var imagingExamsContent: some View {
        ForEach(viewModel.labsAndImage.imagingExams) { exam in
            ImagingExamDisclosureGroup(
                viewModel: viewModel,
                exam: exam
            )
        }
    }
}

// MARK: - Imaging Exam Disclosure Group

struct ImagingExamDisclosureGroup: View {
    @Bindable var viewModel: PreAnesthesiaViewModel
    let exam: ImagingExam
    
    @State private var selectedFindings: Set<String> = []
    @State private var customFinding: String = ""
    
    var body: some View {
        DisclosureGroup {
            findingsContent
            
            TextField("Achado customizado", text: $customFinding, axis: .vertical)
                .lineLimit(2...4)
                .onChange(of: selectedFindings) { saveFindings() }
                .onChange(of: customFinding) { saveFindings() }
        } label: {
            Text(exam.type.displayName)
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
