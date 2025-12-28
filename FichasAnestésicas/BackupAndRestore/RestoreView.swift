//
//  RestoreView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 27/12/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct RestoreView: View {
    @State private var showImporter = false
    @State private var showRestartAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Divider()
                    Button {
                        showImporter = true
                    } label: {
                        HStack {
                            Text("Restaurar dados")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    Divider()
                    
                    Text("A restauração do backup irá implementar todas as alterações feitas no backup escolhido.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("Selecione a PASTA que contenha os 3 (três) arquivos de backup")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .fileImporter(
                    isPresented: $showImporter,
                    allowedContentTypes: [.folder]
                ) { result in
                    if case .success(let url) = result {
                        restore(from: url)
                    }
                }
                .alert("Reinicie o App", isPresented: $showRestartAlert) {
                    Button("OK") { }
                } message: {
                    Text("Dados restaurados com sucesso! Feche e abra o app novamente para aplicar as alterações.")
                }
                .alert("Erro", isPresented: $showErrorAlert) {
                    Button("OK") { }
                } message: {
                    Text(errorMessage)
                }
            }
            .background(Color(.tertiarySystemGroupedBackground))
        }
        .navigationTitle("Restaurar Backup")
        .navigationBarTitleDisplayMode(.large)
    }

    func restore(from backupURL: URL) {
        let fileManager = FileManager.default

        guard let destinationURL = fileManager
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .first else {
            errorMessage = "Erro ao localizar diretório de destino"
            showErrorAlert = true
            return
        }

        do {
            // Acesso seguro ao arquivo
            guard backupURL.startAccessingSecurityScopedResource() else {
                errorMessage = "Sem permissão para acessar o arquivo"
                showErrorAlert = true
                return
            }
            defer { backupURL.stopAccessingSecurityScopedResource() }
            
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }

            try fileManager.copyItem(at: backupURL, to: destinationURL)

            showRestartAlert = true
        } catch {
            errorMessage = "Erro ao restaurar: \(error.localizedDescription)"
            showErrorAlert = true
        }
    }
}

#Preview {
    NavigationStack{
        RestoreView()
    }
}
