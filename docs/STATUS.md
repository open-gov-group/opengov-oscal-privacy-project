# OpenGov Privacy Ecosystem - Repository Status

**Stand**: 2026-02-06
**Analyse-Datum**: 2026-02-06

---

## Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ECOSYSTEM STATUS OVERVIEW                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   🟢 AKTIV          🟡 IN ENTWICKLUNG     ⚪ GEPLANT      🔵 MVP LIVE       │
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         LAYER 1: DATEN                              │   │
│   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                 │   │
│   │  │privacy-oscal│  │security-oscal│  │  mappings   │                 │   │
│   │  │     🟢      │  │     ⚪      │  │     🟡      │                 │   │
│   │  └─────────────┘  └─────────────┘  └─────────────┘                 │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                       LAYER 2: LIBRARIES                            │   │
│   │  ┌─────────────┐  ┌─────────────┐                                   │   │
│   │  │ pyprivacy   │  │pylegal-utils│                                   │   │
│   │  │     🟢      │  │     ⚪      │                                   │   │
│   │  └─────────────┘  └─────────────┘                                   │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                      LAYER 3: APPLICATIONS                          │   │
│   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐  │   │
│   │  │privacy-app  │  │   viewer    │  │  workbench  │  │  gateway  │  │   │
│   │  │   🔵 MVP    │  │     🟡      │  │     ⚪      │  │     ⚪    │  │   │
│   │  └─────────────┘  └─────────────┘  └─────────────┘  └───────────┘  │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                      LAYER 4: COORDINATION                          │   │
│   │  ┌──────────────────────────────────────────────────────────────┐   │   │
│   │  │              privacy-project (dieses Repo)  🟢                │   │   │
│   │  └──────────────────────────────────────────────────────────────┘   │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Repository-Details

### 1. opengov-oscal-privacy-project (Koordination)

| Attribut | Wert |
|----------|------|
| **Status** | 🟢 Aktiv |
| **Beschreibung** | Zentrales Architektur- und Koordinations-Repository |
| **Sprache** | Markdown, PowerShell (Scripts) |
| **Letzter Push** | 2026-02-04 |
| **Discussions** | ✅ Aktiviert |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-oscal-privacy-project |

**Inhalt:**
- ✅ Architektur-Dokumentation (MASTER_BLUEPRINT, VISION_AND_CONCEPT)
- ✅ Roadmap und Governance
- ✅ ADRs (4 Entscheidungen dokumentiert)
- ✅ API-Spezifikation
- ✅ Team-Koordination
- ✅ Setup-Scripts für spätere Organisation

---

### 2. opengov-privacy-oscal (OSCAL Kataloge)

| Attribut | Wert |
|----------|------|
| **Status** | 🟢 Aktiv |
| **Beschreibung** | DSGVO/SDM Privacy Kataloge in OSCAL-Format |
| **Sprache** | Shell, JSON |
| **Letzter Push** | 2026-01-27 |
| **Letzter Commit** | "new oscal privacy catalog" |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-privacy-oscal |

**Inhalt:**
- OSCAL Catalog mit DSGVO-Controls
- SDM-basierte Maßnahmen
- Properties: Schutzniveau, Eintrittswahrscheinlichkeit

**Nächste Schritte:**
- [ ] Citizen-Titles für alle Controls
- [ ] Framework-Mappings erweitern
- [ ] Validierung gegen OSCAL 1.1.2 Schema

---

### 3. opengov-oscal-pyprivacy (Python Library)

| Attribut | Wert |
|----------|------|
| **Status** | 🟢 Aktiv |
| **Beschreibung** | Python-Utilities für OSCAL Privacy |
| **Sprache** | Python |
| **Letzter Push** | 2026-02-04 |
| **Letzter Commit** | "fix mapping" |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-oscal-pyprivacy |

**Features:**
- OSCAL JSON Parsing
- Catalog-Utilities
- Mapping-Funktionen

**Nächste Schritte:**
- [ ] PyPI-Paket veröffentlichen
- [ ] Dokumentation erweitern
- [ ] Test-Coverage erhöhen

---

### 4. opengov-privacy-app (RoPA Manager)

| Attribut | Wert |
|----------|------|
| **Status** | 🔵 MVP Live |
| **Beschreibung** | RoPA (Verarbeitungsverzeichnis) Manager |
| **Sprache** | JavaScript |
| **Letzter Push** | 2025-11-26 |
| **Letzter Commit** | "new SspEditor" |
| **Live URL** | https://open-gov-group.github.io/opengov-privacy-app |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-privacy-app |

**Features (MVP):**
- SSP Editor
- RoPA-Verwaltung
- OSCAL-Import/Export

**Nächste Schritte:**
- [ ] TypeScript Migration
- [ ] UI/UX Verbesserungen
- [ ] Backend-Integration (Gateway)

---

### 5. opengov-oscal-privacy-viewer (OSCAL 1.1.2 Viewer)

| Attribut | Wert |
|----------|------|
| **Status** | 🟡 In Entwicklung (Viewer Team gegründet) |
| **Beschreibung** | Universeller OSCAL 1.1.2 Viewer (Ersatz für viewer.oscal.io) |
| **Sprache** | TypeScript |
| **Letzter Push** | 2026-02-04 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-oscal-privacy-viewer |
| **Team-Spec** | [OSCAL_VIEWER_TEAM.md](architecture/OSCAL_VIEWER_TEAM.md) |

**Viewer Team (NEU 2026-02-06):**

> Der bestehende viewer.oscal.io unterstützt nur OSCAL bis 1.0.4. Das Viewer Team entwickelt einen leichtgewichtigen, Client-Side-Only Viewer für OSCAL 1.1.2.

**Technologie-Stack:**
- TypeScript + Preact/Lit (< 10KB Bundle)
- Vite Build, Zero-Backend
- GitHub Pages Deployment
- PWA-fähig (Offline)

**Roadmap:**
| Phase | Aufgaben | Timeline |
|-------|----------|----------|
| Phase 1 | OSCAL Parser, Catalog Renderer | KW 6-9 |
| Phase 2 | Profile, Component, SSP Renderer | KW 10-12 |
| Phase 3 | GitHub Pages Deploy, PWA, Docs | KW 13-14 |

**Nächste Schritte:**
- [ ] Architektur-Design (ADR)
- [ ] OSCAL 1.1.2 Parser implementieren
- [ ] Catalog Renderer entwickeln
- [ ] GitHub Pages Deployment

---

### 6. opengov-privacy-mappings (Framework-Mappings)

| Attribut | Wert |
|----------|------|
| **Status** | 🟡 In Entwicklung |
| **Beschreibung** | Mappings zwischen Frameworks (ISO, BSI, NIST) |
| **Sprache** | XSLT |
| **Letzter Push** | 2026-02-04 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-privacy-mappings |

**Inhalt:**
- XSLT-Transformationen
- Referenz-Mappings

**Nächste Schritte:**
- [ ] ISO 27001:2022 Mapping
- [ ] BSI IT-Grundschutz Mapping
- [ ] Confidence-Levels hinzufügen

---

### 7. opengov-oscal-workbench (Authoring Tool)

| Attribut | Wert |
|----------|------|
| **Status** | ⚪ Geplant |
| **Beschreibung** | Web-basiertes Authoring für OSCAL-Artefakte |
| **Sprache** | TypeScript |
| **Letzter Push** | 2026-01-17 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-oscal-workbench |

**Geplante Features:**
- Catalog Editor
- Profile Builder
- Component Definition Editor

---

### 8. opengov-privacy-gateway (REST API)

| Attribut | Wert |
|----------|------|
| **Status** | ⚪ Geplant |
| **Beschreibung** | Zentrale REST API für das Ecosystem |
| **Sprache** | JavaScript |
| **Letzter Push** | 2025-11-23 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-privacy-gateway |

**Geplant:**
- FastAPI Backend
- OSCAL Endpoints
- RoPA API
- Compliance Matrix

**API-Spezifikation:** [PRIVACY_GATEWAY_API.md](architecture/api/PRIVACY_GATEWAY_API.md)

---

### 9. opengov-pylegal-utils (Legal Text Processing)

| Attribut | Wert |
|----------|------|
| **Status** | ⚪ Geplant |
| **Beschreibung** | Python-Library für Rechtstext-Verarbeitung |
| **Sprache** | Python |
| **Letzter Push** | 2026-01-14 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-pylegal-utils |

**Geplante Features:**
- NLP für deutsche Rechtstexte
- DSGVO-Artikel Parsing
- Referenz-Extraktion

---

### 10. opengov-security-oscal (Security Kataloge)

| Attribut | Wert |
|----------|------|
| **Status** | ⚪ Geplant |
| **Beschreibung** | NIST/BSI/ISO Security Kataloge |
| **Sprache** | - |
| **Letzter Push** | 2025-12-11 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-security-oscal |

**Geplant:**
- NIST CSF Controls
- BSI IT-Grundschutz
- ISO 27001:2022

---

### 11. opengov-privacy-data (Operative Daten)

| Attribut | Wert |
|----------|------|
| **Status** | ⚪ Integriert in App |
| **Beschreibung** | Operative Daten (Beispiele, Templates) |
| **Sprache** | - |
| **Letzter Push** | 2025-11-26 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-privacy-data |

---

## Statistik-Zusammenfassung

| Metrik | Wert |
|--------|------|
| **Repositories gesamt** | 11 |
| **Aktiv (🟢)** | 3 |
| **In Entwicklung (🟡)** | 2 |
| **MVP Live (🔵)** | 1 |
| **Geplant (⚪)** | 5 |
| **Offene Issues** | 0 |
| **Discussions aktiviert** | 1 (privacy-project) |

---

## Technologie-Stack (aktuell)

| Sprache/Tech | Repositories |
|--------------|--------------|
| **TypeScript** | viewer, workbench |
| **JavaScript** | privacy-app, gateway |
| **Python** | pyprivacy, pylegal-utils |
| **XSLT** | mappings |
| **Shell** | privacy-oscal |
| **Markdown** | privacy-project |

---

## Prioritäten (Empfehlung)

### Kurzfristig (Q1 2026)
1. **privacy-oscal** - Katalog vervollständigen
2. **pyprivacy** - Library stabilisieren
3. **privacy-app** - MVP verbessern

### Mittelfristig (Q2 2026)
4. **viewer** - Fertigstellen
5. **mappings** - ISO/BSI Mappings

### Langfristig (Q3+ 2026)
6. **gateway** - API implementieren
7. **workbench** - Authoring Tool
8. **security-oscal** - Security Kataloge

---

## Änderungshistorie

| Datum | Änderung |
|-------|----------|
| 2026-02-04 | Initiale Status-Erfassung |
| 2026-02-05 | BSI Grundschutz++ Mapping abgeschlossen, SDM-Katalogstruktur v1.0 festgeschrieben |
| 2026-02-05 | **ISO 27701:2025 Mapping abgeschlossen** - 89% Coverage, 1546 Zeilen OSCAL-Mapping |
| 2026-02-05 | **SDM Privacy Catalog v2.0** - 31 Controls durch Reverse Engineering (ISO/BSI) |
| 2026-02-06 | **OSCAL Catalog Bugfix** - `ns`-Attribut aus OPC v0.6.0/v0.7.0 entfernt; Lokalisierung wird als Service in pyprivacy implementiert |
| 2026-02-06 | **Viewer Team gegründet** - OSCAL 1.1.2 Viewer als Ersatz für viewer.oscal.io (nur 1.0.4); Team-Spezifikation erstellt |

---

## Highlights seit letztem Update

### Neu erstellte Dokumente (2026-02-05)

| Dokument | Beschreibung |
|----------|--------------|
| [MANAGEMENT_SUMMARY.md](architecture/MANAGEMENT_SUMMARY.md) | Executive Summary für Stakeholder |
| [SDM_CATALOG_STRUCTURE.md](architecture/SDM_CATALOG_STRUCTURE.md) | SDM Privacy Catalog Gliederung v1.0 |
| [GROUP_MAPPING_ANALYSIS.md](architecture/GROUP_MAPPING_ANALYSIS.md) | OPC ↔ SDM ↔ BSI ↔ ISO Mapping-Analyse |
| [CATALOG_OVERVIEW.md](architecture/CATALOG_OVERVIEW.md) | Zwei-Katalog-Architektur Übersicht |
| **[MAPPING_PRIVACY_TO_ISO27701.md](architecture/MAPPING_PRIVACY_TO_ISO27701.md)** | **NEU: ISO 27701:2025 Mapping (89% Coverage)** |
| **[REFERENCE_ARCHITECTURE.md](architecture/REFERENCE_ARCHITECTURE.md)** | **NEU: OPC ↔ SPC ↔ Frameworks Referenzierungsarchitektur** |
| **[SPC_REVERSE_ENGINEERING.md](architecture/SPC_REVERSE_ENGINEERING.md)** | **NEU: Methodik zur Maßnahmen-Konsolidierung** |

### Neue OSCAL-Artefakte

| Artefakt | Pfad |
|----------|------|
| BSI-Mapping | oscal/mappings/opengov_privacy_to_bsi_grundschutz.json |
| **ISO 27701-Mapping** | **oscal/mappings/opengov_privacy_to_iso27701.json** (1546 Zeilen) |
| Integriertes Profil | oscal/profiles/profile_integrated_privacy_security.json |
| OPC v0.7.0 | oscal/catalog/open_privacy_catalog_risk_v0.7.0.json |
| **SPC v2.0.0** | **oscal/catalog/sdm_privacy_catalog_v2.0.0.json** (861 Zeilen, 31 Controls) |

---

**Nächste Aktualisierung**: Monatlich oder bei signifikanten Änderungen
