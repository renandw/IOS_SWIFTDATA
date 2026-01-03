//
//  AllMonthView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 18/12/25.
//

import SwiftUI
import SwiftData

struct AllMonthsView: View {
    let surgeries: [Surgery]
    @State private var selectedYear: Int
    
    init(surgeries: [Surgery]) {
        self.surgeries = surgeries
        // Inicializa com o ano atual
        _selectedYear = State(initialValue: Calendar.current.component(.year, from: Date()))
    }
    
    private var availableYears: [Int] {
        let calendar = Calendar.current
        let years = Set(surgeries.compactMap { surgery in
            calendar.component(.year, from: surgery.date)
        })
        return years.sorted(by: >)
    }
    
    private var groupedByMonth: [Date: [Surgery]] {
        let calendar = Calendar.current
        return Dictionary(grouping: surgeries.filter { $0.type == .convenio }) { surgery in
            calendar.date(from: calendar.dateComponents([.year, .month], from: surgery.date)) ?? surgery.date
        }
    }
    
    private var filteredMonthDates: [Date] {
        let calendar = Calendar.current
        return groupedByMonth.keys
            .filter { monthDate in
                calendar.component(.year, from: monthDate) == selectedYear
            }
            .sorted(by: >)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Seletor de ano
                //if availableYears.count > 1 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Filtrar por ano:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Picker("Ano", selection: $selectedYear) {
                            ForEach(availableYears, id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal)
                    .padding(.top)
               // }
                
                // Lista de meses filtrados
                VStack(alignment: .leading, spacing: 12) {
                    if filteredMonthDates.isEmpty {
                        Text("Nenhuma cirurgia encontrada para \(selectedYear)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ForEach(filteredMonthDates, id: \.self) { monthDate in
                            let calendar = Calendar.current
                            let components = calendar.dateComponents([.month, .year], from: monthDate)
                            
                            if let month = components.month, let year = components.year {
                                let stats = MonthlyStatsHelper.getMonthlyStats(for: month, year: year, from: surgeries)
                                let surgeriesForMonth = groupedByMonth[monthDate] ?? []
                                
                                NavigationLink {
                                    MonthFinancialView(
                                        monthDate: monthDate,
                                        stats: stats,
                                        surgeries: surgeriesForMonth
                                    )
                                } label: {
                                    MonthStatCard(
                                        icon: "calendar",
                                        cardName: monthDate.formatted(.dateTime.month(.wide).year()),
                                        title: monthDate.formatted(.dateTime.month(.wide).year()),
                                        stats: stats,
                                        iconColor: .blue
                                    )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.tertiarySystemGroupedBackground))
        .navigationTitle("Escolha um mês")
    }
}

#Preview("FinancialDashboard") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)



    let session = SessionManager()
    session.currentUser = user

    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }
        try! context.save()
    }


    return NavigationStack {
        AllMonthsView(surgeries: surgeries)
            .environment(session)
    }
    .modelContainer(container)
}
