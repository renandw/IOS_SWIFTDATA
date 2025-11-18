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
    @State private var showingVitalSignsFormCreate = false
    @State private var selectedEntry: VitalSignEntry? = nil
    
    var body: some View {
        
        Group {
            if anesthesia.vitalSigns.isEmpty {
                ContentUnavailableView(
                    "Não há registro de sinais vitais para esta anestesia.",
                    systemImage: "waveform.path.ecg.rectangle.fill",
                    description: Text("Visualize aqui o registro durante a anestesia.")
                )
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            showingVitalSignsFormCreate = true
                                                selectedEntry = nil
                        }) {
                            Label("Adicionar Sinais Vitais", systemImage: "plus")
                        }
                        .buttonStyle(.glass)
                        .tint(.blue)
                        .padding()
                    }
                )
            } else {
                ScrollView {
                    Text("Sinais vitais registrados \(anesthesia.vitalSigns.count).")
                    VStack(alignment: .leading) {
                        ForEach(anesthesia.vitalSigns) { vitalSign in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(vitalSign.timestamp.formatted(date: .omitted, time: .shortened))
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    if (vitalSign.rhythm) != nil{
                                        HStack {
                                            Text("Ritmo:")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("\(displayOrNoStringRecord(vitalSign.rhythm))")
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    if vitalSign.fc != nil {
                                        HStack {
                                            Text("FC:")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("\(displayOrNoRecord(vitalSign.fc, decimals: 0, suffix: "bpm"))")
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                
                                HStack {
                                    if vitalSign.spo2 != nil {
                                        HStack {
                                            Text("SpO₂:")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("\(displayOrNoRecord(vitalSign.spo2, decimals: 1, suffix: "%"))")
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if vitalSign.paS != nil || vitalSign.paD != nil {
                                        HStack(alignment: .bottom) {
                                            Text("PA:")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("\(displayOrNoRecord(vitalSign.paS, decimals: 0, suffix: "")) / \(displayOrNoRecord(vitalSign.paD, decimals: 0, suffix: "mmHg"))")
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                            if vitalSign.pam != nil{
                                                Text("(\(displayOrNoRecord(vitalSign.pam, decimals: 0, suffix: "")))")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                        }
                                    }
                                }
                                
                                HStack {
                                    
                                    
                                    if (vitalSign.etco2) != nil{
                                        VStack(alignment: .leading) {
                                            Text("ETCO₂:")
                                            Text("\(displayOrNoRecord(vitalSign.etco2, decimals: 0, suffix: "mmHg"))")
                                        }
                                    }
                                    if (vitalSign.volumeCorrente) != nil{
                                        VStack(alignment: .leading) {
                                            Text("VC:")
                                            Text("\(displayOrNoRecord(vitalSign.volumeCorrente, decimals: 0, suffix: "mL"))")
                                        }
                                    }
                                    
                                }
                                HStack {
                                    if vitalSign.bis != nil {
                                        VStack(alignment: .leading) {
                                            Text("BIS:")
                                            Text("\(displayOrNoRecord(vitalSign.bis, decimals: 1, suffix: "bis"))")
                                        }
                                    }
                                    if vitalSign.pvc != nil {
                                        VStack(alignment: .leading) {
                                            Text("PVC:")
                                            Text("\(displayOrNoRecord(vitalSign.pvc, decimals: 1, suffix: "mmHg"))")
                                        }
                                    }
                                    
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .glassEffect(.regular.interactive())
                            .onTapGesture {
                                selectedEntry = vitalSign
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                
            }
        }
            .sheet(item: $selectedEntry) { entry in
                if let user = session.currentUser {
                    let repo: VitalSignsEntryRepository = SwiftDataVitalSignsEntryRepository(context: modelContext)
                    let vm = VitalSignsFormViewModel(
                        repo: repo,
                        anesthesia: anesthesia,
                        user: user,
                        context: modelContext,
                        existingEntry: entry
                    )
                    NavigationStack { VitalSignsFormView(viewModel: vm) }
                } else {
                    NavigationStack { Text("Dependências indisponíveis para abrir o formulário.") }
                }
            }
            .sheet(isPresented: $showingVitalSignsFormCreate) {
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

            if !anesthesia.vitalSigns.isEmpty {
                Button(action: {
                    //toogle graphview in vitalsignsview
                
                }) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Apagar Registros")
                .buttonStyle(.glass)
                .tint(.blue)
            }
            
            Spacer()
            
            if !anesthesia.vitalSigns.isEmpty {
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
                selectedEntry = nil
                showingVitalSignsFormCreate = true
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

