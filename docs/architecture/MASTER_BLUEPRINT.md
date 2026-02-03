# OpenGov OSCAL Privacy Ecosystem - Master Architecture Blueprint

**Version**: 1.0.0
**Stand**: 2026-02-02
**Status**: Living Document
**Verantwortlich**: Architecture Team

---

## 1. Executive Summary

Das **OpenGov OSCAL Privacy Ecosystem** ist ein modulares, OSCAL-basiertes System zur Integration von Datenschutz in Sicherheits- und Resilienz-Frameworks für europäische öffentliche Verwaltungen.

### Kernprinzipien

| Prinzip | Beschreibung |
|---------|-------------|
| **OSCAL-First** | Alle Compliance-Artefakte basieren auf NIST OSCAL 1.1.2 |
| **Privacy by Design** | Datenschutz ist keine Ergänzung, sondern Kern des Systems |
| **Multi-Framework** | Gleichzeitige Compliance mit DSGVO, ISO 27001/27701, BSI, NIST |
| **Open Source** | Transparenz und Community-Beteiligung |
| **Dual-Audience** | Bürger und Fachpersonal gleichermaßen adressiert |

### Zielgruppe

- **Primär**: Europäische öffentliche Verwaltungen (Kommunen, Länder, Bund)
- **Sekundär**: Datenschutzbeauftragte, Compliance-Teams, IT-Sicherheit
- **Tertiär**: Bürger (über transparente Informationen zu ihren Rechten)

---

## 2. Systemarchitektur

### 2.1 Schichtenmodell

```
+===========================================================================+
|                         PRÄSENTATIONSSCHICHT                              |
|   (User Interfaces - Web Applications)                                    |
+===========================================================================+
|                                                                           |
|  +-------------------+  +-------------------+  +-------------------+       |
|  | oscal-privacy-    |  |   privacy-app     |  | oscal-workbench   |      |
|  |     viewer        |  |                   |  |                   |      |
|  +-------------------+  +-------------------+  +-------------------+       |
|  | React 18, TS      |  | React/Vue, Node   |  | React, Monaco     |      |
|  | Vite, Tailwind    |  | PostgreSQL        |  | Editor            |      |
|  | Client-Side Only  |  | Full-Stack        |  | Git Integration   |      |
|  +-------------------+  +-------------------+  +-------------------+       |
|        |                       |                       |                  |
|        | HTTP/JSON             | HTTP/JSON             | HTTP/JSON        |
|        v                       v                       v                  |
+===========================================================================+
|                         INTEGRATIONSSCHICHT                               |
|   (APIs, Libraries, Services)                                             |
+===========================================================================+
|                                                                           |
|  +-----------------------------------------------------------------------+|
|  |                       privacy-gateway (REST API)                      ||
|  |   Endpoints: /catalogs, /profiles, /controls, /ropa, /compliance      ||
|  |   Features: Auth (OAuth2), Caching (Redis), Rate Limiting             ||
|  +-----------------------------------------------------------------------+|
|        |                                           |                      |
|        v                                           v                      |
|  +----------------------------+    +----------------------------+         |
|  |    oscal-pyprivacy        |    |    pylegal-utils           |         |
|  |    (Python 3.10+)         |    |    (Python 3.10+)          |         |
|  |                           |    |                            |         |
|  | - CatalogLoader           |    | - GDPRParser               |         |
|  | - ProfileResolver         |    | - LegalReferenceNormalizer |         |
|  | - ControlMapper           |    | - ArticleExtractor         |         |
|  | - OSCALValidator          |    |                            |         |
|  +----------------------------+    +----------------------------+         |
|        |                                           |                      |
+===========================================================================+
|                            DATENSCHICHT                                   |
|   (OSCAL Artifacts, Operational Data)                                     |
+===========================================================================+
|                                                                           |
|  OSCAL ARTEFAKTE (Maschinenlesbar, Versioniert, JSON)                     |
|  +-------------------+  +-------------------+  +-------------------+       |
|  | privacy-oscal     |  | security-oscal    |  | privacy-mappings  |      |
|  +-------------------+  +-------------------+  +-------------------+       |
|  | Catalogs:         |  | Catalogs:         |  | Mappings:         |      |
|  | - sdm_privacy     |  | - nist_sp800-53   |  | - oscal_to_iso27001|     |
|  | - open_privacy    |  | - bsi_grundschutz |  | - oscal_to_iso27701|     |
|  |                   |  | - iso27001        |  | - oscal_to_bsi    |      |
|  | Profiles:         |  |                   |  | - oscal_to_nist   |      |
|  | - melderegister   |  | Profiles:         |  | - oscal_to_sdm    |      |
|  | - standard_webapp |  | - gov_baseline    |  |                   |      |
|  |                   |  | - critical_infra  |  | Metadata:         |      |
|  | Components:       |  |                   |  | - framework_info  |      |
|  | - fachverfahren   |  |                   |  | - methodology     |      |
|  +-------------------+  +-------------------+  +-------------------+       |
|                                                                           |
|  OPERATIVE DATEN (Organisations-spezifisch)                               |
|  +-----------------------------------------------------------------------+|
|  |                         privacy-data                                  ||
|  +-----------------------------------------------------------------------+|
|  | ropa/                    | assessments/           | incidents/        ||
|  | - processing_activities  | - dpia/                | - breach_records  ||
|  | - data_categories        | - pia/                 | - dsr_logs        ||
|  | - legal_bases            |                        |                   ||
|  | - recipients             |                        |                   ||
|  +-----------------------------------------------------------------------+|
|                                                                           |
+===========================================================================+
```

### 2.2 Repository-Beziehungen

```
                           +-------------------+
                           |   OSCAL Standard  |
                           |   (NIST 1.1.2)    |
                           +-------------------+
                                    |
                                    | definiert Schema
                                    v
        +-----------------------------------------------------------+
        |                    KATALOG-SCHICHT                        |
        |  +---------------+  +---------------+  +---------------+  |
        |  | privacy-oscal |  |security-oscal |  |privacy-mappings| |
        |  | (GDPR/SDM)    |  | (NIST/BSI)    |  | (Crosswalks)  |  |
        |  +---------------+  +---------------+  +---------------+  |
        +-----------------------------------------------------------+
                  |                   |                   |
                  | liest             | liest             | liest
                  v                   v                   v
        +-----------------------------------------------------------+
        |                   UTILITY-SCHICHT                         |
        |  +---------------------------+  +----------------------+  |
        |  |     oscal-pyprivacy       |  |   pylegal-utils     |  |
        |  | - Parsing & Validation    |  | - Legal Text Proc.  |  |
        |  | - Profile Resolution      |  | - GDPR References   |  |
        |  +---------------------------+  +----------------------+  |
        +-----------------------------------------------------------+
                  |                            |
                  | verwendet                  | verwendet
                  v                            v
        +-----------------------------------------------------------+
        |                    API-SCHICHT                            |
        |  +-----------------------------------------------------+  |
        |  |                 privacy-gateway                      |  |
        |  |   - Unified REST API                                 |  |
        |  |   - Authentication & Authorization                   |  |
        |  |   - Caching & Rate Limiting                          |  |
        |  +-----------------------------------------------------+  |
        +-----------------------------------------------------------+
                  |
                  | bedient
                  v
        +-----------------------------------------------------------+
        |                 APPLIKATIONS-SCHICHT                      |
        |  +---------------+  +---------------+  +---------------+  |
        |  | privacy-viewer|  |  privacy-app  |  |oscal-workbench| |
        |  | (Read-Only)   |  | (CRUD RoPA)   |  | (Edit OSCAL)  |  |
        |  +---------------+  +---------------+  +---------------+  |
        |         |                  |                  |           |
        |         v                  v                  v           |
        |  +-----------------------------------------------------+  |
        |  |                    privacy-data                      |  |
        |  |   - RoPA Records    - Assessments    - Incidents     |  |
        |  +-----------------------------------------------------+  |
        +-----------------------------------------------------------+
```

---

## 3. Repository-Spezifikationen

### 3.1 Daten-Repositories

#### opengov-privacy-oscal

| Attribut | Wert |
|----------|------|
| **Typ** | OSCAL Catalog/Profile Repository |
| **Sprache** | JSON (OSCAL 1.1.2) |
| **Status** | Active - Kern-Artefakt |
| **Team** | Compliance/DPO |
| **Abhängigkeiten** | Keine (Basis) |
| **Konsumenten** | viewer, app, workbench, gateway |

**Inhalt:**
```
opengov-privacy-oscal/
+-- catalog/
|   +-- open_privacy_catalog_risk.json   # Risiko-basierte Controls
|   +-- sdm_privacy_catalog.json         # SDM/TOM technische Controls
+-- profile/
|   +-- profile-melderegister-privacy-sdm.json
|   +-- profile_standard_web_app.json
+-- component/
    +-- comp_app_fachverfahren_base.json
```

**Custom OSCAL Properties (Namespace: https://open-gov-group.org/oscal/privacy):**
- `dp-risk-impact`: Auswirkung bei Datenschutzverletzung (1-5)
- `dp-likelihood`: Wahrscheinlichkeit (1-5)
- `implementation-level`: baseline | standard | enhanced
- `citizen-title-de/en/fr`: Bürgerfreundlicher Titel
- `gdpr-article`: Zugehörige DSGVO-Artikel (Art. 15, 17, etc.)
- `maturity-level`: CNIL-Skala 1-5

#### opengov-security-oscal

| Attribut | Wert |
|----------|------|
| **Typ** | OSCAL Catalog Repository |
| **Status** | Geplant |
| **Team** | InfoSec |
| **Abhängigkeiten** | Keine (Basis) |

**Geplanter Inhalt:**
- NIST SP 800-53 Rev. 5
- BSI IT-Grundschutz 2023
- ISO 27001 Annex A

#### opengov-privacy-mappings

| Attribut | Wert |
|----------|------|
| **Typ** | Control Mapping Repository |
| **Status** | Teilweise implementiert |
| **Team** | Standards/Compliance |
| **Abhängigkeiten** | privacy-oscal, security-oscal |

**Mapping-Struktur:**
```json
{
  "mapping_id": "sdm-tom-ac-01-to-iso27001",
  "source": {
    "framework": "OpenGov OSCAL Privacy",
    "control_id": "SDM-TOM-AC-01"
  },
  "targets": [
    {
      "framework": "ISO/IEC 27001:2022",
      "control_id": "A.9.2.1",
      "mapping_type": "equivalent"
    }
  ]
}
```

### 3.2 Applikations-Repositories

#### opengov-oscal-privacy-viewer

| Attribut | Wert |
|----------|------|
| **Typ** | Web Application (Read-Only) |
| **Tech Stack** | React 18, TypeScript, Vite, Tailwind |
| **Status** | Alpha -> Beta |
| **Team** | Frontend |
| **Deployment** | Statisch (GitHub Pages / Vercel) |

**Features:**
- Katalog-Browser mit Baum-Navigation
- Bürger- vs. DPO-Ansicht Toggle
- Mehrsprachig (DE/EN/FR)
- Compliance-Mapping-Anzeige
- Export (PDF/CSV/JSON)
- Client-Side Only (Privacy-First)

**URL-Parameter-API:**
```
/catalogs/{catalog-id}?
  view=citizen|professional
  lang=de|en|fr
  control={control-id}
  filter[risk]={1-5}
  filter[gdpr]={article-number}
```

#### opengov-privacy-app

| Attribut | Wert |
|----------|------|
| **Typ** | Full-Stack Web Application |
| **Tech Stack** | React/Vue + Node.js + PostgreSQL |
| **Status** | MVP |
| **Team** | Full-Stack |
| **Deployment** | Docker / Kubernetes |

**Module:**
- **RoPA**: Verarbeitungsverzeichnis (DSGVO Art. 30)
- **Controls**: OSCAL Control-Zuweisung
- **DSR**: Betroffenenanfragen-Workflow
- **Compliance**: Dashboard mit Multi-Framework-Status

#### opengov-oscal-workbench

| Attribut | Wert |
|----------|------|
| **Typ** | Web Application (Authoring Tool) |
| **Tech Stack** | React, Monaco Editor |
| **Status** | Geplant |
| **Team** | Frontend + Compliance |

**Features:**
- Visueller OSCAL-Editor
- Profile-Builder
- Mapping-Editor
- OSCAL-Schema-Validierung
- Git-Integration

### 3.3 Library-Repositories

#### opengov-oscal-pyprivacy

| Attribut | Wert |
|----------|------|
| **Typ** | Python Library |
| **Tech Stack** | Python 3.10+ |
| **Status** | Active |
| **Team** | Backend |
| **Distribution** | PyPI |

**API:**
```python
from opengov_oscal_pyprivacy import (
    CatalogLoader,
    ProfileResolver,
    ControlMapper,
    OSCALValidator
)

catalog = CatalogLoader.from_url("https://.../catalog.json")
validator = OSCALValidator(schema_version="1.1.2")
validator.validate(catalog)
```

#### opengov-pylegal-utils

| Attribut | Wert |
|----------|------|
| **Typ** | Python Library |
| **Tech Stack** | Python 3.10+ |
| **Status** | Geplant |
| **Team** | Compliance |

**API:**
```python
from opengov_pylegal_utils import GDPRParser

parser = GDPRParser()
articles = parser.extract_articles("Implements Art. 15, 16, 17 GDPR")
# Returns: [Article(15), Article(16), Article(17)]
```

### 3.4 API-Repository

#### opengov-privacy-gateway

| Attribut | Wert |
|----------|------|
| **Typ** | REST API Service |
| **Tech Stack** | FastAPI / Express |
| **Status** | Geplant |
| **Team** | Backend |

**Endpoints:**
```
GET  /api/v1/catalogs
GET  /api/v1/catalogs/{id}
GET  /api/v1/profiles/{id}/resolve
GET  /api/v1/controls/search?q={query}
GET  /api/v1/controls/{id}/mappings
GET  /api/v1/ropa/activities
POST /api/v1/ropa/activities
GET  /api/v1/compliance/matrix
GET  /api/v1/export/pdf?catalog={id}
```

---

## 4. Datenfluss-Übersicht

### 4.1 Use Case: Bürger prüft Rechte

```
+--------+     +------------------+     +----------------+
| Bürger | --> | privacy-viewer   | --> | privacy-oscal  |
+--------+     | (Bürgeransicht)  |     | (JSON Catalog) |
               +------------------+     +----------------+
                        |
                        | lädt citizen-title-de
                        v
               +------------------+
               | Anzeige:         |
               | "Recht auf       |
               |  Auskunft"       |
               | Art. 15 DSGVO    |
               +------------------+
```

### 4.2 Use Case: DPO erstellt RoPA-Eintrag

```
+------+     +-------------+     +-----------------+     +---------------+
| DPO  | --> | privacy-app | --> | privacy-gateway | --> | privacy-data  |
+------+     +-------------+     +-----------------+     +---------------+
                  |                      |
                  |                      | liest Controls
                  |                      v
                  |              +---------------+
                  |              | privacy-oscal |
                  |              +---------------+
                  |
                  | zeigt vorgeschlagene Controls
                  v
          +--------------------+
          | System schlagt vor:|
          | SDM-TOM-AC-01      |
          | SDM-TOM-LG-01      |
          +--------------------+
```

### 4.3 Use Case: Auditor prüft ISO 27001 Compliance

```
+----------+     +----------------+     +------------------+
| Auditor  | --> | privacy-viewer | --> | privacy-mappings |
+----------+     | (DPO-Ansicht)  |     | (ISO 27001 Map)  |
                 +----------------+     +------------------+
                         |
                         | zeigt Mapping
                         v
                 +------------------+
                 | SDM-TOM-AC-01    |
                 | -> ISO A.9.2.1   |
                 | -> ISO A.9.2.2   |
                 +------------------+
```

---

## 5. Technologie-Stack

### 5.1 Frontend-Standards

| Komponente | Technologie | Version |
|------------|-------------|---------|
| Framework | React | 18.x |
| Sprache | TypeScript | 5.x (strict) |
| Build Tool | Vite | 5.x |
| Styling | Tailwind CSS | 3.x |
| State | React Context / Zustand | - |
| Testing | Vitest, Testing Library | - |

### 5.2 Backend-Standards

| Komponente | Technologie | Version |
|------------|-------------|---------|
| Runtime | Python | 3.10+ |
| API Framework | FastAPI | 0.100+ |
| ORM | SQLAlchemy | 2.x |
| Validation | Pydantic | 2.x |
| Testing | pytest | - |

### 5.3 Daten-Standards

| Standard | Version | Verwendung |
|----------|---------|------------|
| OSCAL | 1.1.2 | Alle Compliance-Artefakte |
| JSON Schema | Draft 2020-12 | Validierung |
| OpenAPI | 3.0 | API-Spezifikation |

### 5.4 DevOps-Standards

| Komponente | Technologie |
|------------|-------------|
| CI/CD | GitHub Actions |
| Versionierung | Semantic Versioning |
| Branching | Git Flow (feature branches) |
| Containerization | Docker |
| Orchestration | Kubernetes (optional) |

---

## 6. Governance & Verantwortlichkeiten

### 6.1 Repository-Ownership (RACI)

| Repository | Responsible | Accountable | Consulted | Informed |
|------------|-------------|-------------|-----------|----------|
| privacy-oscal | Compliance | DPO | InfoSec, Legal | Alle |
| security-oscal | InfoSec | CISO | Compliance | Alle |
| privacy-mappings | Standards | DPO | Externe Auditoren | Alle |
| privacy-viewer | Frontend | Prod. Owner | UX, Accessibility | Alle |
| privacy-app | Full-Stack | Prod. Owner | DPO, IT | Alle |
| oscal-workbench | Frontend | Standards Lead | Compliance | Alle |
| privacy-gateway | Backend | Tech Lead | Security | Alle |
| oscal-pyprivacy | Backend | Tech Lead | Standards | Alle |
| pylegal-utils | Backend | Compliance | Legal | Alle |

### 6.2 Änderungsprozess

1. **Feature Request / Bug Report** -> GitHub Issue
2. **Architektur-Änderungen** -> RFC in GitHub Discussions
3. **Code-Änderungen** -> Pull Request mit Review
4. **Release** -> Semantic Versioning + Changelog

### 6.3 Review-Anforderungen

| Repository-Typ | Mindest-Reviewer | Zusatzliche Anforderungen |
|----------------|------------------|---------------------------|
| Kataloge (OSCAL) | 2 | DPO + InfoSec Sign-off |
| Mappings | 2 | Externe Audit-Prufung |
| Apps/Viewer | 1 | CI muss grun sein |
| Libraries | 1 | Test-Coverage > 80% |

---

## 7. Sicherheit & Compliance

### 7.1 Sicherheitsprinzipien

- **Client-Side First**: privacy-viewer läuft vollständig im Browser
- **Minimale Daten**: Nur notwendige Daten werden verarbeitet
- **Keine Tracking**: Keine externen Analytics
- **Audit Trail**: Alle Änderungen in privacy-data protokolliert

### 7.2 Authentifizierung

| Komponente | Auth-Methode |
|------------|--------------|
| privacy-viewer | Keine (offentlich) |
| privacy-app | OAuth2 / OIDC |
| privacy-gateway | API Keys + OAuth2 |
| oscal-workbench | OAuth2 (GitHub) |

### 7.3 Compliance-Ziele

- WCAG 2.1 AA (Barrierefreiheit)
- DSGVO-konform (Privacy by Design)
- ISO 27001 zertifizierbar
- BSI IT-Grundschutz anwendbar

---

## 8. Roadmap-Integration

### 8.1 Abhängigkeitsmatrix

```
Phase 1 (MVP - Foundation)
+-----------------+
| privacy-oscal   | <-- Muss zuerst existieren
+-----------------+
        |
        v
+-------------------+     +-------------------+
| privacy-viewer    | <-- | oscal-pyprivacy   |
+-------------------+     +-------------------+
        |
        v
+-------------------+
| privacy-app       |
| (embedded data)   |
+-------------------+

Phase 2 (Integration)
+-------------------+
| privacy-mappings  | <-- Erweitert privacy-oscal
+-------------------+
        |
        v
+-------------------+
| privacy-gateway   | <-- Unified API
+-------------------+
        |
        v
+-------------------+
| privacy-data      | <-- Separiert von privacy-app
+-------------------+

Phase 3 (Erweiterung)
+-------------------+     +-------------------+
| security-oscal    |     | oscal-workbench   |
+-------------------+     +-------------------+
        |
        v
+-------------------+
| pylegal-utils     |
+-------------------+
```

### 8.2 Kritischer Pfad

1. **privacy-oscal** (Kataloge mussen existieren)
2. **oscal-pyprivacy** (Validierung und Parsing)
3. **privacy-viewer** (Sichtbarkeit fur Burger)
4. **privacy-app** (Operatives Tool fur DPOs)
5. **privacy-mappings** (Multi-Framework-Compliance)

---

## 9. Erweiterungspunkte

### 9.1 Geplante Erweiterungen

- **SSP-Katalog**: System Security Plans für behördliche IT-Systeme
- **Automatisierte Evidence Collection**: Integration mit CI/CD
- **AI-gestützte Risikobewertung**: ML für DSFA-Vorschläge
- **Echtzeit-Compliance-Dashboard**: WebSocket-basiert

### 9.2 Integrationsmöglichkeiten

- **Externe Kataloge**: Import von NIST, BSI Katalogen
- **IAM-Integration**: Azure AD, Keycloak
- **Ticket-Systeme**: Jira, ServiceNow
- **Dokumenten-Management**: SharePoint, Confluence

---

## 10. Glossar

| Begriff | Definition |
|---------|------------|
| **OSCAL** | Open Security Controls Assessment Language (NIST) |
| **RoPA** | Records of Processing Activities (DSGVO Art. 30) |
| **DSFA/DPIA** | Datenschutz-Folgenabschätzung |
| **DSB/DPO** | Datenschutzbeauftragter |
| **TOM** | Technische und organisatorische Maßnahmen |
| **SDM** | Standard-Datenschutzmodell |
| **BSI** | Bundesamt für Sicherheit in der Informationstechnik |

---

## 11. Änderungshistorie

| Version | Datum | Autor | Änderung |
|---------|-------|-------|----------|
| 1.0.0 | 2026-02-02 | Architecture Team | Initiale Version |

---

**Nächste Review**: 2026-03-02
**Fragen?** -> GitHub Discussions oder #opengov-architecture Channel
