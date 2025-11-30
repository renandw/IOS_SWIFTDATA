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
    
}
