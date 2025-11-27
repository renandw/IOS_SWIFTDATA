//
//  ComorbitiesFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 25/11/25.
//
import SwiftUI

struct ComorbitiesFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectionIsPregnantComorbities: [PregnantComorbities]
    @State private var newCustomIsPregnantComorbities = ""
    @Binding var selectionIsInfantComorbities: [InfantComorbities]
    @State private var newCustomIsInfantComorbities = ""
    @Binding var selection: [CardiologicComorbities]
    @State private var newCustomCardiacComorbities = ""
    
    @Bindable var viewModel: PreAnesthesiaViewModel

    var body: some View {
        NavigationStack {
            Form {
                if viewModel.patientSex == .female && viewModel.patientAge > 12 {
                    Section {
                        isPregnant
                        if viewModel.comorbities.isPregnant == true {
                            isPregnantContent
                        }
                    } header: {
                        Text("Gestação")
                    }
                }
                if viewModel.patientAge < 1{
                    Section {
                        isInfant
                        if viewModel.comorbities.isInfant == true {
                            isInfantContent
                        }
                    } header: {
                        Text("Menor de um ano")
                    }
                }
                Section {
                    cardiacComorbities
                    if viewModel.comorbities.cardiacComorbities == true {
                        cardicacComorbitiesContent
                    }
                } header: {
                    Text("Cardíacas")
                }
                Section {
                    respiratoryComorbities
                } header: {
                    Text("Respiratórias")
                }
                Section {
                    endocrinesComorbities
                } header: {
                    Text("Endocrino e Metabólica")
                }
                Section {
                    gastrointestinalComorbities
                } header: {
                    Text("Gastrointestinal")
                }
                Section {
                    hematilogicalComorbities
                } header: {
                    Text("Hematológicas")
                }
                Section {
                    imunologicalComorbities
                } header: {
                    Text("Imunológicas")
                }
                Section {
                    musculoskeletalComorbities
                } header: {
                    Text("Músculoesquelético")
                }
                Section {
                    genitourologicalComorbities
                } header: {
                    Text("Genitourinárias")
                }
                Section {
                    neurologicalComorbities
                } header: {
                    Text("Neurológicas")
                }
                Section {
                    geneticSyndrome
                } header: {
                    Text("Síndromes Genéticas")
                }
            }
            .navigationTitle("Comorbidades")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar", systemImage: "checkmark") {
                        do {
                            try viewModel.save()
                            dismiss()
                        }
                        catch {
                            print("Erro ao salvar AnesthesiaDescriptionEntry: \(error)")
                        }
                    }
                }
            }
        }
    }
    private var isPregnant: some View {
        Toggle(
            "Gestante",
            systemImage: "figure.seated.side.right.child.lap",
            isOn: $viewModel.comorbities.isPregnant
        )
    }
    
    private var isPregnantComorbitiesDetails: [PregnantComorbities] {
        PregnantComorbities.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }
    
    private func togglePregnantComorbities(_ kind: PregnantComorbities) {
        if let idx = selectionIsPregnantComorbities.firstIndex(of: kind) {
            selectionIsPregnantComorbities.remove(at: idx)
        } else {
            selectionIsPregnantComorbities.append(kind)
        }
    }
    
    private var isPregnantContent: some View {
        Group {
            isPregnantAge
            ForEach(isPregnantComorbitiesDetails, id: \.self) { kind in
                Button {
                    togglePregnantComorbities(kind)
                } label: {
                    HStack {
                        Text(kind.displayName)
                        Spacer()
                        if selectionIsPregnantComorbities.contains(kind) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            ForEach(viewModel.comorbities.isPregnantCustomDetails, id: \.self) { name in
                Button {
                    if let index = viewModel.comorbities.isPregnantCustomDetails.firstIndex(of: name) {
                        viewModel.comorbities.removePregnantCustomDetails(at: index)
                    }
                } label: {
                    HStack {
                        Text(name)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
                .foregroundStyle(.primary)
            }
            HStack {
                TextField("Adicionar Comorbidades", text: $newCustomIsPregnantComorbities)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.comorbities.addPregnantCustomDetails(newCustomIsPregnantComorbities)
                        newCustomIsPregnantComorbities = ""
                    }
                if !newCustomIsPregnantComorbities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button {
                        viewModel.comorbities.addPregnantCustomDetails(newCustomIsPregnantComorbities)
                        newCustomIsPregnantComorbities = ""
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                
            }
            if viewModel.comorbities.isPregnantCustomDetails.isEmpty == false || viewModel.comorbities.isPregnantComorbitiesDetails != nil{
                isPregnantDetailsText
            }
        }
    }
    private var isPregnantDetailsText: some View {
        HStack {
            Text("Detalhes")
            TextField(
                "nasc: 32sem, 2d, 1,5kg",
                text: Binding<String>(
                    get: { viewModel.comorbities.isInfantDetailsText ?? "" },
                    set: { newValue in
                        viewModel.comorbities.isPregnantDetailsText = newValue.isEmpty ? nil : newValue
                    }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
    private var isPregnantAge: some View {
        HStack {
            Text("Idade Gestacional")
            TextField(
                "IG: 32 semanas e 3 dias",
                text: Binding<String>(
                    get: { viewModel.comorbities.isPregnantAge ?? "" },
                    set: { newValue in
                        viewModel.comorbities.isPregnantAge = newValue.isEmpty ? nil : newValue
                    }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
    
    
    
    
    
    
    //is infant
    private var isInfant: some View {
        Toggle(
            "Menor de um ano",
            systemImage: "figure.child.circle.fill",
            isOn: $viewModel.comorbities.isInfant
        )
    }
    
    private var isInfantComorbitiesDetails: [InfantComorbities] {
        InfantComorbities.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }
    
    private func toggleInfantComorbities(_ kind: InfantComorbities) {
        if let idx = selectionIsInfantComorbities.firstIndex(of: kind) {
            selectionIsInfantComorbities.remove(at: idx)
        } else {
            selectionIsInfantComorbities.append(kind)
        }
    }
    
    private var isInfantContent: some View {
        Group {
            ForEach(isInfantComorbitiesDetails, id: \.self) { kind in
                Button {
                    toggleInfantComorbities(kind)
                } label: {
                    HStack {
                        Text(kind.displayName)
                        Spacer()
                        if selectionIsInfantComorbities.contains(kind) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            ForEach(viewModel.comorbities.isInfantCustomDetails, id: \.self) { name in
                Button {
                    if let index = viewModel.comorbities.isInfantCustomDetails.firstIndex(of: name) {
                        viewModel.comorbities.removeInfantCustomDetails(at: index)
                    }
                } label: {
                    HStack {
                        Text(name)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
                .foregroundStyle(.primary)
            }
            HStack {
                TextField("Adicionar Comorbidades", text: $newCustomIsInfantComorbities)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.comorbities.addInfantCustomDetails(newCustomIsInfantComorbities)
                        newCustomIsInfantComorbities = ""
                    }
                if !newCustomIsInfantComorbities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button {
                        viewModel.comorbities.addInfantCustomDetails(newCustomIsInfantComorbities)
                        newCustomIsInfantComorbities = ""
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                
            }
            if viewModel.comorbities.isInfantCustomDetails.isEmpty == false || viewModel.comorbities.isInfantComorbitiesDetails != nil{
                isInfantDetailsText
            }
        }
    }
    private var isInfantDetailsText: some View {
        HStack {
            Text("Detalhes")
            TextField(
                "nasc: 32sem, 2d, 1,5kg",
                text: Binding<String>(
                    get: { viewModel.comorbities.isInfantDetailsText ?? "" },
                    set: { newValue in
                        viewModel.comorbities.isInfantDetailsText = newValue.isEmpty ? nil : newValue
                    }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
    
    //Cardiac
    private var cardiacComorbities: some View {
        Toggle(
            "Cardiológicas",
            systemImage: "heart.circle.fill",
            isOn: $viewModel.comorbities.cardiacComorbities
        )
    }
    
    private var cardicacComorbitiesContent: some View {
        Group {
            ForEach(cardiacComorbitiesDetails, id: \.self) { kind in
                Button {
                    toggle(kind)
                } label: {
                    HStack {
                        Text(kind.displayName)
                        Spacer()
                        if selection.contains(kind) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle.dashed")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            ForEach(viewModel.comorbities.cardiacComorbitiesCustomDetails, id: \.self) { name in
                Button {
                    if let index = viewModel.comorbities.cardiacComorbitiesCustomDetails.firstIndex(of: name) {
                        viewModel.comorbities.removeCardiacComorbitiesCustomDetails(at: index)
                    }
                } label: {
                    HStack {
                        Text(name)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
                .foregroundStyle(.primary)
            }
            HStack {
                TextField("Adicionar Comorbidades", text: $newCustomCardiacComorbities)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.comorbities.addCardiacComorbitiesCustomDetails(newCustomCardiacComorbities)
                        newCustomCardiacComorbities = ""
                    }
                if !newCustomIsInfantComorbities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button {
                        viewModel.comorbities.addCardiacComorbitiesCustomDetails(newCustomCardiacComorbities)
                        newCustomCardiacComorbities = ""
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                
            }
            if viewModel.comorbities.cardiacComorbitiesCustomDetails.isEmpty == false || viewModel.comorbities.cardiacComorbitiesDetails != nil{
                cardiacDetailsText
            }
        }
    }
    
    private var cardiacComorbitiesDetails: [CardiologicComorbities] {
        CardiologicComorbities.allCases.sorted { a, b in
            a.displayName.localizedCaseInsensitiveCompare(b.displayName) == .orderedAscending
        }
    }
    
    private func toggle(_ kind: CardiologicComorbities) {
        if let idx = selection.firstIndex(of: kind) {
            selection.remove(at: idx)
        } else {
            selection.append(kind)
        }
    }
    
    private var cardiacDetailsText: some View {
        HStack {
            Text("Detalhes")
            TextField(
                "insuficiência mitral moderada",
                text: Binding<String>(
                    get: { viewModel.comorbities.cardiacComorbitiesDetailsText ?? "" },
                    set: { newValue in
                        viewModel.comorbities.cardiacComorbitiesDetailsText = newValue.isEmpty ? nil : newValue
                    }
                )
            )
            .multilineTextAlignment(.trailing)
        }
    }
    
    private var respiratoryComorbities: some View {
        Toggle(
            "Respiratórias",
            systemImage: "lungs.fill",
            isOn: $viewModel.comorbities.respiratoryComorbities
        )
    }
    private var endocrinesComorbities: some View {
        Toggle(
            "Endócrinas",
            systemImage: "syringe.fill",
            isOn: $viewModel.comorbities.endocrineComorbities
        )
    }
    private var musculoskeletalComorbities: some View {
        Toggle(
            "Musculoesqueléticas",
            systemImage: "figure.run.circle.fill",
            isOn: $viewModel.comorbities.musculoskeletalComorbities
        )
    }
    private var gastrointestinalComorbities: some View {
        Toggle(
            "Gastrointestinais",
            systemImage: "fork.knife.circle.fill",
            isOn: $viewModel.comorbities.gastrointestinalComorbities
        )
    }
    private var hematilogicalComorbities: some View {
        Toggle(
            "Hematológicas",
            systemImage: "ivfluid.bag",
            isOn: $viewModel.comorbities.hematologicalComorbities
        )
    }
    private var imunologicalComorbities: some View {
        Toggle(
            "Imunológicas",
            systemImage: "ivfluid.bag.fill",
            isOn: $viewModel.comorbities.imunologicalComorbities
        )
    }
    private var neurologicalComorbities: some View {
        Toggle(
            "Neurológicas",
            systemImage: "brain.head.profile.fill",
            isOn: $viewModel.comorbities.neurologicalComorbities
        )
    }
    private var genitourologicalComorbities: some View {
        Toggle(
            "Genitourológicas",
            systemImage: "toilet.fill",
            isOn: $viewModel.comorbities.genitourologicalComorbities
        )
    }
    private var geneticSyndrome: some View {
        Toggle(
            "Síndromes Genéticas",
            systemImage: "apple.meditate.circle.fill",
            isOn: $viewModel.comorbities.geneticSyndrome
        )
    }
    
    
    
    
}
