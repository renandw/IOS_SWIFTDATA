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
    var infectiousComorbities: Bool?
    var oncologicComorbities: Bool?
    var geneticSyndrome: Bool
    var healthyPatient: Bool?
    var surgeryHistory: Bool?
    var anesthesiaHistory: Bool?
    var hasAllergies: Bool?
    
    //newFormat
    @Relationship var pregnancyDetails: [PregnancyDetail]?
    @Relationship var infantDetails: [InfantDetail]?
    
    @Relationship var oncologyDetails: [OncologyComorbidityDetail]?
    @Relationship var cardiologyDetails: [CardiologyComorbidityDetail]?
    @Relationship var respiratoryDetails: [RespiratoryComorbidityDetail]?
    @Relationship var endocrineDetails: [EndocrineComorbidityDetail]?
    @Relationship var gastroIntestinalDetails: [GastroIntestinalComorbidityDetail]?
    @Relationship var hematologyDetails: [HematologyComorbidityDetail]?
    @Relationship var imunologyDetails: [ImunologyComorbidityDetail]?
    @Relationship var musculoskeletalDetails: [MusculoskeletalComorbidityDetail]?
    @Relationship var genitoUrinaryDetails: [GenitoUrinaryComorbidityDetail]?
    @Relationship var gynecologyDetails: [GynecologicComorbityDetail]?
    @Relationship var androgenyDetails: [AndrogenicComorbityDetail]?
    @Relationship var neurologyDetails: [NeurologyComorbityDetail]?
    @Relationship var infectiousDetails: [InfectiousComorbityDetail]?
    @Relationship var geneticSyndromeDetails: [GeneticSyndromeDetail]?
    
    @Relationship var surgeryHistoricDetails: [SurgeryHistoryDetail]?
    @Relationship var anesthesiaHistoricDetails: [AnesthesiaHistoryDetail]?
    
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
    
    var laboratoryExams: LaboratoryExams?
    
    var imagingExams: [ImagingExam]?
    var customImagingExams: [String]?
    
    var physicalExaminationDetailsText: String?
    
    
    
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
        infectiousComorbities: Bool = false,
        oncologicComorbities: Bool = false,
        geneticSyndrome: Bool = false,
        healthyPatient: Bool = false,
        hasAllergies: Bool? = false,
        
        
        surgeryHistory: Bool = false,
        anesthesiaHistory: Bool = false,
        
        //newSection
        pregnancyDetails: [PregnancyDetail]? = nil,
        infantDetails: [InfantDetail]? = nil,
        
        oncologyDetails: [OncologyComorbidityDetail]? = nil,
        cardiologyDetails: [CardiologyComorbidityDetail]? = nil,
        respiratoryDetails: [RespiratoryComorbidityDetail]? = nil,
        endocrineDetails: [EndocrineComorbidityDetail]? = nil,
        gastroIntestinalDetails: [GastroIntestinalComorbidityDetail]? = nil,
        hematologyDetails: [HematologyComorbidityDetail]? = nil,
        imunologyDetails: [ImunologyComorbidityDetail]? = nil,
        musculoskeletalDetails: [MusculoskeletalComorbidityDetail]? = nil,
        genitoUrinaryDetails: [GenitoUrinaryComorbidityDetail]? = nil,
        gynecologyDetails: [GynecologicComorbityDetail]? = nil,
        androgenyDetails: [AndrogenicComorbityDetail]? = nil,
        neurologyDetails: [NeurologyComorbityDetail]? = nil,
        infectiousDetails: [InfectiousComorbityDetail]? = nil,
        geneticSyndromeDetails: [GeneticSyndromeDetail]? = nil,
        
        surgeryHistoricDetails: [SurgeryHistoryDetail]? = nil,
        anesthesiaHistoricDetails: [AnesthesiaHistoryDetail]? = nil,
        
        //one by one
        isPregnantComorbitiesDetails: PregnantComorbities? = nil,
        isPregnantDetailsText: String? = nil,
        isPregnantAge: String? = nil,
        isPregnantCustomDetails: [String]? = [],
        isInfantComorbitiesDetails: InfantComorbities? = nil,
        isInfantDetailsText: String? = nil,
        isInfantCustomDetails: [String]? = [],
        
        
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
        allergiesMedicationsCustomDetails: [String]? = [],
        laboratoryExams: LaboratoryExams? = nil,
        imagingExams: [ImagingExam]? = nil,
        customImagingExams: [String]? = [],
        physicalExaminationDetailsText: String? = nil,
        
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
        self.infectiousComorbities = infectiousComorbities
        self.oncologicComorbities = oncologicComorbities
        self.geneticSyndrome = geneticSyndrome
        self.healthyPatient = healthyPatient
        self.hasAllergies = hasAllergies
        self.surgeryHistory = surgeryHistory
        self.anesthesiaHistory = anesthesiaHistory
        // newsection
        self.pregnancyDetails = pregnancyDetails
        self.infantDetails = infantDetails
        
        self.oncologyDetails = oncologyDetails
        self.cardiologyDetails = cardiologyDetails
        self.respiratoryDetails = respiratoryDetails
        self.endocrineDetails = endocrineDetails
        self.gastroIntestinalDetails = gastroIntestinalDetails
        self.hematologyDetails = hematologyDetails
        self.imunologyDetails = imunologyDetails
        self.musculoskeletalDetails = musculoskeletalDetails
        self.genitoUrinaryDetails = genitoUrinaryDetails
        self.gynecologyDetails = gynecologyDetails
        self.androgenyDetails = androgenyDetails
        self.neurologyDetails = neurologyDetails
        self.infectiousDetails = infectiousDetails
        self.geneticSyndromeDetails = geneticSyndromeDetails
        
        self.surgeryHistoricDetails = surgeryHistoricDetails
        self.anesthesiaHistoricDetails = anesthesiaHistoricDetails
        
        //one by one
        self.isPregnantComorbitiesDetailsRaw = isPregnantComorbitiesDetails.map { [$0.rawValue] }
        self.isPregnantDetailsText = isPregnantDetailsText
        self.isPregnantAge = isPregnantAge
        self.isPregnantCustomDetails = isPregnantCustomDetails
        self.isInfantComorbitiesDetailsRaw = isInfantComorbitiesDetails.map { [$0.rawValue] }
        self.isInfantCustomDetails = isInfantCustomDetails
        self.isInfantDetailsText = isInfantDetailsText
        
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
        self.laboratoryExams = laboratoryExams
        self.imagingExams = imagingExams
        self.customImagingExams = customImagingExams
        self.physicalExaminationDetailsText = physicalExaminationDetailsText
    }
}
