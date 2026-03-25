# FichasAnestésicas — Overview

## 1. O que o app resolve

O app digitaliza e organiza o **fluxo completo de registros anestésicos cirúrgicos** para anestesiologistas brasileiros, eliminando fichas em papel e centralizando toda a documentação do ato anestésico em um único lugar.

### Fluxo coberto

| Etapa | O que registra |
|---|---|
| **Paciente** | Cadastro com CNS, dados demográficos, histórico cirúrgico |
| **Cirurgia** | Procedimento, hospital, cirurgião, convênio, códigos CBHPM |
| **Pré-anestesia** | Clearance, comorbidades, histórico, medicamentos em uso, alergias, avaliação de vias aéreas, exames |
| **Anestesia** | Técnica anestésica, medicamentos, sinais vitais, monitorização, intercorrências intraoperatórias |
| **SRPA** | Recuperação pós-anestésica: sinais vitais, medicamentos, intercorrências |
| **Financeiro** | Cobrança, glosas, status de pagamento, cálculo de impostos |
| **Dashboard** | Estatísticas clínicas e financeiras, tendências mensais |

---

## 2. Público-alvo

**Anestesiologistas** em prática privada e/ou hospitalar no Brasil.

- Suporta contexto **SUS** e **convênios privados**
- Multi-usuário: cada anestesiologista vê apenas seus próprios dados
- Uso individual por dispositivo (sem colaboração em tempo real)

---

## 3. Princípios

### Arquitetura
- **MVVM + Repository Pattern**: ViewModels separados por seção; repositórios abstratos com implementação SwiftData
- **SwiftUI declarativo**: 100% SwiftUI com estado gerenciado via `@Observable` / `@Bindable`
- **SwiftData**: ORM moderno da Apple como camada de persistência (substitui CoreData)

### Dados
- **Isolamento por usuário**: todas as queries filtradas por `currentUser.userId`
- **Armazenamento local**: dados ficam no dispositivo; backup/restore é manual via arquivo
- **Modelagem de domínio rica**: 50+ entidades SwiftData, 60+ enums médicos específicos (ASA, Mallampati, Cormack-Lehane, APFEL, etc.)

### UX
- Formulários longos divididos em seções com ViewModels dedicados por seção
- Detecção de pacientes duplicados via distância de Levenshtein (similaridade > 75%)
- Cópia rápida de dados entre pré-anestesia e anestesia via entidade `SharedPreAndAnesthesia`

---

## 4. Restrições importantes

| Restrição | Impacto |
|---|---|
| **iOS 17.1+ / macOS 14+** obrigatório | SwiftData não roda em versões anteriores |
| **Sem sincronização entre dispositivos** | Backup é manual; dados não seguem o usuário automaticamente |
| **Sem autenticação robusta** | Seleção de usuário simples, sem senha ou biometria |
| **Sem integração com HIS/PEP** | Nenhuma conexão com sistemas hospitalares externos |
| **Sem paginação nas listas** | Pode haver impacto de performance com grande volume de registros |
| **Idioma fixo em português** | UI hardcoded em pt-BR, sem internacionalização |
| **Financeiro manual** | Glosas e valores inseridos manualmente, sem adjudicação automática de convênios |
| **Sem audit log** | Alterações em registros não são rastreadas com histórico de versões |

---

## 5. Estrutura do projeto (resumo)

```
FichasAnestésicas/
├── Patients/           # Cadastro e listagem de pacientes
├── Surgery/            # Registro cirúrgico e códigos CBHPM
├── PreAnesthesia/      # Avaliação pré-anestésica
├── Anesthesia/         # Documentação intraoperatória
├── SRPA/               # Recuperação pós-anestésica
├── Financial/          # Cobrança e controle financeiro
├── Dashboard/          # Estatísticas clínicas e financeiras
├── User/               # Gerenciamento de usuários/anestesiologistas
├── Backup/             # Exportação e importação de dados
├── Models/             # Entidades SwiftData e enums de domínio
├── Repositories/       # Camada de acesso a dados (Repository Pattern)
└── Helpers/            # Componentes e utilitários compartilhados
```

---

## 6. Números do projeto

| Métrica | Valor aproximado |
|---|---|
| Linhas de código Swift | ~59.000 |
| Entidades SwiftData | 50+ |
| Enums de domínio médico | 60+ |
| Views SwiftUI | 100+ |
| ViewModels | 15+ |
| Repositórios | 14+ |
