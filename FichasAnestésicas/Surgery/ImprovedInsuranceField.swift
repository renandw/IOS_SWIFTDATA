import SwiftUI

struct InsuranceField: View {
    @Binding var insuranceName: String
    @State private var showSuggestions = false
    @State private var filteredList: [String] = []
    @State private var searchTask: Task<Void, Never>?
    @FocusState private var isFocused: Bool
    
    let insuranceList = ["Unimed", "Bradesco", "Amil", "Sulamerica", "Assefaz",
                        "Astir", "Capesesp", "Cassi", "Funsa", "Fusex", "Geap",
                        "Ipam", "Life", "Saúde Caixa", "Innova", "Particular"]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .center) {
                Text("Convênio")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    TextField("Convênio", text: $insuranceName)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .focused($isFocused)
                        .onChange(of: insuranceName) { _, newValue in
                            handleSearchChange(newValue)
                        }
                        .onChange(of: isFocused) { _, focused in
                            if !focused {
                                showSuggestions = false
                            } else {
                                handleSearchChange(insuranceName)
                            }
                        }
                    
                    if !insuranceName.isEmpty {
                        Button {
                            insuranceName = ""
                            showSuggestions = false
                            filteredList = []
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Limpar convênio")
                    }
                }
                .contentShape(Rectangle())
            }
            .zIndex(0)
            
            if showSuggestions {
                suggestionsView
                    .padding(.top, 36)
                    .zIndex(1)
            }
        }
        .background {
            if showSuggestions {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dismissSuggestions()
                    }
            }
        }
    }
    
    private var suggestionsView: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if filteredList.isEmpty {
                Text("Nenhum resultado")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredList.prefix(8), id: \.self) { name in
                            Button {
                                selectInsurance(name)
                            } label: {
                                HStack {
                                    Spacer()
                                    Text(name)
                                        .foregroundStyle(.primary)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 12)
                                }
                            }
                            .buttonStyle(.plain)
                            .contentShape(Rectangle())
                            .background(Color(.systemBackground))
                            .overlay(
                                Rectangle()
                                    .frame(height: 0.5)
                                    .foregroundStyle(Color.secondary.opacity(0.2)),
                                alignment: .bottom
                            )
                        }
                    }
                }
                .frame(maxHeight: 180)
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.secondary.opacity(0.25), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .transition(.asymmetric(
            insertion: .opacity.combined(with: .move(edge: .top)).combined(with: .scale(scale: 0.95, anchor: .top)),
            removal: .opacity
        ).animation(.spring(response: 0.3, dampingFraction: 0.8)))
    }
    
    private func handleSearchChange(_ value: String) {
        searchTask?.cancel()
        
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmed.count >= 2 else {
            showSuggestions = false
            filteredList = []
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 200_000_000)
            
            guard !Task.isCancelled else { return }
            
            await MainActor.run {
                filteredList = insuranceList.filter {
                    $0.localizedCaseInsensitiveContains(trimmed)
                }
                showSuggestions = isFocused && !filteredList.isEmpty
            }
        }
    }
    
    private func selectInsurance(_ name: String) {
        insuranceName = name
        dismissSuggestions()
        
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
    
    private func dismissSuggestions() {
        showSuggestions = false
        isFocused = false
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var insurance = ""
        
        var body: some View {
            Form {
                InsuranceField(insuranceName: $insurance)
            }
        }
    }
    
    return PreviewWrapper()
}
