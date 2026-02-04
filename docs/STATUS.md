# OpenGov Privacy Ecosystem - Repository Status

**Stand**: 2026-02-04
**Analyse-Datum**: 2026-02-04

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

### 5. opengov-oscal-privacy-viewer (Katalog-Viewer)

| Attribut | Wert |
|----------|------|
| **Status** | 🟡 In Entwicklung |
| **Beschreibung** | Web-Viewer für OSCAL Privacy Kataloge |
| **Sprache** | TypeScript |
| **Letzter Push** | 2026-02-04 |
| **Issues** | 0 offen |
| **URL** | https://github.com/open-gov-group/opengov-oscal-privacy-viewer |

**Geplante Features:**
- Bürgeransicht (einfache Sprache)
- DPO-Ansicht (professionell)
- Mehrsprachig (DE, EN, FR)

**Nächste Schritte:**
- [ ] Client-Side OSCAL Rendering
- [ ] Citizen-Title Anzeige
- [ ] Filter und Suche

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

---

**Nächste Aktualisierung**: Monatlich oder bei signifikanten Änderungen
