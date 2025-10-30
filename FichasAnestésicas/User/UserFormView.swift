import SwiftUI
import SwiftData

struct UserFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel: UserFormViewModel
    
    private let userToEdit: User?
    
    init(user: User? = nil, repository: UserRepository) {
        self.userToEdit = user
        _viewModel = StateObject(wrappedValue: UserFormViewModel(repository: repository, user: user))
    }
    
    #if DEBUG
    init(previewUser user: User? = nil) {
        self.userToEdit = user
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: User.self, configurations: configuration)
        let context = ModelContext(container)
        _viewModel = StateObject(wrappedValue: UserFormViewModel(
            repository: SwiftDataUserRepository(context: context),
            user: user
        ))
    }
    #endif
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $viewModel.name)
                    .textInputAutocapitalization(.words)
                    .onChange(of: viewModel.name) { _, newValue in
                        // Do not rewrite the text while typing to preserve spaces/cursor
                        viewModel.nameError = viewModel.validateName(newValue) ? nil : "Informe nome e sobrenome."
                    }
                if let nameError = viewModel.nameError {
                    Text(nameError).font(.footnote).foregroundStyle(.red)
                }
                TextField("CRM", text: $viewModel.crm)
                    .textInputAutocapitalization(.characters)
                    .onChange(of: viewModel.crm) { _, newValue in
                        // Allow user to type freely, but normalize lightweight aspects only
                        // 1) Uppercase letters
                        var normalized = newValue.uppercased()
                        // 2) Keep only letters, digits, and hyphen
                        normalized = normalized.filter { $0.isNumber || ($0 >= "A" && $0 <= "Z") || $0 == "-" }
                        // 3) Ensure at most a single hyphen (keep first, drop the rest)
                        if normalized.filter({ $0 == "-" }).count > 1 {
                            var seenHyphen = false
                            normalized = normalized.reduce(into: "") { acc, ch in
                                if ch == "-" {
                                    if !seenHyphen { acc.append(ch); seenHyphen = true }
                                } else {
                                    acc.append(ch)
                                }
                            }
                        }
                        // Do not force split/merge around the hyphen while typing; let the user position the cursor
                        if normalized != viewModel.crm {
                            viewModel.crm = normalized
                        }
                        // Validate current value without forcing a rewrite
                        viewModel.crmError = viewModel.validateCRM(viewModel.crm) ? nil : "Formato: numeros-UF (ex: 12345-SP)"
                    }
                    .onSubmit {
                        // On submit, apply the stricter formatting numbers-UF with up to 2 letters
                        let finalized = formatCRM(viewModel.crm)
                        if finalized != viewModel.crm {
                            viewModel.crm = finalized
                        }
                        viewModel.crmError = viewModel.validateCRM(viewModel.crm) ? nil : "Formato: numeros-UF (ex: 12345-SP)"
                    }
                if let crmError = viewModel.crmError {
                    Text(crmError).font(.footnote).foregroundStyle(.red)
                }
                TextField("RQE", text: $viewModel.rqe)
                TextField("Email", text: $viewModel.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.emailAddress) { _, newValue in
                        let normalized = newValue
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .lowercased()
                        if normalized != viewModel.emailAddress {
                            viewModel.emailAddress = normalized
                        }
                        if normalized.hasSuffix(".com") || normalized.hasSuffix(".com.br") {
                            viewModel.emailError = viewModel.validateEmail(normalized) ? nil : "Email inválido (.com ou .com.br)"
                        } else if normalized.isEmpty {
                            viewModel.emailError = nil
                        } else {
                            viewModel.emailError = nil
                        }
                    }
                if let emailError = viewModel.emailError {
                    Text(emailError).font(.footnote).foregroundStyle(.red)
                }
                TextField("Telefone", text: $viewModel.phone)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.phone) { _, newValue in
                        let formatted = formatPhone(newValue)
                        if formatted != viewModel.phone {
                            viewModel.phone = formatted
                        }
                        viewModel.phoneError = viewModel.validatePhone(viewModel.phone) ? nil : "Formato: (XX) XXXXX-XXXX"
                    }
                if let phoneError = viewModel.phoneError {
                    Text(phoneError).font(.footnote).foregroundStyle(.red)
                }
            }
            .navigationTitle(userToEdit == nil ? "Novo Usuário" : "Editar Usuário")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        viewModel.save()
                        if viewModel.saveError == nil {
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.formIsValid || viewModel.isSaving)
                }
            }
        }
    }
    
    private func digitsOnly(_ s: String) -> String { s.filter { $0.isNumber } }
    
    private func formatCRM(_ value: String) -> String {
        // Keep only digits and letters, then format as numbers-UF (UF = 2 letters)
        let allowed = value.uppercased().filter { $0.isNumber || ($0 >= "A" && $0 <= "Z") || $0 == "-" }
        // Remove extra hyphens
        let noDupHyphen = allowed.replacingOccurrences(of: "--", with: "-")
        // Split by hyphen
        let comps = noDupHyphen.split(separator: "-", maxSplits: 1, omittingEmptySubsequences: false)
        let digits = comps.first.map { String($0).filter { $0.isNumber } } ?? ""
        let letters = comps.count > 1 ? String(comps[1]).filter { $0.isLetter }.prefix(2) : ""
        var out = digits
        if !letters.isEmpty {
            out += "-" + letters
        }
        return out
    }
    
    private func formatPhone(_ value: String) -> String {
        // Formats to (XX) XXXXX-XXXX using only digits
        let d = digitsOnly(value)
        var result = ""
        let digits = Array(d.prefix(11))
        if digits.count > 0 {
            result += "("
            result += String(digits.prefix(2))
            result += ") "
        }
        if digits.count > 2 {
            let start = 2
            let midEnd = min(digits.count, 7)
            result += String(digits[start..<midEnd])
        }
        if digits.count > 7 {
            result += "-"
            result += String(digits[7..<min(digits.count, 11)])
        }
        return result
    }
}

#Preview("Create & Edit") {
    // Create an in-memory model container for previews
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: configuration)

    // Seed a sample user for the edit preview
    let sampleUser = User(userId: UUID().uuidString,
                          name: "Maria Souza",
                          crm: "1234-AB",
                          rqe: "2345",
                          phone: "(69) 98132-8798",
                          emailAddress: "maria@example.com",
                          createdAt: .now)
    let context = ModelContext(container)
    context.insert(sampleUser)
    try? context.save()
    
    let repo = SwiftDataUserRepository(context: context)

    return VStack(spacing: 24) {
        NavigationStack { UserFormView(user: nil, repository: repo) }
        Divider()
        NavigationStack { UserFormView(user: sampleUser, repository: repo) }
    }
    .modelContainer(container)
}
