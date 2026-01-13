//
//  ListView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 12/01/26.
//

import SwiftUI

struct ListView: View {
    let title: String
    let patients: [Patient]
    
    var body: some View {
        List {
            Section {
                ForEach(patients, id: \.patientId) { patient in
                    NavigationLink {
                        PatientDetailsView(patient: patient)
                    } label: {
                        PatientRowView(
                            patient: patient,
                            numberCnsContext: .notNeeded,
                            ageContext: .outSurgery
                        )
                    }
                }
            } header: {
                HStack {
                    Text("Pacientes filtrados")
                        .font(.headline)
                }
            }
        }
        .navigationTitle(title)
    }
}

struct SurgeryListView: View {
    let title: String
    let surgeries: [Surgery]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(surgeries, id: \.surgeryId) { surgery in
                    NavigationLink {
                        SurgeryDetailsView(surgery: surgery)
                    } label: {
                        RecentSurgeryCard(surgery: surgery)
                    }
                }
            }
            .padding()
            .navigationTitle(title)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.tertiarySystemGroupedBackground))

    }
}
