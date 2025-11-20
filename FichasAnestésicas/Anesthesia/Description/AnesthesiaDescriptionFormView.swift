//
//  AnesthesiaDescriptionFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/11/25.
//

import SwiftUI
import Observation   // para @Bindable

struct AnesthesiaDescriptionFormView: View {

    @Bindable var viewModel: AnesthesiaDescriptionViewModel

    init(viewModel: AnesthesiaDescriptionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                monitoringSection
                admissionSection

                Section {
                    Button("Salvar") {
                        do {
                            try viewModel.save()
                            print("AnesthesiaDescriptionEntry salvo com sucesso")
                        } catch {
                            print("Erro ao salvar AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
            }
            .navigationTitle("Descrição da anestesia")
        }
    }

    // MARK: - Seção de Monitorização

    private var monitoringSection: some View {
        Section("Monitorização") {
            Toggle("Eletrocardioscopia", isOn: $viewModel.monitoring.electrocardioscopy)
            Toggle("Oximetria", isOn: $viewModel.monitoring.oximetry)
            Toggle("PANI", isOn: $viewModel.monitoring.nonInvasiveBloodPressure)
            Toggle("Capnografia", isOn: $viewModel.monitoring.capnography)
            Toggle("P. Art. invasiva", isOn: $viewModel.monitoring.invasiveBloodPlessure)
            Toggle("PVC", isOn: $viewModel.monitoring.centralVenousPressure)
            Toggle("Termômetro", isOn: $viewModel.monitoring.thermometer)
            Toggle("BIS", isOn: $viewModel.monitoring.bis)
            Toggle("TOF", isOn: $viewModel.monitoring.tof)
        }
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