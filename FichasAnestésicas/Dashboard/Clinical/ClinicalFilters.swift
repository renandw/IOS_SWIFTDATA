//
//  ClinicalFilters.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 12/01/26.
//
import SwiftUI

struct ClinicalFilters {
    var patient = ""
    var sex: Sex? = nil
    var asa: ASAClassification? = nil
    var weight: Double? = nil
    var hospital = ""
    var procedure = ""
    var surgeon = ""
    var insurance = ""
    var paid: Bool? = nil
    var useDateFilter = false
    var startDate = Date()
    var endDate = Date()
    
    var hasActiveFilters: Bool {
        !patient.isEmpty || !hospital.isEmpty || asa != nil ||
        weight != nil ||
        !surgeon.isEmpty || !insurance.isEmpty || sex != nil ||
        useDateFilter || paid != nil
    }
    
    mutating func clear() {
        self = ClinicalFilters()
    }
}

struct ClinicalFilterSheetView: View {
    @Binding var filters: ClinicalFilters
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
                        Text("Sexo")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Picker("", selection: Binding<Sex?>(
                            get: { filters.sex },
                            set: { filters.sex = $0 }
                        )) {
                            ForEach(Sex.allCases, id: \.self) { sex in
                                HStack {
                                    Image(systemName: sex.sexImage)
                                    //Text(sex.sexStringDescription)
                                }
                                .tag(Optional(sex))
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 160)
                        
                        if filters.sex != nil {
                            Button {
                                filters.sex = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Sexo")
                        }
                    }
                    HStack {
                        Text("ASA")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Picker("", selection: Binding<ASAClassification?>(
                            get: { filters.asa },
                            set: { filters.asa = $0 }
                        )) {
                            Text("Não informado").tag(nil as ASAClassification?)
                            ForEach(ASAClassification.allCases, id: \.self) { asa in
                                HStack {
                                    Text(asa.displayName)
                                }
                                .tag(Optional(asa))
                            }
                        }
                    }
                    HStack {
                        Text("Peso")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("kg", value: $filters.weight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        if filters.weight != nil {
                            Button {
                                filters.weight = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Peso")
                        }
                    }
                }
                Section{
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
                        Text("Procedimento")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("Postectomia", text: $filters.procedure)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                        if !filters.procedure.isEmpty {
                            Button {
                                filters.procedure = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar Procedimento")
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

#Preview("ClinicalFilterSheetView") {
    @Previewable @State var filters = ClinicalFilters(
        patient: "Maria",
        sex: .female,
        asa: .II,
        weight: 70,
        hospital: "Santa Casa",
        procedure: "Colecistectomia",
        surgeon: "Dr. Silva",
        insurance: "Unimed",
        useDateFilter: true,
        startDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date(),
        endDate: Date()
    )
    @Previewable @State var isPresented = true

    return NavigationStack {
        ClinicalFilterSheetView(
            filters: $filters,
            isFilterSheetPresented: $isPresented
        )
    }
}
