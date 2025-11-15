//
//  TwoMonthsAnesthesias.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/11/25.
//
import SwiftUI

struct TwoMonthsPatients: View {
    @Environment(SessionManager.self) var session
    let anesthesias: [Anesthesia]
    
    var twoMonthsPatients: [Anesthesia] {
        // Filtra anestesias entre o início do mês anterior e o fim do mês corrente
        let rangeStart = previousMonthBounds.start
        let rangeEnd = monthBounds.end
        return anesthesias
            .filter { anesthesia in
                guard let date = anesthesia.start else { return false }
                return (rangeStart ... rangeEnd).contains(date)
            }
            .sorted { (a, b) in
                let da = a.start ?? .distantPast
                let db = b.start ?? .distantPast
                return da > db
            }
    }
    
    var body: some View {
        Group {
            if twoMonthsPatients.isEmpty {
                ContentUnavailableView(
                    "Nenhum Paciente",
                    systemImage: "Person",
                    description: Text("Os pacientes aparecerão aqui")
                )
                .frame(height: 200)
            } else {
                List {
                    // Este mês
                    let currentMonth = Calendar.current.dateComponents([.year, .month], from: now)
                    let currentMonthItems = twoMonthsPatients.filter { item in
                        guard let d = item.start else { return false }
                        let comps = Calendar.current.dateComponents([.year, .month], from: d)
                        return comps.year == currentMonth.year && comps.month == currentMonth.month
                    }

                    if !currentMonthItems.isEmpty {
                        Section("Este mês") {
                            ForEach(currentMonthItems) { anesthesia in
                                NavigationLink {
                                    PatientDetailsView(patient: anesthesia.surgery.patient)
                                } label: {
                                    PatientRowView(
                                        patient: anesthesia.surgery.patient,
                                        numberCnsContext: .notNeeded,
                                        ageContext: .outSurgery
                                    )
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                    }

                    // Mês anterior
                    let prevMonthStart = previousMonthBounds.start
                    let prevMonthComps = Calendar.current.dateComponents([.year, .month], from: prevMonthStart)
                    let previousMonthItems = twoMonthsPatients.filter { item in
                        guard let d = item.start else { return false }
                        let comps = Calendar.current.dateComponents([.year, .month], from: d)
                        return comps.year == prevMonthComps.year && comps.month == prevMonthComps.month
                    }

                    if !previousMonthItems.isEmpty {
                        Section("Mês anterior") {
                            ForEach(previousMonthItems) { anesthesia in
                                NavigationLink {
                                    PatientDetailsView(patient: anesthesia.surgery.patient)
                                } label: {
                                    PatientRowView(
                                        patient: anesthesia.surgery.patient,
                                        numberCnsContext: .notNeeded,
                                        ageContext: .outSurgery
                                    )
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                    }

                    Section {
                        NavigationLink(destination: PatientListView(session: session)) {
                            Label("Navegar para todos os pacientes", systemImage: "wallet.pass.fill")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Pacientes Recentes")
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    private var now: Date { Date() }

    private var monthBounds: (start: Date, end: Date) {
        let cal = Calendar.current
        let start = cal.date(from: cal.dateComponents([.year, .month], from: now)) ?? now
        let end = cal.date(byAdding: .month, value: 1, to: start).map { cal.date(byAdding: .second, value: -1, to: $0) ?? $0 } ?? now
        return (start, end)
    }

    private var previousMonthBounds: (start: Date, end: Date) {
        let cal = Calendar.current
        let currentStart = cal.date(from: cal.dateComponents([.year, .month], from: now)) ?? now
        let start = cal.date(byAdding: .month, value: -1, to: currentStart) ?? now
        let end = cal.date(byAdding: .second, value: -1, to: currentStart) ?? currentStart
        return (start, end)
    }
}

