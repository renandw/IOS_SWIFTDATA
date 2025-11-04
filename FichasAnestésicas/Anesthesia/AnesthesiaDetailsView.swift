//
//  AnesthesiaDetailsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 01/11/25.
//

import Foundation
import SwiftUI

enum anesthesiaDetailsSection: Int, CaseIterable, Hashable {
    case identificationSection, apaSection, medicationsSection, vitalSignsSection, descriptionSection, previewSection

    var sectionTitle: String {
        switch self {
        case .identificationSection:    return "Identificação"
        case .apaSection:               return "A. Pré-Anestésica"
        case .medicationsSection:       return "Medicações"
        case .vitalSignsSection:        return "Sinais Vitais"
        case .descriptionSection:       return "Descrição Anestésica"
        case .previewSection:           return "Pré-Visualização"
        }
    }

    var sectionIcon: String {
        switch self {
        case .identificationSection:    return "person.text.rectangle"
        case .apaSection:               return "doc.text.magnifyingglass"
        case .medicationsSection:       return "pills"
        case .vitalSignsSection:        return "waveform.path.ecg"
        case .descriptionSection:       return "square.and.pencil"
        case .previewSection:           return "eye"
        }
    }
}



struct AnesthesiaDetailsView: View {
    @Bindable var anesthesia: Anesthesia
    
    @Environment(SessionManager.self) var session
    
    @State private var activeSection: anesthesiaDetailsSection = .identificationSection

    var body: some View {
        VStack(alignment: .leading) {
            headerSection
            contentSectionView
        }
        .padding()
        .navigationTitle("Detalhes da Anestesia")
    }
    
    
    private var pickerSection: some View {
        Picker("Secção", selection: $activeSection) {
            ForEach(anesthesiaDetailsSection.allCases, id: \.self) { section in
                Image(systemName: section.sectionIcon)
                    .tag(section)
                    .accessibilityLabel(section.sectionTitle)
            }
        }
        .pickerStyle(.segmented)
        .tint(.indigo)
        .padding(.horizontal, 6)
    }
    
    private var titleSection: some View {
        HStack(spacing: 8) {
            Text(activeSection.sectionTitle)
                .font(.title2).bold()
                .accessibilityAddTraits(.isHeader)
            Spacer()
// to be implemented with PreferenceKey
//            if let button = customTopBarButton {
//                button
//            }
        }
        .padding(.horizontal, 16)
    }
    
    private var headerSection: some View {
            VStack(spacing: 16) {
                pickerSection
                titleSection
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
    
    private var contentSectionView: some View {
        SectionContent(
            anesthesia: anesthesia,
            patient: anesthesia.surgery.patient,
            surgery: anesthesia.surgery,
            section: activeSection

        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .id(activeSection)
        
    }
}

struct SectionContent: View {
    @Bindable var anesthesia: Anesthesia
    let patient: Patient
    let surgery: Surgery
    let section: anesthesiaDetailsSection
    
    var body: some View {
        switch section {
        case .identificationSection:
            IdentificationView(anesthesia: anesthesia, patient: patient, surgery: surgery, ageContext: .inSurgery(surgery))
        case .apaSection:
            ContentUnavailableView("APA To be implemented", image: "plus")
        case .medicationsSection:
            ContentUnavailableView("Medication To be implemented", image: "plus")
        case .vitalSignsSection:
            ContentUnavailableView("VitalSignsTo be implemented", image: "plus")
        case .descriptionSection:
            ContentUnavailableView("Description To be implemented", image: "plus")
        case .previewSection:
            ContentUnavailableView("Preview To be implemented", image: "plus")
        }
    }
}
