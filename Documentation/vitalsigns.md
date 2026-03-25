# Sinais Vitais Intraoperatórios — Documentação de Domínio

## 1. Propósito

O módulo de sinais vitais permite ao anestesiologista registrar a evolução hemodinâmica e ventilatória do paciente ao longo do procedimento cirúrgico. O objetivo final é compor a **folha de sinais vitais da ficha anestésica**, documento obrigatório do ato anestésico.

O registro pode ocorrer de duas formas:

- **Manual** — o profissional digita um registro por vez com os valores que lê nos monitores do centro cirúrgico; não há integração automática com equipamentos
- **Geração automática de série** — o profissional informa um estado basal (FC, PA, SpO₂) e o sistema gera toda a série de registros da cirurgia simulando variações fisiológicas realistas, conforme a técnica anestésica e as fases do procedimento

Em ambos os casos o fluxo é **não tempo real** — os dados são inseridos pelo profissional, não capturados automaticamente dos monitores.

---

## 2. Entidade: VitalSignEntry

Cada registro representa um **snapshot** dos parâmetros monitorados em um determinado momento da cirurgia.

### Campos

| Campo (snake_case) | Tipo | Obrigatório | Significado |
|---|---|---|---|
| `id` | String (UUID) | Sim | Identificador único |
| `anesthesia_id` | String (FK) | Sim | Vínculo com o ato anestésico |
| `timestamp` | DateTime | Sim | Momento do registro |
| `heart_rate` | Double | **Sim** | Frequência Cardíaca (bpm) |
| `systolic_bp` | Double | **Sim** | Pressão Arterial Sistólica (mmHg) |
| `diastolic_bp` | Double | **Sim** | Pressão Arterial Diastólica (mmHg) |
| `mean_bp` | Double? | Não | Pressão Arterial Média (mmHg) — calculada |
| `cardiac_rhythm` | String? | Não | Ritmo cardíaco (ex: "Sinusal") |
| `spo2` | Double | **Sim** | Saturação periférica de O₂ (%) |
| `etco2` | Double? | Não | CO₂ ao final da expiração (mmHg) |
| `fio2` | Double? | Não | Fração inspirada de O₂ (%) |
| `peep` | Double? | Não | Pressão expiratória final positiva (cmH₂O) |
| `tidal_volume` | Double? | Não | Volume corrente (mL) |
| `bis` | Double? | Não | Índice Bispectral (0–100) |
| `pupils` | String? | Não | Avaliação pupilar |
| `tof` | Double? | Não | Train-of-Four (%) |
| `cvp` | Double? | Não | Pressão Venosa Central (cmH₂O) |
| `cardiac_output` | Double? | Não | Débito cardíaco (L/min) |
| `blood_glucose` | Double? | Não | Glicemia (mg/dL) |
| `lactate` | Double? | Não | Lactato (mmol/L) |
| `temperature` | Double? | Não | Temperatura corporal (°C) |
| `urine_output` | Double? | Não | Diurese (mL) |
| `blood_loss` | Double? | Não | Sangramento estimado (mL) |

### Cálculo do mean_bp

A Pressão Arterial Média é sempre **derivada**, nunca digitada diretamente:

```
mean_bp = (systolic_bp + 2 × diastolic_bp) / 3
```

Deve ser recalculada sempre que `systolic_bp` ou `diastolic_bp` mudar.

---

## 3. Regras de Validação

### heart_rate — obrigatório
- Não pode ser negativa
- Não pode ultrapassar 280 bpm

### spo2 — obrigatório
- Deve estar entre 0% e 100%

### systolic_bp / diastolic_bp — obrigatórios
As regras são relacionais — validar sempre os dois campos em conjunto:

| Condição | Erro |
|---|---|
| `systolic_bp` < 0 | Não pode ser negativa |
| `systolic_bp` > 300 | Valor improvável — confirmar digitação |
| `diastolic_bp` < 0 | Não pode ser negativa |
| `diastolic_bp` > 200 | Valor improvável — confirmar digitação |
| `systolic_bp` == 0 e `diastolic_bp` ≠ 0 | Se sistólica for 0, diastólica também deve ser 0 |
| `diastolic_bp` == 0 e `systolic_bp` ≠ 0 | Se diastólica for 0, sistólica também deve ser 0 |
| `systolic_bp` == `diastolic_bp` e ambas ≠ 0 | Só podem ser iguais se ambas forem 0 |
| `systolic_bp` < `diastolic_bp` | Sistólica deve ser maior que diastólica |

### Princípio de exibição de erros
Erros só devem ser exibidos **após o usuário interagir com o campo** (padrão "touched"). Campos opcionais nunca preenchidos não exibem erro — são simplesmente omitidos do registro.

---

## 4. Sugestão Automática de Timestamp

Ao abrir o formulário para um novo registro, o sistema sugere automaticamente o próximo horário com base no andamento da cirurgia.

### Algoritmo

```
âncora = horário de início da anestesia (apiAnesthesia - anesthesia.start_at)

se não há nenhum registro anterior:
    sugerido = âncora

senão:
    decorrido = último_registro - âncora (em minutos)

    se decorrido < 30 min:
        incremento = 5 min
    senão:
        incremento = 10 min

    sugerido = último_registro + incremento
```

### Racional clínico

Os primeiros 30 minutos correspondem à indução anestésica e ao início da manutenção — fase de maior instabilidade hemodinâmica. Registros a cada 5 minutos refletem a necessidade de acompanhamento mais próximo nesse período. Após 30 minutos, o paciente tende a estar estabilizado e registros a cada 10 minutos são a prática clínica padrão.

A regra de intervalo é determinada pela diferença entre o **último registro** e o **início da anestesia** (`anesthesia.start_at`), não pelo horário atual:

```
decorrido = último_registro - anesthesia.start_at (em minutos)

se decorrido < 30 min → próximo intervalo = 5 min
se decorrido ≥ 30 min → próximo intervalo = 10 min
```

**Exemplo** — `anesthesia.start_at` = 06/03/2026 às 15:10, sem registros anteriores:

| # | Timestamp sugerido | Decorrido desde 15:10 | Intervalo usado |
|---|---|---|---|
| 1 | 15:10 | 0 min (sem registro anterior) | — |
| 2 | 15:15 | 5 min | 5 min |
| 3 | 15:20 | 10 min | 5 min |
| 4 | 15:25 | 15 min | 5 min |
| 5 | 15:30 | 20 min | 5 min |
| 6 | 15:35 | 25 min | 5 min |
| 7 | 15:40 | 30 min → ≥ 30 min | **10 min** |
| 8 | 15:50 | 40 min | 10 min |

Essa lógica se aplica nos dois modos de registro:
- **Manual**: o timestamp sugerido ao abrir o formulário já segue esse intervalo, guiando o profissional sem obrigá-lo
- **Geração automática**: os timestamps da série inteira são gerados com esse mesmo espaçamento, garantindo que a distribuição dos registros simulados reflita a prática real

---

## 5. Faixas de Referência por Faixa Etária

Usadas como base para geração de séries e como referência de "paciente saudável". (usar apiPatients - patient.birthdate para cálculo de idade)

| Faixa etária | FC (bpm) | PAS (mmHg) | PAD (mmHg) | SpO₂ (%) | EtCO₂ (mmHg) |
|---|---|---|---|---|---|
| Neonato / Lactente (0–1 ano) | 110–150 | 70–90 | 50–65 | 95–100 | 30–35 |
| Pré-escolar (2–5 anos) | 95–130 | 80–100 | 55–70 | 96–100 | 32–38 |
| Escolar (6–12 anos) | 80–115 | 90–110 | 60–75 | 96–100 | 34–40 |
| Adolescente (13–17 anos) | 70–100 | 100–120 | 65–80 | 97–100 | 35–42 |
| Adulto (18–64 anos) | 60–90 | 100–130 | 70–85 | 97–100 | 35–42 |
| Idoso (65+ anos) | 65–85 | 110–140 | 70–90 | 95–99 | 34–40 |

---

## 6. Geração Automática de Série

Permite gerar toda a série de registros da cirurgia a partir de um **estado basal** informado pelo profissional. Útil para documentação retrospectiva ou para preencher casos com evolução previsível.

### Pré-requisitos
- Modo criação (sem registro existente selecionado)
- `heart_rate`, `systolic_bp`, `diastolic_bp` e `spo2` base preenchidos
- Duração da cirurgia conhecida (informada ou calculada pelo horário de início/fim)

### Campos variáveis vs fixos

| Comportamento | Campos |
|---|---|
| **Variam** conforme fase e técnica | `heart_rate`, `systolic_bp`, `diastolic_bp`, `mean_bp`, `spo2`, `etco2`, `tidal_volume`, `bis`, `cvp`, `temperature` |
| **Repetem** o valor base em todos os registros | `cardiac_rhythm`, `fio2`, `peep`, `pupils`, `tof`, `cardiac_output`, `blood_glucose`, `lactate`, `urine_output`, `blood_loss` |

### Fases da Anestesia

| Fase | Critério | Comportamento esperado |
|---|---|---|
| **Indução** | 0–15 min | Queda de PA, ajuste de FC, BIS cai |
| **Manutenção** | 15 min até (fim − 20 min) | Estabilidade próxima à base; temperatura cai lentamente |
| **Despertar** | Últimos 20 min | PA e FC sobem; BIS sobe |
| **Caso curto** | Duração total < 40 min | Sem fases distintas; pequena variabilidade uniforme |

### Perfis por Técnica Anestésica
-apisharedpreananesthesia -> techniques
| Técnica | Característica principal |
|---|---|
| **Raquianestesia** | Queda importante de PA na indução (≈25%); FC pode compensar subindo |
| **Geral** (balanceada / TIVA / inalatória) | Muito estável após indução; menor variabilidade; PA e FC sobem no despertar |
| **Sedação** | Maior variabilidade; reflexos mantidos; alterações hemodinâmicas discretas |
| **Bloqueio / Local** | Alterações mínimas; variabilidade baixa |

### Algoritmo de Geração

Para cada timestamp gerado pela lógica de sugestão (seção 4):

1. Determinar a fase com base no tempo decorrido
2. Calcular valores-alvo ajustados pela fase e pelo perfil da técnica
3. Aplicar **suavização exponencial** entre o último valor e o alvo:
   ```
   novo = (1 - α) × último + α × alvo
   ```
   - α próximo de 0 → transição suave (PA, SpO₂)
   - α próximo de 1 → transição rápida
4. Adicionar **ruído fisiológico** (variação aleatória pequena) para simular micro-oscilações reais
5. Aplicar limites (clamping) dentro de uma faixa fisiológica razoável
6. Garantir que PAD < PAM < PAS
7. Calcular PAM a partir de PAS e PAD

### Parâmetros de variabilidade por técnica (referência)

| Técnica | Variab. FC | Variab. PA | Queda PA indução | Subida PA despertar |
|---|---|---|---|---|
| Raquianestesia | ±8 bpm | ±15 mmHg | 25% | 10% |
| Geral | ±3 bpm | ±8 mmHg | 15% | 15% |
| Sedação | ±6 bpm | ±10 mmHg | 5% | 5% |
| Bloqueio / Local | ±5 bpm | ±8 mmHg | 5% | 3% |

---

## 7. Modos do Formulário

### Criação
- Timestamp sugerido automaticamente (seção 4)
- Ritmo pré-preenchido com "Sinusal"
- Campos de toque inicialmente limpos (sem erros exibidos)
- Disponível: geração de série automática

### Edição
- Todos os campos carregados do registro existente
- Campos de toque inicializados como "tocados" (erros exibidos imediatamente se inválidos)
- Geração de série **não disponível**

---

## 8. Contexto Clínico Injetado

O formulário recebe informações do contexto cirúrgico para alimentar a lógica de sugestão e geração:

| Dado | Origem | Uso |
|---|---|---|
| `anesthesiaStart` / `anesthesiaEnd` | Anesthesia | Âncora de timestamp e duração da série |
| `surgeryStart` / `surgeryEnd` | Surgery | Referência secundária de duração |
| `techniques` | SharedPreAndAnesthesia | Define perfil de variabilidade |
| `asaClassification` | SharedPreAndAnesthesia | Reservado para validações clínicas futuras |
| `patientAge` | Surgery → Patient.birthDate | Faixas de referência por faixa etária |
| `anesthesiaPosition` | Anesthesia | Reservado para validações clínicas futuras |

---

## 9. Considerações para Outras Plataformas

- Todos os campos são **opcionais exceto id, vínculo com anestesia e timestamp** — suporte a avaliações parciais é um requisito
- A PAM nunca deve ser um campo de entrada do usuário — sempre calculada
- A lógica de sugestão de timestamp é stateless: depende apenas do horário de início da anestesia e do último registro persistido
- A geração de série pode ser implementada inteiramente em backend ou frontend — não há dependência de persistência durante o cálculo
- Os perfis de técnica e fases de anestesia são regras de negócio clínicas, não de UI — devem viver na camada de domínio independentemente da plataforma
