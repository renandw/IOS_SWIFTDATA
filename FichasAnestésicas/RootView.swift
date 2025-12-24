
import SwiftUI
import SwiftData

struct RootView: View {
    @State private var didRunManualMigrations = false
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var context

    var body: some View {
        Group {
            if let user = session.currentUser {
                DashboardView(userId: user.userId)
            } else {
                UserSelectionView()
            }
        }
        .task {
            if !didRunManualMigrations {
                didRunManualMigrations = true
                try? migrateOncologyIfNeeded(context: context)
            }
            session.loadCurrentUser(using: context)
        }    }
}

#Preview("RootView") {
    let session = SessionManager()
    return RootView()
        .environment(session)
        .modelContainer(for: [User.self])
}
