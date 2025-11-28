import SwiftUI

// MARK: - Protocolo Comum
protocol ComorbiditiesType: CaseIterable, Hashable, Identifiable where ID == Self {
    var displayName: String { get }
}

// MARK: - Componente Genérico Reutilizável
struct ComorbiditiesSection<T: ComorbiditiesType>: View {
    let title: String
    let icon: String
    @Binding var isEnabled: Bool
    @Binding var selection: [T]
    @Binding var customDetails: [String]
    @Binding var detailsText: String?
    @State private var newCustomItem = ""
    
    var extraContent: (() -> AnyView)? = nil
    
    var sortedItems: [T] {
        T.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }
    
    var body: some View {
        Section {
            Toggle(title, systemImage: icon, isOn: $isEnabled)
            
            if isEnabled {
                // Conteúdo extra (ex: idade gestacional)
                if let extra = extraContent {
                    extra()
                }
                
                // Items predefinidos
                ForEach(sortedItems) { item in
                    Button {
                        toggleSelection(item)
                    } label: {
                        HStack {
                            Text(item.displayName)
                            Spacer()
                            Image(systemName: selection.contains(item) ? "checkmark.circle.fill" : "circle.dashed")
                                .foregroundStyle(selection.contains(item) ? .blue : .gray)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                
                // Items customizados
                ForEach(customDetails, id: \.self) { name in
                    Button {
                        customDetails.removeAll { $0 == name }
                    } label: {
                        HStack {
                            Text(name)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                
                // Campo adicionar custom
                HStack {
                    TextField("Adicionar Comorbidades", text: $newCustomItem)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .onSubmit {
                            addCustomItem()
                        }
                    if !newCustomItem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {
                            addCustomItem()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                
                // Campo de detalhes
                if !customDetails.isEmpty || !selection.isEmpty {
                    HStack {
                        Text("Detalhes")
                        TextField(
                            "Informações adicionais",
                            text: Binding<String>(
                                get: { detailsText ?? "" },
                                set: { detailsText = $0.isEmpty ? nil : $0 }
                            )
                        )
                        .multilineTextAlignment(.trailing)
                    }
                }
            }
        } header: {
            Text(title)
        }
    }
    
    private func toggleSelection(_ item: T) {
        if let idx = selection.firstIndex(of: item) {
            selection.remove(at: idx)
        } else {
            selection.append(item)
        }
    }
    
    private func addCustomItem() {
        let trimmed = newCustomItem.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty && !customDetails.contains(trimmed) {
            customDetails.append(trimmed)
            newCustomItem = ""
        }
    }
}

// MARK: - View Principal Refatorada
struct ComorbitiesFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Pregnancy
    @Binding var selectionIsPregnantComorbities: [PregnantComorbities]
    
    // Infant
    @Binding var selectionIsInfantComorbities: [InfantComorbities]
    
    // Cardiac
    @Binding var selection: [CardiologicComorbities]
    
    // Respiratory
    @Binding var selectionRespiratory: [RespiratoryComorbities]
    
    // Endocrine
    @Binding var selectionEndocrine: [EndocrineComorbities]
    
    // Gastrointestinal
    @Binding var selectionGastrointestinal: [GastrointestinalComorbities]
    
    // Hematological
    @Binding var selectionHematological: [HematologicComorbities]
    
    // Hematological
    @Binding var selectionImunological: [ImmunologicComorbities]
    
    // musculoskeletal
    @Binding var selectionMusculoskeletal: [MusculoskeletalComorbities]
    
    
    
    
    @Bindable var viewModel: PreAnesthesiaViewModel

    var body: some View {
        NavigationStack {
            Form {
                // Gestação (condicional)
                if viewModel.patientSex == .female && viewModel.patientAge > 12 {
                    ComorbiditiesSection(
                        title: "Gestante",
                        icon: "figure.seated.side.right.child.lap",
                        isEnabled: $viewModel.comorbities.isPregnant,
                        selection: $selectionIsPregnantComorbities,
                        customDetails: $viewModel.comorbities.isPregnantCustomDetails,
                        detailsText: $viewModel.comorbities.isPregnantDetailsText,
                        extraContent: {
                            AnyView(pregnantAgeField)
                        }
                    )
                }
                
                // Menor de um ano (condicional)
                if viewModel.patientAge < 1 {
                    ComorbiditiesSection(
                        title: "Menor de um ano",
                        icon: "figure.child.circle.fill",
                        isEnabled: $viewModel.comorbities.isInfant,
                        selection: $selectionIsInfantComorbities,
                        customDetails: $viewModel.comorbities.isInfantCustomDetails,
                        detailsText: $viewModel.comorbities.isInfantDetailsText
                    )
                }
                
                // Cardíacas
                ComorbiditiesSection(
                    title: "Cardíacas",
                    icon: "heart.circle.fill",
                    isEnabled: $viewModel.comorbities.cardiacComorbities,
                    selection: $selection,
                    customDetails: $viewModel.comorbities.cardiacComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.cardiacComorbitiesDetailsText
                )
                
                // Respiratórias
                ComorbiditiesSection(
                    title: "Respiratórias",
                    icon: "lungs.fill",
                    isEnabled: $viewModel.comorbities.respiratoryComorbities,
                    selection: $selectionRespiratory,
                    customDetails: $viewModel.comorbities.respiratoryComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.respiratoryComorbitiesDetailsText
                )
                
                // Endócrinas
                ComorbiditiesSection(
                    title: "Endócrinas e Metabólicas",
                    icon: "syringe.fill",
                    isEnabled: $viewModel.comorbities.endocrineComorbities,
                    selection: $selectionEndocrine,
                    customDetails: $viewModel.comorbities.endocrineComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.endocrineComorbitiesDetailsText
                )
                
                //Gastrointestinal
                ComorbiditiesSection(
                    title: "Gastrointestinais",
                    icon: "fork.knife.circle.fill",
                    isEnabled: $viewModel.comorbities.gastrointestinalComorbities,
                    selection: $selectionGastrointestinal,
                    customDetails: $viewModel.comorbities.gastrointestinalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.gastrointestinalComorbitiesDetailsText
                )
                
                ComorbiditiesSection(
                    title: "Hematológicas",
                    icon: "ivfluid.bag",
                    isEnabled: $viewModel.comorbities.hematologicalComorbities,
                    selection: $selectionHematological,
                    customDetails: $viewModel.comorbities.hematologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.hematologicalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Imunológicas",
                    icon: "ivfluid.bag.fill",
                    isEnabled: $viewModel.comorbities.imunologicalComorbities,
                    selection: $selectionImunological,
                    customDetails: $viewModel.comorbities.imunologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.imunologicalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Musculoesqueléticas",
                    icon: "figure.run.circle.fill",
                    isEnabled: $viewModel.comorbities.musculoskeletalComorbities,
                    selection: $selectionMusculoskeletal,
                    customDetails: $viewModel.comorbities.musculoskeletalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.musculoskeletalComorbitiesDetailsText
                )
                
                Section("Genitourinárias") {
                    Toggle("Genitourológicas", systemImage: "toilet.fill",
                           isOn: $viewModel.comorbities.genitourologicalComorbities)
                }
                
                Section("Neurológicas") {
                    Toggle("Neurológicas", systemImage: "brain.head.profile.fill",
                           isOn: $viewModel.comorbities.neurologicalComorbities)
                }
                
                Section("Síndromes Genéticas") {
                    Toggle("Síndromes Genéticas", systemImage: "apple.meditate.circle.fill",
                           isOn: $viewModel.comorbities.geneticSyndrome)
                }
            }
            .navigationTitle("Comorbidades")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        } catch {
                            print("Erro ao salvar: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private var pregnantAgeField: some View {
        HStack {
            Text("Idade Gestacional")
            TextField(
                "IG: 32 semanas e 3 dias",
                text: Binding<String>(
                    get: { viewModel.comorbities.isPregnantAge ?? "" },
                    set: { viewModel.comorbities.isPregnantAge = $0.isEmpty ? nil : $0 }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
}

// MARK: - Extensões para conformidade com o protocolo
extension PregnantComorbities: ComorbiditiesType {
    public var id: Self { self }
}

extension InfantComorbities: ComorbiditiesType {
    public var id: Self { self }
}

extension CardiologicComorbities: ComorbiditiesType {
    public var id: Self { self }
}

extension RespiratoryComorbities: ComorbiditiesType {
    public var id: Self { self }
}

extension EndocrineComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension GastrointestinalComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension HematologicComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension ImmunologicComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension MusculoskeletalComorbities: ComorbiditiesType {
    public var id: Self { self }
}

