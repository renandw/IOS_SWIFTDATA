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
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Documentos", selection: $selectedTab) {
                    Text("Documento 1").tag(0)
                    Text("Documento 2").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
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
                id: "Share.preview.topbar.buttons",
                view: AnyView(
                    ShareLink(item: render()) {
                        Label("Compartilhar", systemImage: "square.and.arrow.up")
                    }
                ),
                token: "Share.preview.topbar.buttons.v1"
            )
        )
    }
    
    
    func render() -> URL {
        let content = selectedTab == 0 ? AnyView(AnesthesiaSheetView(anesthesia: anesthesia)) : AnyView(PreanesthesiaSheetView(anesthesia: anesthesia))
        let renderer = ImageRenderer(content: content)
        renderer.scale = 3.0
        
        let url = URL.documentsDirectory.appending(path: "document.pdf")
        
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

