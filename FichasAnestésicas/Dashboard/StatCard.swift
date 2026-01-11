//
//  StatCard.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 14/11/25.
//
import SwiftUI

struct StatCard: View {
    let icon: String
    let cardName: String
    let title: String
    let secondaryTitle: String
    let tertiaryTitle: String
    let value: String
    let secondaryValue: String
    let tertiaryValue: String
    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text(cardName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(value)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(secondaryTitle)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(secondaryValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                    
                    
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(tertiaryTitle)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(tertiaryValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(16)
        .glassEffect(in: .rect(cornerRadius: 16.0))
        .contentShape(Rectangle())
    }
}

struct StatisticsSection: View {
    let anesthesias: [Anesthesia]
    let preanesthesias: [PreAnesthesia]
    let surgeries: [Surgery]
    var onPatientsTapped: (() -> Void)? = nil
    var onAnesthesiasTapped: (() -> Void)? = nil
    var onFinancialTapped: (() -> Void)? = nil
    var onSurgeryTapped: (() -> Void)? = nil

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

    private var patientCurrentMonthCount: Int {
        let (start, end) = monthBounds
        return anesthesias.filter { anesthesia in
            guard let anesthesiaStart = anesthesia.start else { return false }
            return anesthesiaStart >= start && anesthesiaStart <= end
        }
        .map { ObjectIdentifier($0.surgery.patient as AnyObject) }
        .reduce(into: Set<ObjectIdentifier>()) { $0.insert($1) }
        .count
    }

    private var patientPreviousMonthCount: Int {
        let (start, end) = previousMonthBounds
        return anesthesias.filter { anesthesia in
            guard let anesthesiaStart = anesthesia.start else { return false }
            return anesthesiaStart >= start && anesthesiaStart <= end
        }
        .map { ObjectIdentifier($0.surgery.patient as AnyObject) }
        .reduce(into: Set<ObjectIdentifier>()) { $0.insert($1) }
        .count
    }
    private var anesthesiaCurrentMonthCount: Int {
        let (start, end) = monthBounds
        return anesthesias.filter { anesthesia in
            guard let anesthesiaStart = anesthesia.start else { return false }
            return anesthesiaStart >= start && anesthesiaStart <= end
        }
        .count
    }
    private var anesthesiaPreviousMonthCount: Int {
        let (start, end) = previousMonthBounds
        return anesthesias.filter { anesthesia in
            guard let anesthesiaStart = anesthesia.start else { return false }
            return anesthesiaStart >= start && anesthesiaStart <= end
        }
        .count
    }
    
    private var surgeryCurrentMonthCount: Int {
        let (start, end) = monthBounds
        return surgeries.filter { surgery in
            surgery.date >= start && surgery.date <= end
        }
        .count
    }
    
    private var surgeryPreviousMonthCount: Int {
        let (start, end) = previousMonthBounds
        return surgeries.filter { surgery in
            surgery.date >= start && surgery.date <= end
        }
        .count
    }
    
    private var surgeryTotalCount: Int {
        surgeries.count
    }
    
    private var preAnesthesiaCurrentMonthCount: Int {
        let (start, end) = monthBounds
        return preanesthesias.filter { preanesthesias in
            preanesthesias.surgery.date >= start && preanesthesias.surgery.date <= end
        }
        .count
    }
    
    private var preAnesthesiaPreviousMonthCount: Int {
        let (start, end) = previousMonthBounds
        return preanesthesias.filter { preanesthesia in
            preanesthesia.surgery.date >= start && preanesthesia.surgery.date <= end
        }
        .count
    }
    
    private var preAnesthesiaTotalCount: Int {
        preanesthesias.count
    }

    private var patientTotalCount: Int {
        anesthesias
            .map { ObjectIdentifier($0.surgery.patient as AnyObject) }
            .reduce(into: Set<ObjectIdentifier>()) { $0.insert($1) }
            .count
    }
    
    private var anesthesiaTotalCount: Int {
        anesthesias.count
    }
    
    
    
    private var anesthesiaFinalSurgeryValueCurrentMonthCount: Double {
        let (start, end) = monthBounds
        return anesthesias
            .filter { anesthesia in
                guard let anesthesiaStart = anesthesia.start else { return false }
                return anesthesiaStart >= start && anesthesiaStart <= end
            }
            .compactMap { $0.surgery.financial?.finalSurgeryValue }
            .reduce(0, +)
    }

    private var anesthesiaFinalSurgeryValuePreviousMonthCount: Double {
        let (start, end) = previousMonthBounds
        return anesthesias
            .filter { anesthesia in
                guard let anesthesiaStart = anesthesia.start else { return false }
                return anesthesiaStart >= start && anesthesiaStart <= end
            }
            .compactMap { $0.surgery.financial?.finalSurgeryValue }
            .reduce(0, +)
    }

    private var anesthesiaFinalSurgeryValueCurrentYear: Double {
        let cal = Calendar.current
        let yearStart = cal.date(from: cal.dateComponents([.year], from: now)) ?? now
        let yearEnd = cal.date(byAdding: .year, value: 1, to: yearStart)
            .map { cal.date(byAdding: .second, value: -1, to: $0) ?? $0 } ?? now
        
        return anesthesias
            .filter { anesthesia in
                guard let anesthesiaStart = anesthesia.start else { return false }
                return anesthesiaStart >= yearStart && anesthesiaStart <= yearEnd
            }
            .compactMap { $0.surgery.financial?.finalSurgeryValue }
            .reduce(0, +)
    }
    
    

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Estatísticas")
                .font(.title3)
                .fontWeight(.semibold)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                Button(action: { onPatientsTapped?() }) {
                    StatCard(
                        icon: "person.2.fill",
                        cardName: "Pacientes",
                        title: "Neste mês",
                        secondaryTitle: "Anterior",
                        tertiaryTitle: "Total",
                        value: String(patientCurrentMonthCount),
                        secondaryValue: String(patientPreviousMonthCount),
                        tertiaryValue: String(patientTotalCount),
                        iconColor: .blue
                    )
                    
                }
                .buttonStyle(.plain)
                
                Button(action: { onAnesthesiasTapped?() }) {
                    StatCard(
                        icon: "syringe.fill",
                        cardName: "Anestesias",
                        title: "Neste mês",
                        secondaryTitle: "Anterior",
                        tertiaryTitle: "Total",
                        value: String(anesthesiaCurrentMonthCount),
                        secondaryValue: String(anesthesiaPreviousMonthCount),
                        tertiaryValue: String(anesthesiaTotalCount),
                        iconColor: .purple
                    )
                    
                }
                .buttonStyle(.plain)
                
                Button(action: { onSurgeryTapped?() }) {
                    StatCard(
                        icon: "cross.fill",
                        cardName: "Cirurgias",
                        title: "Neste mês",
                        secondaryTitle: "Anterior",
                        tertiaryTitle: "Total",
                        value: String(surgeryCurrentMonthCount),
                        secondaryValue: String(surgeryPreviousMonthCount),
                        tertiaryValue: String(surgeryTotalCount),
                        iconColor: .green
                    )
                    
                }
                .buttonStyle(.plain)
                
                Button(action: { onFinancialTapped?() }) {
                    StatCard(
                        icon: "stethoscope",
                        cardName: "Pré-Anestesias",
                        title: "Neste mês",
                        secondaryTitle: "Anterior",
                        tertiaryTitle: "Total",
                        value: String(preAnesthesiaCurrentMonthCount),
                        secondaryValue: String(preAnesthesiaPreviousMonthCount),
                        tertiaryValue: String(preAnesthesiaTotalCount),
                        iconColor: .purple
                    )
                    
                }
                .buttonStyle(.plain)
            }
        }
    }
}

