# AnesthesiaSheetView — UI e Dados Exibidos

## 1. Escopo

Esta documentação descreve apenas:

- Estrutura visual da folha anestésica (estilo, tamanhos, layout, cores, espaçamentos)
- Dados apresentados ao usuário, em linguagem clínica/negócio

Não descreve nomes internos de propriedades do código.

---

## 2. Estrutura geral da folha

- Formato da página: A4 em pontos (`567 x 813 pt`)
- Padding interno da página: `28 pt` (aprox. 10 mm)
- Fundo da página: branco
- Borda externa: cinza com opacidade `0.3`, espessura `1 pt`
- Composição vertical:
1. Cabeçalho
2. Identificação do paciente
3. Medicações e fluidos
4. Sinais vitais (gráfico)
5. Descrição anestésica
6. Equipe cirúrgica e procedimentos
7. Rodapé (finalização + responsável + assinatura)

---

## 3. Padrão visual das seções

### Faixa de título das seções (exceto cabeçalho e rodapé)

- Barra vertical azul à esquerda com `4 pt` de largura
- Fundo da faixa: cinza claro (`opacity 0.2`)
- Título:
  - Fonte: sistema
  - Peso: negrito
  - Tamanho:
    - `10 pt` (seções gerais)
    - `9 pt` (Medicações e Fluidos)
  - Cor: cinza
- Espaçamento interno do título: horizontal `8 pt`, vertical `4 pt`

### Corpo das seções

- Fundo: branco (ou cinza muito claro em identificação do paciente)
- Borda: cinza `opacity 0.3`, espessura `1 pt`
- Texto de conteúdo:
  - Fonte sistema, principalmente `9 pt` ou `10 pt`
  - Cor principal: preta
  - Rótulos em destaque via negrito/semibold em trechos específicos

---

## 4. Cabeçalho

### UI

- Título principal: `FICHA ANESTÉSICA`
  - Fonte `16 pt`, negrito, cor preta
- Linha de metadados com fonte `10 pt`
- Código da cirurgia em destaque visual:
  - Fonte `12 pt`, negrito, cor azul
  - Padding horizontal `12 pt`, vertical `4 pt`
  - Fundo azul com opacidade `0.1`
  - Borda azul com opacidade `0.3`, `1 pt`
- Linha divisória inferior azul (`2 pt`)

### Dados exibidos

- Data da cirurgia
  - Formato: numérico local (ex.: `06/03/2026`)
- Período anestésico
  - Início da anestesia: horário curto (ex.: `15:10`, padrão `HH:MM`)
  - Fim da anestesia: horário curto (ex.: `18:45`, padrão `HH:MM`)
  - Quando ausente: `-`
- Código/identificador da cirurgia
- Hospital
- Médico responsável
  - Nome
  - CRM
  - RQE (quando existente)

---

## 5. Identificação do paciente

### UI

- Título com fundo azul e texto branco:
  - `IDENTIFICAÇÃO DO PACIENTE`
  - Fonte `10 pt`, negrito
- Conteúdo:
  - Padding interno `10 pt`
  - Fundo cinza muito claro (`opacity 0.05`)
  - Texto `10 pt`, preto
  - Organização em 2 linhas com espaçadores para distribuição

### Dados exibidos

- Paciente (nome completo)
- Sexo
- Idade (calculada na data da cirurgia)
- Peso (em kg)
- Identificação administrativa:
  - Se atendimento SUS:
    - CNS (formatado para 15 dígitos)
    - Prontuário
  - Se convênio:
    - Convênio
    - Carteirinha

---

## 6. Medicações e fluidos

### UI

- Título: `MEDICAÇÕES E FLUIDOS`
  - Fonte `9 pt`, negrito, cor cinza
- Conteúdo:
  - Fonte `9 pt`, cor preta
  - Padding horizontal `12 pt`, vertical `4 pt`
  - Texto corrido em segmentos separados por `;`

### Dados exibidos

Os itens são agrupados por via/categoria e exibidos em blocos:

- Via venosa regional (VR)
- Cristaloides
- Hemoderivados
- Via endovenosa (EV)
- Demais vias (IM, IT, PD, PN, SC, SL, IN, TOP, VO, etc.)

Formato de cada item:

- `Nome da medicação + dose + (horário da administração)`
- Horário no formato curto (ex.: `15:20`, padrão `HH:MM`)

Exemplo de trecho exibido:

- `EV: Fentanil 100 mcg (15:20), Propofol 50 mg (15:25)`

---

## 7. Sinais vitais (gráfico)

### UI

- Título: `SINAIS VITAIS` (`10 pt`, negrito)
- Área do gráfico:
  - Altura total: `180 pt`
  - Padding: `12 pt`
  - Borda cinza `1 pt` com opacidade `0.3`
- Eixo Y:
  - Marcação de 10 em 10
  - Fonte dos valores: `7 pt`
- Eixo X:
  - Aproximadamente 6 marcações automáticas
  - Fonte dos valores: `7 pt`
- Legenda inferior compacta:
  - Fonte base `5 pt`
  - Símbolos em `8 pt`

### Dados exibidos no gráfico

Séries de monitorização:

- FC (frequência cardíaca): círculo vermelho
- PAS (pressão arterial sistólica): triângulo preto invertido
- PAD (pressão arterial diastólica): triângulo preto
- PAM (pressão arterial média): quadrado preto
- SpO₂ (saturação periférica de oxigênio): cruz verde
- EtCO₂ (CO₂ expirado final): círculo azul

Marcadores verticais de eventos:

- Início da anestesia (verde)
- Início da cirurgia (azul)
- Fim da cirurgia (azul)
- Fim da anestesia (verde)

Escala de tempo (eixo X):

- Baseada no menor e maior horário disponível entre:
  - registros de sinais vitais
  - início/fim da anestesia
  - início/fim da cirurgia
- Com margem lateral de 60 segundos em cada ponta

---

## 8. Descrição anestésica

### UI

- Título: `DESCRIÇÃO ANESTÉSICA` (`10 pt`, negrito)
- Conteúdo:
  - Fonte `9 pt`, cor preta
  - Rótulos de campos com semibold
  - `lineSpacing` de `2`
  - Padding interno `12 pt`
  - Texto narrativo com espaçamento superior de `6 pt`

### Dados exibidos

- Técnica anestésica (ou Técnicas anestésicas, no plural)
- Posicionamento do paciente
- Texto final da descrição anestésica
  - Quando não houver texto: `Sem descrição`

---

## 9. Equipe cirúrgica e procedimentos

### UI

- Título: `EQUIPE CIRÚRGICA E PROCEDIMENTOS` (`10 pt`, negrito)
- Conteúdo com fonte principal `9 pt` (há um campo de auxiliares em `10 pt`)
- Padding interno `12 pt`
- Borda cinza `1 pt`

### Dados exibidos

- Cirurgião principal
- Auxiliares (quando houver)
- Procedimento (ou Cirurgia proposta, conforme contexto)
- Códigos CBHPM (quando houver)
- Portes (quando houver)

---

## 10. Rodapé

### UI

- Linha separadora superior: cinza `1 pt` (`opacity 0.3`)
- Texto esquerdo:
  - Fonte `9 pt`, cinza
- Texto direito:
  - Fonte `10 pt`, cinza
- Assinatura opcional sobreposta no canto superior direito:
  - Assinatura da imagem: `162 x 50 pt`
  - Ou assinatura padrão GovBR reduzida (`scale 0.55`)

### Dados exibidos

- Frase de encerramento da ficha:
  - `Ficha finalizada em {horário} {data}`
  - Horário: formato curto (ex.: `18:45`, padrão `HH:MM`)
  - Data: formato numérico local (ex.: `06/03/2026`)
- Responsável:
  - Nome
  - CRM
  - RQE

