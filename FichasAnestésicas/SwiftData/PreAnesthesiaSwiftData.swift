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
    var neurologicalComorbities: Bool
    var geneticSyndrome: Bool
    
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
        neurologicalComorbities: Bool = false,
        geneticSyndrome: Bool = false,
        
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
        self.neurologicalComorbities = neurologicalComorbities
        self.geneticSyndrome = geneticSyndrome
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
        
    }
}
