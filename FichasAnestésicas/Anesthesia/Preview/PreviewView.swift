import SwiftUI
import SwiftData

struct PDFPreviewView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    func makeUIViewController(context: Context) -> PDFZoomViewController<Content> {
        PDFZoomViewController(content: content)
    }
    
    func updateUIViewController(_ uiViewController: PDFZoomViewController<Content>, context: Context) {}
}

class PDFZoomViewController<Content: View>: UIViewController, UIScrollViewDelegate {
    let content: Content
    private var scrollView: UIScrollView!
    private var hostingController: UIHostingController<Content>!
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura UIScrollView nativo
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 4.0
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bouncesZoom = true
        
        // Adiciona o conteúdo SwiftUI
        hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        scrollView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        view.addSubview(scrollView)
        
        // Duplo toque para zoom
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        //setupToolbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hostingController.view.frame = CGRect(
            origin: .zero,
            size: hostingController.sizeThatFits(in: scrollView.bounds.size)
        )
        scrollView.contentSize = hostingController.view.frame.size
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return hostingController.view
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
       // updateToolbar()
    }
    
    // MARK: - Actions
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1.0 {
            scrollView.setZoomScale(1.0, animated: true)
        } else {
            let point = gesture.location(in: hostingController.view)
            let zoomRect = zoomRect(for: 2.0, withCenter: point)
            scrollView.zoom(to: zoomRect, animated: true)
        }
    }
    
    private func zoomRect(for scale: CGFloat, withCenter center: CGPoint) -> CGRect {
        let size = CGSize(
            width: scrollView.bounds.width / scale,
            height: scrollView.bounds.height / scale
        )
        return CGRect(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
    
    @objc private func resetZoom() {
        scrollView.setZoomScale(1.0, animated: true)
    }
    
    @objc private func zoomIn() {
        let newScale = min(scrollView.zoomScale + 0.5, scrollView.maximumZoomScale)
        scrollView.setZoomScale(newScale, animated: true)
    }
    
    @objc private func zoomOut() {
        let newScale = max(scrollView.zoomScale - 0.5, scrollView.minimumZoomScale)
        scrollView.setZoomScale(newScale, animated: true)
    }
    
    // MARK: - Toolbar (usando UIKit)
    
//    private func setupToolbar() {
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: view.bounds.height - 44, width: view.bounds.width, height: 44))
//        toolbar.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
//        
//        let resetButton = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(resetZoom))
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let zoomLabel = UIBarButtonItem(title: "Zoom: 100%", style: .plain, target: nil, action: nil)
//        zoomLabel.isEnabled = false
//        let zoomInButton = UIBarButtonItem(image: UIImage(systemName: "plus.magnifyingglass"), style: .plain, target: self, action: #selector(zoomIn))
//        let zoomOutButton = UIBarButtonItem(image: UIImage(systemName: "minus.magnifyingglass"), style: .plain, target: self, action: #selector(zoomOut))
//        
//        toolbar.items = [resetButton, flexSpace, zoomLabel, flexSpace, zoomInButton, zoomOutButton]
//        view.addSubview(toolbar)
//    }
//    
//    private func updateToolbar() {
//        // Atualiza o label de zoom na toolbar
//        if let toolbar = view.subviews.compactMap({ $0 as? UIToolbar }).first,
//           let items = toolbar.items,
//           items.count > 2 {
//            items[2].title = "Zoom: \(Int(scrollView.zoomScale * 100))%"
//        }
//    }
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
                // Agora passa uma View normal, não um Group
                if selectedTab == 0 {
                    PDFPreviewView(content: AnesthesiaSheetView(anesthesia: anesthesia))
                        .environment(\.showSignature, $showSignature)
                } else {
                    PDFPreviewView(content: PreanesthesiaSheetView(anesthesia: anesthesia))
                        .environment(\.showSignature, $showSignature)
                }
            }
            .navigationTitle("Previsualização")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preference(
            key: CustomTopBarButtonPreferenceKey.self,
            value: CustomTopBarButtonPreference(
                id: "Document.preview.topbar.buttons",
                view: AnyView(topBarButtons),
                token: "Document.preview.topbar.buttons.v1.\(selectedTab).\(anesthesia.surgery.preanesthesia?.preanesthesiaId ?? "none")"
            )
        )
    }
    
    
    func render(showSignature: Bool = false) -> URL {
        let content: AnyView
        
        if selectedTab == 0 {
            content = AnyView(
                AnesthesiaSheetView(anesthesia: anesthesia)
                    .environment(\.showSignature, .constant(showSignature))
            )
        } else {
            content = AnyView(
                PreanesthesiaSheetView(anesthesia: anesthesia)
                    .environment(\.showSignature, .constant(showSignature))
            )
        }
        
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
            if anesthesia.status == .finished {
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
    
    func renderPreAnesthesia(showSignature: Bool = false) -> URL {
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
        ContentView(anesthesia: anesthesia)
            .environment(session)
    }
    .modelContainer(container)
}
