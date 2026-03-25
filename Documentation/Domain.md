# FichasAnestésicas — Domain Model

## Entidades principais

### Hierarquia de relacionamentos

```
User (1) ──→ (Many) Patient
Patient (1) ──→ (Many) Surgery
Surgery (1) ──→ (1?) PreAnesthesia
Surgery (1) ──→ (1?) Anesthesia
Surgery (1) ──→ (1?) SRPA
Surgery (1) ──→ (1?) Financial
Surgery (1) ──→ (Many) CbhpmProcedure
Surgery (1) ──→ (1?) SharedPreAndAnesthesia

Anesthesia (1) ──→ (1?) AnesthesiaDescriptionEntry
Anesthesia (1) ──→ (Many) MedicationEntry
Anesthesia (1) ──→ (Many) VitalSignEntry

SRPA (1) ──→ (Many) SRPAMedicationEntry
SRPA (1) ──→ (Many) SRPAVitalSignEntry

PreAnesthesia (1) ──→ (Many) [Comorbidity Details]
PreAnesthesia (1) ──→ (1?) LaboratoryExams
```

---

## User

Representa o anestesiologista que cria e gerencia os registros.

| Campo | Tipo | Notas |
|---|---|---|
| `userId` | String (unique) | Identificador único |
| `name` | String | Nome completo |
| `crm` | String | Número do CRM |
| `rqe` | String? | Registro de Qualificação de Especialista |
| `phone` | String? | Telefone |
| `emailAddress` | String (unique) | E-mail único por usuário |
| `createdAt` | Date | |
| `updatedAt` | Date? | |

**Relacionamentos:**
- `createdPatients` → `[Patient]` (cascade delete)

---

## Patient

| Campo | Tipo | Notas |
|---|---|---|
| `patientId` | String (unique) | |
| `cns` | String | Cartão Nacional de Saúde |
| `name` | String | Nome completo |
| `birthDate` | Date | |
| `sex` | `Sex` | Armazenado como `sexRaw: String` |
| `createdBy` | User | |
| `updatedBy` | User? | |
| `createdAt` | Date | |
| `updatedAt` | Date? | |
| `lastActivityAt` | Date | |

**Relacionamentos:**
- `surgeries` → `[Surgery]` (cascade delete)

---

## Surgery

Entidade central que agrega todos os registros de um procedimento.

| Campo | Tipo | Notas |
|---|---|---|
| `surgeryId` | String (unique) | |
| `date` | Date | Data do procedimento |
| `status` | `Status` | `statusRaw: String` |
| `type` | `SurgeryType` | SUS ou convênio; `typeRaw: String` |
| `insuranceName` | String | Convênio/plano |
| `insuranceNumber` | String | Número da carteirinha |
| `mainSurgeon` | String | Cirurgião principal |
| `auxiliarySurgeons` | [String]? | Cirurgiões auxiliares |
| `hospital` | String | |
| `weight` | Double | Peso em kg (cálculo de doses pediátricas) |
| `proposedProcedure` | String | Procedimento proposto |
| `completeProcedure` | String? | Procedimento realizado |
| `start` | Date? | Início real |
| `end` | Date? | Término real |
| `createdBy` | User | |
| `updatedBy` | User? | |
| `createdAt` | Date | |
| `updatedAt` | Date? | |
| `lastActivityAt` | Date | |

**Relacionamentos (todos cascade delete):**
- `patient` → Patient
- `preanesthesia` → PreAnesthesia?
- `anesthesia` → Anesthesia?
- `srpa` → SRPA?
- `financial` → Financial?
- `shared` → SharedPreAndAnesthesia?
- `cbhpmProcedures` → [CbhpmProcedure]

---

## PreAnesthesia

Avaliação pré-anestésica completa.

### Clearance

| Campo | Tipo | Notas |
|---|---|---|
| `clearenceStatus` | `ClearenceStatus?` | Liberado / Liberado com ressalvas / Não Liberado |
| `definitiveRecommendationForRevaluationStatus` | `[RecommendationForRevaluationStatus]?` | |
| `futherRecommendationForRevaluation` | [String]? | Recomendações livres |

### Flags de comorbidades

| Campo | Tipo |
|---|---|
| `isPregnant` | Bool |
| `isInfant` | Bool |
| `healthyPatient` | Bool? |
| `cardiacComorbities` | Bool |
| `respiratoryComorbities` | Bool |
| `endocrineComorbities` | Bool |
| `gastrointestinalComorbities` | Bool |
| `hematologicalComorbities` | Bool |
| `imunologicalComorbities` | Bool? |
| `musculoskeletalComorbities` | Bool |
| `genitourologicalComorbities` | Bool |
| `gynecologicalComorbities` | Bool? |
| `androgenicalComorbities` | Bool? |
| `neurologicalComorbities` | Bool |
| `infectiousComorbities` | Bool? |
| `oncologicComorbities` | Bool? |
| `geneticSyndrome` | Bool |
| `surgeryHistory` | Bool? |
| `anesthesiaHistory` | Bool? |
| `hasAllergies` | Bool? |

### Detalhes de comorbidades (todos: `[Model]?`, cascade delete)

| Relacionamento | Tipo de detalhe |
|---|---|
| `cardiologyDetails` | `CardiologyComorbidityDetail` |
| `respiratoryDetails` | `RespiratoryComorbidityDetail` |
| `endocrineDetails` | `EndocrineComorbidityDetail` |
| `gastroIntestinalDetails` | `GastroIntestinalComorbidityDetail` |
| `hematologyDetails` | `HematologyComorbidityDetail` |
| `imunologyDetails` | `ImunologyComorbidityDetail` |
| `musculoskeletalDetails` | `MusculoskeletalComorbidityDetail` |
| `genitoUrinaryDetails` | `GenitoUrinaryComorbidityDetail` |
| `gynecologyDetails` | `GynecologicComorbityDetail` |
| `androgenyDetails` | `AndrogenicComorbityDetail` |
| `neurologyDetails` | `NeurologyComorbityDetail` |
| `infectiousDetails` | `InfectiousComorbityDetail` |
| `oncologyDetails` | `OncologyComorbidityDetail` |
| `geneticSyndromeDetails` | `GeneticSyndromeDetail` |
| `pregnancyDetails` | `PregnancyDetail` |
| `infantDetails` | `InfantDetail` |
| `surgeryHistoricDetails` | `SurgeryHistoryDetail` |
| `anesthesiaHistoricDetails` | `AnesthesiaHistoryDetail` |
| `difficultAirwayDetails` | `DifficultAirwayDetail` |

> Todos os modelos de detalhe seguem o protocolo `ComorbidityDetailProtocol`:
> `typeRaw: String?`, `customName: String?`, `notes: String?`, `displayName() -> String`

### Avaliação de vias aéreas e risco

| Campo | Tipo |
|---|---|
| `mallampatiClassification` | `MallampatiClassification?` |
| `apfelScoreDetails` | `[ApfelScore]?` |
| `socialHabitsAndEnvironmentDetails` | `[SocialHabitsAndEnvironment]?` |
| `socialHabitsAndEnvironmentDetailsText` | String? |

### Medicamentos e alergias

| Campo | Tipo |
|---|---|
| `dailyMedications` | `[DailyMedications]?` |
| `dailyMedicationsDetailsText` | String? |
| `dailyMedicationsCustomDetails` | [String]? |
| `allergiesMedicationsCustomDetails` | [String]? |

### Exames

| Campo | Tipo |
|---|---|
| `laboratoryExams` | `LaboratoryExams?` |
| `imagingExams` | `[ImagingExam]?` |
| `customImagingExams` | [String]? |
| `physicalExaminationDetailsText` | String? |

**LaboratoryExams** (struct):
`hemoglobin`, `hct`, `urea`, `creatinine`, `sodium`, `potassium`, `inr`, `glucose` — todos `Double?`

---

## Anesthesia

Registro intraoperatório completo.

| Campo | Tipo | Notas |
|---|---|---|
| `anesthesiaId` | String (unique) | |
| `anesthesiaTechniqueRaw` | [String] | `AnesthesiaTechniqueKind` |
| `positionRaw` | [String] | `Positioning` |
| `start` | Date? | |
| `end` | Date? | |
| `statusRaw` | String? | |

**Relacionamentos (cascade delete):**
- `anesthesiaDescription` → AnesthesiaDescriptionEntry?
- `medications` → [MedicationEntry]
- `vitalSigns` → [VitalSignEntry]
- `shared` → SharedPreAndAnesthesia?

### AnesthesiaDescriptionEntry

Registro detalhado das decisões clínicas durante o ato anestésico.

**Monitorização:**

| Campo | Tipo |
|---|---|
| `electrocardioscopy` | Bool |
| `oximetry` | Bool |
| `nonInvasiveBloodPressure` | Bool |
| `capnography` | Bool |
| `invasiveBloodPlessure` | Bool |
| `centralVenousPressure` | Bool |
| `thermometer` | Bool |
| `bis` | Bool |
| `tof` | Bool |
| `customMonitorings` | [String] |

**Admissão:**

| Campo | Tipo |
|---|---|
| `airway` | `AirwayKind?` |
| `consciousness` | `ConsciousnessKind?` |
| `ventilatory` | `VentilationMode?` |
| `mechanicalVentilation` | `MechanicalVentilationMode?` |
| `oxygenSupply` | `OxygenSupply?` |
| `fiO2Fraction` | Double? |
| `hemodynamic` | `HemodynamicKind?` |
| `veinAccess` | `VeinAccessKind?` |
| `veinGauge` | `VeinGaugeKind?` |

**Anestesia geral:**

| Campo | Tipo |
|---|---|
| `visualizationMethod` | `VisualizationMethod?` |
| `equipment` | `LaringoschopyEquipment?` |
| `tubeType` | `TubeType?` |
| `tubeAcess` | `TubeAcess?` |
| `tubeCuff` | `TubeCuff?` |
| `tubeRoute` | `TubeRoute?` |
| `totNumber` | String? |
| `cormack` | `CormackLehane?` |
| `fixation` | String? |

**Raquianestesia:**

| Campo | Tipo |
|---|---|
| `raquiPosition` | `SpinalAndEpiduralPosition?` |
| `raquiLevel` | `SpinalAndEpiduralLevel?` |
| `raquiNivelOutro` | String? |
| `raquiNeedle` | `SpinalAndEpiduralNeedle?` |
| `raquiNeedleGauge` | `SpinalAndEpiduralGaugeKind?` |

**Peridural:**

| Campo | Tipo |
|---|---|
| `periduralPosition` | `SpinalAndEpiduralPosition?` |
| `doublePeridural` | Bool? |
| `periduralLevel` | `SpinalAndEpiduralLevel?` |
| `periduralLevel2` | `SpinalAndEpiduralLevel?` |
| `periduralNeedle` | `SpinalAndEpiduralNeedle?` |
| `periduralNeedleGauge` | `SpinalAndEpiduralGaugeKind?` |
| `periduralTechnique` | `PeriduralTechniqueKind?` |
| `periduralCateterFixation` | String? |

**Sedação:**

| Campo | Tipo |
|---|---|
| `sedationTechnique` | `SedationTechniqueKind?` |
| `sedationType` | `SedationType?` |
| `intraVenousSedationType` | `IntraVenousSedationType?` |
| `sedationOxygenSupply` | `SedationOxygenSupplyKind?` |

**Bloqueio periférico:**

| Campo | Tipo |
|---|---|
| `blockEquipment` | `BlockEquipmentKind?` |
| `mmssTechnique` | `MMSSTechnique?` |
| `mmiiTechnique` | `MMIITechnique?` |
| `abdominalToraxTechnique` | `AbdominalToraxTechnique?` |
| `blockSide` | `BlockSide?` |
| `blockOthers` | String? |

**Desfecho:**

| Campo | Tipo |
|---|---|
| `standardEnd` | Bool |
| `destinationAnesthesia` | `DestinationAnesthesia?` |
| `endAnesthesia` | `EndAnesthesia?` |
| `complications` | [String]? |
| `adverseEvolution` | String? |
| `finalDescription` | String? |

### MedicationEntry

| Campo | Tipo |
|---|---|
| `medicationId` | String (unique) |
| `name` | String |
| `category` | `MedicationCategory` |
| `via` | `AdministrationRoute` |
| `dose` | String |
| `timestamp` | Date |

### VitalSignEntry

| Campo | Tipo | Significado |
|---|---|---|
| `timestamp` | Date | |
| `pam` | Double? | Pressão Arterial Média |
| `fc` | Double? | Frequência Cardíaca |
| `paS` | Double? | Pressão Arterial Sistólica |
| `paD` | Double? | Pressão Arterial Diastólica |
| `rhythm` | String? | Ritmo cardíaco |
| `spo2` | Double? | Saturação de O₂ |
| `fio2` | Double? | FiO₂ |
| `etco2` | Double? | EtCO₂ |
| `peep` | Double? | PEEP |
| `volumeCorrente` | Double? | Volume corrente |
| `bis` | Double? | Índice Bispectral |
| `tof` | Double? | Train-of-Four |
| `pvc` | Double? | Pressão Venosa Central |
| `debitCardiaco` | Double? | Débito cardíaco |
| `glicemia` | Double? | Glicemia |
| `lactato` | Double? | Lactato |
| `temperatura` | Double? | Temperatura |
| `diurese` | Double? | Diurese |
| `sangramento` | Double? | Sangramento |

---

## SRPA

Registro da Sala de Recuperação Pós-Anestésica.

| Campo | Tipo |
|---|---|
| `srpaId` | String (unique) |
| `start` | Date? |
| `end` | Date? |
| `statusRaw` | String? |
| `descriptionText` | String? |

**Relacionamentos (cascade delete):**
- `medications` → [SRPAMedicationEntry]
- `vitalSigns` → [SRPAVitalSignEntry]

> `SRPAMedicationEntry` e `SRPAVitalSignEntry` são estruturalmente idênticos a `MedicationEntry` e `VitalSignEntry`.

---

## Financial

| Campo | Tipo | Notas |
|---|---|---|
| `valueAnesthesia` | Double? | Valor anestesia |
| `valuePreAnesthesia` | Double? | Valor pré-anestesia |
| `finalSurgeryValue` | Double? | Valor total |
| `glosaAnesthesia` | Bool? | Glosa da anestesia |
| `glosaPreanesthesia` | Bool? | Glosa da pré |
| `glosedAnesthesiaValue` | Double? | Valor glosado — anestesia |
| `glosedPreAnesthesiaValue` | Double? | Valor glosado — pré |
| `paid` | Bool | Pago |
| `paymentDate` | Date? | |
| `billingDate` | Date? | |
| `taxedValue` | Double? | Valor líquido |
| `taxPercentage` | Double? | Alíquota de imposto |
| `notes` | String? | |

---

## SharedPreAndAnesthesia

Configuração compartilhada entre pré-anestesia e anestesia para evitar reentrada de dados.

| Campo | Tipo |
|---|---|
| `techniqueRaw` | [String] → `AnesthesiaTechniqueKind` |
| `asaRaw` | String? → `ASAClassification` |
| `mmssBlocksRaw` | [String]? → `MMSSTechnique` |
| `mmiiBlocksRaw` | [String]? → `MMIITechnique` |
| `abdominalBlocksRaw` | [String]? → `AbdominalToraxTechnique` |

---

## CbhpmProcedure

| Campo | Tipo |
|---|---|
| `cbhpmId` | String (unique) |
| `code` | String |
| `procedure` | String |
| `port` | String |

---

## Enums de domínio

### Status geral

```swift
Status: scheduled | inProgress | finished | cancelled | notNecessary
Sex: male | female
SurgeryType: sus | convenio
```

### Técnicas anestésicas

```swift
AnesthesiaTechniqueKind:
  geralBalanceada | geralVenosaTotal | geralInalatoria
  raquianestesia | peridural | sedacao
  bloqueioPeriferico | anestesiaLocal
```

### Posicionamento cirúrgico

```swift
Positioning:
  decubitoDorsal | decubitoVentral
  decubitoLateralDireito | decubitoLateralEsquerdo
  trendelenburg | proclive | canivete | litotomia | cadeiraDePraia
```

### Vias aéreas

```swift
AirwayKind:
  noDevice | compromised | oropharyngealGuedel
  nasopharyngeal | lma | endotrachealTube | tracheostomy

ConsciousnessKind:
  alert | drowsy | lethargic | responsiveToPain | unresponsive | sedated

MallampatiClassification: I | II | III | IV
CormackLehane: grade1 | grade2a | grade2b | grade3 | grade4
```

### Ventilação

```swift
VentilationMode: spontaneous | invasiveMechanicalVentilation | nonInvasiveMechanicalVentilation
MechanicalVentilationMode: CPAP | BiPAP | VCV | PCV | SIMV | PSV
OxygenSupply: ambientAir | nasalCateter | venturiMask | nonReinalantMask
```

### Acesso vascular

```swift
HemodynamicKind: stable | unstable | compensated | unstableDespiteDrugs
VeinAccessKind: none | inOpRoom | previouslyInserted
VeinGaugeKind: g14 | g18 | g20 | g22 | g24 | cdl
```

### Intubação

```swift
VisualizationMethod: direct | indirect
LaringoschopyEquipment: laringoscope | fibroscope | mirrorGarcia | videoLaryngoscope
TubeType: common | aramado | doubleLumen | eNasal | traqueal
TubeRoute: nasal | oral
TubeCuff: with | without
```

### Raqui / Peridural

```swift
SpinalAndEpiduralPosition: seated | lateralDecubitus
SpinalAndEpiduralLevel: T1–T12, L1–L5, sacral, coccyx
SpinalAndEpiduralNeedle: whitacre | quincke | thuohy | thuohysoho | caudal
SpinalAndEpiduralGaugeKind: g16 … g27
PeriduralTechniqueKind: dogliotti | gutierrez
```

### Sedação

```swift
SedationTechniqueKind: minimal | moderate | deep
SedationType: intravenous | inalatory | combined
IntraVenousSedationType: tiva | intermitent
SedationOxygenSupplyKind: cateterNasal | facialMask
```

### Bloqueios periféricos

```swift
BlockEquipmentKind: usg | usgAndNeuralStimulation | neuralStimulationOnly | landmarks
BlockSide: left | right | bilateral

MMSSTechnique (MMSS): interescalenical | supraclavian | subclavian | axilar
MMIITechnique (MMII): femoral | adutor | sciatic_gluteal | sciatic_poplitean
AbdominalToraxTechnique: tap | quadrado_lombar | pecs1 | pecs2 | serratus | paravertebral | ilioinguinal
```

### Desfecho

```swift
DestinationAnesthesia: rpa | uti
EndAnesthesia: noComplication | complication
```

### Pré-anestesia — clearance

```swift
ClearenceStatus: able | reevaluate | unable

RecommendationForRevaluationStatus:
  posIntensiveUnitCare | posIAMEnzimes | dialisesPre
  asmaControl | IVASevaluation | labsImgRevaluation | adaptedFasting
```

### Classificações de risco

```swift
ASAClassification: I | II | III | IV | V | VI | Ie | IIe | IIIe | IVe | Ve

ApfelScore (NVPO): tobaccoUse | femaleSex | historyPONV | historyMotionSickness | postoperativeOpioids

MallampatiClassification: I | II | III | IV
DifficultAirwayEvaluation: previousHistory | anatomy | tyromentonian | esternalmentonian
  | interIncisive | neckMobility | obesity | noTeeth | traqueo
```

### Medicamentos

```swift
MedicationCategory (30 categorias):
  hipnotico | anestesicoInalatório | anestésicoLocal | opioide
  bloqueadorNeuromuscular | benzodiazepínico | alfa2Agonista | neuroléptico
  vasopressor | inotrópico | hipotensor | betabloqueador
  analgésico | aine | antiemético | corticoide | antibiótico
  anticonvulsivante | antiarritmico | reversor | colinérgico | anticolinérgico
  beta2Agonista | hidroeletrolítico | cristalóide | hemoderivados
  antialérgico | gasFresco | hormonal | naoPadronizado

AdministrationRoute: EV | IM | IT | PD | PN | SC | SL | IN | TOP | VO | VR
```

### Hábitos sociais

```swift
SocialHabitsAndEnvironment:
  alcoholConsumption | drugUse | tobaccoUse | tobaccoExposure
  | sedentaryLifestyle | airPollutionExposure

DailyMedications:
  antiDiabetes | antiHypertension | antiCholesterol | imunossupressor
  | anticoncepcional | antiConvulsant | antiInflammatory | antiCoagulant
```

### Histórico

```swift
SurgeryHistorySpeciality (11 especialidades):
  general | orthopedics | cardiac | neurosurgery | urology
  | gynecology | dentistry | ophthalmology | headNeck | oncology | thorax

AnesthesiaComplicationsHistory (10 complicações):
  nauseaVomiting | laryngospasm | bronchospasm | cardiacArrest
  | neuropraxia | allergicReaction | postspinalHeadache
  | difficultIntubation | shivering | bronchoaspiration
```

### Exames de imagem

```swift
ImagingExamType: chestXRay | ecg | echocardiogram

ChestXRayFinding: normal | cardiomegaly | pulmonaryHypervascularization | infiltrate | pleuralEffusion | atelectasis
ecgFinding: normal | sinusRhythm | atrialFibrillation | rightBundleBranchBlock | BAVT
echocardiogramFinding: normal | mitralInsufficiency | aorticInsufficiency | mitralStenosis | aorticStenosis | lowEjectionFraction
```

---

## Padrões de implementação

| Padrão | Descrição |
|---|---|
| **Enum como raw String** | Todos os enums são persistidos como `String` no SwiftData; propriedades computadas provêm acesso type-safe |
| **Cascade delete** | Registros filhos (medicamentos, sinais vitais, comorbidades) são deletados automaticamente com o pai |
| **Audit trail** | Todas as entidades principais têm `createdAt`, `updatedAt`, `createdBy`, `updatedBy` |
| **Optionals extensivos** | Campos médicos são opcionais para suportar avaliações parciais |
| **Dose como String** | Doses são armazenadas como texto livre para preservar a formatação clínica (ex: "100mg", "2mcg/kg") |
| **Shared entity** | `SharedPreAndAnesthesia` evita reentrada de dados entre pré-anestesia e anestesia |
