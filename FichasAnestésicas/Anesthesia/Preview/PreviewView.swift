import SwiftUI

struct PDFPreviewView: View {
    let content: AnyView
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            content
                .scaleEffect(scale)
        }
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = lastScale * value
                }
                .onEnded { _ in
                    lastScale = scale
                    // Limitar o zoom
                    if scale < 0.5 { scale = 0.5; lastScale = 0.5 }
                    if scale > 4.0 { scale = 4.0; lastScale = 4.0 }
                }
        )
        .onTapGesture(count: 2) {
            withAnimation(.spring()) {
                if scale > 1.0 {
                    scale = 1.0
                    lastScale = 1.0
                } else {
                    scale = 2.0
                    lastScale = 2.0
                }
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
    var body: some View {
        NavigationStack {
            PDFPreviewView(content: AnyView(documentContent))
                .navigationTitle("Documento")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        ShareLink("Exportar PDF", item: render())
                    }
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
    
    var documentContent: some View {
        VStack(spacing: 30) {
            Text("Meu Documento")
                .font(.largeTitle)
                .bold()
            
            Text("Este é um exemplo de documento que pode ser visualizado com zoom e depois exportado como PDF.")
                .multilineTextAlignment(.center)
                .padding()
            
            Rectangle()
                .fill(Color.blue.gradient)
                .frame(height: 200)
                .overlay {
                    Text("Conteúdo Visual")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            
            Text("Mais conteúdo aqui...")
                .padding()
        }
        .padding(40)
        .frame(width: 595, height: 842) // Tamanho A4
        .background(Color.white)
    }
    
    func render() -> URL {
        let renderer = ImageRenderer(content: documentContent)
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



