import SwiftUI

struct TechniquesSectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    let anesthesiaTechniques: [AnesthesiaTechniqueItems] = [
                        AnesthesiaTechniqueItems(
                            title: "Anestesia Geral",
                            icon: "waveform.path.ecg.rectangle",
                            binding: $viewModel.techniques.generalAnesthesia,
                            onChange: { newValue in
                                if newValue {
                                    viewModel.techniques.applyGeneralAnesthesiaSuggestion(
                                        patientAge: viewModel.patientAge,
                                        patientWeight: viewModel.patientWeight,
                                        patientSex: viewModel.patientSex
                                    )
                                } else {
                                    viewModel.techniques.resetGeneralAnesthesia()
                                }
                            }
                        ),
                        AnesthesiaTechniqueItems(
                            title: "Sedação",
                            icon: "lungs",
                            binding: $viewModel.techniques.sedationAnesthesia,
                            onChange: nil
                        ),
                        AnesthesiaTechniqueItems(
                            title: "RaquiAnestesia",
                            icon: "blood.pressure.cuff",
                            binding: $viewModel.techniques.spinalAnesthesia,
                            onChange: nil
                        ),
                        AnesthesiaTechniqueItems(
                            title: "Peridural",
                            icon: "carbon.dioxide.cloud",
                            binding: $viewModel.techniques.periduralAnesthesia,
                            onChange: nil
                        ),
                        AnesthesiaTechniqueItems(
                            title: "Bloqueios Periféricos",
                            icon: "carbon.dioxide.cloud",
                            binding: $viewModel.techniques.peripheralAnesthesia,
                            onChange: nil
                        ),
                        AnesthesiaTechniqueItems(
                            title: "Local",
                            icon: "carbon.dioxide.cloud",
                            binding: $viewModel.techniques.localAnesthesia,
                            onChange: nil
                        )
                    ]

                    ForEach(Array(anesthesiaTechniques.enumerated()), id: \.offset) { _, item in
                        Toggle(
                            item.title,
                            systemImage: item.icon,
                            isOn: Binding(
                                get: { item.binding.wrappedValue },
                                set: { newValue in
                                    item.binding.wrappedValue = newValue
                                    item.onChange?(newValue)
                                }
                            )
                        )
                    }

                } header: {
                    HStack {
                        Text("Técnicas Anestésicas")
                        Spacer()
                        Button("Limpar seleção") {
                            viewModel.techniques.resetTechniquesSelection()
                        }
                    }
                }
                if viewModel.techniques.generalAnesthesia || viewModel.techniques.sedationAnesthesia || viewModel.techniques.spinalAnesthesia || viewModel.techniques.periduralAnesthesia || viewModel.techniques.peripheralAnesthesia || viewModel.techniques.localAnesthesia {
                    Section ("Técnicas Selecionadas") {
                        if viewModel.techniques.generalAnesthesia {
                            NavigationLink {
                                GeneralAnesthesiaSectionView(viewModel: viewModel)
                            } label: {
                                HStack {
                                    Text("Anestesia Geral")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        if viewModel.techniques.sedationAnesthesia {
                            NavigationLink {
                                SedationAnesthesiaSectionView(viewModel: viewModel)
                            } label: {
                                HStack {
                                    Text("Sedação Anestésica")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        if viewModel.techniques.spinalAnesthesia {
                            NavigationLink {
                                SpinalAnesthesiaSectionView(viewModel: viewModel)
                            } label: {
                                HStack {
                                    Text("Raquianestesia")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        if viewModel.techniques.periduralAnesthesia {
                            NavigationLink {
                                PeriduralAnesthesiaSectionView(viewModel: viewModel)
                            } label: {
                                HStack {
                                    Text("Peridural")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        if viewModel.techniques.peripheralAnesthesia {
                            NavigationLink {
                                PeripheralBlockAnesthesiaSectionView(viewModel: viewModel)
                            } label: {
                                HStack{
                                    Text("Bloqueio Periférico")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        if viewModel.techniques.localAnesthesia {
                            Text("Anestesia Local")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Técnicas Anestésicas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluir") { dismiss() }
                }
            }
        }
    }
    
    struct AnesthesiaTechniqueItems {
        let title: String
        let icon: String
        let binding: Binding<Bool>
        let onChange: ((Bool) -> Void)?
    }
}
