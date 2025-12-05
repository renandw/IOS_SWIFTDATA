
import SwiftUI

struct DateTimePickerSheetButton: View {
    @Binding var date: Date?
    var title: String
    var placeholder: String = "Selecionar"
    var minDate: Date? = nil
    var maxDate: Date? = nil
    var compactInRow: Bool = true
    var onConfirm: (() -> Void)? = nil
    @State private var showPicker = false
    @State private var tempDate: Date? = nil

    var body: some View {
        Button {
            tempDate = date ?? Date()
            showPicker = true
        } label: {
            Group {
                if compactInRow {
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .foregroundStyle(.secondary)
                        if let d = date {
                            Text(Self.inlineFormatter.string(from: d))
                                .foregroundStyle(.tint)
                                .fontWeight(.semibold)
                        } else {
                            Text(placeholder)
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .contentShape(Rectangle())
                } else {
                    HStack {
                        Text(title)
                        Spacer()
                        if let d = date {
                            Text(Self.inlineFormatter.string(from: d))
                                .foregroundStyle(.tint)
                                .monospacedDigit()
                                .fontWeight(.semibold)
                        } else {
                            Text(placeholder)
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                        }
                    }
                    .font(.body)
                    .padding(.vertical, 6)
                    .contentShape(Rectangle())
                }
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showPicker) {
            NavigationStack {
                VStack {
                    DatePicker(
                        "",
                        selection: Binding<Date>(
                            get: { tempDate ?? date ?? Date() },
                            set: { tempDate = $0 }
                        ),
                        in: (minDate ?? .distantPast)...(maxDate ?? .distantFuture),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: "pt_BR"))
                }
                .navigationTitle(title.isEmpty ? "Selecionar" : title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { showPicker = false }
                            .tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("OK") {
                            if let confirmed = tempDate {
                                date = confirmed
                            }
                            onConfirm?()
                            showPicker = false
                        }
                        .tint(.blue)
                    }
                }
                .padding()
            }
            .presentationDetents([.fraction(0.35)])
            .presentationDragIndicator(.visible)
        }
    }

    static let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    static let inlineFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateFormat = "dd/MM/yyyy HH:mm"
        return f
    }()
}


struct OnlyDatePickerSheetButton: View {
    @Binding var date: Date?
    var title: String
    var placeholder: String = "Selecionar"
    var minDate: Date? = nil
    var maxDate: Date? = nil
    var compactInRow: Bool = true
    var onConfirm: (() -> Void)? = nil
    @State private var showPicker = false
    @State private var tempDate: Date? = nil

    var body: some View {
        Button {
            tempDate = date ?? Date()
            showPicker = true
        } label: {
            Group {
                if compactInRow {
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.secondary)
                        if let d = date {
                            Text(Self.inlineFormatter.string(from: d))
                                .foregroundStyle(.tint)
                                .fontWeight(.semibold)
                        } else {
                            Text(placeholder)
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .contentShape(Rectangle())
                } else {
                    HStack {
                        Text(title)
                        Spacer()
                        if let d = date {
                            Text(Self.inlineFormatter.string(from: d))
                                .foregroundStyle(.tint)
                                .monospacedDigit()
                                .fontWeight(.semibold)
                        } else {
                            Text(placeholder)
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                        }
                    }
                    .font(.body)
                    .padding(.vertical, 6)
                    .contentShape(Rectangle())
                }
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showPicker) {
            NavigationStack {
                VStack {
                    DatePicker(
                        "",
                        selection: Binding<Date>(
                            get: { tempDate ?? date ?? Date() },
                            set: { tempDate = $0 }
                        ),
                        in: (minDate ?? .distantPast)...(maxDate ?? .distantFuture),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: "pt_BR"))
                }
                .navigationTitle(title.isEmpty ? "Selecionar" : title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { showPicker = false }
                            .tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("OK") {
                            if let confirmed = tempDate {
                                date = confirmed
                            }
                            onConfirm?()
                            showPicker = false
                        }
                        .tint(.blue)
                    }
                }
                .padding()
            }
            .presentationDetents([.fraction(0.35)])
            .presentationDragIndicator(.visible)
        }
    }

    static let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()

    static let inlineFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateFormat = "dd/MM/yyyy"
        return f
    }()
}
