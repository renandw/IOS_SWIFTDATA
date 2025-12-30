//
//  UserDetails.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/10/25.
//

import SwiftUI
import SwiftData

struct UserDetails: View {
    let userId: String

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(SessionManager.self) private var session

    @State private var showingEdit = false
    @State private var showingDeleteConfirm = false

    @Query private var fetched: [User]

    // Related entities queries - these model types must exist in the project
    @Query private var patients: [Patient]
    @Query private var surgeries: [Surgery]
    @Query private var anesthesia: [Anesthesia]
    @Query private var preAnesthesia: [PreAnesthesia]

    init(userId: String) {
        self.userId = userId
        self._fetched = Query(filter: #Predicate<User> { $0.userId == userId })
        self._patients = Query(
              filter: #Predicate<Patient> { $0.createdBy.userId == userId },
              sort: [SortDescriptor(\Patient.name, order: .forward)]
          )
        self._surgeries = Query(filter: #Predicate<Surgery> { $0.createdBy.userId == userId })
        self._anesthesia = Query(filter: #Predicate<Anesthesia> { $0.createdBy.userId == userId })
        self._preAnesthesia = Query(filter: #Predicate<PreAnesthesia> { $0.createdBy.userId == userId })
    }

    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }

    var body: some View {
        if let user = fetched.first {
            List {
                Section("Atividades") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CountCard(title: "Pacientes", count: patients.count, systemImage: "person.2")
                            CountCard(title: "Cirurgias", count: surgeries.count, systemImage: "scissors")
                            CountCard(title: "Anestesias", count: anesthesia.count, systemImage: "stethoscope")
                            CountCard(title: "APA.", count: preAnesthesia.count, systemImage: "doc.text.magnifyingglass")
                        }
                        .padding(.vertical, 4)
                    }
                }
                Section("Informações") {
                    LabeledValueRow(title: "User ID", value: user.userId)
                    LabeledValueRow(title: "Nome", value: user.name)
                    LabeledValueRow(title: "CRM", value: user.crm)
                    LabeledValueRow(title: "RQE", value: user.rqe ?? "Cadastro pendente")
                    LabeledValueRow(title: "Telefone", value: user.phone ?? "Cadastro Pendente")
                    LabeledValueRow(title: "E-mail", value: user.emailAddress)
                }
                Section("Metadados") {
                    LabeledValueRow(title: "Criado em", value: dateFormatter.string(from: user.createdAt))
                    LabeledValueRow(title: "Atualizado em", value: user.updatedAt.map { dateFormatter.string(from: $0) } ?? "Nunca foi atualizado")
                }
                Section {
                    NavigationLink("Criar backup completo", destination: BackupView())
                        .foregroundStyle(.blue)
                } header: {
                    HStack{
                        Image(systemName: "externaldrive.fill")
                        Text("Criar Backup")
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .navigationTitle(user.name.isEmpty ? "Detalhes do Usuário" : user.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Editar", systemImage: "pencil") { showingEdit = true }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button("Excluir", systemImage: "trash") { showingDeleteConfirm = true }
                }
            }
            .sheet(isPresented: $showingEdit) {
                NavigationStack {
                    UserFormView(user: user, repository: SwiftDataUserRepository(context: modelContext))
                }
            }
            .confirmationDialog(
                "Excluir usuário?",
                isPresented: $showingDeleteConfirm,
                titleVisibility: .visible
            ) {
                Button("Excluir", role: .destructive) {
                    session.currentUser = nil
                    modelContext.delete(user)
                    try? modelContext.save()
                    dismiss()
                }
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text("Esta ação não pode ser desfeita.")
            }
        } else {
            ContentUnavailableView("Usuário não encontrado", systemImage: "person.crop.circle.badge.exclam")
        }
    }
}

private struct LabeledValueRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                
                .foregroundStyle(.secondary)
            Spacer(minLength: 16)
            Text(value)
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
        }
        .textSelection(.enabled)
    }
}

private struct CountCard: View {
    let title: String
    let count: Int
    let systemImage: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundStyle(.blue)
                Spacer()
                Text("\(count)")
                    .font(.title2).bold()
            }
            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(minWidth: 140)
        .background(RoundedRectangle(cornerRadius: 12).fill(.thinMaterial))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.quaternary, lineWidth: 0.5)
        )
    }
}

#Preview("User Details") {
    // Create an in-memory model container and a sample user for preview
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: configuration)
    let context = ModelContext(container)

    let sample = User(userId: UUID().uuidString,
                      name: "Renan Dantas Wrobel",
                      crm: "4794-SP",
                      rqe: "2516",
                      phone: "(69) 98132-8798",
                      emailAddress: "renandw@me.com",
                      createdAt: .now.addingTimeInterval(-86400 * 20),
                      updatedAt: .now)
    context.insert(sample)
    try? context.save()

    return NavigationStack { UserDetails(userId: sample.userId) }
        .modelContainer(container)
}
