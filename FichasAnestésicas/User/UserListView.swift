//
//  ContentView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/10/25.
//

import SwiftUI
import SwiftData


struct UserListView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var userModelContext
    
    @Query(sort: \User.updatedAt) var users: [User]
    
    @State private var showingCreate = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserDetails(userId: user.userId)) {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            HStack {
                                Text(user.crm)
                                if !user.emailAddress.isEmpty {
                                    Text("· \(user.emailAddress)")
                                }
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .navigationTitle("Lista de Usuários")
            .toolbar{
                if users.isEmpty {
                    Button("Adicionar Usuário", systemImage: "plus") {
                        showingCreate = true
                    }
                    .sheet(isPresented: $showingCreate) {
                        NavigationStack {
                            UserFormView(user: nil, repository: SwiftDataUserRepository(context: userModelContext))
                        }
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
    }
    
    private func deleteUsers(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            // Se o usuário deletado é o usuário logado, faz logout
            if user.userId == session.currentUser?.userId {
                session.logout()
            }
            userModelContext.delete(user)
        }
        try? userModelContext.save()
    }
}

#Preview {
    let session = SessionManager()
    UserListView()
        .modelContainer(for: [User.self])
        .environment(session)
}
