//
//  AnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//

import SwiftData
import SwiftUI

struct AnesthesiaSheetView: View {
    let anesthesia: Anesthesia

    // A4 dimensions in points (72 DPI): 200mm ≈ 567pt, 287mm ≈ 813pt
    private let pageWidth: CGFloat = 567
    private let pageHeight: CGFloat = 813
    private let padding: CGFloat = 28 // 10mm ≈ 28pt

    var body: some View {
        VStack(spacing: 0) {
            // Container with A4 dimensions
            VStack(spacing: 0) {
                AnesthesiaHeaderView(anesthesia: anesthesia)
                AnesthesiaSheetPatientInfoView(anesthesia: anesthesia)
                AnesthesiaSheetMedicationsView(anesthesia: anesthesia)
                AnesthesiaSheetVitalSignsView(anesthesia: anesthesia)
                AnesthesiaSheetDescriptionView(anesthesia: anesthesia)
                AnesthesiaSheetViewTeamAndProcedure(anesthesia: anesthesia)
                Spacer()
                AnesthesiaSheetFooterView(anesthesia: anesthesia)
                //AssinaturaGovBRView(data: data)
            }
            .padding(padding)
            .frame(width: pageWidth, height: pageHeight)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview("Medication • Para uso em Anesthesia DetailsView") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let shared = SharedPreAndAnesthesia.samples(surgeries: surgeries)
    let anesthesias = Anesthesia.samples(surgeries: surgeries, user: user)
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
        preanesthesias.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!


    return NavigationStack {
        AnesthesiaSheetView(anesthesia: anesthesia)
            .environment(session)
    }
    .modelContainer(container)
}
