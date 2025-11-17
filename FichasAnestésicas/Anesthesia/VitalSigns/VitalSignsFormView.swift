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

    var body: some View {
        Form {
            Section("Técnicas Anestésicas") {
                let allTechniques = viewModel.techniques.map { $0.rawValue }.joined(separator: ", ")
                Text(allTechniques.isEmpty ? "Sem técnicas anestésicas descritas" : allTechniques)
            }
            Section("ASA") {
                if let asa = viewModel.asaClassification {
                    Text(String(describing:asa))
                } else {
                    Text("Não informado")
                        .foregroundStyle(.secondary)
                }
            }
            Text("Idade: \(viewModel.patientAge)")

            
            Section {
                HStack {
                    Text("Horário")
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

            Section("Sinais vitais") {
                HStack {
                    Text("FC")
                    Spacer()
                    TextField("bpm", value: $viewModel.fc, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorFc { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("SpO₂")
                    Spacer()
                    TextField("%", value: $viewModel.spo2, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorSpo2 { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("PAS")
                    Spacer()
                    TextField("mmHg", value: $viewModel.paS, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorPaS { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("PAD")
                    Spacer()
                    TextField("mmHg", value: $viewModel.paD, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorPaD { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("Ritmo")
                    Spacer()
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
                    Picker("Ritmo", selection: Binding<String>(
                        get: { viewModel.rhythm ?? "" },
                        set: { newValue in
                            viewModel.rhythm = newValue.isEmpty ? nil : newValue
                        }
                    )) {
                        Text("Selecionar").tag("")
                        ForEach(rhythmOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                }
                if let error = viewModel.errorRhythm { Text(error).foregroundStyle(.red).font(.footnote) }
            }

            Section("Ventilação") {
                HStack {
                    Text("FiO₂")
                    Spacer()
                    TextField("%", value: $viewModel.fio2, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorFio2 { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("PEEP")
                    Spacer()
                    TextField("cmH₂O", value: $viewModel.peep, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorPeep { Text(error).foregroundStyle(.red).font(.footnote) }

                HStack {
                    Text("Volume Corrente")
                    Spacer()
                    TextField("mL", value: $viewModel.volumeCorrente, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorVolumeCorrente { Text(error).foregroundStyle(.red).font(.footnote) }
            }

            Section("Monitorização avançada") {
                HStack {
                    Text("BIS")
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
                    Spacer()
                    TextField("%", value: $viewModel.tof, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorTof {
                    Text(error).foregroundStyle(.red).font(.footnote)
                }
                HStack {
                    Text("PVC")
                    Spacer()
                    TextField("mmHg", value: $viewModel.pvc, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorPvc {
                    Text(error).foregroundStyle(.red).font(.footnote)
                }
                HStack {
                    Text("Débito cardíaco")
                    Spacer()
                    TextField("L/min", value: $viewModel.debitCardiaco, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorDebitCardiaco {
                    Text(error).foregroundStyle(.red).font(.footnote)
                }
                HStack {
                    Text("Pupilas")
                    Spacer()
                    TextField("", text: Binding<String>(
                        get: { viewModel.pupilas ?? "" },
                        set: { viewModel.pupilas = $0.isEmpty ? nil : $0 }))
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorPupilas {
                    Text(error).foregroundStyle(.red).font(.footnote)
                }
            }

            Section("Metabólico e balanço") {
                HStack {
                    Text("Glicemia")
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
                    Spacer()
                    TextField("mL", value: $viewModel.sangramento, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                if let error = viewModel.errorSangramento {
                    Text(error).foregroundStyle(.red).font(.footnote)
                }
            }
        }
        .navigationTitle(viewModel.isNew ? "Novo registro" : "Editar registro")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isNew {
                    Button("Criar Registro", systemImage: "plus") {
                        do { try viewModel.createCurrent(); dismiss() } catch { /* handle error UI */ }
                    }
                } else {
                    Button("Atualizar registro", systemImage: "checkmark.arrow.trianglehead.clockwise") {
                        do { try viewModel.updateCurrent(); dismiss() } catch { /* handle error UI */ }
                    }
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
            
    }
}

