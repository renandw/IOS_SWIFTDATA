import SwiftUI

struct PDFPreviewView<Content: View>: View {
    let content: Content
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            ZStack {
                // background do "canvas"
                Color(.tertiarySystemGroupedBackground)

                content
                    .scaleEffect(scale, anchor: .center)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let newScale = lastScale * value
                                scale = min(max(newScale, 0.5), 4.0)
                            }
                            .onEnded { _ in
                                lastScale = scale
                            }
                    )
                    .clipped()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onTapGesture(count: 2) {
            withAnimation(.spring()) {
                let target = scale > 1.0 ? 1.0 : 2.0
                scale = target
                lastScale = target
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    withAnimation(.spring()) {
                        scale = 1.0
                        lastScale = 1.0
                    }
                } label: {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                }
                
                Spacer()
                
                Text("Zoom: \(Int(scale * 100))%")
                    .font(.caption)
                
                Spacer()
                
                Button {
                    withAnimation(.spring()) {
                        scale = min(scale + 0.5, 4.0)
                        lastScale = scale
                    }
                } label: {
                    Label("Zoom In", systemImage: "plus.magnifyingglass")
                }
                
                Button {
                    withAnimation(.spring()) {
                        scale = max(scale - 0.5, 0.5)
                        lastScale = scale
                    }
                } label: {
                    Label("Zoom Out", systemImage: "minus.magnifyingglass")
                }
            }
        }
    }
}

struct ContentView: View {
    @Bindable var anesthesia: Anesthesia
    @State private var selectedTab = 0
    
    @State private var showSignature = false
    
    var filenameAnesthesia: String {
        "Ficha Anestésica - \(anesthesia.surgery.patient.name) - \(anesthesia.surgery.surgeryId)"
    }
    
    var filenamePreAnesthesia: String {
        "Ficha Pré-Anestésica - \(anesthesia.surgery.patient.name) - \(anesthesia.surgery.surgeryId)"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PDFPreviewView(content: Group {
                    if selectedTab == 0 {
                        AnesthesiaSheetView(anesthesia: anesthesia)
                    } else {
                        PreanesthesiaSheetView(anesthesia: anesthesia)
                    }
                })
                .navigationTitle("Documento")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .preference(
            key: CustomTopBarButtonPreferenceKey.self,
            value: CustomTopBarButtonPreference(
                id: "Document.preview.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "Document.preview.topbar.buttons.v1.\(anesthesia.surgery.preanesthesia?.preanesthesiaId ?? "none")"
            )
        )
    }
    
    
    func render() -> URL {
        let content = selectedTab == 0 ? AnyView(AnesthesiaSheetView(anesthesia: anesthesia)) : AnyView(PreanesthesiaSheetView(anesthesia: anesthesia))
        let renderer = ImageRenderer(content: content)
        renderer.scale = 3.0
        
        let filename = selectedTab == 0 ? filenameAnesthesia : filenamePreAnesthesia
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
            
            Picker("", selection: $selectedTab) {
                Text("FA").tag(0)
                if anesthesia.surgery.preanesthesia != nil {
                    Text("APA").tag(1)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            .onChange(of: selectedTab) { oldValue, newValue in
                
                if newValue == 1 && anesthesia.surgery.preanesthesia == nil {
                    selectedTab = 0
                }
            }
            ShareLink(item: render()) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20, height: 20)
            }
            .accessibilityLabel("Compartilhar")
            .buttonStyle(.glass)
            .tint(.blue)
            Button("Assinar", systemImage: "signature") {
                showSignature = true
            }
        }
    }
    
    func renderPreAnesthesia() -> URL {
        let content = AnyView(PreanesthesiaSheetView(anesthesia: anesthesia))
        let renderer = ImageRenderer(content: content)
        renderer.scale = 3.0
        
        let sanitized = sanitizeFilename(filenamePreAnesthesia)
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
}

