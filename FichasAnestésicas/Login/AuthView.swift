import SwiftUI
import SwiftData

struct AuthView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) var context
    
    @State private var isLogin = true
    
    // Campos do formulário
    @State private var name = ""
    @State private var crm = ""
    @State private var rqe = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    
    // Estados
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var migrationStatus: String?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Modo", isOn: $isLogin)
                        .toggleStyle(.switch)
                        .onChange(of: isLogin) { _, _ in
                            errorMessage = nil
                        }
                } header: {
                    Text(isLogin ? "Entrar" : "Criar Conta")
                }
                
                if !isLogin {
                    Section("Dados do Médico") {
                        TextField("Nome completo", text: $name)
                            .textInputAutocapitalization(.words)
                        
                        TextField("CRM-UF", text: $crm)
                            .textInputAutocapitalization(.characters)
                        
                        TextField("RQE (opcional)", text: $rqe)
                            .keyboardType(.numberPad)
                        
                        TextField("Telefone (opcional)", text: $phone)
                            .keyboardType(.phonePad)
                    }
                }
                
                Section("Credenciais") {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .onChange(of: email) { _, newValue in
                            // ✅ Normaliza em tempo real
                            let normalized = newValue
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                                .lowercased()
                            if normalized != email {
                                email = normalized
                            }
                        }
                    
                    SecureField("Senha", text: $password)
                }
                
                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
                
                Section {
                    Button {
                        Task {
                            if isLogin {
                                await handleLogin()
                            } else {
                                await handleRegister()
                            }
                        }
                    } label: {
                        if isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            Text(isLogin ? "Entrar" : "Criar Conta")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(isLoading || !isFormValid)
                }
                // MARK: - Migração (uso temporário para popular o servidor)
                Section("Migração") {
                    Button("Migrar usuários (SwiftData → Servidor)") {
                        Task {
                            await migrateUsersToServer()
                        }
                    }
                    .disabled(isLoading)

                    if let migrationStatus {
                        Text(migrationStatus)
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle(isLogin ? "Login" : "Registro")
        }
    }
    
    // MARK: - Validação
    private var isFormValid: Bool {
        let emailValid = email.contains("@") && !email.isEmpty
        let passwordValid = password.count >= 6
        
        if isLogin {
            return emailValid && passwordValid
        } else {
            return !name.isEmpty && !crm.isEmpty && emailValid && passwordValid
        }
    }
    
    // MARK: - Login
    @MainActor
    private func handleLogin() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            // ✅ Normaliza antes de enviar
            let normalizedEmail = email
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
            
            let response = try await APIService.shared.login(
                emailAddress: normalizedEmail,
                password: password
            )
            
            // Salva token
            UserDefaults.standard.set(response.token, forKey: "authToken")
            // Salva também o ID do usuário para o SessionManager recarregar ao abrir o app
            UserDefaults.standard.set(response.user.userId, forKey: "currentUserID")
            
            // ✅ Verifica se User já existe no SwiftData
            let descriptor = FetchDescriptor<User>(
                predicate: #Predicate { $0.userId == response.user.userId }
            )
            let existingUsers = try? context.fetch(descriptor)
            
            let user: User
            if let existingUser = existingUsers?.first {
                // Atualiza dados do usuário existente
                existingUser.name = response.user.name
                existingUser.crm = response.user.crm
                existingUser.rqe = response.user.rqe
                existingUser.phone = response.user.phone
                existingUser.emailAddress = response.user.emailAddress
                existingUser.updatedAt = Date()
                user = existingUser
            } else {
                // Cria novo User
                user = User(
                    userId: response.user.userId,
                    name: response.user.name,
                    crm: response.user.crm,
                    rqe: response.user.rqe,
                    phone: response.user.phone,
                    emailAddress: response.user.emailAddress,
                    createdAt: response.user.createdAt,
                    updatedAt: nil
                )
                context.insert(user)
            }
            
            try? context.save()
            
            // Define como usuário atual
            session.currentUser = user
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        // isLoading is handled by defer
    }
    
    // MARK: - Register
    @MainActor
    private func handleRegister() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            // ✅ Normaliza antes de enviar
            let normalizedEmail = email
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
            
            let userId = try await APIService.shared.register(
                name: name,
                crm: crm,
                rqe: rqe.isEmpty ? nil : rqe,
                phone: phone.isEmpty ? nil : phone,
                emailAddress: normalizedEmail,
                password: password
            )
            
            // Após registrar, faz login automaticamente
            await handleLogin()
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        // isLoading is handled by defer
    }
    // MARK: - Migração
    @MainActor
    private func migrateUsersToServer() async {
        isLoading = true
        errorMessage = nil
        migrationStatus = nil
        defer { isLoading = false }

        do {
            let descriptor = FetchDescriptor<User>()
            let users = try context.fetch(descriptor)

            var ok = 0
            var failed = 0

            for u in users {
                do {
                    _ = try await APIService.shared.register(
                        userId: u.userId,
                        name: u.name,
                        crm: u.crm,
                        rqe: u.rqe,
                        phone: u.phone,
                        emailAddress: u.emailAddress,
                        password: "mude-me-depois-123"
                    )
                    ok += 1
                } catch {
                    failed += 1
                }
            }

            migrationStatus = "Migração concluída. OK: \(ok) | Falhou: \(failed)"
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    let session = SessionManager()
    return AuthView()
        .environment(session)
        .modelContainer(for: [User.self])
}
