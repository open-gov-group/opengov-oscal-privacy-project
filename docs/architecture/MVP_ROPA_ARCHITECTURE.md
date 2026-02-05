# RoPa MVP Architektur - Privacy App Ecosystem

**Version**: 1.0.0
**Stand**: 2026-02-05
**Team**: RoPa (Record of Processing Activities)
**Status**: MVP Live

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [Komponenten](#2-komponenten)
3. [Datenfluss](#3-datenfluss)
4. [API Gateway](#4-api-gateway)
5. [Mapping Engine](#5-mapping-engine)
6. [Wiederverwendung durch andere Teams](#6-wiederverwendung-durch-andere-teams)
7. [Technologie-Stack](#7-technologie-stack)
8. [Deployment](#8-deployment)

---

## 1. Übersicht

Das **RoPa MVP** ist ein modulares OSCAL-basiertes Privacy-Compliance-System bestehend aus 4 Komponenten:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         RoPa MVP ARCHITEKTUR                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                      opengov-privacy-app                            │   │
│   │                      (React Frontend)                               │   │
│   │                                                                     │   │
│   │   • RoPA Manager (Verarbeitungsverzeichnis)                         │   │
│   │   • SSP Editor (System Security Plan)                               │   │
│   │   • Evidence Management (Nachweise)                                 │   │
│   │   • POA&M Viewer (Maßnahmenplan)                                    │   │
│   │                                                                     │   │
│   │   Live: https://open-gov-group.github.io/opengov-privacy-app        │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │ REST API                                 │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    opengov-privacy-gateway                          │   │
│   │                   (Cloudflare Workers API)                          │   │
│   │                                                                     │   │
│   │   Endpoints:                                                        │   │
│   │   • /api/tenants/:orgId/ropa     (RoPA Directory)                   │   │
│   │   • /api/ropa/preview            (XDOMEA Import)                    │   │
│   │   • /api/templates/ssp           (SSP Template)                     │   │
│   │   • /api/tenants/:orgId/save     (Git Commit)                       │   │
│   │                                                                     │   │
│   │   [SHARED SERVICE - nutzbar durch andere Teams]                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │                                          │
│              ┌───────────────────┴───────────────────┐                      │
│              │                                       │                      │
│              ▼                                       ▼                      │
│   ┌─────────────────────────┐         ┌─────────────────────────────────┐   │
│   │ opengov-privacy-data    │         │ opengov-privacy-mappings        │   │
│   │ (Git-based Persistence) │         │ (Transformation Engine)         │   │
│   │                         │         │                                 │   │
│   │ tenants/                │         │ • xDOMEA Parser                 │   │
│   │  └─ <org-id>/           │         │ • BPMN Parser                   │   │
│   │     ├─ ropa.json        │         │ • CIM (Canonical Model)         │   │
│   │     └─ procedures/      │         │ • OSCAL Writer                  │   │
│   │        └─ ssp.json      │         │ • YAML Rules Engine             │   │
│   │                         │         │                                 │   │
│   │                         │         │ [SHARED LIB - nutzbar durch     │   │
│   │                         │         │  andere Teams]                  │   │
│   └─────────────────────────┘         └─────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.1 Repositories

| Repository | Zweck | Status | URL |
|------------|-------|--------|-----|
| **opengov-privacy-app** | React Frontend (RoPA Manager, SSP Editor) | MVP Live | [GitHub](https://github.com/open-gov-group/opengov-privacy-app) |
| **opengov-privacy-data** | Git-basierte Persistenz (OSCAL JSON) | In Betrieb | [GitHub](https://github.com/open-gov-group/opengov-privacy-data) |
| **opengov-privacy-gateway** | Serverless REST API | Development | [GitHub](https://github.com/open-gov-group/opengov-privacy-gateway) |
| **opengov-privacy-mappings** | xDOMEA/BPMN → OSCAL Transformation | Aktiv | [GitHub](https://github.com/open-gov-group/opengov-privacy-mappings) |

---

## 2. Komponenten

### 2.1 Privacy App (Frontend)

```
opengov-privacy-app/
├── ui/                          # React + Vite
│   ├── src/
│   │   ├── pages/
│   │   │   ├── RopaDirectory.jsx   # Verarbeitungsverzeichnis
│   │   │   ├── SspEditor.jsx       # SSP/POA&M Editor
│   │   │   └── TenantSetup.jsx     # Organisation einrichten
│   │   ├── lib/
│   │   │   ├── mapper.js           # YAML-basierte SSP Transformation
│   │   │   ├── evidence.js         # Back-Matter Management
│   │   │   └── contract.js         # SSP Validierung
│   │   └── components/ui/          # Radix UI Components
│   └── vite.config.js
│
└── api/                         # Express.js Backend
    └── server.mjs               # Port 8787
```

**Features:**

| Feature | Beschreibung |
|---------|--------------|
| **RoPA Manager** | Import XDOMEA XML, Liste Verarbeitungstätigkeiten, SSP-Referenzen |
| **SSP Editor** | OSCAL 1.1.2 SSP bearbeiten, Profile wechseln, Controls implementieren |
| **Evidence Management** | Nachweise (back-matter) hinzufügen, Hashes validieren |
| **POA&M Viewer** | Risiko-Bewertung, Maßnahmenplanung |

### 2.2 Privacy Data (Persistenz)

```
opengov-privacy-data/data/
└── tenants/
    └── <org-id>/                    # z.B. EU-DE-NRW-40213-...
        ├── ropa.json                # RoPA Index
        │   {
        │     "id": "org-id",
        │     "title": "Organisation",
        │     "processes": [...]
        │   }
        │
        ├── procedures/
        │   └── <procedure-id>/
        │       ├── ssp.json         # OSCAL SSP (1.1.2)
        │       └── poam.json        # Plan of Action & Milestones
        │
        └── profiles/
            └── resolved/
                └── *.json           # Mandanten-Profile
```

**Governance:**
- Jede Änderung = Pull Request
- Schema-Validierung vor Merge
- Volle Git-Historie (Audit Trail)
- Mandanten-Isolation über Verzeichnisstruktur

### 2.3 Privacy Gateway (API)

```
opengov-privacy-gateway/workers/
├── wrangler.toml                # Cloudflare Config
├── src/
│   ├── main.mjs                 # Entry + CORS
│   └── router.mjs               # Routing
├── handlers/
│   └── ropa.mjs                 # RoPA Endpoints
└── libs/
    ├── secure.mjs               # API Key / JWT
    ├── tenant.mjs               # Git Operations
    └── mapping.mjs              # xDOMEA Parsing
```

### 2.4 Privacy Mappings (Transformation)

```
opengov-privacy-mappings/
├── src/
│   ├── adapters/
│   │   ├── xdomea-xml.ts        # xDOMEA Parser
│   │   └── bpmn-xml.ts          # BPMN 2.0 Parser
│   ├── core/
│   │   ├── merge.ts             # Quellen → CIM
│   │   ├── normalize.ts         # Normalisierung
│   │   ├── yaml-runner.ts       # Rules Engine
│   │   └── oscal.ts             # CIM → OSCAL SSP
│   ├── rules/
│   │   ├── xdomea_to_cim.yaml   # xDOMEA Regeln
│   │   └── bpmn_to_cim.yaml     # BPMN Regeln
│   └── normalize/registry/
│       ├── legal-basis.yaml     # Rechtsgrundlagen
│       └── data-categories.yaml # Datenkategorien
└── cli/index.ts                 # CLI Tool
```

---

## 3. Datenfluss

### 3.1 XDOMEA Import → RoPA

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DATENFLUSS: XDOMEA → ROPA                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. XDOMEA XML                                                             │
│      (Aktenplan aus Fachverfahren)                                          │
│      └─> <Aktenplan>                                                        │
│            <Bezeichnung>02.02 - Melderegister</Bezeichnung>                 │
│            <Beschreibung>Führung Einwohnermelderegister</Beschreibung>      │
│          </Aktenplan>                                                       │
│                                  │                                          │
│                                  ▼                                          │
│   2. PARSER (xdomea-xml.ts)                                                 │
│      └─> { aktenplaene: [{ bezeichnung, beschreibung }] }                   │
│                                  │                                          │
│                                  ▼                                          │
│   3. CIM (Canonical Information Model)                                      │
│      └─> {                                                                  │
│            context: { aktenplan_positions: ["02.02"] },                     │
│            process: {                                                       │
│              title: "Melderegister",                                        │
│              purpose: [...],                                                │
│              legal_basis: ["Art. 6 Abs. 1 lit. c DSGVO"]                    │
│            }                                                                │
│          }                                                                  │
│                                  │                                          │
│                                  ▼                                          │
│   4. OSCAL SSP (oscal.ts)                                                   │
│      └─> {                                                                  │
│            "system-security-plan": {                                        │
│              "metadata": { "title": "Melderegister" },                      │
│              "system-characteristics": {...},                               │
│              "control-implementation": {...}                                │
│            }                                                                │
│          }                                                                  │
│                                  │                                          │
│                                  ▼                                          │
│   5. opengov-privacy-data                                                   │
│      └─> tenants/<org>/procedures/<id>/ssp.json                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 SSP Bearbeiten → Git Commit

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    WORKFLOW: SSP BEARBEITUNG                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. User lädt SSP Editor                                                   │
│      └─> GET /api/tenants/:orgId/procedures/:id/ssp                         │
│                                                                             │
│   2. User bearbeitet:                                                       │
│      • system-characteristics (Infotypen, Kategorisierung)                  │
│      • system-implementation (Komponenten, Services)                        │
│      • control-implementation (Statement je Control)                        │
│      • back-matter (Evidence Resources)                                     │
│                                                                             │
│   3. User speichert (Draft)                                                 │
│      └─> PUT /api/tenants/:orgId/save?ref=feature/edit-123                  │
│          ├─ Gateway erstellt Branch                                         │
│          ├─ Commit mit Änderungen                                           │
│          └─> Returns: { prUrl: "https://github.com/.../pull/456" }          │
│                                                                             │
│   4. Review & Merge                                                         │
│      └─> POST /api/tenants/:orgId/merge?ref=feature/edit-123&base=main      │
│          └─ Gateway merged PR                                               │
│                                                                             │
│   5. SSP in Production                                                      │
│      └─> tenants/<org>/procedures/<id>/ssp.json (main branch)               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 4. API Gateway

### 4.1 Endpoints

| Endpoint | Methode | Beschreibung | Auth |
|----------|---------|--------------|------|
| `/api/healthz` | GET | Health Check | - |
| `/api/templates/ssp` | GET | SSP Template generieren | - |
| `/api/tenants/:orgId` | GET | Mandant lesen | - |
| `/api/tenants/:orgId/init` | POST | Mandant anlegen | API Key |
| `/api/tenants/:orgId/ropa` | GET | RoPA Directory laden | - |
| `/api/ropa/preview` | GET | XDOMEA Preview | - |
| `/api/tenants/:orgId/bundles` | POST | Neuen SSP Bundle erstellen | API Key |
| `/api/tenants/:orgId/save` | PUT | Änderungen speichern (Branch) | API Key |
| `/api/tenants/:orgId/merge` | POST | Branch mergen | API Key |

### 4.2 Authentifizierung

```javascript
// API Key Validierung
Authorization: Bearer <APP_API_KEY>
// oder
X-API-Key: <APP_API_KEY>

// Optional: JWT
{
  "iss": "open-privacy-api",
  "aud": "opengov-privacy-ui",
  "alg": "HS256"
}
```

### 4.3 Konfiguration (wrangler.toml)

```toml
[env.staging]
MODE = "mock-no-auth"
MOCK_BASE = "https://raw.githubusercontent.com/open-gov-group/opengov-privacy-mappings/main/build"

[env.production]
MODE = "prod"
DATA_OWNER = "open-gov-group"
DATA_REPO = "opengov-privacy-data"
```

---

## 5. Mapping Engine

### 5.1 Dreischicht-Transformation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MAPPING ENGINE ARCHITEKTUR                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   LAYER 1: PARSERS (Adapters)                                               │
│   ══════════════════════════                                                │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                        │
│   │  xDOMEA     │  │   BPMN      │  │   Vendor    │                        │
│   │  Parser     │  │   Parser    │  │   Adapter   │                        │
│   │             │  │             │  │   (future)  │                        │
│   │  XML → TS   │  │  XML → TS   │  │  JSON → TS  │                        │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘                        │
│          │                │                │                                │
│          └────────────────┼────────────────┘                                │
│                           ▼                                                 │
│   LAYER 2: RULES ENGINE (Normalisierung)                                    │
│   ══════════════════════════════════════                                    │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         CIM                                         │   │
│   │                (Canonical Information Model)                        │   │
│   │                                                                     │   │
│   │   {                                                                 │   │
│   │     context: { aktenplan_positions, authority },                    │   │
│   │     process: { title, purpose, legal_basis, data_categories },      │   │
│   │     architecture: { components: [...] },                            │   │
│   │     evidence: [...]                                                 │   │
│   │   }                                                                 │   │
│   │                                                                     │   │
│   │   Transformation via YAML Rules:                                    │   │
│   │   • xdomea_to_cim.yaml                                              │   │
│   │   • bpmn_to_cim.yaml                                                │   │
│   │   • normalize via Registry (legal-basis, data-categories)           │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  ▼                                          │
│   LAYER 3: WRITER (OSCAL Generation)                                        │
│   ═══════════════════════════════════                                       │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                      OSCAL SSP Writer                               │   │
│   │                                                                     │   │
│   │   CIM → OSCAL 1.1.2 SSP                                             │   │
│   │   • system-characteristics                                          │   │
│   │   • system-implementation                                           │   │
│   │   • control-implementation                                          │   │
│   │   • back-matter                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.2 YAML Rules Beispiel

```yaml
# xdomea_to_cim.yaml
rules:
  - target: "process.purpose[]"
    source:
      - "xdomea://VVT/Process/Purpose"
      - "bpmn://process.documentation"
    normalize:
      - trim
      - uniq
    fallback: []

  - target: "process.legal_basis"
    source: ["bpmn://process.documentation"]
    normalize:
      - extract: legal-basis
      - map: legal-basis-registry.yaml
```

### 5.3 Registries (Normalisierung)

```yaml
# legal-basis-registry.yaml
- input: "Art. 6"
  canonical: "LEX:EU:REG:GDPR:20160525:ART:6:ABS:1"

- input: "customer consent"
  canonical: "LEX:EU:REG:GDPR:20160525:ART:6:ABS:1:LIT:A"

- input: "contract"
  canonical: "LEX:EU:REG:GDPR:20160525:ART:6:ABS:1:LIT:B"
```

### 5.4 CLI Nutzung

```bash
# xDOMEA + BPMN → CIM
node dist/cli/index.js to-cim \
  --xdomea examples/xdomea_valid.xml \
  --bpmn examples/bpmn_emr.bpmn \
  --rules-xdomea src/rules/xdomea_to_cim.yaml \
  --out build/cim.json

# CIM → OSCAL SSP
node dist/cli/index.js cim-to-ssp \
  --cim build/cim.json \
  --profile https://.../profile_intervenability.json \
  --out build/ssp.json
```

---

## 6. Wiederverwendung durch andere Teams

### 6.1 Gateway als Shared Service

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SHARED GATEWAY ARCHITEKTUR                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Clients:                                                                  │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│   │ Privacy App │  │  Workbench  │  │   Viewer    │  │   External  │       │
│   │ (RoPa MVP)  │  │  (Team WB)  │  │  (Team VW)  │  │   Tools     │       │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘       │
│          │                │                │                │               │
│          └────────────────┴────────────────┴────────────────┘               │
│                                  │                                          │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    opengov-privacy-gateway                          │   │
│   │                      (Shared Service)                               │   │
│   │                                                                     │   │
│   │   /api/ropa/*          → RoPA Manager (RoPa)                        │   │
│   │   /api/tenants/*       → Multi-Tenant Support (alle)                │   │
│   │   /api/catalogs/*      → Katalog-Zugriff (alle)                     │   │
│   │   /api/mappings/*      → Mapping Service (alle)                     │   │
│   │   /api/validate/*      → Schema-Validierung (alle)                  │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Mappings als NPM Library

```bash
# Installation
npm install @opengov/privacy-mappings

# Nutzung
import { cimToSSP, parseXdomea, parseBpmn } from '@opengov/privacy-mappings';

const xdomea = parseXdomea(xmlString);
const cim = merge({ xdomea });
const ssp = cimToSSP(cim, { profile: 'intervenability' });
```

### 6.3 Erweiterungspunkte

| Komponente | Erweiterung | Beispiel |
|------------|-------------|----------|
| **Parsers** | Neuer Adapter in `adapters/` | `iso27001-xml.ts`, `nist-csv.ts` |
| **Rules** | Neue YAML-Regeldatei | `iso27001_to_cim.yaml` |
| **Registries** | Neue Normalisierungs-Registry | `bsi-controls-registry.yaml` |
| **Writers** | Neuer Output-Writer | `CimToISO27001()` |
| **Gateway Handlers** | Neuer Route Handler | `iso27001.mjs`, `bsi.mjs` |

### 6.4 Use Cases für andere Teams

| Team | Use Case | Gateway Endpoint | Mapping |
|------|----------|------------------|---------|
| **Workbench** | SDM-Katalog laden | `/api/catalogs/sdm` | - |
| **Workbench** | Mapping verwalten | `/api/mappings/sdm-to-resilience` | YAML Rules |
| **Viewer** | Katalog-Darstellung | `/api/catalogs/privacy` | - |
| **Viewer** | Control-Details | `/api/controls/:id` | - |
| **Externe Tools** | XDOMEA Import | `/api/ropa/preview` | xdomea-xml.ts |
| **Externe Tools** | BSI Mapping | `/api/mappings/bsi` | bsi_to_cim.yaml |

---

## 7. Technologie-Stack

| Layer | Technologie | Version | Zweck |
|-------|-------------|---------|-------|
| **Frontend** | React | 18.3.1 | UI Framework |
| | Vite | 5.4.0 | Build Tool |
| | Tailwind CSS | 3.4.14 | Styling |
| | Radix UI | 1.0+ | Accessible Components |
| | React Router | 6.28.0 | Routing |
| **Backend API** | Express.js | 4.21.1 | App Server |
| **Gateway** | Cloudflare Workers | 2024-11-01 | Serverless |
| | Wrangler | (latest) | Deployment |
| **Persistence** | Git (GitHub) | - | Version Control |
| | JSON | OSCAL 1.1.2 | Datenformat |
| **Mapping** | TypeScript | 5.6.3 | Engine |
| | YAML | 2.6.0 | Rules |
| | fast-xml-parser | 4.4.1 | XML Parsing |
| | AJV | 8.17.1 | Schema Validation |
| | Vitest | 2.1.3 | Testing |

---

## 8. Deployment

### 8.1 Frontend (GitHub Pages)

```
URL: https://open-gov-group.github.io/opengov-privacy-app/
Deployment: Automatisch bei Push auf main
Base Path: /opengov-privacy-app/
```

### 8.2 Gateway (Cloudflare Workers)

```
Environments:
├── Staging: mock-no-auth (Demo-Modus)
└── Production: prod (echte Git-Integration)

Secrets:
├── GH_TOKEN_DATA    (GitHub Token für Data Repo)
├── APP_API_KEY      (API Key für geschützte Endpoints)
└── JWT_SECRET       (Optional: JWT Signing)
```

### 8.3 Data Repository

```
GitHub: opengov-privacy-data
Branch Protection: main (PR required)
Validation: GitHub Actions (OSCAL Schema Check)
```

---

## 9. Nächste Schritte

### 9.1 Kurzfristig
- [ ] Gateway für andere Teams dokumentieren (OpenAPI Spec)
- [ ] Mapping Library als NPM Paket veröffentlichen
- [ ] API Key Management für Multi-Team Nutzung

### 9.2 Mittelfristig
- [ ] Neue Mappings: ISO 27001, BSI IT-Grundschutz
- [ ] Real-time Collaboration im SSP Editor
- [ ] Dashboard für Compliance-Status

### 9.3 Langfristig
- [ ] Mobile PWA für Feld-Assessments
- [ ] Automatisierte DPIA-Generierung
- [ ] Integration mit Beschaffungsportalen

---

## 10. Referenzen

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – Katalog-Spezifikation
- [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) – Katalog-Integration
- [PRIVACY_GATEWAY_API.md](api/PRIVACY_GATEWAY_API.md) – API-Dokumentation
- [Live MVP](https://open-gov-group.github.io/opengov-privacy-app) – Privacy App

---

**Letzte Aktualisierung**: 2026-02-05
**Team**: RoPa (Record of Processing Activities)
**Kontakt**: @open-gov-group
