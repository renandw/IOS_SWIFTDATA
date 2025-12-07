//
//  PdfExporterHelper.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 06/12/25.
//

import SwiftUI

extension Anesthesia {
    @MainActor
    func renderAnesthesiaPDF() -> URL {
        renderPDF(
            content: AnesthesiaSheetView(anesthesia: self),
            filename: "Ficha Anestésica - \(surgery.patient.name) - \(surgery.surgeryId)"
        )
    }
    @MainActor
    func renderPreAnesthesiaPDF() -> URL {
        renderPDF(
            content: PreanesthesiaSheetView(anesthesia: self),
            filename: "Ficha Pré-Anestésica - \(surgery.patient.name) - \(surgery.surgeryId)"
        )
    }
    @MainActor
    private func renderPDF<Content: View>(content: Content, filename: String) -> URL {
        let renderer = ImageRenderer(content: content)
        renderer.scale = 3.0
        
        let sanitized = sanitizeFilename(filename)
        let url = URL.documentsDirectory.appending(path: "\(sanitized).pdf")
        
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
    @MainActor
    private func sanitizeFilename(_ s: String) -> String {
        let invalid = CharacterSet(charactersIn: "/\\?%*|\"<>:")
        return s.components(separatedBy: invalid).joined().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

