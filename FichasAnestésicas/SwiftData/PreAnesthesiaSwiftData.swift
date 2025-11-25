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
        futherRecommendationForRevaluation: [String] = []
        
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
    }
}
