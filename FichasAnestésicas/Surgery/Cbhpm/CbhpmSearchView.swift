//
//  CbhpmSearchView.swift
//  FichasAnestésicas
//
//  Created by Claude on 30/10/25.
//

import SwiftUI
import UIKit

struct CbhpmSearchView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedProcedures: [CbhpmCode]
    @State private var searchText = ""
    @State private var showAllSelected = false
    @State private var isKeyboardVisible = false

    private var trimmedQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var hasMinimumQueryLength: Bool {
        trimmedQuery.count >= 3
    }

    private var filteredRows: [SearchRow] {
        guard hasMinimumQueryLength else { return [] }

        let results = CbhpmManager.shared.search(query: trimmedQuery)
        var occurrences: [SelectionKey: Int] = [:]

        return results.map { item in
            let key = selectionKey(for: item)
            let occurrence = occurrences[key, default: 0]
            occurrences[key] = occurrence + 1
            return SearchRow(
                id: SearchRowID(key: key, occurrence: occurrence),
                item: item,
                key: key
            )
        }
    }

    private var selectionSnapshot: SelectionSnapshot {
        var countsByKey: [SelectionKey: Int] = [:]
        var orderedKeys: [SelectionKey] = []
        var firstByKey: [SelectionKey: CbhpmCode] = [:]

        for item in selectedProcedures {
            let key = selectionKey(for: item)
            countsByKey[key, default: 0] += 1
            if firstByKey[key] == nil {
                firstByKey[key] = item
                orderedKeys.append(key)
            }
        }

        let rows: [SelectedRow] = orderedKeys.compactMap { key -> SelectedRow? in
            guard let item = firstByKey[key], let qty = countsByKey[key] else { return nil }
            return SelectedRow(key: key, item: item, qty: qty)
        }

        return SelectionSnapshot(countsByKey: countsByKey, rows: rows)
    }

    var body: some View {
        let selection = selectionSnapshot

        List {
            if filteredRows.isEmpty {
                EmptyStateView(hasMinimumQueryLength: hasMinimumQueryLength)
                    .listRowBackground(Color.clear)
            } else {
                ForEach(filteredRows) { row in
                    ResultRow(
                        item: row.item,
                        qty: selection.countsByKey[row.key],
                        onAdd: { add(row.item) },
                        onRemove: { remove(row.item) }
                    )
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Procedimentos")
        .searchable(text: $searchText, placement: .toolbar, prompt: "Buscar código ou procedimento")
        .safeAreaInset(edge: .bottom) {
            if !isKeyboardVisible {
                SelectionFooter(
                    selectedRows: selection.rows,
                    showAllSelected: $showAllSelected,
                    totalSelectedCount: selectedProcedures.count,
                    onRemoveAll: removeAll,
                    onClearSelection: clearSelection,
                    onCancel: { dismiss() },
                    onConfirm: { dismiss() }
                )
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            isKeyboardVisible = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            isKeyboardVisible = false
        }
    }

    private func selectionKey(for item: CbhpmCode) -> SelectionKey {
        SelectionKey(codigo: item.codigo, procedimento: item.procedimento, porte: item.porte_anestesico)
    }

    private func add(_ item: CbhpmCode) {
        selectedProcedures.append(item)
    }

    private func remove(_ item: CbhpmCode) {
        let key = selectionKey(for: item)
        if let idx = selectedProcedures.lastIndex(where: { selectionKey(for: $0) == key }) {
            selectedProcedures.remove(at: idx)
        }
    }

    private func removeAll(_ item: CbhpmCode) {
        let key = selectionKey(for: item)
        selectedProcedures.removeAll { selectionKey(for: $0) == key }
    }

    private func clearSelection() {
        selectedProcedures.removeAll()
        showAllSelected = false
    }
}

private extension CbhpmSearchView {
    struct SelectionKey: Hashable {
        let codigo: String
        let procedimento: String
        let porte: String
    }

    struct SearchRowID: Hashable {
        let key: SelectionKey
        let occurrence: Int
    }

    struct SearchRow: Identifiable {
        let id: SearchRowID
        let item: CbhpmCode
        let key: SelectionKey
    }

    struct SelectedRow: Identifiable {
        let key: SelectionKey
        let item: CbhpmCode
        let qty: Int

        var id: SelectionKey { key }
    }

    struct SelectionSnapshot {
        let countsByKey: [SelectionKey: Int]
        let rows: [SelectedRow]
    }
}

private struct EmptyStateView: View {
    let hasMinimumQueryLength: Bool

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: hasMinimumQueryLength ? "exclamationmark.magnifyingglass" : "text.magnifyingglass")
                .font(.title2)
                .foregroundStyle(.secondary)
            Text(hasMinimumQueryLength ? "Nenhum procedimento encontrado" : "Inicie a Busca")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(
                hasMinimumQueryLength
                ? "Tente outro código ou nome de procedimento."
                : "Busque por código ou procedimento para começar."
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}

private struct ResultRow: View {
    let item: CbhpmCode
    let qty: Int?
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onAdd) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.procedimento)
                            .font(.subheadline.weight(.semibold))
                            //.lineLimit(1)

                        HStack(spacing: 8) {
                            Text(item.codigo)
                                .font(.caption.weight(.bold))
                                .foregroundStyle(.primary)
                            Text("•")
                                .foregroundStyle(.secondary)
                            Text("Porte \(item.porte_anestesico)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if let qty {
                HStack(spacing: 10) {
                    Button(action: onRemove) {
                        Image(systemName: "minus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Remover procedimento")

                    Text("\(qty)")
                        .font(.headline)
                        .frame(minWidth: 20)

                    Button(action: onAdd) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Adicionar procedimento")
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.secondarySystemBackground))
                .clipShape(Capsule())
            } else {
                Button(action: onAdd) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Adicionar procedimento")
            }
        }
        .padding(.vertical, 4)
    }
}

private struct SelectionFooter: View {
    let selectedRows: [CbhpmSearchView.SelectedRow]
    @Binding var showAllSelected: Bool
    let totalSelectedCount: Int
    let onRemoveAll: (CbhpmCode) -> Void
    let onClearSelection: () -> Void
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            if selectedRows.isEmpty {
                HStack {
                    Image(systemName: "tray")
                    Text("Nenhum procedimento selecionado")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                VStack(spacing: 6) {
                    ForEach(showAllSelected ? selectedRows : Array(selectedRows.prefix(3))) { row in
                        HStack(spacing: 8) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(row.item.procedimento)
                                    .font(.caption.weight(.semibold))
                                    .lineLimit(1)
                                Text("\(row.item.codigo) • Porte \(row.item.porte_anestesico)")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text("x\(row.qty)")
                                .font(.caption.weight(.bold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(Capsule())

                            Button {
                                onRemoveAll(row.item)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.footnote)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Remover todas as unidades")
                        }
                    }

                    if selectedRows.count > 3 {
                        Button(showAllSelected ? "Ver menos" : "Ver todos (\(selectedRows.count))") {
                            showAllSelected.toggle()
                        }
                        .font(.caption.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            HStack {
                Text("Selecionados: \(totalSelectedCount)")
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Button("Limpar") {
                    onClearSelection()
                }
                .font(.subheadline)
                .disabled(selectedRows.isEmpty)
            }

            HStack(spacing: 10) {
                Button("Cancelar") {
                    onCancel()
                }
                .buttonStyle(.glass)

                Button("Confirmar seleção (\(totalSelectedCount))") {
                    onConfirm()
                }
                .buttonStyle(.glassProminent)
                .disabled(selectedRows.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    NavigationStack {
        CbhpmSearchView(selectedProcedures: .constant([]))
    }
}
