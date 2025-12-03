//
//  AnesthesiaSheetView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 02/12/25.
//


import SwiftUI

struct AnesthesiaSheetView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        VStack(spacing: 30) {
            if anesthesia.surgery.preanesthesia != nil {
                Text("\(anesthesia.surgery.patient.name)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.primary)
            }
            Text("Meu Documento")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            
            Text("Este é um exemplo de documento que pode ser visualizado com zoom e depois exportado como PDF.")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.primary)
            
            Rectangle()
                .fill(Color.gray.gradient)
                .frame(height: 200)
                .overlay {
                    Text("Conteúdo Visual")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            
            Text("Mais conteúdo aqui...")
                .padding()
                .foregroundStyle(.primary)
        }
        .padding(40)
        .frame(width: 595, height: 842)
        .background(Color.pink)
    }
}