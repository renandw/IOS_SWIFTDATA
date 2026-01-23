import SwiftUI
import SwiftData

struct RootView: View {
    @State private var didRunManualMigrations = false
    @AppStorage("authToken") private var authToken: String?
    @AppStorage("currentUserID") private var currentUserID: String?
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var context
    @Environment(SyncManager.self) var syncManager
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if authToken == nil || currentUserID == nil {
                AuthView()
            } else if let user = session.currentUser {
                DashboardView(userId: user.userId)
            } else {
                ProgressView("Carregando...")
            }
        }
        .task {
            guard authToken != nil, currentUserID != nil else { return }
            syncManager.lastSyncDate = nil 
            session.loadCurrentUser(using: context)
            await syncManager.sync(context: context)
        }
        .onChange(of: scenePhase) { phase in
            guard phase == .active, authToken != nil, currentUserID != nil else { return }
            Task {
                session.loadCurrentUser(using: context) // opcional mas ajuda em multi-device
                await syncManager.sync(context: context)
            }
        }
    }
}

#Preview("RootView") {
    let session = SessionManager()
    let syncManager = SyncManager() // ✅ Adicionar
    return RootView()
        .environment(session)
        .environment(syncManager) // ✅ Adicionar
        .modelContainer(for: [User.self])
}
