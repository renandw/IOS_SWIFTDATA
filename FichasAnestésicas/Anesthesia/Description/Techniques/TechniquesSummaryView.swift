import SwiftUI
import Observation

struct TechniquesSummaryView: View {
  @Bindable var viewModel: AnesthesiaDescriptionViewModel
  @Binding var isPresented: Bool

    private var techniqueSummary: String {
        var result: [String] = []
        
        if viewModel.techniques.generalAnesthesia {
            result.append("Anestesia Geral")
        }
        if viewModel.techniques.sedationAnesthesia {
            result.append("Sedação")
        }
        if viewModel.techniques.spinalAnesthesia {
            result.append("Raquianestesia")
        }
        if viewModel.techniques.periduralAnesthesia {
            result.append("Peridural")
        }
        if viewModel.techniques.peripheralAnesthesia {
            result.append("Bloqueios Periféricos")
        }
        if viewModel.techniques.localAnesthesia {
            result.append("Local")
        }
        return result.joined(separator: ", ")
    }

  var body: some View {
      HStack(spacing: 15) {
          Image(systemName: "pill.circle.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 40)
              .foregroundColor(.purple)
          
          VStack(alignment: .leading) {
              Text("Técnicas Anestésicas")
                  .font(.headline)
              Text(techniqueSummary)
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
