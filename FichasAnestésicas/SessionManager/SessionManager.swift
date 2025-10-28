import SwiftUI
import SwiftData

@Observable
class SessionManager {
    @AppStorage("currentUserID") private var currentUserID: String?
    var currentUser: User? {
        didSet {
            currentUserID = currentUser?.id.uuidString
        }
    }

    // chamada do App quando tiver modelContext disponível
    func loadCurrentUser(using context: ModelContext) {
        guard currentUser == nil,
              let idString = currentUserID,
              let uuid = UUID(uuidString: idString) else { return }
        let fd = FetchDescriptor<User>(predicate: #Predicate { $0.id == uuid })
        if let found = try? context.fetch(fd).first {
            currentUser = found
        } else {
            // usuário salvo não existe mais -> limpar
            currentUserID = nil
        }
    }
}