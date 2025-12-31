//
//  SharedPreAndAnesthesia.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 31/12/25.
//

import Foundation

extension SharedPreAndAnesthesia {
    static func samples(surgeries: [Surgery]) -> [SharedPreAndAnesthesia] {
        return [
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Local"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[20]
            surgeries[20].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[23]
            surgeries[23].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[19]
            surgeries[19].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[18]
            surgeries[18].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[39]
            surgeries[39].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[40]
            surgeries[40].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[38]
            surgeries[38].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[17]
            surgeries[17].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[37]
            surgeries[37].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[35]
            surgeries[35].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[36]
            surgeries[36].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[31]
            surgeries[31].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "III"
            )
            shared.surgery = surgeries[32]
            surgeries[32].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[33]
            surgeries[33].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[34]
            surgeries[34].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[29]
            surgeries[29].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[30]
            surgeries[30].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[26]
            surgeries[26].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[27]
            surgeries[27].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[28]
            surgeries[28].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[24]
            surgeries[24].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "III"
            )
            shared.surgery = surgeries[25]
            surgeries[25].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Raquianestesia"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[21]
            surgeries[21].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Bloqueio Periférico"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[16]
            surgeries[16].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Local", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[22]
            surgeries[22].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[15]
            surgeries[15].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Raquianestesia"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[13]
            surgeries[13].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[12]
            surgeries[12].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[11]
            surgeries[11].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[14]
            surgeries[14].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Peridural", "Geral Balanceada"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[10]
            surgeries[10].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Local"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[9]
            surgeries[9].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[8]
            surgeries[8].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[7]
            surgeries[7].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[6]
            surgeries[6].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Raquianestesia"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[5]
            surgeries[5].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Raquianestesia"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[4]
            surgeries[4].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[3]
            surgeries[3].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[2]
            surgeries[2].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[79]
            surgeries[79].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[80]
            surgeries[80].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Geral Balanceada"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[1]
            surgeries[1].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[78]
            surgeries[78].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[71]
            surgeries[71].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[85]
            surgeries[85].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[84]
            surgeries[84].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia"],
                asaRaw: "II"
            )
            shared.surgery = surgeries[91]
            surgeries[91].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Raquianestesia", "Sedação"],
                asaRaw: "I"
            )
            shared.surgery = surgeries[74]
            surgeries[74].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[47]
            surgeries[47].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[86]
            surgeries[86].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: [],
                asaRaw: nil
            )
            shared.surgery = surgeries[61]
            surgeries[61].shared = shared
            return shared
        }(),
        {
            let shared = SharedPreAndAnesthesia(
                techniquesRaw: ["Sedação", "Local"],
                asaRaw: "IIIe"
            )
            shared.surgery = surgeries[0]
            surgeries[0].shared = shared
            return shared
        }(),
        ]
    }
}
