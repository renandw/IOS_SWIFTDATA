import SwiftUI
import SwiftData

struct UserSelectionView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var context
    @Query(sort: \.name) var users: [User]

    var body: some View {
        NavigationStack {
            List {
                if users.isEmpty {
                    NavigationLink("Criar primeiro usuário", destination: UserFormView())
                } else {
                    Section("Selecione um usuário") {
                        ForEach(users, id: \.userId) { user in
                            Button {
                                session.currentUser = user
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .font(.headline)
                                    Text(user.emailAddress)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }

                    Section {
                        NavigationLink("Criar novo usuário", destination: UserFormView())
                    }
                }
            }
            .navigationTitle("Selecionar Usuário")
        }
    }
}