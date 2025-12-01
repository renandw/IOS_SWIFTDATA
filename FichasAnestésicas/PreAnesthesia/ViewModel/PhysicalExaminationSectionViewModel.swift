//
//  PhysicalExaminationSectionViewModel.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/11/25.
//


import SwiftUI
import SwiftData

@Observable
final class PhysicalExaminationSectionViewModel {
    
   
    var physicalExaminationDetailsText: String?

    
    
    func load(from e: PreAnesthesia) {
        physicalExaminationDetailsText = e.physicalExaminationDetailsText
        
    }
    
    func apply(to e: PreAnesthesia) {
        
        e.physicalExaminationDetailsText = physicalExaminationDetailsText

    }
    
    func applyPatientHealthy() {
        physicalExaminationDetailsText = """
        Paciente não apresenta alterações dignas de nota ao exame físico.
        """
        
    }
    
}

