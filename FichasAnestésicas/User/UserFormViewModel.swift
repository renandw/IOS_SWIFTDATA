import Foundation
import SwiftData
import Combine

final class UserFormViewModel: ObservableObject {
    // Dependencies
    private let repository: UserRepository

    // Editing target (nil for create)
    private(set) var editingUser: User?

    // Form fields
    @Published var name: String = ""
    @Published var crm: String = ""
    @Published var emailAddress: String = ""
    @Published var phone: String = ""
    @Published var rqe: String = ""

    // Validation errors
    @Published var nameError: String? = nil
    @Published var crmError: String? = nil
    @Published var emailError: String? = nil
    @Published var phoneError: String? = nil

    // UI state
    @Published var isSaving: Bool = false
    @Published var saveError: String? = nil

    init(repository: UserRepository, user: User? = nil) {
        self.repository = repository
        self.editingUser = user
        if let user {
            self.name = user.name
            self.crm = user.crm
            self.rqe = user.rqe ?? ""
            self.emailAddress = user.emailAddress
            self.phone = user.phone ?? ""
        }
    }

    var formIsValid: Bool {
        validateName(name) && validateCRM(crm) && validateEmail(emailAddress) && validatePhone(phone)
    }

    func save() {
        guard formIsValid else { return }
        isSaving = true
        saveError = nil

        // Minimal normalization for name: trim and collapse spaces
        let cleanedName = name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")

        do {
            if let user = editingUser {
                user.name = cleanedName
                user.crm = crm
                user.rqe = rqe
                user.emailAddress = emailAddress
                user.phone = phone
                try repository.update(user)
            } else {
                let newUser = User(userId: UUID().uuidString,
                                   name: cleanedName,
                                   crm: crm,
                                   rqe: rqe,
                                   phone: phone,
                                   emailAddress: emailAddress,
                                   createdAt: .now)
                try repository.create(newUser)
                self.editingUser = newUser
            }
            isSaving = false
        } catch {
            isSaving = false
            saveError = error.localizedDescription
        }
    }

    // MARK: - Validation

    func validateName(_ value: String) -> Bool {
        let parts = value.split(separator: " ").filter { !$0.isEmpty }
        return parts.count >= 2
    }

    func validateCRM(_ value: String) -> Bool {
        let pattern = "^[0-9]+-[A-Z]{2}$"
        return value.range(of: pattern, options: .regularExpression) != nil
    }

    func validateEmail(_ value: String) -> Bool {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.(com|com\\.br)$"
        return trimmed.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }

    func validatePhone(_ value: String) -> Bool {
        let pattern = "^\\([0-9]{2}\\) [0-9]{5}-[0-9]{4}$"
        return value.range(of: pattern, options: .regularExpression) != nil
    }
}
