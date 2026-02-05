# Katalog-Integration: Privacy → SDM → Resilience → Standards

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Integrationsanalyse basierend auf Workbench-Implementierung

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [Katalog-Landschaft](#2-katalog-landschaft)
3. [open_privacy_catalog → SDM-TOM-Katalog](#3-open_privacy_catalog--sdm-tom-katalog)
4. [SDM-TOM → Resilience Baseline](#4-sdm-tom--resilience-baseline)
5. [Mapping zu externen Standards](#5-mapping-zu-externen-standards)
6. [Workbench-Implementierung](#6-workbench-implementierung)
7. [Integrationsempfehlungen](#7-integrationsempfehlungen)

---

## 1. Übersicht

Das OpenGov Privacy Ecosystem verwendet eine mehrschichtige Katalog-Architektur:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    KATALOG-INTEGRATIONS-ARCHITEKTUR                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     LAYER 1: DATENSCHUTZ-KOMPENDIUM                 │   │
│   │                                                                     │   │
│   │                      open_privacy_catalog                           │   │
│   │                                                                     │   │
│   │   Fokus: WAS muss geschützt werden? (Betroffenenperspektive)       │   │
│   │   Gruppen: GOV | ACC | LAW | TOM                                    │   │
│   │   Risiko-Szenarien: normal | moderate | high                        │   │
│   │                                                                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │                                          │
│                                  │ links: rel="related-control"             │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     LAYER 2: SDM-MASSNAHMEN                         │   │
│   │                                                                     │   │
│   │                       sdm_privacy_catalog                           │   │
│   │                                                                     │   │
│   │   Fokus: WIE wird es technisch/organisatorisch umgesetzt?           │   │
│   │   Gruppen: access | lifecycle | deletion | restriction | logging    │   │
│   │   Gewährleistungsziele: 7 SDM-Ziele                                 │   │
│   │   Implementation-Level: baseline | standard | enhanced              │   │
│   │                                                                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │                                          │
│                                  │ mappings (sdm_privacy_to_security.json)  │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     LAYER 3: RESILIENCE BASELINE                    │   │
│   │                                                                     │   │
│   │                   resilience_baseline_catalog                       │   │
│   │                                                                     │   │
│   │   Fokus: TECHNISCHE Sicherheit & Business Continuity                │   │
│   │   Controls: SEC-BACKUP-*, SEC-LOGGING-*, SEC-DATA-INTEGRITY-*       │   │
│   │   Domains: backup-recovery | logging | monitoring | pii-governance  │   │
│   │                                                                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │                                          │
│                                  │ standards mappings                       │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     LAYER 4: EXTERNE STANDARDS                      │   │
│   │                                                                     │   │
│   │   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                │   │
│   │   │ BSI IT-     │  │ ISO/IEC     │  │ ISO/IEC     │                │   │
│   │   │ Grundschutz │  │ 27001:2022  │  │ 27701 (PIMS)│                │   │
│   │   │             │  │             │  │             │                │   │
│   │   │ CON.2       │  │ 5.34, 8.10  │  │ 7.3.6, 7.4.7│                │   │
│   │   │ ORP.4       │  │ 8.15, 8.16  │  │ A.7.4.5     │                │   │
│   │   │ OPS.1.1.5   │  │             │  │             │                │   │
│   │   └─────────────┘  └─────────────┘  └─────────────┘                │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Katalog-Landschaft

### 2.1 Katalog-Übersicht

| Katalog | Repository | Fokus | Zielgruppe |
|---------|------------|-------|------------|
| **open_privacy_catalog** | opengov-privacy-oscal | Datenschutz-Anforderungen, Risiko-Perspektive | DSB, DPO |
| **sdm_privacy_catalog** | opengov-privacy-oscal | Technische/Org. Maßnahmen (TOM) | IT-Security, Entwicklung |
| **resilience_baseline_catalog** | opengov-security-oscal | Security & Business Continuity | CISO, IT-Betrieb |
| **Mappings** | opengov-security-oscal/mappings | Verknüpfung zu Standards | Compliance, Audit |

### 2.2 Beziehungstypen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         BEZIEHUNGSTYPEN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. LINKS (innerhalb OSCAL)                                                │
│      ────────────────────────                                               │
│      TOM-02 ──links──▶ SDM-TOM-AC-01                                        │
│      rel: "related-control"                                                 │
│      text: "...beschreibt die dazugehörigen technischen Maßnahmen"          │
│                                                                             │
│   2. EMBEDDED MAPPINGS (in Props)                                           │
│      ───────────────────────────                                            │
│      SDM-TOM-AC-01:                                                         │
│        prop: related-mapping, class: "bsi", value: "ORP-4"                  │
│        prop: related-mapping, class: "iso27001", value: "A.9.x"             │
│        prop: related-mapping, class: "iso27701", value: "PIMS-A.7/8"        │
│                                                                             │
│   3. SEPARATE MAPPING FILE (strukturiert)                                   │
│      ─────────────────────────────────────                                  │
│      sdm_privacy_to_security.json:                                          │
│      {                                                                      │
│        sdm_control_id: "SDM-TOM-LC-01-03",                                  │
│        security_controls: [SEC-BACKUP-LIFECYCLE-01, ...],                   │
│        standards: { bsi: [...], iso27001: [...], iso27701: [...] }          │
│      }                                                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. open_privacy_catalog → SDM-TOM-Katalog

### 3.1 Verknüpfung über Links

Der **open_privacy_catalog** (Layer 1) verlinkt auf konkrete SDM-Maßnahmen:

```json
// Im open_privacy_catalog: Control TOM-02
{
  "id": "TOM-02",
  "title": "Zugriffs- und Berechtigungsmanagement",
  "class": "safeguard",
  "props": [
    { "name": "assurance_goal", "value": "confidentiality" },
    { "name": "assurance_goal", "value": "integrity" }
  ]
}

// Im sdm_privacy_catalog: Control SDM-TOM-AC-01
{
  "id": "SDM-TOM-AC-01",
  "title": "Rollenbasiertes Zugriffs- und Berechtigungsmanagement",
  "links": [
    {
      "href": "#TOM-02",
      "rel": "related-control",
      "text": "TOM-02 (Open Privacy Catalog) beschreibt das Zugriffs- und Berechtigungsmanagement aus Sicht der betroffenen Personen und des Datenschutzrisikos; SDM-TOM-AC-01 konkretisiert die dazugehörigen technischen und organisatorischen Maßnahmen."
    }
  ]
}
```

### 3.2 Unterschiedliche Perspektiven

| Aspekt | open_privacy_catalog (TOM-02) | sdm_privacy_catalog (SDM-TOM-AC-01) |
|--------|------------------------------|--------------------------------------|
| **Perspektive** | Betroffene Personen | Technische Umsetzung |
| **Risiko-Fokus** | Impact-Szenarien (normal/moderate/high) | Implementation-Level (baseline/standard/enhanced) |
| **Ziel** | Was kann schiefgehen? | Wie wird es verhindert? |
| **Parts** | maturity-hints, risk-guidance, assessment-questions | legal-justification, warranty-mapping, typical-measures |
| **Granularität** | Control-Ebene | Control + Sub-Controls |

### 3.3 SDM-Katalog Struktur

```yaml
sdm_privacy_catalog:
  groups:
    - id: "sdm-tom-access"
      title: "Access Control"
      controls:
        - id: "SDM-TOM-AC-01"      # Hauptcontrol
          controls:                 # Verschachtelte Sub-Controls
            - id: "SDM-TOM-AC-01-01"  # baseline
            - id: "SDM-TOM-AC-01-02"  # standard
            - id: "SDM-TOM-AC-01-03"  # enhanced

    - id: "sdm-tom-lifecycle"
      title: "Data Lifecycle"

    - id: "sdm-tom-deletion"
      title: "Data Deletion"

    - id: "sdm-tom-restriction"
      title: "Processing Restriction"

    - id: "sdm-tom-rectification"
      title: "Data Rectification"
```

### 3.4 SDM-Gewährleistungsziele

Der SDM-Katalog verwendet die 7 Gewährleistungsziele:

| Gewährleistungsziel | Englisch | SDM-Kurzform |
|---------------------|----------|--------------|
| Verfügbarkeit | availability | VERFÜGBARKEIT |
| Integrität | integrity | INTEGRITÄT |
| Vertraulichkeit | confidentiality | VERTRAULICHKEIT |
| Transparenz | transparency | TRANSPARENZ |
| Intervenierbarkeit | intervenability | INTERVENIERBARKEIT |
| Nichtverkettung | unlinkability | NICHTVERKETTUNG |
| Datenminimierung | data-minimization | DATENMINIMIERUNG |

```json
{
  "props": [
    { "name": "sdm-goal", "class": "warranty-objective", "value": "VERTRAULICHKEIT" },
    { "name": "sdm-goal", "class": "warranty-objective", "value": "INTEGRITÄT" }
  ],
  "parts": [
    {
      "name": "warranty-mapping",
      "parts": [
        {
          "name": "warranty-objective",
          "prose": "VERTRAULICHKEIT: Streng gesteuerte Berechtigungen verhindern, dass Unbefugte personenbezogene Daten einsehen..."
        }
      ]
    }
  ]
}
```

---

## 4. SDM-TOM → Resilience Baseline

### 4.1 Mapping-Struktur

Das Mapping zwischen SDM-Privacy und Resilience erfolgt über `sdm_privacy_to_security.json`:

```json
{
  "metadata": {
    "title": "SDM Privacy ↔ Security / Resilience Mapping",
    "version": "0.1.0-draft"
  },
  "mappings": [
    {
      "sdm_control_id": "SDM-TOM-LC-01-03",
      "sdm_group_id": "sdm-tom-lifecycle",
      "sdm_title": "Löschung in Sicherungskopien und bei Auftragsverarbeitern",
      "description": "Stellt sicher, dass das Lösch- und Aufbewahrungskonzept auch für Backups gilt...",

      "security_controls": [
        {
          "catalog_id": "opengov-resilience-baseline",
          "control_id": "SEC-BACKUP-LIFECYCLE-01",
          "control_title": "Backup retention and recovery lifecycle"
        },
        {
          "catalog_id": "opengov-resilience-baseline",
          "control_id": "SEC-THIRD-PARTY-DATA-LIFECYCLE-01",
          "control_title": "Third-party data lifecycle and deletion"
        }
      ],

      "standards": {
        "bsi": ["CON.2 Datenschutz", "OPS.1.1.5 Protokollierung"],
        "iso27001": ["5.34 Privacy and protection of PII", "8.10 Information deletion"],
        "iso27701": ["7.3.6 Access, correction and/or erasure", "7.4.7 Retention"]
      },

      "notes": "Privacy-Sicht: SDM-TOM-LC-01-03 operationalisiert DSGVO-Löschpflichten in Backups..."
    }
  ]
}
```

### 4.2 Resilience Controls

Der Resilience-Katalog enthält Security-Controls mit Domänen:

| Control | Titel | Domäne | Objective |
|---------|-------|--------|-----------|
| SEC-BACKUP-LIFECYCLE-01 | Backup retention and recovery lifecycle | backup-recovery | CIA, DS-GVO requirements |
| SEC-THIRD-PARTY-DATA-LIFECYCLE-01 | Third-party data lifecycle and deletion | third-party-management | Processors handle data according to policy |
| SEC-ARCHIVE-RETENTION-01 | Archival retention and disposal | archiving | Govern retention and disposal |
| SEC-RESTORE-CONTROL-01 | Controlled restore and change replay | backup-recovery | Control and document restore |
| SEC-DATA-INTEGRITY-01 | Data integrity and correction lifecycle | data-integrity | Data integrity processes |
| SEC-AUDIT-LOG-01 | Audit logging for data changes | logging | Tamper-resistant audit trails |
| SEC-PII-RESTRICTION-01 | Restriction of PII processing | pii-governance | Enforce restriction states |
| SEC-LOGGING-01 | Centralized logging | logging | Collect relevant logs |
| SEC-MONITORING-01 | Security monitoring and alerting | monitoring | Detect and respond |

### 4.3 Duale Perspektive (Privacy ↔ Security)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              DUALE PERSPEKTIVE: PRIVACY ↔ SECURITY                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   SDM-TOM-LC-01-03                          SEC-BACKUP-LIFECYCLE-01         │
│   (Privacy-Sicht)                           (Security/Resilience-Sicht)     │
│   ────────────────                          ──────────────────────────      │
│                                                                             │
│   "Stellt sicher, dass das                  "Das Unternehmen definiert      │
│   Lösch- und Aufbewahrungskonzept           einen vollständigen Backup-     │
│   auch für Backups und                      Lebenszyklus inklusive          │
│   Auftragsverarbeiter gilt..."              Datenschutzanforderungen..."    │
│                                                                             │
│   Gewährleistungsziele:                     Objectives:                     │
│   • NICHTVERKETTUNG                         • CIA                           │
│   • INTERVENIERBARKEIT                      • DS-GVO compliance             │
│   • TRANSPARENZ                             • Evidentiary needs             │
│                                                                             │
│   DSGVO-Artikel:                            Domain:                         │
│   • Art. 17 (Recht auf Löschung)            • backup-recovery               │
│   • Art. 28 (Auftragsverarbeiter)                                           │
│                                                                             │
│                         ◄── MAPPING ──►                                     │
│                                                                             │
│   notes: "Privacy-Sicht: SDM-TOM-LC-01-03 operationalisiert                │
│           DSGVO-Löschpflichten. Security-Sicht: SEC-BACKUP-LIFECYCLE-01    │
│           sorgt für konsistente Backup-Retention, Recovery-Szenarien..."   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Mapping zu externen Standards

### 5.1 BSI IT-Grundschutz

| SDM Control | BSI Baustein | Beschreibung |
|-------------|--------------|--------------|
| SDM-TOM-AC-01 | ORP.4 | Identitäts- und Berechtigungsmanagement |
| SDM-TOM-LC-01-03 | CON.2 | Datenschutz |
| SDM-TOM-LG-02 | OPS.1.1.5 | Protokollierung |
| SDM-TOM-DEL-01-03 | APP.4.3 | Relationale Datenbanken |

### 5.2 ISO/IEC 27001:2022

| SDM Control | ISO Control | Beschreibung |
|-------------|-------------|--------------|
| SDM-TOM-LC-01-03 | 5.34 | Privacy and protection of PII |
| SDM-TOM-DEL-01-03 | 8.10 | Information deletion |
| SDM-TOM-LG-02 | 8.15, 8.16 | Logging, Monitoring activities |
| SDM-TOM-REC-01-05 | 8.15 | Logging |

### 5.3 ISO/IEC 27701 (PIMS)

| SDM Control | ISO 27701 | Beschreibung |
|-------------|-----------|--------------|
| SDM-TOM-LC-01-03 | 7.3.6 | Access, correction and/or erasure |
| SDM-TOM-DEL-01-03 | 7.4.7, 7.4.8 | Retention, Disposal |
| SDM-TOM-RES-01-04 | 7.4.2 | Limit processing |
| SDM-TOM-LG-02 | 8.3.1 | Obligations to PII principals |

---

## 6. Workbench-Implementierung

### 6.1 Architektur

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       OSCAL WORKBENCH ARCHITEKTUR                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         FRONTEND                                    │   │
│   │                    (React + TypeScript)                             │   │
│   │                                                                     │   │
│   │   /sdm              /resilience          /privacy                   │   │
│   │   SDM Controls      Security Controls    Privacy Catalog            │   │
│   │   + Mapping Editor  + Domain Editor      + Risk Guidance            │   │
│   │                                                                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │ REST API                                 │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         BACKEND                                     │   │
│   │                      (FastAPI + Python)                             │   │
│   │                                                                     │   │
│   │   Services:                                                         │   │
│   │   • SdmCatalogService       → sdm_privacy_catalog.json              │   │
│   │   • ResilienceCatalogService → resilience_baseline_catalog.json     │   │
│   │   • MappingService          → sdm_privacy_to_security.json          │   │
│   │   • PrivacyCatalogService   → open_privacy_catalog_risk.json        │   │
│   │   • FileService             → JSON I/O                              │   │
│   │   • DiffService             → Änderungsvergleich                    │   │
│   │                                                                     │   │
│   └──────────────────────────────┬──────────────────────────────────────┘   │
│                                  │ File I/O                                 │
│                                  ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         DATA LAYER                                  │   │
│   │                   (OSCAL JSON as Single Source of Truth)            │   │
│   │                                                                     │   │
│   │   data/opengov-privacy-oscal/                                       │   │
│   │     └─ oscal/catalog/                                               │   │
│   │         ├─ open_privacy_catalog_risk.json                           │   │
│   │         └─ sdm_privacy_catalog.json                                 │   │
│   │                                                                     │   │
│   │   data/opengov-security-oscal/                                      │   │
│   │     ├─ oscal/catalog/                                               │   │
│   │     │   └─ resilience_baseline_catalog.json                         │   │
│   │     └─ mappings/                                                    │   │
│   │         └─ sdm_privacy_to_security.json                             │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 API-Endpunkte

| Endpunkt | Methode | Beschreibung |
|----------|---------|--------------|
| `/api/sdm/controls` | GET | Liste aller SDM-Controls |
| `/api/sdm/controls/{id}` | GET/PUT | Control-Detail + Update |
| `/api/resilience/controls` | GET | Liste Security-Controls |
| `/api/resilience/controls/{id}` | GET/PUT | Control-Detail + Update |
| `/api/mapping` | GET | Alle SDM→Security Mappings |
| `/api/mapping/{sdmControlId}` | GET/PUT/DELETE | Mapping CRUD |
| `/api/privacy/controls` | GET | Privacy-Katalog Controls |
| `/api/privacy/controls/{id}/typical-measures` | GET/POST | Typische Maßnahmen |

### 6.3 Workflow: Mapping bearbeiten

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    USER WORKFLOW: MAPPING BEARBEITEN                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. DSB/CISO öffnet Workbench → /sdm                                       │
│                                                                             │
│   2. Wählt SDM-Control: SDM-TOM-AC-01                                       │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ SDM-TOM-AC-01: Rollenbasiertes Zugriffs- und Berechtigungsmgmt  │    │
│      │                                                                 │    │
│      │ Props:                                                          │    │
│      │   • sdm-goal: VERTRAULICHKEIT, INTEGRITÄT                       │    │
│      │   • sdm-module: SDM-AC-01                                       │    │
│      │   • dsgvo-article: Art. 5, 24, 25, 32 DSGVO                     │    │
│      │   • related-mapping: ORP-4 (BSI), A.9.x (ISO)                   │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   3. Öffnet Mapping-Editor                                                  │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ Verknüpfte Security Controls:                                   │    │
│      │   ☑ SEC-BACKUP-LIFECYCLE-01                                     │    │
│      │   ☐ SEC-DATA-INTEGRITY-01                                       │    │
│      │   ☐ SEC-AUDIT-LOG-01                                            │    │
│      │                                                                 │    │
│      │ Standards:                                                      │    │
│      │   BSI: ORP-4, CON.2                                             │    │
│      │   ISO 27001: 5.34, A.9.2                                        │    │
│      │   ISO 27701: 7.3.6                                              │    │
│      │                                                                 │    │
│      │ Notes: [Privacy-/Security-Begründung...]                        │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   4. Klickt "Diff anzeigen" → Preview der Änderungen                        │
│                                                                             │
│   5. Klickt "Mapping speichern" → sdm_privacy_to_security.json updated      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. Integrationsempfehlungen

### 7.1 Katalog-Konsistenz

| Empfehlung | Beschreibung |
|------------|--------------|
| **Bidirektionale Links** | open_privacy_catalog → SDM und SDM → open_privacy_catalog |
| **Einheitliche IDs** | TOM-02 ↔ SDM-TOM-AC-01 über `links` verbinden |
| **Shared Vocabulary** | assurance_goal = sdm-goal (gleiche 7 Werte) |
| **Konsistente Props** | Gleiche class-Attribute für Mappings |

### 7.2 Mapping-Strategie

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       EMPFOHLENE MAPPING-STRATEGIE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OPTION A: Embedded Mappings (aktuell im SDM-Katalog)                      │
│   ─────────────────────────────────────────────────────                     │
│   + Alles in einem File                                                     │
│   + Einfach zu pflegen                                                      │
│   - Redundanz wenn mehrere Controls gleiche Standards referenzieren         │
│                                                                             │
│   OPTION B: Separate Mapping-Datei (aktuell implementiert)                  │
│   ─────────────────────────────────────────────────────────                 │
│   + Klare Trennung der Domänen                                              │
│   + Einfacher zu erweitern                                                  │
│   + Notes/Begründungen pro Mapping                                          │
│   - Zwei Files synchron halten                                              │
│                                                                             │
│   EMPFEHLUNG: Kombination                                                   │
│   ─────────────────────────                                                 │
│   • Embedded für stabile, allgemeine Mappings (BSI, ISO)                    │
│   • Separate Datei für:                                                     │
│     - SDM → Resilience (interne Kataloge)                                   │
│     - Notes/Begründungen                                                    │
│     - Workbench-gepflegte Mappings                                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.3 Nächste Schritte

1. **Katalog-Synchronisation**
   - [ ] open_privacy_catalog Links zu SDM-Controls validieren
   - [ ] SDM-Katalog Links zurück zu open_privacy_catalog prüfen

2. **Mapping-Erweiterung**
   - [ ] Alle TOM-Controls mit SDM-Entsprechungen verlinken
   - [ ] Resilience-Mappings vervollständigen
   - [ ] BSI IT-Grundschutz Mappings erweitern

3. **Workbench-Integration**
   - [ ] Workbench als Editor für alle Kataloge nutzen
   - [ ] Diff-Preview vor Speicherung
   - [ ] Git-Integration für Versionierung

4. **Dokumentation**
   - [ ] Mapping-Rationale dokumentieren
   - [ ] Querverweise in beiden Richtungen prüfen

---

## 8. BSI Grundschutz++ Integration

### 8.1 Neue Artefakte (2026-02-05)

Mit der BSI Grundschutz++ Integration wurden folgende Artefakte erstellt:

| Artefakt | Pfad | Beschreibung |
|----------|------|--------------|
| **Mapping-Dokumentation** | [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) | Vollständiges Mapping Privacy ↔ BSI |
| **OSCAL Mapping-Datei** | [opengov_privacy_to_bsi_grundschutz.json](../../oscal/mappings/opengov_privacy_to_bsi_grundschutz.json) | Maschinenlesbares OSCAL-Mapping |
| **Erweitertes Control-Schema** | [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) | BSI-kompatible Erweiterungen |
| **Integriertes Profil** | [profile_integrated_privacy_security.json](../../oscal/profiles/profile_integrated_privacy_security.json) | Kombiniertes Privacy + Security Profil |

### 8.2 Integration Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BSI GRUNDSCHUTZ++ INTEGRATION                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. Mapping analysieren                                                    │
│      └─► MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md                             │
│                                                                             │
│   2. Gaps identifizieren                                                    │
│      └─► opengov_privacy_to_bsi_grundschutz.json → "gaps" Section          │
│                                                                             │
│   3. Controls erweitern (optional)                                          │
│      └─► EXTENDED_CONTROL_SCHEMA.md → modalverb, effort_level, etc.        │
│                                                                             │
│   4. Integriertes Profil nutzen                                            │
│      └─► profile_integrated_privacy_security.json                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 9. Referenzen

### Projekt-Dokumentation

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – Katalog-Spezifikation
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – BSI Mapping-Dokumentation
- [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) – Erweitertes Control-Schema

### OSCAL-Artefakte

- [opengov_privacy_to_bsi_grundschutz.json](../../oscal/mappings/opengov_privacy_to_bsi_grundschutz.json) – OSCAL Mapping-Datei
- [profile_integrated_privacy_security.json](../../oscal/profiles/profile_integrated_privacy_security.json) – Integriertes Profil

### Externe Repositories

- [opengov-privacy-oscal](https://github.com/open-gov-group/opengov-privacy-oscal) – Privacy-Kataloge
- [opengov-security-oscal](https://github.com/open-gov-group/opengov-security-oscal) – Security-Kataloge
- [open-oscal-workbench](https://github.com/open-gov-group/open-oscal-workbench) – Workbench-Implementierung
- [BSI Stand-der-Technik-Bibliothek](https://github.com/BSI-Bund/Stand-der-Technik-Bibliothek) – BSI Grundschutz++ Quellkataloge

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
