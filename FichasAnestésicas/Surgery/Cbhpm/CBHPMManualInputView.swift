import SwiftUI

struct CBHPMManualInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedProcedures: [CbhpmCode]

    @State private var code = ""
    @State private var procedure = ""
    @State private var port = ""

    private var isValidInput: Bool {
        !trimmedCode.isEmpty && !trimmedProcedure.isEmpty && !trimmedPort.isEmpty
    }

    private var trimmedCode: String {
        code.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedProcedure: String {
        procedure.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedPort: String {
        port.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        Form {
            Section("Novo Item") {
                HStack {
                    Text("Código")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                TextField("3.33.33.33-3", text: $code)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Procedimento")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                TextField("Angiolastia de Coronárias", text: $procedure)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Porte Anestésico")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                TextField("5", text: $port)
                    .keyboardType(.numbersAndPunctuation)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .multilineTextAlignment(.trailing)
                }
            }


            // Section {
            //     Button("Adicionar item") {
            //         addItem()
            //     }
            //     .disabled(!isValidInput)
            // }
            // Section{
            //     Button("Adicionar e fechar") {
            //         addItem()
            //         dismiss()
            //     }
            //     .disabled(!isValidInput)
            // }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Adicionar", systemImage: "checkmark") {
                    addItem()
                }
                .disabled(!isValidInput)
            }
        }
        .navigationTitle("Inserir Código CBHPM")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addItem() {
        selectedProcedures.append(
            CbhpmCode(
                codigo: trimmedCode,
                procedimento: trimmedProcedure,
                porte_anestesico: trimmedPort
            )
        )

        code = ""
        procedure = ""
        port = ""
    }
}

#Preview {
    NavigationStack {
        CBHPMManualInputView(selectedProcedures: .constant([]))
    }
}
