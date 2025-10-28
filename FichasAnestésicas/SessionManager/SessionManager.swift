import SwiftUI
import SwiftData
import Observation

@Observable
class SessionManager {
    // Armazena o ID do usuário logado no UserDefaults
    @ObservationIgnored
    @AppStorage("currentUserID") private var storedUserID: String?

    // Usuário ativo em memória (observável)
    var currentUser: User? {
        didSet {
            // Sincroniza com UserDefaults apenas o ID
            storedUserID = currentUser?.userId
        }
    }

    init() {}

    // Carrega o usuário salvo ao iniciar o app
    func loadCurrentUser(using context: ModelContext) {
        // Evita recarregar se já há um usuário em memória
        guard currentUser == nil, let idString = storedUserID else { return }

        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.userId == idString }
        )
        if let foundUser = try? context.fetch(descriptor).first {
            currentUser = foundUser
        } else {
            // Usuário salvo não existe mais → limpa o registro
            storedUserID = nil
        }
    }
}
