//
//  Last12MonthsGraphView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//

import SwiftUI
import SwiftData
import Charts

struct Last12MonthsGraphView: View {
    let surgeries: [Surgery]
    
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    @State private var showingAnesthesiaWizard = false
    @State private var createdAnesthesia: Anesthesia?
    @State private var navigateToDetails = false
    
    struct MonthData: Identifiable, Hashable {
        let id = UUID()
        let month: Date
        let received: Double
        let scheduled: Double
    }
    
    var body: some View {
        let calendar = Calendar.current
        let now = Date()
        let currentMonthComponents = calendar.dateComponents([.year, .month], from: now)
        
        // Generate last 12 months anchors (oldest to newest)
        let monthAnchors: [Date] = (0..<6).reversed().compactMap {
            calendar.date(byAdding: .month, value: -$0, to: calendar.date(from: currentMonthComponents) ?? now)
        }
        
        let monthData: [MonthData] = monthAnchors.map { date in
            let comps = calendar.dateComponents([.month, .year], from: date)
            let stats = MonthlyStatsHelper.getMonthlyStats(for: comps.month ?? 1, year: comps.year ?? 0, from: surgeries)
            return MonthData(month: date, received: stats.totalPaid, scheduled: stats.totalValue )
        }
        
        // currentMonthPaid for header display
        let currentMonthValue = monthData.last?.scheduled ?? 0
        let currentMonthPaid = monthData.last?.received ?? 0
        
        let showDataBranch = !surgeries.isEmpty && !showingAnesthesiaWizard
        
        Group {
            if showDataBranch {
                VStack(alignment: .leading) {
                    HStack() {
                        Text("Último Semestre")
                            .font(.headline)
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(formatCurrency(currentMonthPaid))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                }
                            }
                            HStack{
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(formatCurrency(currentMonthValue))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                            }
                            HStack {
                                Spacer()
                                Text("Mês atual")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    Chart {
                        ForEach(monthData) { data in
                            BarMark(
                                x: .value("Mês", data.month, unit: .month),
                                y: .value("Recebido", data.scheduled)
                            )
                            .foregroundStyle(
                                calendar.isDate(data.month, equalTo: now, toGranularity: .month)
                                ? .blue
                                : .blue.opacity(0.5)
                            )
                            .position(by: .value("Tipo", "Recebido"))

                            BarMark(
                                x: .value("Mês", data.month, unit: .month),
                                y: .value("Pago", data.received)
                            )
                            .foregroundStyle(
                                calendar.isDate(data.month, equalTo: now, toGranularity: .month)
                                ? .green
                                : .green.opacity(0.5)
                            )
                            .position(by: .value("Tipo", "Pago"))

                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .month)) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.month(.abbreviated))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .frame(height: 170)
                    .padding(.top, 5)
                }
                .padding()
                .glassEffect(in: .rect(cornerRadius: 16))
            } else {
                VStack(alignment: .leading) {
                    ContentUnavailableView {
                        Label("Não há dados financeiros para exibir", systemImage: "chart.bar.xaxis")
                    } actions: {
                        Button("Nova Cirurgia / Anestesia") {
                            showingAnesthesiaWizard = true
                        }
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding()
                .glassEffect(in: .rect(cornerRadius: 16))
            }
        }
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
        
    
}

#Preview("Last12MonthsGraphView") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let cbhpm = CbhpmProcedure.samples(surgeries: surgeries)
    let financial = Financial.samples(surgeries: surgeries)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
    let vitalSigns = VitalSignEntry.samples(anesthesias: anesthesias)
    let medications = MedicationEntry.samples(anesthesias: anesthesias)
    let preanesthesias = PreAnesthesia.samples(
        surgeries: surgeries,
        shared: shared,
        user: user
    )

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
        cbhpm.forEach { context.insert($0) }
        financial.forEach { context.insert($0) }
        preanesthesias.forEach { context.insert($0) }
        vitalSigns.forEach{ context.insert($0) }
        medications.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!
    
    let pre = preanesthesias.randomElement()!

    return NavigationStack {
        Last12MonthsGraphView(surgeries: surgeries)
            .environment(session)
    }
    .modelContainer(container)
}


#Preview("Empty Surgeries") {
    let session = SessionManager()
    session.currentUser = User.sampleUser
    let container = try! ModelContainer(
        for: User.self,
           Patient.self,
           Surgery.self,
           PreAnesthesia.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    return NavigationStack {
        Last12MonthsGraphView(surgeries: [])
            .environment(session)
    }
    .modelContainer(container)
}

