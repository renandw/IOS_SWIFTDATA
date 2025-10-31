//
//  CbhpmManager.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/10/25.
//


//
//  CbhpmManager.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import Foundation

@MainActor
final class CbhpmManager {
    static let shared = CbhpmManager()
    
    private var codes: [CbhpmCode] = []
    
    private init() {
        loadCodes()
    }
    
    func getCodes() -> [CbhpmCode] {
        return codes
    }
    
    func search(query: String) -> [CbhpmCode] {
        guard !query.isEmpty else { return codes }
        
        let normalized = normalize(query)
        return codes.filter {
            normalize($0.codigo).contains(normalized) ||
            normalize($0.procedimento).contains(normalized)
        }
    }
    
    private func normalize(_ text: String) -> String {
        text.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .components(separatedBy: CharacterSet.punctuationCharacters)
            .joined()
    }
    
    private func loadCodes() {
        guard let url = Bundle.main.url(forResource: "cbhpm_codes", withExtension: "json") else {
            print("❌ cbhpm_codes.json não encontrado")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            codes = try JSONDecoder().decode([CbhpmCode].self, from: data)
            print("✅ Carregados \(codes.count) códigos CBHPM")
        } catch {
            print("❌ Erro ao decodificar JSON: \(error)")
        }
    }
}