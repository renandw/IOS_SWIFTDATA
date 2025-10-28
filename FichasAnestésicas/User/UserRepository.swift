import Foundation
import SwiftData

enum UserRepositoryError: Error {
    case notFound
}

protocol UserRepository {
    func listAll() throws -> [User]
    func get(byId id: String) throws -> User
    func create(_ user: User) throws
    func update(_ user: User) throws
    func delete(_ user: User) throws
}

final class SwiftDataUserRepository: UserRepository {
    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    public func listAll() throws -> [User] {
        var descriptor = FetchDescriptor<User>()
        descriptor.sortBy = [SortDescriptor(\.name, order: .forward)]
        return try context.fetch(descriptor)
    }

    public func get(byId id: String) throws -> User {
        var descriptor = FetchDescriptor<User>(predicate: #Predicate { $0.userId == id })
        descriptor.fetchLimit = 1
        if let found = try context.fetch(descriptor).first {
            return found
        }
        throw UserRepositoryError.notFound
    }

    public func create(_ user: User) throws {
        context.insert(user)
        user.createdAt = .now
        try context.save()
    }

    public func update(_ user: User) throws {
        // Assuming the user instance is already managed by the context
        user.updatedAt = .now
        try context.save()
    }

    public func delete(_ user: User) throws {
        context.delete(user)
        try context.save()
    }
}
