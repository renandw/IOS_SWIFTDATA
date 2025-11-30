//
//  PreAnesthesiaSwiftData.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 24/11/25.
//
import Foundation
import SwiftData

@Model
final class PreAnesthesia {
    @Attribute(.unique) var preanesthesiaId: String
    @Relationship var surgery: Surgery
    @Relationship var shared: SharedPreAndAnesthesia?
    //metadatafields
    var createdBy: User
    var updatedBy: User?
    var createdAt: Date
    var updatedAt: Date?
    //for test only - it worked
    var textField: String?
    
    var statusRaw: String?
    var status: Status? {
        get { statusRaw.flatMap(Status.init(rawValue:)) }
        set { statusRaw = newValue?.rawValue }
    }
    
    //First section - clearence status
    var clearenceStatusRaw: String?
    var clearenceStatus: ClearenceStatus? {
        get { clearenceStatusRaw.flatMap(ClearenceStatus.init(rawValue:)) }
        set { clearenceStatusRaw = newValue?.rawValue }
    }
    var definitiveRecommendationForRevaluationStatusRaw: [String]?
    var definitiveRecommendationForRevaluationStatus: [RecommendationForRevaluationStatus]? {
        get { definitiveRecommendationForRevaluationStatusRaw?.compactMap(RecommendationForRevaluationStatus.init(rawValue:)) }
        set { definitiveRecommendationForRevaluationStatusRaw = newValue?.map { $0.rawValue } }
    }
    //deprecated
    var recommendationForRevaluationStatusRaw: String?
    var recommendationForRevaluationStatus: RecommendationForRevaluationStatus? {
        get { recommendationForRevaluationStatusRaw.flatMap(RecommendationForRevaluationStatus.init(rawValue:)) }
        set { recommendationForRevaluationStatusRaw = newValue?.rawValue }
    }
    //end deprecated
    var futherRecommendationForRevaluation: [String]?
    
    //Second Section - Comorbities Booleans
    var isPregnant: Bool
    var isInfant: Bool
    var cardiacComorbities: Bool
    var respiratoryComorbities: Bool
    var endocrineComorbities: Bool
    var gastrointestinalComorbities: Bool
    var hematologicalComorbities: Bool
    var imunologicalComorbities: Bool?
    var musculoskeletalComorbities: Bool
    var genitourologicalComorbities: Bool
    var gynecologicalComorbities: Bool?
    var androgenicalComorbities: Bool?
    var neurologicalComorbities: Bool
    var geneticSyndrome: Bool
    var healthyPatient: Bool?
    var surgeryHistory: Bool?
    var anesthesiaHistory: Bool?
    var hasAllergies: Bool?
    
    //one by one
    var isPregnantComorbitiesDetailsRaw: [String]?
    var isPregnantComorbitiesDetails: [PregnantComorbities]? {
        get { isPregnantComorbitiesDetailsRaw?.compactMap(PregnantComorbities.init(rawValue:))}
        set { isPregnantComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var isPregnantDetailsText: String?
    var isPregnantAge: String?
    var isPregnantCustomDetails: [String]?
    
    var isInfantComorbitiesDetailsRaw: [String]?
    var isInfantComorbitiesDetails: [InfantComorbities]? {
        get { isInfantComorbitiesDetailsRaw?.compactMap(InfantComorbities.init(rawValue:))}
        set { isInfantComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var isInfantDetailsText: String?
    var isInfantCustomDetails: [String]?
    
    var cardiacComorbitiesDetailsRaw: [String]?
    var cardiacComorbitiesDetails: [CardiologicComorbities]? {
        get { cardiacComorbitiesDetailsRaw?.compactMap(CardiologicComorbities.init(rawValue:))}
        set { cardiacComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var cardiacComorbitiesDetailsText: String?
    var cardiacComorbitiesCustomDetails: [String]?
    
    var respiratoryComorbitiesDetailsRaw: [String]?
    var respiratoryComorbitiesDetails: [RespiratoryComorbities]? {
        get { respiratoryComorbitiesDetailsRaw?.compactMap(RespiratoryComorbities.init(rawValue:))}
        set { respiratoryComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var respiratoryComorbitiesDetailsText: String?
    var respiratoryComorbitiesCustomDetails: [String]?
    
    var endocrineComorbitiesDetailsRaw: [String]?
    var endocrineComorbitiesDetails: [EndocrineComorbities]? {
        get { endocrineComorbitiesDetailsRaw?.compactMap(EndocrineComorbities.init(rawValue:))}
        set { endocrineComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var endocrineComorbitiesDetailsText: String?
    var endocrineComorbitiesCustomDetails: [String]?
    
    var gastrointestinalComorbitiesDetailsRaw: [String]?
    var gastrointestinalComorbitiesDetails: [GastrointestinalComorbities]? {
        get { gastrointestinalComorbitiesDetailsRaw?.compactMap(GastrointestinalComorbities.init(rawValue:))}
        set { gastrointestinalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var gastrointestinalComorbitiesDetailsText: String?
    var gastrointestinalComorbitiesCustomDetails: [String]?
    
    var hematologicalComorbitiesDetailsRaw: [String]?
    var hematologicalComorbitiesDetails: [HematologicComorbities]? {
        get { hematologicalComorbitiesDetailsRaw?.compactMap(HematologicComorbities.init(rawValue:))}
        set { hematologicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var hematologicalComorbitiesDetailsText: String?
    var hematologicalComorbitiesCustomDetails: [String]?
    
    var imunologicalComorbitiesDetailsRaw: [String]?
    var imunologicalComorbitiesDetails: [ImmunologicComorbities]? {
        get { imunologicalComorbitiesDetailsRaw?.compactMap(ImmunologicComorbities.init(rawValue:))}
        set { imunologicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var imunologicalComorbitiesDetailsText: String?
    var imunologicalComorbitiesCustomDetails: [String]?
    
    var musculoskeletalComorbitiesDetailsRaw: [String]?
    var musculoskeletalComorbitiesDetails: [MusculoskeletalComorbities]? {
        get { musculoskeletalComorbitiesDetailsRaw?.compactMap(MusculoskeletalComorbities.init(rawValue:))}
        set { musculoskeletalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var musculoskeletalComorbitiesDetailsText: String?
    var musculoskeletalComorbitiesCustomDetails: [String]?
    
    var genitourologicalComorbitiesDetailsRaw: [String]?
    var genitourologicalComorbitiesDetails: [GenitourinaryComorbities]? {
        get { genitourologicalComorbitiesDetailsRaw?.compactMap(GenitourinaryComorbities.init(rawValue:))}
        set { genitourologicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var genitourologicalComorbitiesDetailsText: String?
    var genitourologicalComorbitiesCustomDetails: [String]?
    
    var gynecologicalComorbitiesDetailsRaw: [String]?
    var gynecologicalComorbitiesDetails: [GynecologicComorbities]? {
        get { gynecologicalComorbitiesDetailsRaw?.compactMap(GynecologicComorbities.init(rawValue:))}
        set { gynecologicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var gynecologicalComorbitiesDetailsText: String?
    var gynecologicalComorbitiesCustomDetails: [String]?
    
    var androgenicalComorbitiesDetailsRaw: [String]?
    var androgenicalComorbitiesDetails: [AndrologicComorbities]? {
        get { androgenicalComorbitiesDetailsRaw?.compactMap(AndrologicComorbities.init(rawValue:))}
        set { androgenicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var androgenicalComorbitiesDetailsText: String?
    var androgenicalComorbitiesCustomDetails: [String]?
    
    var neurologicalComorbitiesDetailsRaw: [String]?
    var neurologicalComorbitiesDetails: [NeurologicalComorbities]? {
        get { neurologicalComorbitiesDetailsRaw?.compactMap(NeurologicalComorbities.init(rawValue:))}
        set { neurologicalComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var neurologicalComorbitiesDetailsText: String?
    var neurologicalComorbitiesCustomDetails: [String]?
    
    var geneticSyndromeComorbitiesDetailsRaw: [String]?
    var geneticSyndromeComorbitiesDetails: [GeneticSyndrome]? {
        get { geneticSyndromeComorbitiesDetailsRaw?.compactMap(GeneticSyndrome.init(rawValue:))}
        set { geneticSyndromeComorbitiesDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var geneticSyndromeComorbitiesDetailsText: String?
    var geneticSyndromeComorbitiesCustomDetails: [String]?
    
    var surgeryHistoryDetailsRaw: [String]?
    var surgeryHistoryDetails: [SurgeryHistorySpeciality]? {
        get { surgeryHistoryDetailsRaw?.compactMap(SurgeryHistorySpeciality.init(rawValue:))}
        set { surgeryHistoryDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var surgeryHistoryDetailsText: String?
    var surgeryHistoryCustomDetails: [String]?
    
    var anesthesiaHistoryDetailsRaw: [String]?
    var anesthesiaHistoryDetails: [AnesthesiaComplicationsHistory]? {
        get { anesthesiaHistoryDetailsRaw?.compactMap(AnesthesiaComplicationsHistory.init(rawValue:))}
        set { anesthesiaHistoryDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var anesthesiaHistoryDetailsText: String?
    var anesthesiaHistoryCustomDetails: [String]?
    
    
    var socialHabitsAndEnvironmentDetailsRaw: [String]?
    var socialHabitsAndEnvironmentDetails: [SocialHabitsAndEnvironment]? {
        get { socialHabitsAndEnvironmentDetailsRaw?.compactMap(SocialHabitsAndEnvironment.init(rawValue:))}
        set { socialHabitsAndEnvironmentDetailsRaw = newValue?.map { $0.rawValue}}
    }
    var socialHabitsAndEnvironmentDetailsText: String?
    var socialHabitsAndEnvironmentCustomDetails: [String]?
    
    var apfelScoreDetailsRaw: [String]?
    var apfelScoreDetails: [ApfelScore]? {
        get { apfelScoreDetailsRaw?.compactMap(ApfelScore.init(rawValue:))}
        set { apfelScoreDetailsRaw = newValue?.map { $0.rawValue}}
    }
    
    var mallampatiClassificationRaw: [String]?
    var mallampatiClassification: MallampatiClassification? {
        get {
            mallampatiClassificationRaw?.first.flatMap { MallampatiClassification(rawValue: $0) }
        }
        set {
            mallampatiClassificationRaw = newValue.map { [$0.rawValue] }
        }
    }
    
    var difficultAirwayEvaluationRaw: [String]?
    var difficultAirwayEvaluation: [DifficultAirwayEvaluation]? {
        get { difficultAirwayEvaluationRaw?.compactMap(DifficultAirwayEvaluation.init(rawValue:))}
        set { difficultAirwayEvaluationRaw = newValue?.map { $0.rawValue}}
    }
    
    var difficultAirwayEvaluationDetailsText: String?
    var difficultAirwayEvaluationCustomDetails: [String]?
    
    var dailyMedicationsRaw: [String]?
    var dailyMedications: [DailyMedications]? {
        get { dailyMedicationsRaw?.compactMap(DailyMedications.init(rawValue:))}
        set { dailyMedicationsRaw = newValue?.map { $0.rawValue}}
    }
    
    var dailyMedicationsDetailsText: String?
    var dailyMedicationsCustomDetails: [String]?
    
    var allergiesMedicationsCustomDetails: [String]?
    
    
    
    init(
        preanesthesiaId: String = UUID().uuidString,
        surgery: Surgery,
        shared: SharedPreAndAnesthesia? = nil,
        createdBy: User,
        updatedBy: User? = nil,
        createdAt: Date,
        updatedAt: Date? = nil,
        
        textField: String? = nil,
        
        statusRaw: String? = nil,
        
        //First section - clearence status
        clearenceStatus: ClearenceStatus? = nil,
        definitiveRecommendationForRevaluationStatusRaw: RecommendationForRevaluationStatus? = nil,
        //deprecated
        recommendationForRevaluationStatus: RecommendationForRevaluationStatus? = nil,
        //enddeprecated
        futherRecommendationForRevaluation: [String] = [],
        
        //SecondSection - comorbities
        isPregnant: Bool = false,
        isInfant: Bool = false,
        cardiacComorbities: Bool = false,
        respiratoryComorbities: Bool = false,
        endocrineComorbities: Bool = false,
        gastrointestinalComorbities: Bool = false,
        hematologicalComorbities: Bool = false,
        imunologicalComorbities: Bool = false,
        musculoskeletalComorbities: Bool = false,
        genitourologicalComorbities: Bool = false,
        gynecologicalComorbities: Bool? = false,
        androgenicalComorbities: Bool? = false,
        neurologicalComorbities: Bool = false,
        geneticSyndrome: Bool = false,
        healthyPatient: Bool = false,
        hasAllergies: Bool? = false,
        
        
        surgeryHistory: Bool = false,
        anesthesiaHistory: Bool = false,
        
        //one by one
        isPregnantComorbitiesDetails: PregnantComorbities? = nil,
        isPregnantDetailsText: String? = nil,
        isPregnantAge: String? = nil,
        isPregnantCustomDetails: [String]? = [],
        isInfantComorbitiesDetails: InfantComorbities? = nil,
        isInfantDetailsText: String? = nil,
        isInfantCustomDetails: [String]? = [],
        cardiacComorbitiesDetails: CardiologicComorbities? = nil,
        cardiacComorbitiesDetailsText: String? = nil,
        cardiacComorbitiesCustomDetails: [String]? = [],
        respiratoryComorbitiesDetails: RespiratoryComorbities? = nil,
        respiratoryComorbitiesDetailsText: String? = nil,
        respiratoryComorbitiesCustomDetails: [String]? = [],
        endocrineComorbitiesDetails: EndocrineComorbities? = nil,
        endocrineComorbitiesDetailsText: String? = nil,
        endocrineComorbitiesCustomDetails: [String]? = [],
        gastrointestinalComorbitiesDetails: GastrointestinalComorbities? = nil,
        gastrointestinalComorbitiesDetailsText: String? = nil,
        gastrointestinalComorbitiesCustomDetails: [String]? = [],
        hematologicalComorbitiesDetails: HematologicComorbities? = nil,
        hematologicalComorbitiesDetailsText: String? = nil,
        hematologicalComorbitiesCustomDetails: [String]? = [],
        imunologicalComorbitiesDetails: ImmunologicComorbities? = nil,
        imunologicalComorbitiesDetailsText: String? = nil,
        imunologicalComorbitiesCustomDetails: [String]? = [],
        musculoskeletalComorbitiesDetails: MusculoskeletalComorbities? = nil,
        musculoskeletalComorbitiesDetailsText: String? = nil,
        musculoskeletalComorbitiesCustomDetails: [String]? = [],
        genitourologicalComorbitiesDetails: GenitourinaryComorbities? = nil,
        genitourologicalComorbitiesDetailsText: String? = nil,
        genitourologicalComorbitiesCustomDetails: [String]? = [],
        gynecologicalComorbitiesDetails: GynecologicComorbities? = nil,
        gynecologicalComorbitiesDetailsText: String? = nil,
        gynecologicalComorbitiesCustomDetails: [String]? = [],
        androgenicalComorbitiesDetails: AndrologicComorbities? = nil,
        androgenicalComorbitiesDetailsText: String? = nil,
        androgenicalComorbitiesCustomDetails: [String]? = [],
        neurologicalComorbitiesDetails: NeurologicalComorbities? = nil,
        neurologicalComorbitiesDetailsText: String? = nil,
        neurologicalComorbitiesCustomDetails: [String]? = [],
        geneticSyndromeComorbitiesDetails: GeneticSyndrome? = nil,
        geneticSyndromeComorbitiesDetailsText: String? = nil,
        geneticSyndromeComorbitiesCustomDetails: [String]? = [],
        
        surgeryHistoryDetails: SurgeryHistorySpeciality? = nil,
        surgeryHistoryDetailsText: String? = nil,
        surgeryHistoryCustomDetails: [String]? = [],
        anesthesiaHistoryDetails: AnesthesiaComplicationsHistory? = nil,
        anesthesiaHistoryDetailsText: String? = nil,
        anesthesiaHistoryCustomDetails: [String]? = [],
        
        
        socialHabitsAndEnvironmentDetails: SocialHabitsAndEnvironment? = nil,
        socialHabitsAndEnvironmentDetailsText: String? = nil,
        socialHabitsAndEnvironmentCustomDetails: [String]? = [],
        
        apfelScoreDetails: ApfelScore? = nil,
        mallampatiClassification: [MallampatiClassification]? = nil,
        difficultAirwayEvaluation: [DifficultAirwayEvaluation]? = nil,
        difficultAirwayEvaluationDetailsText: String? = nil,
        difficultAirwayEvaluationCustomDetails: [String]? = [],
        
        dailyMedications: [DailyMedications]? = nil,
        dailyMedicationsRawDetailsText: String? = nil,
        dailyMedicationsRawCustomDetails: [String]? = [],
        allergiesMedicationsCustomDetails: [String]? = []
        
        
        
    ) {
        self.preanesthesiaId = preanesthesiaId
        self.surgery = surgery
        self.shared = shared
        self.statusRaw = statusRaw
        self.createdBy = createdBy
        self.updatedBy = updatedBy
        
        self.textField = textField
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.statusRaw = statusRaw
        
        //First section - clearence status
        self.clearenceStatusRaw = clearenceStatus?.rawValue
        self.definitiveRecommendationForRevaluationStatusRaw = definitiveRecommendationForRevaluationStatusRaw.map { [$0.rawValue] }
        //deprecated
        self.recommendationForRevaluationStatusRaw = recommendationForRevaluationStatus?.rawValue
        //end deprecated
        self.futherRecommendationForRevaluation = futherRecommendationForRevaluation
        
        //Second Section - comorbities bool
        self.isPregnant = isPregnant
        self.isInfant = isInfant
        self.cardiacComorbities = cardiacComorbities
        self.respiratoryComorbities = respiratoryComorbities
        self.endocrineComorbities = endocrineComorbities
        self.gastrointestinalComorbities = gastrointestinalComorbities
        self.hematologicalComorbities = hematologicalComorbities
        self.imunologicalComorbities = imunologicalComorbities
        self.musculoskeletalComorbities = musculoskeletalComorbities
        self.genitourologicalComorbities = genitourologicalComorbities
        self.gynecologicalComorbities = gynecologicalComorbities
        self.androgenicalComorbities = androgenicalComorbities
        self.neurologicalComorbities = neurologicalComorbities
        self.geneticSyndrome = geneticSyndrome
        self.healthyPatient = healthyPatient
        self.hasAllergies = hasAllergies
        self.surgeryHistory = surgeryHistory
        self.anesthesiaHistory = anesthesiaHistory
        //one by one
        self.isPregnantComorbitiesDetailsRaw = isPregnantComorbitiesDetails.map { [$0.rawValue] }
        self.isPregnantDetailsText = isPregnantDetailsText
        self.isPregnantAge = isPregnantAge
        self.isPregnantCustomDetails = isPregnantCustomDetails
        self.isInfantComorbitiesDetailsRaw = isInfantComorbitiesDetails.map { [$0.rawValue] }
        self.isInfantCustomDetails = isInfantCustomDetails
        self.isInfantDetailsText = isInfantDetailsText
        self.cardiacComorbitiesDetailsRaw = cardiacComorbitiesDetails.map { [$0.rawValue] }
        self.cardiacComorbitiesCustomDetails = cardiacComorbitiesCustomDetails
        self.cardiacComorbitiesDetailsText = cardiacComorbitiesDetailsText
        self.respiratoryComorbitiesDetailsRaw = respiratoryComorbitiesDetails.map { [$0.rawValue] }
        self.respiratoryComorbitiesDetailsText = respiratoryComorbitiesDetailsText
        self.respiratoryComorbitiesCustomDetails = respiratoryComorbitiesCustomDetails
        self.endocrineComorbitiesDetailsRaw = endocrineComorbitiesDetails.map { [$0.rawValue] }
        self.endocrineComorbitiesDetailsText = endocrineComorbitiesDetailsText
        self.endocrineComorbitiesCustomDetails = endocrineComorbitiesCustomDetails
        self.gastrointestinalComorbitiesDetailsRaw = gastrointestinalComorbitiesDetails.map { [$0.rawValue] }
        self.gastrointestinalComorbitiesDetailsText = gastrointestinalComorbitiesDetailsText
        self.gastrointestinalComorbitiesCustomDetails = gastrointestinalComorbitiesCustomDetails
        self.hematologicalComorbitiesDetailsRaw = hematologicalComorbitiesDetails.map { [$0.rawValue] }
        self.hematologicalComorbitiesDetailsText = hematologicalComorbitiesDetailsText
        self.hematologicalComorbitiesCustomDetails = hematologicalComorbitiesCustomDetails
        self.imunologicalComorbitiesDetailsRaw = imunologicalComorbitiesDetails.map { [$0.rawValue] }
        self.imunologicalComorbitiesDetailsText = imunologicalComorbitiesDetailsText
        self.imunologicalComorbitiesCustomDetails = imunologicalComorbitiesCustomDetails
        self.musculoskeletalComorbitiesDetailsRaw = musculoskeletalComorbitiesDetails.map { [$0.rawValue] }
        self.musculoskeletalComorbitiesDetailsText = musculoskeletalComorbitiesDetailsText
        self.musculoskeletalComorbitiesCustomDetails = musculoskeletalComorbitiesCustomDetails
        self.genitourologicalComorbitiesDetailsRaw = genitourologicalComorbitiesDetails.map { [$0.rawValue] }
        self.genitourologicalComorbitiesDetailsText = genitourologicalComorbitiesDetailsText
        self.genitourologicalComorbitiesCustomDetails = genitourologicalComorbitiesCustomDetails
        self.gynecologicalComorbitiesDetailsRaw = gynecologicalComorbitiesDetails.map { [$0.rawValue] }
        self.gynecologicalComorbitiesDetailsText = gynecologicalComorbitiesDetailsText
        self.gynecologicalComorbitiesCustomDetails = gynecologicalComorbitiesCustomDetails
        self.androgenicalComorbitiesDetailsRaw = androgenicalComorbitiesDetails.map { [$0.rawValue] }
        self.androgenicalComorbitiesDetailsText = androgenicalComorbitiesDetailsText
        self.androgenicalComorbitiesCustomDetails = androgenicalComorbitiesCustomDetails
        self.neurologicalComorbitiesDetailsRaw = neurologicalComorbitiesDetails.map { [$0.rawValue] }
        self.neurologicalComorbitiesDetailsText = neurologicalComorbitiesDetailsText
        self.neurologicalComorbitiesCustomDetails = neurologicalComorbitiesCustomDetails
        self.geneticSyndromeComorbitiesDetailsRaw = geneticSyndromeComorbitiesDetails.map { [$0.rawValue] }
        self.geneticSyndromeComorbitiesDetailsText = geneticSyndromeComorbitiesDetailsText
        self.geneticSyndromeComorbitiesCustomDetails = geneticSyndromeComorbitiesCustomDetails
        self.surgeryHistoryDetailsRaw = surgeryHistoryDetails.map { [$0.rawValue] }
        self.surgeryHistoryDetailsText = surgeryHistoryDetailsText
        self.surgeryHistoryCustomDetails = surgeryHistoryCustomDetails
        self.anesthesiaHistoryDetailsRaw = anesthesiaHistoryDetails.map { [$0.rawValue] }
        self.anesthesiaHistoryDetailsText = anesthesiaHistoryDetailsText
        self.anesthesiaHistoryCustomDetails = anesthesiaHistoryCustomDetails
        
        self.socialHabitsAndEnvironmentDetailsRaw = socialHabitsAndEnvironmentDetails.map { [$0.rawValue] }
        self.socialHabitsAndEnvironmentDetailsText = socialHabitsAndEnvironmentDetailsText
        self.socialHabitsAndEnvironmentCustomDetails = socialHabitsAndEnvironmentCustomDetails
        self.apfelScoreDetailsRaw = apfelScoreDetails.map { [$0.rawValue] }
        
        self.mallampatiClassificationRaw = mallampatiClassification?.map { $0.rawValue }
        self.difficultAirwayEvaluationRaw = difficultAirwayEvaluation?.map { $0.rawValue }
        self.difficultAirwayEvaluationDetailsText = difficultAirwayEvaluationDetailsText
        self.difficultAirwayEvaluationCustomDetails = difficultAirwayEvaluationCustomDetails
        self.dailyMedicationsRaw = dailyMedications?.map { $0.rawValue }
        self.dailyMedicationsDetailsText = dailyMedicationsDetailsText
        self.dailyMedicationsCustomDetails = dailyMedicationsCustomDetails
        self.allergiesMedicationsCustomDetails = allergiesMedicationsCustomDetails
    }
}

