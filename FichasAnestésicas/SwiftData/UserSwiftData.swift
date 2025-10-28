import Foundation
import SwiftData

// MARK: - Usuário (autor/criador de registros)

@Model
final class User {
    @Attribute(.unique) var userId: String
    var name: String
    var crm: String
    var rqe: String?
    var phone: String?
    @Attribute(.unique) var emailAddress: String
    
    @Relationship(deleteRule: .cascade, inverse: \Patient.createdBy)
    var createdPatients: [Patient] = []
    
    var createdAt: Date
    var updatedAt: Date?

    init(userId: String, name: String, crm: String, rqe: String? = nil, phone: String? = nil, emailAddress: String, createdAt: Date, updatedAt: Date? = nil) {
        self.userId = userId
        self.name = name
        self.crm = crm
        self.rqe = rqe
        self.phone = phone
        self.emailAddress = emailAddress
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
