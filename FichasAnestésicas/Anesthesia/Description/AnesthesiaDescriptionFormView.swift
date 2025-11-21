//
//  AnesthesiaDescriptionFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import Observation   // para @Bindable

struct AnesthesiaDescriptionFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AnesthesiaDescriptionViewModel
    @State private var isMonitoringSheetPresented: Bool = false
    @State private var newCustomMonitoring: String = ""

    init(viewModel: AnesthesiaDescriptionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "waveform.path.ecg")
                            .foregroundStyle(.secondary)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Monitorização")
                                .font(.body)
                                .foregroundColor(.primary)
                            Text(monitoringSummary)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                                .multilineTextAlignment(.trailing)
                                .truncationMode(.tail)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.tertiary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { isMonitoringSheetPresented = true }
                } header: {
                    HStack {
                        Text("Monitorização")
                        Spacer()
                        Button {
                            viewModel.monitoring.applyMonitoringSuggestion(hasGeneralAnesthesia: viewModel.hasGeneralAnesthesia)
                        } label: {
                            Label("Sugerir", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderless)
                        .controlSize(.mini)
                        .foregroundStyle(.tint)
                    }
                }
                admissionSection

            }
            .navigationTitle("Descrição Anestésica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        }
                        catch {
                            print("Erro ao salvar AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Excluir", systemImage: "trash") {
                        do {
                            try viewModel.delete()
                            dismiss()
                        }
                        catch {
                            print("Erro ao excluir AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isMonitoringSheetPresented) {
            MonitoringSectionView(
                viewModel: viewModel,
                newCustomMonitoring: $newCustomMonitoring
            )
        }
    }

    // MARK: - Helpers
    private var monitoringSummary: String {
        var names: [String] = []
        if viewModel.monitoring.electrocardioscopy { names.append("Cardioscopia") }
        if viewModel.monitoring.oximetry { names.append("Oximetria") }
        if viewModel.monitoring.nonInvasiveBloodPressure { names.append("PANI") }
        if viewModel.monitoring.capnography { names.append("Capnografia") }
        if viewModel.monitoring.invasiveBloodPlessure { names.append("PAI") }
        if viewModel.monitoring.centralVenousPressure { names.append("PVC") }
        if viewModel.monitoring.thermometer { names.append("Termômetro") }
        if viewModel.monitoring.bis { names.append("BIS") }
        if viewModel.monitoring.tof { names.append("TOF") }

        // If customMonitorings is an array of simple names (String)
        if let custom = viewModel.monitoring.customMonitorings as? [String] {
            names.append(contentsOf: custom)
        }

        // If customMonitorings is an array of items with `isOn` and `name`, keep the next line.
        // names.append(contentsOf: viewModel.monitoring.customMonitorings.filter { $0.isOn }.map { $0.name })

        if names.isEmpty { return "Nenhuma monitorização selecionada" }
        return names.joined(separator: ", ")
    }


    // MARK: - Seção de Admissão

    private var admissionSection: some View {
        Section("Admissão") {
            airwayPicker
            consciousnessPicker
            ventilatoryPicker
            mechanicalVentilationPicker
            oxygenSupplyPicker
            fiO2Field
            hemodynamicPicker
            veinAccessPicker
            veinGaugePicker
        }
    }

    // MARK: - Subviews Admission

    private var airwayPicker: some View {
        Picker("Via aérea", selection: $viewModel.admission.airway) {
            Text("Não informado").tag(nil as AirwayKind?)
            ForEach(AirwayKind.allCases, id: \.self) { (kind: AirwayKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var consciousnessPicker: some View {
        Picker("Consciência", selection: $viewModel.admission.consciousness) {
            Text("Não informado").tag(nil as ConsciousnessKind?)
            ForEach(ConsciousnessKind.allCases, id: \.self) { (kind: ConsciousnessKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var ventilatoryPicker: some View {
        Picker("Modo ventilatório", selection: $viewModel.admission.ventilatory) {
            Text("Não informado").tag(nil as VentilationMode?)
            ForEach(VentilationMode.allCases, id: \.self) { (mode: VentilationMode) in
                Text(mode.displayName)
                    .tag(Optional(mode))
            }
        }
    }

    private var mechanicalVentilationPicker: some View {
        Picker("Ventilação mecânica", selection: $viewModel.admission.mechanicalVentilation) {
            Text("Não informado").tag(nil as MechanicalVentilationMode?)
            ForEach(MechanicalVentilationMode.allCases, id: \.self) { (mode: MechanicalVentilationMode) in
                Text(mode.displayName)
                    .tag(Optional(mode))
            }
        }
    }

    private var oxygenSupplyPicker: some View {
        Picker("Suplementação O₂", selection: $viewModel.admission.oxygenSupply) {
            Text("Não informado").tag(nil as OxygenSupply?)
            ForEach(OxygenSupply.allCases, id: \.self) { (supply: OxygenSupply) in
                Text(supply.displayName)
                    .tag(Optional(supply))
            }
        }
    }

    private var fiO2Field: some View {
        HStack {
            Text("FiO₂")
            TextField("Ex.: 0,5", value: $viewModel.admission.fiO2Fraction, format: .number)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }

    private var hemodynamicPicker: some View {
        Picker("Hemodinâmica", selection: $viewModel.admission.hemodynamic) {
            Text("Não informado").tag(nil as HemodynamicKind?)
            ForEach(HemodynamicKind.allCases, id: \.self) { (kind: HemodynamicKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var veinAccessPicker: some View {
        Picker("Acesso venoso", selection: $viewModel.admission.veinAccess) {
            Text("Não informado").tag(nil as VeinAccessKind?)
            ForEach(VeinAccessKind.allCases, id: \.self) { (kind: VeinAccessKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var veinGaugePicker: some View {
        Picker("Calibre do acesso", selection: $viewModel.admission.veinGauge) {
            Text("Não informado").tag(nil as VeinGaugeKind?)
            ForEach(VeinGaugeKind.allCases, id: \.self) { (kind: VeinGaugeKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }
}

