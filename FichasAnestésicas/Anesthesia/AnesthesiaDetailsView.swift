//
//  AnesthesiaDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftUI

struct AnesthesiaDetailsView: View {
    @Bindable var anesthesia: Anesthesia

    var body: some View {
        VStack(alignment: .leading) {
            Text("Método: \(anesthesia.start)")
            Spacer()
        }
        .padding()
        .navigationTitle("Detalhes da Anestesia")
    }
}
