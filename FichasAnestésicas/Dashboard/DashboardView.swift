//
//  DashboardView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/10/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    let userId: String
    
    @Environment(SessionManager.self) var session
    @Query(sort:\Patient.name) var patients: [Patient]
    @Query(sort: \Surgery.date, order: .reverse) var surgeries: [Surgery]
    @Query(sort: \Anesthesia.start, order: .reverse) var anesthesias: [Anesthesia]
    @Query(sort: \PreAnesthesia.createdAt, order: .reverse) var preanesthesias: [PreAnesthesia]
    @Environment(\.modelContext) private var patientContext
    @State private var navigateToPatients = false
    @State private var navigateToFinancialDashboard = false
    @State private var navigateToTwoMonthPatients = false
    @State private var navigateToTwoMonthAnesthesia = false
    @State private var navigateToTwoMonthSurgery = false
    
    
    
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
        _anesthesias = Query(
            filter: #Predicate<Anesthesia> { $0.createdBy.userId == userId },
            sort: [SortDescriptor(\.start, order: .reverse)]
        )
        _preanesthesias = Query(
            filter: #Predicate<PreAnesthesia> { $0.createdBy.userId == userId },
            sort: [SortDescriptor(\.createdAt, order: .reverse)]
        )
    }

      var body: some View {
          if let user = session.currentUser {
              NavigationStack {
                  ScrollView {
                      VStack {
                          
                          QuickActionsSection(
                              onNewAnesthesia: {},
                              onMyPatients: { navigateToPatients = true },
                              onFinancial: {navigateToFinancialDashboard = true}
                          )

                          
                          StatisticsSection(
                            anesthesias: anesthesias,
                            preanesthesias: preanesthesias,
                            surgeries: surgeries,
                            onPatientsTapped: { navigateToTwoMonthPatients = true },
                            onAnesthesiasTapped : {navigateToTwoMonthAnesthesia = true},
                            onFinancialTapped: {navigateToFinancialDashboard = true},
                            onSurgeryTapped: {navigateToTwoMonthSurgery = true}
                          )
                          RecentAnesthesiasSection(anesthesias: anesthesias)

                      }
                      .navigationDestination(isPresented: $navigateToPatients) {
                          PatientListView()
                      }
                      .navigationDestination(isPresented: $navigateToTwoMonthAnesthesia) {
                          TwoMonthsAnesthesias(anesthesias: anesthesias)
                      }
                      .navigationDestination(isPresented: $navigateToTwoMonthPatients) {
                          TwoMonthsPatients(anesthesias: anesthesias)
                      }
                      .navigationDestination(isPresented: $navigateToFinancialDashboard) {
                          FinancialDashboardView(userId: user.userId, surgeries: surgeries)
                      }
                      .navigationDestination(isPresented: $navigateToTwoMonthSurgery) {
                          TwoMonthsSurgeries(surgeries: surgeries)
                      }
                      .padding()
                      .navigationTitle("Olá, \(displayName(name: user.name))")
                      .navigationSubtitle(Date.now.formatted(date: .long, time: .shortened))
                      .navigationBarTitleDisplayMode(.large)
                      .toolbar {
                          ToolbarItem(placement: .topBarLeading) {
                              NavigationLink{
                                  UserDetails(userId: user.userId)
                              } label: {
                                  Label(user.name, systemImage: "gear")
                              }
                          }
                          ToolbarItem(placement: .topBarLeading) {
                              Button("Encerrar Sessão", systemImage: "rectangle.portrait.and.arrow.right") {
                                  session.currentUser = nil
                              }
                          }
//                          ToolbarItem(placement: .topBarTrailing) {
//                              
//                              Button("Gerar Shared Extension") {
//                                  do {
//                                      try generatePreAnesthesiaExtension(context: patientContext)
//                                  } catch {
//                                      print("Failed to generate PreAnesthesia extension:", error)
//                                  }
//                              }
//                          }
                      }
                      
                      
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
    
    func swiftString(_ value: String?) -> String {
        value.map { "\"\($0)\"" } ?? "nil"
    }
    func swiftBoolNonOptional(_ value: Bool?) -> String {
        String(value ?? false)
    }
    func swiftStringArray(_ value: [String]?) -> String {
        guard let value else { return "nil" }
        return "[\(value.map { "\"\($0)\"" }.joined(separator: ", "))]"
    }
    func swiftRawEnum(_ value: String?) -> String {
        value.map { "\"\($0)\"" } ?? "nil"
    }
    func swiftRawEnumArray(_ value: [String]?) -> String {
        guard let value else { return "nil" }
        return "[\(value.map { "\"\($0)\"" }.joined(separator: ", "))]"
    }
    func swiftEnum(_ rawValue: String?) -> String {
        guard let rawValue else { return "nil" }
        return ".\(rawValue)"
    }
    func swiftMallampatiArray(_ rawValues: [String]?) -> String {
        let rawValues = rawValues ?? []
        return "[\(rawValues.map { "MallampatiClassification.\($0)" }.joined(separator: ", "))]"
    }
    
    func swiftRelation<T: AnyObject>(
        _ object: T?,
        in array: [T],
        name: String
    ) -> String {
        guard let object,
              let index = array.firstIndex(where: { $0 === object }) else {
            return "nil"
        }
        return "\(name)[\(index)]"
    }
    func swiftStringArrayNonOptional(_ value: [String]?) -> String {
        let value = value ?? []
        return "[\(value.map { "\"\($0)\"" }.joined(separator: ", "))]"
    }
    
    func generatePreAnesthesiaExtension(
        context: ModelContext
    ) throws {

        let descriptor = FetchDescriptor<PreAnesthesia>(
            sortBy: [SortDescriptor(\.createdAt)]
        )

        let entries = try context.fetch(descriptor)

        let surgeries = Array(Set(entries.map(\.surgery)))
        let sharedList = Array(Set(entries.compactMap(\.shared)))

        print("""
        extension PreAnesthesia {
            static func samples(
                surgeries: [Surgery],
                shared: [SharedPreAndAnesthesia],
                user: User
            ) -> [PreAnesthesia] {
                return [
        """)

        for entry in entries {

            let surgeryIndex = surgeries.firstIndex { $0 === entry.surgery }!
            let sharedValue = "surgeries[\(surgeryIndex)].shared"

            print("""
                    PreAnesthesia(
                        preanesthesiaId: "\(entry.preanesthesiaId)",
                        surgery: surgeries[\(surgeryIndex)],
                        shared: \(sharedValue),
                        createdBy: user,
                        updatedBy: nil,
                        createdAt: .now,
                        updatedAt: nil,

                        textField: \(swiftString(entry.textField)),

                        statusRaw: \(swiftRawEnum(entry.statusRaw)),

                        clearenceStatus: \(swiftEnum(entry.clearenceStatusRaw)),
                        definitiveRecommendationForRevaluationStatusRaw: \(swiftEnum(entry.definitiveRecommendationForRevaluationStatusRaw?.first)),
                        recommendationForRevaluationStatus: \(swiftEnum(entry.recommendationForRevaluationStatusRaw)),

                        futherRecommendationForRevaluation: \(swiftStringArrayNonOptional(entry.futherRecommendationForRevaluation)),

                        isPregnant: \(entry.isPregnant),
                        isInfant: \(entry.isInfant),
                        cardiacComorbities: \(entry.cardiacComorbities),
                        respiratoryComorbities: \(entry.respiratoryComorbities),
                        endocrineComorbities: \(entry.endocrineComorbities),
                        gastrointestinalComorbities: \(entry.gastrointestinalComorbities),
                        hematologicalComorbities: \(entry.hematologicalComorbities),
                        imunologicalComorbities: \(swiftBoolNonOptional(entry.imunologicalComorbities)),
                        musculoskeletalComorbities: \(entry.musculoskeletalComorbities),
                        genitourologicalComorbities: \(entry.genitourologicalComorbities),
                        gynecologicalComorbities: \(swiftBoolNonOptional(entry.gynecologicalComorbities)),
                        androgenicalComorbities: \(swiftBoolNonOptional(entry.androgenicalComorbities)),
                        neurologicalComorbities: \(entry.neurologicalComorbities),
                        infectiousComorbities: \(swiftBoolNonOptional(entry.infectiousComorbities)),
                        oncologicComorbities: \(swiftBoolNonOptional(entry.oncologicComorbities)),
                        geneticSyndrome: \(entry.geneticSyndrome),
                        healthyPatient: \(swiftBoolNonOptional(entry.healthyPatient)),
                        hasAllergies: \(swiftBoolNonOptional(entry.hasAllergies)),

                        surgeryHistory: \(swiftBoolNonOptional(entry.surgeryHistory)),
                        anesthesiaHistory: \(swiftBoolNonOptional(entry.anesthesiaHistory)),

                        pregnancyDetails: nil,
                        infantDetails: nil,
                        oncologyDetails: nil,
                        cardiologyDetails: nil,
                        respiratoryDetails: nil,
                        endocrineDetails: nil,
                        gastroIntestinalDetails: nil,
                        hematologyDetails: nil,
                        imunologyDetails: nil,
                        musculoskeletalDetails: nil,
                        genitoUrinaryDetails: nil,
                        gynecologyDetails: nil,
                        androgenyDetails: nil,
                        neurologyDetails: nil,
                        infectiousDetails: nil,
                        geneticSyndromeDetails: nil,
                        surgeryHistoricDetails: nil,
                        anesthesiaHistoricDetails: nil,

                        isPregnantAge: \(swiftString(entry.isPregnantAge)),
                        difficultAirwayDetails: nil,
                        socialHabitsAndEnvironmentDetailsText: \(swiftString(entry.socialHabitsAndEnvironmentDetailsText)),
                        socialHabitsAndEnvironmentCustomDetails: \(swiftStringArray(entry.socialHabitsAndEnvironmentCustomDetails)),
            
                        apfelScoreDetails: \(swiftEnum(entry.apfelScoreDetailsRaw?.first)),
                        mallampatiClassification: \(swiftMallampatiArray(entry.mallampatiClassificationRaw)),

                        dailyMedications: \(swiftRawEnumArray(entry.dailyMedicationsRaw)),
                        dailyMedicationsRawDetailsText: \(swiftString(entry.dailyMedicationsDetailsText)),
                        dailyMedicationsRawCustomDetails: \(swiftStringArray(entry.dailyMedicationsCustomDetails)),
                        allergiesMedicationsCustomDetails: \(swiftStringArray(entry.allergiesMedicationsCustomDetails)),
                        laboratoryExams: nil,
                        imagingExams: nil,
                        customImagingExams: \(swiftStringArray(entry.customImagingExams)),
                        physicalExaminationDetailsText: \(swiftString(entry.physicalExaminationDetailsText))
                    ),
            """)
        }

        print("""
                ]
            }
        }
        """)
    }
    
    // Função auxiliar para formatar datas
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}

// MARK: - Quick Actions Section
struct QuickActionsSection: View {
    var onNewAnesthesia: () -> Void = {}
    var onMyPatients: () -> Void = {}
    var onFinancial: () -> Void = {}
    
    @State private var showingAnesthesiaWizard = false
    @State private var showingPreAnesthesiaWizard = false
    @State private var createdAnesthesia: Anesthesia?
    @State private var createdPreAnesthesia: PreAnesthesia?
    @State private var navigateToDetails = false
    @State private var navigateToPreDetails = false
    @State private var showComingSoonAlert = false
    
    @Environment(SessionManager.self) private var session
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ações Rápidas")
                .font(.title3)
                .fontWeight(.semibold)
            QuickActionCard(
                title: "Nova Ficha Anestésica",
                icon: "plus.circle.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.2, green: 0.45, blue: 0.8), Color(red: 0.14, green: 0.36, blue: 0.65)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: { showingAnesthesiaWizard = true }
            )
            
            QuickActionCard(
                title: "Nova Avaliação Pré-Anestésica",
                icon: "plus.circle.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.4, green: 0.3, blue: 0.66), Color(red: 0.5, green: 0.4, blue: 0.55)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: { showingPreAnesthesiaWizard = true }
            )
            
            QuickActionCard(
                title: "Estatísticas Clínicas",
                icon: "chart.bar.xaxis",
                gradient: LinearGradient(
                    colors: [Color(red: 0.12, green: 0.78, blue: 0.76), Color(red: 0.77, green: 0.18, blue: 0.45)],
                    startPoint: .trailing,
                    endPoint: .leading
                ),
                onTap: { showComingSoonAlert = true }
            )
            
//            QuickActionCard(
//                title: "Nova Ficha SRPA",
//                icon: "plus.circle.fill",
//                gradient: LinearGradient(
//                    colors: [Color(red: 0.4, green: 0.5, blue: 0.66), Color(red: 0.45, green: 0.4, blue: 0.59)],
//                    startPoint: .leading,
//                    endPoint: .trailing
//                )
//            )
            
            QuickActionCard(
                title: "Financeiro",
                icon: "dollarsign",
                gradient: LinearGradient(
                    colors: [Color(red: 0.39, green: 0.75, blue: 0.65), Color(red: 0.17, green: 0.45, blue: 0.65)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: onFinancial
            )
            
            QuickActionCard(
                title: "Meus Pacientes",
                icon: "person.2.fill",
                gradient: LinearGradient(
                    colors: [Color(red: 0.41, green: 0.25, blue: 0.66), Color(red: 0.25, green: 0.14, blue: 0.55)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                onTap: onMyPatients
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Menu("Ações Rápidas", systemImage: "line.3.horizontal") {
                    Button("Nova Ficha Anestésica", systemImage: "plus") {
                        showingAnesthesiaWizard = true
                    }
                    Button("Nova Ficha Pré-Anestésica", systemImage: "plus") {
                        //showingAnesthesiaWizard = true
                    }
                }
            }
        }
        .sheet(isPresented: $showingAnesthesiaWizard) {
            NewAnesthesiaPageView(
                session: session,
                modelContext: modelContext,
                onFinished: { anesthesia in
                    createdAnesthesia = anesthesia
                    navigateToDetails = true
                }
            )
        }
        .sheet(isPresented: $showingPreAnesthesiaWizard) {
            NewPreAnesthesiaPageView(
                session: session,
                modelContext: modelContext,
                onFinished: { preanesthesia in
                    createdPreAnesthesia = preanesthesia
                    navigateToPreDetails = true
                }
            )
        }
        .navigationDestination(isPresented: $navigateToDetails) {
            if let anesthesia = createdAnesthesia {
                AnesthesiaDetailsView(anesthesia: anesthesia)
            }
        }
        .navigationDestination(isPresented: $navigateToPreDetails) {
            if let preanesthesia = createdPreAnesthesia {
                PreAnesthesiaForSurgeryView(preanesthesia: preanesthesia)
            }
        }
        .padding(.bottom, 16)
        .alert("Será implementado em breve", isPresented: $showComingSoonAlert) {
            Button("OK", role: .cancel) { }
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


#Preview("Anesthesia • completo") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)

    let session = SessionManager()
    session.currentUser = user

    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }

        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!

    return NavigationStack {
        DashboardView(userId: user.userId)
            .environment(session)
    }
    .modelContainer(container)
}

#Preview("Dashboard • completo") {
    let user = User.sampleUser

    let session = SessionManager()
    session.currentUser = user

    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        try! context.save()
    }

    return NavigationStack {
        DashboardView(userId: user.userId)
            .environment(session)
    }
    .modelContainer(container)
}

