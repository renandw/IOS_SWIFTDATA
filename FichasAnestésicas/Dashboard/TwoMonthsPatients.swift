//
//  TwoMonthsAnesthesias.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/11/25.
//
import SwiftUI
import SwiftData

struct TwoMonthsPatients: View {
    @Environment(SessionManager.self) var session
    let anesthesias: [Anesthesia]
    private let cal = Calendar.current
    
    @State private var searchText: String = ""
    
    private var grouped: (current: [Anesthesia], previous: [Anesthesia]) {
        let (curStart, curEnd) = monthBounds(for: now)
        let (prevStart, prevEnd) = monthBounds(for: cal.date(byAdding: .month, value: -1, to: now)!)
        
        func mostRecentPerPatient(in range: ClosedRange<Date>) -> [Anesthesia] {
            let filtered = anesthesias
                .compactMap { a in a.start.map { (a, $0) } }
                .filter { range.contains($0.1) }
                .map { $0.0 }
            
            let grouped = Dictionary(grouping: filtered, by: { $0.surgery.patient.id })
            return grouped.values
                .compactMap { $0.max(by: { ($0.start ?? .distantPast) < ($1.start ?? .distantPast) }) }
                .sorted(by: { ($0.start ?? .distantPast) > ($1.start ?? .distantPast) })
        }
        
        let currentAll = mostRecentPerPatient(in: curStart...curEnd)
        let previousAll = mostRecentPerPatient(in: prevStart...prevEnd)

        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return (
                current: currentAll,
                previous: previousAll
            )
        } else {
            let needle = trimmed
            let currentFiltered = currentAll.filter { a in
                a.surgery.patient.name.localizedStandardContains(needle)
            }
            let previousFiltered = previousAll.filter { a in
                a.surgery.patient.name.localizedStandardContains(needle)
            }
            return (
                current: currentFiltered,
                previous: previousFiltered
            )
        }
    }

    var body: some View {
        let g = grouped
        
        List {
            if g.current.isEmpty && g.previous.isEmpty {
                ContentUnavailableView("Nenhum Paciente com Anestesia Recente", systemImage: "person")
            } else {
                if !g.current.isEmpty {
                    Section("Este mês") {
                        ForEach(g.current) { a in row(for: a) }
                    }
                }
                
                if !g.previous.isEmpty {
                    Section("Mês anterior") {
                        ForEach(g.previous) { a in row(for: a) }
                    }
                }
            }
            
            Section {
                NavigationLink("Todos os pacientes no banco de dados") {
                    PatientListView()
                }
            }
        }
        .searchable(text: $searchText, placement: .toolbar, prompt: "Buscar pacientes")
        .navigationTitle("Pacientes Recentes")
        .listStyle(.insetGrouped)
    }
    
    private func row(for anesthesia: Anesthesia) -> some View {
        NavigationLink {
            PatientDetailsView(patient: anesthesia.surgery.patient)
        } label: {
            PatientRowView(
                patient: anesthesia.surgery.patient,
                numberCnsContext: .notNeeded,
                ageContext: .outSurgery
            )
        }
    }
    
    private func monthBounds(for date: Date) -> (start: Date, end: Date) {
        let start = cal.date(from: cal.dateComponents([.year, .month], from: date))!
        let end = cal.date(byAdding: .second, value: -1,
                    to: cal.date(byAdding: .month, value: 1, to: start)!)!
        return (start, end)
    }
    
    private var now: Date { Date() }
}

