import SwiftUI
import SwiftData

@Observable
final class SocialHabitsAndEnvironmentSectionViewModel {
    weak var surgeryHistoryVM: SurgeryHistorySectionViewModel?

    
    var socialHabitsAndEnvironmentDetails: [SocialHabitsAndEnvironment]? {
        didSet { syncSocialToApfel() }
    }
    var socialHabitsAndEnvironmentCustomDetails: [String] = []
    var socialHabitsAndEnvironmentDetailsText: String?

    var apfelScoreDetails: [ApfelScore]? = [] {
            didSet { syncApfelToSocial() }
        }
    
    
    
    func load(from e: PreAnesthesia, patientSex: Sex) {
        syncing = true
        socialHabitsAndEnvironmentDetails = e.socialHabitsAndEnvironmentDetails ?? []
        socialHabitsAndEnvironmentCustomDetails = e.socialHabitsAndEnvironmentCustomDetails ?? []
        socialHabitsAndEnvironmentDetailsText = e.socialHabitsAndEnvironmentDetailsText
        apfelScoreDetails = e.apfelScoreDetails ?? []
        syncing = false

        // Re-apply classical Apfel smoking rule at load time.
        syncSocialToApfel()
        
        ifFemaleApply(patientSex: patientSex)
    }
    
    func apply(to e: PreAnesthesia) {

        e.socialHabitsAndEnvironmentDetails = socialHabitsAndEnvironmentDetails
        e.socialHabitsAndEnvironmentCustomDetails = socialHabitsAndEnvironmentCustomDetails
        e.socialHabitsAndEnvironmentDetailsText = socialHabitsAndEnvironmentDetailsText
        e.apfelScoreDetails = apfelScoreDetails
    }
    
    func ifFemaleApply(patientSex: Sex) {
        guard patientSex == .female else { return }
        var apfel = apfelScoreDetails ?? []
        if !apfel.contains(.femaleSex) {
            apfel.append(.femaleSex)
        }
        apfelScoreDetails = apfel
    }
    
    
    private var syncing = false
    
    private func syncSocialToApfel() {
        guard !syncing else { return }
        syncing = true

        let social = socialHabitsAndEnvironmentDetails ?? []
        var apfel = apfelScoreDetails ?? []

        if social.contains(.tobaccoUse) {
            apfel.removeAll { $0 == .nonTobaccoUse }
        } else {
            if !apfel.contains(.nonTobaccoUse) {
                apfel.append(.nonTobaccoUse)
            }
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

        if apfel.contains(.nonTobaccoUse) {
            social.removeAll { $0 == .tobaccoUse }
        }

        socialHabitsAndEnvironmentDetails = social
        
        if let historyVM = surgeryHistoryVM {
            var history = historyVM.anesthesiaHistoricDetails
            
            if apfel.contains(.historyPONV) {
                if !history.contains(where: { $0.type == .nausea }) {
                    history.append(AnesthesiaHistoryDetail(type: .nausea))
                }
            } else {
                // Remove nausea
                history.removeAll { $0.type == .nausea }
            }
            
            historyVM.anesthesiaHistoricDetails = history
        }

        syncing = false
    }

    

}
