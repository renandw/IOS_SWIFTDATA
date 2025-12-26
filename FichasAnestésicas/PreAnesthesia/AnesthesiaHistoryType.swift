//
//  AnesthesiaHistoryType.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 28/11/25.
//

import SwiftUI

// MARK: - View Principal Refatorada
struct AnesthesiaHistoryTypeFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var viewModel: PreAnesthesiaViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                NewComorbidityDetailSection<AnesthesiaHistoryDetail, AnesthesiaComplicationsHistory>(
                    title: "Anestesias Prévias",
                    icon: "syringe.fill",
                    isEnabled: $viewModel.surgeryHistory.anesthesiaHistory.optional(),
                    details: $viewModel.surgeryHistory.anesthesiaHistoricDetails,
                    createDetail: { AnesthesiaHistoryDetail(type: $0) },
                    createCustomDetail: { AnesthesiaHistoryDetail(customName: $0) }
                )
            }
            .navigationTitle("Anestesias Prévias")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        } catch {
                            print("Erro ao salvar: \(error)")
                        }
                    }
                }
            }
        }
    }
}

