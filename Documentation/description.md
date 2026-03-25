# AnesthesiaDescription — Documentação para Replicação

Módulo responsável por registrar o **relato clínico do ato anestésico** (intraoperatório).
Está organizado em 4 seções sequenciais que, ao final, geram automaticamente um texto narrativo padronizado.

---

## Modelagem rica — alternativa stack-agnóstica

> Esta seção descreve uma modelagem mais expressiva que a implementação atual em SwiftData.
> Serve como referência para replicações em qualquer stack (Android/Room, Web/Postgres, Flutter/Drift, etc.).

A implementação atual achata todas as seções em campos planos com lógica de dependência espalhada nos ViewModels. Dois problemas distintos emergem:

- **Técnicas:** hierarquia de *tipo* — a estrutura dos dados muda conforme a técnica escolhida (polimorfismo).
- **Admissão:** hierarquia de *restrição* — os valores válidos de um campo dependem do valor de outro (máquina de estados).

---

### Técnicas — modelo polimórfico

Em vez de booleanos + ~25 campos planos opcionais, as técnicas são uma **lista ordenada de objetos discriminados**. A ordem no array substitui `techOrder`.

#### Schema

```typescript
type AnesthesiaTechnique =
  | GeneralTechnique
  | SpinalTechnique
  | PeriduralTechnique
  | SedationTechnique
  | PeripheralBlockTechnique
  | LocalTechnique

// Discriminante comum a todos
interface BaseTechnique {
  category: "general" | "spinal" | "peridural" | "sedation" | "block" | "local"
}

interface GeneralTechnique extends BaseTechnique {
  category: "general"
  subtype: "balanced" | "tiva" | "inhalatory"
  tubeAccess: TubeAccess | null
  visualizationMethod: VisualizationMethod | null
  equipment: LaryngoscopyEquipment | null
  cormack: CormackLehane | null
  tubeType: TubeType | null
  tubeRoute: TubeRoute | null
  tubeCuff: TubeCuff | null
  totNumber: string | null
  fixation: string | null
}

interface SpinalTechnique extends BaseTechnique {
  category: "spinal"
  position: SpinalPosition | null
  needle: SpinalNeedle | null
  level: SpinalLevel | null
  levelCustom: string | null
  gauge: NeedleGauge | null
}

interface PeriduralTechnique extends BaseTechnique {
  category: "peridural"
  position: SpinalPosition | null
  needle: SpinalNeedle | null
  level: SpinalLevel | null
  level2: SpinalLevel | null        // null se não for dupla
  double: boolean
  gauge: NeedleGauge | null
  technique: PeriduralTechniqueKind | null
  catheterFixation: string | null
}

interface SedationTechnique extends BaseTechnique {
  category: "sedation"
  depth: "minimal" | "moderate" | "deep" | null
  type: "intravenous" | "inhalatory" | "combined" | null
  ivType: "tiva" | "intermitent" | null   // null se type != intravenous/combined
  oxygenSupply: SedationOxygenSupply | null
}

interface PeripheralBlockTechnique extends BaseTechnique {
  category: "block"
  equipment: BlockEquipment | null
  region: "mmss" | "mmii" | "thoracic_abdominal"
  type: MMSSTechnique | MMIITechnique | AbdominalToraxTechnique
  laterality: "left" | "right" | "bilateral" | null
  notes: string | null
}

interface LocalTechnique extends BaseTechnique {
  category: "local"
  notes: string | null
}
```

#### Representação persistida (JSON / coluna TEXT)

```json
[
  {
    "category": "spinal",
    "position": "seated",
    "needle": "quincke",
    "level": "L3",
    "gauge": "g26"
  },
  {
    "category": "block",
    "equipment": "usg",
    "region": "mmss",
    "type": "axilar",
    "laterality": "left"
  },
  {
    "category": "general",
    "subtype": "balanced",
    "tubeAccess": "inORInserted",
    "equipment": "laringoscope",
    "visualizationMethod": "direct",
    "cormack": "grade2a",
    "tubeType": "common",
    "tubeRoute": "oral",
    "tubeCuff": "with",
    "totNumber": "7.0",
    "fixation": "21"
  }
]
```

#### Regras de visibilidade derivadas do tipo

As regras que hoje vivem em `didSet` nos ViewModels passam a ser **derivadas do discriminante**:

| Condição | Campos visíveis |
|---|---|
| `category == "general"` e `tubeAccess == "previouslyInserted"` | Oculta `visualizationMethod`, `equipment`, `cormack` |
| `category == "general"` e `tubeType == "traqueal"` | Oculta `tubeRoute`, `tubeCuff`, `fixation`, `visualizationMethod`, `equipment`, `cormack`, `totNumber` |
| `category == "sedation"` e `type == "inhalatory"` | Oculta `ivType` |
| `category == "peridural"` e `double == false` | Oculta `level2` |

---

### Admissão — modelo de máquina de estados

A admissão não é polimórfica, mas tem **dependências em cascata** entre campos. O modelo correto é um grafo de estados onde cada nó restringe os valores válidos do próximo.

#### Cadeia de dependências

```
airway
  └─► ventilationMode
        └─► mechanicalVentilationMode   (apenas se mode != spontaneous)
              └─► oxygenSupply
                    └─► fiO2Fraction    (apenas se supply != ambientAir)

hemodynamic  (independente)

veinAccess
  └─► veinGauge                         (apenas se access != none)
```

#### Schema

```typescript
interface AdmissionState {
  airway: AirwayKind | null
  consciousness: ConsciousnessKind | null
  ventilation: VentilationConfig | null
  oxygenSupply: OxygenSupplyConfig | null
  hemodynamic: HemodynamicKind | null
  vascularAccess: VascularAccessConfig | null
}

interface VentilationConfig {
  mode: "spontaneous" | "invasive_mechanical" | "non_invasive_mechanical"
  mechanicalMode: MechanicalVentilationMode | null  // null se mode == spontaneous
}

interface OxygenSupplyConfig {
  supply: "ambientAir" | "nasalCateter" | "venturiMask" | "nonRebreather"
  fiO2Fraction: number | null  // null se supply == ambientAir
}

interface VascularAccessConfig {
  access: "none" | "inOpRoom" | "previouslyInserted"
  gauge: VeinGauge | null  // null se access == none
}
```

#### Exemplo persistido

```json
{
  "airway": "endotrachealTube",
  "consciousness": "sedated",
  "ventilation": {
    "mode": "invasive_mechanical",
    "mechanicalMode": "VCV"
  },
  "oxygenSupply": {
    "supply": "venturiMask",
    "fiO2Fraction": 40
  },
  "hemodynamic": "stable",
  "vascularAccess": {
    "access": "inOpRoom",
    "gauge": "g22"
  }
}
```

#### Restrições de valores válidos por nó

| Campo pai | Valor | Restrição no filho |
|---|---|---|
| `airway` | `noDevice`, `compromised`, `oropharyngealGuedel`, `nasopharyngeal` | `ventilation.mode` deve ser `spontaneous` |
| `airway` | `endotrachealTube`, `tracheostomy` | `ventilation.mode` não pode ser `spontaneous` |
| `ventilation.mode` | `spontaneous` | `mechanicalMode` deve ser `null` |
| `oxygenSupply.supply` | `ambientAir` | `fiO2Fraction` deve ser `null` |
| `oxygenSupply.supply` | `venturiMask` | `fiO2Fraction` tem valores discretos: 24, 28, 31, 35, 40, 60% |
| `vascularAccess.access` | `none` | `gauge` deve ser `null` |

---

### Comparativo com a implementação atual

| Aspecto | Implementação atual (SwiftData) | Modelagem rica |
|---|---|---|
| Técnicas | 6 booleans + ~25 campos planos | `[AnesthesiaTechnique]` polimórfico |
| Ordem das técnicas | `techOrder: [String]` separado | posição no array |
| Admissão | 9 campos planos + lógica em `didSet` | 5 objetos agrupados por coesão |
| Regras de visibilidade | espalhadas nos ViewModels | derivadas da estrutura do dado |
| Adicionar nova técnica | novos campos no modelo raiz | novo objeto na lista, schema raiz inalterado |
| Persistência | 1 coluna por campo | JSON em coluna única (ou tabela de técnicas com FK) |

---

## Contexto no domínio

```
Surgery
 └── Anesthesia
      └── AnesthesiaDescriptionEntry   ← este módulo
```

`AnesthesiaDescriptionEntry` tem cardinalidade **1:1** com `Anesthesia`.
O módulo recebe como contexto somente-leitura:
- `patientAge: Int` — calculado a partir de `surgery.patient.birthDate`
- `patientWeight: Double` — `surgery.weight`
- `patientSex: Sex` — `surgery.patient.sex`
- `sharedTechniques: [AnesthesiaTechniqueKind]` — técnicas selecionadas na pre-anestesia (via `SharedPreAndAnesthesia`)

---

## Modelo de dados — `AnesthesiaDescriptionEntry`

Todos os campos de enum são persistidos como `String?` (rawValue). A camada de apresentação converte para o enum type-safe.

### Monitorização

| Campo | Tipo | Default |
|---|---|---|
| `electrocardioscopy` | Bool | false |
| `oximetry` | Bool | false |
| `nonInvasiveBloodPressure` | Bool | false |
| `capnography` | Bool | false |
| `invasiveBloodPressure` | Bool | false |
| `centralVenousPressure` | Bool | false |
| `thermometer` | Bool | false |
| `bis` | Bool | false |
| `tof` | Bool | false |
| `customMonitorings` | [String] | [] |

### Admissão

| Campo | Tipo |
|---|---|
| `airway` | `AirwayKind?` |
| `consciousness` | `ConsciousnessKind?` |
| `ventilatory` | `VentilationMode?` |
| `mechanicalVentilation` | `MechanicalVentilationMode?` |
| `oxygenSupply` | `OxygenSupply?` |
| `fiO2Fraction` | `Double?` |
| `hemodynamic` | `HemodynamicKind?` |
| `veinAccess` | `VeinAccessKind?` |
| `veinGauge` | `VeinGaugeKind?` |

### Técnicas — seleção e ordem

| Campo | Tipo | Default |
|---|---|---|
| `generalAnesthesia` | Bool | false |
| `spinalAnesthesia` | Bool | false |
| `sedationAnesthesia` | Bool | false |
| `periduralAnesthesia` | Bool | false |
| `peripheralBlockAnesthesia` | Bool | false |
| `localAnesthesia` | Bool | false |
| `techOrder` | [String] | [] |

### Anestesia Geral — detalhes

| Campo | Tipo |
|---|---|
| `tubeAcess` | `TubeAcess?` |
| `visualizationMethod` | `VisualizationMethod?` |
| `equipment` | `LaringoschopyEquipment?` |
| `cormack` | `CormackLehane?` |
| `tubeType` | `TubeType?` |
| `tubeRoute` | `TubeRoute?` |
| `tubeCuff` | `TubeCuff?` |
| `totNumber` | `String?` |
| `fixation` | `String?` |

### Raquianestesia — detalhes

| Campo | Tipo |
|---|---|
| `raquiPosition` | `SpinalAndEpiduralPosition?` |
| `raquiNeedle` | `SpinalAndEpiduralNeedle?` |
| `raquiLevel` | `SpinalAndEpiduralLevel?` |
| `raquiNivelOutro` | `String?` |
| `raquiNeedleGauge` | `SpinalAndEpiduralGaugeKind?` |

### Peridural — detalhes

| Campo | Tipo |
|---|---|
| `periduralPosition` | `SpinalAndEpiduralPosition?` |
| `periduralNeedle` | `SpinalAndEpiduralNeedle?` |
| `periduralLevel` | `SpinalAndEpiduralLevel?` |
| `periduralLevel2` | `SpinalAndEpiduralLevel?` |
| `doublePeridural` | `Bool?` |
| `periduralNeedleGauge` | `SpinalAndEpiduralGaugeKind?` |
| `periduralTechnique` | `PeriduralTechniqueKind?` |
| `periduralCateterFixation` | `String?` |

### Sedação — detalhes

| Campo | Tipo |
|---|---|
| `sedationTechnique` | `SedationTechniqueKind?` |
| `sedationType` | `SedationType?` |
| `intraVenousSedationType` | `IntraVenousSedationType?` |
| `sedationOxygenSupply` | `SedationOxygenSupplyKind?` |

### Bloqueio Periférico — detalhes

| Campo | Tipo |
|---|---|
| `blockEquipment` | `BlockEquipmentKind?` |
| `mmssTechnique` | `MMSSTechnique?` |
| `mmiiTechnique` | `MMIITechnique?` |
| `abdominalToraxTechnique` | `AbdominalToraxTechnique?` |
| `blockSide` | `BlockSide?` |
| `blockOthers` | `String?` |

> **Nota:** os arrays de bloqueios multi-seleção (`mmssBlocks`, `mmiiBlocks`, `abdominalBlocks`) vêm de `SharedPreAndAnesthesia`, não de `AnesthesiaDescriptionEntry`. São somente-leitura neste módulo.

### Desfecho

| Campo | Tipo | Default |
|---|---|---|
| `standardEnd` | Bool | false |
| `destinationAnesthesia` | `DestinationAnesthesia?` | nil |
| `endAnesthesia` | `EndAnesthesia?` | nil |
| `complications` | `[String]?` | nil |
| `adverseEvolution` | `String?` | nil |

### Textos gerados (cache)

| Campo | Tipo |
|---|---|
| `monitoringText` | `String?` |
| `admissionText` | `String?` |
| `techniquesText` | `String?` |
| `completionText` | `String?` |
| `veryEndDescriptionText` | `String?` |
| `finalDescription` | `String?` |

Esses campos são preenchidos pela operação "Sugerir" e podem ser editados livremente pelo usuário.

---

## Enums de domínio

### `AirwayKind`
```
noDevice | compromised | oropharyngealGuedel | nasopharyngeal
lma | endotrachealTube | tracheostomy
```

### `ConsciousnessKind`
```
alert | drowsy | lethargic | responsiveToPain | unresponsive | sedated
```

### `VentilationMode`
```
spontaneous | invasiveMechanicalVentilation | nonInvasiveMechanicalVentilation
```

### `MechanicalVentilationMode`
```
CPAP | BiPAP | VCV | PCV | SIMV | PSV
```

### `OxygenSupply`
```
ambientAir | nasalCateter | venturiMask | nonReinalantMask
```

### `HemodynamicKind`
```
stable | unstable | compensated | unstableDespiteDrugs
```

### `VeinAccessKind`
```
none | inOpRoom | previouslyInserted
```

### `VeinGaugeKind`
```
g14 | g18 | g20 | g22 | g24 | cdl
```

### `TubeAcess`
```
inORInserted | previouslyInserted
```

### `VisualizationMethod`
```
direct | indirect
```

### `LaringoschopyEquipment`
```
laringoscope | fibroscope | mirrorGarcia | videoLaryngoscope
```

### `TubeType`
```
common | aramado | doubleLumen | eNasal | traqueal
```

### `TubeRoute`
```
nasal | oral
```

### `TubeCuff`
```
with | without
```

### `CormackLehane`
```
grade1 | grade2a | grade2b | grade3 | grade4
```

### `SpinalAndEpiduralPosition`
```
seated | lateralDecubitus
```

### `SpinalAndEpiduralLevel`
```
T1 | T2 | T3 | T4 | T5 | T6 | T7 | T8 | T9 | T10 | T11 | T12
L1 | L2 | L3 | L4 | L5 | sacral | coccyx
```

### `SpinalAndEpiduralNeedle`
```
whitacre | quincke | thuohy | thuohysoho | caudal
```

### `SpinalAndEpiduralGaugeKind`
```
g16 | g17 | g18 | g19 | g20 | g22 | g25 | g26 | g27
```

### `PeriduralTechniqueKind`
```
dogliotti | gutierrez
```

### `SedationTechniqueKind`
```
minimal | moderate | deep
```

### `SedationType`
```
intravenous | inalatory | combined
```

### `IntraVenousSedationType`
```
tiva | intermitent
```

### `SedationOxygenSupplyKind`
```
cateterNasal | facialMask
```

### `BlockEquipmentKind`
```
usg | usgAndNeuralStimulation | neuralStimulationOnly | landmarks
```

### `BlockSide`
```
left | right | bilateral
```

### `MMSSTechnique` (membros superiores)
```
interescalenical | supraclavian | subclavian | axilar
```

### `MMIITechnique` (membros inferiores)
```
femoral | adutor | sciatic_gluteal | sciatic_poplitean
```

### `AbdominalToraxTechnique`
```
tap | quadrado_lombar | pecs1 | pecs2 | serratus | paravertebral | ilioinguinal
```

### `DestinationAnesthesia`
```
rpa | uti
```

### `EndAnesthesia`
```
noComplication | complication
```

---

## Regras de negócio e visibilidade condicional

### Admissão

| Gatilho | Efeito |
|---|---|
| `airway` ∈ `{noDevice, compromised, oropharyngealGuedel, nasopharyngeal}` | Força `ventilatory = spontaneous` |
| `ventilatory == spontaneous` | Oculta/limpa `mechanicalVentilation` |
| `oxygenSupply == ambientAir` | Oculta/limpa `fiO2Fraction` |
| `veinAccess == none` | Oculta/limpa `veinGauge` |

### Anestesia Geral

| Gatilho | Efeito |
|---|---|
| `tubeAcess == previouslyInserted` | Oculta `visualizationMethod`, `cormack`, `equipment` |
| `tubeType == traqueal` | Oculta `tubeRoute`, `tubeCuff`, `fixation`, `visualizationMethod`, `cormack`, `equipment`, `totNumber` |
| `tubeType == aramado` | Força `tubeCuff = with` |
| `tubeType == eNasal` | Força `tubeRoute = nasal` |
| `tubeType == doubleLumen` | Força `tubeRoute = oral` |
| `tubeRoute == nasal` | Limpa `fixation` |

### Sedação

| Gatilho | Efeito |
|---|---|
| `sedationType == inalatory` | Oculta/limpa `intraVenousSedationType` |

### Peridural

| Gatilho | Efeito |
|---|---|
| `doublePeridural == false` | Limpa `periduralLevel2` |

### Desfecho

| Gatilho | Efeito |
|---|---|
| `standardEnd == true` | Força `destinationAnesthesia = rpa` e `endAnesthesia = noComplication` |
| `endAnesthesia == noComplication` | Limpa `adverseEvolution` e `complications` |

---

## Sugestões automáticas (defaults inteligentes)

As sugestões são opcionais e acionadas explicitamente pelo usuário (botão "Sugerir"). Usam `patientAge`, `patientWeight` e `patientSex` do contexto.

### Monitorização

```
electrocardioscopy = true
oximetry = true
nonInvasiveBloodPressure = true
capnography = true  (apenas se hasGeneralAnesthesia)
```

### Admissão

```
airway = noDevice
consciousness = alert
ventilatory = spontaneous
oxygenSupply = ambientAir
hemodynamic = stable
veinAccess = inOpRoom
veinGauge = g22
```

### Anestesia Geral

```
tubeAcess = inORInserted
equipment = laringoscope
tubeType = common
visualizationMethod = direct
cormack = grade2a
tubeRoute = oral
tubeCuff = with

// Cálculo de número do tubo (totNumber) e fixação:
if age > 12:
  male:   totNumber = "7.5", fixation = "22"
  female: totNumber = "7.0", fixation = "21"
else if age >= 2:
  // Fórmula pediátrica (Cole modificada)
  tube = round_half((age / 4.0 + 3.5) * 2) / 2
  fixation = tube * 3  (arredondado)
else:
  // Neonato/lactente — baseado em peso
  weight < 1 kg  → tube = 2.5
  1 ≤ weight < 2 → tube = 3.0
  2 ≤ weight < 3.5 → tube = 3.0
  3.5 ≤ weight < 7 → tube = 3.5
  7 ≤ weight < 10 → tube = 3.5
  weight ≥ 10 → tube = 4.0
  fixation = tube * 3
```

### Raquianestesia

```
raquiPosition = seated
raquiNeedle = quincke

if age < 12:
  raquiLevel = L4
  raquiNeedleGauge = g27
else:
  raquiLevel = L3
  raquiNeedleGauge = g26
```

### Peridural

```
periduralPosition = seated
periduralLevel = L4
periduralNeedle = thuohy
periduralTechnique = dogliotti

if age < 12:
  periduralNeedleGauge = g22
else:
  periduralNeedleGauge = g18
```

### Sedação

```
sedationTechnique = minimal

if age < 12:
  sedationType = combined
else:
  sedationType = intravenous

intraVenousSedationType = intermitent
sedationOxygenSupply = cateterNasal
```

### Bloqueio Periférico

```
blockEquipment = usg
```

### Desfecho

```
standardEnd = true
destinationAnesthesia = rpa
endAnesthesia = noComplication
```

---

## Geração de texto narrativo

Cada seção gera um parágrafo de texto clínico em pt-BR. Os parágrafos são concatenados com `\n` para formar o `finalDescription`.

A ordem de geração das técnicas respeita a prioridade clínica:

```
1. Raquianestesia
2. Peridural
3. Bloqueio Periférico
4. Anestesia Local
5. Sedação
6. Anestesia Geral
```

Seções que não têm dados preenchidos geram string vazia e são ignoradas na concatenação.

### Texto — Monitorização

```
"Checklist de materiais de anestesia. Monitorização: {lista separada por vírgula}."
```

Mapeamento de campo → nome no texto:
```
electrocardioscopy    → "cardioscopia"
oximetry              → "oximetria"
nonInvasiveBloodPressure → "PANI"
capnography           → "capnografia"
invasiveBloodPressure → "PAI"
centralVenousPressure → "PVC"
thermometer           → "termômetro"
bis                   → "BIS"
tof                   → "TOF"
customMonitorings     → adicionados na ordem inserida
```

### Texto — Admissão

```
if age < 12:
  "Paciente pediátrico admitido em sala cirúrgica, {partes}."
else:
  "Paciente admitido em sala cirúrgica, {partes}."
```

Partes incluídas na ordem:
1. `airway.reportDisplayName`
2. `consciousness.reportDisplayName(for: age)`
3. `ventilatory.reportDisplayName`
4. `mechanicalVentilation.reportDisplayName`
5. `oxygenSupply.reportDisplayName`
6. `"FiO2 {Int(fiO2Fraction)}%"` (se fiO2Fraction não-nulo)
7. `hemodynamic.reportDisplayName`
8. `veinAccess.reportDisplayName(for: age)`
9. `veinGauge.reportDisplayName`

### Texto — Anestesia Geral

```
if tubeAcess == previouslyInserted:
  "Anestesia geral: {partes}, infusão de medicações descritas na seção de medicamentos."
else:
  "Anestesia geral: pré-oxigenação O2 100%, infusão de medicações descritas na seção de medicamentos, {partes}."
```

Partes na ordem:
1. `tubeAcess.reportDisplayName`
2. `equipment.reportDisplayName`
3. `visualizationMethod.reportDisplayName`
4. `cormack.reportDisplayName`
5. `tubeRoute.reportDisplayName`
6. `tubeType.reportDisplayName`
7. `"nº {totNumber}"`
8. `tubeCuff.reportDisplayName`
9. `"fixado a {fixation}cm da rima labial"`

### Texto — Raquianestesia

Partes inseridas na posição 1 (após a primeira parte ou no início):
```
partes[0] = raquiPosition
partes[1] = "assepsia e antissepsia de mãos e de dorso do paciente, punção única de espaço subaracnóide via paramediana"
partes[2] = raquiNeedle
partes[3] = raquiLevel
partes[4] = raquiNeedleGauge
```

Texto final:
```
"Raquianestesia: {partes}, LCR límpido, claro, sem presença de sangue, sem acidentes de punção. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores."
```

### Texto — Peridural

Partes na ordem:
1. `periduralPosition`
2. Inserido fixo: `"assepsia e antissepsia de mãos e de dorso do paciente, punção única de espaço peridural via paramediana"`
3. `periduralNeedle`
4. `periduralLevel`
5. `periduralLevel2` (se doublePeridural)
6. `periduralNeedleGauge`
7. `periduralTechnique`
8. `"insiro cateter peridural sem intercorrências, fixado na marca de: {periduralCateterFixation}cm da pele"` (se preenchido)

Texto final:
```
"Peridural: {partes}, sem presença de sangue e sem acidentes de punção. Após injeção de dose teste com adrenalina. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores."
```

### Texto — Sedação

Partes na ordem:
1. `sedationTechnique.reportDisplayName`
2. `sedationType.reportDisplayName`
3. `intraVenousSedationType.reportDisplayName`
4. `sedationOxygenSupply.reportDisplayName(for: age)`

Texto final:
```
"Sedoanalgesia: {partes}, infusão de medicações descritas na seção de medicamentos."
```

### Texto — Bloqueio Periférico

Partes na ordem:
1. `blockEquipment.reportDisplayName`
2. Todos os `mmssBlocks[].reportDisplayName`
3. Todos os `mmiiBlocks[].reportDisplayName`
4. Todos os `abdominalBlocks[].reportDisplayName`
5. `blockOthers` (texto livre)
6. `blockSide.DisplayName`

Texto final:
```
"Bloqueios de nervos periféricos: assepsia e antissepsia de mãos e do paciente {partes}, sem presença de sangue e sem acidentes de punção. Após injeção de dose teste com adrenalina. Infusão de medicações descritas na seção de medicações. Testo bloqueio com estímulos térmicos e motores."
```

### Texto — Anestesia Local

```
"Foi realizado anestesia local pela equipe cirúrgica. Procedimento sem intercorrências"
```

### Texto — Desfecho

Partes na ordem:
1. `"paciente com respiração espontânea, obedecendo comandos, boa mecânica ventilatória e oximetria estável"` (se `standardEnd == true`)
2. `destinationAnesthesia.reportDisplayName`
3. `endAnesthesia.reportDisplayName`
4. Cada item de `complications[]`

Texto final:
```
"Ao término da cirurgia {partes}."
```

---

## Fluxo de estado

```
[Sem entry]
     │
     ▼ (usuário toca "Adicionar")
[Cria AnesthesiaDescriptionEntry em memória]
     │
     ▼
[FormView aberto]
  ├── Seção Monitorização → toggle booleans + custom list
  ├── Seção Admissão      → pickers encadeados (com regras de visibilidade)
  ├── Seção Técnicas      → toggles principais → detail screens por técnica
  └── Seção Desfecho      → pickers + complicações livres
     │
     ▼ (ação "Sugerir Tudo")
[Aplica defaults inteligentes em todas as seções]
[Gera textos das 4 seções e concatena em finalDescription]
     │
     ▼ (ação "Salvar")
[Persiste entry no repositório]
     │
     ▼
[AnesthesiaDescriptionView exibe texto gerado]
```

O usuário pode editar o `finalDescription` diretamente (texto livre) após a geração automática. O texto editado é salvo em `veryEndDescriptionText` — que é o valor exibido na ficha final.

---

## Arquitetura recomendada para replicação

```
presentation/
├── description/
│   ├── DescriptionFormScreen          # tela principal (4 seções + toolbar)
│   ├── DescriptionSummaryScreen       # exibição do texto gerado
│   ├── monitoring/
│   │   ├── MonitoringSectionScreen
│   │   └── MonitoringSummaryCard
│   ├── admission/
│   │   ├── AdmissionSectionScreen
│   │   └── AdmissionSummaryCard
│   ├── techniques/
│   │   ├── TechniquesSectionScreen
│   │   ├── TechniquesSummaryCard
│   │   ├── GeneralAnesthesiaDetailScreen
│   │   ├── SpinalAnesthesiaDetailScreen
│   │   ├── PeriduralAnesthesiaDetailScreen
│   │   ├── SedationDetailScreen
│   │   └── PeripheralBlockDetailScreen
│   └── completion/
│       ├── CompletionSectionScreen
│       └── CompletionSummaryCard
│
domain/
├── model/
│   └── AnesthesiaDescriptionEntry
├── enums/
│   └── (todos os enums listados acima)
└── usecase/
    ├── LoadDescriptionUseCase
    ├── SaveDescriptionUseCase
    ├── DeleteDescriptionUseCase
    ├── ApplySuggestionsUseCase      # defaults por seção
    └── GenerateDescriptionTextUseCase  # geração dos parágrafos

data/
└── repository/
    └── AnesthesiaDescriptionRepository  # CRUD
```

### Contratos do repositório

```
interface AnesthesiaDescriptionRepository {
  get(anesthesiaId: String): AnesthesiaDescriptionEntry?
  create(entry: AnesthesiaDescriptionEntry, anesthesiaId: String): void
  update(entry: AnesthesiaDescriptionEntry, anesthesiaId: String): void
  delete(entryId: String): void
}
```

### Isolamento de estado por seção

Cada seção deve ter seu próprio objeto de estado isolado, carregado a partir do entry persistido e aplicado de volta ao salvar. Isso facilita edição parcial e navegação entre seções sem side effects.

```
MonitoringState { booleans + customList }
AdmissionState  { enums + fiO2 }
TechniquesState { toggle flags + details por técnica }
CompletionState { end flags + complications }
```

As regras de visibilidade condicional (descritas na seção "Regras de negócio") devem ser implementadas como efeitos reativos sobre mutations de estado — não como validações no momento de salvar.

---

## Notas de implementação

- `techOrder: [String]` guarda a ordem em que as técnicas foram habilitadas, para eventual ordenação do laudo. Não é obrigatório para funcionalidade básica.
- `raquiNivelOutro: String?` existe para nível vertebral não padronizado (texto livre). Exibir quando `raquiLevel == nil` ou como campo adicional.
- `complications: [String]` é uma lista aberta: o usuário digita livremente e adiciona items. Deduplicação case-insensitive é recomendada.
- `customMonitorings: [String]` segue o mesmo padrão.
- Os textos gerados são apenas uma sugestão inicial. O usuário deve poder editar o texto final livremente antes de salvar.
- `finalDescription` = texto concatenado gerado automaticamente. `veryEndDescriptionText` = versão após edição manual. A ficha final usa `veryEndDescriptionText ?? finalDescription`.
