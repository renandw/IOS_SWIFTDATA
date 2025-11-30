//
//  LabsAndImageExamsViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class LabsAndImageExamsSectionViewModel {
    
    var hemoglobin: Double?
        var urea: Double?
        var creatinine: Double?
        var sodium: Double?
        var potassium: Double?
        var inr: Double?
        var glucose: Double?
 
    
    func load(from e: PreAnesthesia) {
        hemoglobin = e.laboratoryExams?.hemoglobin
        urea       = e.laboratoryExams?.urea
        creatinine = e.laboratoryExams?.creatinine
        sodium     = e.laboratoryExams?.sodium
        potassium  = e.laboratoryExams?.potassium
        inr        = e.laboratoryExams?.inr
        glucose    = e.laboratoryExams?.glucose
    
    }
    
    func apply(to e: PreAnesthesia) {
        e.laboratoryExams = LaboratoryExams(
            hemoglobin: hemoglobin,
            urea: urea,
            creatinine: creatinine,
            sodium: sodium,
            potassium: potassium,
            inr: inr,
            glucose: glucose
        )
        
    }
    
    func addDifficultEvaluationCustomDetails(_ name: String) {

    }
    func removeDifficultEvaluationCustomDetails(at index: Int) {

    }
    
    
    func applyHealthyPatient() {
        
    }
}
