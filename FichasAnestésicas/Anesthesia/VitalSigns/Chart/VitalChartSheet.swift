//
//  VitalChartSheet.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 18/11/25.
//


import SwiftUI
import Charts

/// Sheet que apresenta o gráfico de sinais vitais em tela cheia
struct VitalChartSheet: View {
    @Environment(\.dismiss) private var dismiss
    let anesthesia: Anesthesia
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VitalChartContent(anesthesia: anesthesia)
                    .padding()
            }
            .navigationTitle("Gráfico de Sinais Vitais")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

/// Conteúdo do gráfico com legenda
private struct VitalChartContent: View {
    let anesthesia: Anesthesia
    
    private var data: [VitalPoint] {
        anesthesia.vitalSigns.toVitalPoints()
    }
    
    // Cálculo de domínio Y com arredondamento para múltiplos de 10
    private var yDomain: ClosedRange<Double> {
        var values: [Double] = []
        for p in data {
            if let v = p.fc { values.append(v) }
            if let v = p.pas { values.append(v) }
            if let v = p.pad { values.append(v) }
            if let v = p.pam { values.append(v) }
            if let v = p.spo2 { values.append(v) }
            if let v = p.etco2 { values.append(v) }
        }
        let maxV = values.max() ?? 200
        let hi = ceil(maxV / 10.0) * 10.0
        return 0...hi 
    }
    
    // Domínio X (tempo)
    private var xDomain: ClosedRange<Date>? {
        guard let minT = data.map({ $0.time }).min(),
              let maxT = data.map({ $0.time }).max() else { return nil }
        return minT...maxT
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Chart {
                // FC: círculo vermelho
                ForEach(data) { p in
                    if let y = p.fc {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.red)
                                .font(.system(size: 12))
                        }
                    }
                }
                
                // PAS: triângulo cabeça para baixo
                ForEach(data) { p in
                    if let y = p.pas {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "triangle.fill")
                                .rotationEffect(.degrees(180))
                                .foregroundStyle(.primary)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                // PAD: triângulo cabeça para cima
                ForEach(data) { p in
                    if let y = p.pad {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "triangle.fill")
                                .foregroundStyle(.primary)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                // PAM: quadrado preto
                ForEach(data) { p in
                    if let y = p.pam {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "square.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 10))
                        }
                    }
                }
                
                // SpO2: cruz verde
                ForEach(data) { p in
                    if let y = p.spo2 {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "plus")
                                .foregroundStyle(.green)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                // EtCO2: círculo azul claro
                ForEach(data) { p in
                    if let y = p.etco2 {
                        PointMark(
                            x: .value("Tempo", p.time),
                            y: .value("Valor", y)
                        )
                        .opacity(0)
                        .annotation(position: .overlay) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(Color.blue.opacity(0.8))
                                .font(.system(size: 14))
                        }
                    }
                }
                
                // Marcadores verticais: início e fim da anestesia
                if let start = anesthesia.start {
                    RuleMark(x: .value("Início", start))
                        .foregroundStyle(.gray)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [8, 4]))
                }
                if let end = anesthesia.end {
                    RuleMark(x: .value("Fim", end))
                        .foregroundStyle(.gray)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [8, 4]))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .stride(by: 10)) { value in
                    AxisGridLine().foregroundStyle(Color.gray.opacity(0.3))
                    AxisValueLabel()
                }
            }
            .chartYScale(domain: yDomain)
            .chartXScale(domain: xDomain ?? Date()...Date())
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 6)) { value in
                    AxisGridLine().foregroundStyle(Color.gray.opacity(0.3))
                    AxisValueLabel()
                }
            }
            .frame(minHeight: 220)
            
            // Legenda
            VitalChartLegend()
        }
    }
}

/// Legenda com SF Symbols
private struct VitalChartLegend: View {
    var body: some View {
        HStack(spacing: 16) {
            LegendItem(symbol: "circle.fill", color: .red, label: "FC")
            LegendItem(symbol: "triangle.fill", color: .primary, label: "PAS", rotation: 180)
            LegendItem(symbol: "triangle.fill", color: .primary, label: "PAD")
            LegendItem(symbol: "square.fill", color: .black, label: "PAM")
            LegendItem(symbol: "plus", color: .green, label: "SpO₂")
            LegendItem(symbol: "circle.fill", color: Color.blue.opacity(0.8), label: "EtCO₂")
        }
        .font(.caption)
    }
}

private struct LegendItem: View {
    let symbol: String
    let color: Color
    let label: String
    var rotation: Double = 0
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .rotationEffect(.degrees(rotation))
                .font(.system(size: 10))
            Text(label)
                .foregroundStyle(.secondary)
        }
    }
}
