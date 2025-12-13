//
//  UserSelectionView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/10/25.
//


import SwiftUI
import SwiftData

struct UserSelectionView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var userModelContext
    @Query<User>(sort: [SortDescriptor(\.name)]) var users: [User]

    var body: some View {
        NavigationStack {
            List {
                if users.isEmpty {
                    ContentUnavailableView(
                        "Nenhum usuário",
                        systemImage: "person.crop.circle.badge.exclam",
                        description: Text("Crie um usuário para começar.")
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
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
                        NavigationLink("Criar novo usuário", destination: UserFormView(repository: SwiftDataUserRepository(context: userModelContext)))
                    }
                }
            }
            .navigationTitle("Selecionar Usuário")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: UserFormView(repository: SwiftDataUserRepository(context: userModelContext))) {
                        Label("Criar", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    let session = SessionManager()
    return UserSelectionView()
        .environment(session)
        .modelContainer(for: [User.self])
}
