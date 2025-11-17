//
//  VitalSigns.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 16/11/25.
//

import SwiftUI

struct VitalSignsView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    @State private var showingMedicationsForm = false
    
    var body: some View {
        ScrollView {
            
            Button("Adicionar Sinais Vitais", systemImage: "plus") {
                showingMedicationsForm = true
            }
            
            if anesthesia.vitalSigns.isEmpty {
                Text("Nenhum registro de sinais vitais.")
            } else {
                Text("Sinais vitais registrados \(anesthesia.vitalSigns.count).")
                VStack(alignment: .leading) {
                    ForEach(anesthesia.vitalSigns) { vitalSign in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("FC:")
                                Text("\(displayOrNoRecord(vitalSign.fc, decimals: 0, suffix: "bpm"))")
                            }
                            VStack(alignment: .leading) {
                                Text("PA:")
                                Text("\(displayOrNoRecord(vitalSign.paS, decimals: 0, suffix: "")) / \(displayOrNoRecord(vitalSign.paD, decimals: 0, suffix: "mmHg"))")
                            }
                            VStack(alignment: .leading) {
                                Text("SpO₂:")
                                Text("\(displayOrNoRecord(vitalSign.spo2, decimals: 1, suffix: "%"))")
                            }
                            VStack(alignment: .leading) {
                                Text("Ritmo:")
                                Text("\(displayOrNoStringRecord(vitalSign.rhythm))")
                            }
                        }
                        .padding()
                        .glassEffect(.regular.interactive())
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .sheet(isPresented: $showingMedicationsForm) {
            if let user = session.currentUser {
                let repo: VitalSignsEntryRepository = SwiftDataVitalSignsEntryRepository(context: modelContext)
                let vm = VitalSignsFormViewModel(
                    repo: repo,
                    anesthesia: anesthesia,
                    user: user,
                    context: modelContext
                )
                NavigationStack { VitalSignsFormView(viewModel: vm) }
            } else {
                NavigationStack { Text("Dependências indisponíveis para abrir o formulário.") }
            }
        }
        .preference(
            key: CustomTopBarButtonPreferenceKey.self,
            value: CustomTopBarButtonPreference(
                id: "VitalSignsView.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "VitalSignsView.topbar.buttons.v\(anesthesia.vitalSigns.count)"
            )
        )
    }
    
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            
            if !anesthesia.vitalSigns.isEmpty {
                Text("\(anesthesia.vitalSigns.count)")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .glassEffect(.regular.interactive())
                    .clipShape(Capsule())
            }

            
            Spacer()
            
            if !anesthesia.medications.isEmpty {
                Button(action: {
                    if let currentUser = session.currentUser {
                        let repo: VitalSignsEntryRepository = SwiftDataVitalSignsEntryRepository(context: modelContext)
                        try? repo.deleteAll(for: anesthesia, by: currentUser)
                    } else {
                        anesthesia.vitalSigns.removeAll()
                    }
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Apagar Registros")
                .buttonStyle(.glass)
                .tint(.red)
            }
            
            
            Button(action: {
                showingMedicationsForm = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Adicionar Registro")
            .buttonStyle(.glass)
            .tint(.blue)
        }
    }
    
    
    func displayOrNoRecord(_ value: Double?, decimals: Int = 0, suffix: String? = nil, noRecord: String = "não há registro") -> String {
        guard let value else { return noRecord }
        let formatted = String(format: "%.\(decimals)f", value)
        if let suffix, !suffix.isEmpty {
            return "\(formatted) \(suffix)"
        } else {
            return formatted
        }
    }
    
    func displayOrNoStringRecord(_ value: String?, noRecord: String = "não há registro") -> String {
        guard let value else { return noRecord }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? noRecord : trimmed
    }
}
