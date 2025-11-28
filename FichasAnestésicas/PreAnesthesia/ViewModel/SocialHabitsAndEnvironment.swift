

import SwiftUI
import SwiftData

@Observable
final class SocialHabitsAndEnvironmentSectionViewModel {

    
    var socialHabitsAndEnvironmentDetails: [SocialHabitsAndEnvironment]?
    var socialHabitsAndEnvironmentCustomDetails: [String] = []
    var socialHabitsAndEnvironmentDetailsText: String?

    
    
    func load(from e: PreAnesthesia) {
        
        socialHabitsAndEnvironmentDetails = e.socialHabitsAndEnvironmentDetails ?? []
        socialHabitsAndEnvironmentCustomDetails = e.socialHabitsAndEnvironmentCustomDetails ?? []
        socialHabitsAndEnvironmentDetailsText = e.socialHabitsAndEnvironmentDetailsText
    }
    
    func apply(to e: PreAnesthesia) {

        e.socialHabitsAndEnvironmentDetails = socialHabitsAndEnvironmentDetails
        e.socialHabitsAndEnvironmentCustomDetails = socialHabitsAndEnvironmentCustomDetails
        e.socialHabitsAndEnvironmentDetailsText = socialHabitsAndEnvironmentDetailsText
    }

}

