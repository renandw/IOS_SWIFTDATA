//
//  SurgeryFinancialCard.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 17/12/25.
//


import SwiftUI
import SwiftData

struct SurgeryFinancialCard: View {
    let surgery: Surgery

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

#Preview("Lista com samples") {
    let user = User.sampleUser
    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let financial = Financial.samples(surgeries: surgeries)
    let anesthesia = Anesthesia.samples(surgeries: surgeries, user: user)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let preanesthesia = PreAnesthesia.samples(surgeries: surgeries, shared: shared, user: user)


    let session = SessionManager()
    session.currentUser = user

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self, Patient.self, Surgery.self,
        configurations: config
    )
    let context = container.mainContext

    // Preload uma única vez
    if try! context.fetch(FetchDescriptor<User>()).isEmpty {
        context.insert(user)
        patients.forEach { context.insert($0) }
        surgeries.forEach { context.insert($0) }
        financial.forEach { context.insert($0) }
        anesthesia.forEach { context.insert($0) }
        preanesthesia.forEach { context.insert($0) }
        try! context.save()
    }

    // Escolhe um paciente aleatório
    let randomPatient = patients.randomElement()!

    // Filtra apenas cirurgias do paciente aleatório que possuem anesthesia
    let surgeriesWithAnesthesiaForPatient = surgeries.filter { $0.patient.id == randomPatient.id && $0.anesthesia != nil }

    // Se o paciente não tiver cirurgias com anesthesia, tenta globalmente
    let surgeriesWithAnesthesia = surgeries.filter { $0.anesthesia != nil }

    // Escolhe uma cirurgia com anesthesia (primeiro do paciente, senão global)
    guard let randomSurgery = (surgeriesWithAnesthesiaForPatient.randomElement() ?? surgeriesWithAnesthesia.randomElement()) else {
        fatalError("Nenhuma cirurgia com anesthesia disponível nas amostras do preview.")
    }

    return NavigationStack {
        SurgeryFinancialCard(surgery: randomSurgery)
            .environment(session)
    }
    .modelContainer(container)
}
