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
    @Environment(\.modelContext) var context
    @Query<User>(sort: [SortDescriptor(\.name)]) var users: [User]

    var body: some View {
        NavigationStack {
            List {
                if users.isEmpty {
                    ContentUnavailableView(
                        "Nenhum usuário",
                        systemImage: "person.crop.circle.badge.exclam",
                        description: Text("Crie o primeiro usuário para começar.")
                    )
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(
                        NavigationLink(destination: UserFormView()) {
                            Text("Criar primeiro usuário")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        , alignment: .bottom
                    )
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

#Preview {
    let session = SessionManager()
    return UserSelectionView()
        .environment(session)
        .modelContainer(for: [User.self]) // sem inMemory
}
