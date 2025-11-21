import SwiftUI
import Observation

struct MonitoringSummaryView: View {
  @Bindable var viewModel: AnesthesiaDescriptionViewModel
  @Binding var isPresented: Bool

  private var monitoringSummary: String {
    var result: [String] = []

    if viewModel.monitoring.electrocardioscopy {
      result.append("Cardioscopia")
    }
    if viewModel.monitoring.oximetry {
      result.append("Oximetria")
    }
      if viewModel.monitoring.nonInvasiveBloodPressure {
      result.append("PANI")
    }
    if viewModel.monitoring.capnography {
      result.append("Capnografia")
    }
      if viewModel.monitoring.invasiveBloodPlessure {
          result.append("PAI")
      }
      if viewModel.monitoring.centralVenousPressure {
          result.append("PVC")
      }
    if viewModel.monitoring.thermometer {
      result.append("Termômetro")
    }
      if viewModel.monitoring.bis {
          result.append("BIS")
      }
      if viewModel.monitoring.tof {
          result.append("TOF")
      }
    if viewModel.monitoring.customMonitorings.isEmpty {
      result.append(contentsOf: viewModel.monitoring.customMonitorings)
    }
    return result.joined(separator: ", ")
  }

  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: "stethoscope.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
        .foregroundColor(.accentColor)

      VStack(alignment: .leading) {
        Text("Monitorização")
          .font(.headline)
        Text(monitoringSummary)
          .font(.caption)
          .foregroundColor(.secondary)
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
