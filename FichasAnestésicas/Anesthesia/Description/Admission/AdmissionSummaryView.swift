//
//  MonitoringSummaryView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 21/11/25.
//


import SwiftUI
import Observation

struct AdmissionSummaryView: View {
  @Bindable var viewModel: AnesthesiaDescriptionViewModel
  @Binding var isPresented: Bool

  private var admissionSummary: String {
    var result: [String] = []

      if let airway = viewModel.admission.airway?.displayName {
      result.append("\(airway)")
    }
    if let consciousness = viewModel.admission.consciousness {
      result.append("\(consciousness)")
    }
      if let ventilatory = viewModel.admission.ventilatory {
      result.append("\(ventilatory)")
    }
    if let mechanicalVentilation =  viewModel.admission.mechanicalVentilation {
      result.append("\(mechanicalVentilation)")
    }
      if let oxygenSupply = viewModel.admission.oxygenSupply {
          result.append("\(oxygenSupply)")
      }
      if let fiO2Fraction = viewModel.admission.fiO2Fraction {
          result.append("\(fiO2Fraction)")
      }
    if let hemodynamic = viewModel.admission.hemodynamic {
      result.append("\(hemodynamic)")
    }
      if let veinAccess = viewModel.admission.veinAccess {
          result.append("\(veinAccess)")
      }
      if let veinGauge = viewModel.admission.veinGauge {
          result.append("\(veinGauge)")
      }
    if viewModel.monitoring.customMonitorings.isEmpty {
      result.append(contentsOf: viewModel.monitoring.customMonitorings)
    }
    return result.joined(separator: ", ")
  }

  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: "figure.wave.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
        .foregroundColor(.green)

      VStack(alignment: .leading) {
        Text("Admissão")
          .font(.headline)
        Text(admissionSummary)
          .font(.caption)
          .foregroundColor(.secondary)
          Text(viewModel.admission.generateAdmissionText(patientAge: viewModel.patientAge))
      }
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundColor(.secondary)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      isPresented = true
    }
  }
}
