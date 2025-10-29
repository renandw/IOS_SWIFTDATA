//
//  FichasAneste_sicasApp.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 20/10/25.
//

import SwiftUI
import SwiftData

@main
struct FichasAnestesicasApp: App {
    @State private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .environment(session)
        .modelContainer(for: [User.self, Patient.self, Surgery.self, CbhpmProcedure.self, Financial.self])
    }
}
 
