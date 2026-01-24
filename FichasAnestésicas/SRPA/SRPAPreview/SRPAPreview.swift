
//
//  SRPSPreview.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import SwiftUI
import SwiftData


struct SRPAContentView: View {
    @Bindable var srpa: SRPA
    @State private var selectedTab = 0
    
    @State private var showSignature = false
    
    var filenameSRPA: String {
        "Ficha SRPA - \(srpa.surgery.patient.name) - \(srpa.surgery.surgeryId)"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Agora passa uma View normal, não um Group
                
                PDFPreviewView(content: SRPASheetView(srpa: srpa))
                    .environment(\.showSignature, $showSignature)
                
            }
            .navigationTitle("Visualização")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preference(
            key: SRPACustomTopBarButtonPreferenceKey.self,
            value: SRPACustomTopBarButtonPreference(
                id: "Document.preview.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "Document.preview.topbar.buttons.v1.\(srpa.status?.rawValue ?? "none")"
            )
        )
    }
    
    
    func render(showSignature: Bool = false) -> URL {
        let content: AnyView
        
            content = AnyView(
                SRPASheetView(srpa: srpa)
                    .environment(\.showSignature, .constant(showSignature))
            )
        
        
        let renderer = ImageRenderer(content: content)
        renderer.scale = 3.0
        
        let filename = filenameSRPA
        let sanitized = sanitizeFilename(filename)
        let url = URL.documentsDirectory.appending(path: "\(sanitized).pdf")
        
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
    
    func sanitizeFilename(_ s: String) -> String {
        let invalid = CharacterSet(charactersIn: "/\\?%*|\"<>:")
        let cleaned = s
            .components(separatedBy: invalid)
            .joined()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleaned
    }
    
    
    
    private var topBarButtons: some View {
        HStack(spacing: 8) {
            if srpa.status == .finished {
                ShareLink(item: render(showSignature: showSignature)) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20, height: 20)
                }
                .accessibilityLabel("Compartilhar")
                .buttonStyle(.glass)
                .tint(.blue)
            }
            Button(action: {
                showSignature.toggle()
            }) {
                Image(systemName: "signature")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.glass)
        }
    }
}

#Preview("Preview • Para uso em Anesthesia DetailsView") {
    let user = User.sampleUser

    let patients = Patient.samples(createdBy: user)
    let surgeries = Surgery.samples(createdBy: user, patients: patients)
    let cbhpm = CbhpmProcedure.samples(surgeries: surgeries)
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
        preanesthesias.forEach { context.insert($0) }
        vitalSigns.forEach{ context.insert($0) }
        medications.forEach { context.insert($0) }
        try! context.save()
    }

    let anesthesia = anesthesias
        .filter { $0.surgery.preanesthesia != nil }
        .randomElement()!
    

    return NavigationStack {
        ContentUnavailableView("SRPAVitalSigns To be implemented", image: "plus")
            .environment(session)
    }
    .modelContainer(container)
}
