//
//  DashboardView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/10/25.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct DashboardView: View {
    let userId: String
    
    @Environment(SessionManager.self) var session
    @Query(sort:\Patient.name) var patients: [Patient]
    @Query(sort: \Surgery.date, order: .reverse) var surgeries: [Surgery]
    @Environment(\.modelContext) private var patientContext
    
    init(userId: String) {
        self.userId = userId
        _patients = Query(
            filter: #Predicate<Patient> { $0.createdBy.userId == userId },
            sort: [SortDescriptor(\.name)]
        )
        _surgeries = Query(
            filter: #Predicate<Surgery> { $0.createdBy.userId == userId },
            sort: [SortDescriptor(\.date, order: .reverse)]
        )
    }

      var body: some View {
          if let user = session.currentUser {
              NavigationStack {
                  ScrollView {
                      VStack {
                          QuickActionsSection()
                          Text("Olá, \(user.name)")
                          Button("Encerrar Sessão") {
                              session.currentUser = nil
                          }
                          .buttonStyle(.glassProminent)
                          
                          Text ("Paciente: \(patients.count)")
                          Text ("Cirurgias? \(surgeries.count)")
                          
                          NavigationLink("Navegar para Lista de Pacientes") {
                              PatientListView(session: session)
                          }
                          .buttonStyle(.borderedProminent)
                          NavigationLink("Navegar para Lista de Usuários") {
                              UserListView()
                          }
                          .buttonStyle(.borderedProminent)
                      }
                      .padding()
                      .navigationTitle("Olá, \(displayName(name: user.name))")
                      .navigationSubtitle(Date.now.formatted(date: .long, time: .shortened))
                      .navigationBarTitleDisplayMode(.large)
                      
                  }
                  .background(Color(.tertiarySystemGroupedBackground))
              }
              
          } else {
              ContentUnavailableView("Sem usuário", systemImage: "person.crop.circle.badge.exclam")
          }
      }
    
    /// Returns a display-friendly version of a full name.
    /// If the name has more than 3 words, returns "first last"; otherwise, returns the original name.
    func displayName(name: String) -> String {
        // Split by whitespace and filter out empty components
        let parts = name.split(whereSeparator: { $0.isWhitespace }).map(String.init).filter { !$0.isEmpty }
        guard let first = parts.first, let last = parts.last else { return name }
        if parts.count > 2 {
            return "\(first) \(last)"
        } else {
            return name
        }
    }
}

// MARK: - Quick Actions Section
struct QuickActionsSection: View {
    var onNewAnesthesia: () -> Void = {}
    var onMyPatients: () -> Void = {}
    var onFinancial: () -> Void = {}
    var body: some View {
        VStack(spacing: 12) {
            QuickActionCard(
                title: "Nova Ficha Anestésica",
                icon: "plus.circle.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.2, green: 0.45, blue: 0.8), Color(red: 0.14, green: 0.36, blue: 0.65)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: onNewAnesthesia
            )
            
            QuickActionCard(
                title: "Nova Avaliação Pré-Anestésica",
                icon: "plus.circle.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.4, green: 0.3, blue: 0.66), Color(red: 0.5, green: 0.4, blue: 0.55)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
            QuickActionCard(
                title: "Nova Ficha SRPA",
                icon: "plus.circle.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.4, green: 0.5, blue: 0.66), Color(red: 0.45, green: 0.4, blue: 0.59)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
            QuickActionCard(
                title: "Financeiro",
                icon: "dollarsign",
                gradient: LinearGradient(
                    colors: [Color(red: 0.19, green: 0.55, blue: 0.65), Color(red: 0.17, green: 0.45, blue: 0.65)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: onFinancial
            )
            
            QuickActionCard(
                title: "Meus Pacientes",
                icon: "person.2.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.31, green: 0.18, blue: 0.66), Color(red: 0.25, green: 0.14, blue: 0.55)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: onMyPatients
            )
        }
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    var onTap: () -> Void = {}
    @State private var isPressed = false
    
    var body: some View {
        Button(action: { onTap() }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(gradient)
                    .brightness(isPressed ? -0.1 : 0)
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

//#Preview {
//    DashboardView()
//        .environment(SessionManager())
//        .modelContainer(for: [User.self, Patient.self])
//}
