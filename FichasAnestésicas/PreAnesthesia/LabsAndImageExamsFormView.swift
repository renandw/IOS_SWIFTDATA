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
    @State private var newCustomImageExam = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Exames Laboratoriais") {
                    laboratoryExamsContent
                }
                
                Section("Exames de Imagem") {
                    imagingExamsWithFindingsContent
                }
                
                Section("Outros Exames") {
                    customImagingExams
                }
                
                Button("Paciente Saudável") {
                    viewModel.labsAndImage.applyHealthyPatient()
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
    
    private var customImagingExams: some View {
        Group {
            ForEach(viewModel.labsAndImage.customImagingExams, id: \.self) { name in
                Button {
                    if let index = viewModel.labsAndImage.customImagingExams.firstIndex(of: name) {
                        viewModel.labsAndImage.removeImagingExam(at: index)
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
                TextField("Tomografia", text: $newCustomImageExam)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.labsAndImage.addCustomImagingExams(newCustomImageExam)
                        newCustomImageExam = ""
                    }
                if !newCustomImageExam.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button {
                        viewModel.labsAndImage.addCustomImagingExams(newCustomImageExam)
                        newCustomImageExam = ""
                    } label: {
                        Image(systemName: "plus.circle")
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
                Text("g/dL")
            }
            
            HStack {
                Text("Ureia")
                Spacer()
                TextField("mg/dL", value: $viewModel.labsAndImage.urea, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
                Text("mg/dL")
            }
            
            HStack {
                Text("Creatinina")
                Spacer()
                TextField("mg/dL", value: $viewModel.labsAndImage.creatinine, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
                Text("mEq/L")
            }
            
            HStack {
                Text("Sódio")
                Spacer()
                TextField("mEq/L", value: $viewModel.labsAndImage.sodium, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
                Text("mEq/L")    
            }
            
            HStack {
                Text("Potássio")
                Spacer()
                TextField("mEq/L", value: $viewModel.labsAndImage.potassium, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
                Text("mEq/L")    
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
                Text("mg/dL")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    // MARK: - Imaging Exams with Findings
    
    private var imagingExamsWithFindingsContent: some View {
        ForEach(ImagingExamType.allCases, id: \.self) { type in
            Section {
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
                        .fontWeight(.medium)
                }

                if let exam = viewModel.labsAndImage.imagingExams.first(where: { $0.type == type }) {
                    ImagingExamFindingsView(viewModel: viewModel, exam: exam)
                }
            }
        }
    }
}


// MARK: - Imaging Exam Findings View

struct ImagingExamFindingsView: View {
    @Bindable var viewModel: PreAnesthesiaViewModel
    let exam: ImagingExam
    
    @State private var selectedFindings: Set<String> = []
    @State private var customFinding: String = ""
    
    var body: some View {
        
            findingsContent
            
            TextField("Descrever alteração", text: $customFinding, axis: .vertical)
                .lineLimit(2...4)
                //.textFieldStyle(.roundedBorder)
                .onChange(of: selectedFindings) { saveFindings() }
                .onChange(of: customFinding) { saveFindings() }
        
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
        Button {
            if selectedFindings.contains(rawValue) {
                selectedFindings.remove(rawValue)
            } else {
                selectedFindings.insert(rawValue)
            }
        } label: {
            HStack {
                Text(displayName)
                    .font(.subheadline)
                Spacer()
                Image(systemName: selectedFindings.contains(rawValue) ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selectedFindings.contains(rawValue) ? .blue : .secondary)
            }
        }
        .foregroundStyle(.primary)
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

