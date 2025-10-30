//
//  SurgeryDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 29/10/25.
//
import SwiftData
import SwiftUI

struct SurgeryDetailsView: View {
    @Bindable var surgery: Surgery

    var body: some View {
        VStack(alignment: .leading) {
            Text("Tipo: \(surgery.type)")
            Text("Criado por: \(surgery.createdBy.name)")
            Text("Data: \(surgery.date.formatted(date: .abbreviated, time: .omitted))")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detalhes da Cirurgia")
    }
}

