import SwiftUI
import SwiftData
import Charts

struct FinancialDashboardView: View {
    let userId: String
    let surgeries: [Surgery]
    
    @Environment(SessionManager.self) var session
    @State private var filters = SurgeryFilters()
    @State private var isFilterSheetPresented = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("Painel Financeiro")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Last12MonthsGraphView(
                        surgeries: surgeries
                    )
                    MonthStatSection(
                        surgeries: surgeries,
                        filters: $filters,
                        isFilterSheetPresented: $isFilterSheetPresented
                    )
                    
                }
                .padding()
                .navigationTitle("Financeiro")
                .navigationBarTitleDisplayMode(.large)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(.tertiarySystemGroupedBackground))
        }
        .toolbar {
            ToolbarItem {
                if filters.hasActiveFilters {
                    Button {
                        isFilterSheetPresented = true
                    } label: {
                        Label("Filtros", systemImage: "magnifyingglass")
                    }
                    .buttonStyle(.glassProminent)
                } else {
                    Button {
                        isFilterSheetPresented = true
                    } label: {
                        Label("Filtros", systemImage: "magnifyingglass")
                    }
                }
            }
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            FilterSheetView(
                filters: $filters,
                showDateFilter: true,
                isFilterSheetPresented: $isFilterSheetPresented
            )
            .presentationDetents([.height(filters.useDateFilter ? 550 : 400), .large])
        }
    }
}


struct MonthStatSection: View {
    let surgeries: [Surgery]
    @Binding var filters: SurgeryFilters
    @Binding var isFilterSheetPresented: Bool
    
    private var hasActiveFilters: Bool {
        filters.hasActiveFilters
    }
    
    var filteredSurgeries: [Surgery] {
        surgeries.filter { surgery in
            (filters.patient.isEmpty || surgery.patient.name.localizedCaseInsensitiveContains(filters.patient)) &&
            (filters.hospital.isEmpty || surgery.hospital.localizedCaseInsensitiveContains(filters.hospital)) &&
            (filters.surgeon.isEmpty || surgery.mainSurgeon.localizedCaseInsensitiveContains(filters.surgeon)) &&
            (filters.insurance.isEmpty || surgery.insuranceName.localizedCaseInsensitiveContains(filters.insurance)) &&
            (!filters.useDateFilter || (surgery.date >= filters.startDate && surgery.date <= filters.endDate))
        }
    }
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    var body: some View {
        let calendar = Calendar.current

        // Agrupa cirurgias por mês/ano (somente meses que têm cirurgias entram no dicionário)
        let groupedByMonth = Dictionary(grouping: surgeries.filter{$0.type == .convenio}) { surgery in
            calendar.date(from: calendar.dateComponents([.year, .month], from: surgery.date)) ?? surgery.date
        }

        // Ordena os meses (mais recente primeiro)
        let sortedMonthDates = groupedByMonth.keys.sorted(by: >)

        return VStack(alignment: .leading, spacing: 16) {
            Text("Estatísticas Mensais:")
                .font(.headline)
                .fontWeight(.semibold)

            ForEach(sortedMonthDates, id: \.self) { monthDate in
                let components = calendar.dateComponents([.month, .year], from: monthDate)
                if let month = components.month, let year = components.year {
                    let stats = getMonthlyStats(for: month, year: year)
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
            VStack(alignment: .leading, spacing: 16) {
                if hasActiveFilters {
                    HStack {
                        Text("Cirurgias")
                            .font(.headline)
                        Spacer()
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass.circle.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                    ForEach(filteredSurgeries) { surgery in
                        HStack{
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(surgery.patient.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    if let financial = surgery.financial {
                                        if financial.paid {
                                            VStack {
                                                HStack {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.green)
                                                    Text("Pago")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.green)
                                                }
                                                if let payDate = financial.paymentDate {
                                                    Text(payDate.formatted(date: .numeric, time: .omitted))
                                                        .font(.caption)
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                        } else {
                                            HStack{
                                                Image(systemName: "exclamationmark.circle.fill")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.orange)
                                                Text("Pendente")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.orange)
                                            }
                                        }
                                    }
                                }
                                
                                HStack {
                                    Text(surgery.proposedProcedure)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                    Text ("-")
                                    Text(surgery.mainSurgeon)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                }
                                
                                Text(surgery.date, style: .date)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Text("Convênio:")
                                        .font(.subheadline)
                                    Text(surgery.insuranceName)
                                        .font(.subheadline)
                                    Spacer()
                                    if let financial = surgery.financial {
                                        Text("\(formatCurrency(financial.finalSurgeryValue ?? 0))")
                                            .font(.footnote)
                                            .fontWeight(.black)
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding(.bottom, 2)
                                
                                Divider()
                                HStack {
                                    HStack(alignment: .top) {
                                        NavButton(title: "Paciente",
                                                  icon: "person.circle",
                                                  destination: PatientDetailsView(patient: surgery.patient))
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        NavButton(title: "Cirurgia",
                                                  icon: "stethoscope.circle",
                                                  destination: SurgeryDetailsView(surgery:surgery))
                                    }
                                    Spacer()
                                    HStack(alignment: .top) {
                                        NavButton(title: "Valores",
                                                  icon: "brazilianrealsign.circle",
                                                  destination: FinancialView(surgery:surgery))
                                    }
                                }
                                .padding(.top, 4)
                                
                            }
                        }
                        .padding()
                        .glassEffect(in: .rect(cornerRadius: 12))
                    }
                } else {
                    HStack {
                        Text("Encontrar Cirurgias")
                            .font(.headline)
                        Spacer()
                        Button {
                            isFilterSheetPresented = true
                        } label: {
                            Label("Filtros", systemImage: "magnifyingglass.circle")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getMonthlyStats(for month: Int, year: Int) -> MonthStats {
        var totalValue: Double = 0
        var totalPaid: Double = 0
        var totalDebts: Double = 0
        var totalOnHold: Double = 0
        
        let calendar = Calendar.current
        
        for surgery in surgeries {
            guard let financial = surgery.financial else { continue }
            
            // Usa a data da cirurgia como referência
            let components = calendar.dateComponents([.month, .year], from: surgery.date)
            
            // Verifica se é do mês e ano corretos
            guard components.month == month && components.year == year else { continue }
            
            // totalValue: soma de valueAnesthesia + valuePreAnesthesia
            let anesthesiaValue = financial.valueAnesthesia ?? 0
            let preAnesthesiaValue = financial.valuePreAnesthesia ?? 0
            totalValue += anesthesiaValue + preAnesthesiaValue
            
            // finalSurgeryValue para este registro
            let surgeryFinalValue = financial.finalSurgeryValue ?? 0
            
            if financial.paid {
                // totalPaid: soma de finalSurgeryValue quando paid == true
                totalPaid += surgeryFinalValue
            } else {
                // totalOnHold: soma de finalSurgeryValue quando paid == false
                totalOnHold += surgeryFinalValue
            }
            
            // totalDebts: soma de taxedValue + glosedAnesthesiaValue + glosedPreAnesthesiaValue
            let taxed = financial.taxedValue ?? 0
            let glosedAnesth = financial.glosedAnesthesiaValue ?? 0
            let glosedPreAnesth = financial.glosedPreAnesthesiaValue ?? 0
            totalDebts += taxed + glosedAnesth + glosedPreAnesth
        }
        
        // finalValue: calcula DEPOIS do loop, quando todos os valores já foram somados
        let finalValue = totalValue - totalDebts
        
        return MonthStats(
            totalValue: totalValue,
            totalPaid: totalPaid,
            totalDebts: totalDebts,
            finalValue: finalValue,
            totalOnHold: totalOnHold
        )
    }
}

// MARK: - Supporting Types

struct MonthStats {
    let totalValue: Double
    let totalPaid: Double
    let totalDebts: Double
    let finalValue: Double
    let totalOnHold: Double
}

struct MonthStatCard: View {
    let icon: String
    let cardName: String
    let title: String
    let stats: MonthStats
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: - HEADER
            HStack(spacing: 10) {
                Spacer()
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(iconColor)

                Text(cardName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                
            }
            Divider()
            
            // MARK: - RECEBIDO (HERÓI)
            HStack {
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pendente")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalOnHold))
                        
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Recebido")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalPaid))
                        
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
               
            }
        
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Faturado")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalValue))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Descontos")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.totalDebts))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Líquido")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text(formatCurrency(stats.finalValue))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .glassEffect(in: .rect(cornerRadius: 16.0))
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}

#Preview {
    MonthStatCard(
        icon: "calendar",
        cardName: "Outubro de 2025",
        title: "Outubro de 2025",
        stats: MonthStats(
            totalValue: 10000,
            totalPaid: 8000,
            totalDebts: 2000,
            finalValue: 8000,
            totalOnHold: 0000,
        ),
        iconColor: .green
    )
}


struct SurgeryFilters {
    var patient = ""
    var hospital = ""
    var surgeon = ""
    var insurance = ""
    var useDateFilter = false
    var startDate = Date()
    var endDate = Date()
    
    var hasActiveFilters: Bool {
        !patient.isEmpty || !hospital.isEmpty ||
        !surgeon.isEmpty || !insurance.isEmpty || useDateFilter
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
                            DatePicker("Data inicial", selection: $filters.startDate, displayedComponents: .date)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            DatePicker("Data final", selection: $filters.endDate, displayedComponents: .date)
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
struct Last12MonthsGraphView: View {
    let surgeries: [Surgery]
    
    struct MonthPointValue: Identifiable {
        let id = UUID()
        let date: Date
        let totalValue: Double
    }
    struct MonthPointPaid: Identifiable {
        let id = UUID()
        let date: Date
        let totalPaid: Double
    }
    
    private func getMonthlyStats(for month: Int, year: Int) -> MonthStats {
        var totalValue: Double = 0
        var totalPaid: Double = 0
        var totalDebts: Double = 0
        var totalOnHold: Double = 0
        
        let calendar = Calendar.current
        
        for surgery in surgeries {
            guard let financial = surgery.financial else { continue }
            
            let components = calendar.dateComponents([.month, .year], from: surgery.date)
            guard components.month == month && components.year == year else { continue }
            
            let anesthesiaValue = financial.valueAnesthesia ?? 0
            let preAnesthesiaValue = financial.valuePreAnesthesia ?? 0
            totalValue += anesthesiaValue + preAnesthesiaValue
            
            let surgeryFinalValue = financial.finalSurgeryValue ?? 0
            
            if financial.paid {
                totalPaid += surgeryFinalValue
            } else {
                totalOnHold += surgeryFinalValue
            }
            
            let taxed = financial.taxedValue ?? 0
            let glosedAnesth = financial.glosedAnesthesiaValue ?? 0
            let glosedPreAnesth = financial.glosedPreAnesthesiaValue ?? 0
            totalDebts += taxed + glosedAnesth + glosedPreAnesth
        }
        
        let finalValue = totalValue - totalDebts
        
        return MonthStats(
            totalValue: totalValue,
            totalPaid: totalPaid,
            totalDebts: totalDebts,
            finalValue: finalValue,
            totalOnHold: totalOnHold
        )
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    var body: some View {
        let calendar = Calendar.current
        let now = Date()
        let currentMonthComponents = calendar.dateComponents([.year, .month], from: now)
        
        // Generate last 12 months anchors (oldest to newest)
        let monthAnchors: [Date] = (0..<6).reversed().compactMap {
            calendar.date(byAdding: .month, value: -$0, to: calendar.date(from: currentMonthComponents) ?? now)
        }
        
        // Create MonthPoints for chart
        let monthPointsValue: [MonthPointValue] = monthAnchors.map { date in
            let comps = calendar.dateComponents([.month, .year], from: date)
            let stats = getMonthlyStats(for: comps.month ?? 1, year: comps.year ?? 0)
            return MonthPointValue(date: date, totalValue: stats.totalValue)
        }
        let monthPointsPaid: [MonthPointPaid] = monthAnchors.map { date in
            let comps = calendar.dateComponents([.month, .year], from: date)
            let stats = getMonthlyStats(for: comps.month ?? 1, year: comps.year ?? 0)
            return MonthPointPaid(date: date, totalPaid: stats.totalPaid)
        }
        
        // currentMonthPaid for header display
        let currentMonthValue = monthPointsValue.last?.totalValue ?? 0
        let currentMonthPaid = monthPointsPaid.last?.totalPaid ?? 0
        
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
                ForEach(monthPointsValue) { point in
                    BarMark(
                        x: .value("Mês", point.date, unit: .month),
                        y: .value("Recebido", point.totalValue)
                    )
                    .foregroundStyle(
                        calendar.isDate(point.date, equalTo: now, toGranularity: .month)
                        ? .blue
                        : .blue.opacity(0.5)
                    )
                    .position(by: .value("Tipo", "Recebido"))
                }
                
                ForEach(monthPointsPaid) { point in
                    BarMark(
                        x: .value("Mês", point.date, unit: .month),
                        y: .value("Pago", point.totalPaid)
                    )
                    .foregroundStyle(
                        calendar.isDate(point.date, equalTo: now, toGranularity: .month)
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
            .frame(height: 200)
            .padding(.top, 5)
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: 16))
    }
}
#Preview("Last12MonthsGraphView") {
    // Minimal preview with empty surgeries; replace with real data as needed
    Last12MonthsGraphView(surgeries: [])
}

