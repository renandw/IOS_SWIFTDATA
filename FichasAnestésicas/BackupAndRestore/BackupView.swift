//
//  BackupView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 27/12/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct BackupView: View {
    @State private var isExporting = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    Divider()
                    Button {
                        exportData()
                    } label: {
                        HStack {
                            if isExporting {
                                ProgressView()
                                    .padding(.trailing, 8)
                            }
                            Text(isExporting ? "Exportando..." : "Criar Backup e Exportar")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(isExporting)
                    
                    Divider()
                    
                    Text("O backup incluirá todos os dados do aplicativo")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
            }
            .background(Color(.tertiarySystemGroupedBackground))

        }
        
        .navigationTitle("Criar e Exportar Backup")
        .navigationBarTitleDisplayMode(.large)
    }

    func exportData() {
        isExporting = true
        
        // Executar em background para não travar a UI
        DispatchQueue.global(qos: .userInitiated).async {
            let fileManager = FileManager.default

            guard let sourceURL = fileManager
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first else {
                showError("Erro ao localizar diretório de dados")
                return
            }

            let destinationURL = fileManager.temporaryDirectory
                .appendingPathComponent("SwiftDataBackup_\(Date().timeIntervalSince1970)", conformingTo: .folder)

            do {
                // Copiar dados
                try fileManager.copyItem(at: sourceURL, to: destinationURL)
                
                // Voltar para a thread principal para apresentar o UIActivityViewController
                DispatchQueue.main.async {
                    presentActivityViewController(with: destinationURL)
                }

            } catch {
                showError("Erro ao criar backup: \(error.localizedDescription)")
            }
        }
    }
    
    func presentActivityViewController(with url: URL) {
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        // Configuração para iPad
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = rootVC.view
                popover.sourceRect = CGRect(x: rootVC.view.bounds.midX,
                                           y: rootVC.view.bounds.midY,
                                           width: 0,
                                           height: 0)
                popover.permittedArrowDirections = []
            }
            
            // Callback quando o usuário completar a ação
            activityVC.completionWithItemsHandler = { _, completed, _, error in
                isExporting = false
                
                if let error = error {
                    showError("Erro ao compartilhar: \(error.localizedDescription)")
                } else if completed {
                    showSuccess()
                } else {
                    // Usuário cancelou
                    isExporting = false
                }
            }
            
            rootVC.present(activityVC, animated: true)
        } else {
            showError("Erro ao apresentar opções de compartilhamento")
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            isExporting = false
            alertTitle = "Erro"
            alertMessage = message
            showAlert = true
        }
    }
    
    func showSuccess() {
        DispatchQueue.main.async {
            alertTitle = "Sucesso"
            alertMessage = "Backup exportado com sucesso!"
            showAlert = true
        }
    }
}

#Preview {
    NavigationStack{
        BackupView()
    }
}
