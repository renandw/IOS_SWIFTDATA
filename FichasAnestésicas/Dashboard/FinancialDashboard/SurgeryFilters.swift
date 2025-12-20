//
//  SurgeryFilters.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//
import SwiftUI

struct SurgeryFilters {
    var patient = ""
    var hospital = ""
    var surgeon = ""
    var insurance = ""
    var paid: Bool? = nil
    var useDateFilter = false
    var startDate = Date()
    var endDate = Date()
    
    var hasActiveFilters: Bool {
        !patient.isEmpty || !hospital.isEmpty ||
        !surgeon.isEmpty || !insurance.isEmpty ||
        useDateFilter || paid != nil
    }
    
    mutating func clear() {
        self = SurgeryFilters()
    }
}


struct FilterSheetView: View {
    @Binding var filters: SurgeryFilters
    var showDateFilter = true
    @Binding var isFilterSheetPresented: Bool
    
    var hasActiveFilters: Bool {
        filters.hasActiveFilters
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Paciente")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("John Appleseed", text: $filters.patient)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                        if !filters.patient.isEmpty {
                            Button {
                                filters.patient = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Paciente")
                        }
                    }
                    HStack {
                        Text("Hospital")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Hospital de Base", text: $filters.hospital)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                        if !filters.hospital.isEmpty {
                            Button {
                                filters.hospital = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Hospital")
                        }
                    }
                    HStack {
                        Text("Cirurgião")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Dr. Appleseed", text: $filters.surgeon)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                        if !filters.surgeon.isEmpty {
                            Button {
                                filters.surgeon = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Cirurgião")
                        }
                    }
                    HStack {
                        Text("Convênio")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Particular", text: $filters.insurance)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                        if !filters.insurance.isEmpty {
                            Button {
                                filters.insurance = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Convênio")
                        }
                    }
                    HStack {
                        Text("Pagamento")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Picker("", selection: Binding<Bool>(
                            get: { filters.paid ?? false },
                            set: { filters.paid = $0 }
                        )) {
                            Text("Pago").tag(true)
                            Text("Pendente").tag(false)
                        }
                        .pickerStyle(.segmented)
                    }
                } header : {
                    HStack {
                        Text("Filtros")
                            .fontWeight(.semibold)
                        Spacer()
                        if hasActiveFilters {
                            Button {
                                filters.clear()
                            } label: {
                                Image(systemName: "eraser.fill")
                                Text("Limpar Filtros")
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                if showDateFilter {
                    Section {
                        Toggle("Filtrar por Data", isOn: $filters.useDateFilter)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        if filters.useDateFilter {
                            OnlyDatePickerSheetButton(
                                date: Binding(
                                    get: { filters.startDate },
                                    set: { filters.startDate = $0 ?? Date() }
                                ),
                                title: "Data inicial",
                                placeholder: "Selecionar",
                                compactInRow: false
                            )
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                            OnlyDatePickerSheetButton(
                                date: Binding(
                                    get: { filters.endDate },
                                    set: { filters.endDate = $0 ?? Date() }
                                ),
                                title: "Data final",
                                placeholder: "Selecionar",
                                compactInRow: false
                            )
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        }
                    }
                }
            }
            .navigationTitle("Filtros")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fechar" , systemImage: "xmark") {
                        isFilterSheetPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aplicar" , systemImage: "checkmark") {
                        isFilterSheetPresented = false
                    }
                }
            }
        }
    }
}


#Preview("FilterSheetView") {
    @Previewable @State var filters = SurgeryFilters(
        patient: "Maria",
        hospital: "Santa Casa",
        surgeon: "Dr. Silva",
        insurance: "Unimed",
        useDateFilter: true,
        startDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date(),
        endDate: Date()
    )
    @Previewable @State var isPresented = true

    return NavigationStack {
        FilterSheetView(
            filters: $filters,
            isFilterSheetPresented: $isPresented
        )
    }
}
