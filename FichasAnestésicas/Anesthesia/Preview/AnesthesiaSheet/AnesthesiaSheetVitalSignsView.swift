//
//  AnesthesiaSheetVitalSignsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 04/12/25.
//

import SwiftUI
import Charts

struct AnesthesiaSheetVitalSignsView: View {
    let anesthesia: Anesthesia
    
    var body: some View {
            VStack(spacing: 0) {
                // Title
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 4)
                    Text("SINAIS VITAIS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    Spacer()
                }
                .background(Color.gray.opacity(0.2))
                
                // Chart
                VStack(spacing: 0) {
                    VitalChartSheetPrint(anesthesia: anesthesia)
                    
                }
                .frame(height: 180)
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .fixedSize(horizontal: false, vertical: true)
            
        }
}




/// Versão simplificada do gráfico de sinais vitais para impressão/PDF
struct VitalChartSheetPrint: View {
    let anesthesia: Anesthesia
    
    var body: some View {
        VitalChartContentPrint(anesthesia: anesthesia)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Conteúdo do gráfico otimizado para impressão
private struct VitalChartContentPrint: View {
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
        VStack(spacing: 8) {
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
                                .font(.system(size: 7))
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
                                .foregroundStyle(.black)
                                .font(.system(size: 7))
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
                                .foregroundStyle(.black)
                                .font(.system(size: 7))
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
                                .font(.system(size: 5))
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
                                .font(.system(size: 7))
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
                                .font(.system(size: 7))
                        }
                    }
                }
                
                // Marcadores verticais: início e fim da anestesia/cirurgia
                if let start = anesthesia.start {
                    RuleMark(x: .value("Anestesia ↓", start))
                        .foregroundStyle(.green)
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                }
                if let surgeryStart = anesthesia.surgery.start {
                    RuleMark(x: .value("Cirurgia ↓", surgeryStart))
                        .foregroundStyle(.blue)
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                }
                if let surgeryEnd = anesthesia.surgery.end {
                    RuleMark(x: .value("Cirurgia ↑", surgeryEnd))
                        .foregroundStyle(.blue)
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                }
                if let end = anesthesia.end {
                    RuleMark(x: .value("Anestesia ↑", end))
                        .foregroundStyle(.green)
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .stride(by: 10)) { value in
                    AxisGridLine().foregroundStyle(Color.gray.opacity(0.3))
                    AxisValueLabel()
                        .font(.system(size: 7))
                }
            }
            .chartYScale(domain: yDomain)
            .chartXScale(domain: xDomain ?? Date()...Date())
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 6)) { value in
                    AxisGridLine().foregroundStyle(Color.gray.opacity(0.3))
                    AxisValueLabel()
                        .font(.system(size: 7))
                }
            }
            
            // Legenda compacta
            VitalChartLegendPrint()
        }
    }
}

/// Legenda compacta para impressão
private struct VitalChartLegendPrint: View {
    var body: some View {
        HStack(spacing: 6) {
            LegendItemPrint(symbol: "circle.fill", color: .red, label: "FC")
            LegendItemPrint(symbol: "triangle.fill", color: .primary, label: "PAS", rotation: 180)
            LegendItemPrint(symbol: "triangle.fill", color: .primary, label: "PAD")
            LegendItemPrint(symbol: "square.fill", color: .black, label: "PAM")
            LegendItemPrint(symbol: "plus", color: .green, label: "SpO₂")
            LegendItemPrint(symbol: "circle.fill", color: Color.blue.opacity(0.8), label: "EtCO₂")
        }
        .font(.system(size: 5))
    }
}

private struct LegendItemPrint: View {
    let symbol: String
    let color: Color
    let label: String
    var rotation: Double = 0
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .rotationEffect(.degrees(rotation))
                .font(.system(size: 8))
            Text(label)
                .foregroundStyle(.gray)
        }
    }
}
