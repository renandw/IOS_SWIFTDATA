//
//  LabsAndImageExamsViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class LabsAndImageExamsSectionViewModel {
    
    // Laboratory Exams
    var hemoglobin: Double?
    var hct: Double?
    var urea: Double?
    var creatinine: Double?
    var sodium: Double?
    var potassium: Double?
    var inr: Double?
    var glucose: Double?
    
    // Imaging Exams
    var imagingExams: [ImagingExam] = []
    var customImagingExams: [String] = []
    
    func load(from e: PreAnesthesia) {
        // Load laboratory exams
        hemoglobin = e.laboratoryExams?.hemoglobin
        hct        = e.laboratoryExams?.hct
        urea       = e.laboratoryExams?.urea
        creatinine = e.laboratoryExams?.creatinine
        sodium     = e.laboratoryExams?.sodium
        potassium  = e.laboratoryExams?.potassium
        inr        = e.laboratoryExams?.inr
        glucose    = e.laboratoryExams?.glucose
        customImagingExams = e.customImagingExams ?? []
        
        // Load imaging exams
        imagingExams = e.imagingExams ?? []
    }
    
    func apply(to e: PreAnesthesia) {
        // Apply laboratory exams
        e.customImagingExams = customImagingExams
        e.laboratoryExams = LaboratoryExams(
            hemoglobin: hemoglobin,
            urea: urea,
            creatinine: creatinine,
            sodium: sodium,
            potassium: potassium,
            inr: inr,
            glucose: glucose
        )
        
        // Apply imaging exams
        e.imagingExams = imagingExams.isEmpty ? nil : imagingExams
    }
    
    // MARK: - Imaging Exams Helper Methods
    
    func addImagingExam(type: ImagingExamType) {
        let newExam = ImagingExam(type: type, findings: [], customFinding: nil)
        imagingExams.append(newExam)
    }
    
    func removeImagingExam(at index: Int) {
        guard index >= 0 && index < imagingExams.count else { return }
        imagingExams.remove(at: index)
    }
    
    func removeImagingExam(id: UUID) {
        imagingExams.removeAll { $0.id == id }
    }
    
    func updateImagingExam(id: UUID, findings: [ImagingFinding], customFinding: String?) {
        if let index = imagingExams.firstIndex(where: { $0.id == id }) {
            imagingExams[index].findings = findings
            imagingExams[index].customFinding = customFinding
        }
    }
    
    func addCustomImagingExams(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !customImagingExams.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        customImagingExams.append(trimmed)
    }
    func removeCustomImagingExams(at index: Int) {
        guard customImagingExams.indices.contains(index) else { return }
        customImagingExams.remove(at: index)
    }
    
    func applyHealthyPatient() {
        hemoglobin = Double.random(in: 11.3...13.9)
        hct = Double.random(in: 39.0...46.0)
        urea = Double.random(in: 18.0...40.0)
        creatinine = Double.random(in: 0.7...1.1)
        sodium = Double(Int.random(in: 135...93))
        potassium = Double.random(in: 3.5...4.5)
        inr = Double.random(in: 1.1...1.4)
        glucose = Double(Int.random(in: 81...93))

        // Imaging exams: set Chest X-Ray and ECG as Normal
        let chestNormal = ImagingExam(type: .chestXRay,
                                      findings: [.chestXRay(.normal)],
                                      customFinding: nil)
        let ecgNormal = ImagingExam(type: .ecg,
                                    findings: [.ecg(.normal)],
                                    customFinding: nil)

        func upsert(_ exam: ImagingExam) {
            if let idx = imagingExams.firstIndex(where: { $0.type == exam.type }) {
                imagingExams[idx].findings = exam.findings
                imagingExams[idx].customFinding = nil
            } else {
                imagingExams.append(exam)
            }
        }

        upsert(chestNormal)
        upsert(ecgNormal)
    }
    
}
