//
//  VitalSignsSample.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 31/12/25.
//
import Foundation

extension VitalSignEntry {
    static func samples(anesthesias: [Anesthesia]) -> [VitalSignEntry] {
        var signs: [VitalSignEntry] = []

        let vital9EEF16B8 = VitalSignEntry(
            vitalSignsId: "9EEF16B8-F579-4BEE-A619-5A72196583E6",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 0, second: 28)
        )
        vital9EEF16B8.pam = 106.0
        vital9EEF16B8.fc = 106.0
        vital9EEF16B8.paS = 138.0
        vital9EEF16B8.paD = 90.0
        vital9EEF16B8.rhythm = "Sinusal"
        vital9EEF16B8.spo2 = 100.0
        signs.append(vital9EEF16B8)

        let vital65D9ADAE = VitalSignEntry(
            vitalSignsId: "65D9ADAE-CC13-4396-A2E7-F98A31BE0F1D",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 5, second: 28)
        )
        vital65D9ADAE.pam = 104.0
        vital65D9ADAE.fc = 106.0
        vital65D9ADAE.paS = 136.0
        vital65D9ADAE.paD = 88.0
        vital65D9ADAE.rhythm = "Sinusal"
        vital65D9ADAE.spo2 = 99.0
        signs.append(vital65D9ADAE)

        let vital051F93A1 = VitalSignEntry(
            vitalSignsId: "051F93A1-431E-4853-8EE7-1C021B63856C",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 10, second: 28)
        )
        vital051F93A1.pam = 104.0
        vital051F93A1.fc = 105.0
        vital051F93A1.paS = 137.0
        vital051F93A1.paD = 87.0
        vital051F93A1.rhythm = "Sinusal"
        vital051F93A1.spo2 = 99.0
        signs.append(vital051F93A1)

        let vital8B2F4DAD = VitalSignEntry(
            vitalSignsId: "8B2F4DAD-E8A9-48FB-89FC-F294B23579FF",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 15, second: 28)
        )
        vital8B2F4DAD.pam = 106.0
        vital8B2F4DAD.fc = 105.0
        vital8B2F4DAD.paS = 137.0
        vital8B2F4DAD.paD = 90.0
        vital8B2F4DAD.rhythm = "Sinusal"
        vital8B2F4DAD.spo2 = 100.0
        signs.append(vital8B2F4DAD)

        let vital32D838F6 = VitalSignEntry(
            vitalSignsId: "32D838F6-B8FD-4A59-B62D-AFF32A5713CE",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 20, second: 28)
        )
        vital32D838F6.pam = 104.0
        vital32D838F6.fc = 103.0
        vital32D838F6.paS = 137.0
        vital32D838F6.paD = 88.0
        vital32D838F6.rhythm = "Sinusal"
        vital32D838F6.spo2 = 100.0
        signs.append(vital32D838F6)

        let vitalC6E14B27 = VitalSignEntry(
            vitalSignsId: "C6E14B27-8162-4A86-8DB7-E5457CC9E5D9",
            anesthesia: anesthesias[0],
            timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 25, second: 28)
        )
        vitalC6E14B27.pam = 107.0
        vitalC6E14B27.fc = 106.0
        vitalC6E14B27.paS = 140.0
        vitalC6E14B27.paD = 91.0
        vitalC6E14B27.rhythm = "Sinusal"
        vitalC6E14B27.spo2 = 100.0
        signs.append(vitalC6E14B27)

        let vital57071DAF = VitalSignEntry(
            vitalSignsId: "57071DAF-E2E1-4257-BB86-601478452CF9",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
        )
        vital57071DAF.pam = 80.0
        vital57071DAF.fc = 87.0
        vital57071DAF.paS = 109.0
        vital57071DAF.paD = 66.0
        vital57071DAF.rhythm = "Sinusal"
        vital57071DAF.etco2 = 34.0
        vital57071DAF.spo2 = 98.0
        signs.append(vital57071DAF)

        let vital7EBE2922 = VitalSignEntry(
            vitalSignsId: "7EBE2922-CC89-4C7D-A3DA-1B8B8FA81FA1",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 5, second: 30)
        )
        vital7EBE2922.pam = 80.0
        vital7EBE2922.fc = 86.0
        vital7EBE2922.paS = 108.0
        vital7EBE2922.paD = 66.0
        vital7EBE2922.rhythm = "Sinusal"
        vital7EBE2922.etco2 = 35.0
        vital7EBE2922.spo2 = 99.0
        signs.append(vital7EBE2922)

        let vitalD39B08E9 = VitalSignEntry(
            vitalSignsId: "D39B08E9-ACEA-41D8-95CD-4CF16CF25E77",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 10, second: 30)
        )
        vitalD39B08E9.pam = 80.0
        vitalD39B08E9.fc = 86.0
        vitalD39B08E9.paS = 108.0
        vitalD39B08E9.paD = 66.0
        vitalD39B08E9.rhythm = "Sinusal"
        vitalD39B08E9.etco2 = 35.0
        vitalD39B08E9.spo2 = 99.0
        signs.append(vitalD39B08E9)

        let vital0581B7E8 = VitalSignEntry(
            vitalSignsId: "0581B7E8-35DA-425B-B1B9-8B781A0E3F0B",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 15, second: 30)
        )
        vital0581B7E8.pam = 83.0
        vital0581B7E8.fc = 89.0
        vital0581B7E8.paS = 110.0
        vital0581B7E8.paD = 70.0
        vital0581B7E8.rhythm = "Sinusal"
        vital0581B7E8.etco2 = 36.0
        vital0581B7E8.spo2 = 100.0
        signs.append(vital0581B7E8)

        let vital70E5C643 = VitalSignEntry(
            vitalSignsId: "70E5C643-94D4-44E0-A899-5B83D41472AF",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 20, second: 30)
        )
        vital70E5C643.pam = 86.0
        vital70E5C643.fc = 90.0
        vital70E5C643.paS = 113.0
        vital70E5C643.paD = 72.0
        vital70E5C643.rhythm = "Sinusal"
        vital70E5C643.etco2 = 37.0
        vital70E5C643.spo2 = 99.0
        signs.append(vital70E5C643)

        let vital5A9CE869 = VitalSignEntry(
            vitalSignsId: "5A9CE869-128F-4BD2-BE9D-7852E6D805A6",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 25, second: 30)
        )
        vital5A9CE869.pam = 86.0
        vital5A9CE869.fc = 89.0
        vital5A9CE869.paS = 117.0
        vital5A9CE869.paD = 71.0
        vital5A9CE869.rhythm = "Sinusal"
        vital5A9CE869.etco2 = 36.0
        vital5A9CE869.spo2 = 98.0
        signs.append(vital5A9CE869)

        let vital8DE7C1AF = VitalSignEntry(
            vitalSignsId: "8DE7C1AF-907D-4FA3-BD6A-924FBAC058BA",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 30, second: 30)
        )
        vital8DE7C1AF.pam = 85.0
        vital8DE7C1AF.fc = 88.0
        vital8DE7C1AF.paS = 115.0
        vital8DE7C1AF.paD = 70.0
        vital8DE7C1AF.rhythm = "Sinusal"
        vital8DE7C1AF.etco2 = 36.0
        vital8DE7C1AF.spo2 = 98.0
        signs.append(vital8DE7C1AF)

        let vitalA9E7FD65 = VitalSignEntry(
            vitalSignsId: "A9E7FD65-BD84-4133-BB2B-40F61A8BF90C",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 40, second: 30)
        )
        vitalA9E7FD65.pam = 86.0
        vitalA9E7FD65.fc = 89.0
        vitalA9E7FD65.paS = 113.0
        vitalA9E7FD65.paD = 72.0
        vitalA9E7FD65.rhythm = "Sinusal"
        vitalA9E7FD65.etco2 = 36.0
        vitalA9E7FD65.spo2 = 99.0
        signs.append(vitalA9E7FD65)

        let vital0DF9EECB = VitalSignEntry(
            vitalSignsId: "0DF9EECB-A4E6-49DA-A3A2-9D730228BC45",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 50, second: 30)
        )
        vital0DF9EECB.pam = 89.0
        vital0DF9EECB.fc = 92.0
        vital0DF9EECB.paS = 122.0
        vital0DF9EECB.paD = 73.0
        vital0DF9EECB.rhythm = "Sinusal"
        vital0DF9EECB.etco2 = 36.0
        vital0DF9EECB.spo2 = 99.0
        signs.append(vital0DF9EECB)

        let vitalAB09C4FA = VitalSignEntry(
            vitalSignsId: "AB09C4FA-B9DA-4449-BCE5-81540E19F2E5",
            anesthesia: anesthesias[1],
            timestamp: createDate(day: 22, month: 12, year: 2025, hour: 9, minute: 0, second: 30)
        )
        vitalAB09C4FA.pam = 91.0
        vitalAB09C4FA.fc = 92.0
        vitalAB09C4FA.paS = 124.0
        vitalAB09C4FA.paD = 74.0
        vitalAB09C4FA.rhythm = "Sinusal"
        vitalAB09C4FA.etco2 = 35.0
        vitalAB09C4FA.spo2 = 98.0
        signs.append(vitalAB09C4FA)

        let vital07CA4294 = VitalSignEntry(
            vitalSignsId: "07CA4294-6D15-4AF9-B756-4EA9E3C152DF",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
        )
        vital07CA4294.pam = 74.0
        vital07CA4294.fc = 71.0
        vital07CA4294.paS = 92.0
        vital07CA4294.paD = 65.0
        vital07CA4294.rhythm = "Sinusal"
        vital07CA4294.spo2 = 100.0
        signs.append(vital07CA4294)

        let vitalB93E2B8C = VitalSignEntry(
            vitalSignsId: "B93E2B8C-12C1-4AE7-9DE5-6CA3006476AE",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 55, second: 32)
        )
        vitalB93E2B8C.pam = 74.0
        vitalB93E2B8C.fc = 73.0
        vitalB93E2B8C.paS = 92.0
        vitalB93E2B8C.paD = 65.0
        vitalB93E2B8C.rhythm = "Sinusal"
        vitalB93E2B8C.spo2 = 100.0
        signs.append(vitalB93E2B8C)

        let vital54335659 = VitalSignEntry(
            vitalSignsId: "54335659-1296-4911-8D54-882E4C7B7B4B",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 0, second: 32)
        )
        vital54335659.pam = 74.0
        vital54335659.fc = 73.0
        vital54335659.paS = 92.0
        vital54335659.paD = 65.0
        vital54335659.rhythm = "Sinusal"
        vital54335659.spo2 = 99.0
        signs.append(vital54335659)

        let vital0DBF4CE3 = VitalSignEntry(
            vitalSignsId: "0DBF4CE3-207E-435B-8093-832F740E345F",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 5, second: 32)
        )
        vital0DBF4CE3.pam = 80.0
        vital0DBF4CE3.fc = 69.0
        vital0DBF4CE3.paS = 99.0
        vital0DBF4CE3.paD = 70.0
        vital0DBF4CE3.rhythm = "Sinusal"
        vital0DBF4CE3.spo2 = 99.0
        signs.append(vital0DBF4CE3)

        let vitalFC8A6BBA = VitalSignEntry(
            vitalSignsId: "FC8A6BBA-AB98-4AF5-A044-63DFBA986098",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 10, second: 32)
        )
        vitalFC8A6BBA.pam = 84.0
        vitalFC8A6BBA.fc = 66.0
        vitalFC8A6BBA.paS = 107.0
        vitalFC8A6BBA.paD = 73.0
        vitalFC8A6BBA.rhythm = "Sinusal"
        vitalFC8A6BBA.spo2 = 99.0
        signs.append(vitalFC8A6BBA)

        let vital37B73648 = VitalSignEntry(
            vitalSignsId: "37B73648-9535-40A4-9B9F-D28D403069DF",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 15, second: 32)
        )
        vital37B73648.pam = 84.0
        vital37B73648.fc = 67.0
        vital37B73648.paS = 107.0
        vital37B73648.paD = 73.0
        vital37B73648.rhythm = "Sinusal"
        vital37B73648.spo2 = 100.0
        signs.append(vital37B73648)

        let vital7206EA27 = VitalSignEntry(
            vitalSignsId: "7206EA27-FAE9-405A-9AAF-3AD2FEB10A98",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 20, second: 32)
        )
        vital7206EA27.pam = 84.0
        vital7206EA27.fc = 65.0
        vital7206EA27.paS = 106.0
        vital7206EA27.paD = 73.0
        vital7206EA27.rhythm = "Sinusal"
        vital7206EA27.spo2 = 100.0
        signs.append(vital7206EA27)

        let vital416595F4 = VitalSignEntry(
            vitalSignsId: "416595F4-AF00-4E69-806B-F70DBF63A906",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 30, second: 32)
        )
        vital416595F4.pam = 85.0
        vital416595F4.fc = 65.0
        vital416595F4.paS = 107.0
        vital416595F4.paD = 74.0
        vital416595F4.rhythm = "Sinusal"
        vital416595F4.spo2 = 100.0
        signs.append(vital416595F4)

        let vitalB8D73663 = VitalSignEntry(
            vitalSignsId: "B8D73663-5B8B-43B4-A74D-3C6B6D77FE05",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 40, second: 32)
        )
        vitalB8D73663.pam = 89.0
        vitalB8D73663.fc = 68.0
        vitalB8D73663.paS = 113.0
        vitalB8D73663.paD = 77.0
        vitalB8D73663.rhythm = "Sinusal"
        vitalB8D73663.spo2 = 100.0
        signs.append(vitalB8D73663)

        let vitalB3991B5F = VitalSignEntry(
            vitalSignsId: "B3991B5F-9E55-4B55-B702-DB55E7FD5636",
            anesthesia: anesthesias[2],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 50, second: 32)
        )
        vitalB3991B5F.pam = 91.0
        vitalB3991B5F.fc = 68.0
        vitalB3991B5F.paS = 114.0
        vitalB3991B5F.paD = 79.0
        vitalB3991B5F.rhythm = "Sinusal"
        vitalB3991B5F.spo2 = 100.0
        signs.append(vitalB3991B5F)

        let vitalF690D334 = VitalSignEntry(
            vitalSignsId: "F690D334-0F81-4973-9D46-C3A75DA05597",
            anesthesia: anesthesias[3],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 40, second: 2)
        )
        vitalF690D334.pam = 92.0
        vitalF690D334.fc = 86.0
        vitalF690D334.paS = 130.0
        vitalF690D334.paD = 73.0
        vitalF690D334.rhythm = "Sinusal"
        vitalF690D334.spo2 = 98.0
        signs.append(vitalF690D334)

        let vital8360BCE6 = VitalSignEntry(
            vitalSignsId: "8360BCE6-3CF5-4E46-9766-547C2812EE23",
            anesthesia: anesthesias[3],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 45, second: 2)
        )
        vital8360BCE6.pam = 90.0
        vital8360BCE6.fc = 88.0
        vital8360BCE6.paS = 133.0
        vital8360BCE6.paD = 69.0
        vital8360BCE6.rhythm = "Sinusal"
        vital8360BCE6.spo2 = 98.0
        signs.append(vital8360BCE6)

        let vitalE3F4EC16 = VitalSignEntry(
            vitalSignsId: "E3F4EC16-1296-478F-9860-A2B787891520",
            anesthesia: anesthesias[3],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 2)
        )
        vitalE3F4EC16.pam = 90.0
        vitalE3F4EC16.fc = 86.0
        vitalE3F4EC16.paS = 130.0
        vitalE3F4EC16.paD = 70.0
        vitalE3F4EC16.rhythm = "Sinusal"
        vitalE3F4EC16.spo2 = 97.0
        signs.append(vitalE3F4EC16)

        let vital6248345B = VitalSignEntry(
            vitalSignsId: "6248345B-8358-48B0-B4CB-34703F051537",
            anesthesia: anesthesias[3],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 55, second: 2)
        )
        vital6248345B.pam = 90.0
        vital6248345B.fc = 86.0
        vital6248345B.paS = 129.0
        vital6248345B.paD = 71.0
        vital6248345B.rhythm = "Sinusal"
        vital6248345B.spo2 = 97.0
        signs.append(vital6248345B)

        let vital619489E3 = VitalSignEntry(
            vitalSignsId: "619489E3-4015-49E2-AED1-275F806CAAF6",
            anesthesia: anesthesias[3],
            timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 0, second: 2)
        )
        vital619489E3.pam = 90.0
        vital619489E3.fc = 87.0
        vital619489E3.paS = 126.0
        vital619489E3.paD = 72.0
        vital619489E3.rhythm = "Sinusal"
        vital619489E3.spo2 = 97.0
        signs.append(vital619489E3)

        let vital241880F8 = VitalSignEntry(
            vitalSignsId: "241880F8-91DD-49F4-8CEA-5AF7D40DF249",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
        )
        vital241880F8.pam = 91.0
        vital241880F8.fc = 59.0
        vital241880F8.paS = 116.0
        vital241880F8.paD = 78.0
        vital241880F8.rhythm = "Sinusal"
        vital241880F8.spo2 = 99.0
        signs.append(vital241880F8)

        let vital94116088 = VitalSignEntry(
            vitalSignsId: "94116088-C198-4A96-8B53-01CAD70548DB",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 15, second: 23)
        )
        vital94116088.pam = 91.0
        vital94116088.fc = 61.0
        vital94116088.paS = 116.0
        vital94116088.paD = 78.0
        vital94116088.rhythm = "Sinusal"
        vital94116088.spo2 = 98.0
        signs.append(vital94116088)

        let vitalF9AD308D = VitalSignEntry(
            vitalSignsId: "F9AD308D-CE45-41FB-ABBE-005222105511",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 20, second: 23)
        )
        vitalF9AD308D.pam = 91.0
        vitalF9AD308D.fc = 62.0
        vitalF9AD308D.paS = 116.0
        vitalF9AD308D.paD = 78.0
        vitalF9AD308D.rhythm = "Sinusal"
        vitalF9AD308D.spo2 = 98.0
        signs.append(vitalF9AD308D)

        let vital761EAFB2 = VitalSignEntry(
            vitalSignsId: "761EAFB2-66B3-4240-8AD1-5E40129E3BB3",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 25, second: 23)
        )
        vital761EAFB2.pam = 97.0
        vital761EAFB2.fc = 60.0
        vital761EAFB2.paS = 124.0
        vital761EAFB2.paD = 84.0
        vital761EAFB2.rhythm = "Sinusal"
        vital761EAFB2.spo2 = 99.0
        signs.append(vital761EAFB2)

        let vital449528E3 = VitalSignEntry(
            vitalSignsId: "449528E3-B7D4-42C5-85A7-BE6B977AD8DC",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 30, second: 23)
        )
        vital449528E3.pam = 99.0
        vital449528E3.fc = 61.0
        vital449528E3.paS = 126.0
        vital449528E3.paD = 85.0
        vital449528E3.rhythm = "Sinusal"
        vital449528E3.spo2 = 98.0
        signs.append(vital449528E3)

        let vitalDD9935F3 = VitalSignEntry(
            vitalSignsId: "DD9935F3-7537-4862-B3BB-BB48509E7EEF",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 35, second: 23)
        )
        vitalDD9935F3.pam = 101.0
        vitalDD9935F3.fc = 58.0
        vitalDD9935F3.paS = 128.0
        vitalDD9935F3.paD = 87.0
        vitalDD9935F3.rhythm = "Sinusal"
        vitalDD9935F3.spo2 = 99.0
        signs.append(vitalDD9935F3)

        let vitalF962C35A = VitalSignEntry(
            vitalSignsId: "F962C35A-C14B-4042-AAC6-3C82B0BCF0BD",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 40, second: 23)
        )
        vitalF962C35A.pam = 103.0
        vitalF962C35A.fc = 57.0
        vitalF962C35A.paS = 130.0
        vitalF962C35A.paD = 89.0
        vitalF962C35A.rhythm = "Sinusal"
        vitalF962C35A.spo2 = 100.0
        signs.append(vitalF962C35A)

        let vitalBB26B11C = VitalSignEntry(
            vitalSignsId: "BB26B11C-575A-4021-86F6-A741AA183C5F",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 50, second: 23)
        )
        vitalBB26B11C.pam = 102.0
        vitalBB26B11C.fc = 55.0
        vitalBB26B11C.paS = 132.0
        vitalBB26B11C.paD = 87.0
        vitalBB26B11C.rhythm = "Sinusal"
        vitalBB26B11C.spo2 = 100.0
        signs.append(vitalBB26B11C)

        let vital61E747E8 = VitalSignEntry(
            vitalSignsId: "61E747E8-A133-4DDC-85ED-0D288A320253",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 0, second: 23)
        )
        vital61E747E8.pam = 103.0
        vital61E747E8.fc = 55.0
        vital61E747E8.paS = 130.0
        vital61E747E8.paD = 89.0
        vital61E747E8.rhythm = "Sinusal"
        vital61E747E8.spo2 = 100.0
        signs.append(vital61E747E8)

        let vitalFBBF52AD = VitalSignEntry(
            vitalSignsId: "FBBF52AD-A1BB-4096-A35A-C73A2A9A058C",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 10, second: 23)
        )
        vitalFBBF52AD.pam = 104.0
        vitalFBBF52AD.fc = 55.0
        vitalFBBF52AD.paS = 133.0
        vitalFBBF52AD.paD = 89.0
        vitalFBBF52AD.rhythm = "Sinusal"
        vitalFBBF52AD.spo2 = 99.0
        signs.append(vitalFBBF52AD)

        let vital68C7BFDB = VitalSignEntry(
            vitalSignsId: "68C7BFDB-B9C0-4820-97FE-6C636E417B40",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 20, second: 23)
        )
        vital68C7BFDB.pam = 101.0
        vital68C7BFDB.fc = 57.0
        vital68C7BFDB.paS = 131.0
        vital68C7BFDB.paD = 86.0
        vital68C7BFDB.rhythm = "Sinusal"
        vital68C7BFDB.spo2 = 98.0
        signs.append(vital68C7BFDB)

        let vital7D18729E = VitalSignEntry(
            vitalSignsId: "7D18729E-2FBE-465C-B99B-DFA338C5E2DD",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 30, second: 23)
        )
        vital7D18729E.pam = 103.0
        vital7D18729E.fc = 58.0
        vital7D18729E.paS = 133.0
        vital7D18729E.paD = 88.0
        vital7D18729E.rhythm = "Sinusal"
        vital7D18729E.spo2 = 97.0
        signs.append(vital7D18729E)

        let vital9475E0F7 = VitalSignEntry(
            vitalSignsId: "9475E0F7-1A6C-42EF-ABCF-4B014EC058B6",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 40, second: 23)
        )
        vital9475E0F7.pam = 102.0
        vital9475E0F7.fc = 59.0
        vital9475E0F7.paS = 131.0
        vital9475E0F7.paD = 88.0
        vital9475E0F7.rhythm = "Sinusal"
        vital9475E0F7.spo2 = 98.0
        signs.append(vital9475E0F7)

        let vital7AB8705E = VitalSignEntry(
            vitalSignsId: "7AB8705E-AF0A-430F-AA3F-9DDD0F368110",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 50, second: 23)
        )
        vital7AB8705E.pam = 103.0
        vital7AB8705E.fc = 58.0
        vital7AB8705E.paS = 132.0
        vital7AB8705E.paD = 89.0
        vital7AB8705E.rhythm = "Sinusal"
        vital7AB8705E.spo2 = 98.0
        signs.append(vital7AB8705E)

        let vital058FEDE7 = VitalSignEntry(
            vitalSignsId: "058FEDE7-5F75-4113-82D7-6541CEEC3155",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 10, minute: 0, second: 23)
        )
        vital058FEDE7.pam = 107.0
        vital058FEDE7.fc = 59.0
        vital058FEDE7.paS = 140.0
        vital058FEDE7.paD = 91.0
        vital058FEDE7.rhythm = "Sinusal"
        vital058FEDE7.spo2 = 98.0
        signs.append(vital058FEDE7)

        let vital2758CC52 = VitalSignEntry(
            vitalSignsId: "2758CC52-5C29-4A2F-B6B0-BA684A09D7CE",
            anesthesia: anesthesias[4],
            timestamp: createDate(day: 17, month: 12, year: 2025, hour: 10, minute: 10, second: 23)
        )
        vital2758CC52.pam = 108.0
        vital2758CC52.fc = 60.0
        vital2758CC52.paS = 140.0
        vital2758CC52.paD = 92.0
        vital2758CC52.rhythm = "Sinusal"
        vital2758CC52.spo2 = 98.0
        signs.append(vital2758CC52)

        let vital6C2AAB4A = VitalSignEntry(
            vitalSignsId: "6C2AAB4A-A1AD-47C4-9281-19581BFAD370",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
        )
        vital6C2AAB4A.pam = 86.0
        vital6C2AAB4A.fc = 73.0
        vital6C2AAB4A.paS = 113.0
        vital6C2AAB4A.paD = 72.0
        vital6C2AAB4A.rhythm = "Sinusal"
        vital6C2AAB4A.spo2 = 100.0
        signs.append(vital6C2AAB4A)

        let vitalB55A1423 = VitalSignEntry(
            vitalSignsId: "B55A1423-3FA1-4D5B-AF4E-8CFFFEAA80CE",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 25, second: 32)
        )
        vitalB55A1423.pam = 86.0
        vitalB55A1423.fc = 75.0
        vitalB55A1423.paS = 113.0
        vitalB55A1423.paD = 72.0
        vitalB55A1423.rhythm = "Sinusal"
        vitalB55A1423.spo2 = 100.0
        signs.append(vitalB55A1423)

        let vitalE5651771 = VitalSignEntry(
            vitalSignsId: "E5651771-81AE-4650-B9ED-25BDE8D2D2BF",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 30, second: 32)
        )
        vitalE5651771.pam = 86.0
        vitalE5651771.fc = 77.0
        vitalE5651771.paS = 113.0
        vitalE5651771.paD = 72.0
        vitalE5651771.rhythm = "Sinusal"
        vitalE5651771.spo2 = 100.0
        signs.append(vitalE5651771)

        let vital52833652 = VitalSignEntry(
            vitalSignsId: "52833652-33FF-4301-AC14-EF50373CDAA2",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 35, second: 32)
        )
        vital52833652.pam = 94.0
        vital52833652.fc = 72.0
        vital52833652.paS = 125.0
        vital52833652.paD = 79.0
        vital52833652.rhythm = "Sinusal"
        vital52833652.spo2 = 100.0
        signs.append(vital52833652)

        let vital4573D473 = VitalSignEntry(
            vitalSignsId: "4573D473-50FF-4F98-B18F-506DA74070F4",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 40, second: 32)
        )
        vital4573D473.pam = 97.0
        vital4573D473.fc = 71.0
        vital4573D473.paS = 126.0
        vital4573D473.paD = 82.0
        vital4573D473.rhythm = "Sinusal"
        vital4573D473.spo2 = 100.0
        signs.append(vital4573D473)

        let vitalB1DB98E2 = VitalSignEntry(
            vitalSignsId: "B1DB98E2-F25B-4F39-B17B-E18162618A29",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 45, second: 32)
        )
        vitalB1DB98E2.pam = 96.0
        vitalB1DB98E2.fc = 72.0
        vitalB1DB98E2.paS = 125.0
        vitalB1DB98E2.paD = 81.0
        vitalB1DB98E2.rhythm = "Sinusal"
        vitalB1DB98E2.spo2 = 100.0
        signs.append(vitalB1DB98E2)

        let vital007AFB7E = VitalSignEntry(
            vitalSignsId: "007AFB7E-9CA8-45B2-A34D-90D3F5EF666A",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
        )
        vital007AFB7E.pam = 95.0
        vital007AFB7E.fc = 70.0
        vital007AFB7E.paS = 126.0
        vital007AFB7E.paD = 80.0
        vital007AFB7E.rhythm = "Sinusal"
        vital007AFB7E.spo2 = 100.0
        signs.append(vital007AFB7E)

        let vitalE7434541 = VitalSignEntry(
            vitalSignsId: "E7434541-846C-43A2-B761-7D85A3626BA0",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 8, minute: 0, second: 32)
        )
        vitalE7434541.pam = 97.0
        vitalE7434541.fc = 70.0
        vitalE7434541.paS = 126.0
        vitalE7434541.paD = 83.0
        vitalE7434541.rhythm = "Sinusal"
        vitalE7434541.spo2 = 100.0
        signs.append(vitalE7434541)

        let vital64C7FBF8 = VitalSignEntry(
            vitalSignsId: "64C7FBF8-297B-4641-822D-143DBC5DF47C",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 8, minute: 10, second: 32)
        )
        vital64C7FBF8.pam = 103.0
        vital64C7FBF8.fc = 73.0
        vital64C7FBF8.paS = 137.0
        vital64C7FBF8.paD = 86.0
        vital64C7FBF8.rhythm = "Sinusal"
        vital64C7FBF8.spo2 = 100.0
        signs.append(vital64C7FBF8)

        let vitalA808540D = VitalSignEntry(
            vitalSignsId: "A808540D-CFFA-4FAF-99F0-30909591E38F",
            anesthesia: anesthesias[5],
            timestamp: createDate(day: 16, month: 12, year: 2025, hour: 8, minute: 20, second: 32)
        )
        vitalA808540D.pam = 104.0
        vitalA808540D.fc = 72.0
        vitalA808540D.paS = 137.0
        vitalA808540D.paD = 88.0
        vitalA808540D.rhythm = "Sinusal"
        vitalA808540D.spo2 = 100.0
        signs.append(vitalA808540D)

        let vital7DB28CF4 = VitalSignEntry(
            vitalSignsId: "7DB28CF4-049B-4A0B-A596-15D1B69C1248",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 50, second: 48)
        )
        vital7DB28CF4.pam = 90.0
        vital7DB28CF4.fc = 87.0
        vital7DB28CF4.paS = 103.0
        vital7DB28CF4.paD = 83.0
        vital7DB28CF4.rhythm = "Sinusal"
        vital7DB28CF4.spo2 = 99.0
        signs.append(vital7DB28CF4)

        let vitalB1BDEC08 = VitalSignEntry(
            vitalSignsId: "B1BDEC08-E114-4D76-81EE-7B34C6B46608",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 55, second: 48)
        )
        vitalB1BDEC08.pam = 88.0
        vitalB1BDEC08.fc = 85.0
        vitalB1BDEC08.paS = 102.0
        vitalB1BDEC08.paD = 81.0
        vitalB1BDEC08.rhythm = "Sinusal"
        vitalB1BDEC08.spo2 = 99.0
        signs.append(vitalB1BDEC08)

        let vital4594FCF6 = VitalSignEntry(
            vitalSignsId: "4594FCF6-FD83-4C6A-91FF-1796001EA5F9",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 8, minute: 0, second: 48)
        )
        vital4594FCF6.pam = 89.0
        vital4594FCF6.fc = 85.0
        vital4594FCF6.paS = 102.0
        vital4594FCF6.paD = 82.0
        vital4594FCF6.rhythm = "Sinusal"
        vital4594FCF6.spo2 = 100.0
        signs.append(vital4594FCF6)

        let vital496EA372 = VitalSignEntry(
            vitalSignsId: "496EA372-4062-4E7F-8846-F3E5FEC2D6AB",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 8, minute: 5, second: 48)
        )
        vital496EA372.pam = 90.0
        vital496EA372.fc = 85.0
        vital496EA372.paS = 101.0
        vital496EA372.paD = 84.0
        vital496EA372.rhythm = "Sinusal"
        vital496EA372.spo2 = 99.0
        signs.append(vital496EA372)

        let vital05B83CD7 = VitalSignEntry(
            vitalSignsId: "05B83CD7-3777-4C9D-8D07-D41244D247DC",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 8, minute: 10, second: 48)
        )
        vital05B83CD7.pam = 91.0
        vital05B83CD7.fc = 85.0
        vital05B83CD7.paS = 104.0
        vital05B83CD7.paD = 85.0
        vital05B83CD7.rhythm = "Sinusal"
        vital05B83CD7.spo2 = 100.0
        signs.append(vital05B83CD7)

        let vitalB44C94A4 = VitalSignEntry(
            vitalSignsId: "B44C94A4-CDE4-47E8-B004-705CC027AD3E",
            anesthesia: anesthesias[6],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 8, minute: 15, second: 48)
        )
        vitalB44C94A4.pam = 88.0
        vitalB44C94A4.fc = 83.0
        vitalB44C94A4.paS = 100.0
        vitalB44C94A4.paD = 82.0
        vitalB44C94A4.rhythm = "Sinusal"
        vitalB44C94A4.spo2 = 100.0
        signs.append(vitalB44C94A4)

        let vitalE2935DD6 = VitalSignEntry(
            vitalSignsId: "E2935DD6-F08C-45DB-879E-006E185067A3",
            anesthesia: anesthesias[7],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 25, second: 36)
        )
        vitalE2935DD6.pam = 86.0
        vitalE2935DD6.fc = 74.0
        vitalE2935DD6.paS = 117.0
        vitalE2935DD6.paD = 71.0
        vitalE2935DD6.rhythm = "Sinusal"
        vitalE2935DD6.spo2 = 98.0
        signs.append(vitalE2935DD6)

        let vital92CE104E = VitalSignEntry(
            vitalSignsId: "92CE104E-4823-4F80-B5D8-43770DE22971",
            anesthesia: anesthesias[7],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 30, second: 36)
        )
        vital92CE104E.pam = 87.0
        vital92CE104E.fc = 75.0
        vital92CE104E.paS = 120.0
        vital92CE104E.paD = 71.0
        vital92CE104E.rhythm = "Sinusal"
        vital92CE104E.spo2 = 97.0
        signs.append(vital92CE104E)

        let vital0B585BF1 = VitalSignEntry(
            vitalSignsId: "0B585BF1-0980-4E56-8B6B-5C5E997F20A2",
            anesthesia: anesthesias[7],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 35, second: 36)
        )
        vital0B585BF1.pam = 88.0
        vital0B585BF1.fc = 73.0
        vital0B585BF1.paS = 119.0
        vital0B585BF1.paD = 73.0
        vital0B585BF1.rhythm = "Sinusal"
        vital0B585BF1.spo2 = 97.0
        signs.append(vital0B585BF1)

        let vital8193B8BB = VitalSignEntry(
            vitalSignsId: "8193B8BB-4B1C-4277-917F-5F9009D7690D",
            anesthesia: anesthesias[7],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 40, second: 36)
        )
        vital8193B8BB.pam = 88.0
        vital8193B8BB.fc = 72.0
        vital8193B8BB.paS = 121.0
        vital8193B8BB.paD = 72.0
        vital8193B8BB.rhythm = "Sinusal"
        vital8193B8BB.spo2 = 98.0
        signs.append(vital8193B8BB)

        let vital68B2572D = VitalSignEntry(
            vitalSignsId: "68B2572D-92CD-43DA-A26B-D1A762049774",
            anesthesia: anesthesias[7],
            timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 45, second: 36)
        )
        vital68B2572D.pam = 87.0
        vital68B2572D.fc = 73.0
        vital68B2572D.paS = 120.0
        vital68B2572D.paD = 71.0
        vital68B2572D.rhythm = "Sinusal"
        vital68B2572D.spo2 = 99.0
        signs.append(vital68B2572D)

        let vital88F9B768 = VitalSignEntry(
            vitalSignsId: "88F9B768-6A5E-4C43-9971-E457C0ED5641",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
        )
        vital88F9B768.pam = 67.0
        vital88F9B768.fc = 105.0
        vital88F9B768.paS = 94.0
        vital88F9B768.paD = 54.0
        vital88F9B768.rhythm = "Sinusal"
        vital88F9B768.spo2 = 98.0
        signs.append(vital88F9B768)

        let vital8D5CC902 = VitalSignEntry(
            vitalSignsId: "8D5CC902-A8D9-43F5-8A14-1B4ACEB07A31",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 25, second: 32)
        )
        vital8D5CC902.pam = 67.0
        vital8D5CC902.fc = 108.0
        vital8D5CC902.paS = 94.0
        vital8D5CC902.paD = 54.0
        vital8D5CC902.rhythm = "Sinusal"
        vital8D5CC902.spo2 = 97.0
        signs.append(vital8D5CC902)

        let vital24D35B06 = VitalSignEntry(
            vitalSignsId: "24D35B06-4921-4ADE-BCD1-4D12857D45E9",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 30, second: 32)
        )
        vital24D35B06.pam = 67.0
        vital24D35B06.fc = 108.0
        vital24D35B06.paS = 94.0
        vital24D35B06.paD = 54.0
        vital24D35B06.rhythm = "Sinusal"
        vital24D35B06.spo2 = 98.0
        signs.append(vital24D35B06)

        let vitalD2569411 = VitalSignEntry(
            vitalSignsId: "D2569411-6287-46EB-8EA4-B52AFC87C2D4",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 35, second: 32)
        )
        vitalD2569411.pam = 75.0
        vitalD2569411.fc = 105.0
        vitalD2569411.paS = 106.0
        vitalD2569411.paD = 60.0
        vitalD2569411.rhythm = "Sinusal"
        vitalD2569411.spo2 = 98.0
        signs.append(vitalD2569411)

        let vital7B9EA12B = VitalSignEntry(
            vitalSignsId: "7B9EA12B-DD02-42CD-8C51-61A761047B23",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 40, second: 32)
        )
        vital7B9EA12B.pam = 78.0
        vital7B9EA12B.fc = 105.0
        vital7B9EA12B.paS = 105.0
        vital7B9EA12B.paD = 64.0
        vital7B9EA12B.rhythm = "Sinusal"
        vital7B9EA12B.spo2 = 97.0
        signs.append(vital7B9EA12B)

        let vital2CC5A4C5 = VitalSignEntry(
            vitalSignsId: "2CC5A4C5-CD83-4D9E-BFA0-2C561C173E68",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 45, second: 32)
        )
        vital2CC5A4C5.pam = 78.0
        vital2CC5A4C5.fc = 103.0
        vital2CC5A4C5.paS = 105.0
        vital2CC5A4C5.paD = 64.0
        vital2CC5A4C5.rhythm = "Sinusal"
        vital2CC5A4C5.spo2 = 97.0
        signs.append(vital2CC5A4C5)

        let vital64B2B196 = VitalSignEntry(
            vitalSignsId: "64B2B196-0EE1-4847-A139-99FE4031F7D9",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 50, second: 32)
        )
        vital64B2B196.pam = 78.0
        vital64B2B196.fc = 101.0
        vital64B2B196.paS = 105.0
        vital64B2B196.paD = 65.0
        vital64B2B196.rhythm = "Sinusal"
        vital64B2B196.spo2 = 97.0
        signs.append(vital64B2B196)

        let vital4B403BEB = VitalSignEntry(
            vitalSignsId: "4B403BEB-A908-48BC-817E-8885AB69CEB5",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 0, second: 32)
        )
        vital4B403BEB.pam = 80.0
        vital4B403BEB.fc = 102.0
        vital4B403BEB.paS = 109.0
        vital4B403BEB.paD = 66.0
        vital4B403BEB.rhythm = "Sinusal"
        vital4B403BEB.spo2 = 98.0
        signs.append(vital4B403BEB)

        let vital4A64D471 = VitalSignEntry(
            vitalSignsId: "4A64D471-30DC-4791-A17B-F7C59DC401E1",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 10, second: 32)
        )
        vital4A64D471.pam = 82.0
        vital4A64D471.fc = 103.0
        vital4A64D471.paS = 113.0
        vital4A64D471.paD = 67.0
        vital4A64D471.rhythm = "Sinusal"
        vital4A64D471.spo2 = 97.0
        signs.append(vital4A64D471)

        let vitalD298D3E1 = VitalSignEntry(
            vitalSignsId: "D298D3E1-A14F-4FFA-AA98-8C8D4EC9C791",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 20, second: 32)
        )
        vitalD298D3E1.pam = 79.0
        vitalD298D3E1.fc = 104.0
        vitalD298D3E1.paS = 110.0
        vitalD298D3E1.paD = 64.0
        vitalD298D3E1.rhythm = "Sinusal"
        vitalD298D3E1.spo2 = 96.0
        signs.append(vitalD298D3E1)

        let vital3EE56E49 = VitalSignEntry(
            vitalSignsId: "3EE56E49-71E0-465B-B6C8-3FAD988F3A39",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 30, second: 32)
        )
        vital3EE56E49.pam = 79.0
        vital3EE56E49.fc = 103.0
        vital3EE56E49.paS = 108.0
        vital3EE56E49.paD = 64.0
        vital3EE56E49.rhythm = "Sinusal"
        vital3EE56E49.spo2 = 96.0
        signs.append(vital3EE56E49)

        let vitalB1853874 = VitalSignEntry(
            vitalSignsId: "B1853874-E021-49C9-A63A-CAFFA5345D0F",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 40, second: 32)
        )
        vitalB1853874.pam = 79.0
        vitalB1853874.fc = 101.0
        vitalB1853874.paS = 106.0
        vitalB1853874.paD = 65.0
        vitalB1853874.rhythm = "Sinusal"
        vitalB1853874.spo2 = 96.0
        signs.append(vitalB1853874)

        let vitalD7C025E6 = VitalSignEntry(
            vitalSignsId: "D7C025E6-2E7F-47ED-B6FC-18A70AA9B179",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 50, second: 32)
        )
        vitalD7C025E6.pam = 78.0
        vitalD7C025E6.fc = 99.0
        vitalD7C025E6.paS = 107.0
        vitalD7C025E6.paD = 63.0
        vitalD7C025E6.rhythm = "Sinusal"
        vitalD7C025E6.spo2 = 96.0
        signs.append(vitalD7C025E6)

        let vital00D678B5 = VitalSignEntry(
            vitalSignsId: "00D678B5-2DEE-4B70-BA45-27E9F40843F2",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 0, second: 32)
        )
        vital00D678B5.pam = 79.0
        vital00D678B5.fc = 100.0
        vital00D678B5.paS = 110.0
        vital00D678B5.paD = 63.0
        vital00D678B5.rhythm = "Sinusal"
        vital00D678B5.spo2 = 96.0
        signs.append(vital00D678B5)

        let vital12717704 = VitalSignEntry(
            vitalSignsId: "12717704-0D3C-4EDB-8A91-827C39AAD31D",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 10, second: 32)
        )
        vital12717704.pam = 77.0
        vital12717704.fc = 102.0
        vital12717704.paS = 106.0
        vital12717704.paD = 63.0
        vital12717704.rhythm = "Sinusal"
        vital12717704.spo2 = 96.0
        signs.append(vital12717704)

        let vital373CA927 = VitalSignEntry(
            vitalSignsId: "373CA927-BEF8-4B94-9562-2EE3CE5F0B6D",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 20, second: 32)
        )
        vital373CA927.pam = 78.0
        vital373CA927.fc = 100.0
        vital373CA927.paS = 108.0
        vital373CA927.paD = 63.0
        vital373CA927.rhythm = "Sinusal"
        vital373CA927.spo2 = 97.0
        signs.append(vital373CA927)

        let vitalF348C38C = VitalSignEntry(
            vitalSignsId: "F348C38C-AE3C-4645-A956-845CD4D4C53F",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 30, second: 32)
        )
        vitalF348C38C.pam = 80.0
        vitalF348C38C.fc = 100.0
        vitalF348C38C.paS = 109.0
        vitalF348C38C.paD = 65.0
        vitalF348C38C.rhythm = "Sinusal"
        vitalF348C38C.spo2 = 97.0
        signs.append(vitalF348C38C)

        let vital8BD02EE0 = VitalSignEntry(
            vitalSignsId: "8BD02EE0-E3C6-4C2E-BF8C-05C2F9776F67",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 40, second: 32)
        )
        vital8BD02EE0.pam = 78.0
        vital8BD02EE0.fc = 99.0
        vital8BD02EE0.paS = 108.0
        vital8BD02EE0.paD = 63.0
        vital8BD02EE0.rhythm = "Sinusal"
        vital8BD02EE0.spo2 = 98.0
        signs.append(vital8BD02EE0)

        let vital5247492C = VitalSignEntry(
            vitalSignsId: "5247492C-AB7F-4297-A1D6-68CC7994E5B8",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 50, second: 32)
        )
        vital5247492C.pam = 79.0
        vital5247492C.fc = 98.0
        vital5247492C.paS = 110.0
        vital5247492C.paD = 63.0
        vital5247492C.rhythm = "Sinusal"
        vital5247492C.spo2 = 98.0
        signs.append(vital5247492C)

        let vital095E5684 = VitalSignEntry(
            vitalSignsId: "095E5684-49D0-459D-9DED-13203BAF8584",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 12, minute: 0, second: 32)
        )
        vital095E5684.pam = 82.0
        vital095E5684.fc = 101.0
        vital095E5684.paS = 118.0
        vital095E5684.paD = 64.0
        vital095E5684.rhythm = "Sinusal"
        vital095E5684.spo2 = 97.0
        signs.append(vital095E5684)

        let vitalE984000D = VitalSignEntry(
            vitalSignsId: "E984000D-3DF4-4581-BDEF-6C637123C40B",
            anesthesia: anesthesias[8],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 12, minute: 10, second: 32)
        )
        vitalE984000D.pam = 81.0
        vitalE984000D.fc = 101.0
        vitalE984000D.paS = 116.0
        vitalE984000D.paD = 64.0
        vitalE984000D.rhythm = "Sinusal"
        vitalE984000D.spo2 = 96.0
        signs.append(vitalE984000D)

        let vital15866A73 = VitalSignEntry(
            vitalSignsId: "15866A73-335B-4225-81F7-AFD080CD9031",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
        )
        vital15866A73.pam = 78.0
        vital15866A73.fc = 91.0
        vital15866A73.paS = 105.0
        vital15866A73.paD = 65.0
        vital15866A73.rhythm = "Sinusal"
        vital15866A73.spo2 = 97.0
        signs.append(vital15866A73)

        let vital8891C28A = VitalSignEntry(
            vitalSignsId: "8891C28A-DF62-429C-BD61-6CB2E25F5D09",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 50, second: 18)
        )
        vital8891C28A.pam = 78.0
        vital8891C28A.fc = 89.0
        vital8891C28A.paS = 105.0
        vital8891C28A.paD = 65.0
        vital8891C28A.rhythm = "Sinusal"
        vital8891C28A.spo2 = 96.0
        signs.append(vital8891C28A)

        let vital9E382C40 = VitalSignEntry(
            vitalSignsId: "9E382C40-5D1C-49E0-A8C6-35F9DF49D6F8",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 55, second: 18)
        )
        vital9E382C40.pam = 78.0
        vital9E382C40.fc = 89.0
        vital9E382C40.paS = 104.0
        vital9E382C40.paD = 65.0
        vital9E382C40.rhythm = "Sinusal"
        vital9E382C40.spo2 = 96.0
        signs.append(vital9E382C40)

        let vital8A87B0BC = VitalSignEntry(
            vitalSignsId: "8A87B0BC-B92A-4F21-B0F4-FBA84020EEBE",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 0, second: 18)
        )
        vital8A87B0BC.pam = 79.0
        vital8A87B0BC.fc = 90.0
        vital8A87B0BC.paS = 106.0
        vital8A87B0BC.paD = 65.0
        vital8A87B0BC.rhythm = "Sinusal"
        vital8A87B0BC.spo2 = 97.0
        signs.append(vital8A87B0BC)

        let vitalF3BDFD06 = VitalSignEntry(
            vitalSignsId: "F3BDFD06-31FB-4B75-947F-AA02E9468AF3",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 5, second: 18)
        )
        vitalF3BDFD06.pam = 82.0
        vitalF3BDFD06.fc = 89.0
        vitalF3BDFD06.paS = 109.0
        vitalF3BDFD06.paD = 68.0
        vitalF3BDFD06.rhythm = "Sinusal"
        vitalF3BDFD06.spo2 = 96.0
        signs.append(vitalF3BDFD06)

        let vitalA42955BD = VitalSignEntry(
            vitalSignsId: "A42955BD-394D-4902-BB08-60D0DCAB9FBD",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 10, second: 18)
        )
        vitalA42955BD.pam = 83.0
        vitalA42955BD.fc = 87.0
        vitalA42955BD.paS = 112.0
        vitalA42955BD.paD = 68.0
        vitalA42955BD.rhythm = "Sinusal"
        vitalA42955BD.spo2 = 96.0
        signs.append(vitalA42955BD)

        let vitalC04F2FC3 = VitalSignEntry(
            vitalSignsId: "C04F2FC3-7071-48AC-9860-62C64DAC7019",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 15, second: 18)
        )
        vitalC04F2FC3.pam = 83.0
        vitalC04F2FC3.fc = 89.0
        vitalC04F2FC3.paS = 108.0
        vitalC04F2FC3.paD = 70.0
        vitalC04F2FC3.rhythm = "Sinusal"
        vitalC04F2FC3.spo2 = 96.0
        signs.append(vitalC04F2FC3)

        let vital1405252E = VitalSignEntry(
            vitalSignsId: "1405252E-932D-45C1-8A8A-46B494624DE2",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 25, second: 18)
        )
        vital1405252E.pam = 81.0
        vital1405252E.fc = 90.0
        vital1405252E.paS = 111.0
        vital1405252E.paD = 66.0
        vital1405252E.rhythm = "Sinusal"
        vital1405252E.spo2 = 95.0
        signs.append(vital1405252E)

        let vital3BB04601 = VitalSignEntry(
            vitalSignsId: "3BB04601-44CB-470C-99D4-2F0650E7C9D7",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 35, second: 18)
        )
        vital3BB04601.pam = 84.0
        vital3BB04601.fc = 93.0
        vital3BB04601.paS = 114.0
        vital3BB04601.paD = 69.0
        vital3BB04601.rhythm = "Sinusal"
        vital3BB04601.spo2 = 96.0
        signs.append(vital3BB04601)

        let vital65097E3F = VitalSignEntry(
            vitalSignsId: "65097E3F-FB65-40B4-9B21-2BB66380613F",
            anesthesia: anesthesias[9],
            timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 45, second: 18)
        )
        vital65097E3F.pam = 87.0
        vital65097E3F.fc = 92.0
        vital65097E3F.paS = 118.0
        vital65097E3F.paD = 72.0
        vital65097E3F.rhythm = "Sinusal"
        vital65097E3F.spo2 = 97.0
        signs.append(vital65097E3F)

        let vital650A7046 = VitalSignEntry(
            vitalSignsId: "650A7046-071E-413E-80C3-8CBD1E6B14D1",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
        )
        vital650A7046.pam = 92.0
        vital650A7046.fc = 59.0
        vital650A7046.paS = 123.0
        vital650A7046.paD = 77.0
        vital650A7046.rhythm = "Sinusal"
        vital650A7046.etco2 = 40.0
        vital650A7046.spo2 = 98.0
        signs.append(vital650A7046)

        let vital7E2249CE = VitalSignEntry(
            vitalSignsId: "7E2249CE-A7C9-4AC5-9A14-9D780CDBE8E4",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 5, second: 56)
        )
        vital7E2249CE.pam = 92.0
        vital7E2249CE.fc = 59.0
        vital7E2249CE.paS = 122.0
        vital7E2249CE.paD = 77.0
        vital7E2249CE.rhythm = "Sinusal"
        vital7E2249CE.etco2 = 40.0
        vital7E2249CE.spo2 = 98.0
        signs.append(vital7E2249CE)

        let vitalD9C17A6E = VitalSignEntry(
            vitalSignsId: "D9C17A6E-DC16-4025-9258-40B55EBB54CD",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 10, second: 56)
        )
        vitalD9C17A6E.pam = 92.0
        vitalD9C17A6E.fc = 59.0
        vitalD9C17A6E.paS = 122.0
        vitalD9C17A6E.paD = 77.0
        vitalD9C17A6E.rhythm = "Sinusal"
        vitalD9C17A6E.etco2 = 39.0
        vitalD9C17A6E.spo2 = 98.0
        signs.append(vitalD9C17A6E)

        let vitalC00A9966 = VitalSignEntry(
            vitalSignsId: "C00A9966-0919-4B07-9FBE-6E909B8BCEBC",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 15, second: 56)
        )
        vitalC00A9966.pam = 94.0
        vitalC00A9966.fc = 61.0
        vitalC00A9966.paS = 126.0
        vitalC00A9966.paD = 78.0
        vitalC00A9966.rhythm = "Sinusal"
        vitalC00A9966.etco2 = 40.0
        vitalC00A9966.spo2 = 99.0
        signs.append(vitalC00A9966)

        let vitalE97D80E3 = VitalSignEntry(
            vitalSignsId: "E97D80E3-9AE8-4CE5-BC54-C983762CABDF",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 20, second: 56)
        )
        vitalE97D80E3.pam = 96.0
        vitalE97D80E3.fc = 60.0
        vitalE97D80E3.paS = 127.0
        vitalE97D80E3.paD = 81.0
        vitalE97D80E3.rhythm = "Sinusal"
        vitalE97D80E3.etco2 = 39.0
        vitalE97D80E3.spo2 = 99.0
        signs.append(vitalE97D80E3)

        let vital1F23C150 = VitalSignEntry(
            vitalSignsId: "1F23C150-807E-4E41-AC7C-8699ABD17DFC",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 25, second: 56)
        )
        vital1F23C150.pam = 96.0
        vital1F23C150.fc = 62.0
        vital1F23C150.paS = 129.0
        vital1F23C150.paD = 80.0
        vital1F23C150.rhythm = "Sinusal"
        vital1F23C150.etco2 = 40.0
        vital1F23C150.spo2 = 99.0
        signs.append(vital1F23C150)

        let vital00271BED = VitalSignEntry(
            vitalSignsId: "00271BED-E5E3-4F6E-8382-BB7A9BEA390D",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 30, second: 56)
        )
        vital00271BED.pam = 99.0
        vital00271BED.fc = 61.0
        vital00271BED.paS = 131.0
        vital00271BED.paD = 83.0
        vital00271BED.rhythm = "Sinusal"
        vital00271BED.etco2 = 39.0
        vital00271BED.spo2 = 98.0
        signs.append(vital00271BED)

        let vital9F7B2D38 = VitalSignEntry(
            vitalSignsId: "9F7B2D38-B5D2-4B34-B9F3-1EF33D272458",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 40, second: 56)
        )
        vital9F7B2D38.pam = 99.0
        vital9F7B2D38.fc = 62.0
        vital9F7B2D38.paS = 130.0
        vital9F7B2D38.paD = 84.0
        vital9F7B2D38.rhythm = "Sinusal"
        vital9F7B2D38.etco2 = 40.0
        vital9F7B2D38.spo2 = 99.0
        signs.append(vital9F7B2D38)

        let vital21B238F2 = VitalSignEntry(
            vitalSignsId: "21B238F2-9500-4BB3-B056-54EEA5C0BC5F",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 50, second: 56)
        )
        vital21B238F2.pam = 100.0
        vital21B238F2.fc = 63.0
        vital21B238F2.paS = 131.0
        vital21B238F2.paD = 84.0
        vital21B238F2.rhythm = "Sinusal"
        vital21B238F2.etco2 = 39.0
        vital21B238F2.spo2 = 99.0
        signs.append(vital21B238F2)

        let vital3E3B6D65 = VitalSignEntry(
            vitalSignsId: "3E3B6D65-CFC4-4E9D-B49E-C46B6CE39B65",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 0, second: 56)
        )
        vital3E3B6D65.pam = 100.0
        vital3E3B6D65.fc = 63.0
        vital3E3B6D65.paS = 131.0
        vital3E3B6D65.paD = 85.0
        vital3E3B6D65.rhythm = "Sinusal"
        vital3E3B6D65.etco2 = 38.0
        vital3E3B6D65.spo2 = 99.0
        signs.append(vital3E3B6D65)

        let vital81F9DBD2 = VitalSignEntry(
            vitalSignsId: "81F9DBD2-214A-4F9B-86EF-5945491DB351",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 10, second: 56)
        )
        vital81F9DBD2.pam = 101.0
        vital81F9DBD2.fc = 64.0
        vital81F9DBD2.paS = 132.0
        vital81F9DBD2.paD = 85.0
        vital81F9DBD2.rhythm = "Sinusal"
        vital81F9DBD2.etco2 = 38.0
        vital81F9DBD2.spo2 = 100.0
        signs.append(vital81F9DBD2)

        let vital5DBA5766 = VitalSignEntry(
            vitalSignsId: "5DBA5766-8905-49F5-BE83-FAF174554738",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 20, second: 56)
        )
        vital5DBA5766.pam = 99.0
        vital5DBA5766.fc = 62.0
        vital5DBA5766.paS = 128.0
        vital5DBA5766.paD = 85.0
        vital5DBA5766.rhythm = "Sinusal"
        vital5DBA5766.etco2 = 40.0
        vital5DBA5766.spo2 = 100.0
        signs.append(vital5DBA5766)

        let vital059DB8EC = VitalSignEntry(
            vitalSignsId: "059DB8EC-609B-45EE-9600-9FBDAE4E251D",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 30, second: 56)
        )
        vital059DB8EC.pam = 99.0
        vital059DB8EC.fc = 64.0
        vital059DB8EC.paS = 127.0
        vital059DB8EC.paD = 85.0
        vital059DB8EC.rhythm = "Sinusal"
        vital059DB8EC.etco2 = 41.0
        vital059DB8EC.spo2 = 100.0
        signs.append(vital059DB8EC)

        let vital8D42335A = VitalSignEntry(
            vitalSignsId: "8D42335A-552A-4904-B7C2-63A90D3F415C",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 40, second: 56)
        )
        vital8D42335A.pam = 99.0
        vital8D42335A.fc = 63.0
        vital8D42335A.paS = 130.0
        vital8D42335A.paD = 84.0
        vital8D42335A.rhythm = "Sinusal"
        vital8D42335A.etco2 = 41.0
        vital8D42335A.spo2 = 99.0
        signs.append(vital8D42335A)

        let vitalCC55BE4E = VitalSignEntry(
            vitalSignsId: "CC55BE4E-419E-4A58-8964-C93218A5395B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 50, second: 56)
        )
        vitalCC55BE4E.pam = 99.0
        vitalCC55BE4E.fc = 61.0
        vitalCC55BE4E.paS = 133.0
        vitalCC55BE4E.paD = 82.0
        vitalCC55BE4E.rhythm = "Sinusal"
        vitalCC55BE4E.etco2 = 41.0
        vitalCC55BE4E.spo2 = 98.0
        signs.append(vitalCC55BE4E)

        let vitalE8CA6E87 = VitalSignEntry(
            vitalSignsId: "E8CA6E87-E288-4E1C-B2A2-19D8BB63E7D9",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 0, second: 56)
        )
        vitalE8CA6E87.pam = 101.0
        vitalE8CA6E87.fc = 62.0
        vitalE8CA6E87.paS = 134.0
        vitalE8CA6E87.paD = 84.0
        vitalE8CA6E87.rhythm = "Sinusal"
        vitalE8CA6E87.etco2 = 40.0
        vitalE8CA6E87.spo2 = 98.0
        signs.append(vitalE8CA6E87)

        let vitalCCD7D0D5 = VitalSignEntry(
            vitalSignsId: "CCD7D0D5-A17B-4BA3-9A25-EC23A23C8983",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 10, second: 56)
        )
        vitalCCD7D0D5.pam = 98.0
        vitalCCD7D0D5.fc = 63.0
        vitalCCD7D0D5.paS = 129.0
        vitalCCD7D0D5.paD = 82.0
        vitalCCD7D0D5.rhythm = "Sinusal"
        vitalCCD7D0D5.etco2 = 39.0
        vitalCCD7D0D5.spo2 = 99.0
        signs.append(vitalCCD7D0D5)

        let vital6D54C255 = VitalSignEntry(
            vitalSignsId: "6D54C255-2004-4F6E-A55B-6C140EE19700",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 20, second: 56)
        )
        vital6D54C255.pam = 98.0
        vital6D54C255.fc = 64.0
        vital6D54C255.paS = 130.0
        vital6D54C255.paD = 82.0
        vital6D54C255.rhythm = "Sinusal"
        vital6D54C255.etco2 = 39.0
        vital6D54C255.spo2 = 99.0
        signs.append(vital6D54C255)

        let vital48EAC496 = VitalSignEntry(
            vitalSignsId: "48EAC496-DC5E-4900-9AB3-147C38B20A8B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 30, second: 56)
        )
        vital48EAC496.pam = 98.0
        vital48EAC496.fc = 61.0
        vital48EAC496.paS = 131.0
        vital48EAC496.paD = 82.0
        vital48EAC496.rhythm = "Sinusal"
        vital48EAC496.etco2 = 40.0
        vital48EAC496.spo2 = 99.0
        signs.append(vital48EAC496)

        let vital8BC4B9DE = VitalSignEntry(
            vitalSignsId: "8BC4B9DE-F266-4683-82B2-BAD81F2668D4",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 40, second: 56)
        )
        vital8BC4B9DE.pam = 98.0
        vital8BC4B9DE.fc = 61.0
        vital8BC4B9DE.paS = 130.0
        vital8BC4B9DE.paD = 82.0
        vital8BC4B9DE.rhythm = "Sinusal"
        vital8BC4B9DE.etco2 = 41.0
        vital8BC4B9DE.spo2 = 98.0
        signs.append(vital8BC4B9DE)

        let vitalF440588B = VitalSignEntry(
            vitalSignsId: "F440588B-AE3E-4977-B63B-066A4BC3569B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 10, minute: 50, second: 56)
        )
        vitalF440588B.pam = 99.0
        vitalF440588B.fc = 62.0
        vitalF440588B.paS = 132.0
        vitalF440588B.paD = 82.0
        vitalF440588B.rhythm = "Sinusal"
        vitalF440588B.etco2 = 40.0
        vitalF440588B.spo2 = 98.0
        signs.append(vitalF440588B)

        let vital745E9549 = VitalSignEntry(
            vitalSignsId: "745E9549-00CD-49E3-898F-FAEC33A35F61",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 0, second: 56)
        )
        vital745E9549.pam = 99.0
        vital745E9549.fc = 60.0
        vital745E9549.paS = 133.0
        vital745E9549.paD = 82.0
        vital745E9549.rhythm = "Sinusal"
        vital745E9549.etco2 = 41.0
        vital745E9549.spo2 = 98.0
        signs.append(vital745E9549)

        let vital628F87A6 = VitalSignEntry(
            vitalSignsId: "628F87A6-03CB-405B-9DED-EFC574237261",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 10, second: 56)
        )
        vital628F87A6.pam = 97.0
        vital628F87A6.fc = 62.0
        vital628F87A6.paS = 131.0
        vital628F87A6.paD = 80.0
        vital628F87A6.rhythm = "Sinusal"
        vital628F87A6.etco2 = 41.0
        vital628F87A6.spo2 = 98.0
        signs.append(vital628F87A6)

        let vitalFFC9708F = VitalSignEntry(
            vitalSignsId: "FFC9708F-F8DA-4DD1-8ACA-815F2487AE68",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 20, second: 56)
        )
        vitalFFC9708F.pam = 96.0
        vitalFFC9708F.fc = 60.0
        vitalFFC9708F.paS = 128.0
        vitalFFC9708F.paD = 80.0
        vitalFFC9708F.rhythm = "Sinusal"
        vitalFFC9708F.etco2 = 40.0
        vitalFFC9708F.spo2 = 98.0
        signs.append(vitalFFC9708F)

        let vital14872896 = VitalSignEntry(
            vitalSignsId: "14872896-FCB2-47ED-BF50-271273ECA63F",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 30, second: 56)
        )
        vital14872896.pam = 99.0
        vital14872896.fc = 62.0
        vital14872896.paS = 132.0
        vital14872896.paD = 82.0
        vital14872896.rhythm = "Sinusal"
        vital14872896.etco2 = 40.0
        vital14872896.spo2 = 98.0
        signs.append(vital14872896)

        let vital256137AC = VitalSignEntry(
            vitalSignsId: "256137AC-32DD-456C-9F35-CA03398C9D9A",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 40, second: 56)
        )
        vital256137AC.pam = 100.0
        vital256137AC.fc = 60.0
        vital256137AC.paS = 133.0
        vital256137AC.paD = 83.0
        vital256137AC.rhythm = "Sinusal"
        vital256137AC.etco2 = 40.0
        vital256137AC.spo2 = 99.0
        signs.append(vital256137AC)

        let vitalD74062E0 = VitalSignEntry(
            vitalSignsId: "D74062E0-0E56-4228-AB5F-7B37C8501707",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 50, second: 56)
        )
        vitalD74062E0.pam = 102.0
        vitalD74062E0.fc = 61.0
        vitalD74062E0.paS = 135.0
        vitalD74062E0.paD = 85.0
        vitalD74062E0.rhythm = "Sinusal"
        vitalD74062E0.etco2 = 40.0
        vitalD74062E0.spo2 = 98.0
        signs.append(vitalD74062E0)

        let vital39DF735F = VitalSignEntry(
            vitalSignsId: "39DF735F-429A-487F-85A1-831F2C114691",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 0, second: 56)
        )
        vital39DF735F.pam = 99.0
        vital39DF735F.fc = 62.0
        vital39DF735F.paS = 132.0
        vital39DF735F.paD = 82.0
        vital39DF735F.rhythm = "Sinusal"
        vital39DF735F.etco2 = 39.0
        vital39DF735F.spo2 = 98.0
        signs.append(vital39DF735F)

        let vitalF7C4B1C7 = VitalSignEntry(
            vitalSignsId: "F7C4B1C7-9F37-4E0D-9325-6538BDBD7500",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 10, second: 56)
        )
        vitalF7C4B1C7.pam = 99.0
        vitalF7C4B1C7.fc = 60.0
        vitalF7C4B1C7.paS = 134.0
        vitalF7C4B1C7.paD = 81.0
        vitalF7C4B1C7.rhythm = "Sinusal"
        vitalF7C4B1C7.etco2 = 38.0
        vitalF7C4B1C7.spo2 = 98.0
        signs.append(vitalF7C4B1C7)

        let vital3C5D87E2 = VitalSignEntry(
            vitalSignsId: "3C5D87E2-75F8-4967-BD83-8CBE2C66F697",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 20, second: 56)
        )
        vital3C5D87E2.pam = 100.0
        vital3C5D87E2.fc = 62.0
        vital3C5D87E2.paS = 134.0
        vital3C5D87E2.paD = 83.0
        vital3C5D87E2.rhythm = "Sinusal"
        vital3C5D87E2.etco2 = 38.0
        vital3C5D87E2.spo2 = 98.0
        signs.append(vital3C5D87E2)

        let vital29D880B9 = VitalSignEntry(
            vitalSignsId: "29D880B9-C798-4E3D-83BC-93D68677C6EB",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 30, second: 56)
        )
        vital29D880B9.pam = 98.0
        vital29D880B9.fc = 63.0
        vital29D880B9.paS = 132.0
        vital29D880B9.paD = 81.0
        vital29D880B9.rhythm = "Sinusal"
        vital29D880B9.etco2 = 39.0
        vital29D880B9.spo2 = 98.0
        signs.append(vital29D880B9)

        let vitalB230C31E = VitalSignEntry(
            vitalSignsId: "B230C31E-129E-4651-9C5C-FBB44B014E77",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 40, second: 56)
        )
        vitalB230C31E.pam = 98.0
        vitalB230C31E.fc = 61.0
        vitalB230C31E.paS = 131.0
        vitalB230C31E.paD = 82.0
        vitalB230C31E.rhythm = "Sinusal"
        vitalB230C31E.etco2 = 38.0
        vitalB230C31E.spo2 = 99.0
        signs.append(vitalB230C31E)

        let vitalA578BBE1 = VitalSignEntry(
            vitalSignsId: "A578BBE1-6E23-4F0D-BCC1-74C16CB6258B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 12, minute: 50, second: 56)
        )
        vitalA578BBE1.pam = 98.0
        vitalA578BBE1.fc = 62.0
        vitalA578BBE1.paS = 132.0
        vitalA578BBE1.paD = 81.0
        vitalA578BBE1.rhythm = "Sinusal"
        vitalA578BBE1.etco2 = 38.0
        vitalA578BBE1.spo2 = 99.0
        signs.append(vitalA578BBE1)

        let vital9C2B52F9 = VitalSignEntry(
            vitalSignsId: "9C2B52F9-036C-448C-B167-75CE4D9F3A3B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 0, second: 56)
        )
        vital9C2B52F9.pam = 98.0
        vital9C2B52F9.fc = 60.0
        vital9C2B52F9.paS = 131.0
        vital9C2B52F9.paD = 82.0
        vital9C2B52F9.rhythm = "Sinusal"
        vital9C2B52F9.etco2 = 38.0
        vital9C2B52F9.spo2 = 99.0
        signs.append(vital9C2B52F9)

        let vital379A99A8 = VitalSignEntry(
            vitalSignsId: "379A99A8-BC12-4326-A7EE-406832D839FF",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 10, second: 56)
        )
        vital379A99A8.pam = 98.0
        vital379A99A8.fc = 59.0
        vital379A99A8.paS = 131.0
        vital379A99A8.paD = 81.0
        vital379A99A8.rhythm = "Sinusal"
        vital379A99A8.etco2 = 38.0
        vital379A99A8.spo2 = 98.0
        signs.append(vital379A99A8)

        let vital80854695 = VitalSignEntry(
            vitalSignsId: "80854695-AD74-43A4-A8F9-D3A6E37F7072",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 20, second: 56)
        )
        vital80854695.pam = 98.0
        vital80854695.fc = 59.0
        vital80854695.paS = 129.0
        vital80854695.paD = 83.0
        vital80854695.rhythm = "Sinusal"
        vital80854695.etco2 = 39.0
        vital80854695.spo2 = 98.0
        signs.append(vital80854695)

        let vital45A35900 = VitalSignEntry(
            vitalSignsId: "45A35900-06D0-4FFC-A1AF-F2A1F8F3BA91",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 30, second: 56)
        )
        vital45A35900.pam = 97.0
        vital45A35900.fc = 59.0
        vital45A35900.paS = 129.0
        vital45A35900.paD = 81.0
        vital45A35900.rhythm = "Sinusal"
        vital45A35900.etco2 = 39.0
        vital45A35900.spo2 = 98.0
        signs.append(vital45A35900)

        let vital56D1F185 = VitalSignEntry(
            vitalSignsId: "56D1F185-1F37-4E8C-9E84-46D13E279C69",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 40, second: 56)
        )
        vital56D1F185.pam = 98.0
        vital56D1F185.fc = 60.0
        vital56D1F185.paS = 131.0
        vital56D1F185.paD = 82.0
        vital56D1F185.rhythm = "Sinusal"
        vital56D1F185.etco2 = 40.0
        vital56D1F185.spo2 = 98.0
        signs.append(vital56D1F185)

        let vitalEFD7A61D = VitalSignEntry(
            vitalSignsId: "EFD7A61D-44E4-4F0A-9A40-6869467281E0",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 13, minute: 50, second: 56)
        )
        vitalEFD7A61D.pam = 99.0
        vitalEFD7A61D.fc = 61.0
        vitalEFD7A61D.paS = 131.0
        vitalEFD7A61D.paD = 83.0
        vitalEFD7A61D.rhythm = "Sinusal"
        vitalEFD7A61D.etco2 = 40.0
        vitalEFD7A61D.spo2 = 98.0
        signs.append(vitalEFD7A61D)

        let vitalB13205DE = VitalSignEntry(
            vitalSignsId: "B13205DE-541A-4E76-8EBA-6FB6E7012D44",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 0, second: 56)
        )
        vitalB13205DE.pam = 99.0
        vitalB13205DE.fc = 61.0
        vitalB13205DE.paS = 130.0
        vitalB13205DE.paD = 83.0
        vitalB13205DE.rhythm = "Sinusal"
        vitalB13205DE.etco2 = 41.0
        vitalB13205DE.spo2 = 99.0
        signs.append(vitalB13205DE)

        let vital4D7C88F1 = VitalSignEntry(
            vitalSignsId: "4D7C88F1-71C4-43E2-9119-A451563B333C",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 10, second: 56)
        )
        vital4D7C88F1.pam = 98.0
        vital4D7C88F1.fc = 61.0
        vital4D7C88F1.paS = 129.0
        vital4D7C88F1.paD = 82.0
        vital4D7C88F1.rhythm = "Sinusal"
        vital4D7C88F1.etco2 = 41.0
        vital4D7C88F1.spo2 = 98.0
        signs.append(vital4D7C88F1)

        let vital33631942 = VitalSignEntry(
            vitalSignsId: "33631942-8022-4164-B6D4-3D3226353A47",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 20, second: 56)
        )
        vital33631942.pam = 97.0
        vital33631942.fc = 59.0
        vital33631942.paS = 127.0
        vital33631942.paD = 82.0
        vital33631942.rhythm = "Sinusal"
        vital33631942.etco2 = 40.0
        vital33631942.spo2 = 98.0
        signs.append(vital33631942)

        let vitalA494BA1F = VitalSignEntry(
            vitalSignsId: "A494BA1F-3AFB-40D7-AAFB-5D259CB46872",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 30, second: 56)
        )
        vitalA494BA1F.pam = 97.0
        vitalA494BA1F.fc = 60.0
        vitalA494BA1F.paS = 128.0
        vitalA494BA1F.paD = 81.0
        vitalA494BA1F.rhythm = "Sinusal"
        vitalA494BA1F.etco2 = 40.0
        vitalA494BA1F.spo2 = 99.0
        signs.append(vitalA494BA1F)

        let vital2FB830DD = VitalSignEntry(
            vitalSignsId: "2FB830DD-4354-4FAF-8735-89B09AB06A1E",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 40, second: 56)
        )
        vital2FB830DD.pam = 98.0
        vital2FB830DD.fc = 62.0
        vital2FB830DD.paS = 127.0
        vital2FB830DD.paD = 84.0
        vital2FB830DD.rhythm = "Sinusal"
        vital2FB830DD.etco2 = 39.0
        vital2FB830DD.spo2 = 99.0
        signs.append(vital2FB830DD)

        let vitalAB031739 = VitalSignEntry(
            vitalSignsId: "AB031739-3BCF-4073-B128-C4965350CB21",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 14, minute: 50, second: 56)
        )
        vitalAB031739.pam = 100.0
        vitalAB031739.fc = 62.0
        vitalAB031739.paS = 131.0
        vitalAB031739.paD = 85.0
        vitalAB031739.rhythm = "Sinusal"
        vitalAB031739.etco2 = 39.0
        vitalAB031739.spo2 = 99.0
        signs.append(vitalAB031739)

        let vital9F650204 = VitalSignEntry(
            vitalSignsId: "9F650204-4D82-437A-90F8-E452C24F46FE",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 15, minute: 0, second: 56)
        )
        vital9F650204.pam = 102.0
        vital9F650204.fc = 60.0
        vital9F650204.paS = 133.0
        vital9F650204.paD = 86.0
        vital9F650204.rhythm = "Sinusal"
        vital9F650204.etco2 = 39.0
        vital9F650204.spo2 = 98.0
        signs.append(vital9F650204)

        let vital83A74312 = VitalSignEntry(
            vitalSignsId: "83A74312-A6BA-4133-8DE2-39C2EF763F1B",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 15, minute: 10, second: 56)
        )
        vital83A74312.pam = 105.0
        vital83A74312.fc = 65.0
        vital83A74312.paS = 138.0
        vital83A74312.paD = 88.0
        vital83A74312.rhythm = "Sinusal"
        vital83A74312.etco2 = 39.0
        vital83A74312.spo2 = 98.0
        signs.append(vital83A74312)

        let vital9C19AF0B = VitalSignEntry(
            vitalSignsId: "9C19AF0B-CEC3-475B-B3F7-52DFCCE752B7",
            anesthesia: anesthesias[10],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 15, minute: 20, second: 56)
        )
        vital9C19AF0B.pam = 105.0
        vital9C19AF0B.fc = 65.0
        vital9C19AF0B.paS = 138.0
        vital9C19AF0B.paD = 88.0
        vital9C19AF0B.rhythm = "Sinusal"
        vital9C19AF0B.etco2 = 39.0
        vital9C19AF0B.spo2 = 98.0
        signs.append(vital9C19AF0B)

        let vital90264EF1 = VitalSignEntry(
            vitalSignsId: "90264EF1-4368-4879-943E-9FB3E1EC3E0E",
            anesthesia: anesthesias[11],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 20, second: 59)
        )
        vital90264EF1.pam = 94.0
        vital90264EF1.fc = 86.0
        vital90264EF1.paS = 129.0
        vital90264EF1.paD = 77.0
        vital90264EF1.rhythm = "Sinusal"
        vital90264EF1.spo2 = 99.0
        signs.append(vital90264EF1)

        let vital61E4FD2C = VitalSignEntry(
            vitalSignsId: "61E4FD2C-D4FD-4033-99B6-4856B0E26EDB",
            anesthesia: anesthesias[11],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 25, second: 59)
        )
        vital61E4FD2C.pam = 93.0
        vital61E4FD2C.fc = 87.0
        vital61E4FD2C.paS = 130.0
        vital61E4FD2C.paD = 75.0
        vital61E4FD2C.rhythm = "Sinusal"
        vital61E4FD2C.spo2 = 100.0
        signs.append(vital61E4FD2C)

        let vital2E666395 = VitalSignEntry(
            vitalSignsId: "2E666395-E479-41F7-A1D3-5C42C341F87B",
            anesthesia: anesthesias[11],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 30, second: 59)
        )
        vital2E666395.pam = 94.0
        vital2E666395.fc = 86.0
        vital2E666395.paS = 128.0
        vital2E666395.paD = 77.0
        vital2E666395.rhythm = "Sinusal"
        vital2E666395.spo2 = 100.0
        signs.append(vital2E666395)

        let vital6B9D3819 = VitalSignEntry(
            vitalSignsId: "6B9D3819-F402-45BD-A0D3-86F6FF75BB4F",
            anesthesia: anesthesias[11],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 35, second: 59)
        )
        vital6B9D3819.pam = 95.0
        vital6B9D3819.fc = 87.0
        vital6B9D3819.paS = 124.0
        vital6B9D3819.paD = 80.0
        vital6B9D3819.rhythm = "Sinusal"
        vital6B9D3819.spo2 = 99.0
        signs.append(vital6B9D3819)

        let vital80FBCC09 = VitalSignEntry(
            vitalSignsId: "80FBCC09-CD70-4D3C-88A2-1BCE57FC44FC",
            anesthesia: anesthesias[11],
            timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 40, second: 59)
        )
        vital80FBCC09.pam = 96.0
        vital80FBCC09.fc = 89.0
        vital80FBCC09.paS = 129.0
        vital80FBCC09.paD = 80.0
        vital80FBCC09.rhythm = "Sinusal"
        vital80FBCC09.spo2 = 100.0
        signs.append(vital80FBCC09)

        let vitalE80B6C48 = VitalSignEntry(
            vitalSignsId: "E80B6C48-93DF-446F-A185-6FFCA925026D",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 28)
        )
        vitalE80B6C48.pam = 86.0
        vitalE80B6C48.fc = 87.0
        vitalE80B6C48.paS = 106.0
        vitalE80B6C48.paD = 76.0
        vitalE80B6C48.rhythm = "Sinusal"
        vitalE80B6C48.spo2 = 98.0
        signs.append(vitalE80B6C48)

        let vitalF2157ADF = VitalSignEntry(
            vitalSignsId: "F2157ADF-BEC1-458A-8D60-379C98A7583E",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 55, second: 28)
        )
        vitalF2157ADF.pam = 86.0
        vitalF2157ADF.fc = 87.0
        vitalF2157ADF.paS = 108.0
        vitalF2157ADF.paD = 75.0
        vitalF2157ADF.rhythm = "Sinusal"
        vitalF2157ADF.spo2 = 97.0
        signs.append(vitalF2157ADF)

        let vitalE5E5C600 = VitalSignEntry(
            vitalSignsId: "E5E5C600-CD67-4CDE-9C4A-4E186244C6EF",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 0, second: 28)
        )
        vitalE5E5C600.pam = 85.0
        vitalE5E5C600.fc = 86.0
        vitalE5E5C600.paS = 109.0
        vitalE5E5C600.paD = 73.0
        vitalE5E5C600.rhythm = "Sinusal"
        vitalE5E5C600.spo2 = 97.0
        signs.append(vitalE5E5C600)

        let vital9130E690 = VitalSignEntry(
            vitalSignsId: "9130E690-4A25-4A33-9A24-783C19EB0598",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 5, second: 28)
        )
        vital9130E690.pam = 86.0
        vital9130E690.fc = 86.0
        vital9130E690.paS = 113.0
        vital9130E690.paD = 73.0
        vital9130E690.rhythm = "Sinusal"
        vital9130E690.spo2 = 97.0
        signs.append(vital9130E690)

        let vitalCF72153D = VitalSignEntry(
            vitalSignsId: "CF72153D-4F56-4408-AC70-28348D11EE26",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 10, second: 28)
        )
        vitalCF72153D.pam = 86.0
        vitalCF72153D.fc = 88.0
        vitalCF72153D.paS = 113.0
        vitalCF72153D.paD = 73.0
        vitalCF72153D.rhythm = "Sinusal"
        vitalCF72153D.spo2 = 97.0
        signs.append(vitalCF72153D)

        let vital00FAB080 = VitalSignEntry(
            vitalSignsId: "00FAB080-28AA-4AE3-ADC5-111A1C73DF1F",
            anesthesia: anesthesias[12],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 15, second: 28)
        )
        vital00FAB080.pam = 88.0
        vital00FAB080.fc = 86.0
        vital00FAB080.paS = 112.0
        vital00FAB080.paD = 76.0
        vital00FAB080.rhythm = "Sinusal"
        vital00FAB080.spo2 = 97.0
        signs.append(vital00FAB080)

        let vital27F38F26 = VitalSignEntry(
            vitalSignsId: "27F38F26-6EF0-4A34-9FA8-DDA56C5DE3F1",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
        )
        vital27F38F26.pam = 87.0
        vital27F38F26.fc = 88.0
        vital27F38F26.paS = 118.0
        vital27F38F26.paD = 71.0
        vital27F38F26.rhythm = "Sinusal"
        vital27F38F26.spo2 = 96.0
        signs.append(vital27F38F26)

        let vital49046A93 = VitalSignEntry(
            vitalSignsId: "49046A93-7248-4E9A-B130-5458DFCCE94A",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 35, second: 31)
        )
        vital49046A93.pam = 88.0
        vital49046A93.fc = 88.0
        vital49046A93.paS = 118.0
        vital49046A93.paD = 73.0
        vital49046A93.rhythm = "Sinusal"
        vital49046A93.spo2 = 96.0
        signs.append(vital49046A93)

        let vitalD954D0FC = VitalSignEntry(
            vitalSignsId: "D954D0FC-2FDD-4E98-A257-7B3057481146",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 40, second: 31)
        )
        vitalD954D0FC.pam = 88.0
        vitalD954D0FC.fc = 88.0
        vitalD954D0FC.paS = 123.0
        vitalD954D0FC.paD = 71.0
        vitalD954D0FC.rhythm = "Sinusal"
        vitalD954D0FC.spo2 = 97.0
        signs.append(vitalD954D0FC)

        let vital4D02AEFA = VitalSignEntry(
            vitalSignsId: "4D02AEFA-2D89-4A3B-BC6C-4DC71C47B497",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 45, second: 31)
        )
        vital4D02AEFA.pam = 88.0
        vital4D02AEFA.fc = 87.0
        vital4D02AEFA.paS = 119.0
        vital4D02AEFA.paD = 72.0
        vital4D02AEFA.rhythm = "Sinusal"
        vital4D02AEFA.spo2 = 98.0
        signs.append(vital4D02AEFA)

        let vitalDB2253B6 = VitalSignEntry(
            vitalSignsId: "DB2253B6-9FF0-4260-B7B3-B49CBC7C3286",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 31)
        )
        vitalDB2253B6.pam = 87.0
        vitalDB2253B6.fc = 87.0
        vitalDB2253B6.paS = 117.0
        vitalDB2253B6.paD = 72.0
        vitalDB2253B6.rhythm = "Sinusal"
        vitalDB2253B6.spo2 = 98.0
        signs.append(vitalDB2253B6)

        let vital17AEB74C = VitalSignEntry(
            vitalSignsId: "17AEB74C-6EA7-4CAE-88F6-0B67D422F114",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 55, second: 31)
        )
        vital17AEB74C.pam = 85.0
        vital17AEB74C.fc = 88.0
        vital17AEB74C.paS = 118.0
        vital17AEB74C.paD = 69.0
        vital17AEB74C.rhythm = "Sinusal"
        vital17AEB74C.spo2 = 98.0
        signs.append(vital17AEB74C)

        let vitalC029DC35 = VitalSignEntry(
            vitalSignsId: "C029DC35-ECF0-49A6-A78D-465D045F6B46",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 0, second: 31)
        )
        vitalC029DC35.pam = 88.0
        vitalC029DC35.fc = 89.0
        vitalC029DC35.paS = 119.0
        vitalC029DC35.paD = 72.0
        vitalC029DC35.rhythm = "Sinusal"
        vitalC029DC35.spo2 = 97.0
        signs.append(vitalC029DC35)

        let vitalADA9162F = VitalSignEntry(
            vitalSignsId: "ADA9162F-C48B-438C-A25A-E8BC6E2B7FA8",
            anesthesia: anesthesias[13],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 8, minute: 10, second: 31)
        )
        vitalADA9162F.pam = 90.0
        vitalADA9162F.fc = 91.0
        vitalADA9162F.paS = 121.0
        vitalADA9162F.paD = 74.0
        vitalADA9162F.rhythm = "Sinusal"
        vitalADA9162F.spo2 = 96.0
        signs.append(vitalADA9162F)

        let vital50DC50B5 = VitalSignEntry(
            vitalSignsId: "50DC50B5-BA60-4D63-A247-8BEA80A38515",
            anesthesia: anesthesias[14],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 19)
        )
        vital50DC50B5.pam = 98.0
        vital50DC50B5.fc = 66.0
        vital50DC50B5.paS = 129.0
        vital50DC50B5.paD = 83.0
        vital50DC50B5.rhythm = "Sinusal"
        vital50DC50B5.spo2 = 97.0
        signs.append(vital50DC50B5)

        let vital004C69BB = VitalSignEntry(
            vitalSignsId: "004C69BB-2AA5-43EE-B4D0-7CC5F4B44ACE",
            anesthesia: anesthesias[14],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 35, second: 19)
        )
        vital004C69BB.pam = 99.0
        vital004C69BB.fc = 65.0
        vital004C69BB.paS = 127.0
        vital004C69BB.paD = 85.0
        vital004C69BB.rhythm = "Sinusal"
        vital004C69BB.spo2 = 96.0
        signs.append(vital004C69BB)

        let vital37E07783 = VitalSignEntry(
            vitalSignsId: "37E07783-91F3-4B1D-A65C-78852FA7D464",
            anesthesia: anesthesias[14],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 40, second: 19)
        )
        vital37E07783.pam = 99.0
        vital37E07783.fc = 64.0
        vital37E07783.paS = 128.0
        vital37E07783.paD = 84.0
        vital37E07783.rhythm = "Sinusal"
        vital37E07783.spo2 = 96.0
        signs.append(vital37E07783)

        let vitalC9A297D0 = VitalSignEntry(
            vitalSignsId: "C9A297D0-48A6-4FE2-BCA8-1C99879A776A",
            anesthesia: anesthesias[14],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 45, second: 19)
        )
        vitalC9A297D0.pam = 98.0
        vitalC9A297D0.fc = 64.0
        vitalC9A297D0.paS = 126.0
        vitalC9A297D0.paD = 84.0
        vitalC9A297D0.rhythm = "Sinusal"
        vitalC9A297D0.spo2 = 96.0
        signs.append(vitalC9A297D0)

        let vitalA3C523DF = VitalSignEntry(
            vitalSignsId: "A3C523DF-30E4-42E0-9C13-81FAF5C2D6DC",
            anesthesia: anesthesias[14],
            timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 19)
        )
        vitalA3C523DF.pam = 97.0
        vitalA3C523DF.fc = 65.0
        vitalA3C523DF.paS = 123.0
        vitalA3C523DF.paD = 84.0
        vitalA3C523DF.rhythm = "Sinusal"
        vitalA3C523DF.spo2 = 97.0
        signs.append(vitalA3C523DF)

        let vital5F0008C4 = VitalSignEntry(
            vitalSignsId: "5F0008C4-01E3-4498-8B33-EA85624AF5E5",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
        )
        vital5F0008C4.pam = 81.0
        vital5F0008C4.fc = 83.0
        vital5F0008C4.paS = 90.0
        vital5F0008C4.paD = 77.0
        vital5F0008C4.rhythm = "Sinusal"
        vital5F0008C4.spo2 = 100.0
        signs.append(vital5F0008C4)

        let vital6E2DD234 = VitalSignEntry(
            vitalSignsId: "6E2DD234-D7BB-46F6-83B2-5BD2E4950FC4",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 25, second: 20)
        )
        vital6E2DD234.pam = 80.0
        vital6E2DD234.fc = 81.0
        vital6E2DD234.paS = 95.0
        vital6E2DD234.paD = 73.0
        vital6E2DD234.rhythm = "Sinusal"
        vital6E2DD234.spo2 = 99.0
        signs.append(vital6E2DD234)

        let vitalF3A500C7 = VitalSignEntry(
            vitalSignsId: "F3A500C7-2370-4716-8F64-F6E2F4618766",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 30, second: 20)
        )
        vitalF3A500C7.pam = 83.0
        vitalF3A500C7.fc = 83.0
        vitalF3A500C7.paS = 97.0
        vitalF3A500C7.paD = 76.0
        vitalF3A500C7.rhythm = "Sinusal"
        vitalF3A500C7.spo2 = 99.0
        signs.append(vitalF3A500C7)

        let vital374B3257 = VitalSignEntry(
            vitalSignsId: "374B3257-9043-44A5-A5A6-213F90162009",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 35, second: 20)
        )
        vital374B3257.pam = 81.0
        vital374B3257.fc = 80.0
        vital374B3257.paS = 91.0
        vital374B3257.paD = 76.0
        vital374B3257.rhythm = "Sinusal"
        vital374B3257.spo2 = 99.0
        signs.append(vital374B3257)

        let vital4DAC8EE2 = VitalSignEntry(
            vitalSignsId: "4DAC8EE2-34B1-4DA2-8981-4F565C4B0845",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 40, second: 20)
        )
        vital4DAC8EE2.pam = 82.0
        vital4DAC8EE2.fc = 81.0
        vital4DAC8EE2.paS = 92.0
        vital4DAC8EE2.paD = 77.0
        vital4DAC8EE2.rhythm = "Sinusal"
        vital4DAC8EE2.spo2 = 99.0
        signs.append(vital4DAC8EE2)

        let vital2BD36A62 = VitalSignEntry(
            vitalSignsId: "2BD36A62-6A52-42F2-A363-E67198D73FF6",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 45, second: 20)
        )
        vital2BD36A62.pam = 82.0
        vital2BD36A62.fc = 81.0
        vital2BD36A62.paS = 93.0
        vital2BD36A62.paD = 76.0
        vital2BD36A62.rhythm = "Sinusal"
        vital2BD36A62.spo2 = 100.0
        signs.append(vital2BD36A62)

        let vitalCA569CD7 = VitalSignEntry(
            vitalSignsId: "CA569CD7-77A3-4A50-8F87-0F368E664DDD",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 50, second: 20)
        )
        vitalCA569CD7.pam = 82.0
        vitalCA569CD7.fc = 80.0
        vitalCA569CD7.paS = 90.0
        vitalCA569CD7.paD = 78.0
        vitalCA569CD7.rhythm = "Sinusal"
        vitalCA569CD7.spo2 = 100.0
        signs.append(vitalCA569CD7)

        let vital6553040A = VitalSignEntry(
            vitalSignsId: "6553040A-6F0D-491B-BD4C-6ED2289F1A7B",
            anesthesia: anesthesias[15],
            timestamp: createDate(day: 10, month: 12, year: 2025, hour: 9, minute: 0, second: 20)
        )
        vital6553040A.pam = 83.0
        vital6553040A.fc = 81.0
        vital6553040A.paS = 93.0
        vital6553040A.paD = 78.0
        vital6553040A.rhythm = "Sinusal"
        vital6553040A.spo2 = 100.0
        signs.append(vital6553040A)

        let vitalAD14DC66 = VitalSignEntry(
            vitalSignsId: "AD14DC66-13F7-4CD9-8236-9318935BE60E",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
        )
        vitalAD14DC66.pam = 92.0
        vitalAD14DC66.fc = 62.0
        vitalAD14DC66.paS = 119.0
        vitalAD14DC66.paD = 79.0
        vitalAD14DC66.rhythm = "Sinusal"
        vitalAD14DC66.spo2 = 98.0
        signs.append(vitalAD14DC66)

        let vitalADA0D2BE = VitalSignEntry(
            vitalSignsId: "ADA0D2BE-DAEF-4FDF-BC55-24C7A30FD396",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 25, second: 54)
        )
        vitalADA0D2BE.pam = 91.0
        vitalADA0D2BE.fc = 64.0
        vitalADA0D2BE.paS = 118.0
        vitalADA0D2BE.paD = 78.0
        vitalADA0D2BE.rhythm = "Sinusal"
        vitalADA0D2BE.spo2 = 99.0
        signs.append(vitalADA0D2BE)

        let vitalD29C2624 = VitalSignEntry(
            vitalSignsId: "D29C2624-22BC-4082-A8E1-62671C3858F3",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
        )
        vitalD29C2624.pam = 93.0
        vitalD29C2624.fc = 64.0
        vitalD29C2624.paS = 115.0
        vitalD29C2624.paD = 82.0
        vitalD29C2624.rhythm = "Sinusal"
        vitalD29C2624.spo2 = 98.0
        signs.append(vitalD29C2624)

        let vital8842BBF6 = VitalSignEntry(
            vitalSignsId: "8842BBF6-6951-4E20-8D32-2A97D2EC8746",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 35, second: 54)
        )
        vital8842BBF6.pam = 95.0
        vital8842BBF6.fc = 62.0
        vital8842BBF6.paS = 121.0
        vital8842BBF6.paD = 82.0
        vital8842BBF6.rhythm = "Sinusal"
        vital8842BBF6.spo2 = 98.0
        signs.append(vital8842BBF6)

        let vitalCF0348E2 = VitalSignEntry(
            vitalSignsId: "CF0348E2-F466-44B8-B447-F6F313515BCB",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 40, second: 54)
        )
        vitalCF0348E2.pam = 96.0
        vitalCF0348E2.fc = 61.0
        vitalCF0348E2.paS = 119.0
        vitalCF0348E2.paD = 85.0
        vitalCF0348E2.rhythm = "Sinusal"
        vitalCF0348E2.spo2 = 99.0
        signs.append(vitalCF0348E2)

        let vital481317AD = VitalSignEntry(
            vitalSignsId: "481317AD-44F6-4A98-BA8F-FCA9D281EFCD",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 45, second: 54)
        )
        vital481317AD.pam = 97.0
        vital481317AD.fc = 61.0
        vital481317AD.paS = 124.0
        vital481317AD.paD = 83.0
        vital481317AD.rhythm = "Sinusal"
        vital481317AD.spo2 = 99.0
        signs.append(vital481317AD)

        let vital021BD6A5 = VitalSignEntry(
            vitalSignsId: "021BD6A5-3748-4466-B65B-DE85C39474E1",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 50, second: 54)
        )
        vital021BD6A5.pam = 97.0
        vital021BD6A5.fc = 63.0
        vital021BD6A5.paS = 126.0
        vital021BD6A5.paD = 82.0
        vital021BD6A5.rhythm = "Sinusal"
        vital021BD6A5.spo2 = 100.0
        signs.append(vital021BD6A5)

        let vital2A7EE285 = VitalSignEntry(
            vitalSignsId: "2A7EE285-0F36-4524-9B80-E89E75DE480E",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 0, second: 54)
        )
        vital2A7EE285.pam = 98.0
        vital2A7EE285.fc = 63.0
        vital2A7EE285.paS = 127.0
        vital2A7EE285.paD = 84.0
        vital2A7EE285.rhythm = "Sinusal"
        vital2A7EE285.spo2 = 100.0
        signs.append(vital2A7EE285)

        let vital311B25A1 = VitalSignEntry(
            vitalSignsId: "311B25A1-E63B-4FB0-8F94-FD6897C6DB9D",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 10, second: 54)
        )
        vital311B25A1.pam = 97.0
        vital311B25A1.fc = 63.0
        vital311B25A1.paS = 122.0
        vital311B25A1.paD = 84.0
        vital311B25A1.rhythm = "Sinusal"
        vital311B25A1.spo2 = 99.0
        signs.append(vital311B25A1)

        let vital0C3DA5D3 = VitalSignEntry(
            vitalSignsId: "0C3DA5D3-6B01-4942-8095-497E77D7A8F4",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 20, second: 54)
        )
        vital0C3DA5D3.pam = 97.0
        vital0C3DA5D3.fc = 63.0
        vital0C3DA5D3.paS = 123.0
        vital0C3DA5D3.paD = 84.0
        vital0C3DA5D3.rhythm = "Sinusal"
        vital0C3DA5D3.spo2 = 100.0
        signs.append(vital0C3DA5D3)

        let vitalFE62493D = VitalSignEntry(
            vitalSignsId: "FE62493D-888D-4568-A2D2-D440862E3722",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 30, second: 54)
        )
        vitalFE62493D.pam = 97.0
        vitalFE62493D.fc = 62.0
        vitalFE62493D.paS = 125.0
        vitalFE62493D.paD = 83.0
        vitalFE62493D.rhythm = "Sinusal"
        vitalFE62493D.spo2 = 100.0
        signs.append(vitalFE62493D)

        let vitalC3F71770 = VitalSignEntry(
            vitalSignsId: "C3F71770-C6B4-45DD-A226-75591D267502",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 40, second: 54)
        )
        vitalC3F71770.pam = 98.0
        vitalC3F71770.fc = 60.0
        vitalC3F71770.paS = 124.0
        vitalC3F71770.paD = 85.0
        vitalC3F71770.rhythm = "Sinusal"
        vitalC3F71770.spo2 = 100.0
        signs.append(vitalC3F71770)

        let vital09DEC311 = VitalSignEntry(
            vitalSignsId: "09DEC311-AFF7-4B60-8B07-8D50617D3EE5",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 8, minute: 50, second: 54)
        )
        vital09DEC311.pam = 100.0
        vital09DEC311.fc = 65.0
        vital09DEC311.paS = 125.0
        vital09DEC311.paD = 87.0
        vital09DEC311.rhythm = "Sinusal"
        vital09DEC311.spo2 = 100.0
        signs.append(vital09DEC311)

        let vitalDC99450A = VitalSignEntry(
            vitalSignsId: "DC99450A-AA02-4CC5-8941-322D1BA6DC4F",
            anesthesia: anesthesias[16],
            timestamp: createDate(day: 9, month: 12, year: 2025, hour: 9, minute: 0, second: 54)
        )
        vitalDC99450A.pam = 99.0
        vitalDC99450A.fc = 64.0
        vitalDC99450A.paS = 127.0
        vitalDC99450A.paD = 85.0
        vitalDC99450A.rhythm = "Sinusal"
        vitalDC99450A.spo2 = 99.0
        signs.append(vitalDC99450A)

        let vitalF4FB5111 = VitalSignEntry(
            vitalSignsId: "F4FB5111-FE85-4DFE-9DB9-189454FFD025",
            anesthesia: anesthesias[17],
            timestamp: createDate(day: 8, month: 12, year: 2025, hour: 7, minute: 55, second: 56)
        )
        vitalF4FB5111.pam = 87.0
        vitalF4FB5111.fc = 87.0
        vitalF4FB5111.paS = 100.0
        vitalF4FB5111.paD = 80.0
        vitalF4FB5111.rhythm = "Sinusal"
        vitalF4FB5111.spo2 = 99.0
        signs.append(vitalF4FB5111)

        let vital29702024 = VitalSignEntry(
            vitalSignsId: "29702024-F0DB-4A37-B35B-A59A5938A2C1",
            anesthesia: anesthesias[17],
            timestamp: createDate(day: 8, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
        )
        vital29702024.pam = 87.0
        vital29702024.fc = 86.0
        vital29702024.paS = 106.0
        vital29702024.paD = 78.0
        vital29702024.rhythm = "Sinusal"
        vital29702024.spo2 = 100.0
        signs.append(vital29702024)

        let vitalA9BEE0FE = VitalSignEntry(
            vitalSignsId: "A9BEE0FE-E8ED-4C9D-A10C-DF3C98F4E671",
            anesthesia: anesthesias[17],
            timestamp: createDate(day: 8, month: 12, year: 2025, hour: 8, minute: 5, second: 56)
        )
        vitalA9BEE0FE.pam = 87.0
        vitalA9BEE0FE.fc = 85.0
        vitalA9BEE0FE.paS = 104.0
        vitalA9BEE0FE.paD = 78.0
        vitalA9BEE0FE.rhythm = "Sinusal"
        vitalA9BEE0FE.spo2 = 99.0
        signs.append(vitalA9BEE0FE)

        let vital971110F2 = VitalSignEntry(
            vitalSignsId: "971110F2-290A-4C6B-85B8-EB25E632F390",
            anesthesia: anesthesias[17],
            timestamp: createDate(day: 8, month: 12, year: 2025, hour: 8, minute: 10, second: 56)
        )
        vital971110F2.pam = 89.0
        vital971110F2.fc = 85.0
        vital971110F2.paS = 107.0
        vital971110F2.paD = 80.0
        vital971110F2.rhythm = "Sinusal"
        vital971110F2.spo2 = 99.0
        signs.append(vital971110F2)

        let vital63AF5639 = VitalSignEntry(
            vitalSignsId: "63AF5639-1C1B-4BF2-8BA6-393C2A049E5D",
            anesthesia: anesthesias[17],
            timestamp: createDate(day: 8, month: 12, year: 2025, hour: 8, minute: 15, second: 56)
        )
        vital63AF5639.pam = 89.0
        vital63AF5639.fc = 84.0
        vital63AF5639.paS = 108.0
        vital63AF5639.paD = 80.0
        vital63AF5639.rhythm = "Sinusal"
        vital63AF5639.spo2 = 98.0
        signs.append(vital63AF5639)

        let vitalDFAF28D9 = VitalSignEntry(
            vitalSignsId: "DFAF28D9-A6A2-44D6-83AF-A98B91CBF808",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
        )
        vitalDFAF28D9.pam = 64.0
        vitalDFAF28D9.fc = 119.0
        vitalDFAF28D9.paS = 77.0
        vitalDFAF28D9.paD = 57.0
        vitalDFAF28D9.rhythm = "Sinusal"
        vitalDFAF28D9.etco2 = 33.0
        vitalDFAF28D9.spo2 = 98.0
        signs.append(vitalDFAF28D9)

        let vitalAE937168 = VitalSignEntry(
            vitalSignsId: "AE937168-AE5B-4DCA-8285-7A6E8F711274",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 25, second: 34)
        )
        vitalAE937168.pam = 62.0
        vitalAE937168.fc = 119.0
        vitalAE937168.paS = 75.0
        vitalAE937168.paD = 55.0
        vitalAE937168.rhythm = "Sinusal"
        vitalAE937168.etco2 = 34.0
        vitalAE937168.spo2 = 98.0
        signs.append(vitalAE937168)

        let vital173D0766 = VitalSignEntry(
            vitalSignsId: "173D0766-EE76-4529-9952-872827D53408",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 30, second: 34)
        )
        vital173D0766.pam = 62.0
        vital173D0766.fc = 119.0
        vital173D0766.paS = 75.0
        vital173D0766.paD = 55.0
        vital173D0766.rhythm = "Sinusal"
        vital173D0766.etco2 = 35.0
        vital173D0766.spo2 = 98.0
        signs.append(vital173D0766)

        let vitalF52A11C3 = VitalSignEntry(
            vitalSignsId: "F52A11C3-A069-4A11-B6C7-8395727077F3",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 35, second: 34)
        )
        vitalF52A11C3.pam = 64.0
        vitalF52A11C3.fc = 120.0
        vitalF52A11C3.paS = 79.0
        vitalF52A11C3.paD = 57.0
        vitalF52A11C3.rhythm = "Sinusal"
        vitalF52A11C3.etco2 = 35.0
        vitalF52A11C3.spo2 = 99.0
        signs.append(vitalF52A11C3)

        let vital7A20A33D = VitalSignEntry(
            vitalSignsId: "7A20A33D-EC84-4AC2-8517-C5C314F75767",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 40, second: 34)
        )
        vital7A20A33D.pam = 65.0
        vital7A20A33D.fc = 122.0
        vital7A20A33D.paS = 79.0
        vital7A20A33D.paD = 58.0
        vital7A20A33D.rhythm = "Sinusal"
        vital7A20A33D.etco2 = 34.0
        vital7A20A33D.spo2 = 98.0
        signs.append(vital7A20A33D)

        let vitalE21BCB32 = VitalSignEntry(
            vitalSignsId: "E21BCB32-A97E-420D-A297-4E56456D8301",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 45, second: 34)
        )
        vitalE21BCB32.pam = 66.0
        vitalE21BCB32.fc = 122.0
        vitalE21BCB32.paS = 79.0
        vitalE21BCB32.paD = 60.0
        vitalE21BCB32.rhythm = "Sinusal"
        vitalE21BCB32.etco2 = 34.0
        vitalE21BCB32.spo2 = 98.0
        signs.append(vitalE21BCB32)

        let vitalC46BEA32 = VitalSignEntry(
            vitalSignsId: "C46BEA32-1D3F-4115-B656-9CC99AFC5867",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 50, second: 34)
        )
        vitalC46BEA32.pam = 66.0
        vitalC46BEA32.fc = 124.0
        vitalC46BEA32.paS = 80.0
        vitalC46BEA32.paD = 59.0
        vitalC46BEA32.rhythm = "Sinusal"
        vitalC46BEA32.etco2 = 35.0
        vitalC46BEA32.spo2 = 98.0
        signs.append(vitalC46BEA32)

        let vitalE2F43EC8 = VitalSignEntry(
            vitalSignsId: "E2F43EC8-C7B0-422C-BF65-1EFDDB1587C6",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 0, second: 34)
        )
        vitalE2F43EC8.pam = 66.0
        vitalE2F43EC8.fc = 123.0
        vitalE2F43EC8.paS = 81.0
        vitalE2F43EC8.paD = 59.0
        vitalE2F43EC8.rhythm = "Sinusal"
        vitalE2F43EC8.etco2 = 34.0
        vitalE2F43EC8.spo2 = 98.0
        signs.append(vitalE2F43EC8)

        let vital830A823B = VitalSignEntry(
            vitalSignsId: "830A823B-4153-4986-89DB-B99971582810",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 10, second: 34)
        )
        vital830A823B.pam = 68.0
        vital830A823B.fc = 122.0
        vital830A823B.paS = 83.0
        vital830A823B.paD = 61.0
        vital830A823B.rhythm = "Sinusal"
        vital830A823B.etco2 = 35.0
        vital830A823B.spo2 = 98.0
        signs.append(vital830A823B)

        let vital3D2837F7 = VitalSignEntry(
            vitalSignsId: "3D2837F7-8514-42E3-8509-6CD3253FF2DD",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
        )
        vital3D2837F7.pam = 68.0
        vital3D2837F7.fc = 123.0
        vital3D2837F7.paS = 84.0
        vital3D2837F7.paD = 60.0
        vital3D2837F7.rhythm = "Sinusal"
        vital3D2837F7.etco2 = 35.0
        vital3D2837F7.spo2 = 98.0
        signs.append(vital3D2837F7)

        let vital19D2EDA0 = VitalSignEntry(
            vitalSignsId: "19D2EDA0-C877-441C-A405-61AF5E2E965A",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 30, second: 34)
        )
        vital19D2EDA0.pam = 68.0
        vital19D2EDA0.fc = 122.0
        vital19D2EDA0.paS = 84.0
        vital19D2EDA0.paD = 60.0
        vital19D2EDA0.rhythm = "Sinusal"
        vital19D2EDA0.etco2 = 35.0
        vital19D2EDA0.spo2 = 98.0
        signs.append(vital19D2EDA0)

        let vital2B9782A2 = VitalSignEntry(
            vitalSignsId: "2B9782A2-A48C-4EB5-8388-0A7551F3830E",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 40, second: 34)
        )
        vital2B9782A2.pam = 70.0
        vital2B9782A2.fc = 121.0
        vital2B9782A2.paS = 85.0
        vital2B9782A2.paD = 62.0
        vital2B9782A2.rhythm = "Sinusal"
        vital2B9782A2.etco2 = 34.0
        vital2B9782A2.spo2 = 98.0
        signs.append(vital2B9782A2)

        let vital87DC1B30 = VitalSignEntry(
            vitalSignsId: "87DC1B30-E6B1-44F6-A574-D019DB3929A2",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 50, second: 34)
        )
        vital87DC1B30.pam = 70.0
        vital87DC1B30.fc = 122.0
        vital87DC1B30.paS = 86.0
        vital87DC1B30.paD = 62.0
        vital87DC1B30.rhythm = "Sinusal"
        vital87DC1B30.etco2 = 34.0
        vital87DC1B30.spo2 = 98.0
        signs.append(vital87DC1B30)

        let vitalDA05B779 = VitalSignEntry(
            vitalSignsId: "DA05B779-2A60-4869-A66B-93EDDE109288",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 0, second: 34)
        )
        vitalDA05B779.pam = 68.0
        vitalDA05B779.fc = 124.0
        vitalDA05B779.paS = 85.0
        vitalDA05B779.paD = 60.0
        vitalDA05B779.rhythm = "Sinusal"
        vitalDA05B779.etco2 = 34.0
        vitalDA05B779.spo2 = 98.0
        signs.append(vitalDA05B779)

        let vital9A66A211 = VitalSignEntry(
            vitalSignsId: "9A66A211-170F-4255-B6B5-BAA006D588E5",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 10, second: 34)
        )
        vital9A66A211.pam = 69.0
        vital9A66A211.fc = 124.0
        vital9A66A211.paS = 82.0
        vital9A66A211.paD = 63.0
        vital9A66A211.rhythm = "Sinusal"
        vital9A66A211.etco2 = 35.0
        vital9A66A211.spo2 = 98.0
        signs.append(vital9A66A211)

        let vital97F0B158 = VitalSignEntry(
            vitalSignsId: "97F0B158-26A6-4B02-9377-CCCB62EF6C06",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 20, second: 34)
        )
        vital97F0B158.pam = 66.0
        vital97F0B158.fc = 123.0
        vital97F0B158.paS = 79.0
        vital97F0B158.paD = 60.0
        vital97F0B158.rhythm = "Sinusal"
        vital97F0B158.etco2 = 35.0
        vital97F0B158.spo2 = 98.0
        signs.append(vital97F0B158)

        let vital6E23D9CF = VitalSignEntry(
            vitalSignsId: "6E23D9CF-2AE7-4EED-BF69-412999F0E6D1",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 30, second: 34)
        )
        vital6E23D9CF.pam = 68.0
        vital6E23D9CF.fc = 124.0
        vital6E23D9CF.paS = 82.0
        vital6E23D9CF.paD = 61.0
        vital6E23D9CF.rhythm = "Sinusal"
        vital6E23D9CF.etco2 = 35.0
        vital6E23D9CF.spo2 = 99.0
        signs.append(vital6E23D9CF)

        let vital9F07F44C = VitalSignEntry(
            vitalSignsId: "9F07F44C-63BB-44AA-9697-7F875230705A",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 40, second: 34)
        )
        vital9F07F44C.pam = 71.0
        vital9F07F44C.fc = 125.0
        vital9F07F44C.paS = 86.0
        vital9F07F44C.paD = 63.0
        vital9F07F44C.rhythm = "Sinusal"
        vital9F07F44C.etco2 = 34.0
        vital9F07F44C.spo2 = 98.0
        signs.append(vital9F07F44C)

        let vitalD6B38C3C = VitalSignEntry(
            vitalSignsId: "D6B38C3C-0B10-45AA-AA64-B5E0FF830D0E",
            anesthesia: anesthesias[18],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 10, minute: 50, second: 34)
        )
        vitalD6B38C3C.pam = 73.0
        vitalD6B38C3C.fc = 125.0
        vitalD6B38C3C.paS = 91.0
        vitalD6B38C3C.paD = 64.0
        vitalD6B38C3C.rhythm = "Sinusal"
        vitalD6B38C3C.etco2 = 33.0
        vitalD6B38C3C.spo2 = 98.0
        signs.append(vitalD6B38C3C)

        let vital58B07507 = VitalSignEntry(
            vitalSignsId: "58B07507-59D7-479D-8945-BC52F7DB9A68",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
        )
        vital58B07507.pam = 93.0
        vital58B07507.fc = 90.0
        vital58B07507.paS = 122.0
        vital58B07507.paD = 79.0
        vital58B07507.rhythm = "Sinusal"
        vital58B07507.spo2 = 100.0
        signs.append(vital58B07507)

        let vitalF52C1B90 = VitalSignEntry(
            vitalSignsId: "F52C1B90-23C6-4219-AC31-7B5122F3B59B",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 25, second: 54)
        )
        vitalF52C1B90.pam = 93.0
        vitalF52C1B90.fc = 92.0
        vitalF52C1B90.paS = 122.0
        vitalF52C1B90.paD = 79.0
        vitalF52C1B90.rhythm = "Sinusal"
        vitalF52C1B90.spo2 = 100.0
        signs.append(vitalF52C1B90)

        let vital98EEF96C = VitalSignEntry(
            vitalSignsId: "98EEF96C-ABF1-4C8D-8BD0-13930F327379",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
        )
        vital98EEF96C.pam = 93.0
        vital98EEF96C.fc = 93.0
        vital98EEF96C.paS = 122.0
        vital98EEF96C.paD = 79.0
        vital98EEF96C.rhythm = "Sinusal"
        vital98EEF96C.spo2 = 100.0
        signs.append(vital98EEF96C)

        let vital88BCE480 = VitalSignEntry(
            vitalSignsId: "88BCE480-EF76-4616-AD53-0D38D2EA16FF",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 35, second: 54)
        )
        vital88BCE480.pam = 101.0
        vital88BCE480.fc = 91.0
        vital88BCE480.paS = 134.0
        vital88BCE480.paD = 85.0
        vital88BCE480.rhythm = "Sinusal"
        vital88BCE480.spo2 = 100.0
        signs.append(vital88BCE480)

        let vital21B72E71 = VitalSignEntry(
            vitalSignsId: "21B72E71-A43E-49A4-B9BA-B4FEE6BA69B8",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 40, second: 54)
        )
        vital21B72E71.pam = 103.0
        vital21B72E71.fc = 91.0
        vital21B72E71.paS = 135.0
        vital21B72E71.paD = 87.0
        vital21B72E71.rhythm = "Sinusal"
        vital21B72E71.spo2 = 100.0
        signs.append(vital21B72E71)

        let vitalA1715001 = VitalSignEntry(
            vitalSignsId: "A1715001-79B5-4F4F-A4D9-7285C659FE56",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 45, second: 54)
        )
        vitalA1715001.pam = 104.0
        vitalA1715001.fc = 90.0
        vitalA1715001.paS = 134.0
        vitalA1715001.paD = 89.0
        vitalA1715001.rhythm = "Sinusal"
        vitalA1715001.spo2 = 100.0
        signs.append(vitalA1715001)

        let vitalB79D87CA = VitalSignEntry(
            vitalSignsId: "B79D87CA-DA1E-4AB5-9FC1-EBC7553FE499",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 50, second: 54)
        )
        vitalB79D87CA.pam = 104.0
        vitalB79D87CA.fc = 89.0
        vitalB79D87CA.paS = 137.0
        vitalB79D87CA.paD = 88.0
        vitalB79D87CA.rhythm = "Sinusal"
        vitalB79D87CA.spo2 = 100.0
        signs.append(vitalB79D87CA)

        let vital0177C8C8 = VitalSignEntry(
            vitalSignsId: "0177C8C8-BF8B-463D-94DD-CC8AF29BEEC6",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 0, second: 54)
        )
        vital0177C8C8.pam = 111.0
        vital0177C8C8.fc = 88.0
        vital0177C8C8.paS = 147.0
        vital0177C8C8.paD = 93.0
        vital0177C8C8.rhythm = "Sinusal"
        vital0177C8C8.spo2 = 100.0
        signs.append(vital0177C8C8)

        let vital5156B1CC = VitalSignEntry(
            vitalSignsId: "5156B1CC-8F36-4D7B-9A34-421FD108D57B",
            anesthesia: anesthesias[19],
            timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 10, second: 54)
        )
        vital5156B1CC.pam = 113.0
        vital5156B1CC.fc = 86.0
        vital5156B1CC.paS = 148.0
        vital5156B1CC.paD = 95.0
        vital5156B1CC.rhythm = "Sinusal"
        vital5156B1CC.spo2 = 100.0
        signs.append(vital5156B1CC)

        let vitalBA084232 = VitalSignEntry(
            vitalSignsId: "BA084232-CF50-4CB5-9558-983CBE410A60",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
        )
        vitalBA084232.pam = 79.0
        vitalBA084232.fc = 104.0
        vitalBA084232.paS = 96.0
        vitalBA084232.paD = 71.0
        vitalBA084232.rhythm = "Sinusal"
        vitalBA084232.spo2 = 98.0
        signs.append(vitalBA084232)

        let vital429A6C5B = VitalSignEntry(
            vitalSignsId: "429A6C5B-C915-428C-A348-2DEAFBB4502D",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 35, second: 9)
        )
        vital429A6C5B.pam = 79.0
        vital429A6C5B.fc = 106.0
        vital429A6C5B.paS = 96.0
        vital429A6C5B.paD = 71.0
        vital429A6C5B.rhythm = "Sinusal"
        vital429A6C5B.spo2 = 98.0
        signs.append(vital429A6C5B)

        let vital68883E96 = VitalSignEntry(
            vitalSignsId: "68883E96-6553-4D5D-B8F4-9EAD70B0E68A",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 40, second: 9)
        )
        vital68883E96.pam = 80.0
        vital68883E96.fc = 107.0
        vital68883E96.paS = 97.0
        vital68883E96.paD = 72.0
        vital68883E96.rhythm = "Sinusal"
        vital68883E96.spo2 = 99.0
        signs.append(vital68883E96)

        let vitalAB07FF38 = VitalSignEntry(
            vitalSignsId: "AB07FF38-53B8-4BB8-A994-A3D93D467F3B",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 45, second: 9)
        )
        vitalAB07FF38.pam = 81.0
        vitalAB07FF38.fc = 104.0
        vitalAB07FF38.paS = 94.0
        vitalAB07FF38.paD = 75.0
        vitalAB07FF38.rhythm = "Sinusal"
        vitalAB07FF38.spo2 = 100.0
        signs.append(vitalAB07FF38)

        let vital5D8210D6 = VitalSignEntry(
            vitalSignsId: "5D8210D6-AADF-4EE0-9326-FBB8DF42AA98",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 50, second: 9)
        )
        vital5D8210D6.pam = 81.0
        vital5D8210D6.fc = 103.0
        vital5D8210D6.paS = 93.0
        vital5D8210D6.paD = 75.0
        vital5D8210D6.rhythm = "Sinusal"
        vital5D8210D6.spo2 = 99.0
        signs.append(vital5D8210D6)

        let vital7211DD78 = VitalSignEntry(
            vitalSignsId: "7211DD78-6647-439C-94FD-F398A77D78D2",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 55, second: 9)
        )
        vital7211DD78.pam = 80.0
        vital7211DD78.fc = 101.0
        vital7211DD78.paS = 94.0
        vital7211DD78.paD = 73.0
        vital7211DD78.rhythm = "Sinusal"
        vital7211DD78.spo2 = 99.0
        signs.append(vital7211DD78)

        let vitalF62C0A8B = VitalSignEntry(
            vitalSignsId: "F62C0A8B-1566-4AB2-85EF-2C5D39D58DC1",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 11, minute: 0, second: 9)
        )
        vitalF62C0A8B.pam = 82.0
        vitalF62C0A8B.fc = 102.0
        vitalF62C0A8B.paS = 95.0
        vitalF62C0A8B.paD = 75.0
        vitalF62C0A8B.rhythm = "Sinusal"
        vitalF62C0A8B.spo2 = 99.0
        signs.append(vitalF62C0A8B)

        let vital9F42A7C9 = VitalSignEntry(
            vitalSignsId: "9F42A7C9-9EAE-429C-B57B-4832233378DF",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 11, minute: 10, second: 9)
        )
        vital9F42A7C9.pam = 83.0
        vital9F42A7C9.fc = 106.0
        vital9F42A7C9.paS = 100.0
        vital9F42A7C9.paD = 75.0
        vital9F42A7C9.rhythm = "Sinusal"
        vital9F42A7C9.spo2 = 99.0
        signs.append(vital9F42A7C9)

        let vital7321DA6A = VitalSignEntry(
            vitalSignsId: "7321DA6A-CCAB-403E-9F11-A11ACFA85A16",
            anesthesia: anesthesias[20],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 11, minute: 20, second: 9)
        )
        vital7321DA6A.pam = 82.0
        vital7321DA6A.fc = 107.0
        vital7321DA6A.paS = 101.0
        vital7321DA6A.paD = 73.0
        vital7321DA6A.rhythm = "Sinusal"
        vital7321DA6A.spo2 = 99.0
        signs.append(vital7321DA6A)

        let vital58AA8E49 = VitalSignEntry(
            vitalSignsId: "58AA8E49-98D1-48CC-B4FE-642044182FF3",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
        )
        vital58AA8E49.pam = 59.0
        vital58AA8E49.fc = 151.0
        vital58AA8E49.paS = 78.0
        vital58AA8E49.paD = 50.0
        vital58AA8E49.rhythm = "Sinusal"
        vital58AA8E49.spo2 = 96.0
        signs.append(vital58AA8E49)

        let vitalFA469118 = VitalSignEntry(
            vitalSignsId: "FA469118-C54D-4B80-A2AE-2599806F06F2",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 25, second: 53)
        )
        vitalFA469118.pam = 57.0
        vitalFA469118.fc = 152.0
        vitalFA469118.paS = 74.0
        vitalFA469118.paD = 49.0
        vitalFA469118.rhythm = "Sinusal"
        vitalFA469118.spo2 = 96.0
        signs.append(vitalFA469118)

        let vital169A49D4 = VitalSignEntry(
            vitalSignsId: "169A49D4-7351-4CF5-81DD-BB2B9145AD46",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 30, second: 53)
        )
        vital169A49D4.pam = 57.0
        vital169A49D4.fc = 151.0
        vital169A49D4.paS = 73.0
        vital169A49D4.paD = 49.0
        vital169A49D4.rhythm = "Sinusal"
        vital169A49D4.spo2 = 97.0
        signs.append(vital169A49D4)

        let vital1428A47A = VitalSignEntry(
            vitalSignsId: "1428A47A-4BCB-454A-9E89-A59591DF16B5",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 35, second: 53)
        )
        vital1428A47A.pam = 59.0
        vital1428A47A.fc = 148.0
        vital1428A47A.paS = 75.0
        vital1428A47A.paD = 51.0
        vital1428A47A.rhythm = "Sinusal"
        vital1428A47A.spo2 = 96.0
        signs.append(vital1428A47A)

        let vitalC107C044 = VitalSignEntry(
            vitalSignsId: "C107C044-5697-42B8-9F87-EDF253325F34",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 40, second: 53)
        )
        vitalC107C044.pam = 60.0
        vitalC107C044.fc = 146.0
        vitalC107C044.paS = 78.0
        vitalC107C044.paD = 51.0
        vitalC107C044.rhythm = "Sinusal"
        vitalC107C044.spo2 = 96.0
        signs.append(vitalC107C044)

        let vital75C27832 = VitalSignEntry(
            vitalSignsId: "75C27832-484D-4058-ABF7-935FE49B5E4F",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 45, second: 53)
        )
        vital75C27832.pam = 60.0
        vital75C27832.fc = 146.0
        vital75C27832.paS = 74.0
        vital75C27832.paD = 53.0
        vital75C27832.rhythm = "Sinusal"
        vital75C27832.spo2 = 97.0
        signs.append(vital75C27832)

        let vital5BE6B0A0 = VitalSignEntry(
            vitalSignsId: "5BE6B0A0-FEEC-4677-9F89-53E4A4F9A94B",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 50, second: 53)
        )
        vital5BE6B0A0.pam = 60.0
        vital5BE6B0A0.fc = 144.0
        vital5BE6B0A0.paS = 73.0
        vital5BE6B0A0.paD = 53.0
        vital5BE6B0A0.rhythm = "Sinusal"
        vital5BE6B0A0.spo2 = 97.0
        signs.append(vital5BE6B0A0)

        let vitalD4EFCCA4 = VitalSignEntry(
            vitalSignsId: "D4EFCCA4-C174-4F1E-9126-5AFE3A9B5140",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 9, minute: 0, second: 53)
        )
        vitalD4EFCCA4.pam = 59.0
        vitalD4EFCCA4.fc = 144.0
        vitalD4EFCCA4.paS = 77.0
        vitalD4EFCCA4.paD = 50.0
        vitalD4EFCCA4.rhythm = "Sinusal"
        vitalD4EFCCA4.spo2 = 97.0
        signs.append(vitalD4EFCCA4)

        let vitalE5E6D601 = VitalSignEntry(
            vitalSignsId: "E5E6D601-7AB5-44EB-9CE6-459DE7785DA4",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 9, minute: 10, second: 53)
        )
        vitalE5E6D601.pam = 60.0
        vitalE5E6D601.fc = 147.0
        vitalE5E6D601.paS = 79.0
        vitalE5E6D601.paD = 50.0
        vitalE5E6D601.rhythm = "Sinusal"
        vitalE5E6D601.spo2 = 97.0
        signs.append(vitalE5E6D601)

        let vitalB45A9B68 = VitalSignEntry(
            vitalSignsId: "B45A9B68-0497-4276-851C-AD277D12F309",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 9, minute: 20, second: 53)
        )
        vitalB45A9B68.pam = 58.0
        vitalB45A9B68.fc = 145.0
        vitalB45A9B68.paS = 76.0
        vitalB45A9B68.paD = 49.0
        vitalB45A9B68.rhythm = "Sinusal"
        vitalB45A9B68.spo2 = 97.0
        signs.append(vitalB45A9B68)

        let vital0589FEFC = VitalSignEntry(
            vitalSignsId: "0589FEFC-54DC-4852-A7D1-F1E60C291B8C",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 9, minute: 30, second: 53)
        )
        vital0589FEFC.pam = 63.0
        vital0589FEFC.fc = 151.0
        vital0589FEFC.paS = 82.0
        vital0589FEFC.paD = 53.0
        vital0589FEFC.rhythm = "Sinusal"
        vital0589FEFC.spo2 = 96.0
        signs.append(vital0589FEFC)

        let vital69FBFC7A = VitalSignEntry(
            vitalSignsId: "69FBFC7A-9A2E-42C1-A602-98FC00110839",
            anesthesia: anesthesias[21],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 9, minute: 40, second: 53)
        )
        vital69FBFC7A.pam = 63.0
        vital69FBFC7A.fc = 152.0
        vital69FBFC7A.paS = 83.0
        vital69FBFC7A.paD = 53.0
        vital69FBFC7A.rhythm = "Sinusal"
        vital69FBFC7A.spo2 = 96.0
        signs.append(vital69FBFC7A)

        let vital010A4BE4 = VitalSignEntry(
            vitalSignsId: "010A4BE4-7AC1-4872-B9F1-E79A3B090BF4",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
        )
        vital010A4BE4.pam = 95.0
        vital010A4BE4.fc = 84.0
        vital010A4BE4.paS = 131.0
        vital010A4BE4.paD = 77.0
        vital010A4BE4.rhythm = "Sinusal"
        vital010A4BE4.spo2 = 100.0
        signs.append(vital010A4BE4)

        let vital19CD7CC9 = VitalSignEntry(
            vitalSignsId: "19CD7CC9-2504-458B-81A6-04C4DD1CAC49",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 20, second: 21)
        )
        vital19CD7CC9.pam = 97.0
        vital19CD7CC9.fc = 85.0
        vital19CD7CC9.paS = 133.0
        vital19CD7CC9.paD = 79.0
        vital19CD7CC9.rhythm = "Sinusal"
        vital19CD7CC9.spo2 = 100.0
        signs.append(vital19CD7CC9)

        let vital336D9F06 = VitalSignEntry(
            vitalSignsId: "336D9F06-4FCD-4CD1-A18D-23E959F60050",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 25, second: 21)
        )
        vital336D9F06.pam = 96.0
        vital336D9F06.fc = 84.0
        vital336D9F06.paS = 131.0
        vital336D9F06.paD = 79.0
        vital336D9F06.rhythm = "Sinusal"
        vital336D9F06.spo2 = 100.0
        signs.append(vital336D9F06)

        let vital505B343C = VitalSignEntry(
            vitalSignsId: "505B343C-84A0-4636-AD0B-7AB554C21C5F",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 30, second: 21)
        )
        vital505B343C.pam = 96.0
        vital505B343C.fc = 81.0
        vital505B343C.paS = 130.0
        vital505B343C.paD = 79.0
        vital505B343C.rhythm = "Sinusal"
        vital505B343C.spo2 = 100.0
        signs.append(vital505B343C)

        let vital98D92760 = VitalSignEntry(
            vitalSignsId: "98D92760-D395-40AF-8A31-B2F9638E8316",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 35, second: 21)
        )
        vital98D92760.pam = 95.0
        vital98D92760.fc = 83.0
        vital98D92760.paS = 126.0
        vital98D92760.paD = 80.0
        vital98D92760.rhythm = "Sinusal"
        vital98D92760.spo2 = 100.0
        signs.append(vital98D92760)

        let vital13F801D9 = VitalSignEntry(
            vitalSignsId: "13F801D9-191E-4B6B-88FA-30C7FD9C5EE7",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 40, second: 21)
        )
        vital13F801D9.pam = 95.0
        vital13F801D9.fc = 84.0
        vital13F801D9.paS = 127.0
        vital13F801D9.paD = 79.0
        vital13F801D9.rhythm = "Sinusal"
        vital13F801D9.spo2 = 100.0
        signs.append(vital13F801D9)

        let vital7CF1F953 = VitalSignEntry(
            vitalSignsId: "7CF1F953-02A2-4C5A-8E3B-BEBC51AF793F",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 45, second: 21)
        )
        vital7CF1F953.pam = 96.0
        vital7CF1F953.fc = 85.0
        vital7CF1F953.paS = 130.0
        vital7CF1F953.paD = 79.0
        vital7CF1F953.rhythm = "Sinusal"
        vital7CF1F953.spo2 = 100.0
        signs.append(vital7CF1F953)

        let vital9126FC93 = VitalSignEntry(
            vitalSignsId: "9126FC93-48F9-4A2A-A394-1057E59F0E8A",
            anesthesia: anesthesias[22],
            timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 55, second: 21)
        )
        vital9126FC93.pam = 98.0
        vital9126FC93.fc = 84.0
        vital9126FC93.paS = 131.0
        vital9126FC93.paD = 82.0
        vital9126FC93.rhythm = "Sinusal"
        vital9126FC93.spo2 = 100.0
        signs.append(vital9126FC93)

        let vitalA6735A58 = VitalSignEntry(
            vitalSignsId: "A6735A58-EDC5-4CD5-8AED-026245501097",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
        )
        vitalA6735A58.pam = 89.0
        vitalA6735A58.fc = 80.0
        vitalA6735A58.paS = 113.0
        vitalA6735A58.paD = 77.0
        vitalA6735A58.rhythm = "Sinusal"
        vitalA6735A58.spo2 = 98.0
        signs.append(vitalA6735A58)

        let vital882DFB70 = VitalSignEntry(
            vitalSignsId: "882DFB70-7F0E-403F-92CD-BF96CD1E9250",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 20, second: 13)
        )
        vital882DFB70.pam = 89.0
        vital882DFB70.fc = 79.0
        vital882DFB70.paS = 112.0
        vital882DFB70.paD = 77.0
        vital882DFB70.rhythm = "Sinusal"
        vital882DFB70.spo2 = 98.0
        signs.append(vital882DFB70)

        let vital2668F821 = VitalSignEntry(
            vitalSignsId: "2668F821-224D-4CB6-9FC9-566DE6D761EF",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 25, second: 13)
        )
        vital2668F821.pam = 89.0
        vital2668F821.fc = 82.0
        vital2668F821.paS = 110.0
        vital2668F821.paD = 78.0
        vital2668F821.rhythm = "Sinusal"
        vital2668F821.spo2 = 98.0
        signs.append(vital2668F821)

        let vitalBDBD3F64 = VitalSignEntry(
            vitalSignsId: "BDBD3F64-23DF-4E67-87AB-7A17D779D078",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 30, second: 13)
        )
        vitalBDBD3F64.pam = 87.0
        vitalBDBD3F64.fc = 81.0
        vitalBDBD3F64.paS = 110.0
        vitalBDBD3F64.paD = 76.0
        vitalBDBD3F64.rhythm = "Sinusal"
        vitalBDBD3F64.spo2 = 98.0
        signs.append(vitalBDBD3F64)

        let vitalB4CA32A2 = VitalSignEntry(
            vitalSignsId: "B4CA32A2-9A03-460A-B0D8-7488FC25329A",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 35, second: 13)
        )
        vitalB4CA32A2.pam = 86.0
        vitalB4CA32A2.fc = 82.0
        vitalB4CA32A2.paS = 109.0
        vitalB4CA32A2.paD = 75.0
        vitalB4CA32A2.rhythm = "Sinusal"
        vitalB4CA32A2.spo2 = 98.0
        signs.append(vitalB4CA32A2)

        let vitalE57383A0 = VitalSignEntry(
            vitalSignsId: "E57383A0-1102-4440-9FCA-E432A8706780",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 40, second: 13)
        )
        vitalE57383A0.pam = 86.0
        vitalE57383A0.fc = 83.0
        vitalE57383A0.paS = 108.0
        vitalE57383A0.paD = 75.0
        vitalE57383A0.rhythm = "Sinusal"
        vitalE57383A0.spo2 = 98.0
        signs.append(vitalE57383A0)

        let vital6C804122 = VitalSignEntry(
            vitalSignsId: "6C804122-F0D9-4229-8113-BB15F7F6F90B",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 45, second: 13)
        )
        vital6C804122.pam = 88.0
        vital6C804122.fc = 83.0
        vital6C804122.paS = 107.0
        vital6C804122.paD = 78.0
        vital6C804122.rhythm = "Sinusal"
        vital6C804122.spo2 = 99.0
        signs.append(vital6C804122)

        let vital0D51F676 = VitalSignEntry(
            vitalSignsId: "0D51F676-9A7B-4B1A-8CB8-C633939F83C5",
            anesthesia: anesthesias[23],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 55, second: 13)
        )
        vital0D51F676.pam = 88.0
        vital0D51F676.fc = 84.0
        vital0D51F676.paS = 110.0
        vital0D51F676.paD = 77.0
        vital0D51F676.rhythm = "Sinusal"
        vital0D51F676.spo2 = 100.0
        signs.append(vital0D51F676)

        let vitalDC484EFC = VitalSignEntry(
            vitalSignsId: "DC484EFC-3ABD-49E7-9D32-AED65A38A5F4",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
        )
        vitalDC484EFC.pam = 86.0
        vitalDC484EFC.fc = 82.0
        vitalDC484EFC.paS = 115.0
        vitalDC484EFC.paD = 71.0
        vitalDC484EFC.rhythm = "Sinusal"
        vitalDC484EFC.spo2 = 98.0
        signs.append(vitalDC484EFC)

        let vital192224DD = VitalSignEntry(
            vitalSignsId: "192224DD-F00F-48C0-A586-71C2690F5948",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 50, second: 49)
        )
        vital192224DD.pam = 85.0
        vital192224DD.fc = 82.0
        vital192224DD.paS = 114.0
        vital192224DD.paD = 70.0
        vital192224DD.rhythm = "Sinusal"
        vital192224DD.spo2 = 99.0
        signs.append(vital192224DD)

        let vitalF58DE81F = VitalSignEntry(
            vitalSignsId: "F58DE81F-0E10-4ED7-A9BA-1F051FDDADD5",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 55, second: 49)
        )
        vitalF58DE81F.pam = 84.0
        vitalF58DE81F.fc = 83.0
        vitalF58DE81F.paS = 113.0
        vitalF58DE81F.paD = 70.0
        vitalF58DE81F.rhythm = "Sinusal"
        vitalF58DE81F.spo2 = 98.0
        signs.append(vitalF58DE81F)

        let vital61336C63 = VitalSignEntry(
            vitalSignsId: "61336C63-31FF-48B4-A4CE-859E53A037BC",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 0, second: 49)
        )
        vital61336C63.pam = 87.0
        vital61336C63.fc = 82.0
        vital61336C63.paS = 117.0
        vital61336C63.paD = 72.0
        vital61336C63.rhythm = "Sinusal"
        vital61336C63.spo2 = 98.0
        signs.append(vital61336C63)

        let vitalDDB9A1A3 = VitalSignEntry(
            vitalSignsId: "DDB9A1A3-D1F0-48FB-8EDB-A168838CCFF4",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 5, second: 49)
        )
        vitalDDB9A1A3.pam = 88.0
        vitalDDB9A1A3.fc = 83.0
        vitalDDB9A1A3.paS = 117.0
        vitalDDB9A1A3.paD = 73.0
        vitalDDB9A1A3.rhythm = "Sinusal"
        vitalDDB9A1A3.spo2 = 98.0
        signs.append(vitalDDB9A1A3)

        let vitalA63B963F = VitalSignEntry(
            vitalSignsId: "A63B963F-9D5F-4FE4-8394-D1E998F8ED04",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 10, second: 49)
        )
        vitalA63B963F.pam = 87.0
        vitalA63B963F.fc = 81.0
        vitalA63B963F.paS = 116.0
        vitalA63B963F.paD = 73.0
        vitalA63B963F.rhythm = "Sinusal"
        vitalA63B963F.spo2 = 98.0
        signs.append(vitalA63B963F)

        let vital56A32439 = VitalSignEntry(
            vitalSignsId: "56A32439-4DA8-41E0-B2B8-358B366FAEBF",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 15, second: 49)
        )
        vital56A32439.pam = 88.0
        vital56A32439.fc = 80.0
        vital56A32439.paS = 115.0
        vital56A32439.paD = 74.0
        vital56A32439.rhythm = "Sinusal"
        vital56A32439.spo2 = 99.0
        signs.append(vital56A32439)

        let vital943C7FAD = VitalSignEntry(
            vitalSignsId: "943C7FAD-D2D5-4F9B-9F97-E2569D748506",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 25, second: 49)
        )
        vital943C7FAD.pam = 89.0
        vital943C7FAD.fc = 78.0
        vital943C7FAD.paS = 120.0
        vital943C7FAD.paD = 74.0
        vital943C7FAD.rhythm = "Sinusal"
        vital943C7FAD.spo2 = 99.0
        signs.append(vital943C7FAD)

        let vital5B8889EF = VitalSignEntry(
            vitalSignsId: "5B8889EF-4C39-4FBB-81B0-F801B45952BB",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 35, second: 49)
        )
        vital5B8889EF.pam = 90.0
        vital5B8889EF.fc = 80.0
        vital5B8889EF.paS = 119.0
        vital5B8889EF.paD = 75.0
        vital5B8889EF.rhythm = "Sinusal"
        vital5B8889EF.spo2 = 99.0
        signs.append(vital5B8889EF)

        let vital0B0173C7 = VitalSignEntry(
            vitalSignsId: "0B0173C7-0F83-48A1-A839-D04C28CE3AB2",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 45, second: 49)
        )
        vital0B0173C7.pam = 91.0
        vital0B0173C7.fc = 86.0
        vital0B0173C7.paS = 120.0
        vital0B0173C7.paD = 77.0
        vital0B0173C7.rhythm = "Sinusal"
        vital0B0173C7.spo2 = 98.0
        signs.append(vital0B0173C7)

        let vital046D5B4A = VitalSignEntry(
            vitalSignsId: "046D5B4A-69AF-406E-B47B-CC9235560900",
            anesthesia: anesthesias[24],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 8, minute: 55, second: 49)
        )
        vital046D5B4A.pam = 94.0
        vital046D5B4A.fc = 86.0
        vital046D5B4A.paS = 125.0
        vital046D5B4A.paD = 78.0
        vital046D5B4A.rhythm = "Sinusal"
        vital046D5B4A.spo2 = 98.0
        signs.append(vital046D5B4A)

        let vitalD1F3487D = VitalSignEntry(
            vitalSignsId: "D1F3487D-5FB4-4FB0-A918-3EDBFD224F16",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
        )
        vitalD1F3487D.pam = 76.0
        vitalD1F3487D.fc = 103.0
        vitalD1F3487D.paS = 101.0
        vitalD1F3487D.paD = 64.0
        vitalD1F3487D.rhythm = "Sinusal"
        vitalD1F3487D.spo2 = 99.0
        signs.append(vitalD1F3487D)

        let vitalB456EC80 = VitalSignEntry(
            vitalSignsId: "B456EC80-D6ED-4A4D-BB18-59738AA8FD43",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 35, second: 59)
        )
        vitalB456EC80.pam = 77.0
        vitalB456EC80.fc = 103.0
        vitalB456EC80.paS = 102.0
        vitalB456EC80.paD = 64.0
        vitalB456EC80.rhythm = "Sinusal"
        vitalB456EC80.spo2 = 99.0
        signs.append(vitalB456EC80)

        let vital65587913 = VitalSignEntry(
            vitalSignsId: "65587913-BA7F-475A-B35A-A07B150B4212",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 40, second: 59)
        )
        vital65587913.pam = 80.0
        vital65587913.fc = 104.0
        vital65587913.paS = 105.0
        vital65587913.paD = 67.0
        vital65587913.rhythm = "Sinusal"
        vital65587913.spo2 = 100.0
        signs.append(vital65587913)

        let vital724B489C = VitalSignEntry(
            vitalSignsId: "724B489C-79DC-46CE-9C39-46BA5C509F80",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 45, second: 59)
        )
        vital724B489C.pam = 81.0
        vital724B489C.fc = 101.0
        vital724B489C.paS = 104.0
        vital724B489C.paD = 69.0
        vital724B489C.rhythm = "Sinusal"
        vital724B489C.spo2 = 99.0
        signs.append(vital724B489C)

        let vitalAFC5D57D = VitalSignEntry(
            vitalSignsId: "AFC5D57D-5337-49A9-926A-8F41BA75F7CF",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 50, second: 59)
        )
        vitalAFC5D57D.pam = 81.0
        vitalAFC5D57D.fc = 100.0
        vitalAFC5D57D.paS = 106.0
        vitalAFC5D57D.paD = 68.0
        vitalAFC5D57D.rhythm = "Sinusal"
        vitalAFC5D57D.spo2 = 98.0
        signs.append(vitalAFC5D57D)

        let vital0FBA9F4A = VitalSignEntry(
            vitalSignsId: "0FBA9F4A-A8AD-40F0-AB34-8A05FA02D71B",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 55, second: 59)
        )
        vital0FBA9F4A.pam = 79.0
        vital0FBA9F4A.fc = 98.0
        vital0FBA9F4A.paS = 103.0
        vital0FBA9F4A.paD = 67.0
        vital0FBA9F4A.rhythm = "Sinusal"
        vital0FBA9F4A.spo2 = 98.0
        signs.append(vital0FBA9F4A)

        let vital2F5C377B = VitalSignEntry(
            vitalSignsId: "2F5C377B-827D-4814-BCC5-0CAF7A5F31CA",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 0, second: 59)
        )
        vital2F5C377B.pam = 79.0
        vital2F5C377B.fc = 99.0
        vital2F5C377B.paS = 104.0
        vital2F5C377B.paD = 66.0
        vital2F5C377B.rhythm = "Sinusal"
        vital2F5C377B.spo2 = 97.0
        signs.append(vital2F5C377B)

        let vitalC9A24F51 = VitalSignEntry(
            vitalSignsId: "C9A24F51-6B1F-4122-AE84-B8DD1F6F0209",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 10, second: 59)
        )
        vitalC9A24F51.pam = 84.0
        vitalC9A24F51.fc = 103.0
        vitalC9A24F51.paS = 112.0
        vitalC9A24F51.paD = 70.0
        vitalC9A24F51.rhythm = "Sinusal"
        vitalC9A24F51.spo2 = 98.0
        signs.append(vitalC9A24F51)

        let vitalE217CF98 = VitalSignEntry(
            vitalSignsId: "E217CF98-5D17-4CE2-9BFE-9B365C8049EB",
            anesthesia: anesthesias[25],
            timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 20, second: 59)
        )
        vitalE217CF98.pam = 85.0
        vitalE217CF98.fc = 106.0
        vitalE217CF98.paS = 114.0
        vitalE217CF98.paD = 70.0
        vitalE217CF98.rhythm = "Sinusal"
        vitalE217CF98.spo2 = 98.0
        signs.append(vitalE217CF98)

        let vitalCD9E3821 = VitalSignEntry(
            vitalSignsId: "CD9E3821-78DB-49A6-8210-4FF9B8613DE8",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
        )
        vitalCD9E3821.pam = 72.0
        vitalCD9E3821.fc = 117.0
        vitalCD9E3821.paS = 88.0
        vitalCD9E3821.paD = 64.0
        vitalCD9E3821.rhythm = "Sinusal"
        vitalCD9E3821.spo2 = 99.0
        signs.append(vitalCD9E3821)

        let vital47D0A578 = VitalSignEntry(
            vitalSignsId: "47D0A578-3179-47D4-A6CA-5C87BA667288",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 40, second: 41)
        )
        vital47D0A578.pam = 74.0
        vital47D0A578.fc = 119.0
        vital47D0A578.paS = 92.0
        vital47D0A578.paD = 65.0
        vital47D0A578.rhythm = "Sinusal"
        vital47D0A578.spo2 = 100.0
        signs.append(vital47D0A578)

        let vitalE3E86DF9 = VitalSignEntry(
            vitalSignsId: "E3E86DF9-1899-4F39-BB67-E3C851D128D3",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 45, second: 41)
        )
        vitalE3E86DF9.pam = 71.0
        vitalE3E86DF9.fc = 117.0
        vitalE3E86DF9.paS = 86.0
        vitalE3E86DF9.paD = 63.0
        vitalE3E86DF9.rhythm = "Sinusal"
        vitalE3E86DF9.spo2 = 100.0
        signs.append(vitalE3E86DF9)

        let vital1C8F44D9 = VitalSignEntry(
            vitalSignsId: "1C8F44D9-C301-4AE9-916F-958F4E5EB721",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 50, second: 41)
        )
        vital1C8F44D9.pam = 74.0
        vital1C8F44D9.fc = 114.0
        vital1C8F44D9.paS = 93.0
        vital1C8F44D9.paD = 65.0
        vital1C8F44D9.rhythm = "Sinusal"
        vital1C8F44D9.spo2 = 100.0
        signs.append(vital1C8F44D9)

        let vitalC966F220 = VitalSignEntry(
            vitalSignsId: "C966F220-6B7F-4A67-AA58-D2C0A54A8D0F",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 55, second: 41)
        )
        vitalC966F220.pam = 76.0
        vitalC966F220.fc = 114.0
        vitalC966F220.paS = 95.0
        vitalC966F220.paD = 66.0
        vitalC966F220.rhythm = "Sinusal"
        vitalC966F220.spo2 = 100.0
        signs.append(vitalC966F220)

        let vital29FA613B = VitalSignEntry(
            vitalSignsId: "29FA613B-CD82-458D-AA92-67D431669BEB",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 11, minute: 0, second: 41)
        )
        vital29FA613B.pam = 77.0
        vital29FA613B.fc = 115.0
        vital29FA613B.paS = 94.0
        vital29FA613B.paD = 69.0
        vital29FA613B.rhythm = "Sinusal"
        vital29FA613B.spo2 = 100.0
        signs.append(vital29FA613B)

        let vitalBB11BC22 = VitalSignEntry(
            vitalSignsId: "BB11BC22-93FC-4755-AD83-CFD73226E112",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 11, minute: 5, second: 41)
        )
        vitalBB11BC22.pam = 76.0
        vitalBB11BC22.fc = 112.0
        vitalBB11BC22.paS = 96.0
        vitalBB11BC22.paD = 66.0
        vitalBB11BC22.rhythm = "Sinusal"
        vitalBB11BC22.spo2 = 99.0
        signs.append(vitalBB11BC22)

        let vital27F7E044 = VitalSignEntry(
            vitalSignsId: "27F7E044-A208-44A2-AE59-80A2E0C0B42D",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 11, minute: 15, second: 41)
        )
        vital27F7E044.pam = 76.0
        vital27F7E044.fc = 112.0
        vital27F7E044.paS = 94.0
        vital27F7E044.paD = 67.0
        vital27F7E044.rhythm = "Sinusal"
        vital27F7E044.spo2 = 99.0
        signs.append(vital27F7E044)

        let vital24BA27CA = VitalSignEntry(
            vitalSignsId: "24BA27CA-9DA4-4E9D-8AAF-716ABB2EB3C4",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 11, minute: 25, second: 41)
        )
        vital24BA27CA.pam = 79.0
        vital24BA27CA.fc = 119.0
        vital24BA27CA.paS = 100.0
        vital24BA27CA.paD = 68.0
        vital24BA27CA.rhythm = "Sinusal"
        vital24BA27CA.spo2 = 99.0
        signs.append(vital24BA27CA)

        let vitalB42C78F6 = VitalSignEntry(
            vitalSignsId: "B42C78F6-3C3C-47FA-9141-06CDC529EB0B",
            anesthesia: anesthesias[26],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 11, minute: 35, second: 41)
        )
        vitalB42C78F6.pam = 78.0
        vitalB42C78F6.fc = 120.0
        vitalB42C78F6.paS = 100.0
        vitalB42C78F6.paD = 67.0
        vitalB42C78F6.rhythm = "Sinusal"
        vitalB42C78F6.spo2 = 99.0
        signs.append(vitalB42C78F6)

        let vitalE74909E6 = VitalSignEntry(
            vitalSignsId: "E74909E6-D42A-4EC6-BAEE-488ED8EE9D8E",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
        )
        vitalE74909E6.pam = 74.0
        vitalE74909E6.fc = 112.0
        vitalE74909E6.paS = 104.0
        vitalE74909E6.paD = 59.0
        vitalE74909E6.rhythm = "Sinusal"
        vitalE74909E6.etco2 = 38.0
        vitalE74909E6.spo2 = 98.0
        signs.append(vitalE74909E6)

        let vitalC4619221 = VitalSignEntry(
            vitalSignsId: "C4619221-6599-496B-A95F-8F9C47E6B770",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 50, second: 25)
        )
        vitalC4619221.pam = 73.0
        vitalC4619221.fc = 111.0
        vitalC4619221.paS = 101.0
        vitalC4619221.paD = 59.0
        vitalC4619221.rhythm = "Sinusal"
        vitalC4619221.etco2 = 38.0
        vitalC4619221.spo2 = 98.0
        signs.append(vitalC4619221)

        let vitalDC2E55B6 = VitalSignEntry(
            vitalSignsId: "DC2E55B6-D7A6-4CFF-B3AC-29E428F13CCD",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 55, second: 25)
        )
        vitalDC2E55B6.pam = 73.0
        vitalDC2E55B6.fc = 111.0
        vitalDC2E55B6.paS = 101.0
        vitalDC2E55B6.paD = 59.0
        vitalDC2E55B6.rhythm = "Sinusal"
        vitalDC2E55B6.etco2 = 38.0
        vitalDC2E55B6.spo2 = 98.0
        signs.append(vitalDC2E55B6)

        let vital3E7C511F = VitalSignEntry(
            vitalSignsId: "3E7C511F-CF6E-4C8C-8210-B5217648B36F",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 0, second: 25)
        )
        vital3E7C511F.pam = 76.0
        vital3E7C511F.fc = 112.0
        vital3E7C511F.paS = 105.0
        vital3E7C511F.paD = 62.0
        vital3E7C511F.rhythm = "Sinusal"
        vital3E7C511F.etco2 = 38.0
        vital3E7C511F.spo2 = 98.0
        signs.append(vital3E7C511F)

        let vital717F84E8 = VitalSignEntry(
            vitalSignsId: "717F84E8-4E63-4021-B522-7E32AD5A00E4",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 5, second: 25)
        )
        vital717F84E8.pam = 77.0
        vital717F84E8.fc = 113.0
        vital717F84E8.paS = 106.0
        vital717F84E8.paD = 63.0
        vital717F84E8.rhythm = "Sinusal"
        vital717F84E8.etco2 = 38.0
        vital717F84E8.spo2 = 98.0
        signs.append(vital717F84E8)

        let vital02690433 = VitalSignEntry(
            vitalSignsId: "02690433-8297-4D2F-B015-87E714EBF709",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 10, second: 25)
        )
        vital02690433.pam = 79.0
        vital02690433.fc = 113.0
        vital02690433.paS = 105.0
        vital02690433.paD = 66.0
        vital02690433.rhythm = "Sinusal"
        vital02690433.etco2 = 38.0
        vital02690433.spo2 = 99.0
        signs.append(vital02690433)

        let vital522B7B98 = VitalSignEntry(
            vitalSignsId: "522B7B98-A19A-4E0E-B150-B5DAC1041950",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 15, second: 25)
        )
        vital522B7B98.pam = 79.0
        vital522B7B98.fc = 113.0
        vital522B7B98.paS = 103.0
        vital522B7B98.paD = 67.0
        vital522B7B98.rhythm = "Sinusal"
        vital522B7B98.etco2 = 37.0
        vital522B7B98.spo2 = 98.0
        signs.append(vital522B7B98)

        let vital152836AA = VitalSignEntry(
            vitalSignsId: "152836AA-0481-4755-BA46-CA33B82C842D",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 25, second: 25)
        )
        vital152836AA.pam = 79.0
        vital152836AA.fc = 112.0
        vital152836AA.paS = 106.0
        vital152836AA.paD = 65.0
        vital152836AA.rhythm = "Sinusal"
        vital152836AA.etco2 = 37.0
        vital152836AA.spo2 = 98.0
        signs.append(vital152836AA)

        let vitalF820C6DC = VitalSignEntry(
            vitalSignsId: "F820C6DC-C743-42D3-8277-D46FF284839F",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 35, second: 25)
        )
        vitalF820C6DC.pam = 82.0
        vitalF820C6DC.fc = 117.0
        vitalF820C6DC.paS = 112.0
        vitalF820C6DC.paD = 67.0
        vitalF820C6DC.rhythm = "Sinusal"
        vitalF820C6DC.etco2 = 37.0
        vitalF820C6DC.spo2 = 98.0
        signs.append(vitalF820C6DC)

        let vital9AB1CE45 = VitalSignEntry(
            vitalSignsId: "9AB1CE45-2261-4671-B9A1-D0924BF54C4D",
            anesthesia: anesthesias[27],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 9, minute: 45, second: 25)
        )
        vital9AB1CE45.pam = 84.0
        vital9AB1CE45.fc = 117.0
        vital9AB1CE45.paS = 115.0
        vital9AB1CE45.paD = 68.0
        vital9AB1CE45.rhythm = "Sinusal"
        vital9AB1CE45.etco2 = 36.0
        vital9AB1CE45.spo2 = 98.0
        signs.append(vital9AB1CE45)

        let vitalB5ABA104 = VitalSignEntry(
            vitalSignsId: "B5ABA104-F49B-4717-8226-FC5880D5E850",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 0, second: 4)
        )
        vitalB5ABA104.pam = 82.0
        vitalB5ABA104.fc = 76.0
        vitalB5ABA104.paS = 103.0
        vitalB5ABA104.paD = 71.0
        vitalB5ABA104.rhythm = "Sinusal"
        vitalB5ABA104.spo2 = 98.0
        signs.append(vitalB5ABA104)

        let vital5505A124 = VitalSignEntry(
            vitalSignsId: "5505A124-EE5C-4E59-B412-6FE4F201B993",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 5, second: 4)
        )
        vital5505A124.pam = 83.0
        vital5505A124.fc = 77.0
        vital5505A124.paS = 107.0
        vital5505A124.paD = 71.0
        vital5505A124.rhythm = "Sinusal"
        vital5505A124.spo2 = 99.0
        signs.append(vital5505A124)

        let vitalB37AF2BC = VitalSignEntry(
            vitalSignsId: "B37AF2BC-62E3-44BC-B36B-D1BF79864BB7",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 10, second: 4)
        )
        vitalB37AF2BC.pam = 80.0
        vitalB37AF2BC.fc = 77.0
        vitalB37AF2BC.paS = 102.0
        vitalB37AF2BC.paD = 69.0
        vitalB37AF2BC.rhythm = "Sinusal"
        vitalB37AF2BC.spo2 = 99.0
        signs.append(vitalB37AF2BC)

        let vital332E31D6 = VitalSignEntry(
            vitalSignsId: "332E31D6-0427-49C7-9CB8-FB3F2C9F5E13",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 15, second: 4)
        )
        vital332E31D6.pam = 82.0
        vital332E31D6.fc = 76.0
        vital332E31D6.paS = 106.0
        vital332E31D6.paD = 70.0
        vital332E31D6.rhythm = "Sinusal"
        vital332E31D6.spo2 = 99.0
        signs.append(vital332E31D6)

        let vital2DA6E039 = VitalSignEntry(
            vitalSignsId: "2DA6E039-EB0E-4395-8CB1-FA44145C4289",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 20, second: 4)
        )
        vital2DA6E039.pam = 82.0
        vital2DA6E039.fc = 76.0
        vital2DA6E039.paS = 105.0
        vital2DA6E039.paD = 70.0
        vital2DA6E039.rhythm = "Sinusal"
        vital2DA6E039.spo2 = 100.0
        signs.append(vital2DA6E039)

        let vital0172C24E = VitalSignEntry(
            vitalSignsId: "0172C24E-8866-4563-86CC-3755D310AF00",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 25, second: 4)
        )
        vital0172C24E.pam = 79.0
        vital0172C24E.fc = 74.0
        vital0172C24E.paS = 100.0
        vital0172C24E.paD = 68.0
        vital0172C24E.rhythm = "Sinusal"
        vital0172C24E.spo2 = 100.0
        signs.append(vital0172C24E)

        let vital1F702CDF = VitalSignEntry(
            vitalSignsId: "1F702CDF-20E0-42FC-876D-E505303444E5",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 30, second: 4)
        )
        vital1F702CDF.pam = 80.0
        vital1F702CDF.fc = 73.0
        vital1F702CDF.paS = 100.0
        vital1F702CDF.paD = 70.0
        vital1F702CDF.rhythm = "Sinusal"
        vital1F702CDF.spo2 = 100.0
        signs.append(vital1F702CDF)

        let vital17588419 = VitalSignEntry(
            vitalSignsId: "17588419-E14F-435E-9303-3A3D4FCA70D5",
            anesthesia: anesthesias[28],
            timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 40, second: 4)
        )
        vital17588419.pam = 79.0
        vital17588419.fc = 75.0
        vital17588419.paS = 103.0
        vital17588419.paD = 67.0
        vital17588419.rhythm = "Sinusal"
        vital17588419.spo2 = 99.0
        signs.append(vital17588419)

        let vital73D3B3C5 = VitalSignEntry(
            vitalSignsId: "73D3B3C5-8309-4FD3-B5DC-8F67157F17A0",
            anesthesia: anesthesias[29],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 50)
        )
        vital73D3B3C5.pam = 93.0
        vital73D3B3C5.fc = 83.0
        vital73D3B3C5.paS = 126.0
        vital73D3B3C5.paD = 76.0
        vital73D3B3C5.rhythm = "Sinusal"
        vital73D3B3C5.spo2 = 99.0
        signs.append(vital73D3B3C5)

        let vital3D4305EA = VitalSignEntry(
            vitalSignsId: "3D4305EA-E164-4B54-BD9E-E4E02F2689C3",
            anesthesia: anesthesias[29],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 40, second: 50)
        )
        vital3D4305EA.pam = 90.0
        vital3D4305EA.fc = 81.0
        vital3D4305EA.paS = 125.0
        vital3D4305EA.paD = 72.0
        vital3D4305EA.rhythm = "Sinusal"
        vital3D4305EA.spo2 = 99.0
        signs.append(vital3D4305EA)

        let vital5BF455C5 = VitalSignEntry(
            vitalSignsId: "5BF455C5-5180-46A8-87C4-69D61AEA031C",
            anesthesia: anesthesias[29],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 45, second: 50)
        )
        vital5BF455C5.pam = 90.0
        vital5BF455C5.fc = 84.0
        vital5BF455C5.paS = 121.0
        vital5BF455C5.paD = 74.0
        vital5BF455C5.rhythm = "Sinusal"
        vital5BF455C5.spo2 = 98.0
        signs.append(vital5BF455C5)

        let vitalC523AFE1 = VitalSignEntry(
            vitalSignsId: "C523AFE1-A829-4C1A-885B-0F8B01D09EB7",
            anesthesia: anesthesias[29],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 50, second: 50)
        )
        vitalC523AFE1.pam = 89.0
        vitalC523AFE1.fc = 86.0
        vitalC523AFE1.paS = 122.0
        vitalC523AFE1.paD = 73.0
        vitalC523AFE1.rhythm = "Sinusal"
        vitalC523AFE1.spo2 = 98.0
        signs.append(vitalC523AFE1)

        let vital2AB1D020 = VitalSignEntry(
            vitalSignsId: "2AB1D020-AA50-4BED-931E-556E140E1CEC",
            anesthesia: anesthesias[29],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 55, second: 50)
        )
        vital2AB1D020.pam = 91.0
        vital2AB1D020.fc = 83.0
        vital2AB1D020.paS = 122.0
        vital2AB1D020.paD = 75.0
        vital2AB1D020.rhythm = "Sinusal"
        vital2AB1D020.spo2 = 97.0
        signs.append(vital2AB1D020)

        let vital4D7B1B9D = VitalSignEntry(
            vitalSignsId: "4D7B1B9D-8887-4AEA-B53C-A4B7F5DB95DD",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 15, second: 59)
        )
        vital4D7B1B9D.pam = 96.0
        vital4D7B1B9D.fc = 83.0
        vital4D7B1B9D.paS = 119.0
        vital4D7B1B9D.paD = 84.0
        vital4D7B1B9D.rhythm = "Sinusal"
        vital4D7B1B9D.spo2 = 96.0
        signs.append(vital4D7B1B9D)

        let vital6677EEE8 = VitalSignEntry(
            vitalSignsId: "6677EEE8-953C-4CC0-BFCD-0EF143C6923D",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 20, second: 59)
        )
        vital6677EEE8.pam = 97.0
        vital6677EEE8.fc = 84.0
        vital6677EEE8.paS = 116.0
        vital6677EEE8.paD = 87.0
        vital6677EEE8.rhythm = "Sinusal"
        vital6677EEE8.spo2 = 97.0
        signs.append(vital6677EEE8)

        let vital30A1EDE2 = VitalSignEntry(
            vitalSignsId: "30A1EDE2-887B-4784-9809-A2D3FE9B377E",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 25, second: 59)
        )
        vital30A1EDE2.pam = 96.0
        vital30A1EDE2.fc = 83.0
        vital30A1EDE2.paS = 117.0
        vital30A1EDE2.paD = 86.0
        vital30A1EDE2.rhythm = "Sinusal"
        vital30A1EDE2.spo2 = 96.0
        signs.append(vital30A1EDE2)

        let vital24529B14 = VitalSignEntry(
            vitalSignsId: "24529B14-1A77-470D-8BFF-F4731E642CD7",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 30, second: 59)
        )
        vital24529B14.pam = 95.0
        vital24529B14.fc = 85.0
        vital24529B14.paS = 114.0
        vital24529B14.paD = 86.0
        vital24529B14.rhythm = "Sinusal"
        vital24529B14.spo2 = 95.0
        signs.append(vital24529B14)

        let vitalFC31A60D = VitalSignEntry(
            vitalSignsId: "FC31A60D-FAF0-494B-9BD8-44B98C3C5B6C",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 59)
        )
        vitalFC31A60D.pam = 96.0
        vitalFC31A60D.fc = 84.0
        vitalFC31A60D.paS = 119.0
        vitalFC31A60D.paD = 85.0
        vitalFC31A60D.rhythm = "Sinusal"
        vitalFC31A60D.spo2 = 95.0
        signs.append(vitalFC31A60D)

        let vitalFC271A72 = VitalSignEntry(
            vitalSignsId: "FC271A72-35D0-439C-84F0-9E71B3A25566",
            anesthesia: anesthesias[30],
            timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 40, second: 59)
        )
        vitalFC271A72.pam = 97.0
        vitalFC271A72.fc = 82.0
        vitalFC271A72.paS = 121.0
        vitalFC271A72.paD = 85.0
        vitalFC271A72.rhythm = "Sinusal"
        vitalFC271A72.spo2 = 95.0
        signs.append(vitalFC271A72)

        let vital04400086 = VitalSignEntry(
            vitalSignsId: "04400086-7945-4691-8347-2F94F7863DCC",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
        )
        vital04400086.pam = 86.0
        vital04400086.fc = 88.0
        vital04400086.paS = 113.0
        vital04400086.paD = 72.0
        vital04400086.rhythm = "Sinusal"
        vital04400086.etco2 = 37.0
        vital04400086.spo2 = 98.0
        signs.append(vital04400086)

        let vital4818B05D = VitalSignEntry(
            vitalSignsId: "4818B05D-9D64-4739-AAE1-D9A1C8C30AFE",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 35, second: 22)
        )
        vital4818B05D.pam = 84.0
        vital4818B05D.fc = 87.0
        vital4818B05D.paS = 113.0
        vital4818B05D.paD = 69.0
        vital4818B05D.rhythm = "Sinusal"
        vital4818B05D.etco2 = 38.0
        vital4818B05D.spo2 = 99.0
        signs.append(vital4818B05D)

        let vital81B156F0 = VitalSignEntry(
            vitalSignsId: "81B156F0-DE45-439A-B25E-EA3D619AFBDB",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 40, second: 22)
        )
        vital81B156F0.pam = 84.0
        vital81B156F0.fc = 87.0
        vital81B156F0.paS = 113.0
        vital81B156F0.paD = 69.0
        vital81B156F0.rhythm = "Sinusal"
        vital81B156F0.etco2 = 38.0
        vital81B156F0.spo2 = 99.0
        signs.append(vital81B156F0)

        let vital3E174C65 = VitalSignEntry(
            vitalSignsId: "3E174C65-533A-46F5-A1D8-E6212E1B3ABE",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 45, second: 22)
        )
        vital3E174C65.pam = 88.0
        vital3E174C65.fc = 88.0
        vital3E174C65.paS = 118.0
        vital3E174C65.paD = 73.0
        vital3E174C65.rhythm = "Sinusal"
        vital3E174C65.etco2 = 37.0
        vital3E174C65.spo2 = 98.0
        signs.append(vital3E174C65)

        let vital5E49303F = VitalSignEntry(
            vitalSignsId: "5E49303F-8D55-4C66-873D-4EF899A55024",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 50, second: 22)
        )
        vital5E49303F.pam = 89.0
        vital5E49303F.fc = 89.0
        vital5E49303F.paS = 121.0
        vital5E49303F.paD = 73.0
        vital5E49303F.rhythm = "Sinusal"
        vital5E49303F.etco2 = 38.0
        vital5E49303F.spo2 = 98.0
        signs.append(vital5E49303F)

        let vital83B23C80 = VitalSignEntry(
            vitalSignsId: "83B23C80-6F68-4252-8F68-109F48A030E6",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 55, second: 22)
        )
        vital83B23C80.pam = 89.0
        vital83B23C80.fc = 88.0
        vital83B23C80.paS = 120.0
        vital83B23C80.paD = 74.0
        vital83B23C80.rhythm = "Sinusal"
        vital83B23C80.etco2 = 39.0
        vital83B23C80.spo2 = 98.0
        signs.append(vital83B23C80)

        let vital27E70BD9 = VitalSignEntry(
            vitalSignsId: "27E70BD9-6139-4B58-AC7F-F36A56B46A57",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 16, minute: 0, second: 22)
        )
        vital27E70BD9.pam = 90.0
        vital27E70BD9.fc = 90.0
        vital27E70BD9.paS = 120.0
        vital27E70BD9.paD = 75.0
        vital27E70BD9.rhythm = "Sinusal"
        vital27E70BD9.etco2 = 38.0
        vital27E70BD9.spo2 = 98.0
        signs.append(vital27E70BD9)

        let vital0BBECA4C = VitalSignEntry(
            vitalSignsId: "0BBECA4C-6E4C-4DD2-9F8C-BBC46B23ED88",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 16, minute: 10, second: 22)
        )
        vital0BBECA4C.pam = 90.0
        vital0BBECA4C.fc = 91.0
        vital0BBECA4C.paS = 119.0
        vital0BBECA4C.paD = 75.0
        vital0BBECA4C.rhythm = "Sinusal"
        vital0BBECA4C.etco2 = 38.0
        vital0BBECA4C.spo2 = 99.0
        signs.append(vital0BBECA4C)

        let vital28E9CEDE = VitalSignEntry(
            vitalSignsId: "28E9CEDE-CFA0-4655-87C4-2383C369AB3C",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 16, minute: 20, second: 22)
        )
        vital28E9CEDE.pam = 88.0
        vital28E9CEDE.fc = 89.0
        vital28E9CEDE.paS = 119.0
        vital28E9CEDE.paD = 73.0
        vital28E9CEDE.rhythm = "Sinusal"
        vital28E9CEDE.etco2 = 38.0
        vital28E9CEDE.spo2 = 99.0
        signs.append(vital28E9CEDE)

        let vitalF8925DF2 = VitalSignEntry(
            vitalSignsId: "F8925DF2-E20B-45F6-8583-899023B4E914",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 16, minute: 30, second: 22)
        )
        vitalF8925DF2.pam = 96.0
        vitalF8925DF2.fc = 92.0
        vitalF8925DF2.paS = 129.0
        vitalF8925DF2.paD = 79.0
        vitalF8925DF2.rhythm = "Sinusal"
        vitalF8925DF2.etco2 = 37.0
        vitalF8925DF2.spo2 = 98.0
        signs.append(vitalF8925DF2)

        let vitalDE9CF1DD = VitalSignEntry(
            vitalSignsId: "DE9CF1DD-F8C4-4432-9412-D08F65F0DDE3",
            anesthesia: anesthesias[31],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 16, minute: 40, second: 22)
        )
        vitalDE9CF1DD.pam = 96.0
        vitalDE9CF1DD.fc = 92.0
        vitalDE9CF1DD.paS = 129.0
        vitalDE9CF1DD.paD = 79.0
        vitalDE9CF1DD.rhythm = "Sinusal"
        vitalDE9CF1DD.etco2 = 37.0
        vitalDE9CF1DD.spo2 = 98.0
        signs.append(vitalDE9CF1DD)

        let vitalFAAB22FC = VitalSignEntry(
            vitalSignsId: "FAAB22FC-9267-4BDC-8B9B-32F45B64395C",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
        )
        vitalFAAB22FC.pam = 99.0
        vitalFAAB22FC.fc = 73.0
        vitalFAAB22FC.paS = 132.0
        vitalFAAB22FC.paD = 83.0
        vitalFAAB22FC.rhythm = "Sinusal"
        vitalFAAB22FC.etco2 = 35.0
        vitalFAAB22FC.spo2 = 98.0
        signs.append(vitalFAAB22FC)

        let vital758C103B = VitalSignEntry(
            vitalSignsId: "758C103B-BF0A-4BA8-81C2-C315BEE8CA9A",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 50, second: 35)
        )
        vital758C103B.pam = 99.0
        vital758C103B.fc = 74.0
        vital758C103B.paS = 132.0
        vital758C103B.paD = 83.0
        vital758C103B.rhythm = "Sinusal"
        vital758C103B.etco2 = 36.0
        vital758C103B.spo2 = 98.0
        signs.append(vital758C103B)

        let vital126D2725 = VitalSignEntry(
            vitalSignsId: "126D2725-F2BC-4BD6-9A8E-4B7AA8B48294",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 55, second: 35)
        )
        vital126D2725.pam = 99.0
        vital126D2725.fc = 74.0
        vital126D2725.paS = 132.0
        vital126D2725.paD = 83.0
        vital126D2725.rhythm = "Sinusal"
        vital126D2725.etco2 = 36.0
        vital126D2725.spo2 = 98.0
        signs.append(vital126D2725)

        let vital2B901734 = VitalSignEntry(
            vitalSignsId: "2B901734-C61E-48A8-8AF4-CE227DDAEE64",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 0, second: 35)
        )
        vital2B901734.pam = 102.0
        vital2B901734.fc = 74.0
        vital2B901734.paS = 137.0
        vital2B901734.paD = 84.0
        vital2B901734.rhythm = "Sinusal"
        vital2B901734.etco2 = 36.0
        vital2B901734.spo2 = 98.0
        signs.append(vital2B901734)

        let vital23864F99 = VitalSignEntry(
            vitalSignsId: "23864F99-909F-4635-B1AA-BEA097E27443",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 5, second: 35)
        )
        vital23864F99.pam = 105.0
        vital23864F99.fc = 74.0
        vital23864F99.paS = 140.0
        vital23864F99.paD = 87.0
        vital23864F99.rhythm = "Sinusal"
        vital23864F99.etco2 = 35.0
        vital23864F99.spo2 = 98.0
        signs.append(vital23864F99)

        let vital803895B7 = VitalSignEntry(
            vitalSignsId: "803895B7-C7ED-41EC-990A-D9EB593817EC",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 10, second: 35)
        )
        vital803895B7.pam = 104.0
        vital803895B7.fc = 73.0
        vital803895B7.paS = 137.0
        vital803895B7.paD = 88.0
        vital803895B7.rhythm = "Sinusal"
        vital803895B7.etco2 = 36.0
        vital803895B7.spo2 = 98.0
        signs.append(vital803895B7)

        let vital4AD089C8 = VitalSignEntry(
            vitalSignsId: "4AD089C8-5469-46DB-8037-33F07C323BF6",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 15, second: 35)
        )
        vital4AD089C8.pam = 106.0
        vital4AD089C8.fc = 74.0
        vital4AD089C8.paS = 137.0
        vital4AD089C8.paD = 90.0
        vital4AD089C8.rhythm = "Sinusal"
        vital4AD089C8.etco2 = 36.0
        vital4AD089C8.spo2 = 98.0
        signs.append(vital4AD089C8)

        let vitalB388C73B = VitalSignEntry(
            vitalSignsId: "B388C73B-FA79-4CCA-904F-732DE447B936",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 25, second: 35)
        )
        vitalB388C73B.pam = 112.0
        vitalB388C73B.fc = 77.0
        vitalB388C73B.paS = 147.0
        vitalB388C73B.paD = 95.0
        vitalB388C73B.rhythm = "Sinusal"
        vitalB388C73B.etco2 = 35.0
        vitalB388C73B.spo2 = 98.0
        signs.append(vitalB388C73B)

        let vitalCA82A3A2 = VitalSignEntry(
            vitalSignsId: "CA82A3A2-9B73-4D84-8DE5-2F614CD5D328",
            anesthesia: anesthesias[32],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 14, minute: 35, second: 35)
        )
        vitalCA82A3A2.pam = 113.0
        vitalCA82A3A2.fc = 79.0
        vitalCA82A3A2.paS = 148.0
        vitalCA82A3A2.paD = 95.0
        vitalCA82A3A2.rhythm = "Sinusal"
        vitalCA82A3A2.etco2 = 35.0
        vitalCA82A3A2.spo2 = 98.0
        signs.append(vitalCA82A3A2)

        let vital701BC41F = VitalSignEntry(
            vitalSignsId: "701BC41F-4E00-4720-8A67-C9F07A9C0363",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
        )
        vital701BC41F.pam = 77.0
        vital701BC41F.fc = 62.0
        vital701BC41F.paS = 101.0
        vital701BC41F.paD = 65.0
        vital701BC41F.rhythm = "Sinusal"
        vital701BC41F.etco2 = 39.0
        vital701BC41F.spo2 = 99.0
        signs.append(vital701BC41F)

        let vital0F42BE64 = VitalSignEntry(
            vitalSignsId: "0F42BE64-EE9D-417E-B22A-9DF966BC4F11",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 5, second: 2)
        )
        vital0F42BE64.pam = 77.0
        vital0F42BE64.fc = 62.0
        vital0F42BE64.paS = 101.0
        vital0F42BE64.paD = 65.0
        vital0F42BE64.rhythm = "Sinusal"
        vital0F42BE64.etco2 = 38.0
        vital0F42BE64.spo2 = 99.0
        signs.append(vital0F42BE64)

        let vital75DAD985 = VitalSignEntry(
            vitalSignsId: "75DAD985-9FAE-44BC-9D21-BCDC968202A5",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 10, second: 2)
        )
        vital75DAD985.pam = 77.0
        vital75DAD985.fc = 62.0
        vital75DAD985.paS = 101.0
        vital75DAD985.paD = 65.0
        vital75DAD985.rhythm = "Sinusal"
        vital75DAD985.etco2 = 38.0
        vital75DAD985.spo2 = 99.0
        signs.append(vital75DAD985)

        let vital8864112B = VitalSignEntry(
            vitalSignsId: "8864112B-505B-4B4F-96D5-5BDC8F175BD3",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 15, second: 2)
        )
        vital8864112B.pam = 79.0
        vital8864112B.fc = 62.0
        vital8864112B.paS = 102.0
        vital8864112B.paD = 67.0
        vital8864112B.rhythm = "Sinusal"
        vital8864112B.etco2 = 39.0
        vital8864112B.spo2 = 99.0
        signs.append(vital8864112B)

        let vitalECA92DA8 = VitalSignEntry(
            vitalSignsId: "ECA92DA8-B455-482A-9809-1FD3D46E1438",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 20, second: 2)
        )
        vitalECA92DA8.pam = 79.0
        vitalECA92DA8.fc = 63.0
        vitalECA92DA8.paS = 103.0
        vitalECA92DA8.paD = 67.0
        vitalECA92DA8.rhythm = "Sinusal"
        vitalECA92DA8.etco2 = 39.0
        vitalECA92DA8.spo2 = 99.0
        signs.append(vitalECA92DA8)

        let vitalFADA3147 = VitalSignEntry(
            vitalSignsId: "FADA3147-6C9F-496E-B441-44BE1ED0E41B",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 25, second: 2)
        )
        vitalFADA3147.pam = 81.0
        vitalFADA3147.fc = 66.0
        vitalFADA3147.paS = 109.0
        vitalFADA3147.paD = 67.0
        vitalFADA3147.rhythm = "Sinusal"
        vitalFADA3147.etco2 = 39.0
        vitalFADA3147.spo2 = 98.0
        signs.append(vitalFADA3147)

        let vital22A07C78 = VitalSignEntry(
            vitalSignsId: "22A07C78-485A-44BB-B9A3-BE1ED835D3B5",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 30, second: 2)
        )
        vital22A07C78.pam = 80.0
        vital22A07C78.fc = 65.0
        vital22A07C78.paS = 107.0
        vital22A07C78.paD = 66.0
        vital22A07C78.rhythm = "Sinusal"
        vital22A07C78.etco2 = 39.0
        vital22A07C78.spo2 = 99.0
        signs.append(vital22A07C78)

        let vitalE50BA746 = VitalSignEntry(
            vitalSignsId: "E50BA746-7477-49CE-B3D2-3A220B5CA774",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 40, second: 2)
        )
        vitalE50BA746.pam = 82.0
        vitalE50BA746.fc = 65.0
        vitalE50BA746.paS = 106.0
        vitalE50BA746.paD = 70.0
        vitalE50BA746.rhythm = "Sinusal"
        vitalE50BA746.etco2 = 38.0
        vitalE50BA746.spo2 = 99.0
        signs.append(vitalE50BA746)

        let vital4B2D1723 = VitalSignEntry(
            vitalSignsId: "4B2D1723-EA7D-4242-9DF3-210FF69D01AC",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 50, second: 2)
        )
        vital4B2D1723.pam = 83.0
        vital4B2D1723.fc = 64.0
        vital4B2D1723.paS = 108.0
        vital4B2D1723.paD = 71.0
        vital4B2D1723.rhythm = "Sinusal"
        vital4B2D1723.etco2 = 38.0
        vital4B2D1723.spo2 = 99.0
        signs.append(vital4B2D1723)

        let vital3CD78404 = VitalSignEntry(
            vitalSignsId: "3CD78404-E23B-4C0E-A57E-5F42CA4705A2",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 0, second: 2)
        )
        vital3CD78404.pam = 83.0
        vital3CD78404.fc = 63.0
        vital3CD78404.paS = 108.0
        vital3CD78404.paD = 70.0
        vital3CD78404.rhythm = "Sinusal"
        vital3CD78404.etco2 = 38.0
        vital3CD78404.spo2 = 100.0
        signs.append(vital3CD78404)

        let vital42149CFA = VitalSignEntry(
            vitalSignsId: "42149CFA-34D2-4509-B255-56D52CBBDA5F",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 10, second: 2)
        )
        vital42149CFA.pam = 84.0
        vital42149CFA.fc = 64.0
        vital42149CFA.paS = 109.0
        vital42149CFA.paD = 71.0
        vital42149CFA.rhythm = "Sinusal"
        vital42149CFA.etco2 = 38.0
        vital42149CFA.spo2 = 100.0
        signs.append(vital42149CFA)

        let vitalEE29552E = VitalSignEntry(
            vitalSignsId: "EE29552E-963B-4133-842D-A0E11F26A007",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 20, second: 2)
        )
        vitalEE29552E.pam = 84.0
        vitalEE29552E.fc = 65.0
        vitalEE29552E.paS = 109.0
        vitalEE29552E.paD = 71.0
        vitalEE29552E.rhythm = "Sinusal"
        vitalEE29552E.etco2 = 38.0
        vitalEE29552E.spo2 = 100.0
        signs.append(vitalEE29552E)

        let vital9E49D22E = VitalSignEntry(
            vitalSignsId: "9E49D22E-6431-4D72-BB0B-7711EC606D1C",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 30, second: 2)
        )
        vital9E49D22E.pam = 85.0
        vital9E49D22E.fc = 66.0
        vital9E49D22E.paS = 109.0
        vital9E49D22E.paD = 73.0
        vital9E49D22E.rhythm = "Sinusal"
        vital9E49D22E.etco2 = 38.0
        vital9E49D22E.spo2 = 99.0
        signs.append(vital9E49D22E)

        let vital4870611C = VitalSignEntry(
            vitalSignsId: "4870611C-448B-4C50-8794-0A4DE291240C",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 40, second: 2)
        )
        vital4870611C.pam = 86.0
        vital4870611C.fc = 66.0
        vital4870611C.paS = 109.0
        vital4870611C.paD = 74.0
        vital4870611C.rhythm = "Sinusal"
        vital4870611C.etco2 = 39.0
        vital4870611C.spo2 = 99.0
        signs.append(vital4870611C)

        let vital636E83FF = VitalSignEntry(
            vitalSignsId: "636E83FF-6D47-4F9C-AA20-AFC965169B8F",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 12, minute: 50, second: 2)
        )
        vital636E83FF.pam = 85.0
        vital636E83FF.fc = 66.0
        vital636E83FF.paS = 107.0
        vital636E83FF.paD = 74.0
        vital636E83FF.rhythm = "Sinusal"
        vital636E83FF.etco2 = 40.0
        vital636E83FF.spo2 = 100.0
        signs.append(vital636E83FF)

        let vital69095849 = VitalSignEntry(
            vitalSignsId: "69095849-A493-4287-97D3-2808F606B925",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 0, second: 2)
        )
        vital69095849.pam = 85.0
        vital69095849.fc = 67.0
        vital69095849.paS = 108.0
        vital69095849.paD = 73.0
        vital69095849.rhythm = "Sinusal"
        vital69095849.etco2 = 40.0
        vital69095849.spo2 = 100.0
        signs.append(vital69095849)

        let vitalE341FE0E = VitalSignEntry(
            vitalSignsId: "E341FE0E-9C50-46A0-B72B-85A5F938303F",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 10, second: 2)
        )
        vitalE341FE0E.pam = 89.0
        vitalE341FE0E.fc = 68.0
        vitalE341FE0E.paS = 117.0
        vitalE341FE0E.paD = 75.0
        vitalE341FE0E.rhythm = "Sinusal"
        vitalE341FE0E.etco2 = 39.0
        vitalE341FE0E.spo2 = 100.0
        signs.append(vitalE341FE0E)

        let vital27EEE6B9 = VitalSignEntry(
            vitalSignsId: "27EEE6B9-5EF1-4674-9CE6-B9D51A4D1224",
            anesthesia: anesthesias[33],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 20, second: 2)
        )
        vital27EEE6B9.pam = 90.0
        vital27EEE6B9.fc = 68.0
        vital27EEE6B9.paS = 117.0
        vital27EEE6B9.paD = 77.0
        vital27EEE6B9.rhythm = "Sinusal"
        vital27EEE6B9.etco2 = 38.0
        vital27EEE6B9.spo2 = 100.0
        signs.append(vital27EEE6B9)

        let vital81C5E471 = VitalSignEntry(
            vitalSignsId: "81C5E471-4D73-4176-9751-A71A89A6C430",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
        )
        vital81C5E471.pam = 87.0
        vital81C5E471.fc = 83.0
        vital81C5E471.paS = 107.0
        vital81C5E471.paD = 77.0
        vital81C5E471.rhythm = "Sinusal"
        vital81C5E471.etco2 = 36.0
        vital81C5E471.spo2 = 99.0
        signs.append(vital81C5E471)

        let vital04474628 = VitalSignEntry(
            vitalSignsId: "04474628-DA8F-44EF-9A38-E352194376BD",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 35, second: 42)
        )
        vital04474628.pam = 87.0
        vital04474628.fc = 83.0
        vital04474628.paS = 107.0
        vital04474628.paD = 77.0
        vital04474628.rhythm = "Sinusal"
        vital04474628.etco2 = 37.0
        vital04474628.spo2 = 100.0
        signs.append(vital04474628)

        let vital07BADA12 = VitalSignEntry(
            vitalSignsId: "07BADA12-327D-4CB4-B5F3-F7AD67669567",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 40, second: 42)
        )
        vital07BADA12.pam = 87.0
        vital07BADA12.fc = 81.0
        vital07BADA12.paS = 107.0
        vital07BADA12.paD = 77.0
        vital07BADA12.rhythm = "Sinusal"
        vital07BADA12.etco2 = 37.0
        vital07BADA12.spo2 = 99.0
        signs.append(vital07BADA12)

        let vitalAD6F7C80 = VitalSignEntry(
            vitalSignsId: "AD6F7C80-5C68-4B35-BDB1-8413F5CD4FED",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 45, second: 42)
        )
        vitalAD6F7C80.pam = 90.0
        vitalAD6F7C80.fc = 81.0
        vitalAD6F7C80.paS = 109.0
        vitalAD6F7C80.paD = 80.0
        vitalAD6F7C80.rhythm = "Sinusal"
        vitalAD6F7C80.etco2 = 37.0
        vitalAD6F7C80.spo2 = 99.0
        signs.append(vitalAD6F7C80)

        let vital6335E35B = VitalSignEntry(
            vitalSignsId: "6335E35B-862E-4A1A-8779-2E6634BA7B00",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 50, second: 42)
        )
        vital6335E35B.pam = 93.0
        vital6335E35B.fc = 83.0
        vital6335E35B.paS = 114.0
        vital6335E35B.paD = 82.0
        vital6335E35B.rhythm = "Sinusal"
        vital6335E35B.etco2 = 37.0
        vital6335E35B.spo2 = 100.0
        signs.append(vital6335E35B)

        let vitalAFA8E675 = VitalSignEntry(
            vitalSignsId: "AFA8E675-40C7-45D5-B900-8D3A8616E24D",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 55, second: 42)
        )
        vitalAFA8E675.pam = 93.0
        vitalAFA8E675.fc = 82.0
        vitalAFA8E675.paS = 112.0
        vitalAFA8E675.paD = 83.0
        vitalAFA8E675.rhythm = "Sinusal"
        vitalAFA8E675.etco2 = 36.0
        vitalAFA8E675.spo2 = 100.0
        signs.append(vitalAFA8E675)

        let vital6A64DEA5 = VitalSignEntry(
            vitalSignsId: "6A64DEA5-1342-40ED-8B9A-07E9C301B0F7",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 0, second: 42)
        )
        vital6A64DEA5.pam = 93.0
        vital6A64DEA5.fc = 83.0
        vital6A64DEA5.paS = 113.0
        vital6A64DEA5.paD = 83.0
        vital6A64DEA5.rhythm = "Sinusal"
        vital6A64DEA5.etco2 = 36.0
        vital6A64DEA5.spo2 = 100.0
        signs.append(vital6A64DEA5)

        let vitalD1180C30 = VitalSignEntry(
            vitalSignsId: "D1180C30-6DDF-4DC2-959E-2B5A737C9EB6",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 10, second: 42)
        )
        vitalD1180C30.pam = 94.0
        vitalD1180C30.fc = 84.0
        vitalD1180C30.paS = 114.0
        vitalD1180C30.paD = 84.0
        vitalD1180C30.rhythm = "Sinusal"
        vitalD1180C30.etco2 = 36.0
        vitalD1180C30.spo2 = 100.0
        signs.append(vitalD1180C30)

        let vitalA92C9C8C = VitalSignEntry(
            vitalSignsId: "A92C9C8C-D787-4787-BA04-A5363AC15855",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 20, second: 42)
        )
        vitalA92C9C8C.pam = 94.0
        vitalA92C9C8C.fc = 82.0
        vitalA92C9C8C.paS = 114.0
        vitalA92C9C8C.paD = 84.0
        vitalA92C9C8C.rhythm = "Sinusal"
        vitalA92C9C8C.etco2 = 36.0
        vitalA92C9C8C.spo2 = 99.0
        signs.append(vitalA92C9C8C)

        let vital62A65D16 = VitalSignEntry(
            vitalSignsId: "62A65D16-12E5-4B21-9BF3-CF82869376BA",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 30, second: 42)
        )
        vital62A65D16.pam = 94.0
        vital62A65D16.fc = 84.0
        vital62A65D16.paS = 115.0
        vital62A65D16.paD = 83.0
        vital62A65D16.rhythm = "Sinusal"
        vital62A65D16.etco2 = 37.0
        vital62A65D16.spo2 = 99.0
        signs.append(vital62A65D16)

        let vital7029C574 = VitalSignEntry(
            vitalSignsId: "7029C574-E7A8-455E-B33B-0CBEABD96A8D",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 40, second: 42)
        )
        vital7029C574.pam = 94.0
        vital7029C574.fc = 84.0
        vital7029C574.paS = 115.0
        vital7029C574.paD = 83.0
        vital7029C574.rhythm = "Sinusal"
        vital7029C574.etco2 = 38.0
        vital7029C574.spo2 = 100.0
        signs.append(vital7029C574)

        let vitalB4E5ECB6 = VitalSignEntry(
            vitalSignsId: "B4E5ECB6-642F-422E-AD47-8931DF79F0F5",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 8, minute: 50, second: 42)
        )
        vitalB4E5ECB6.pam = 94.0
        vitalB4E5ECB6.fc = 85.0
        vitalB4E5ECB6.paS = 117.0
        vitalB4E5ECB6.paD = 83.0
        vitalB4E5ECB6.rhythm = "Sinusal"
        vitalB4E5ECB6.etco2 = 38.0
        vitalB4E5ECB6.spo2 = 99.0
        signs.append(vitalB4E5ECB6)

        let vital02EEAA7F = VitalSignEntry(
            vitalSignsId: "02EEAA7F-E32C-45D8-A34F-4151128B022E",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 0, second: 42)
        )
        vital02EEAA7F.pam = 94.0
        vital02EEAA7F.fc = 85.0
        vital02EEAA7F.paS = 115.0
        vital02EEAA7F.paD = 83.0
        vital02EEAA7F.rhythm = "Sinusal"
        vital02EEAA7F.etco2 = 38.0
        vital02EEAA7F.spo2 = 100.0
        signs.append(vital02EEAA7F)

        let vitalC5849D2E = VitalSignEntry(
            vitalSignsId: "C5849D2E-692D-4717-A37D-AB8E2A83243B",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 10, second: 42)
        )
        vitalC5849D2E.pam = 94.0
        vitalC5849D2E.fc = 85.0
        vitalC5849D2E.paS = 116.0
        vitalC5849D2E.paD = 83.0
        vitalC5849D2E.rhythm = "Sinusal"
        vitalC5849D2E.etco2 = 38.0
        vitalC5849D2E.spo2 = 100.0
        signs.append(vitalC5849D2E)

        let vital146B7C18 = VitalSignEntry(
            vitalSignsId: "146B7C18-CB66-4EDC-8D92-5E06F42E3DB4",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 20, second: 42)
        )
        vital146B7C18.pam = 93.0
        vital146B7C18.fc = 84.0
        vital146B7C18.paS = 114.0
        vital146B7C18.paD = 83.0
        vital146B7C18.rhythm = "Sinusal"
        vital146B7C18.etco2 = 38.0
        vital146B7C18.spo2 = 100.0
        signs.append(vital146B7C18)

        let vital8DB13594 = VitalSignEntry(
            vitalSignsId: "8DB13594-C5CD-41C2-9C10-C6445F7BF11D",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 30, second: 42)
        )
        vital8DB13594.pam = 93.0
        vital8DB13594.fc = 82.0
        vital8DB13594.paS = 114.0
        vital8DB13594.paD = 82.0
        vital8DB13594.rhythm = "Sinusal"
        vital8DB13594.etco2 = 37.0
        vital8DB13594.spo2 = 100.0
        signs.append(vital8DB13594)

        let vital076B543F = VitalSignEntry(
            vitalSignsId: "076B543F-CEB6-476E-996A-00D63C38DD9D",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 40, second: 42)
        )
        vital076B543F.pam = 93.0
        vital076B543F.fc = 84.0
        vital076B543F.paS = 114.0
        vital076B543F.paD = 82.0
        vital076B543F.rhythm = "Sinusal"
        vital076B543F.etco2 = 37.0
        vital076B543F.spo2 = 100.0
        signs.append(vital076B543F)

        let vitalA38C24B5 = VitalSignEntry(
            vitalSignsId: "A38C24B5-5069-467E-B7EE-1D24CD91B0DD",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 9, minute: 50, second: 42)
        )
        vitalA38C24B5.pam = 94.0
        vitalA38C24B5.fc = 85.0
        vitalA38C24B5.paS = 115.0
        vitalA38C24B5.paD = 84.0
        vitalA38C24B5.rhythm = "Sinusal"
        vitalA38C24B5.etco2 = 37.0
        vitalA38C24B5.spo2 = 99.0
        signs.append(vitalA38C24B5)

        let vital47CE3765 = VitalSignEntry(
            vitalSignsId: "47CE3765-270A-4427-B1BF-ACE8564B8D2F",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 10, minute: 0, second: 42)
        )
        vital47CE3765.pam = 95.0
        vital47CE3765.fc = 83.0
        vital47CE3765.paS = 114.0
        vital47CE3765.paD = 85.0
        vital47CE3765.rhythm = "Sinusal"
        vital47CE3765.etco2 = 37.0
        vital47CE3765.spo2 = 99.0
        signs.append(vital47CE3765)

        let vital152CA56A = VitalSignEntry(
            vitalSignsId: "152CA56A-5177-4EC8-9A76-3169D851A7A9",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 10, minute: 10, second: 42)
        )
        vital152CA56A.pam = 100.0
        vital152CA56A.fc = 87.0
        vital152CA56A.paS = 123.0
        vital152CA56A.paD = 88.0
        vital152CA56A.rhythm = "Sinusal"
        vital152CA56A.etco2 = 38.0
        vital152CA56A.spo2 = 99.0
        signs.append(vital152CA56A)

        let vitalB3E62B39 = VitalSignEntry(
            vitalSignsId: "B3E62B39-66CC-4EEA-B947-472E45018E14",
            anesthesia: anesthesias[34],
            timestamp: createDate(day: 24, month: 11, year: 2025, hour: 10, minute: 20, second: 42)
        )
        vitalB3E62B39.pam = 100.0
        vitalB3E62B39.fc = 87.0
        vitalB3E62B39.paS = 123.0
        vitalB3E62B39.paD = 89.0
        vitalB3E62B39.rhythm = "Sinusal"
        vitalB3E62B39.etco2 = 37.0
        vitalB3E62B39.spo2 = 99.0
        signs.append(vitalB3E62B39)

        let vital2683B9E3 = VitalSignEntry(
            vitalSignsId: "2683B9E3-61C6-4F09-A799-081AE5CACA2F",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
        )
        vital2683B9E3.pam = 94.0
        vital2683B9E3.fc = 73.0
        vital2683B9E3.paS = 128.0
        vital2683B9E3.paD = 77.0
        vital2683B9E3.rhythm = "Sinusal"
        vital2683B9E3.spo2 = 96.0
        signs.append(vital2683B9E3)

        let vital996094AD = VitalSignEntry(
            vitalSignsId: "996094AD-5288-4CE3-A0A5-E41353A16EB8",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 35, second: 52)
        )
        vital996094AD.pam = 97.0
        vital996094AD.fc = 74.0
        vital996094AD.paS = 131.0
        vital996094AD.paD = 80.0
        vital996094AD.rhythm = "Sinusal"
        vital996094AD.spo2 = 96.0
        signs.append(vital996094AD)

        let vital7DAF3326 = VitalSignEntry(
            vitalSignsId: "7DAF3326-D36E-4024-8105-66539C5114B5",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 40, second: 52)
        )
        vital7DAF3326.pam = 98.0
        vital7DAF3326.fc = 72.0
        vital7DAF3326.paS = 133.0
        vital7DAF3326.paD = 80.0
        vital7DAF3326.rhythm = "Sinusal"
        vital7DAF3326.spo2 = 97.0
        signs.append(vital7DAF3326)

        let vitalD0FF371E = VitalSignEntry(
            vitalSignsId: "D0FF371E-430E-4AAA-A248-FD4C4569DB75",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 45, second: 52)
        )
        vitalD0FF371E.pam = 97.0
        vitalD0FF371E.fc = 72.0
        vitalD0FF371E.paS = 134.0
        vitalD0FF371E.paD = 79.0
        vitalD0FF371E.rhythm = "Sinusal"
        vitalD0FF371E.spo2 = 97.0
        signs.append(vitalD0FF371E)

        let vital505E39B2 = VitalSignEntry(
            vitalSignsId: "505E39B2-32C4-4E31-A5CC-C197C2BB54C1",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 50, second: 52)
        )
        vital505E39B2.pam = 96.0
        vital505E39B2.fc = 75.0
        vital505E39B2.paS = 133.0
        vital505E39B2.paD = 77.0
        vital505E39B2.rhythm = "Sinusal"
        vital505E39B2.spo2 = 98.0
        signs.append(vital505E39B2)

        let vital2B5EECDA = VitalSignEntry(
            vitalSignsId: "2B5EECDA-F00A-4283-AE0F-845466275739",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 55, second: 52)
        )
        vital2B5EECDA.pam = 96.0
        vital2B5EECDA.fc = 74.0
        vital2B5EECDA.paS = 135.0
        vital2B5EECDA.paD = 76.0
        vital2B5EECDA.rhythm = "Sinusal"
        vital2B5EECDA.spo2 = 97.0
        signs.append(vital2B5EECDA)

        let vitalE5F301E7 = VitalSignEntry(
            vitalSignsId: "E5F301E7-BFFB-4E0A-80CD-EB6F8974CA74",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 8, minute: 0, second: 52)
        )
        vitalE5F301E7.pam = 97.0
        vitalE5F301E7.fc = 75.0
        vitalE5F301E7.paS = 134.0
        vitalE5F301E7.paD = 79.0
        vitalE5F301E7.rhythm = "Sinusal"
        vitalE5F301E7.spo2 = 96.0
        signs.append(vitalE5F301E7)

        let vital9523C4C9 = VitalSignEntry(
            vitalSignsId: "9523C4C9-0255-4A42-A4F7-441BC9317095",
            anesthesia: anesthesias[35],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 8, minute: 10, second: 52)
        )
        vital9523C4C9.pam = 98.0
        vital9523C4C9.fc = 76.0
        vital9523C4C9.paS = 133.0
        vital9523C4C9.paD = 81.0
        vital9523C4C9.rhythm = "Sinusal"
        vital9523C4C9.spo2 = 96.0
        signs.append(vital9523C4C9)

        let vitalD3EE8AC4 = VitalSignEntry(
            vitalSignsId: "D3EE8AC4-D29F-439A-B772-21AC70BC5927",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 20, second: 25)
        )
        vitalD3EE8AC4.pam = 86.0
        vitalD3EE8AC4.fc = 75.0
        vitalD3EE8AC4.paS = 119.0
        vitalD3EE8AC4.paD = 70.0
        vitalD3EE8AC4.rhythm = "Sinusal"
        vitalD3EE8AC4.spo2 = 100.0
        signs.append(vitalD3EE8AC4)

        let vitalD9BB69C6 = VitalSignEntry(
            vitalSignsId: "D9BB69C6-C4C9-46D9-BEA6-AD0493F87C13",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 25, second: 25)
        )
        vitalD9BB69C6.pam = 86.0
        vitalD9BB69C6.fc = 75.0
        vitalD9BB69C6.paS = 117.0
        vitalD9BB69C6.paD = 70.0
        vitalD9BB69C6.rhythm = "Sinusal"
        vitalD9BB69C6.spo2 = 100.0
        signs.append(vitalD9BB69C6)

        let vital4FBC0F56 = VitalSignEntry(
            vitalSignsId: "4FBC0F56-937E-4B7B-9909-2E22894C9904",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 25)
        )
        vital4FBC0F56.pam = 86.0
        vital4FBC0F56.fc = 75.0
        vital4FBC0F56.paS = 117.0
        vital4FBC0F56.paD = 71.0
        vital4FBC0F56.rhythm = "Sinusal"
        vital4FBC0F56.spo2 = 99.0
        signs.append(vital4FBC0F56)

        let vital90102BAA = VitalSignEntry(
            vitalSignsId: "90102BAA-C52D-46FD-A339-F91BC41A0F74",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 35, second: 25)
        )
        vital90102BAA.pam = 87.0
        vital90102BAA.fc = 76.0
        vital90102BAA.paS = 118.0
        vital90102BAA.paD = 71.0
        vital90102BAA.rhythm = "Sinusal"
        vital90102BAA.spo2 = 99.0
        signs.append(vital90102BAA)

        let vitalD97AEA8D = VitalSignEntry(
            vitalSignsId: "D97AEA8D-F833-4BC9-99FE-A460D558155E",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 40, second: 25)
        )
        vitalD97AEA8D.pam = 88.0
        vitalD97AEA8D.fc = 76.0
        vitalD97AEA8D.paS = 119.0
        vitalD97AEA8D.paD = 73.0
        vitalD97AEA8D.rhythm = "Sinusal"
        vitalD97AEA8D.spo2 = 100.0
        signs.append(vitalD97AEA8D)

        let vital66AA5FC8 = VitalSignEntry(
            vitalSignsId: "66AA5FC8-4698-447D-965F-F71DF60499E0",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 45, second: 25)
        )
        vital66AA5FC8.pam = 86.0
        vital66AA5FC8.fc = 72.0
        vital66AA5FC8.paS = 115.0
        vital66AA5FC8.paD = 71.0
        vital66AA5FC8.rhythm = "Sinusal"
        vital66AA5FC8.spo2 = 100.0
        signs.append(vital66AA5FC8)

        let vital16FE627E = VitalSignEntry(
            vitalSignsId: "16FE627E-4BEA-43AD-87F7-1210A2407E37",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 50, second: 25)
        )
        vital16FE627E.pam = 88.0
        vital16FE627E.fc = 72.0
        vital16FE627E.paS = 117.0
        vital16FE627E.paD = 73.0
        vital16FE627E.rhythm = "Sinusal"
        vital16FE627E.spo2 = 100.0
        signs.append(vital16FE627E)

        let vital9067CE0F = VitalSignEntry(
            vitalSignsId: "9067CE0F-F55C-4DD3-95A8-298E415EEA0F",
            anesthesia: anesthesias[36],
            timestamp: createDate(day: 21, month: 11, year: 2025, hour: 8, minute: 0, second: 25)
        )
        vital9067CE0F.pam = 88.0
        vital9067CE0F.fc = 72.0
        vital9067CE0F.paS = 121.0
        vital9067CE0F.paD = 72.0
        vital9067CE0F.rhythm = "Sinusal"
        vital9067CE0F.spo2 = 100.0
        signs.append(vital9067CE0F)

        let vitalC100B5C8 = VitalSignEntry(
            vitalSignsId: "C100B5C8-1FAE-4663-9A50-D991F4226B04",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 20, second: 27)
        )
        vitalC100B5C8.pam = 97.0
        vitalC100B5C8.fc = 72.0
        vitalC100B5C8.paS = 118.0
        vitalC100B5C8.paD = 87.0
        vitalC100B5C8.rhythm = "Sinusal"
        vitalC100B5C8.spo2 = 97.0
        signs.append(vitalC100B5C8)

        let vital194EA31A = VitalSignEntry(
            vitalSignsId: "194EA31A-06C6-42E6-A107-DFA42D5B26EB",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 25, second: 27)
        )
        vital194EA31A.pam = 96.0
        vital194EA31A.fc = 73.0
        vital194EA31A.paS = 117.0
        vital194EA31A.paD = 85.0
        vital194EA31A.rhythm = "Sinusal"
        vital194EA31A.spo2 = 97.0
        signs.append(vital194EA31A)

        let vital941D2F4F = VitalSignEntry(
            vitalSignsId: "941D2F4F-DF0E-483F-94DC-0F6CA3812FE2",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 30, second: 27)
        )
        vital941D2F4F.pam = 96.0
        vital941D2F4F.fc = 71.0
        vital941D2F4F.paS = 120.0
        vital941D2F4F.paD = 84.0
        vital941D2F4F.rhythm = "Sinusal"
        vital941D2F4F.spo2 = 98.0
        signs.append(vital941D2F4F)

        let vital43CEA1CD = VitalSignEntry(
            vitalSignsId: "43CEA1CD-AFBE-42AB-AFDB-17A8F0E52829",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 35, second: 27)
        )
        vital43CEA1CD.pam = 96.0
        vital43CEA1CD.fc = 73.0
        vital43CEA1CD.paS = 118.0
        vital43CEA1CD.paD = 85.0
        vital43CEA1CD.rhythm = "Sinusal"
        vital43CEA1CD.spo2 = 97.0
        signs.append(vital43CEA1CD)

        let vitalDDAA3088 = VitalSignEntry(
            vitalSignsId: "DDAA3088-A516-4D1B-B01B-105164D31CD0",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 40, second: 27)
        )
        vitalDDAA3088.pam = 96.0
        vitalDDAA3088.fc = 72.0
        vitalDDAA3088.paS = 119.0
        vitalDDAA3088.paD = 84.0
        vitalDDAA3088.rhythm = "Sinusal"
        vitalDDAA3088.spo2 = 97.0
        signs.append(vitalDDAA3088)

        let vital19B07172 = VitalSignEntry(
            vitalSignsId: "19B07172-D516-4FB2-B184-BD068CFC1637",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 45, second: 27)
        )
        vital19B07172.pam = 96.0
        vital19B07172.fc = 72.0
        vital19B07172.paS = 117.0
        vital19B07172.paD = 86.0
        vital19B07172.rhythm = "Sinusal"
        vital19B07172.spo2 = 97.0
        signs.append(vital19B07172)

        let vitalEB18C482 = VitalSignEntry(
            vitalSignsId: "EB18C482-94E6-4894-89EA-333883058C1D",
            anesthesia: anesthesias[37],
            timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 50, second: 27)
        )
        vitalEB18C482.pam = 98.0
        vitalEB18C482.fc = 73.0
        vitalEB18C482.paS = 120.0
        vitalEB18C482.paD = 87.0
        vitalEB18C482.rhythm = "Sinusal"
        vitalEB18C482.spo2 = 97.0
        signs.append(vitalEB18C482)

        let vital4F1F5074 = VitalSignEntry(
            vitalSignsId: "4F1F5074-2A43-411B-B787-676D209147D8",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
        )
        vital4F1F5074.pam = 63.0
        vital4F1F5074.fc = 133.0
        vital4F1F5074.paS = 80.0
        vital4F1F5074.paD = 55.0
        vital4F1F5074.rhythm = "Sinusal"
        vital4F1F5074.spo2 = 100.0
        signs.append(vital4F1F5074)

        let vital8D71CDAB = VitalSignEntry(
            vitalSignsId: "8D71CDAB-3AE3-4C8A-854A-3045FA7AF8A9",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 45, second: 58)
        )
        vital8D71CDAB.pam = 63.0
        vital8D71CDAB.fc = 132.0
        vital8D71CDAB.paS = 78.0
        vital8D71CDAB.paD = 55.0
        vital8D71CDAB.rhythm = "Sinusal"
        vital8D71CDAB.spo2 = 100.0
        signs.append(vital8D71CDAB)

        let vitalD494BFFD = VitalSignEntry(
            vitalSignsId: "D494BFFD-8304-42E5-BBBE-EFD2EE68F2BC",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 50, second: 58)
        )
        vitalD494BFFD.pam = 63.0
        vitalD494BFFD.fc = 132.0
        vitalD494BFFD.paS = 78.0
        vitalD494BFFD.paD = 56.0
        vitalD494BFFD.rhythm = "Sinusal"
        vitalD494BFFD.spo2 = 99.0
        signs.append(vitalD494BFFD)

        let vitalA9434324 = VitalSignEntry(
            vitalSignsId: "A9434324-B92B-4092-B61C-8EEC86DBE12E",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 55, second: 58)
        )
        vitalA9434324.pam = 65.0
        vitalA9434324.fc = 130.0
        vitalA9434324.paS = 80.0
        vitalA9434324.paD = 57.0
        vitalA9434324.rhythm = "Sinusal"
        vitalA9434324.spo2 = 99.0
        signs.append(vitalA9434324)

        let vitalA24B772E = VitalSignEntry(
            vitalSignsId: "A24B772E-9424-42D8-B3E4-F48D4BC0E0A5",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 0, second: 58)
        )
        vitalA24B772E.pam = 66.0
        vitalA24B772E.fc = 128.0
        vitalA24B772E.paS = 83.0
        vitalA24B772E.paD = 57.0
        vitalA24B772E.rhythm = "Sinusal"
        vitalA24B772E.spo2 = 99.0
        signs.append(vitalA24B772E)

        let vital8BD5B530 = VitalSignEntry(
            vitalSignsId: "8BD5B530-B528-4511-A9AC-C1BD52AF02D5",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 5, second: 58)
        )
        vital8BD5B530.pam = 65.0
        vital8BD5B530.fc = 128.0
        vital8BD5B530.paS = 84.0
        vital8BD5B530.paD = 56.0
        vital8BD5B530.rhythm = "Sinusal"
        vital8BD5B530.spo2 = 98.0
        signs.append(vital8BD5B530)

        let vital2D800534 = VitalSignEntry(
            vitalSignsId: "2D800534-FFB3-402B-9024-1274CA3C2100",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 10, second: 58)
        )
        vital2D800534.pam = 64.0
        vital2D800534.fc = 129.0
        vital2D800534.paS = 85.0
        vital2D800534.paD = 54.0
        vital2D800534.rhythm = "Sinusal"
        vital2D800534.spo2 = 99.0
        signs.append(vital2D800534)

        let vitalEAA3880F = VitalSignEntry(
            vitalSignsId: "EAA3880F-D256-4ADC-A7FB-7AAA96FC57A2",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 20, second: 58)
        )
        vitalEAA3880F.pam = 67.0
        vitalEAA3880F.fc = 130.0
        vitalEAA3880F.paS = 86.0
        vitalEAA3880F.paD = 57.0
        vitalEAA3880F.rhythm = "Sinusal"
        vitalEAA3880F.spo2 = 99.0
        signs.append(vitalEAA3880F)

        let vital917932F2 = VitalSignEntry(
            vitalSignsId: "917932F2-D66C-4027-A626-A5545E0925A0",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 30, second: 58)
        )
        vital917932F2.pam = 64.0
        vital917932F2.fc = 128.0
        vital917932F2.paS = 83.0
        vital917932F2.paD = 55.0
        vital917932F2.rhythm = "Sinusal"
        vital917932F2.spo2 = 99.0
        signs.append(vital917932F2)

        let vital67BF05EF = VitalSignEntry(
            vitalSignsId: "67BF05EF-4655-4B1E-A975-1C992FBBC60C",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 40, second: 58)
        )
        vital67BF05EF.pam = 63.0
        vital67BF05EF.fc = 129.0
        vital67BF05EF.paS = 80.0
        vital67BF05EF.paD = 55.0
        vital67BF05EF.rhythm = "Sinusal"
        vital67BF05EF.spo2 = 99.0
        signs.append(vital67BF05EF)

        let vitalCF28B2BB = VitalSignEntry(
            vitalSignsId: "CF28B2BB-704C-4D78-B2B9-B554C3DCBB7C",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 9, minute: 50, second: 58)
        )
        vitalCF28B2BB.pam = 63.0
        vitalCF28B2BB.fc = 128.0
        vitalCF28B2BB.paS = 80.0
        vitalCF28B2BB.paD = 55.0
        vitalCF28B2BB.rhythm = "Sinusal"
        vitalCF28B2BB.spo2 = 100.0
        signs.append(vitalCF28B2BB)

        let vitalB694CE77 = VitalSignEntry(
            vitalSignsId: "B694CE77-4F22-4E31-B53E-6110F25FB433",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 10, minute: 0, second: 58)
        )
        vitalB694CE77.pam = 67.0
        vitalB694CE77.fc = 127.0
        vitalB694CE77.paS = 83.0
        vitalB694CE77.paD = 59.0
        vitalB694CE77.rhythm = "Sinusal"
        vitalB694CE77.spo2 = 100.0
        signs.append(vitalB694CE77)

        let vitalF9012B72 = VitalSignEntry(
            vitalSignsId: "F9012B72-9B87-43E3-B3D6-80C9A6E0A0AA",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 10, minute: 10, second: 58)
        )
        vitalF9012B72.pam = 67.0
        vitalF9012B72.fc = 126.0
        vitalF9012B72.paS = 84.0
        vitalF9012B72.paD = 59.0
        vitalF9012B72.rhythm = "Sinusal"
        vitalF9012B72.spo2 = 100.0
        signs.append(vitalF9012B72)

        let vitalD17A3DB8 = VitalSignEntry(
            vitalSignsId: "D17A3DB8-4E77-45D9-AF31-C25C23794716",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 10, minute: 20, second: 58)
        )
        vitalD17A3DB8.pam = 69.0
        vitalD17A3DB8.fc = 134.0
        vitalD17A3DB8.paS = 87.0
        vitalD17A3DB8.paD = 60.0
        vitalD17A3DB8.rhythm = "Sinusal"
        vitalD17A3DB8.spo2 = 100.0
        signs.append(vitalD17A3DB8)

        let vitalEE3CDA3F = VitalSignEntry(
            vitalSignsId: "EE3CDA3F-C474-4C8E-B2A7-E9C31B6FCCD9",
            anesthesia: anesthesias[38],
            timestamp: createDate(day: 3, month: 11, year: 2025, hour: 10, minute: 30, second: 58)
        )
        vitalEE3CDA3F.pam = 67.0
        vitalEE3CDA3F.fc = 134.0
        vitalEE3CDA3F.paS = 88.0
        vitalEE3CDA3F.paD = 57.0
        vitalEE3CDA3F.rhythm = "Sinusal"
        vitalEE3CDA3F.spo2 = 100.0
        signs.append(vitalEE3CDA3F)

        let vital63FFAC8F = VitalSignEntry(
            vitalSignsId: "63FFAC8F-16AF-411E-B174-FD666A118ECF",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
        )
        vital63FFAC8F.pam = 83.0
        vital63FFAC8F.fc = 80.0
        vital63FFAC8F.paS = 102.0
        vital63FFAC8F.paD = 74.0
        vital63FFAC8F.rhythm = "Sinusal"
        vital63FFAC8F.spo2 = 100.0
        signs.append(vital63FFAC8F)

        let vital02D2BC67 = VitalSignEntry(
            vitalSignsId: "02D2BC67-1757-495A-8EB1-8DD220AFDA76",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 35, second: 26)
        )
        vital02D2BC67.pam = 85.0
        vital02D2BC67.fc = 79.0
        vital02D2BC67.paS = 104.0
        vital02D2BC67.paD = 75.0
        vital02D2BC67.rhythm = "Sinusal"
        vital02D2BC67.spo2 = 99.0
        signs.append(vital02D2BC67)

        let vitalA04650BA = VitalSignEntry(
            vitalSignsId: "A04650BA-A0C6-4507-BE1E-A53AFCAAB6CE",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 40, second: 26)
        )
        vitalA04650BA.pam = 86.0
        vitalA04650BA.fc = 76.0
        vitalA04650BA.paS = 105.0
        vitalA04650BA.paD = 77.0
        vitalA04650BA.rhythm = "Sinusal"
        vitalA04650BA.spo2 = 100.0
        signs.append(vitalA04650BA)

        let vital554CBB6A = VitalSignEntry(
            vitalSignsId: "554CBB6A-89F0-4FA7-84AD-A94118317BB5",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 45, second: 26)
        )
        vital554CBB6A.pam = 85.0
        vital554CBB6A.fc = 76.0
        vital554CBB6A.paS = 103.0
        vital554CBB6A.paD = 76.0
        vital554CBB6A.rhythm = "Sinusal"
        vital554CBB6A.spo2 = 99.0
        signs.append(vital554CBB6A)

        let vital0859692F = VitalSignEntry(
            vitalSignsId: "0859692F-C195-4D56-AC5C-B5497E024B48",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 50, second: 26)
        )
        vital0859692F.pam = 85.0
        vital0859692F.fc = 79.0
        vital0859692F.paS = 106.0
        vital0859692F.paD = 74.0
        vital0859692F.rhythm = "Sinusal"
        vital0859692F.spo2 = 99.0
        signs.append(vital0859692F)

        let vital8EB06020 = VitalSignEntry(
            vitalSignsId: "8EB06020-B629-45A6-B34E-063BAE7A4CEF",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 55, second: 26)
        )
        vital8EB06020.pam = 85.0
        vital8EB06020.fc = 77.0
        vital8EB06020.paS = 108.0
        vital8EB06020.paD = 74.0
        vital8EB06020.rhythm = "Sinusal"
        vital8EB06020.spo2 = 100.0
        signs.append(vital8EB06020)

        let vital9A870C90 = VitalSignEntry(
            vitalSignsId: "9A870C90-8169-4366-A27B-C1A86F28A663",
            anesthesia: anesthesias[39],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 9, minute: 0, second: 26)
        )
        vital9A870C90.pam = 82.0
        vital9A870C90.fc = 79.0
        vital9A870C90.paS = 101.0
        vital9A870C90.paD = 73.0
        vital9A870C90.rhythm = "Sinusal"
        vital9A870C90.spo2 = 100.0
        signs.append(vital9A870C90)

        let vitalE7975250 = VitalSignEntry(
            vitalSignsId: "E7975250-4921-486F-9B65-C98D59A8269B",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
        )
        vitalE7975250.pam = 75.0
        vitalE7975250.fc = 76.0
        vitalE7975250.paS = 95.0
        vitalE7975250.paD = 65.0
        vitalE7975250.rhythm = "Sinusal"
        vitalE7975250.spo2 = 96.0
        signs.append(vitalE7975250)

        let vital04C9CEFE = VitalSignEntry(
            vitalSignsId: "04C9CEFE-39F9-4BB9-B1E6-BB932ACF107D",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 25, second: 49)
        )
        vital04C9CEFE.pam = 74.0
        vital04C9CEFE.fc = 80.0
        vital04C9CEFE.paS = 95.0
        vital04C9CEFE.paD = 64.0
        vital04C9CEFE.rhythm = "Sinusal"
        vital04C9CEFE.spo2 = 97.0
        signs.append(vital04C9CEFE)

        let vital3AE18C1C = VitalSignEntry(
            vitalSignsId: "3AE18C1C-E73A-4BEE-A0F8-A03AA0CA3D09",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 30, second: 49)
        )
        vital3AE18C1C.pam = 74.0
        vital3AE18C1C.fc = 81.0
        vital3AE18C1C.paS = 95.0
        vital3AE18C1C.paD = 64.0
        vital3AE18C1C.rhythm = "Sinusal"
        vital3AE18C1C.spo2 = 97.0
        signs.append(vital3AE18C1C)

        let vital27C45A53 = VitalSignEntry(
            vitalSignsId: "27C45A53-0FCE-4121-AAB3-0DE5F1FD0790",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 35, second: 49)
        )
        vital27C45A53.pam = 81.0
        vital27C45A53.fc = 76.0
        vital27C45A53.paS = 103.0
        vital27C45A53.paD = 70.0
        vital27C45A53.rhythm = "Sinusal"
        vital27C45A53.spo2 = 97.0
        signs.append(vital27C45A53)

        let vital4FB2FC4F = VitalSignEntry(
            vitalSignsId: "4FB2FC4F-98E7-4AB0-96D9-B206AF8F2A67",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 40, second: 49)
        )
        vital4FB2FC4F.pam = 82.0
        vital4FB2FC4F.fc = 73.0
        vital4FB2FC4F.paS = 105.0
        vital4FB2FC4F.paD = 71.0
        vital4FB2FC4F.rhythm = "Sinusal"
        vital4FB2FC4F.spo2 = 97.0
        signs.append(vital4FB2FC4F)

        let vital540980F8 = VitalSignEntry(
            vitalSignsId: "540980F8-B016-42C5-88E8-6500194B7015",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
        )
        vital540980F8.pam = 84.0
        vital540980F8.fc = 71.0
        vital540980F8.paS = 107.0
        vital540980F8.paD = 73.0
        vital540980F8.rhythm = "Sinusal"
        vital540980F8.spo2 = 97.0
        signs.append(vital540980F8)

        let vital939B530A = VitalSignEntry(
            vitalSignsId: "939B530A-4402-4D80-92FA-2BDCC0D269C5",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 50, second: 49)
        )
        vital939B530A.pam = 86.0
        vital939B530A.fc = 70.0
        vital939B530A.paS = 107.0
        vital939B530A.paD = 75.0
        vital939B530A.rhythm = "Sinusal"
        vital939B530A.spo2 = 96.0
        signs.append(vital939B530A)

        let vital13C051E8 = VitalSignEntry(
            vitalSignsId: "13C051E8-B662-4E9A-80B0-239E2241F3F0",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 0, second: 49)
        )
        vital13C051E8.pam = 89.0
        vital13C051E8.fc = 70.0
        vital13C051E8.paS = 114.0
        vital13C051E8.paD = 77.0
        vital13C051E8.rhythm = "Sinusal"
        vital13C051E8.spo2 = 97.0
        signs.append(vital13C051E8)

        let vitalD7AA63DE = VitalSignEntry(
            vitalSignsId: "D7AA63DE-EF77-4014-B6EF-D0B764B83CA0",
            anesthesia: anesthesias[40],
            timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 10, second: 49)
        )
        vitalD7AA63DE.pam = 92.0
        vitalD7AA63DE.fc = 73.0
        vitalD7AA63DE.paS = 119.0
        vitalD7AA63DE.paD = 78.0
        vitalD7AA63DE.rhythm = "Sinusal"
        vitalD7AA63DE.spo2 = 97.0
        signs.append(vitalD7AA63DE)

        let vital53D50EAB = VitalSignEntry(
            vitalSignsId: "53D50EAB-5E04-4786-B1FC-01D59DBBB358",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 3, second: 7)
        )
        vital53D50EAB.pam = 90.0
        vital53D50EAB.fc = 88.0
        vital53D50EAB.paS = 123.0
        vital53D50EAB.paD = 73.0
        vital53D50EAB.rhythm = "Sinusal"
        vital53D50EAB.spo2 = 99.0
        signs.append(vital53D50EAB)

        let vitalEDA89952 = VitalSignEntry(
            vitalSignsId: "EDA89952-2379-402E-AFB5-FDEDDFE59081",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 8, second: 7)
        )
        vitalEDA89952.pam = 88.0
        vitalEDA89952.fc = 90.0
        vitalEDA89952.paS = 123.0
        vitalEDA89952.paD = 70.0
        vitalEDA89952.rhythm = "Sinusal"
        vitalEDA89952.spo2 = 100.0
        signs.append(vitalEDA89952)

        let vital857E095D = VitalSignEntry(
            vitalSignsId: "857E095D-D04B-4C45-BDF4-069D76DA646C",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 13, second: 7)
        )
        vital857E095D.pam = 85.0
        vital857E095D.fc = 91.0
        vital857E095D.paS = 118.0
        vital857E095D.paD = 69.0
        vital857E095D.rhythm = "Sinusal"
        vital857E095D.spo2 = 100.0
        signs.append(vital857E095D)

        let vital57FAC9CB = VitalSignEntry(
            vitalSignsId: "57FAC9CB-AB0A-400B-834D-2AF94A679230",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 18, second: 7)
        )
        vital57FAC9CB.pam = 92.0
        vital57FAC9CB.fc = 89.0
        vital57FAC9CB.paS = 125.0
        vital57FAC9CB.paD = 75.0
        vital57FAC9CB.rhythm = "Sinusal"
        vital57FAC9CB.spo2 = 100.0
        signs.append(vital57FAC9CB)

        let vitalB28918B5 = VitalSignEntry(
            vitalSignsId: "B28918B5-9302-4D09-B329-1986B9E16B66",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 23, second: 7)
        )
        vitalB28918B5.pam = 93.0
        vitalB28918B5.fc = 89.0
        vitalB28918B5.paS = 130.0
        vitalB28918B5.paD = 75.0
        vitalB28918B5.rhythm = "Sinusal"
        vitalB28918B5.spo2 = 100.0
        signs.append(vitalB28918B5)

        let vital577E5DA0 = VitalSignEntry(
            vitalSignsId: "577E5DA0-2F58-42D3-947C-04711C4276D3",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 28, second: 7)
        )
        vital577E5DA0.pam = 92.0
        vital577E5DA0.fc = 86.0
        vital577E5DA0.paS = 125.0
        vital577E5DA0.paD = 75.0
        vital577E5DA0.rhythm = "Sinusal"
        vital577E5DA0.spo2 = 99.0
        signs.append(vital577E5DA0)

        let vitalF1685EE8 = VitalSignEntry(
            vitalSignsId: "F1685EE8-222E-40DF-A269-D95F59EBDDF6",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 33, second: 7)
        )
        vitalF1685EE8.pam = 92.0
        vitalF1685EE8.fc = 85.0
        vitalF1685EE8.paS = 127.0
        vitalF1685EE8.paD = 75.0
        vitalF1685EE8.rhythm = "Sinusal"
        vitalF1685EE8.spo2 = 98.0
        signs.append(vitalF1685EE8)

        let vitalC1F6FE96 = VitalSignEntry(
            vitalSignsId: "C1F6FE96-141F-42A8-9F08-CB862737E553",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 43, second: 7)
        )
        vitalC1F6FE96.pam = 93.0
        vitalC1F6FE96.fc = 87.0
        vitalC1F6FE96.paS = 126.0
        vitalC1F6FE96.paD = 76.0
        vitalC1F6FE96.rhythm = "Sinusal"
        vitalC1F6FE96.spo2 = 98.0
        signs.append(vitalC1F6FE96)

        let vital074CA2AB = VitalSignEntry(
            vitalSignsId: "074CA2AB-AFF6-479E-BEB7-2F6F2182FF51",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 53, second: 7)
        )
        vital074CA2AB.pam = 97.0
        vital074CA2AB.fc = 89.0
        vital074CA2AB.paS = 132.0
        vital074CA2AB.paD = 79.0
        vital074CA2AB.rhythm = "Sinusal"
        vital074CA2AB.spo2 = 98.0
        signs.append(vital074CA2AB)

        let vitalDA79B380 = VitalSignEntry(
            vitalSignsId: "DA79B380-1BAF-4514-BA47-E39FBD938C00",
            anesthesia: anesthesias[41],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 12, minute: 3, second: 7)
        )
        vitalDA79B380.pam = 96.0
        vitalDA79B380.fc = 89.0
        vitalDA79B380.paS = 131.0
        vitalDA79B380.paD = 79.0
        vitalDA79B380.rhythm = "Sinusal"
        vitalDA79B380.spo2 = 99.0
        signs.append(vitalDA79B380)

        let vital2DA6FDFE = VitalSignEntry(
            vitalSignsId: "2DA6FDFE-CA75-4AC5-8037-016AD1F9BD69",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 20, second: 33)
        )
        vital2DA6FDFE.pam = 103.0
        vital2DA6FDFE.fc = 65.0
        vital2DA6FDFE.paS = 136.0
        vital2DA6FDFE.paD = 87.0
        vital2DA6FDFE.rhythm = "Sinusal"
        vital2DA6FDFE.spo2 = 95.0
        signs.append(vital2DA6FDFE)

        let vitalFC50AEE1 = VitalSignEntry(
            vitalSignsId: "FC50AEE1-2D1D-4FB3-B22F-FC2E40CC8788",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 25, second: 33)
        )
        vitalFC50AEE1.pam = 104.0
        vitalFC50AEE1.fc = 66.0
        vitalFC50AEE1.paS = 137.0
        vitalFC50AEE1.paD = 87.0
        vitalFC50AEE1.rhythm = "Sinusal"
        vitalFC50AEE1.spo2 = 95.0
        signs.append(vitalFC50AEE1)

        let vital83477994 = VitalSignEntry(
            vitalSignsId: "83477994-F8ED-4B92-B487-4A2E632644D9",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 30, second: 33)
        )
        vital83477994.pam = 105.0
        vital83477994.fc = 64.0
        vital83477994.paS = 138.0
        vital83477994.paD = 88.0
        vital83477994.rhythm = "Sinusal"
        vital83477994.spo2 = 95.0
        signs.append(vital83477994)

        let vitalE532A8AE = VitalSignEntry(
            vitalSignsId: "E532A8AE-1D23-40AE-B08E-51A900CCF754",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 35, second: 33)
        )
        vitalE532A8AE.pam = 104.0
        vitalE532A8AE.fc = 63.0
        vitalE532A8AE.paS = 135.0
        vitalE532A8AE.paD = 88.0
        vitalE532A8AE.rhythm = "Sinusal"
        vitalE532A8AE.spo2 = 95.0
        signs.append(vitalE532A8AE)

        let vital14E5E846 = VitalSignEntry(
            vitalSignsId: "14E5E846-C4F3-4D8D-9D5A-16473DB60E0B",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 40, second: 33)
        )
        vital14E5E846.pam = 106.0
        vital14E5E846.fc = 63.0
        vital14E5E846.paS = 139.0
        vital14E5E846.paD = 90.0
        vital14E5E846.rhythm = "Sinusal"
        vital14E5E846.spo2 = 95.0
        signs.append(vital14E5E846)

        let vital71609655 = VitalSignEntry(
            vitalSignsId: "71609655-360C-4222-8C0F-7A7AAD4A1760",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 45, second: 33)
        )
        vital71609655.pam = 105.0
        vital71609655.fc = 66.0
        vital71609655.paS = 136.0
        vital71609655.paD = 90.0
        vital71609655.rhythm = "Sinusal"
        vital71609655.spo2 = 95.0
        signs.append(vital71609655)

        let vital0D894A3A = VitalSignEntry(
            vitalSignsId: "0D894A3A-DF47-4CE5-97C7-6D9BFC2454AB",
            anesthesia: anesthesias[42],
            timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 50, second: 33)
        )
        vital0D894A3A.pam = 106.0
        vital0D894A3A.fc = 67.0
        vital0D894A3A.paS = 137.0
        vital0D894A3A.paD = 90.0
        vital0D894A3A.rhythm = "Sinusal"
        vital0D894A3A.spo2 = 95.0
        signs.append(vital0D894A3A)

        let vital70E2C0D9 = VitalSignEntry(
            vitalSignsId: "70E2C0D9-4024-4513-AFD3-5FF4CDC4775D",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 10, second: 13)
        )
        vital70E2C0D9.pam = 82.0
        vital70E2C0D9.fc = 80.0
        vital70E2C0D9.paS = 103.0
        vital70E2C0D9.paD = 71.0
        vital70E2C0D9.rhythm = "Sinusal"
        vital70E2C0D9.spo2 = 98.0
        signs.append(vital70E2C0D9)

        let vital12D0DEC7 = VitalSignEntry(
            vitalSignsId: "12D0DEC7-3E71-40B4-9937-6753DA89A1FC",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 15, second: 13)
        )
        vital12D0DEC7.pam = 84.0
        vital12D0DEC7.fc = 81.0
        vital12D0DEC7.paS = 105.0
        vital12D0DEC7.paD = 73.0
        vital12D0DEC7.rhythm = "Sinusal"
        vital12D0DEC7.spo2 = 99.0
        signs.append(vital12D0DEC7)

        let vital7940F532 = VitalSignEntry(
            vitalSignsId: "7940F532-2387-47A3-944C-837593948313",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 20, second: 13)
        )
        vital7940F532.pam = 86.0
        vital7940F532.fc = 80.0
        vital7940F532.paS = 111.0
        vital7940F532.paD = 73.0
        vital7940F532.rhythm = "Sinusal"
        vital7940F532.spo2 = 98.0
        signs.append(vital7940F532)

        let vitalD6152087 = VitalSignEntry(
            vitalSignsId: "D6152087-32E9-4E89-ABF8-EAB663441E1B",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 25, second: 13)
        )
        vitalD6152087.pam = 85.0
        vitalD6152087.fc = 77.0
        vitalD6152087.paS = 109.0
        vitalD6152087.paD = 73.0
        vitalD6152087.rhythm = "Sinusal"
        vitalD6152087.spo2 = 98.0
        signs.append(vitalD6152087)

        let vital5D6FE271 = VitalSignEntry(
            vitalSignsId: "5D6FE271-C0BF-4A2E-88AD-25C2843D6F66",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 30, second: 13)
        )
        vital5D6FE271.pam = 86.0
        vital5D6FE271.fc = 76.0
        vital5D6FE271.paS = 109.0
        vital5D6FE271.paD = 74.0
        vital5D6FE271.rhythm = "Sinusal"
        vital5D6FE271.spo2 = 98.0
        signs.append(vital5D6FE271)

        let vitalD5F59320 = VitalSignEntry(
            vitalSignsId: "D5F59320-7935-4BB4-AB29-738C4B3E74C9",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 35, second: 13)
        )
        vitalD5F59320.pam = 84.0
        vitalD5F59320.fc = 76.0
        vitalD5F59320.paS = 107.0
        vitalD5F59320.paD = 73.0
        vitalD5F59320.rhythm = "Sinusal"
        vitalD5F59320.spo2 = 98.0
        signs.append(vitalD5F59320)

        let vitalC04AC459 = VitalSignEntry(
            vitalSignsId: "C04AC459-B38D-4E0F-AA1E-E72C80A61726",
            anesthesia: anesthesias[43],
            timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 40, second: 13)
        )
        vitalC04AC459.pam = 87.0
        vitalC04AC459.fc = 77.0
        vitalC04AC459.paS = 110.0
        vitalC04AC459.paD = 75.0
        vitalC04AC459.rhythm = "Sinusal"
        vitalC04AC459.spo2 = 98.0
        signs.append(vitalC04AC459)

        return signs
    }
    private static func createDate(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components) ?? Date()
    }
}
