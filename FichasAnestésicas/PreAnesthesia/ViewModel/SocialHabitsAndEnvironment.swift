import SwiftUI
import SwiftData

@Observable
final class SocialHabitsAndEnvironmentSectionViewModel {

    
    var socialHabitsAndEnvironmentDetails: [SocialHabitsAndEnvironment]? {
        didSet { syncSocialToApfel() }
    }
    var socialHabitsAndEnvironmentCustomDetails: [String] = []
    var socialHabitsAndEnvironmentDetailsText: String?

    var apfelScoreDetails: [ApfelScore]? = [] {
            didSet { syncApfelToSocial() }
        }
    
    
    
    func load(from e: PreAnesthesia) {
        
        socialHabitsAndEnvironmentDetails = e.socialHabitsAndEnvironmentDetails ?? []
        socialHabitsAndEnvironmentCustomDetails = e.socialHabitsAndEnvironmentCustomDetails ?? []
        socialHabitsAndEnvironmentDetailsText = e.socialHabitsAndEnvironmentDetailsText
        apfelScoreDetails = e.apfelScoreDetails ?? []
    }
    
    func apply(to e: PreAnesthesia) {

        e.socialHabitsAndEnvironmentDetails = socialHabitsAndEnvironmentDetails
        e.socialHabitsAndEnvironmentCustomDetails = socialHabitsAndEnvironmentCustomDetails
        e.socialHabitsAndEnvironmentDetailsText = socialHabitsAndEnvironmentDetailsText
        e.apfelScoreDetails = apfelScoreDetails
    }
    
    
    private var syncing = false
    
    private func syncSocialToApfel() {
        guard !syncing else { return }
        syncing = true

        let social = socialHabitsAndEnvironmentDetails ?? []
        var apfel = apfelScoreDetails ?? []

        if social.contains(.tobaccoUse) {
            if !apfel.contains(.tobaccoUse) {
                apfel.append(.tobaccoUse)
            }
        } else {
            apfel.removeAll { $0 == .tobaccoUse }
        }

        // Write back
        apfelScoreDetails = apfel

        syncing = false
    }

    private func syncApfelToSocial() {
        guard !syncing else { return }
        syncing = true

        var social = socialHabitsAndEnvironmentDetails ?? []
        let apfel = apfelScoreDetails ?? []

        if apfel.contains(.tobaccoUse) {
            if !social.contains(.tobaccoUse) {
                social.append(.tobaccoUse)
            }
        } else {
            social.removeAll { $0 == .tobaccoUse }
        }

        // Write back
        socialHabitsAndEnvironmentDetails = social

        syncing = false
    }

}
