
import SwiftUI
import SwiftData

struct RootView: View {
    
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
            session.loadCurrentUser(using: context)
        }
    }
}

#Preview("RootView") {
    let session = SessionManager()
    return RootView()
        .environment(session)
        .modelContainer(for: [User.self])
}
