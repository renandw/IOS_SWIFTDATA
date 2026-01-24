//
//  SRPAFormView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import SwiftUI
import Observation

struct SRPAFormView: View {
    enum Mode {
        case standalone
        case wizard
        case onlyTime
        case onlyDescription
    }

    @Bindable var viewModel: SRPAFormViewModel
    @Environment(\.dismiss) private var dismiss

    // MARK: - Bindings
    private var surgeryDate: Date { viewModel.surgeryDate }

    // Modo de funcionamento da view (padrão mantém comportamento atual)
    var mode: Mode = .standalone

    var body: some View {
        switch mode {
        case .standalone:
            standaloneBody
        case .wizard:
            wizardBody
        case .onlyTime:
            onlyTimeBody
        case .onlyDescription:
            onlyDescriptionBody
        }
    
    }

    // Conteúdo básico do formulário (seções)
    private var formContent: some View {
        Form {
            Section {
                HStack {
                    Text("Fim da cirurgia")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text((viewModel.surgeryEnd ?? Date()).formatted(date: .numeric, time: .shortened))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Fim da anestesia")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text((viewModel.anesthesiaEnd ?? Date()).formatted(date: .numeric, time: .shortened))
                        .fontWeight(.semibold)
                }
            } header : {
                HStack {
                    Text("Horários")
                    Spacer()
                }
            }
            Section{
                HStack {
                    Text("Início SRPA")
                    Spacer()
                    HStack{
                        DateTimePickerSheetButton(
                            date: $viewModel.srpaStart,
                            title: "Início da SPRA",
                            placeholder: "Selecionar"
                        )
                        if viewModel.srpaStart != nil {
                            Button(role: .destructive) {
                                viewModel.srpaStart = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar início da SRPA")
                        }
                    }
                }
            } header: {
                VStack(alignment: .leading){
                    Text("Início da Recuperação Anestésica")
                    VStack(alignment: .leading) {
                        if let e = viewModel.srpaStartError {
                            Text(e)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            
            if viewModel.srpa != nil {
                Section {
                    HStack {
                        Text("SRPA")
                        Spacer()
                        HStack {
                            DateTimePickerSheetButton(
                                date: $viewModel.srpaEnd,
                                title: "Fim da SRPA",
                                placeholder: "Selecionar"
                            )
                            
                            if viewModel.srpaEnd != nil {
                                Button(role: .destructive) {
                                    viewModel.srpaEnd = nil
                                } label: {
                                    Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel("Limpar fim da SRPA")
                            }
                        }
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text("Fim do SRPA")
                        VStack(alignment: .leading) {
                            if let e = viewModel.srpaEndError {
                                Text(e)
                                    .font(.footnote)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Status")
                        Spacer()
                        Picker("Status", selection: $viewModel.status) {
                            Text("Selecionar").tag(Status?.none)
                            ForEach(Array(Status.allCases), id: \.self) { s in
                                Text(s.displayName).tag(Status?.some(s))
                            }
                        }
                        .pickerStyle(.menu)
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text("Status de Conclusão")
                    }
                }
            }

            // ASA (classificação)
            Section {
                let asa = viewModel.asa.map { String(describing: $0) } ?? ""
                let techniques = ((viewModel.techniques).map(\.displayName).joined(separator: ", "))
                HStack {
                    Text("ASA")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(asa)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Técnicas")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(techniques)
                        .fontWeight(.semibold)
                }
            } header: {
                HStack {
                    Text("ASA e Técnicas Anestésicas")
                }
            }

            // Erros
            if let error = viewModel.errorMessage {
                Section { Text(error).foregroundStyle(.red) }
            }
        }
    }
    
    private var onlyTimeFormContent: some View {

        Form {
            Section{
                HStack {
                    Text("Início SRPA")
                    Spacer()
                    HStack{
                        DateTimePickerSheetButton(
                            date: $viewModel.srpaStart,
                            title: "Início da SPRA",
                            placeholder: "Selecionar"
                        )
                        if viewModel.srpaStart != nil {
                            Button(role: .destructive) {
                                viewModel.srpaStart = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Limpar início da SRPA")
                        }
                    }
                }
            } header: {
                VStack(alignment: .leading){
                    Text("Início da Recuperação Anestésica")
                    VStack(alignment: .leading) {
                        if let e = viewModel.srpaStartError {
                            Text(e)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            
            
            if viewModel.srpa != nil {
                Section {
                    HStack {
                        Text("Fim da SRPA")
                        Spacer()
                        HStack {
                            DateTimePickerSheetButton(
                                date: $viewModel.srpaEnd,
                                title: "Fim da SRPA",
                                placeholder: "Selecionar"
                            )
                            
                            if viewModel.srpaEnd != nil {
                                Button(role: .destructive) {
                                    viewModel.srpaEnd = nil
                                } label: {
                                    Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel("Limpar fim da SRPA")
                            }
                        }
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text("Fim do SRPA")
                        VStack(alignment: .leading) {
                            if let e = viewModel.srpaEndError {
                                Text(e)
                                    .font(.footnote)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    private var onlyDescriptionContent: some View {
        Form {
            Section(header: Text("Descrição")) {
                let binding = Binding<String>(
                    get: { viewModel.descriptionText ?? "" },
                    set: { viewModel.descriptionText = $0.isEmpty ? nil : $0 }
                )
                TextEditor(text: binding)
                    .frame(minHeight: 220)          // altura do campo
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3))
                    )

            }
            Section{
                Button("Descrição Padrão") {
                    viewModel.descriptionText = """
                    O2 complementar se SatO2 < 92%
                    SSVV
                    
                    Aldrete-Kroulik
                    Chegada                 Saída
                    Atividade: 1            Atividade: 2
                    Respiração: 2           Respiração: 2
                    Circulação: 2           Circulação: 2
                    Consciência: 1          Consciência: 2
                    Saturação: 2            Saturação: 2
                    Total: 8                Total: 10
                    
                    """
                }
            }
        }
    }
    
    

    // Form com validações reativas compartilhadas entre modos
    private var baseForm: some View {
        formContent
            .onChange(of: viewModel.srpaStart) { _, _ in
                viewModel.touched["srpaStart"] = true
                viewModel.validateSRPAStart()
                viewModel.updateSuggestionsForStart()  // ← Adicionar
            }
            .onChange(of: viewModel.srpaEnd) { _, _ in
                viewModel.touched["srpaEnd"] = true
                viewModel.validateSRPAEnd()
                viewModel.updateSuggestionsForEnd()  // ← Adicionar
            }
                
            .onChange(of: viewModel.techniques) { _, _ in
                viewModel.touched["techniques"] = true
                viewModel.validateAnesthesiaTechnique()
            }
            .onChange(of: viewModel.asa) { _, _ in
                viewModel.touched["asa"] = true
                viewModel.validateASA()
            }
    }
    
    private var onlyTime: some View {
        onlyTimeFormContent
            .onChange(of: viewModel.srpaStart) { _, _ in
                viewModel.touched["srpaStart"] = true
                viewModel.validateSRPAStart()
                viewModel.updateSuggestionsForStart()  // ← Adicionar
            }
            .onChange(of: viewModel.srpaEnd) { _, _ in
                viewModel.touched["SRPAEnd"] = true
                viewModel.validateSRPAEnd()
                viewModel.updateSuggestionsForEnd()  // ← Adicionar
            }
    }
    

    // Modo standalone: com NavigationStack, título e toolbar (Excluir / Salvar)
    private var standaloneBody: some View {
        NavigationStack {
            baseForm
                .navigationTitle(viewModel.srpa == nil ? "Nova SRPA" : "Editar SRPA")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Excluir", systemImage: "trash", role: .destructive) {
                            viewModel.delete()
                            dismiss()
                        }
                        .disabled(viewModel.srpa == nil)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark") {
                            if viewModel.save() {
                                dismiss()
                            }
                        }
                        .disabled(!viewModel.isFormValid)
                    }
                }
        }
    }

    // Modo wizard: apenas o formulário, sem NavigationStack nem toolbar própria
    private var wizardBody: some View {
            baseForm
    }
    
    private var onlyTimeBody: some View {
        NavigationStack {
            onlyTime
                .navigationTitle(viewModel.srpa == nil ? "Nova SRPA" : "Editar SRPA")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark") {
                            if viewModel.save() {
                                dismiss()
                            }
                        }
                        .disabled(!viewModel.isFormValid)
                    }
                }
        }
    }
    private var onlyDescriptionBody: some View {
        NavigationStack {
            onlyDescriptionContent
                .navigationTitle(viewModel.srpa == nil ? "Nova SRPA" : "Editar SRPA")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark") {
                            if viewModel.save() {
                                dismiss()
                            }
                        }
                        .disabled(!viewModel.isFormValid)
                    }
                }
        }
    }
}

