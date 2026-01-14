//
//  VitalSignsFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 16/11/25.
//

import SwiftUI

struct VitalSignsFormView: View {
    @ObservedObject var viewModel: VitalSignsFormViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    @FocusState private var fcFieldFocused: Bool
    @FocusState private var spo2FieldFocused: Bool
    @FocusState private var paSFieldFocused: Bool
    @FocusState private var paDFieldFocused: Bool
    @State private var seriesDurationMinutes: Int? = nil
    @State private var showExtraMonitoring: Bool = false

    var body: some View {
        Form {
            if viewModel.isNew && viewModel.anesthesiaEnd == nil {
                Section("Preenchimento automático") {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Duração")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            TextField("min", value: $seriesDurationMinutes, format: .number)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            if seriesDurationMinutes != nil {
                                Text("min")
                                    .foregroundStyle(.secondary)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        Text("Gerar registros automaticamente com pequenas variações dos sinais vitais dentro de faixas normais.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
//                        Text("Quando em branco, será usada a diferença entre início e fim da anestesia (quando disponível).")
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
                    }
                }
            }
            Section {
                if viewModel.isNew {
                    HStack {
                        Button {
                            viewModel.healthyPatient()
                        } label : {
                            Text("Paciente Saudável")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }

            
            Section {
                HStack {
                    Text("Horário")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    DateTimePickerSheetButton(
                        date: Binding<Date?>(
                            get: { viewModel.timestamp },
                            set: { viewModel.timestamp = $0 ?? viewModel.timestamp }
                        ),
                        title: "Administração",
                        placeholder: "Selecionar",
                        minDate: nil,
                        maxDate: nil,
                        compactInRow: true
                    )
                }
            }

            Section("Monitorização Básica") {
                HStack {
                    let rhythmOptions: [String] = [
                        "Sinusal",
                        "Taquicardia Sinusal",
                        "Bradicardia Sinusal",
                        "Fibrilação Atrial",
                        "Flutter Atrial",
                        "Taquicardia Supraventricular",
                        "Extrassístoles",
                        "Ritmo Nodal"
                    ]
                    LabeledContent {
                        Picker("", selection: $viewModel.rhythm) {
                            ForEach(rhythmOptions, id: \.self) { r in
                                Text(r).tag(String?.some(r))
                            }
                        }
                        .pickerStyle(.menu)
                    } label: {
                        Text("Ritmo")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                if let error = viewModel.errorRhythm { Text(error).foregroundStyle(.red).font(.footnote) }
                
                HStack {
                    Text("FC")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("bpm", value: $viewModel.fc, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($fcFieldFocused)
                        .onChange(of: fcFieldFocused, initial: false) { oldValue, newValue in
                            if newValue {
                                viewModel.markFcTouched()
                            } else {
                                viewModel.validateFc()
                            }
                        }
                }
                if let error = viewModel.errorFc { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("SpO₂")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("%", value: $viewModel.spo2, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($spo2FieldFocused)
                        .onChange(of: spo2FieldFocused, initial: false) { oldValue, newValue in
                            if newValue {
                                viewModel.markSpo2Touched()
                            } else {
                                viewModel.validateSpo2()
                            }
                        }
                }
                if let error = viewModel.errorSpo2 { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("PAS")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("mmHg", value: $viewModel.paS, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($paSFieldFocused)
                        .onChange(of: paSFieldFocused, initial: false) { oldValue, newValue in
                            if newValue {
                                viewModel.markPaSTouched()
                            } else {
                                viewModel.validatePa()
                            }
                        }
                }
                if let error = viewModel.errorPaS { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("PAD")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("mmHg", value: $viewModel.paD, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($paDFieldFocused)
                        .onChange(of: paDFieldFocused, initial: false) { oldValue, newValue in
                            if newValue {
                                viewModel.markPaDTouched()
                            } else {
                                viewModel.validatePa()
                            }
                        }
                }
                if let error = viewModel.errorPaD { Text(error).foregroundStyle(.red).font(.footnote) }

                
                HStack {
                    Text("EtCo2")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("mmHg", value: $viewModel.etco2, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorEtco2 { Text(error).foregroundStyle(.red).font(.footnote) }
            }

            Section {
                DisclosureGroup(isExpanded: $showExtraMonitoring) {
                    // Ventilação
                    HStack {
                        Text("FiO₂")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("%", value: $viewModel.fio2, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorFio2 { Text(error).foregroundStyle(.red).font(.footnote) }

                    HStack {
                        Text("PEEP")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("cmH₂O", value: $viewModel.peep, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorPeep { Text(error).foregroundStyle(.red).font(.footnote) }

                    HStack {
                        Text("Volume Corrente")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mL", value: $viewModel.volumeCorrente, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorVolumeCorrente { Text(error).foregroundStyle(.red).font(.footnote) }

                    // Metabólico e balanço
                    HStack {
                        Text("Glicemia")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mg/dL", value: $viewModel.glicemia, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorGlicemia {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Lactato")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mmol/L", value: $viewModel.lactato, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorLactato {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Temperatura")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("°C", value: $viewModel.temperatura, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorTemperatura {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Diurese")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mL", value: $viewModel.diurese, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorDiurese {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Sangramento")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mL", value: $viewModel.sangramento, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorSangramento {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("PVC")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("mmHg", value: $viewModel.pvc, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorPvc {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Débito Cardíaco")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("L/min", value: $viewModel.debitCardiaco, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorDebitCardiaco {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    // Monitorização avançada
                    HStack {
                        Text("BIS")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("", value: $viewModel.bis, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorBis {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("TOF")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("%", value: $viewModel.tof, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorTof {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                    HStack {
                        Text("Pupilas")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("", text: Binding<String>(
                            get: { viewModel.pupilas ?? "" },
                            set: { viewModel.pupilas = $0.isEmpty ? nil : $0 }))
                            .multilineTextAlignment(.trailing)
                    }
                    if let error = viewModel.errorPupilas {
                        Text(error).foregroundStyle(.red).font(.footnote)
                    }
                } label: {
                    Text("Ventilação, Hídrico e Metabólico")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
        }
        .navigationTitle(viewModel.isNew ? "Registrar Sinais Vitais" : "Editar registro")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.isNew {
                    Button("Criar Registro", systemImage: "plus") {
                        do {
                            try viewModel.createCurrent(); dismiss()
                        } catch {
                            /* handle error UI */
                        }
                    }
                    .tint(.blue)
                } else {
                    Button("Atualizar registro", systemImage: "checkmark.arrow.trianglehead.clockwise") {
                        do { try viewModel.updateCurrent(); dismiss() } catch { /* handle error UI */ }
                    }
                    .tint(.blue)
                }
            }
            ToolbarSpacer(.fixed, placement: .topBarTrailing)
            if viewModel.isNew && viewModel.anesthesiaEnd != nil || viewModel.isNew && seriesDurationMinutes != nil {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        do {
                            viewModel.healthyPatient()
                            try viewModel.generateSeries(durationMinutes: seriesDurationMinutes)
                        } catch {
                            // TODO: apresentar erro ao usuário (SeriesGenerationError ou outro)
                        }
                    } label: {
                        Label("Gerar série", systemImage: "sparkles")
                    }
                    .tint(.blue)
                }
            }
            if !viewModel.isNew {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .destructive) {
                        do { try viewModel.deleteCurrent(); dismiss() } catch { /* handle error UI */ }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            
        }
        .onChange(of: viewModel.shouldDismissAfterGenerateSeries) { oldValue, newValue in
            if newValue {
                dismiss()
            }
        }
            
    }
}

