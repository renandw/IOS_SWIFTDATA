import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var context

    var body: some View {
        Group {
            if session.currentUser == nil {
                UserSelectionView()
            } else {
                MainAppView() // sua tela principal
            }
        }
        .task {
            // Carrega o usuário salvo (por userId) ao iniciar o app
            session.loadCurrentUser(using: context)
        }
    }
}