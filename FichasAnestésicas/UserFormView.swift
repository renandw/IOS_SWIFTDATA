import SwiftUI
import SwiftData

struct UserFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name: String
    @State private var crm: String
    @State private var emailAddress: String
    
    private let userToEdit: User?
    
    init(user: User? = nil) {
        self.userToEdit = user
        _name = State(initialValue: user?.name ?? "")
        _crm = State(initialValue: user?.crm ?? "")
        _emailAddress = State(initialValue: user?.emailAddress ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("CRM", text: $crm)
                TextField("Email", text: $emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .navigationTitle(userToEdit == nil ? "Novo Usuário" : "Editar Usuário")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(name.isEmpty || crm.isEmpty)
                }
            }
        }
    }
    
    private func save() {
        if let user = userToEdit {
            user.name = name
            user.crm = crm
            user.emailAddress = emailAddress
            try? modelContext.save()
        } else {
            let newUser = User(userId: UUID().uuidString,
                               name: name,
                               crm: crm,
                               emailAddress: emailAddress,
                               createdAt: Date.now)
            modelContext.insert(newUser)
            try? modelContext.save()
        }
        dismiss()
    }
}

#Preview {
    @Query(sort: \User.createdAt, order: .forward) var users
    
    ModelContainerPreview {
        VStack {
            UserFormView()
            Divider()
            if let existingUser = users.first {
                UserFormView(user: existingUser)
            } else {
                Text("No user available for edit preview")
            }
        }
    }
    .modelContainer(for: [User.self])
}
