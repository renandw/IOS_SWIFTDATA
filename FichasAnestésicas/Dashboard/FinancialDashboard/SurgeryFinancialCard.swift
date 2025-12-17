//
//  SurgeryFinancialCard.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//


import SwiftUI

struct SurgeryFinancialCard: View {
    let surgery: Surgery
    
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    var body: some View {
        HStack {
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
                            HStack {
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
                    Text("-")
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
                                  destination: SurgeryDetailsView(surgery: surgery))
                    }
                    Spacer()
                    HStack(alignment: .top) {
                        NavButton(title: "Valores",
                                  icon: "brazilianrealsign.circle",
                                  destination: FinancialView(surgery: surgery))
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: 12))
    }
}
