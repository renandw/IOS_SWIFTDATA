import SwiftUI

// MARK: - Protocolo Comum
protocol ComorbiditiesType: CaseIterable, Hashable, Identifiable where ID == Self {
    var displayName: String { get }
}

// MARK: - Componente Genérico Reutilizável
struct NewComorbidityDetailSection<Detail: ComorbidityDetailProtocol, EnumType: ComorbiditiesType>: View {
    let title: String
    let icon: String
    @Binding var isEnabled: Bool
    @Binding var details: [Detail]
    let createDetail: (EnumType) -> Detail
    let createCustomDetail: (String) -> Detail
    
    @State private var newCustomName = ""
    
    var extraContent: (() -> AnyView)? = nil
    
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
                if let extra = extraContent {
                    extra()
                }
                
                ForEach(sortedEnumItems) { enumCase in
                    detailRow(for: enumCase)
                }
                
                
                ForEach(customDetails) { detail in
                    customDetailRow(detail)
                }
                
                HStack {
                    TextField("Adicionar", text: $newCustomName)
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
                    NewComorbidityDetailSection<PregnancyDetail, PregnantComorbities>(
                        title: "Gestante",
                        icon: "figure.seated.side.right.child.lap",
                        isEnabled: $viewModel.comorbities.isPregnant,
                        details: $viewModel.comorbities.pregnancyDetails,
                        createDetail: { PregnancyDetail(type: $0) },
                        createCustomDetail: { PregnancyDetail(customName: $0) },
                        extraContent: {
                            AnyView(
                                HStack {
                                    Text("Idade Gestacional:")
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    TextField("IG: 32 semanas...", text: Binding(
                                        get: { viewModel.comorbities.isPregnantAge ?? "" },
                                        set: { viewModel.comorbities.isPregnantAge = $0.isEmpty ? nil : $0 }
                                    ))
                                }
                            )
                        }
                    )
                }
                
                // Menor de um ano (condicional)
                if viewModel.patientAge < 1 {
                    NewComorbidityDetailSection<InfantDetail, InfantComorbities>(
                        title: "Menor de um ano",
                        icon: "figure.child.circle.fill",
                        isEnabled: $viewModel.comorbities.isInfant,
                        details: $viewModel.comorbities.infantDetails,
                        createDetail: { InfantDetail(type: $0) },
                        createCustomDetail: { InfantDetail(customName: $0) }
                    )
                }
                
                // Cardíacas
                NewComorbidityDetailSection<CardiologyComorbidityDetail, CardiologicComorbities>(
                    title: "Cardíacas",
                    icon: "heart.circle.fill",
                    isEnabled: $viewModel.comorbities.cardiacComorbities,
                    details: $viewModel.comorbities.cardiologyDetails,
                    createDetail: { CardiologyComorbidityDetail(type: $0) },
                    createCustomDetail: { CardiologyComorbidityDetail(customName: $0) }
                )
                
                // Respiratórias
                NewComorbidityDetailSection<RespiratoryComorbidityDetail, RespiratoryComorbities>(
                    title: "Respiratórias",
                    icon: "lungs.fill",
                    isEnabled: $viewModel.comorbities.respiratoryComorbities,
                    details: $viewModel.comorbities.respiratoryDetails,
                    createDetail: { RespiratoryComorbidityDetail(type: $0) },
                    createCustomDetail: { RespiratoryComorbidityDetail(customName: $0) }
                )
                
                // Endócrinas
                NewComorbidityDetailSection<EndocrineComorbidityDetail, EndocrineComorbities>(
                    title: "Endócrinas e Metabólicas",
                    icon: "syringe.fill",
                    isEnabled: $viewModel.comorbities.endocrineComorbities,
                    details: $viewModel.comorbities.endocrineDetails,
                    createDetail: { EndocrineComorbidityDetail(type: $0) },
                    createCustomDetail: { EndocrineComorbidityDetail(customName: $0) }
                )
                
                //Gastrointestinal
                NewComorbidityDetailSection<GastroIntestinalComorbidityDetail, GastrointestinalComorbities>(
                    title: "Gastrointestinais",
                    icon: "fork.knife.circle.fill",
                    isEnabled: $viewModel.comorbities.gastrointestinalComorbities,
                    details: $viewModel.comorbities.gastroIntestinalDetails,
                    createDetail: { GastroIntestinalComorbidityDetail(type: $0) },
                    createCustomDetail: { GastroIntestinalComorbidityDetail(customName: $0) }
                )
                //Hematológicas
                NewComorbidityDetailSection<HematologyComorbidityDetail, HematologicComorbities>(
                    title: "Hematológicas",
                    icon: "ivfluid.bag",
                    isEnabled: $viewModel.comorbities.hematologicalComorbities,
                    details: $viewModel.comorbities.hematologyDetails,
                    createDetail: { HematologyComorbidityDetail(type: $0) },
                    createCustomDetail: { HematologyComorbidityDetail(customName: $0) }
                )
                //Imunologicas
                NewComorbidityDetailSection<ImunologyComorbidityDetail, ImmunologicComorbities>(
                    title: "Imunológicas",
                    icon: "ivfluid.bag.fill",
                    isEnabled: $viewModel.comorbities.imunologicalComorbities,
                    details: $viewModel.comorbities.imunologyDetails,
                    createDetail: { ImunologyComorbidityDetail(type: $0) },
                    createCustomDetail: { ImunologyComorbidityDetail(customName: $0) }
                )
                //Musculoesqueléticas
                NewComorbidityDetailSection<MusculoskeletalComorbidityDetail, MusculoskeletalComorbities>(
                    title: "Musculoesqueléticas",
                    icon: "figure.run.circle.fill",
                    isEnabled: $viewModel.comorbities.musculoskeletalComorbities,
                    details: $viewModel.comorbities.musculoskeletalDetails,
                    createDetail: { MusculoskeletalComorbidityDetail(type: $0) },
                    createCustomDetail: { MusculoskeletalComorbidityDetail(customName: $0) }
                )
                //GenitoUrinário
                NewComorbidityDetailSection<GenitoUrinaryComorbidityDetail, GenitourinaryComorbities>(
                    title: "Genitourológicas",
                    icon: "toilet.fill",
                    isEnabled: $viewModel.comorbities.genitourologicalComorbities,
                    details: $viewModel.comorbities.genitoUrinaryDetails,
                    createDetail: { GenitoUrinaryComorbidityDetail(type: $0) },
                    createCustomDetail: { GenitoUrinaryComorbidityDetail(customName: $0) }
                )
                //Ginecológica
                if viewModel.patientSex == .female {
                    NewComorbidityDetailSection<GynecologicComorbityDetail, GynecologicComorbities>(
                        title: "Ginecológicas",
                        icon: "figure.stand.dress",
                        isEnabled: $viewModel.comorbities.gynecologicalComorbities,
                        details: $viewModel.comorbities.gynecologyDetails,
                        createDetail: { GynecologicComorbityDetail(type: $0) },
                        createCustomDetail: { GynecologicComorbityDetail(customName: $0) }
                    )
                }
                //Andrológicas
                if viewModel.patientSex == .male {
                    NewComorbidityDetailSection<AndrogenicComorbityDetail, AndrologicComorbities>(
                        title: "Andrológicas",
                        icon: "figure.stand",
                        isEnabled: $viewModel.comorbities.androgenicalComorbities,
                        details: $viewModel.comorbities.androgenyDetails,
                        createDetail: { AndrogenicComorbityDetail(type: $0) },
                        createCustomDetail: { AndrogenicComorbityDetail(customName: $0) }
                    )
                }
                //Infecciosas
                NewComorbidityDetailSection<InfectiousComorbityDetail, InfectiousComorbities>(
                    title: "Infecciosas",
                    icon: "person.fill",
                    isEnabled: $viewModel.comorbities.infectiousComorbities,
                    details: $viewModel.comorbities.infectiousDetails,
                    createDetail: { InfectiousComorbityDetail(type: $0) },
                    createCustomDetail: { InfectiousComorbityDetail(customName: $0) }
                )
                //Oncológicas
                NewComorbidityDetailSection<OncologyComorbidityDetail, OncologicComorbidities>(
                    title: "Oncológicas",
                    icon: "person.fill",
                    isEnabled: $viewModel.comorbities.oncologicComorbities,
                    details: $viewModel.comorbities.oncologyDetails,
                    createDetail: { OncologyComorbidityDetail(type: $0) },
                    createCustomDetail: { OncologyComorbidityDetail(customName: $0) }
                )
                //Neurológicas
                NewComorbidityDetailSection<NeurologyComorbityDetail, NeurologicalComorbities>(
                    title: "Neurológicas",
                    icon: "brain.head.profile.fill",
                    isEnabled: $viewModel.comorbities.neurologicalComorbities,
                    details: $viewModel.comorbities.neurologyDetails,
                    createDetail: { NeurologyComorbityDetail(type: $0) },
                    createCustomDetail: { NeurologyComorbityDetail(customName: $0) }
                )
                //Genéticas
                NewComorbidityDetailSection<GeneticSyndromeDetail, GeneticSyndrome>(
                    title: "Síndromes Genéticas",
                    icon: "apple.meditate.circle.fill",
                    isEnabled: $viewModel.comorbities.geneticSyndrome,
                    details: $viewModel.comorbities.geneticSyndromeDetails,
                    createDetail: { GeneticSyndromeDetail(type: $0) },
                    createCustomDetail: { GeneticSyndromeDetail(customName: $0) }
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
