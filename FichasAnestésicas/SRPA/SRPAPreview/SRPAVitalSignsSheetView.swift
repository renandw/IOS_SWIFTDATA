//
//  AnesthesiaSheetVitalSignsView.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 23/01/26.
//

import SwiftUI
import Charts

struct SRPASheetVitalSignsView: View {
    let srpa: SRPA

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

            // Table for print with dynamic columns
            let hasRhythm = srpa.vitalSigns.contains { ($0.rhythm?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) }
            let hasFC = srpa.vitalSigns.contains { $0.fc != nil }
            let hasSpO2 = srpa.vitalSigns.contains { $0.spo2 != nil }
            let hasPA = srpa.vitalSigns.contains { $0.paS != nil || $0.paD != nil || $0.pam != nil }
            let hasETCO2 = srpa.vitalSigns.contains { $0.etco2 != nil }
            let hasVC = srpa.vitalSigns.contains { $0.volumeCorrente != nil }
            let hasBIS = srpa.vitalSigns.contains { $0.bis != nil }
            let hasPVC = srpa.vitalSigns.contains { $0.pvc != nil }

            VStack(alignment: .leading, spacing: 0) {
                // Header row
                HStack(alignment: .center, spacing: 0) {
                    Text("Hora")
                        .font(.system(size: 9, weight: .bold))
                        .frame(width: 50, alignment: .leading)
                        .padding(.horizontal, 6)

                    if hasRhythm {
                        Divider().frame(height: 14)
                        Text("Ritmo")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 60, alignment: .leading)
                            .padding(.horizontal, 6)
                    }
                    if hasFC {
                        Divider().frame(height: 14)
                        Text("FC")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 65, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasSpO2 {
                        Divider().frame(height: 14)
                        Text("SpO₂")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 55, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasPA {
                        Divider().frame(height: 14)
                        Text("PA (PAM)")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 120, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasETCO2 {
                        Divider().frame(height: 14)
                        Text("ETCO₂")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 70, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasVC {
                        Divider().frame(height: 14)
                        Text("VC")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 65, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasBIS {
                        Divider().frame(height: 14)
                        Text("BIS")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 60, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    if hasPVC {
                        Divider().frame(height: 14)
                        Text("PVC")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 70, alignment: .trailing)
                            .padding(.horizontal, 6)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 3)
                .background(Color.gray.opacity(0.12))

                Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)

                // Rows
                ForEach(srpa.vitalSigns) { vitalSign in
                    HStack(alignment: .center, spacing: 0) {
                        Text(vitalSign.timestamp.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 10))
                            .frame(width: 50, alignment: .leading)
                            .padding(.horizontal, 6)
                            .lineLimit(1)

                        if hasRhythm {
                            Divider().frame(height: 12)
                            Text(displayOrNoStringRecord(vitalSign.rhythm))
                                .font(.system(size: 10))
                                .frame(width: 60, alignment: .leading)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasFC {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.fc, decimals: 0, suffix: "bpm"))
                                .font(.system(size: 10))
                                .frame(width: 65, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasSpO2 {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.spo2, decimals: 1, suffix: "%"))
                                .font(.system(size: 10))
                                .frame(width: 55, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasPA {
                            Divider().frame(height: 12)
                            Group {
                                let paS = displayOrNoRecord(vitalSign.paS, decimals: 0, suffix: "")
                                let paD = displayOrNoRecord(vitalSign.paD, decimals: 0, suffix: "mmHg")
                                let pamText = vitalSign.pam != nil ? " (\(displayOrNoRecord(vitalSign.pam, decimals: 0, suffix: "")))" : ""
                                Text("\(paS) / \(paD)\(pamText)")
                                    .font(.system(size: 10))
                                    .frame(width: 120, alignment: .trailing)
                                    .padding(.horizontal, 6)
                                    .lineLimit(1)
                            }
                        }

                        if hasETCO2 {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.etco2, decimals: 0, suffix: "mmHg"))
                                .font(.system(size: 10))
                                .frame(width: 70, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasVC {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.volumeCorrente, decimals: 0, suffix: "mL"))
                                .font(.system(size: 10))
                                .frame(width: 65, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasBIS {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.bis, decimals: 1, suffix: "bis"))
                                .font(.system(size: 10))
                                .frame(width: 60, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }

                        if hasPVC {
                            Divider().frame(height: 12)
                            Text(displayOrNoRecord(vitalSign.pvc, decimals: 1, suffix: "mmHg"))
                                .font(.system(size: 10))
                                .frame(width: 70, alignment: .trailing)
                                .padding(.horizontal, 6)
                                .lineLimit(1)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 3)

                    Rectangle().fill(Color.gray.opacity(0.15)).frame(height: 1)
                }
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    func displayOrNoRecord(_ value: Double?, decimals: Int = 0, suffix: String? = nil, noRecord: String = "não há registro") -> String {
        guard let value else { return noRecord }
        let formatted = String(format: "%.\(decimals)f", value)
        if let suffix, !suffix.isEmpty {
            return "\(formatted) \(suffix)"
        } else {
            return formatted
        }
    }

    func displayOrNoStringRecord(_ value: String?, noRecord: String = "não há registro") -> String {
        guard let value else { return noRecord }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? noRecord : trimmed
    }
}
