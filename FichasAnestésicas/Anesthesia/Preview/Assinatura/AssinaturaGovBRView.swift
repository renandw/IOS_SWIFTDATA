//
//  AssinaturaGovBRView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 15/12/25.
//

//
//
import SwiftUI

struct AssinaturaGovBRView: View {
    var nome: String
    var data: Date
    var url: URL = URL(string: "https://validar.iti.gov.br")!
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            GovBRLogo()
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading) {
                    Text("Documento assinado digitalmente")
                        .font(.custom("Arial", size: 11))// próximo do mock
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 4)
                VStack(alignment: .leading) {
                    Text(nome.uppercased())
                        .font(.custom("Arial-BoldMT", size: 10))
                    
                    Text("Data: \(format(data))-0300")
                        .font(.custom("Arial", size: 10))
                    
                    // Link estilizado como texto simples (para copiar/abrir)
                    HStack(spacing: 2) {
                        Text("Verifique em")
                            .font(.custom("Arial", size: 10))
                        Text("https://validar.iti.gov.br")
                            .font(.custom("Arial", size: 10))
                            .tint(.black)
                    }
                }
            }
            .foregroundStyle(Color.black)
        }
        .background(.white)
    }
    
    private func format(_ date: Date) -> String {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "pt_BR")
        cal.timeZone = TimeZone(secondsFromGMT: -3*3600) ?? .current
        
        let f = DateFormatter()
        f.calendar = cal
        f.locale = cal.locale
        f.timeZone = cal.timeZone
        f.dateFormat = "dd/MM/yyyy HH:mm" // ex.: 20/10/2025 16:20:00-03:00
        return f.string(from: date)
    }
}

/// Marca "gov.br" com as cores aproximadas oficiais.
/// g (azul), o (amarelo), v (verde), .br (azul)
private struct GovBRLogo: View {
    // cores aproximadas do guia de marca
    private let azul   = Color(red: 0/255,   green: 120/255,  blue: 180/255) // ~#0061AB
    private let amarelo = Color(red: 255/255, green: 204/255, blue: 0/255)   // ~#FFCC00
    private let verde   = Color(red: 0/255,   green: 197/255, blue: 100/255)  // ~#00A859
    
    var body: some View {
        // usa Texts separados para colorir cada parte
        HStack(spacing: -5) {
            HStack(spacing: -2) {
                Text("g").foregroundStyle(azul)
                Text("o").foregroundStyle(amarelo)
                Text("v").foregroundStyle(verde)
            }
            .font(.custom("Arial-BoldMT", size: 33))
            .baselineOffset(0)
            .accessibilityLabel("gov ponto br")
            
            HStack(spacing: -3) {
                HStack(spacing: -3) {
                    Text(".")
                        .font(.system(size: 27, weight: .black, design: .rounded))
                        .foregroundStyle(azul)
                }
                .baselineOffset(-1)
                .accessibilityLabel("gov ponto br")
                Text("b").foregroundStyle(azul)
                Text("r").foregroundStyle(amarelo)
            }
            .font(.custom("Arial-BoldMT", size: 33))
            .baselineOffset(0)
            .accessibilityLabel("gov ponto br")
        }
    }
}

#Preview {
    // exemplo do print: RENAN DANTAS WROBEL — 20/10/2025 16:20:00-03:00
    let comps = DateComponents(calendar: .current,
                               timeZone: TimeZone(secondsFromGMT: -3*3600),
                               year: 2025, month: 10, day: 20,
                               hour: 16, minute: 20, second: 0)
    let date = comps.date ?? Date()
    
    return AssinaturaGovBRView(
        nome: "RENAN DANTAS WROBEL",
        data: date
    )
   // .previewLayout(.sizeThatFits)
    .padding()
}
