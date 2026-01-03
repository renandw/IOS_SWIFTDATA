//
//  TwoMonthsAnesthesias.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/11/25.
//
import SwiftUI

struct TwoMonthsAnesthesias: View {
    let anesthesias: [Anesthesia]
    
    @State private var searchText: String = ""
    
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAnesthesiaWizard = false
    @State private var createdAnesthesia: Anesthesia?
    @State private var navigateToDetails = false
    
    var twoMonthsAnesthesias: [Anesthesia] {
        // Filtra anestesias entre o início do mês anterior e o fim do mês corrente
        let rangeStart = previousMonthBounds.start
        let rangeEnd = monthBounds.end
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let ranged = anesthesias.filter { anesthesia in
            guard let date = anesthesia.start else { return false }
            return (rangeStart ... rangeEnd).contains(date)
        }

        let searched: [Anesthesia]
        if trimmed.isEmpty {
            searched = ranged
        } else {
            let needle = trimmed.lowercased()
            searched = ranged.filter { anesthesia in
                let haystack = [
                    anesthesia.surgery.patient.name,
                    anesthesia.surgery.proposedProcedure,
                    anesthesia.surgery.mainSurgeon,
                ]
                .compactMap { $0?.lowercased() }
                .joined(separator: " ")
                return haystack.contains(needle)
            }
        }

        return searched.sorted { (a, b) in
            let da = a.start ?? .distantPast
            let db = b.start ?? .distantPast
            return da > db
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if twoMonthsAnesthesias.isEmpty {
                    ContentUnavailableView {
                        Label("Nenhuma Ficha Anestésica", systemImage: "doc.text")
                    } actions: {
                        Button("Nova Anestesia") {
                            showingAnesthesiaWizard = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(height: 200)
                    .glassEffect(in: .rect(cornerRadius: 16))
                } else {
                    LazyVStack(alignment:.leading, spacing: 12) {
                        // Este mês
                        let currentMonth = Calendar.current.dateComponents([.year, .month], from: now)
                        let currentMonthItems = twoMonthsAnesthesias.filter { item in
                            guard let d = item.start else { return false }
                            let comps = Calendar.current.dateComponents([.year, .month], from: d)
                            return comps.year == currentMonth.year && comps.month == currentMonth.month
                        }
                        
                        if !currentMonthItems.isEmpty {
                            Text("Este mês")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            VStack(spacing: 8) {
                                ForEach(currentMonthItems) { anesthesia in
                                    RecentAnesthesiaCard(anesthesia: anesthesia)
                                }
                            }
                        }
                        
                        // Mês anterior
                        let prevMonthStart = previousMonthBounds.start
                        let prevMonthComps = Calendar.current.dateComponents([.year, .month], from: prevMonthStart)
                        let previousMonthItems = twoMonthsAnesthesias.filter { item in
                            guard let d = item.start else { return false }
                            let comps = Calendar.current.dateComponents([.year, .month], from: d)
                            return comps.year == prevMonthComps.year && comps.month == prevMonthComps.month
                        }
                        
                        if !previousMonthItems.isEmpty {
                            Text("Mês anterior")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            VStack(spacing: 8) {
                                ForEach(previousMonthItems) { anesthesia in
                                    RecentAnesthesiaCard(anesthesia: anesthesia)
                                }
                            }
                        }
                        NavigationLink(destination: AllAnesthesias(anesthesias: anesthesias)) {
                            Label("Navegar para Todas as Anestesias", systemImage: "wallet.pass.fill")
                                .font(.body)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.glassProminent)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .searchable(text: $searchText, placement: .toolbar, prompt: "Buscar pacientes, procedimentos, cirurgiões")
        .navigationTitle("Anestesias Recentes")
        .navigationBarTitleDisplayMode(.automatic)
        .sheet(isPresented: $showingAnesthesiaWizard) {
            NewAnesthesiaPageView(
                session: session,
                modelContext: modelContext,
                onFinished: { anesthesia in
                    createdAnesthesia = anesthesia
                }
            )
        }
        .navigationDestination(item: $createdAnesthesia) { anesthesia in
            AnesthesiaDetailsView(anesthesia: anesthesia)
        }
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

