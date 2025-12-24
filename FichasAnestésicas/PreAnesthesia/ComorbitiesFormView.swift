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
            Toggle(isOn: $isEnabled) {
                Label(title, systemImage: icon)
                    .fontWeight(Font.Weight.medium)
            }
            
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

struct NewComorbidityDetailSection<Detail: ComorbidityDetailProtocol, EnumType: ComorbiditiesType>: View {
    let title: String
    let icon: String
    @Binding var isEnabled: Bool
    @Binding var details: [Detail]
    let createDetail: (EnumType) -> Detail
    let createCustomDetail: (String) -> Detail
    
    @State private var newCustomName = ""
    
    var sortedEnumItems: [EnumType] {
        EnumType.allCases.sorted { $0.displayName < $1.displayName }
    }
    
    private func existingDetail(for enumCase: EnumType) -> Detail? {
        details.first { $0.displayName() == enumCase.displayName }
    }
    
    private var customDetails: [Detail] {
        details.filter { detail in
            !EnumType.allCases.contains { $0.displayName == detail.displayName() }
        }
    }
    
    var body: some View {
        Section {
            Toggle(isOn: $isEnabled) {
                Label(title, systemImage: icon)
                    .fontWeight(.medium)
            }
            
            if isEnabled {
                ForEach(sortedEnumItems) { enumCase in
                    detailRow(for: enumCase)
                }
                
                ForEach(customDetails) { detail in
                    customDetailRow(detail)
                }
                
                HStack {
                    TextField("Adicionar Comorbidades", text: $newCustomName)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .onSubmit { addCustom() }
                    if !newCustomName.isEmpty {
                        Button { addCustom() } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        } header: {
            Text(title)
        }
    }
    
    @ViewBuilder
    private func detailRow(for enumCase: EnumType) -> some View {
        let existing = existingDetail(for: enumCase)
        let isSelected = existing != nil
        
        Button {
            toggleEnum(enumCase)
        } label: {
            HStack {
                Text(enumCase.displayName)
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle.dashed")
                    .foregroundStyle(isSelected ? .blue : .gray)
            }
        }
        .foregroundStyle(.primary)
        
        if let detail = existing {
            TextField("Detalhes", text: Binding(
                get: { detail.notes ?? "" },
                set: { detail.notes = $0.isEmpty ? nil : $0 }
            ))
            .font(.caption)
            .textFieldStyle(.roundedBorder)
        }
    }

    @ViewBuilder
    private func customDetailRow(_ detail: Detail) -> some View {
        Button {
            removeDetail(detail)
        } label: {
            HStack {
                Text(detail.displayName())
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
            }
        }
        .foregroundStyle(.primary)
        
        TextField("Detalhes", text: Binding(
            get: { detail.notes ?? "" },
            set: { detail.notes = $0.isEmpty ? nil : $0 }
        ))
        .font(.caption)
        .textFieldStyle(.roundedBorder)
    }
    
    private func toggleEnum(_ enumCase: EnumType) {
        if let existing = existingDetail(for: enumCase) {
            removeDetail(existing)
        } else {
            let new = createDetail(enumCase)
            details.append(new)
        }
    }
    
    private func removeDetail(_ detail: Detail) {
        details.removeAll { $0.id == detail.id }
    }
    
    private func addCustom() {
        let trimmed = newCustomName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !customDetails.contains(where: { $0.displayName() == trimmed }) else { return }
        
        let new = createCustomDetail(trimmed)
        details.append(new)
        newCustomName = ""
    }
}

// MARK: - View Principal Refatorada
struct ComorbitiesFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    private func binding<T>(get: @escaping () -> [T]?, set: @escaping ([T]?) -> Void) -> Binding<[T]> {
        Binding(
            get: { get() ?? [] },
            set: { newArray in set(newArray.isEmpty ? nil : newArray) }
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                ForEach(viewModel.comorbities.validationMessages, id: \.self) { message in
                    Text(message).foregroundStyle(.red)
                }
                Button("Preset Paciente Saudável") {
                    viewModel.comorbities.applyHealthyPatient()
                }
                
                Section("Paciente Saudável") {
                    Toggle("Sem Comorbidades", systemImage: "heart.fill",
                           isOn: $viewModel.comorbities.healthyPatient)
                    .fontWeight(Font.Weight.medium)
                }
                
                // Gestação (condicional)
                if viewModel.patientSex == .female && viewModel.patientAge > 12 {
                    ComorbiditiesSection(
                        title: "Gestante",
                        icon: "figure.seated.side.right.child.lap",
                        isEnabled: $viewModel.comorbities.isPregnant,
                        selection: binding(get: { viewModel.comorbities.isPregnantComorbitiesDetails }, set: { viewModel.comorbities.isPregnantComorbitiesDetails = $0 }),
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
                        selection: binding(get: { viewModel.comorbities.isInfantComorbitiesDetails }, set: { viewModel.comorbities.isInfantComorbitiesDetails = $0 }),
                        customDetails: $viewModel.comorbities.isInfantCustomDetails,
                        detailsText: $viewModel.comorbities.isInfantDetailsText
                    )
                }
                
                // Cardíacas
                ComorbiditiesSection(
                    title: "Cardíacas",
                    icon: "heart.circle.fill",
                    isEnabled: $viewModel.comorbities.cardiacComorbities,
                    selection: binding(get: { viewModel.comorbities.cardiacComorbitiesDetails }, set: { viewModel.comorbities.cardiacComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.cardiacComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.cardiacComorbitiesDetailsText
                )
                
                // Respiratórias
                ComorbiditiesSection(
                    title: "Respiratórias",
                    icon: "lungs.fill",
                    isEnabled: $viewModel.comorbities.respiratoryComorbities,
                    selection: binding(get: { viewModel.comorbities.respiratoryComorbitiesDetails }, set: { viewModel.comorbities.respiratoryComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.respiratoryComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.respiratoryComorbitiesDetailsText
                )
                
                // Endócrinas
                ComorbiditiesSection(
                    title: "Endócrinas e Metabólicas",
                    icon: "syringe.fill",
                    isEnabled: $viewModel.comorbities.endocrineComorbities,
                    selection: binding(get: { viewModel.comorbities.endocrineComorbitiesDetails }, set: { viewModel.comorbities.endocrineComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.endocrineComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.endocrineComorbitiesDetailsText
                )
                
                //Gastrointestinal
                ComorbiditiesSection(
                    title: "Gastrointestinais",
                    icon: "fork.knife.circle.fill",
                    isEnabled: $viewModel.comorbities.gastrointestinalComorbities,
                    selection: binding(get: { viewModel.comorbities.gastrointestinalComorbitiesDetails }, set: { viewModel.comorbities.gastrointestinalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.gastrointestinalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.gastrointestinalComorbitiesDetailsText
                )
                
                ComorbiditiesSection(
                    title: "Hematológicas",
                    icon: "ivfluid.bag",
                    isEnabled: $viewModel.comorbities.hematologicalComorbities,
                    selection: binding(get: { viewModel.comorbities.hematologicalComorbitiesDetails }, set: { viewModel.comorbities.hematologicalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.hematologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.hematologicalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Imunológicas",
                    icon: "ivfluid.bag.fill",
                    isEnabled: $viewModel.comorbities.imunologicalComorbities,
                    selection: binding(get: { viewModel.comorbities.imunologicalComorbitiesDetails }, set: { viewModel.comorbities.imunologicalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.imunologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.imunologicalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Musculoesqueléticas",
                    icon: "figure.run.circle.fill",
                    isEnabled: $viewModel.comorbities.musculoskeletalComorbities,
                    selection: binding(get: { viewModel.comorbities.musculoskeletalComorbitiesDetails }, set: { viewModel.comorbities.musculoskeletalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.musculoskeletalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.musculoskeletalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Genitourológicas",
                    icon: "toilet.fill",
                    isEnabled: $viewModel.comorbities.genitourologicalComorbities,
                    selection: binding(get: { viewModel.comorbities.genitourologicalComorbitiesDetails }, set: { viewModel.comorbities.genitourologicalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.genitourologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.genitourologicalComorbitiesDetailsText
                )
                if viewModel.patientSex == .female {
                    ComorbiditiesSection(
                        title: "Ginecológicas",
                        icon: "figure.stand.dress",
                        isEnabled: $viewModel.comorbities.gynecologicalComorbities,
                        selection: binding(get: { viewModel.comorbities.gynecologicalComorbitiesDetails }, set: { viewModel.comorbities.gynecologicalComorbitiesDetails = $0 }),
                        customDetails: $viewModel.comorbities.gynecologicalComorbitiesCustomDetails,
                        detailsText: $viewModel.comorbities.gynecologicalComorbitiesDetailsText
                    )
                }
                if viewModel.patientSex == .male {
                    ComorbiditiesSection(
                        title: "Andrológicas",
                        icon: "figure.stand",
                        isEnabled: $viewModel.comorbities.androgenicalComorbities,
                        selection: binding(get: { viewModel.comorbities.androgenicalComorbitiesDetails }, set: { viewModel.comorbities.androgenicalComorbitiesDetails = $0 }),
                        customDetails: $viewModel.comorbities.androgenicalComorbitiesCustomDetails,
                        detailsText: $viewModel.comorbities.androgenicalComorbitiesDetailsText
                    )
                }
                ComorbiditiesSection(
                    title: "Infecciosas",
                    icon: "person.fill",
                    isEnabled: $viewModel.comorbities.infectiousComorbities,
                    selection: binding(get: { viewModel.comorbities.infectiousComorbitiesDetails }, set: { viewModel.comorbities.infectiousComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.infectiousComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.infectiousComorbitiesDetailsText
                )
                NewComorbidityDetailSection<OncologyComorbidityDetail, OncologicComorbidities>(
                    title: "Oncológicas",
                    icon: "person.fill",
                    isEnabled: $viewModel.comorbities.oncologicComorbities,
                    details: $viewModel.comorbities.oncologyDetails,
                    createDetail: { OncologyComorbidityDetail(type: $0) },
                    createCustomDetail: { OncologyComorbidityDetail(customName: $0) }
                )
                ComorbiditiesSection(
                    title: "Neurológicas",
                    icon: "brain.head.profile.fill",
                    isEnabled: $viewModel.comorbities.neurologicalComorbities,
                    selection: binding(get: { viewModel.comorbities.neurologicalComorbitiesDetails }, set: { viewModel.comorbities.neurologicalComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.neurologicalComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.neurologicalComorbitiesDetailsText
                )
                ComorbiditiesSection(
                    title: "Síndromes Genéticas",
                    icon: "apple.meditate.circle.fill",
                    isEnabled: $viewModel.comorbities.geneticSyndrome,
                    selection: binding(get: { viewModel.comorbities.geneticSyndromeComorbitiesDetails }, set: { viewModel.comorbities.geneticSyndromeComorbitiesDetails = $0 }),
                    customDetails: $viewModel.comorbities.geneticSyndromeComorbitiesCustomDetails,
                    detailsText: $viewModel.comorbities.geneticSyndromeComorbitiesDetailsText
                )
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
                    .disabled(!viewModel.comorbities.canSave)
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
extension InfectiousComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension OncologicComorbidities: ComorbiditiesType {
    public var id: Self { self }
}
extension MusculoskeletalComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension GenitourinaryComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension GynecologicComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension AndrologicComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension NeurologicalComorbities: ComorbiditiesType {
    public var id: Self { self }
}
extension GeneticSyndrome: ComorbiditiesType {
    public var id: Self { self }
}
