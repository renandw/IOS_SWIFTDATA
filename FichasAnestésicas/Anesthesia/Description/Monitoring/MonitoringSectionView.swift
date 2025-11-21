
import SwiftUI

struct MonitoringSectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    @Binding  var newCustomMonitoring: String
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Monitorização") {
                    let essentialMonitoringItems: [MonitoringItem] = [
                        MonitoringItem(title: "Eletrocardioscopia", icon: "waveform.path.ecg.rectangle", binding: $viewModel.monitoring.electrocardioscopy),
                        MonitoringItem(title: "Oximetria", icon: "lungs", binding: $viewModel.monitoring.oximetry),
                        MonitoringItem(title: "PANI", icon: "blood.pressure.cuff", binding: $viewModel.monitoring.nonInvasiveBloodPressure),
                        MonitoringItem(title: "Capnografia", icon: "carbon.dioxide.cloud", binding: $viewModel.monitoring.capnography)
                    ]
                    
                    let nonEssentialMonitoringItems: [MonitoringItem] = [
                        MonitoringItem(title: "PA Invasiva", icon: "blood.pressure.cuff.badge.gauge.with.needle", binding: $viewModel.monitoring.invasiveBloodPlessure),
                        MonitoringItem(title: "PVC", icon: "blood.pressure.cuff.badge.gauge.with.needle", binding: $viewModel.monitoring.centralVenousPressure),
                        MonitoringItem(title: "Termômetro", icon: "thermometer.variable", binding: $viewModel.monitoring.thermometer),
                        MonitoringItem(title: "BIS", icon: "brain", binding: $viewModel.monitoring.bis),
                        MonitoringItem(title: "TOF", icon: "gauge.with.dots.needle.67percent", binding: $viewModel.monitoring.tof),
                    ]
                    
                    ForEach(Array(essentialMonitoringItems.enumerated()), id: \.offset) { _, item in
                        Toggle(item.title, systemImage: item.icon, isOn: item.binding)
                    }
                    DisclosureGroup("Monitorizações adicionais") {
                        ForEach(Array(nonEssentialMonitoringItems.enumerated()), id: \.offset) { _, item in
                            Toggle(item.title,systemImage: item.icon , isOn: item.binding)
                        }
                        ForEach(Array(viewModel.monitoring.customMonitorings.enumerated()), id: \.offset) { index, name in
                            Toggle(isOn: Binding<Bool>(
                                get: {
                                    // Se o índice ainda é válido, o item está "ligado"
                                    viewModel.monitoring.customMonitorings.indices.contains(index)
                                },
                                set: { newValue in
                                    if newValue {
                                        // Garantir presença (evitar duplicatas)
                                        if !viewModel.monitoring.customMonitorings.contains(where: { $0.caseInsensitiveCompare(name) == .orderedSame }) {
                                            viewModel.monitoring.customMonitorings.append(name)
                                        }
                                    } else {
                                        viewModel.monitoring.removeCustomMonitoring(at: index)
                                    }
                                }
                            )) {
                                Text(name)
                            }
                        }
                        // Adicionar monitorizações personalizadas
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                TextField("Adicionar Monitorização", text: $newCustomMonitoring)
                                    .autocorrectionDisabled(true)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        viewModel.monitoring.addCustomMonitoring(newCustomMonitoring)
                                        newCustomMonitoring = ""
                                    }
                                if !newCustomMonitoring.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    Button(action: {
                                        viewModel.monitoring.addCustomMonitoring(newCustomMonitoring)
                                        newCustomMonitoring = "" }) {
                                            Image(systemName: "plus.circle")
                                        }
                                        .buttonStyle(.glass)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Monitorização")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluir") { dismiss() }
                }
            }
        }
    }
    
    struct MonitoringItem {
        let title: String
        let icon: String
        let binding: Binding<Bool>
    }
}
