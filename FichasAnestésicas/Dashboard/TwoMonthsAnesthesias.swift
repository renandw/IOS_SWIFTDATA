//
//  TwoMonthsAnesthesias.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/11/25.
//
import SwiftUI

struct TwoMonthsAnesthesias: View {
    let anesthesias: [Anesthesia]
    
    var twoMonthsAnesthesias: [Anesthesia] {
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
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {                
                if twoMonthsAnesthesias.isEmpty {
                    ContentUnavailableView(
                        "Nenhuma ficha anestésica",
                        systemImage: "doc.text",
                        description: Text("As fichas anestésicas criadas aparecerão aqui")
                    )
                    .frame(height: 200)
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
        .navigationTitle("Anestesias Recentes")
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

