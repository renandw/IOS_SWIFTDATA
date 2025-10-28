//
//  ContentView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/10/25.
//

import SwiftUI
import SwiftData


struct UserListView: View {
    @Environment(\.modelContext) var userModelContext
    @Query(sort: \User.crm) var users: [User]
    @State private var showingCreate = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserFormView(user: user, repository: SwiftDataUserRepository(context: userModelContext))) {
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
    
    private func deleteUsers(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            userModelContext.delete(user)
        }
        try? userModelContext.save()
    }
}

#Preview {
    UserListView()
        .modelContainer(for: [User.self])
}
