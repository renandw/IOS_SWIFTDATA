
import SwiftUI

struct TechniquesSectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Técnicas Anestésicas") {
                    let anesthesiaTechniques: [AnesthesiaTechniqueItems] = [
                        AnesthesiaTechniqueItems(title: "Anestesia Geral", icon: "waveform.path.ecg.rectangle", binding: $viewModel.techniques.generalAnesthesia),
                        AnesthesiaTechniqueItems(title: "Sedação", icon: "lungs", binding: $viewModel.techniques.sedationAnesthesia),
                        AnesthesiaTechniqueItems(title: "RaquiAnestesia", icon: "blood.pressure.cuff", binding: $viewModel.techniques.spinalAnesthesia),
                        AnesthesiaTechniqueItems(title: "Peridural", icon: "carbon.dioxide.cloud", binding: $viewModel.techniques.periduralAnesthesia),
                        AnesthesiaTechniqueItems(title: "Bloqueios Periféricos", icon: "carbon.dioxide.cloud", binding: $viewModel.techniques.peripheralAnesthesia),
                        AnesthesiaTechniqueItems(title: "Local", icon: "carbon.dioxide.cloud", binding: $viewModel.techniques.localAnesthesia)
                    ]
                    
                    
                    ForEach(Array(anesthesiaTechniques.enumerated()), id: \.offset) { _, item in
                        Toggle(item.title, systemImage: item.icon, isOn: item.binding)
                    }
                    
                }
                if viewModel.techniques.generalAnesthesia || viewModel.techniques.sedationAnesthesia || viewModel.techniques.spinalAnesthesia || viewModel.techniques.periduralAnesthesia || viewModel.techniques.peripheralAnesthesia || viewModel.techniques.localAnesthesia {
                    Section ("Técnicas Selecionadas") {
                        if viewModel.techniques.generalAnesthesia {
                            Text("Anestesia Geral")
                                .foregroundColor(.secondary)
                        }
                        if viewModel.techniques.sedationAnesthesia {
                            Text("Sedação Anestésica")
                                .foregroundColor(.secondary)
                        }
                        if viewModel.techniques.spinalAnesthesia {
                            Text("Raquianestesia")
                                .foregroundColor(.secondary)
                        }
                        if viewModel.techniques.periduralAnesthesia {
                            Text("Peridural")
                                .foregroundColor(.secondary)
                        }
                        if viewModel.techniques.peripheralAnesthesia {
                            Text("Bloqueio Periférico")
                                .foregroundColor(.secondary)
                        }
                        if viewModel.techniques.localAnesthesia {
                            Text("Anestesia Local")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            Button("Resetar Seleção de Técnicas Anestésicas") {
                viewModel.techniques.resetTechniquesSelection()
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
    }
}
