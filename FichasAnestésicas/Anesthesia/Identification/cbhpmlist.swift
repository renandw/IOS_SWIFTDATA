//
//  cbhpmlist.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/11/25.
//

import SwiftUI

// Protocolo leve para desacoplar o componente do modelo concreto
public protocol CBHPMProcedureDisplayable {
    var code: String { get }
    var procedure: String { get }
    var portString: String { get }
}

public struct CBHPMProceduresList<Procedure: CBHPMProcedureDisplayable>: View {
    private let procedures: [Procedure]

    public init(_ procedures: [Procedure]) {
        self.procedures = procedures
    }

    public var body: some View {
        if procedures.isEmpty {
            Text("Nenhum procedimento selecionado")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        } else {
            // Ordena por porte (portString) decrescente, convertendo para Int
            let sorted = procedures.sorted { (lhs, rhs) in
                let l = Int(lhs.portString) ?? 0
                let r = Int(rhs.portString) ?? 0
                return l > r
            }
            VStack(alignment: .leading, spacing: 8) {
                ForEach(sorted, id: \.code) { p in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Código: \(p.code)")
                            Spacer()
                            Text("Porte: \(p.portString)")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)

                        Text(p.procedure)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true) // permite quebrar em múltiplas linhas
                            .lineLimit(nil)
                    }
                }
            }
        }
    }
}

extension CbhpmProcedure: CBHPMProcedureDisplayable {
    public var portString: String { port }
}

extension CbhpmCode: CBHPMProcedureDisplayable {
    public var code: String { codigo }
    public var procedure: String { procedimento }
    public var portString: String { porte_anestesico }
}

#Preview {
    struct MockProc: CBHPMProcedureDisplayable {
        let code: String
        let procedure: String
        let portString: String
    }

    let samples: [MockProc] = [
        .init(code: "12345", procedure: "Procedimento curto", portString: "3"),
        .init(code: "67890", procedure: "Procedimento com um nome bastante extenso que pode facilmente passar de quinze palavras dependendo da descrição completa utilizada", portString: "5"),
        .init(code: "11111", procedure: "Outro procedimento", portString: "2")
    ]

    return VStack(alignment: .leading, spacing: 12) {
        Text("CBHPM")
            .font(.headline)
        CBHPMProceduresList(samples)
            .padding(.vertical, 8)
    }
    .padding()
}
