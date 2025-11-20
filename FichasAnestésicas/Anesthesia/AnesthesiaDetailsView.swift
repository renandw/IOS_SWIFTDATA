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
    @State private var customTitleBarButton: AnyView? = nil

    var body: some View {
        contentSectionView
            .safeAreaInset(edge: .top) {
                headerSection
                    .background(.ultraThinMaterial)
            }
            .navigationTitle("Ficha da Anestésica")
            .navigationBarTitleDisplayMode(.inline)
        .onPreferenceChange(CustomTopBarButtonPreferenceKey.self) { pref in
            customTitleBarButton = pref?.view
        }
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
        .padding(.top, 8)
        .padding(.horizontal, 6)
    }
    
    private var titleSection: some View {
        HStack(spacing: 8) {
            Text(activeSection.sectionTitle)
                .font(.title2).bold()
                .accessibilityAddTraits(.isHeader)
            Spacer()

            if let button = customTitleBarButton {
                button
            } else {
                Color.clear
                    .frame(width: 1, height: 1) // placeholder mínimo
            }
        }
        .frame(minHeight: 44, alignment: .center) // ajuste esse valor à sua UI
        .padding(.horizontal, 16)
    }

    
    private var headerSection: some View {
            VStack(spacing: 16) {
                pickerSection
                titleSection
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
        }
    
    private var contentSectionView: some View {
        SectionContent(
            anesthesia: anesthesia,
            patient: anesthesia.surgery.patient,
            surgery: anesthesia.surgery,
            section: activeSection

        )
        //.padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .id(activeSection)
        
    }
}
struct CustomTopBarButtonPreference: Equatable {
    let id: AnyHashable
    let view: AnyView
    let token: AnyHashable
    
    static func == (lhs: CustomTopBarButtonPreference, rhs: CustomTopBarButtonPreference) -> Bool {
        lhs.id == rhs.id && lhs.token == rhs.token
    }
}

struct CustomTopBarButtonPreferenceKey: PreferenceKey {
    static var defaultValue: CustomTopBarButtonPreference? = nil
    static func reduce(value: inout CustomTopBarButtonPreference?, nextValue: () -> CustomTopBarButtonPreference?) {
        if let next = nextValue() {
            value = next
        }
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
            MedicationsView(anesthesia: anesthesia)
        case .vitalSignsSection:
            VitalSignsView(anesthesia: anesthesia)
        case .descriptionSection:
            AnesthesiaDescriptionView(anesthesia: anesthesia)
        case .previewSection:
            ContentView()
            //ContentUnavailableView("Preview To be implemented", image: "plus")
        }
    }
    
}

//to-do : se anesthesia == nil -> navegar para dashboardview -> proteger subviews em sectioncontent

