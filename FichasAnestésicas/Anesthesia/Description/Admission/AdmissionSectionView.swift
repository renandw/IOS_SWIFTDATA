import SwiftUI
import Observation

struct AdmissionSectionView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var viewModel: AnesthesiaDescriptionViewModel

  var body: some View {
      NavigationStack {
          Form {
              Section {
                  airwayPicker
                  consciousnessPicker
                  ventilatoryPicker
                  if viewModel.admission.ventilatory != .spontaneous {
                      mechanicalVentilationPicker
                  }
                  oxygenSupplyPicker
                  if viewModel.admission.oxygenSupply != .ambientAir {
                      fiO2Field
                  }
                  hemodynamicPicker
                  veinAccessPicker
                  if viewModel.admission.veinAccess != VeinAccessKind.none {
                      veinGaugePicker
                  }
              } header: {
                  Text("Admissão")
              }
          }
          .navigationTitle("Admissão")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                  Button("Concluir") { dismiss() }
              }
          }
      }
  }
    private var consciousnessPicker: some View {
        Picker("Consciência", selection: $viewModel.admission.consciousness) {
            Text("Não informado").tag(nil as ConsciousnessKind?)
            ForEach(ConsciousnessKind.allCases, id: \.self) { (kind: ConsciousnessKind) in
                Text(kind.displayName(for: viewModel.patientAge))
                    .tag(Optional(kind))
            }
        }
    }

    private var airwayPicker: some View {
        Picker("Via aérea", selection: $viewModel.admission.airway) {
            Text("Não informado").tag(nil as AirwayKind?)
            ForEach(AirwayKind.allCases, id: \.self) { (kind: AirwayKind) in
                Text(kind.displayName)
                    .tag(Optional(kind))
            }
        }
    }

    private var ventilatoryPicker: some View {
        // Compute allowed options outside the ViewBuilder to avoid '()' in View context
        let allowed: [VentilationMode]
        if let airway = viewModel.admission.airway, [.noDevice, .compromised, .oropharyngealGuedel, .nasopharyngeal].contains(airway) {
            allowed = [.spontaneous]
        } else {
            allowed = VentilationMode.allCases
        }
        return Picker("Modo ventilatório", selection: $viewModel.admission.ventilatory) {
            Text("Não informado").tag(nil as VentilationMode?)
            ForEach(allowed, id: \.self) { (mode: VentilationMode) in
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

