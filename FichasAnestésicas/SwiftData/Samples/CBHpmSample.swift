 

 
import Foundation

extension CbhpmProcedure {
    static func samples(surgeries: [Surgery]) -> [CbhpmProcedure] {
        return [
            CbhpmProcedure(
                surgery: surgeries[0],
                code: "3.09.12.18-0",
                procedure: "Recanalização arterial no IAM – angioplastia primária – com implante",
                port: "6"
            ),
            CbhpmProcedure(
                surgery: surgeries[1],
                code: "3.10.05.49-7",
                procedure: "Colecistectomia sem colangiografia por videolaparoscopia",
                port: "5"
            ),
            CbhpmProcedure(
                surgery: surgeries[2],
                code: "3.10.04.20-2",
                procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                port: "3"
            ),
            CbhpmProcedure(
                surgery: surgeries[3],
                code: "4.02.02.61-5",
                procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                port: "3"
            ),
            CbhpmProcedure(
                surgery: surgeries[4],
                code: "3.12.06.19-0",
                procedure: "Plástica – retalho cutâneo à distância",
                port: "5"
            ),
            CbhpmProcedure(
                surgery: surgeries[4],
                code: "3.12.06.15-8",
                procedure: "Neofaloplastia – por estágio",
                port: "4"
            ),
             CbhpmProcedure(
                 surgery: surgeries[4],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[4],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[5],
                 code: "3.10.04.06-7",
                 procedure: "Dilatação digital ou instrumental do ânus e/ou do reto",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[5],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[6],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[6],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[7],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[8],
                 code: "3.11.01.43-7",
                 procedure: "Transuretero anastomose",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[9],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[9],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[9],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[10],
                 code: "3.11.04.21-5",
                 procedure: "Uretrostomia",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[10],
                 code: "3.13.01.05-3",
                 procedure: "Clitoroplastia",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[10],
                 code: "3.12.03.07-8",
                 procedure: "Orquiectomia unilateral",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[10],
                 code: "3.12.06.02-6",
                 procedure: "Amputação total",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[10],
                 code: "3.13.02.12-2",
                 procedure: "Neovagina (cólon, delgado, tubo de pele)",
                 port: "6"
             ),
             CbhpmProcedure(
                 surgery: surgeries[11],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[11],
                 code: "3.16.02.23-1",
                 procedure: "Anestesia para endoscopia diagnóstica",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[12],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[13],
                 code: "3.10.04.16-4",
                 procedure: "Fistulectomia perineal",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[14],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[15],
                 code: "3.11.02.34-4",
                 procedure: "Ureteroplastia unilateral",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[15],
                 code: "4.02.01.06-6",
                 procedure: "Cistoscopia e/ou uretroscopia",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[15],
                 code: "4.02.01.28-7",
                 procedure: "Ureteroscopia rígida unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[15],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[16],
                 code: "3.07.22.52-7",
                 procedure: "Osteossíntese de fratura de falange e metacarpeana com fixação",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[16],
                 code: "3.07.22.50-0",
                 procedure: "Luxação metacarpofalangeana – tratamento cirúrgico",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[17],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[18],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[18],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[19],
                 code: "3.10.04.14-8",
                 procedure: "Fistulectomia anal em um tempo",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[20],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[20],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[20],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[20],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[21],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.10.09.16-6",
                 procedure: "Herniorrafia umbilical",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.14.03.02-6",
                 procedure: "Bloqueio de nervo periférico",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.06.19-0",
                 procedure: "Plástica – retalho cutâneo à distância",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[22],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[23],
                 code: "3.12.06.19-0",
                 procedure: "Plástica – retalho cutâneo à distância",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[23],
                 code: "3.12.06.04-2",
                 procedure: "Doença de Peyronie – tratamento cirúrgico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[23],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[23],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[23],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.14.03.02-6",
                 procedure: "Bloqueio de nervo periférico",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[24],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[25],
                 code: "3.12.06.04-2",
                 procedure: "Doença de Peyronie – tratamento cirúrgico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[25],
                 code: "3.01.01.62-0",
                 procedure: "Incisão e drenagem de abscesso, hematoma ou panarício",
                 port: "0"
             ),
             CbhpmProcedure(
                 surgery: surgeries[26],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.06.19-0",
                 procedure: "Plástica – retalho cutâneo à distância",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.14.03.02-6",
                 procedure: "Bloqueio de nervo periférico",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.10.09.16-6",
                 procedure: "Herniorrafia umbilical",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[27],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[28],
                 code: "3.11.04.13-4",
                 procedure: "Meatoplastia (retalho cutâneo)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[29],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[29],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[30],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[31],
                 code: "3.10.02.39-0",
                 procedure: "Gastroplastia para obesidade mórbida por videolaparoscopia",
                 port: "7"
             ),
             CbhpmProcedure(
                 surgery: surgeries[32],
                 code: "3.10.02.39-0",
                 procedure: "Gastroplastia para obesidade mórbida por videolaparoscopia",
                 port: "7"
             ),
             CbhpmProcedure(
                 surgery: surgeries[33],
                 code: "3.10.05.49-7",
                 procedure: "Colecistectomia sem colangiografia por videolaparoscopia",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[34],
                 code: "3.10.05.49-7",
                 procedure: "Colecistectomia sem colangiografia por videolaparoscopia",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[35],
                 code: "3.03.07.07-4",
                 procedure: "Retirada de corpo estranho",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[36],
                 code: "3.10.04.16-4",
                 procedure: "Fistulectomia perineal",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[37],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[37],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[38],
                 code: "3.12.03.06-0",
                 procedure: "Orquidopexia unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[38],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[38],
                 code: "3.10.09.16-6",
                 procedure: "Herniorrafia umbilical",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[39],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[40],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[41],
                 code: "3.13.02.09-2",
                 procedure: "Extração de corpo estranho com anestesia geral ou bloqueio",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[42],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[43],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[44],
                 code: "3.10.04.12-1",
                 procedure: "Fistulectomia anal em dois tempos",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[45],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[46],
                 code: "3.11.03.23-5",
                 procedure: "Corpo estranho – extração endoscópica, inclui retirada de duplo J",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[47],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[47],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[48],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[48],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[48],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[48],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[49],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[50],
                 code: "3.11.03.17-0",
                 procedure: "Cistostomia cirúrgica",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[51],
                 code: "3.10.05.49-7",
                 procedure: "Colecistectomia sem colangiografia por videolaparoscopia",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[52],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[53],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[54],
                 code: "3.12.06.12-3",
                 procedure: "Hipospadia proximal – tratamento em 1 tempo",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[55],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[57],
                 code: "3.03.01.03-3",
                 procedure: "Blefarorrafia",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[57],
                 code: "3.03.01.03-3",
                 procedure: "Blefarorrafia",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[57],
                 code: "3.03.01.10-6",
                 procedure: "Dermatocalaze ou blefarocalaze – unilateral",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[57],
                 code: "3.03.01.10-6",
                 procedure: "Dermatocalaze ou blefarocalaze – unilateral",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[58],
                 code: "3.03.03.08-7",
                 procedure: "Sutura de conjuntiva",
                 port: "0"
             ),
             CbhpmProcedure(
                 surgery: surgeries[58],
                 code: "3.03.11.04-7",
                 procedure: "Estrabismo horizontal – monocular",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[58],
                 code: "3.03.03.08-7",
                 procedure: "Sutura de conjuntiva",
                 port: "0"
             ),
             CbhpmProcedure(
                 surgery: surgeries[58],
                 code: "3.03.11.04-7",
                 procedure: "Estrabismo horizontal – monocular",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[59],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[60],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[61],
                 code: "3.12.03.06-0",
                 procedure: "Orquidopexia unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[61],
                 code: "3.12.03.06-0",
                 procedure: "Orquidopexia unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[62],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[63],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[64],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[65],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[66],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[67],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[68],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[69],
                 code: "3.12.03.04-3",
                 procedure: "Hidrocele unilateral – correção cirúrgica",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[70],
                 code: "4.02.02.61-5",
                 procedure: "Endoscopia digestiva alta com biópsia e teste de urease (pesquisa Helicobacter pylori)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[71],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[72],
                 code: "3.03.07.07-4",
                 procedure: "Retirada de corpo estranho",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[73],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[73],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[73],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[73],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[74],
                 code: "3.10.03.31-1",
                 procedure: "Enteropexia – qualquer segmento",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[74],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[74],
                 code: "3.10.04.06-7",
                 procedure: "Dilatação digital ou instrumental do ânus e/ou do reto",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[75],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[76],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[77],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[78],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[79],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[80],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.14.03.02-6",
                 procedure: "Bloqueio de nervo periférico",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.19-0",
                 procedure: "Plástica – retalho cutâneo à distância",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[81],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[82],
                 code: "3.13.09.05-4",
                 procedure: "Cesariana",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[83],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[84],
                 code: "3.13.09.05-4",
                 procedure: "Cesariana",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[85],
                 code: "3.12.06.13-1",
                 procedure: "Implante de prótese peniana inflável",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[86],
                 code: "3.11.02.52-2",
                 procedure: "Ureteroplastia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[86],
                 code: "3.11.01.52-6",
                 procedure: "Pieloplastia laparoscópica unilateral",
                 port: "6"
             ),
             CbhpmProcedure(
                 surgery: surgeries[86],
                 code: "3.11.02.07-7",
                 procedure: "Colocação ureteroscópica de duplo J unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[86],
                 code: "3.11.01.30-5",
                 procedure: "Nefrostomia a céu aberto unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[87],
                 code: "4.09.02.06-4",
                 procedure: "Doppler colorido intra-operatório",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[87],
                 code: "3.09.13.01-2",
                 procedure: "Implante de cateter venoso central por punção, para NPP, QT,",
                 port: "0"
             ),
             CbhpmProcedure(
                 surgery: surgeries[88],
                 code: "3.10.09.25-5",
                 procedure: "Reconstrução da parede abdominal com retalho muscular ou",
                 port: "6"
             ),
             CbhpmProcedure(
                 surgery: surgeries[88],
                 code: "3.10.03.28-1",
                 procedure: "Enterectomia segmentar",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[88],
                 code: "3.11.03.46-4",
                 procedure: "Vesicostomia cutânea",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[89],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[90],
                 code: "3.13.09.05-4",
                 procedure: "Cesariana",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[91],
                 code: "3.13.09.05-4",
                 procedure: "Cesariana",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[91],
                 code: "3.13.09.05-4",
                 procedure: "Cesariana",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[92],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[93],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[94],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.10.09.33-6",
                 procedure: "Herniorrafia inguinal – unilateral por videolaparoscopia",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.10.09.33-6",
                 procedure: "Herniorrafia inguinal – unilateral por videolaparoscopia",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.12.03.13-2",
                 procedure: "Orquidopexia laparoscópica unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[95],
                 code: "3.14.03.02-6",
                 procedure: "Bloqueio de nervo periférico",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[96],
                 code: "3.10.09.16-6",
                 procedure: "Herniorrafia umbilical",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[96],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[96],
                 code: "3.03.07.07-4",
                 procedure: "Retirada de corpo estranho",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[97],
                 code: "4.02.01.08-2",
                 procedure: "Colonoscopia (inclui a Retossigmoidoscopia)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[98],
                 code: "3.12.06.14-0",
                 procedure: "Implante de prótese semi-rígida (exclui próteses infláveis)",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[98],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[98],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[98],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[98],
                 code: "3.12.02.06-3",
                 procedure: "Reconstrução da bolsa escrotal com retalho inguinal",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[99],
                 code: "3.10.04.20-2",
                 procedure: "Hemorroidectomia aberta ou fechada, com ou sem esfincterotomia, sem grampeador",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[100],
                 code: "3.07.27.13-8",
                 procedure: "Fraturas de tíbia associada ou não a fíbula (inclui descolamento",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[101],
                 code: "3.01.01.78-6",
                 procedure: "Sutura de extensos ferimentos com ou sem desbridamento",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[101],
                 code: "3.03.01.17-3",
                 procedure: "Pálpebra – reconstrução total (com ou sem ressecção de tumor) –",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[102],
                 code: "3.11.02.18-2",
                 procedure: "Reimplante ureteral por via extra ou intravesical unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.03.06-0",
                 procedure: "Orquidopexia unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.10.09.11-5",
                 procedure: "Herniorrafia inguinal – unilateral",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.10.09.11-5",
                 procedure: "Herniorrafia inguinal – unilateral",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[104],
                 code: "3.12.03.06-0",
                 procedure: "Orquidopexia unilateral",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[105],
                 code: "3.07.33.03-0",
                 procedure: "Condroplastia (com remoção de corpos livres)",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[105],
                 code: "3.07.33.07-3",
                 procedure: "Reconstrução, retencionamento ou reforço do ligamento cruzado",
                 port: "6"
             ),
             CbhpmProcedure(
                 surgery: surgeries[106],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[107],
                 code: "3.16.02.34-7",
                 procedure: "Anestesia realizada pelo anestesiologista em atos médicos que não tenham seus portes especialmente previstos ou para situações de imperativo clínico",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.01.01.32-8",
                 procedure: "Enxerto de mucosa",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.12.06.19-0",
                 procedure: "Plástica – retalho cutâneo à distância",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.11.04.13-4",
                 procedure: "Meatoplastia (retalho cutâneo)",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.12.06.15-8",
                 procedure: "Neofaloplastia – por estágio",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[108],
                 code: "3.11.04.19-3",
                 procedure: "Uretroplastia anterior",
                 port: "3"
             ),
             CbhpmProcedure(
                 surgery: surgeries[109],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[109],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[109],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[109],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[110],
                 code: "3.11.02.18-2",
                 procedure: "Reimplante ureteral por via extra ou intravesical unilateral",
                 port: "5"
             ),
             CbhpmProcedure(
                 surgery: surgeries[110],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[111],
                 code: "3.12.06.21-2",
                 procedure: "Plástica do freio bálano-prepucial",
                 port: "1"
             ),
             CbhpmProcedure(
                 surgery: surgeries[111],
                 code: "3.12.06.22-0",
                 procedure: "Postectomia",
                 port: "2"
             ),
             CbhpmProcedure(
                 surgery: surgeries[111],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
             ),
             CbhpmProcedure(
                 surgery: surgeries[111],
                 code: "3.12.06.20-4",
                 procedure: "Plástica de corpo cavernoso",
                 port: "4"
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

extension Financial {
    static func samples(surgeries: [Surgery]) -> [Financial] {
        return [
            Financial(
                surgery: surgeries[1],
                valueAnesthesia: 1200.0,
                finalSurgeryValue: 1200.0,
                paid: true,
                paymentDate: createDate(day: 22, month: 12, year: 2025)
            ),
            Financial(
                surgery: surgeries[2],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[4],
                valueAnesthesia: 3240.04,
                finalSurgeryValue: 3240.04,
                paid: false
            ),
            Financial(
                surgery: surgeries[8],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2173.75,
                paid: true,
                paymentDate: createDate(day: 15, month: 12, year: 2025),
                taxedValue: 326.25,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[10],
                valueAnesthesia: 12000.0,
                finalSurgeryValue: 10434.0,
                paid: true,
                paymentDate: createDate(day: 12, month: 12, year: 2025),
                taxedValue: 1566.0,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[18],
                valueAnesthesia: 3000.0,
                finalSurgeryValue: 3000.0,
                glosaAnesthesia: false,
                glosaPreanesthesia: false,
                notes: "Isso é apenas um teste.",
                paid: false,
                billingDate: createDate(day: 7, month: 12, year: 2025)
            ),
            Financial(
                surgery: surgeries[19],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                glosaAnesthesia: false,
                paid: false,
                paymentDate: createDate(day: 6, month: 12, year: 2025)
            ),
            Financial(
                surgery: surgeries[20],
                finalSurgeryValue: 0.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[21],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[23],
                valueAnesthesia: 1652.45,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 1752.45,
                paid: false
            ),
            Financial(
                surgery: surgeries[25],
                valueAnesthesia: 713.7,
                valuePreAnesthesia: 122.0,
                finalSurgeryValue: 835.7,
                paid: false
            ),
            Financial(
                surgery: surgeries[28],
                valueAnesthesia: 1652.45,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 1752.45,
                paid: false
            ),
            Financial(
                surgery: surgeries[29],
                valueAnesthesia: 242.69,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 342.69,
                paid: false
            ),
            Financial(
                surgery: surgeries[30],
                valueAnesthesia: 242.69,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 342.69,
                paid: false
            ),
            Financial(
                surgery: surgeries[31],
                valueAnesthesia: 3042.0,
                finalSurgeryValue: 3042.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[32],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2173.75,
                paid: true,
                paymentDate: createDate(day: 26, month: 11, year: 2025),
                taxedValue: 326.25,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[33],
                valueAnesthesia: 1500.0,
                finalSurgeryValue: 1304.25,
                paid: true,
                paymentDate: createDate(day: 26, month: 11, year: 2025),
                taxedValue: 195.75,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[34],
                valueAnesthesia: 1109.55,
                valuePreAnesthesia: 131.5,
                finalSurgeryValue: 1241.05,
                paid: false
            ),
            Financial(
                surgery: surgeries[35],
                valueAnesthesia: 500.0,
                finalSurgeryValue: 500.0,
                paid: true,
                paymentDate: createDate(day: 21, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[36],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[37],
                valueAnesthesia: 500.0,
                finalSurgeryValue: 500.0,
                paid: true,
                paymentDate: createDate(day: 19, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[38],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2500.0,
                paid: true,
                paymentDate: createDate(day: 19, month: 12, year: 2025)
            ),
            Financial(
                surgery: surgeries[39],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: true
            ),
            Financial(
                surgery: surgeries[40],
                valueAnesthesia: 1500.0,
                finalSurgeryValue: 1500.0,
                paid: true,
                paymentDate: createDate(day: 19, month: 12, year: 2025)
            ),
            Financial(
                surgery: surgeries[41],
                valueAnesthesia: 1200.0,
                finalSurgeryValue: 1200.0,
                paid: true,
                paymentDate: createDate(day: 31, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[42],
                valueAnesthesia: 437.07,
                finalSurgeryValue: 437.07,
                paid: false
            ),
            Financial(
                surgery: surgeries[43],
                valueAnesthesia: 206.72,
                finalSurgeryValue: 206.72,
                paid: false
            ),
            Financial(
                surgery: surgeries[44],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: true,
                paymentDate: createDate(day: 31, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[45],
                valueAnesthesia: 295.32,
                finalSurgeryValue: 295.32,
                paid: false
            ),
            Financial(
                surgery: surgeries[46],
                valueAnesthesia: 800.0,
                finalSurgeryValue: 800.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[47],
                valueAnesthesia: 725.4,
                valuePreAnesthesia: 122.0,
                finalSurgeryValue: 847.4,
                paid: false
            ),
            Financial(
                surgery: surgeries[48],
                valueAnesthesia: 2337.98,
                finalSurgeryValue: 2337.98,
                paid: false
            ),
            Financial(
                surgery: surgeries[49],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: true,
                paymentDate: createDate(day: 31, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[50],
                valueAnesthesia: 1000.0,
                finalSurgeryValue: 1000.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[51],
                valueAnesthesia: 1877.0,
                finalSurgeryValue: 1877.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[52],
                valueAnesthesia: 707.69,
                finalSurgeryValue: 707.69,
                paid: false
            ),
            Financial(
                surgery: surgeries[53],
                valueAnesthesia: 437.07,
                finalSurgeryValue: 437.07,
                paid: false
            ),
            Financial(
                surgery: surgeries[54],
                valueAnesthesia: 2350.0,
                finalSurgeryValue: 2350.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[55],
                valueAnesthesia: 2000.0,
                finalSurgeryValue: 2000.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[56],
                valueAnesthesia: 1326.31,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 1426.31,
                paid: false
            ),
            Financial(
                surgery: surgeries[57],
                valueAnesthesia: 1073.05,
                finalSurgeryValue: 1073.05,
                paid: false
            ),
            Financial(
                surgery: surgeries[58],
                valueAnesthesia: 2684.94,
                finalSurgeryValue: 2684.94,
                paid: false
            ),
            Financial(
                surgery: surgeries[59],
                valueAnesthesia: 615.78,
                finalSurgeryValue: 615.78,
                paid: false
            ),
            Financial(
                surgery: surgeries[60],
                valueAnesthesia: 437.07,
                finalSurgeryValue: 437.07,
                paid: false
            ),
            Financial(
                surgery: surgeries[61],
                valueAnesthesia: 2000.0,
                finalSurgeryValue: 2000.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[62],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[63],
                valueAnesthesia: 1500.0,
                finalSurgeryValue: 1500.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 11, year: 2025)
            ),
            Financial(
                surgery: surgeries[64],
                valueAnesthesia: 4600.0,
                finalSurgeryValue: 4600.0,
                paid: false
            ),
            Financial(
                surgery: surgeries[65],
                valueAnesthesia: 500.0,
                finalSurgeryValue: 500.0,
                paid: true,
                paymentDate: createDate(day: 3, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[66],
                valueAnesthesia: 905.95,
                finalSurgeryValue: 905.95,
                paid: false
            ),
            Financial(
                surgery: surgeries[67],
                valueAnesthesia: 437.07,
                finalSurgeryValue: 437.07,
                paid: false
            ),
            Financial(
                surgery: surgeries[68],
                valueAnesthesia: 1163.3,
                finalSurgeryValue: 1163.3,
                paid: false
            ),
            Financial(
                surgery: surgeries[69],
                valueAnesthesia: 1500.0,
                finalSurgeryValue: 1500.0,
                paid: true,
                paymentDate: createDate(day: 7, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[70],
                valueAnesthesia: 244.85,
                finalSurgeryValue: 244.85,
                paid: false
            ),
            Financial(
                surgery: surgeries[71],
                valueAnesthesia: 175.5,
                finalSurgeryValue: 175.5,
                paid: false
            ),
            Financial(
                surgery: surgeries[72],
                valueAnesthesia: 800.0,
                finalSurgeryValue: 800.0,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[73],
                valueAnesthesia: 2002.26,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 2102.26,
                paid: false
            ),
            Financial(
                surgery: surgeries[74],
                valueAnesthesia: 955.13,
                finalSurgeryValue: 955.13,
                paid: false
            ),
            Financial(
                surgery: surgeries[75],
                valueAnesthesia: 630.68,
                finalSurgeryValue: 630.68,
                paid: false
            ),
            Financial(
                surgery: surgeries[76],
                valueAnesthesia: 450.0,
                finalSurgeryValue: 404.325,
                paid: true,
                paymentDate: createDate(day: 20, month: 10, year: 2025),
                taxedValue: 45.675,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[77],
                valueAnesthesia: 350.0,
                finalSurgeryValue: 304.325,
                paid: true,
                paymentDate: createDate(day: 20, month: 10, year: 2025),
                taxedValue: 45.675,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[78],
                valueAnesthesia: 350.0,
                finalSurgeryValue: 304.325,
                paid: true,
                paymentDate: createDate(day: 21, month: 10, year: 2025),
                taxedValue: 45.675,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[79],
                valueAnesthesia: 630.68,
                finalSurgeryValue: 630.68,
                paid: false
            ),
            Financial(
                surgery: surgeries[80],
                valueAnesthesia: 615.78,
                finalSurgeryValue: 615.78,
                paid: false
            ),
            Financial(
                surgery: surgeries[81],
                valueAnesthesia: 5020.6,
                valuePreAnesthesia: 131.5,
                finalSurgeryValue: 4496.911700000001,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 655.1883000000001,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[82],
                valueAnesthesia: 1000.0,
                finalSurgeryValue: 1000.0,
                paid: true,
                paymentDate: createDate(day: 21, month: 9, year: 2025)
            ),
            Financial(
                surgery: surgeries[83],
                valueAnesthesia: 342.69,
                finalSurgeryValue: 342.69,
                paid: false
            ),
            Financial(
                surgery: surgeries[84],
                valueAnesthesia: 1000.0,
                finalSurgeryValue: 1000.0,
                paid: true,
                paymentDate: createDate(day: 23, month: 9, year: 2025)
            ),
            Financial(
                surgery: surgeries[85],
                valueAnesthesia: 3000.0,
                finalSurgeryValue: 3000.0,
                paid: true,
                paymentDate: createDate(day: 19, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[86],
                valueAnesthesia: 3449.04,
                finalSurgeryValue: 2908.97,
                paid: true,
                paymentDate: createDate(day: 28, month: 11, year: 2025),
                taxedValue: 540.07,
                taxPercentage: 15.658560063090022
            ),
            Financial(
                surgery: surgeries[87],
                valueAnesthesia: 936.89,
                finalSurgeryValue: 936.89,
                paid: false
            ),
            Financial(
                surgery: surgeries[88],
                valueAnesthesia: 1467.5,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 1567.5,
                paid: false
            ),
            Financial(
                surgery: surgeries[89],
                valueAnesthesia: 700.0,
                finalSurgeryValue: 700.0,
                paid: true,
                paymentDate: createDate(day: 3, month: 10, year: 2025)
            ),
            Financial(
                surgery: surgeries[90],
                valueAnesthesia: 1000.0,
                finalSurgeryValue: 1000.0,
                paid: true,
                paymentDate: createDate(day: 19, month: 9, year: 2025)
            ),
            Financial(
                surgery: surgeries[91],
                valueAnesthesia: 2251.4,
                finalSurgeryValue: 2251.4,
                paid: false
            ),
            Financial(
                surgery: surgeries[92],
                valueAnesthesia: 816.72,
                finalSurgeryValue: 816.72,
                paid: false
            ),
            Financial(
                surgery: surgeries[93],
                valueAnesthesia: 2361.92,
                finalSurgeryValue: 2361.92,
                paid: false
            ),
            Financial(
                surgery: surgeries[94],
                valueAnesthesia: 295.32,
                finalSurgeryValue: 256.78074,
                paid: true,
                paymentDate: createDate(day: 15, month: 11, year: 2025),
                taxedValue: 38.53926,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[95],
                valueAnesthesia: 3731.13,
                valuePreAnesthesia: 131.5,
                finalSurgeryValue: 3358.61551,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 504.0144900000001,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[96],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2500.0,
                paid: true,
                paymentDate: createDate(day: 18, month: 9, year: 2025)
            ),
            Financial(
                surgery: surgeries[97],
                valueAnesthesia: 295.32,
                finalSurgeryValue: 256.78074,
                paid: true,
                paymentDate: createDate(day: 15, month: 11, year: 2025),
                taxedValue: 38.53926,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[98],
                valueAnesthesia: 3177.53,
                valuePreAnesthesia: 78.0,
                finalSurgeryValue: 3255.53,
                paid: false
            ),
            Financial(
                surgery: surgeries[99],
                valueAnesthesia: 642.65,
                finalSurgeryValue: 642.65,
                paid: false
            ),
            Financial(
                surgery: surgeries[100],
                valueAnesthesia: 1864.85,
                valuePreAnesthesia: 131.5,
                finalSurgeryValue: 1752.987075,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 243.362925,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[101],
                valueAnesthesia: 1561.98,
                finalSurgeryValue: 1358.1416100000001,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 203.83839,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[102],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2500.0,
                paid: true,
                paymentDate: createDate(day: 18, month: 9, year: 2025)
            ),
            Financial(
                surgery: surgeries[103],
                valueAnesthesia: 5115.03,
                valuePreAnesthesia: 131.05,
                finalSurgeryValue: 2676.77848,
                glosaAnesthesia: true,
                glosedAnesthesiaValue: 1748.29,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 821.01152,
                taxPercentage: 15.65
            ),
            Financial(
                surgery: surgeries[104],
                valueAnesthesia: 3231.65,
                valuePreAnesthesia: 84.0,
                finalSurgeryValue: 2882.957675,
                paid: true,
                paymentDate: createDate(day: 19, month: 10, year: 2025),
                taxedValue: 432.69232500000004,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[105],
                valueAnesthesia: 2825.16,
                valuePreAnesthesia: 84.0,
                finalSurgeryValue: 2529.51462,
                paid: true,
                paymentDate: createDate(day: 18, month: 10, year: 2025),
                taxedValue: 379.64538,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[106],
                valueAnesthesia: 449.6,
                finalSurgeryValue: 449.6,
                paid: false
            ),
            Financial(
                surgery: surgeries[107],
                valueAnesthesia: 295.32,
                finalSurgeryValue: 295.32,
                paid: false
            ),
            Financial(
                surgery: surgeries[108],
                valueAnesthesia: 3663.27,
                valuePreAnesthesia: 100.0,
                finalSurgeryValue: 3272.163265,
                paid: true,
                paymentDate: createDate(day: 15, month: 10, year: 2025),
                taxedValue: 491.10673500000007,
                taxPercentage: 13.05
            ),
            Financial(
                surgery: surgeries[110],
                valueAnesthesia: 2500.0,
                finalSurgeryValue: 2500.0,
                paid: true,
                paymentDate: createDate(day: 5, month: 8, year: 2025)
            ),
            Financial(
                surgery: surgeries[111],
                valueAnesthesia: 2147.75,
                finalSurgeryValue: 2147.75,
                paid: false
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

//extension SharedPreAndAnesthesia {
//    static func samples() -> [SharedPreAndAnesthesia] {
//        return [
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Local"],
//                asaRaw: "IIIe"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Raquianestesia"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Raquianestesia"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Local"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Peridural", "Geral Balanceada"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Raquianestesia"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Bloqueio Periférico"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Local"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação", "Raquianestesia"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "III"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "III"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Geral Balanceada"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Local", "Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia", "Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "I"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Sedação"],
//                asaRaw: "II"
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: [],
//                asaRaw: nil
//            ),
//            SharedPreAndAnesthesia(
//                techniquesRaw: ["Raquianestesia"],
//                asaRaw: "II"
//            ),
//        ]
//    }
//    private static func createDate(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
//        var components = DateComponents()
//        components.day = day
//        components.month = month
//        components.year = year
//        components.hour = hour
//        components.minute = minute
//        components.second = second
//        return Calendar.current.date(from: components) ?? Date()
//    }
    
//    let sharedToSurgeryLinks: [(surgery: Int, shared: Int)] = [
//        (0, 0), (1, 1), (2, 2), (3, 3), (4, 4),
//        (5, 5), (6, 6), (7, 7), (8, 8), (9, 9),
//        (10, 10), (11, 11), (12, 12), (13, 13),
//        (14, 14), (15, 15), (16, 16), (17, 17),
//        (18, 18), (19, 19), (20, 20), (21, 21),
//        (22, 22), (23, 23), (24, 24), (25, 25),
//        (26, 26), (27, 27), (28, 28), (29, 29),
//        (30, 30), (31, 31), (32, 32), (33, 33),
//        (34, 34), (35, 35), (36, 36), (37, 37),
//        (38, 38), (39, 39), (40, 40),
//        (47, 41), (61, 42), (71, 43), (74, 44),
//        (78, 45), (79, 46), (80, 47), (84, 48),
//        (85, 49), (86, 50), (91, 51)
//    ]
//    let user = User.sampleUser
//    let patients = Patient.samples(createdBy: user)
//    let surgeries = Surgery.samples(createdBy: user, patients: patients)
//    let shareds = SharedPreAndAnesthesia.samples()
//
//    // 🔑 LIGAÇÕES (ANTES do insert)
//    for link in sharedToSurgeryLinks {
//        guard
//            link.surgery < surgeries.count,
//            link.shared < shareds.count
//        else { continue }
//
//        shareds[link.shared].surgery = surgeries[link.surgery]
//    }
//}
