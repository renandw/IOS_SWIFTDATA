//
//  MedicationsSample.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 31/12/25.
//
import Foundation

extension MedicationEntry {
    static func samples(anesthesias: [Anesthesia]) -> [MedicationEntry] {
        return [
            MedicationEntry(
                medicationId: "F14C19DD-5584-4904-A312-98FDE89490F9",
                anesthesia: anesthesias[0],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L",
                name: "Oxigênio",
                timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 0, second: 28)
            ),
            MedicationEntry(
                medicationId: "B726C6CE-FDE2-4EBD-AF64-E97F346CB933",
                anesthesia: anesthesias[0],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 0, second: 28)
            ),
            MedicationEntry(
                medicationId: "A379F917-67BD-4FB1-9BEF-56F439294838",
                anesthesia: anesthesias[0],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "2mg",
                name: "Morfina",
                timestamp: createDate(day: 27, month: 12, year: 2025, hour: 20, minute: 0, second: 28)
            ),
            MedicationEntry(
                medicationId: "A7921EDC-38A4-46FE-84FA-A6C3BA593A5F",
                anesthesia: anesthesias[1],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "C18AD381-D6CF-4AEB-8E2C-168F10582D11",
                anesthesia: anesthesias[1],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "FA38DF4F-37CB-4FBE-A2CF-5783BFE5AC3A",
                anesthesia: anesthesias[1],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "7EA264A0-8E61-46C9-8273-3E873705F0E5",
                anesthesia: anesthesias[1],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "5EB4EEBD-7B65-4D29-BFCD-010D062F7375",
                anesthesia: anesthesias[1],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "93E6B1C6-DE97-4099-BC9A-138A657A67AA",
                anesthesia: anesthesias[1],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "4589FEC9-8927-4885-A670-0728E9644A88",
                anesthesia: anesthesias[1],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "225682DC-FB38-4415-B3A2-D81F21D6C729",
                anesthesia: anesthesias[1],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "E8C2447B-80DF-486B-A78D-9949ECA6D488",
                anesthesia: anesthesias[1],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "E00A81F8-6578-4F82-87F8-71892B1AC273",
                anesthesia: anesthesias[1],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "273A75E1-0812-42CC-A878-15E92692AE16",
                anesthesia: anesthesias[1],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "B511C9F0-1413-4530-8315-8470AF1D6074",
                anesthesia: anesthesias[1],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 0, second: 30)
            ),
            MedicationEntry(
                medicationId: "F4634070-3897-47CF-9F74-E30C3FF8A45D",
                anesthesia: anesthesias[1],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 42, second: 30)
            ),
            MedicationEntry(
                medicationId: "24023731-1DE0-4360-9D10-2FAE9E28774E",
                anesthesia: anesthesias[1],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "6mg",
                name: "Morfina",
                timestamp: createDate(day: 22, month: 12, year: 2025, hour: 8, minute: 46, second: 30)
            ),
            MedicationEntry(
                medicationId: "E13CAB25-97E2-4224-B41C-6854207651AD",
                anesthesia: anesthesias[2],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "BF1485B5-3EEE-4763-8B55-B7B38BE361B1",
                anesthesia: anesthesias[2],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "28212094-993C-488D-9F52-D7DAEEC0D850",
                anesthesia: anesthesias[2],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "EE9EF39E-39EB-4BA0-AE84-54B1C0A91309",
                anesthesia: anesthesias[2],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "38836AE2-5373-4D34-A2A4-F34F77427672",
                anesthesia: anesthesias[2],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "C7D287D4-95EA-4DB0-854E-97FE65B0BB4A",
                anesthesia: anesthesias[2],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "4FFFC4EC-82A4-4DF6-AD66-1CD017FCC25D",
                anesthesia: anesthesias[2],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "C1D3D877-8AE2-4A3A-90F8-5DCC988C86CF",
                anesthesia: anesthesias[2],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 50, second: 32)
            ),
            MedicationEntry(
                medicationId: "7E9B4181-C8DD-41BE-83F4-8AA46A05EE6F",
                anesthesia: anesthesias[2],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 8, minute: 5, second: 32)
            ),
            MedicationEntry(
                medicationId: "0F91A40A-15F2-43A9-9321-AADA9145C113",
                anesthesia: anesthesias[3],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 40, second: 2)
            ),
            MedicationEntry(
                medicationId: "0F374F95-1213-45F3-9C18-1BFDF6766B80",
                anesthesia: anesthesias[3],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 40, second: 2)
            ),
            MedicationEntry(
                medicationId: "CC907DF3-94DE-4BBD-B108-B6A11F173F07",
                anesthesia: anesthesias[3],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 40, second: 2)
            ),
            MedicationEntry(
                medicationId: "F4FF4B4E-8F49-4ADD-BF8E-CCACE3E8B2AF",
                anesthesia: anesthesias[3],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 18, month: 12, year: 2025, hour: 7, minute: 40, second: 2)
            ),
            MedicationEntry(
                medicationId: "FE39F603-CFD4-435E-A9EA-81EF6F444224",
                anesthesia: anesthesias[4],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Isobárica",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "316A9885-A977-4CA8-9F3D-6544EF495875",
                anesthesia: anesthesias[4],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "471930C7-6F81-4CC2-A931-D00A613B6268",
                anesthesia: anesthesias[4],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "439EC4FE-39F4-4DE4-8BFE-3ACD7A4C2222",
                anesthesia: anesthesias[4],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "C8EFAECC-C78C-496D-BA09-499CB9C5A310",
                anesthesia: anesthesias[4],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "C2FBD5CD-748B-428A-A69E-0EA8D95C617B",
                anesthesia: anesthesias[4],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "69A06EB1-BCF5-4832-B39A-2E02A448F636",
                anesthesia: anesthesias[4],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "A1B541AB-5F61-4198-91C6-5FD8E8ADA97E",
                anesthesia: anesthesias[4],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "94F0F44B-E766-440F-AF5D-69508E833DFF",
                anesthesia: anesthesias[4],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "5ED19E57-8A53-42F7-ADCF-561C26B8AF1C",
                anesthesia: anesthesias[4],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "902AC483-CA85-49D9-804A-FF492C4BBA81",
                anesthesia: anesthesias[4],
                categoryRaw: "Benzodiazepínico",
                viaRaw: "EV",
                dose: "5mg",
                name: "Midazolam",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 8, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "0BA5BDC7-AD87-48B9-A7A3-A3B5B4513FC7",
                anesthesia: anesthesias[4],
                categoryRaw: "Anticolinérgico",
                viaRaw: "EV",
                dose: "0.5mg",
                name: "Atropina",
                timestamp: createDate(day: 17, month: 12, year: 2025, hour: 9, minute: 10, second: 23)
            ),
            MedicationEntry(
                medicationId: "D6A60C46-948F-4002-9730-14FA94BEC2BE",
                anesthesia: anesthesias[5],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "7EBAB42F-002E-428C-8C12-4F297BFE37E1",
                anesthesia: anesthesias[5],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "A4A66A06-1BE6-4B96-BB24-657FCFA6CD8E",
                anesthesia: anesthesias[5],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "12425AD5-9A30-4330-889A-C994B7C45DE1",
                anesthesia: anesthesias[5],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "770D712D-653C-41D2-B054-909FAE247989",
                anesthesia: anesthesias[5],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "BD0A3422-46FF-4013-8411-5931A52AC6F4",
                anesthesia: anesthesias[5],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "EAA115A4-30F7-43E6-84E2-24E6327EE394",
                anesthesia: anesthesias[5],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "A238FDE8-A79B-4CBD-8536-97483014F867",
                anesthesia: anesthesias[5],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "035F4A49-F59F-47C9-997F-12B93E23AB1F",
                anesthesia: anesthesias[5],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "08894135-D71A-40F4-AE03-70CEFD077093",
                anesthesia: anesthesias[5],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "4755B6B7-AA50-41F9-B962-D48D4EBC6FD7",
                anesthesia: anesthesias[5],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "866F439E-0C67-4146-A49E-10224DABD480",
                anesthesia: anesthesias[5],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "1A9644D6-A954-488C-9960-07DC376328B5",
                anesthesia: anesthesias[5],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 16, month: 12, year: 2025, hour: 7, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "04EF54C5-1F12-464F-A695-E2601F9003B8",
                anesthesia: anesthesias[6],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 50, second: 48)
            ),
            MedicationEntry(
                medicationId: "26D5C01A-6BB7-425B-8800-AEE2B6CDC58A",
                anesthesia: anesthesias[6],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 50, second: 48)
            ),
            MedicationEntry(
                medicationId: "64CFFDE7-B51E-4590-981B-D9585D1E7A83",
                anesthesia: anesthesias[6],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 50, second: 48)
            ),
            MedicationEntry(
                medicationId: "BA16A8EB-03C4-4EB3-A0B7-3D7D1AA47D9E",
                anesthesia: anesthesias[6],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 50, second: 48)
            ),
            MedicationEntry(
                medicationId: "03CA6026-0D3B-4F98-8602-30DDEE11123A",
                anesthesia: anesthesias[7],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 25, second: 36)
            ),
            MedicationEntry(
                medicationId: "70A6EE7E-03E9-4894-B692-C75EC6E70551",
                anesthesia: anesthesias[7],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 25, second: 36)
            ),
            MedicationEntry(
                medicationId: "C288A505-A5C3-4E58-B2F8-B202526C485C",
                anesthesia: anesthesias[7],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 25, second: 36)
            ),
            MedicationEntry(
                medicationId: "8A4C5AB6-3048-4997-9175-4731C27A736E",
                anesthesia: anesthesias[7],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 15, month: 12, year: 2025, hour: 7, minute: 25, second: 36)
            ),
            MedicationEntry(
                medicationId: "06110AAA-E066-41E4-BEDD-1E3F3B1E50BD",
                anesthesia: anesthesias[8],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Isobárica",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "2AF77383-A290-43E6-90A6-7E1A7C573732",
                anesthesia: anesthesias[8],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "D16937E1-633D-4DE2-86EB-615DF180EA97",
                anesthesia: anesthesias[8],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "9CCA591B-B5CC-48AB-9B9E-D6E95DB009BA",
                anesthesia: anesthesias[8],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "5C8B132F-F104-48E2-971D-537E65A1A7C6",
                anesthesia: anesthesias[8],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "E3C2EB45-0BC5-4D9A-A13D-EFC836715919",
                anesthesia: anesthesias[8],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "20286F4A-E7D5-46DA-8BBD-6C9B76949142",
                anesthesia: anesthesias[8],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "E10F0DA8-0D41-4C48-B230-7ED1D05F238E",
                anesthesia: anesthesias[8],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "D38AB102-8ACE-47DE-AB4B-F12C57B395EC",
                anesthesia: anesthesias[8],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "13D58AAD-5343-4BD7-BBF9-CFB4B8A17E69",
                anesthesia: anesthesias[8],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "1g",
                name: "Ceftriaxona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "EDE117D2-7FDD-4166-BD8A-188AB5A3096F",
                anesthesia: anesthesias[8],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "400mg BIC ACM",
                name: "Propofol",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 10, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "9520D2FB-177D-4804-9C55-01325ED636DB",
                anesthesia: anesthesias[8],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "16A1AA28-959F-4313-A7B4-AF08E19B41EC",
                anesthesia: anesthesias[8],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 11, minute: 30, second: 32)
            ),
            MedicationEntry(
                medicationId: "580F23F8-94E7-4A44-B3A2-0FAD2FE5563D",
                anesthesia: anesthesias[8],
                categoryRaw: "Reversor",
                viaRaw: "EV",
                dose: "0,5mg",
                name: "Flumazenil",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 12, minute: 4, second: 32)
            ),
            MedicationEntry(
                medicationId: "52A6A91E-F5A6-4135-A019-68E9AD0FB99D",
                anesthesia: anesthesias[8],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "150mcg",
                name: "Fentanil",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 9, minute: 20, second: 32)
            ),
            MedicationEntry(
                medicationId: "FF5BDCD5-BC4D-4A79-92A8-591E05DDC69A",
                anesthesia: anesthesias[9],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "69mg",
                name: "Propofol",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "01FCEAF2-4C88-4B22-85FD-4A06AAC3C6F0",
                anesthesia: anesthesias[9],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "69mcg",
                name: "Fentanil",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "0173885D-7014-4F0D-87E6-35EBAABB16C0",
                anesthesia: anesthesias[9],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "BCCC50E1-B728-46C2-ABE6-0275AA8D7A07",
                anesthesia: anesthesias[9],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "E041F54D-6640-4980-9E99-2D406B5EEFAC",
                anesthesia: anesthesias[9],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "1150mg",
                name: "Dipirona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "EB556493-1D7A-422A-9BDC-495C5D3179AF",
                anesthesia: anesthesias[9],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "3mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "ADCDEF2B-A319-4553-8FB9-EC2CCE597581",
                anesthesia: anesthesias[9],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "2mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "4E246F44-261F-4000-A27E-49A199B1DFF0",
                anesthesia: anesthesias[9],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "2mg",
                name: "Dexametasona",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "B53EE5EE-33B8-435E-B249-170C5D3F1045",
                anesthesia: anesthesias[9],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 8, minute: 20, second: 18)
            ),
            MedicationEntry(
                medicationId: "4CF4756F-D555-4DE5-90A6-41142C9368CE",
                anesthesia: anesthesias[9],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 13, month: 12, year: 2025, hour: 7, minute: 45, second: 18)
            ),
            MedicationEntry(
                medicationId: "8B4CC2FA-EE2B-45CC-B09D-87715A6ACF04",
                anesthesia: anesthesias[10],
                categoryRaw: "Anestésico Local",
                viaRaw: "PD",
                dose: "20ml",
                name: "Levobupivacaina",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "6118D6C8-210E-4047-A0A7-91B6758F2F2A",
                anesthesia: anesthesias[10],
                categoryRaw: "Opioide",
                viaRaw: "PD",
                dose: "100mcg",
                name: "Fentanil",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "FA95B460-6F21-496D-B623-734730CBAE54",
                anesthesia: anesthesias[10],
                categoryRaw: "Opioide",
                viaRaw: "PD",
                dose: "2mg",
                name: "Morfina",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "B54C987E-6F7E-41D1-8A96-1156E71F508E",
                anesthesia: anesthesias[10],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "9175D57C-87B1-4512-8F49-F7B928246830",
                anesthesia: anesthesias[10],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "3C0A98C4-AAA3-4B20-8922-400244F57001",
                anesthesia: anesthesias[10],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "100mg",
                name: "Rocurônio",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "0F26D6F3-0868-4F81-B6A9-F8BAFB4C15D4",
                anesthesia: anesthesias[10],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "6289E744-73E2-4D0A-8FB9-9E70DAA6A491",
                anesthesia: anesthesias[10],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "4115E6FD-5D18-4F49-B2E1-5F58508B3184",
                anesthesia: anesthesias[10],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "51BB1054-3A24-4094-AAA9-6F02B85D5F30",
                anesthesia: anesthesias[10],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "11A20C05-A038-4AAB-B2EC-0A7AF5F19C6D",
                anesthesia: anesthesias[10],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "07749C4A-D9B8-4148-AEC9-28A07441163D",
                anesthesia: anesthesias[10],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "5A58EA98-6AD1-411D-A97A-9A275CFCC77C",
                anesthesia: anesthesias[10],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "F77E4E02-DD19-4A6D-BE77-3F2A863ED013",
                anesthesia: anesthesias[10],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 19, second: 56)
            ),
            MedicationEntry(
                medicationId: "CC6D8634-5E69-47D2-822A-BBBBF19281CA",
                anesthesia: anesthesias[10],
                categoryRaw: "Alfa-2 Agonista",
                viaRaw: "PD",
                dose: "100mcg",
                name: "Clonidina",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "3042CCA8-4239-41C1-B480-F8F8A1FA2F5C",
                anesthesia: anesthesias[10],
                categoryRaw: "Não Padronizado",
                viaRaw: "EV",
                dose: "1g",
                name: "Ácido Tranexâmico",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 9, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "22A3FAB5-2E63-4599-A699-C47A021BF387",
                anesthesia: anesthesias[10],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Ceftriaxona",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 8, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "F4804892-DF03-4748-9E82-959596502F82",
                anesthesia: anesthesias[10],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "500mL",
                name: "Ringer Lactato",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "916CAAB8-5508-4702-B057-0F8A2ED10971",
                anesthesia: anesthesias[10],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 11, minute: 21, second: 56)
            ),
            MedicationEntry(
                medicationId: "CEC08BAD-9239-4765-998D-0670655D9151",
                anesthesia: anesthesias[10],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "6mg",
                name: "Morfina",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 15, minute: 0, second: 56)
            ),
            MedicationEntry(
                medicationId: "3492CFFA-3D7D-4314-A10A-100A7CA57B6B",
                anesthesia: anesthesias[10],
                categoryRaw: "Reversor",
                viaRaw: "EV",
                dose: "200mg",
                name: "Sugammadex",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 15, minute: 10, second: 56)
            ),
            MedicationEntry(
                medicationId: "AC907701-0C1A-47D1-B5AF-60B3F1B5D4B7",
                anesthesia: anesthesias[11],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 20, second: 59)
            ),
            MedicationEntry(
                medicationId: "BCF03249-12EF-4BC1-8059-12E5B2E68F41",
                anesthesia: anesthesias[11],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 20, second: 59)
            ),
            MedicationEntry(
                medicationId: "CE0FEF50-5309-48A3-8D2D-454C8B1F4557",
                anesthesia: anesthesias[11],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 20, second: 59)
            ),
            MedicationEntry(
                medicationId: "B57545C2-153D-404A-A639-75850722E0B9",
                anesthesia: anesthesias[11],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 12, month: 12, year: 2025, hour: 7, minute: 20, second: 59)
            ),
            MedicationEntry(
                medicationId: "F454C511-208B-4B0E-90F6-EF6C1472B5E1",
                anesthesia: anesthesias[12],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 28)
            ),
            MedicationEntry(
                medicationId: "037BE7A0-6A24-47C6-B86B-382CCD861EE0",
                anesthesia: anesthesias[12],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 28)
            ),
            MedicationEntry(
                medicationId: "19A515E1-5D2F-4613-ACB9-2728DA30D5B8",
                anesthesia: anesthesias[12],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 28)
            ),
            MedicationEntry(
                medicationId: "A8617298-EAEC-49C2-98D5-BA2A3D837CA6",
                anesthesia: anesthesias[12],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 50, second: 28)
            ),
            MedicationEntry(
                medicationId: "6F3A0E0F-F4F0-47DD-8276-96A2A06B4803",
                anesthesia: anesthesias[13],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "D9F43DD2-CDAE-4752-B8F6-9F51601788A0",
                anesthesia: anesthesias[13],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "CAC48F26-05B9-4690-BC67-1ADED2FAC99D",
                anesthesia: anesthesias[13],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "4046320A-CE25-418E-9552-49820C4E0F79",
                anesthesia: anesthesias[13],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "8BEF125D-8AFF-4244-AC95-6875F54EBF8F",
                anesthesia: anesthesias[13],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "73D24FB9-0E0F-4736-B4D6-6A4DADB83BCA",
                anesthesia: anesthesias[13],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "C772E561-6AEC-41D3-954A-A4B722CDA75E",
                anesthesia: anesthesias[13],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "A33199C6-74DF-4534-8B62-33C5E703815E",
                anesthesia: anesthesias[13],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "F076807C-9C07-42B2-BD20-890AED0165B5",
                anesthesia: anesthesias[13],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "07F30068-2C0D-44FC-A347-4A00B37D7CE4",
                anesthesia: anesthesias[13],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "ADEBD507-2A32-425C-86F5-71FE3F218866",
                anesthesia: anesthesias[13],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 31)
            ),
            MedicationEntry(
                medicationId: "21C35F61-71B8-4D46-B9BF-6E90D65C58D5",
                anesthesia: anesthesias[14],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 19)
            ),
            MedicationEntry(
                medicationId: "8C54F398-E951-477A-9086-0E5D98408949",
                anesthesia: anesthesias[14],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 19)
            ),
            MedicationEntry(
                medicationId: "0A7E51E9-C366-47E6-A279-629800A2C519",
                anesthesia: anesthesias[14],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 19)
            ),
            MedicationEntry(
                medicationId: "EECB3AE0-C276-42C5-B2D8-2FF81E7ED99E",
                anesthesia: anesthesias[14],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 11, month: 12, year: 2025, hour: 7, minute: 30, second: 19)
            ),
            MedicationEntry(
                medicationId: "B4C16DE8-2791-405E-87F4-0934F518CB78",
                anesthesia: anesthesias[15],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "5mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "85AC55D8-2C78-4A18-AF5F-159687FB8835",
                anesthesia: anesthesias[15],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "4mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "DF55516B-543E-4C13-9874-39F6C22ED243",
                anesthesia: anesthesias[15],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "4mg",
                name: "Dexametasona",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "754051B0-B087-4215-8402-C3F25117AE73",
                anesthesia: anesthesias[15],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "06FB01D2-63C5-4AD1-8A6C-4646F5822B49",
                anesthesia: anesthesias[15],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "105mcg",
                name: "Fentanil",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "BB691ACA-E91E-47BB-8560-992732487314",
                anesthesia: anesthesias[15],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "D5832F1D-CFEF-42D1-82D4-67CFB2CF0BEC",
                anesthesia: anesthesias[15],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 10, month: 12, year: 2025, hour: 8, minute: 20, second: 20)
            ),
            MedicationEntry(
                medicationId: "96785CFD-D22E-43FD-90BE-387E628812F2",
                anesthesia: anesthesias[16],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "5A7A615E-FC0F-4B16-931C-F75B1CB3E0D1",
                anesthesia: anesthesias[16],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "588691CA-B14C-4A1D-BF5D-DB9030A25D0E",
                anesthesia: anesthesias[16],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "454453FE-1E4F-41DE-A671-893F699E8FC1",
                anesthesia: anesthesias[16],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "DFC6A061-61C4-4949-83FB-05BCDD4126C6",
                anesthesia: anesthesias[16],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "1CD47537-B5F0-4F86-8529-A8DE4EFF8FD3",
                anesthesia: anesthesias[16],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "9022ED25-039C-41FF-B430-46EC6F729C2D",
                anesthesia: anesthesias[16],
                categoryRaw: "Anestésico Local",
                viaRaw: "PN",
                dose: "50mg",
                name: "Levobupivacaina",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "D19F4BF4-168A-442C-A0C5-D93BA4B52FB9",
                anesthesia: anesthesias[16],
                categoryRaw: "Anestésico Local",
                viaRaw: "PN",
                dose: "100mg",
                name: "Lidocaina",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "3AD56515-4EA4-4E1B-9E10-708E92F8CEC8",
                anesthesia: anesthesias[16],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "F8086245-9322-4F2B-9A70-E7E3E0546B3D",
                anesthesia: anesthesias[16],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "F6F9CA4D-50A4-452C-B380-5220F3E976AE",
                anesthesia: anesthesias[16],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 9, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "3F107DD7-8920-49F2-9E20-469E16A0C14E",
                anesthesia: anesthesias[17],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 8, month: 12, year: 2025, hour: 7, minute: 55, second: 56)
            ),
            MedicationEntry(
                medicationId: "773BB38E-2CC4-4B2E-9417-ADD4B46DCF30",
                anesthesia: anesthesias[17],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 8, month: 12, year: 2025, hour: 7, minute: 55, second: 56)
            ),
            MedicationEntry(
                medicationId: "F93B3FC5-D0C8-4762-AA1F-B30D40132773",
                anesthesia: anesthesias[17],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 8, month: 12, year: 2025, hour: 7, minute: 55, second: 56)
            ),
            MedicationEntry(
                medicationId: "4B8F65D6-F34C-42E6-9676-E84D4D203492",
                anesthesia: anesthesias[17],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 8, month: 12, year: 2025, hour: 7, minute: 55, second: 56)
            ),
            MedicationEntry(
                medicationId: "2A960C13-635D-4741-803D-D7904E7F6964",
                anesthesia: anesthesias[18],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "80mg",
                name: "Propofol",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "5A959163-571B-460B-A379-3CB73ABF4E72",
                anesthesia: anesthesias[18],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "38mcg",
                name: "Fentanil",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "A4F6096D-9515-49A1-A8F7-B0E6AE491237",
                anesthesia: anesthesias[18],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "375mg",
                name: "Cefazolina",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "392BE3F2-DE6A-425E-88A4-BFD89439C855",
                anesthesia: anesthesias[18],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "C2C42687-4590-416D-B3FC-913EF869AEFB",
                anesthesia: anesthesias[18],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "B332551F-C52C-4A0B-BE74-A695359D7C3D",
                anesthesia: anesthesias[18],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "69E87119-66A4-43E5-BEA3-B1CF2D6D7680",
                anesthesia: anesthesias[18],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 8, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "073FEC96-6E1D-4369-A12D-E0D26FF476E6",
                anesthesia: anesthesias[18],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "625mg",
                name: "Dipirona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "CD5F96CF-2564-4EFE-8115-8B91CF4AC911",
                anesthesia: anesthesias[18],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "2mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "2F3877F9-B1FF-424D-93DB-3BDCFFE8D66F",
                anesthesia: anesthesias[18],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "1mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "8247C3C6-1856-4520-8A22-20895FE6F81A",
                anesthesia: anesthesias[18],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "1mg",
                name: "Dexametasona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "AE55E6D5-C100-4C9A-A0E8-25C45A8487C2",
                anesthesia: anesthesias[18],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "95BE812A-B5D2-4C8F-95E8-9C73B3963380",
                anesthesia: anesthesias[18],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "13mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "A7D82C3A-E2A0-4C06-9195-7EF4CD918EB5",
                anesthesia: anesthesias[18],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "250mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 9, minute: 20, second: 34)
            ),
            MedicationEntry(
                medicationId: "541EE3BC-180E-4D29-B527-EB2F6B6BFA92",
                anesthesia: anesthesias[19],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "C53274CF-197B-4775-80CF-B767F9C7C3D9",
                anesthesia: anesthesias[19],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "D82EF955-1AE8-420B-8C06-83ED2B397605",
                anesthesia: anesthesias[19],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "A86170E5-547F-4359-B260-5A4E782976BB",
                anesthesia: anesthesias[19],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "15C0C4F4-6602-461A-B6CC-19C4351DA509",
                anesthesia: anesthesias[19],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 20, second: 54)
            ),
            MedicationEntry(
                medicationId: "E3D34DDB-27C3-49FB-AF46-B041449D7F46",
                anesthesia: anesthesias[19],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "7ADADB6A-4ECE-4947-A63B-1C8C0D8AC920",
                anesthesia: anesthesias[19],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "8AA1462D-B05C-4E54-BF67-914095637DAE",
                anesthesia: anesthesias[19],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "FC414E50-E75F-4C98-9E41-9C165A3DB7EE",
                anesthesia: anesthesias[19],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "ADD43FFA-CDBF-4822-8B02-3152DF2E003F",
                anesthesia: anesthesias[19],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "BDE3C3B0-DB68-4578-9CEC-27B553C53E77",
                anesthesia: anesthesias[19],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 5, month: 12, year: 2025, hour: 7, minute: 30, second: 54)
            ),
            MedicationEntry(
                medicationId: "164E2E96-50EB-48FF-93A1-82EA82DDAF34",
                anesthesia: anesthesias[20],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "13D6BFAD-69CD-4526-B814-1879F95EDEA2",
                anesthesia: anesthesias[20],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "31E3F662-3949-4470-9CDD-B9177A859C8E",
                anesthesia: anesthesias[20],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "AADB3B6E-A9C5-4DE1-8BCB-7D959325C6B4",
                anesthesia: anesthesias[20],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "250516E0-FA6F-416F-A965-DBBAC5121B99",
                anesthesia: anesthesias[20],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "0469009B-63D2-4421-80BF-9F6B3FD49310",
                anesthesia: anesthesias[20],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "B8906AF1-0E64-4C5E-9333-4243F28B0620",
                anesthesia: anesthesias[20],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "1B20F48C-0CDD-4E7D-98AD-FC81F48F5A97",
                anesthesia: anesthesias[20],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "7F88DB92-21B9-44E5-8FB8-C10D6525BD1C",
                anesthesia: anesthesias[20],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "39C9B0AF-472A-4595-8B09-E5814E7F2C35",
                anesthesia: anesthesias[20],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 10, minute: 30, second: 9)
            ),
            MedicationEntry(
                medicationId: "6059126E-7B2C-40EF-8413-68C8B0EAF400",
                anesthesia: anesthesias[21],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "450mg",
                name: "Dipirona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "3D8964E5-CF5E-4EFC-810A-A671B5F618E2",
                anesthesia: anesthesias[21],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "1mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "116B945A-0FEA-4902-8B50-A7A1AAC55867",
                anesthesia: anesthesias[21],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "1mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "4EDB2D34-0890-452F-9B91-CAB75B951E04",
                anesthesia: anesthesias[21],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "1mg",
                name: "Dexametasona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "22F44D5C-8920-4474-9F23-729060B75B54",
                anesthesia: anesthesias[21],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "409B4149-5E53-4BE7-9EF6-1EF6C3C765A9",
                anesthesia: anesthesias[21],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "9mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "1BB0E914-C625-41C2-A185-19FDF7E79EED",
                anesthesia: anesthesias[21],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "27mg",
                name: "Propofol",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "C2423147-9BAF-4207-8849-ECAE23391A83",
                anesthesia: anesthesias[21],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "27mcg",
                name: "Fentanil",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "6CC6658F-85B8-424D-9790-DF6CC13FE191",
                anesthesia: anesthesias[21],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "1A49605C-3C4A-436F-B928-CCFA91A68255",
                anesthesia: anesthesias[21],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 8, minute: 20, second: 53)
            ),
            MedicationEntry(
                medicationId: "7E3FD00F-6563-428B-B475-132285FE6CC0",
                anesthesia: anesthesias[22],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "EFC5A918-DA45-42B8-8FD6-61276224833C",
                anesthesia: anesthesias[22],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "D35DD581-252D-4C0A-9863-87BCA10087B1",
                anesthesia: anesthesias[22],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "63F31CF1-6431-4732-9653-AE770D55C74A",
                anesthesia: anesthesias[22],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "F87349AE-7E15-423F-93BF-C36CF0A61B76",
                anesthesia: anesthesias[22],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "3391F77B-1289-4392-8D26-A6389674B310",
                anesthesia: anesthesias[22],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "FBFBC334-180F-44D2-B620-6A0C56A9C189",
                anesthesia: anesthesias[22],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "71E19F7A-6BF9-4030-BD80-E6B3F9B6E3E4",
                anesthesia: anesthesias[22],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "A6557FFB-CF3E-4A85-A0EF-8E3B1398F3CD",
                anesthesia: anesthesias[22],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "1995E740-2A00-4697-B2EB-E43ABCDA4B46",
                anesthesia: anesthesias[22],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "7E7D69B0-A336-45EF-BB93-FC9AEFEF011C",
                anesthesia: anesthesias[22],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 3, month: 12, year: 2025, hour: 7, minute: 15, second: 21)
            ),
            MedicationEntry(
                medicationId: "AEAE8A77-F78B-4D8C-9A05-1AD003D95FF1",
                anesthesia: anesthesias[23],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "E2517A68-DABC-46DB-8FE3-0FC928DF28F4",
                anesthesia: anesthesias[23],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "9089CAF2-83CF-482C-8FC8-062F3F94DDCD",
                anesthesia: anesthesias[23],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "0D169168-771E-45D5-9051-AD63C8DF804C",
                anesthesia: anesthesias[23],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "04A3FBC2-5E99-46A1-A4B6-14634D19286D",
                anesthesia: anesthesias[23],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "2A7B7761-697C-41CF-94DB-AA07AEA3C842",
                anesthesia: anesthesias[23],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "C0ED3482-3B8B-4E4A-9A73-F292CC6F5B40",
                anesthesia: anesthesias[23],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "3D0816F1-25A7-4C5E-BB27-EF05324B29CD",
                anesthesia: anesthesias[23],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "4718F3CC-5F1D-464C-A075-F503585DA4CE",
                anesthesia: anesthesias[23],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "0AA334E1-6A7B-484D-AACE-A41A3EC88A1C",
                anesthesia: anesthesias[23],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 9, minute: 15, second: 13)
            ),
            MedicationEntry(
                medicationId: "BE9C72E1-7527-4F7C-8B68-8DD7AC8E4665",
                anesthesia: anesthesias[24],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "5B30F401-D53D-4735-80CD-73122D61BFEE",
                anesthesia: anesthesias[24],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "BB700D73-2BEF-4307-BCC4-659440CE43A7",
                anesthesia: anesthesias[24],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "C342F45B-C7E4-4C02-9C80-1E02E309A726",
                anesthesia: anesthesias[24],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "460D4530-27C7-44A0-BECB-8B74E03A3422",
                anesthesia: anesthesias[24],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "BCEF87E4-266D-4FC4-BF24-7C5A2CEF451C",
                anesthesia: anesthesias[24],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "E24829F9-036C-4B4C-AAB2-8CC083E8C83A",
                anesthesia: anesthesias[24],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "3EC54753-80B3-42AA-9CBE-BB0D25466262",
                anesthesia: anesthesias[24],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "3689A6D4-1698-40BB-AE4C-043923A34979",
                anesthesia: anesthesias[24],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "61A2B5BE-CBA2-4FEC-9CB7-143918A0028A",
                anesthesia: anesthesias[24],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 7, minute: 45, second: 49)
            ),
            MedicationEntry(
                medicationId: "3545D14B-9320-4199-8FDA-6F029F258C1E",
                anesthesia: anesthesias[25],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "90mg",
                name: "Propofol",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "E7DD5731-31F5-4F84-938D-2DD6A3151843",
                anesthesia: anesthesias[25],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "90mcg",
                name: "Fentanil",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "77B0664D-1CAB-488E-AF2D-8BA2E84830CC",
                anesthesia: anesthesias[25],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "23545706-4E92-4550-8A34-11F81C00D0ED",
                anesthesia: anesthesias[25],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "25422B60-0026-4A8F-B6EE-3992B65D419C",
                anesthesia: anesthesias[25],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "1500mg",
                name: "Dipirona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "3B90B1B3-187A-49C7-8D8D-18994B1FA44E",
                anesthesia: anesthesias[25],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "5mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "C2DCAF5E-0ECB-4257-B20C-8495D5EA49FA",
                anesthesia: anesthesias[25],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "3mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "0B5BC80F-FA8A-4026-87E1-831D83B24D2C",
                anesthesia: anesthesias[25],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "3mg",
                name: "Dexametasona",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "787252B7-39CF-4FC2-A659-1E38C8D09C7E",
                anesthesia: anesthesias[25],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "0017CF06-66F0-4EC0-BBA4-53E607F360E0",
                anesthesia: anesthesias[25],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "30mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 30, month: 11, year: 2025, hour: 6, minute: 30, second: 59)
            ),
            MedicationEntry(
                medicationId: "C50C8DEA-2F3F-44CD-B76C-E9C5CC6EFC19",
                anesthesia: anesthesias[26],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "105mg",
                name: "Propofol",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "DEA2A6F4-7622-4638-951B-A851FAA00482",
                anesthesia: anesthesias[26],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "105mcg",
                name: "Fentanil",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "8506B879-B8EB-42E4-9889-38E11C2FC628",
                anesthesia: anesthesias[26],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "828EBEDF-DFE6-4C53-9E14-C0DFC09378F7",
                anesthesia: anesthesias[26],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "CAC28AB4-968C-4D2F-8B86-9BC0793AF853",
                anesthesia: anesthesias[26],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "1750mg",
                name: "Dipirona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "491BDCA6-2003-441E-ADBE-2D83EE195A26",
                anesthesia: anesthesias[26],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "5mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "5E3BA074-71C1-4E3D-A290-2481310AEBFA",
                anesthesia: anesthesias[26],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "4mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "08FE5166-A25A-4469-B968-8B48FEE41737",
                anesthesia: anesthesias[26],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "4mg",
                name: "Dexametasona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "A8F700F6-07DE-4D73-83C6-F747539DD8AE",
                anesthesia: anesthesias[26],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "72BDA09C-AB79-4B19-A754-A7750E57F9BD",
                anesthesia: anesthesias[26],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "35mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 10, minute: 35, second: 41)
            ),
            MedicationEntry(
                medicationId: "BDB91F3A-D243-47A0-B7ED-AD15E1F6C684",
                anesthesia: anesthesias[27],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "75mg",
                name: "Propofol",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "76292ACF-0186-49AA-8222-2D2C2CB7D8B2",
                anesthesia: anesthesias[27],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "75mcg",
                name: "Fentanil",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "89116179-E099-409E-889E-C979CD8F3704",
                anesthesia: anesthesias[27],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "13mg",
                name: "Rocurônio",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "60F4490F-A494-413A-9121-CAC90034B33C",
                anesthesia: anesthesias[27],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "750mg",
                name: "Cefazolina",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "93277668-A02C-4815-8DB6-C9223212FE67",
                anesthesia: anesthesias[27],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "9561A86B-3DB6-45A0-800C-8FA1B5AD6969",
                anesthesia: anesthesias[27],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "35181CDC-1360-434E-9C13-6401D5FA73BA",
                anesthesia: anesthesias[27],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "DFB30647-F87C-4CAE-94BB-12C0A6A73452",
                anesthesia: anesthesias[27],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "26BA327C-16EC-4DAB-B4AB-F7F08CB7DB55",
                anesthesia: anesthesias[27],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "1250mg",
                name: "Dipirona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "BA233209-4298-4018-BCFD-D22129C50EDC",
                anesthesia: anesthesias[27],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "4mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "03E3A828-42BE-4458-9A8B-525D43D1205D",
                anesthesia: anesthesias[27],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "3mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "2E55BFC1-128E-4204-9B0B-A8E609F45DF3",
                anesthesia: anesthesias[27],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "3mg",
                name: "Dexametasona",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "00A31A30-63D8-42FD-A873-EE94C6890594",
                anesthesia: anesthesias[27],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "21EB333B-BD58-41F4-9E87-D65C883D4C73",
                anesthesia: anesthesias[27],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "25mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 45, second: 25)
            ),
            MedicationEntry(
                medicationId: "1F692040-55EE-4508-9810-B00FCA39BAA7",
                anesthesia: anesthesias[28],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 0, second: 4)
            ),
            MedicationEntry(
                medicationId: "F3522146-317A-4807-AA1C-FC2788323A6D",
                anesthesia: anesthesias[28],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 0, second: 4)
            ),
            MedicationEntry(
                medicationId: "F8A14CA3-1AEA-4B5E-AC2C-6A898A96301A",
                anesthesia: anesthesias[28],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 0, second: 4)
            ),
            MedicationEntry(
                medicationId: "4DCF3846-3B88-4C40-8060-F465AB0A7B4B",
                anesthesia: anesthesias[28],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 29, month: 11, year: 2025, hour: 8, minute: 0, second: 4)
            ),
            MedicationEntry(
                medicationId: "D32ADD4C-AABA-44A9-A2DA-8E7C4416CF5A",
                anesthesia: anesthesias[29],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 50)
            ),
            MedicationEntry(
                medicationId: "5E34F379-0E23-4D6B-959E-79C7C3F1BF64",
                anesthesia: anesthesias[29],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 50)
            ),
            MedicationEntry(
                medicationId: "5F921D4A-BB57-4CE9-B2BF-471878E89FB6",
                anesthesia: anesthesias[29],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 50)
            ),
            MedicationEntry(
                medicationId: "1D6B4000-D51A-4FA5-A256-A1889F5744E1",
                anesthesia: anesthesias[29],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 35, second: 50)
            ),
            MedicationEntry(
                medicationId: "D5FD6F69-396A-4EC4-BC0A-642B6519A296",
                anesthesia: anesthesias[30],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 15, second: 59)
            ),
            MedicationEntry(
                medicationId: "8D945840-45F7-4959-89CB-65FFB5BF4B54",
                anesthesia: anesthesias[30],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 15, second: 59)
            ),
            MedicationEntry(
                medicationId: "53D62967-5F71-4FA4-BC45-F3766C558643",
                anesthesia: anesthesias[30],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 15, second: 59)
            ),
            MedicationEntry(
                medicationId: "B36966B5-8F24-4B63-AE2B-7D06BB184DDE",
                anesthesia: anesthesias[30],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 25, month: 11, year: 2025, hour: 7, minute: 15, second: 59)
            ),
            MedicationEntry(
                medicationId: "B4E09768-0CD1-40D8-A22E-0E38B6A70618",
                anesthesia: anesthesias[31],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "5740E692-D6E2-4758-A2C6-B411C7744ED0",
                anesthesia: anesthesias[31],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "812ECA48-DF06-4D9D-BBC7-283042F016A2",
                anesthesia: anesthesias[31],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "1EC6E81C-2D2E-454E-9D4E-9B7F05E46BAE",
                anesthesia: anesthesias[31],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "ACFD05B2-3A1D-4555-9A1F-572B4CDA576E",
                anesthesia: anesthesias[31],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "3E547F62-DED1-499B-8640-702C57AC5387",
                anesthesia: anesthesias[31],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "5E406669-8033-418D-A521-B2BA280932FA",
                anesthesia: anesthesias[31],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "7C553FED-A456-4572-90B9-EBB0515A4C2F",
                anesthesia: anesthesias[31],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "CB0E4028-36DE-4F3E-9447-C4DF970655F6",
                anesthesia: anesthesias[31],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "7DD3B2BD-3D03-49B0-A47D-7D1DCA9B693F",
                anesthesia: anesthesias[31],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "CD710F25-0364-4DB8-B660-2FB61B589AC7",
                anesthesia: anesthesias[31],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "C459D6A9-4BEF-44A8-A5D2-C333669A8111",
                anesthesia: anesthesias[31],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "FF504AF9-83EF-4A51-8B9E-45267625CC50",
                anesthesia: anesthesias[31],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "41CA619B-61E3-4FE2-80F9-0FABC302A45A",
                anesthesia: anesthesias[31],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 15, minute: 30, second: 22)
            ),
            MedicationEntry(
                medicationId: "FE08BF7C-8996-4CFC-AED6-8624A143F617",
                anesthesia: anesthesias[32],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "82CB07A7-BC86-446E-BB6D-25051FB1BDDF",
                anesthesia: anesthesias[32],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "55B0B128-AF72-4AB6-8CB4-F2EF0CB41DA1",
                anesthesia: anesthesias[32],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "60566802-A165-4393-8FB7-8E31F051A715",
                anesthesia: anesthesias[32],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "957121BD-D2B7-41EB-BC80-761C1383D717",
                anesthesia: anesthesias[32],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "EF48B07B-0430-4D06-BAC9-674023FA1780",
                anesthesia: anesthesias[32],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "AA6B3735-8928-4D09-A1CD-EC4F835829B0",
                anesthesia: anesthesias[32],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "58317428-4E1B-41BB-8C32-6465FC1148FC",
                anesthesia: anesthesias[32],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "237C6AB5-203C-49E5-953D-1BDEB2748C7D",
                anesthesia: anesthesias[32],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "802E8582-4A75-4BF1-95C0-708BF505E15D",
                anesthesia: anesthesias[32],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "22F80A4C-CD5B-4AB9-964B-D4E1169C34C6",
                anesthesia: anesthesias[32],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "1BACD096-C675-42F5-9E32-EA694C11D44B",
                anesthesia: anesthesias[32],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "130092E6-4FBD-424A-97BD-4A9211221E7B",
                anesthesia: anesthesias[32],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "3D937D6A-E59C-4391-B929-C68DBFDEBEA4",
                anesthesia: anesthesias[32],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 13, minute: 45, second: 35)
            ),
            MedicationEntry(
                medicationId: "7F9307A8-E4AD-454E-8D7A-899BDBF411FC",
                anesthesia: anesthesias[33],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "C3B0423F-3FDB-4DC5-A308-4E3C304B2DAE",
                anesthesia: anesthesias[33],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "844A9267-7D9C-4BCF-AEF6-EA199A018CDA",
                anesthesia: anesthesias[33],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "E1C61866-6155-4246-B27F-67F9E81836DD",
                anesthesia: anesthesias[33],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "386B3CF1-6556-462A-A584-7E59E09F61E6",
                anesthesia: anesthesias[33],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "11C9B421-B67D-49D5-B69B-077A637304C5",
                anesthesia: anesthesias[33],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "E58140BA-181D-4C25-9835-0CF16CB92AB0",
                anesthesia: anesthesias[33],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "5CEB1A21-A9A0-401B-9CBD-BF34E7A07A05",
                anesthesia: anesthesias[33],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "0718B91F-3394-402B-B7C7-36842D175105",
                anesthesia: anesthesias[33],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "602849CB-89BD-4EA6-9C7B-77F95C3976E3",
                anesthesia: anesthesias[33],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "7B6C8E86-7CB9-4C40-BC6D-904F33FC16B2",
                anesthesia: anesthesias[33],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "47F303B6-330F-4B75-BD4A-428090F7385E",
                anesthesia: anesthesias[33],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "7D55A71D-ED72-454C-8211-BA7C13F61649",
                anesthesia: anesthesias[33],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "DF7059E5-0A30-42F1-AB55-AA4D17C8A1F3",
                anesthesia: anesthesias[33],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 11, minute: 0, second: 2)
            ),
            MedicationEntry(
                medicationId: "7DA925E1-8B69-4B7A-A502-1FB31EC9D812",
                anesthesia: anesthesias[34],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "200mg",
                name: "Propofol",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "09EB25F7-B2D1-421D-93C6-B7AE9A1402D2",
                anesthesia: anesthesias[34],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "250mcg",
                name: "Fentanil",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "77E00230-E7F0-444F-A7C5-280339E48AC9",
                anesthesia: anesthesias[34],
                categoryRaw: "Bloqueador Neuromuscular",
                viaRaw: "EV",
                dose: "50mg",
                name: "Rocurônio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "97C9C7C6-08A2-41E1-84C6-DCAD0471F6DA",
                anesthesia: anesthesias[34],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "A2A897D6-1483-4D63-8515-1DBBF624B0AD",
                anesthesia: anesthesias[34],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "2B391A9B-14DC-41D7-BE41-44509A595D5D",
                anesthesia: anesthesias[34],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "DAE221ED-8D4F-42AD-83AE-0140159A0385",
                anesthesia: anesthesias[34],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "1L/min",
                name: "Ar Comprimido",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "FCD0B8B4-BF6C-428A-B419-A40E97B0792F",
                anesthesia: anesthesias[34],
                categoryRaw: "Anestésico Inalatório",
                viaRaw: "VR",
                dose: "10mL",
                name: "Sevoflurano",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "3CB9EFAF-A71F-47E4-A82F-F95C3EB8643E",
                anesthesia: anesthesias[34],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "FB30DD7E-EABE-4D5A-8FD5-964107447C9D",
                anesthesia: anesthesias[34],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "80C1FD0C-3462-4274-9E4E-621D9FC65D31",
                anesthesia: anesthesias[34],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "4623F3E5-AB51-40D2-8FAC-40FF64B0E211",
                anesthesia: anesthesias[34],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "6723F0A9-52D4-4131-9A75-3C2BEBCAAD88",
                anesthesia: anesthesias[34],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "C2E49E06-B5A3-4FB2-8B70-65B8B6805092",
                anesthesia: anesthesias[34],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 24, month: 11, year: 2025, hour: 7, minute: 30, second: 42)
            ),
            MedicationEntry(
                medicationId: "5AEB0170-AE97-45E7-A2CE-7C70822FC652",
                anesthesia: anesthesias[35],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "E589B994-A705-4B60-9622-9488BB05A205",
                anesthesia: anesthesias[35],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "F99F43FC-8A3E-4D38-8D35-3E4DB917D295",
                anesthesia: anesthesias[35],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "EEE2C7D1-FBB5-4BF7-9BEF-8220BD98583E",
                anesthesia: anesthesias[35],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "CBB38F77-0ADC-4392-A24E-3496CC52E161",
                anesthesia: anesthesias[35],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "A032C1D7-2DD1-4CD8-984D-4CE1F6B1F9B0",
                anesthesia: anesthesias[35],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "0671976B-9DAD-4864-96DD-D64B94BABFDE",
                anesthesia: anesthesias[35],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "1E731778-6618-4450-A2AB-7FC4682426C0",
                anesthesia: anesthesias[35],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "05F89ED6-F5EA-4D5C-A5AC-FEDD1474987B",
                anesthesia: anesthesias[35],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "0DAD2228-DA6E-4E1D-86F9-A34A162FBA1D",
                anesthesia: anesthesias[35],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 30, second: 52)
            ),
            MedicationEntry(
                medicationId: "04B9EC8E-C191-4611-AD46-043B9E373F70",
                anesthesia: anesthesias[36],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 20, second: 25)
            ),
            MedicationEntry(
                medicationId: "14219E2D-5703-4F75-8DFD-662A7120F192",
                anesthesia: anesthesias[36],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 20, second: 25)
            ),
            MedicationEntry(
                medicationId: "B119CF7E-F5EB-4D6B-9D8B-ABAC4E67F021",
                anesthesia: anesthesias[36],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 20, second: 25)
            ),
            MedicationEntry(
                medicationId: "377E86BF-F092-4A69-B2BA-FDF63F7BA4BD",
                anesthesia: anesthesias[36],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 21, month: 11, year: 2025, hour: 7, minute: 20, second: 25)
            ),
            MedicationEntry(
                medicationId: "3A728D8C-1CC3-4507-9509-DB7B663AB2ED",
                anesthesia: anesthesias[37],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 20, second: 27)
            ),
            MedicationEntry(
                medicationId: "A4DBE662-9756-4392-BCF8-92C431198BB8",
                anesthesia: anesthesias[37],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 20, second: 27)
            ),
            MedicationEntry(
                medicationId: "CD2A7CDA-C5B5-4855-99EA-E85B358AA761",
                anesthesia: anesthesias[37],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 20, second: 27)
            ),
            MedicationEntry(
                medicationId: "A91D02AA-38CC-4BF7-86ED-55EDC1394ED8",
                anesthesia: anesthesias[37],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 19, month: 11, year: 2025, hour: 7, minute: 20, second: 27)
            ),
            MedicationEntry(
                medicationId: "11F07ABC-5241-4CE0-9629-F26111B12FB9",
                anesthesia: anesthesias[38],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "30mg",
                name: "Propofol",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "00338598-E0F2-43F5-B5F4-7D11A85EA0D3",
                anesthesia: anesthesias[38],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "30mcg",
                name: "Fentanil",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "93F0B1EC-BE45-4138-8FAF-5037C623C19B",
                anesthesia: anesthesias[38],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "39B0BE0F-3CE0-4A8D-8705-DBFB32CE31C7",
                anesthesia: anesthesias[38],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "5AC2A06D-0860-40F9-887E-F0EB7F9BBDBE",
                anesthesia: anesthesias[38],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "500mg",
                name: "Dipirona",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "FF6FC120-1C8F-4DDC-823D-5FA0AFC064E6",
                anesthesia: anesthesias[38],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "2mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "B7FCB4B7-5E84-4F69-AC88-E53BDEA2525D",
                anesthesia: anesthesias[38],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "1mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "142E5782-5850-4883-B74C-2F91C0D6CBB3",
                anesthesia: anesthesias[38],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "1mg",
                name: "Dexametasona",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "9F08368C-AB4E-4B31-9A52-E39464FE054A",
                anesthesia: anesthesias[38],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "1C3A388B-F7CA-4002-BE13-948F4330DBA6",
                anesthesia: anesthesias[38],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "10mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 3, month: 11, year: 2025, hour: 8, minute: 40, second: 58)
            ),
            MedicationEntry(
                medicationId: "A187FEF0-2717-4FAC-B586-15CBBEF518D2",
                anesthesia: anesthesias[39],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "E8091FD6-C538-4B45-A8FC-CCC2260C8CA3",
                anesthesia: anesthesias[39],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "ABB2A7DE-0B7D-4BC1-B14A-A56A5629750A",
                anesthesia: anesthesias[39],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "BE35CE44-DB46-48D8-B274-C1E1554CDDAE",
                anesthesia: anesthesias[39],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "39713F36-F0F6-4DC3-9683-92D243CF4964",
                anesthesia: anesthesias[39],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "0D1F93A5-3A28-4BC7-9B61-D8ED60063EE4",
                anesthesia: anesthesias[39],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "0A905E03-E590-4FEB-82F4-86508995B79F",
                anesthesia: anesthesias[39],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "32F9DE78-61C8-45B6-9E94-D06FBCDAB008",
                anesthesia: anesthesias[39],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "79BAF4B5-EA05-44F6-8494-36B2E8195F7F",
                anesthesia: anesthesias[39],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "0C7EE69B-CBD8-4378-A1F0-8C8E758241D1",
                anesthesia: anesthesias[39],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 8, minute: 30, second: 26)
            ),
            MedicationEntry(
                medicationId: "3B4052D7-3DDC-4C2A-9230-17EC3AD0EF8D",
                anesthesia: anesthesias[40],
                categoryRaw: "Anestésico Local",
                viaRaw: "IT",
                dose: "15mg",
                name: "Bupivacaina Pesada",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "F83B5D8F-3700-499F-8781-81BAC13CA0B9",
                anesthesia: anesthesias[40],
                categoryRaw: "Opioide",
                viaRaw: "IT",
                dose: "80mcg",
                name: "Morfina",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "A19EFBA4-F9C9-49C7-A98C-90CCE2E4BDF5",
                anesthesia: anesthesias[40],
                categoryRaw: "Antibiótico",
                viaRaw: "EV",
                dose: "2g",
                name: "Cefazolina",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "AD707A11-D368-4107-AAE6-865E4F247962",
                anesthesia: anesthesias[40],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "7CF13379-7B26-4EC4-B2B6-B32FE9B5148F",
                anesthesia: anesthesias[40],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "B18070AE-5672-4994-B6A0-724782DE0228",
                anesthesia: anesthesias[40],
                categoryRaw: "Analgésico",
                viaRaw: "EV",
                dose: "2g",
                name: "Dipirona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "154027C0-1460-48AF-9B42-13CF3378D60C",
                anesthesia: anesthesias[40],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "10mg",
                name: "Metoclopramida",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "1FA33BC6-2F55-4FBD-A346-83F2C4AE58BE",
                anesthesia: anesthesias[40],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "8mg",
                name: "Ondansetrona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "1499F5C2-D10E-4778-8ED3-36C340323248",
                anesthesia: anesthesias[40],
                categoryRaw: "Corticoide",
                viaRaw: "EV",
                dose: "10mg",
                name: "Dexametasona",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "C69312D0-D32B-4623-9345-FAB3BE1F9616",
                anesthesia: anesthesias[40],
                categoryRaw: "Antiemético",
                viaRaw: "EV",
                dose: "30mg",
                name: "Dimenidrinato",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "536807A2-A35D-4AAF-88E6-FB71A7B14C39",
                anesthesia: anesthesias[40],
                categoryRaw: "AINE",
                viaRaw: "EV",
                dose: "100mg",
                name: "Cetoprofeno",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "37ED2C8E-21D9-431C-BF2C-715F348482B7",
                anesthesia: anesthesias[40],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "FC54822A-E3E1-44B8-98F2-F6103EAC8E65",
                anesthesia: anesthesias[40],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "CAA9CF61-6C19-4CCB-9F8B-AFA537B62E92",
                anesthesia: anesthesias[40],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "F6DD8739-00C6-413C-94C9-3CDAB7C1824B",
                anesthesia: anesthesias[40],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 1, month: 11, year: 2025, hour: 7, minute: 20, second: 49)
            ),
            MedicationEntry(
                medicationId: "8B89BC09-EBC0-4ECD-A465-98D40294CB71",
                anesthesia: anesthesias[41],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 3, second: 7)
            ),
            MedicationEntry(
                medicationId: "208E267D-D692-4594-A06B-2FC016DFC34A",
                anesthesia: anesthesias[41],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 3, second: 7)
            ),
            MedicationEntry(
                medicationId: "B9AFA65D-75FA-4803-8BD0-2CC89DC07930",
                anesthesia: anesthesias[41],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 3, second: 7)
            ),
            MedicationEntry(
                medicationId: "AFEFAB58-26FF-41C5-AD32-832B55719B41",
                anesthesia: anesthesias[41],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 11, minute: 3, second: 7)
            ),
            MedicationEntry(
                medicationId: "F1780304-64F3-417D-B958-41A5B826DAF5",
                anesthesia: anesthesias[42],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 20, second: 33)
            ),
            MedicationEntry(
                medicationId: "A5A3DADA-F972-4432-B6BB-A2258F9182AB",
                anesthesia: anesthesias[42],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 20, second: 33)
            ),
            MedicationEntry(
                medicationId: "F2722336-E92D-4D61-A7EB-FCD288D7ACDA",
                anesthesia: anesthesias[42],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 20, second: 33)
            ),
            MedicationEntry(
                medicationId: "4069D866-7BB4-4174-8443-A7F591863C3B",
                anesthesia: anesthesias[42],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 23, month: 9, year: 2025, hour: 8, minute: 20, second: 33)
            ),
            MedicationEntry(
                medicationId: "5B8D40D6-BF7D-462C-A016-5069076BB578",
                anesthesia: anesthesias[43],
                categoryRaw: "Hipnótico",
                viaRaw: "EV",
                dose: "70mg",
                name: "Propofol",
                timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 10, second: 13)
            ),
            MedicationEntry(
                medicationId: "C08994E4-BA81-4B14-A947-0AA9D18C534A",
                anesthesia: anesthesias[43],
                categoryRaw: "Opioide",
                viaRaw: "EV",
                dose: "50mcg",
                name: "Fentanil",
                timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 10, second: 13)
            ),
            MedicationEntry(
                medicationId: "ECF5A0DA-3DB6-4AF4-B592-87C8ED7BECA4",
                anesthesia: anesthesias[43],
                categoryRaw: "Cristalóide",
                viaRaw: "EV",
                dose: "100mL",
                name: "Cloreto de Sódio 0,9%",
                timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 10, second: 13)
            ),
            MedicationEntry(
                medicationId: "1C5176C9-8DA0-4FD1-8159-D5CA6996FD0F",
                anesthesia: anesthesias[43],
                categoryRaw: "Gases Frescos",
                viaRaw: "VR",
                dose: "3L/min",
                name: "Oxigênio",
                timestamp: createDate(day: 22, month: 9, year: 2025, hour: 7, minute: 10, second: 13)
            ),
        ]
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
