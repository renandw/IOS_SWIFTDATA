//
//  NewAnesthesiaPageView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI
import SwiftData

struct NewAnesthesiaPageView: View {
    
    enum Step {
        case patient
        case selectOrCreateSurgery
        case surgery
        case anesthesia
    }
    
    @Environment(\.dismiss) private var dismiss
    
    // Recebidos no init
    private let session: SessionManager
    private let modelContext: ModelContext
    
    // Apenas o patientViewModel é criado no init
    @StateObject private var patientViewModel: PatientFormViewModel
    
    // Surgery e Anesthesia ViewModels criados dinamicamente
    @State private var surgeryViewModel: SurgeryFormViewModel?
    @State private var anesthesiaViewModel: AnesthesiaFormViewModel?
    
    @State private var scheduledSurgeries: [Surgery] = []
    @State private var selectedSurgery: Surgery?  // Para quando usuário selecionar uma existente
    
    @State private var currentStep: Step = .patient
    @State private var isSaving: Bool = false
    @State private var selectedPatient: Patient?
    
    @State private var feedbackTrigger = false
    
    let onFinished: (Anesthesia) -> Void
    
    init(
        session: SessionManager,
        modelContext: ModelContext,
        onFinished: @escaping (Anesthesia) -> Void
    ) {
        self.session = session
        self.modelContext = modelContext
        self.onFinished = onFinished
        
        guard let currentUser = session.currentUser else {
            fatalError("User required for NewAnesthesiaPageView")
        }
        
        let patientRepo = SwiftDataPatientRepository(context: modelContext, currentUser: currentUser)
        _patientViewModel = StateObject(wrappedValue: PatientFormViewModel(
            repository: patientRepo,
            currentUser: currentUser
        ))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                Group {
                    switch currentStep {
                    case .patient:
                        PatientFormView(
                            viewModel: patientViewModel,
                            selectedPatient: $selectedPatient,
                            mode: .wizard
                        )
                        .onChange(of: selectedPatient) { _, patient in
                            if patient != nil {
                                // Patient foi selecionado da sheet de duplicatas
                                checkScheduledSurgeriesAndAdvance(with: patient!)
                            }
                        }
                    case .selectOrCreateSurgery:
                            ScheduledSurgerySelectionView(
                                surgeries: scheduledSurgeries,
                                onSelectSurgery: { surgery in
                                    selectedSurgery = surgery
                                    advanceToAnesthesia(with: surgery)
                                },
                                onCreateNew: {
                                    guard let patient = selectedPatient else { return }
                                    createSurgeryViewModelAndAdvance(with: patient)
                                }
                            )
                    case .surgery:
                        if let surgeryViewModel {
                            SurgeryFormView(
                                viewModel: surgeryViewModel,
                                mode: .wizard
                            )
                        }
                    case .anesthesia:
                        if let anesthesiaViewModel {
                            @Bindable var vm = anesthesiaViewModel
                            AnesthesiaFormView(
                                viewModel: vm,
                                mode: .wizard
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .navigationTitle(titleForCurrentStep)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", systemImage: "xmark") {
                            dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(primaryButtonTitle, systemImage: primaryButtonIcon) {
                        handleNext()
                        feedbackTrigger.toggle()
                    }
                    .disabled(!canGoForward || isSaving)
                    .sensoryFeedback(.selection, trigger: feedbackTrigger)
                }
            }
        }
    }
    
    // MARK: - Títulos
    
    private var titleForCurrentStep: String {
        switch currentStep {
        case .patient: return "Informar Paciente"
        case .selectOrCreateSurgery: return "Selecionar Cirurgia"
        case .surgery: return "Nova Cirurgia"
        case .anesthesia: return "Nova Anestesia"
        }
    }
    
    private var primaryButtonTitle: String {
        currentStep == .anesthesia ? "Concluir" : "Próximo"
    }
    private var primaryButtonIcon: String {
        currentStep == .anesthesia ? "checkmark" : "chevron.forward"
    }
    
    
    
    // MARK: - Validação
    
    private var canGoForward: Bool {
        switch currentStep {
        case .patient:
            return patientViewModel.isValid
        case .selectOrCreateSurgery:
                return false
        case .surgery:
            return surgeryViewModel?.isValid ?? false
        case .anesthesia:
            return anesthesiaViewModel?.isFormValid ?? false
        }
    }
    
    // MARK: - Navegação
    
    private func handleBack() {
        switch currentStep {
        case .patient:
            break
        case .selectOrCreateSurgery:  // 👈 NOVO
            currentStep = .patient
        case .surgery:
            // 👇 AJUSTE: pode voltar para seleção OU paciente
            if !scheduledSurgeries.isEmpty {
                currentStep = .selectOrCreateSurgery
            } else {
                currentStep = .patient
            }
        case .anesthesia:
            currentStep = .surgery
        }
    }
    
    private func handleNext() {
        switch currentStep {
        case .patient:
            savePatientAndAdvance()
        case .selectOrCreateSurgery:
            break  // 👈 Navegação pelos botões internos
        case .surgery:
            saveSurgeryAndAdvance()
        case .anesthesia:
            saveAnesthesiaAndFinish()
        }
    }
    
    // MARK: - Salvamento
    
    private func savePatientAndAdvance() {
        
        if let patient = selectedPatient {
            createSurgeryViewModelAndAdvance(with: patient)
            return
        }
        
        isSaving = true
        defer { isSaving = false }
        
        do {
            try patientViewModel.save()
        } catch {
            return
        }
        
        guard patientViewModel.saveSuccess,
              let patient = patientViewModel.resolvedPatient else {
            return
        }
        
        // garante que o wizard sempre tenha o paciente resolvido (novo ou existente)
        selectedPatient = patient
        
        checkScheduledSurgeriesAndAdvance(with: patient)
    }
    
    private func checkScheduledSurgeriesAndAdvance(with patient: Patient) {
        guard let currentUser = session.currentUser else { return }
        
        let surgeryRepo = SwiftDataSurgeryRepository(context: modelContext, currentUser: currentUser)
        
        do {
            scheduledSurgeries = try surgeryRepo.getScheduledForPatient(patient)
            print("🔍 DEBUG: Encontradas \(scheduledSurgeries.count) cirurgias agendadas")
            scheduledSurgeries.forEach { print("  - \($0.surgeryId): \($0.statusRaw)") }
        } catch {
            print("❌ Erro ao buscar: \(error)")
            scheduledSurgeries = []
        }
        
        if scheduledSurgeries.isEmpty {
            print("➡️ Nenhuma agendada, vai criar nova")
            createSurgeryViewModelAndAdvance(with: patient)
        } else {
            print("📋 Mostrando lista de \(scheduledSurgeries.count) cirurgias")
            currentStep = .selectOrCreateSurgery
        }
    }
    
    private func advanceToAnesthesia(with surgery: Surgery) {
        guard let currentUser = session.currentUser else { return }
        
        // Cria o AnesthesiaViewModel direto com a surgery selecionada
        anesthesiaViewModel = AnesthesiaFormViewModel(
            surgery: surgery,
            user: currentUser,
            context: modelContext
        )
        
        currentStep = .anesthesia
    }
    
    private func createSurgeryViewModelAndAdvance(with patient: Patient) {
        guard let currentUser = session.currentUser else { return }
        
        let surgeryRepo = SwiftDataSurgeryRepository(context: modelContext, currentUser: currentUser)
        let financialRepo = SwiftDataFinancialRepository(context: modelContext, currentUser: currentUser)
        let procedureRepo = SwiftDataCbhpmProcedureRepository(context: modelContext)
        
        surgeryViewModel = SurgeryFormViewModel(
            patient: patient,
            repository: surgeryRepo,
            financialRepository: financialRepo,
            procedureRepository: procedureRepo,
            modelContext: modelContext
        )
        
        currentStep = .surgery
    }
    
    private func saveSurgeryAndAdvance() {
        guard let currentUser = session.currentUser,
              let surgeryViewModel else {
            return
        }
        
        isSaving = true
        defer { isSaving = false }
        
        do {
            try surgeryViewModel.save(currentUser: currentUser)
        } catch {
            return
        }
        
        guard surgeryViewModel.saveSuccess,
              let surgery = surgeryViewModel.resolvedSurgery else {
            return
        }
        
        // Criar AnesthesiaViewModel a partir da cirurgia resolvida pelo view model
        anesthesiaViewModel = AnesthesiaFormViewModel(
            surgery: surgery,
            user: currentUser,
            context: modelContext
        )
        
        currentStep = .anesthesia
    }
    
    private func saveAnesthesiaAndFinish() {
        guard let anesthesiaViewModel else { return }
        
        isSaving = true
        defer { isSaving = false }
        
        let success = anesthesiaViewModel.save()
        
        guard success,
              let anesthesia = anesthesiaViewModel.resolvedAnesthesia else {
            return
        }
        
        onFinished(anesthesia)
        dismiss()
    }
}
