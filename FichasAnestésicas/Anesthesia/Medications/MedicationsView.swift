//
//  MedicationsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 05/11/25.
//

import SwiftUI

struct MedicationsView: View {
    @Environment(SessionManager.self) var session
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var anesthesia: Anesthesia
    @State private var showingForm = false
    
    
    var body: some View {
        ScrollView {
            Button("Adicionar Medicação", systemImage: "plus") {
                showingForm = true
            }
            .buttonStyle(.glassProminent)
            .sheet(isPresented: $showingForm) {
                if let currentUser = session.currentUser {
                    let viewModel = MedicationsFormViewModel(
                        anesthesia: anesthesia,
                        user: currentUser,
                        context: modelContext
                    )
                    NavigationStack{
                        MedicationsFormView(
                            viewModel: viewModel,
                            catalog: MedicationsHelper.allMedications
                        )
                    }
                }
            }
            
            Text("Medicações: \(anesthesia.medications.count)")
            
            
            ForEach(anesthesia.medications) { medication in
                VStack {
                    HStack {
                        Text("\(medication.name),")
                        Text("\(medication.dose),")
                        Text("\(medication.category.label),")
                        Text("\(medication.via.label),")
                        Text("\(medication.timestamp.formatted(date: .omitted, time: .shortened))")
                    }
                    
                }
            }
        }
    }
}
