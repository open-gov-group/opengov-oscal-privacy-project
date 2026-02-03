# OpenGov OSCAL Privacy Project

**Das Architektur-Repository für das OpenGov Privacy Ecosystem**

[![Status](https://img.shields.io/badge/Status-Active-green)]()
[![License](https://img.shields.io/badge/License-MIT-blue)]()
[![OSCAL](https://img.shields.io/badge/OSCAL-1.1.2-orange)]()

---

## Was ist das?

Dieses Repository ist das **zentrale Architektur- und Koordinations-Hub** für das OpenGov OSCAL Privacy Ecosystem - ein modulares, Open-Source-System zur Integration von Datenschutz in Sicherheits- und Compliance-Frameworks für europäische öffentliche Verwaltungen.

### Vision

> *"Datenschutz als integraler Bestandteil digitaler Resilienz - für Behörden und Bürger gleichermaßen."*

### Das Ecosystem auf einen Blick

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    OpenGov Privacy Ecosystem                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   👤 BÜRGER          👔 DPO/DSB           📋 EXPERTEN                   │
│      │                  │                    │                          │
│      ▼                  ▼                    ▼                          │
│   ┌─────────┐      ┌─────────┐         ┌─────────┐                     │
│   │ Viewer  │      │  App    │         │Workbench│                     │
│   └────┬────┘      └────┬────┘         └────┬────┘                     │
│        │                │                   │                          │
│        └────────────────┼───────────────────┘                          │
│                         ▼                                              │
│              ┌─────────────────────┐                                   │
│              │   OSCAL Kataloge    │                                   │
│              │   (DSGVO + ISO)     │                                   │
│              └─────────────────────┘                                   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Schnellstart

### Für alle: Das Konzept verstehen

**[VISION_AND_CONCEPT.md](docs/architecture/VISION_AND_CONCEPT.md)** - Das zentrale Konzeptdokument erklärt:
- Datenschutz als Teil der Resilienz (NIST, KRITIS, BSI, ISO)
- Den risikobasierten Ansatz mit Schutzniveau und Eintrittswahrscheinlichkeit
- Den OSCAL-Workflow: **Catalog → Component → Profile → SSP → RoPA**
- Die SDM-Dreischicht-Betrachtung (Prozess/Applikation/Infrastruktur)
- Die sieben Gewährleistungsziele

### Für alle Teams

- **[TEAMS.md](TEAMS.md)** - Wer ist für was verantwortlich? (RACI-Matrix, GitHub Teams)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Wie trage ich bei?
- **[Governance](docs/architecture/GOVERNANCE.md)** - Kommunikation und Prozesse

### Für Architekten & Projektleiter

1. **[Vision & Konzept](docs/architecture/VISION_AND_CONCEPT.md)** - Das "Warum" und "Was"
2. **[Master Blueprint](docs/architecture/MASTER_BLUEPRINT.md)** - Das "Wie" der Architektur
3. **[Roadmap](docs/architecture/ROADMAP.md)** - Das "Wann" der Umsetzung
4. **[ADR-Übersicht](docs/architecture/decisions/README.md)** - Architektur-Entscheidungen

### Für Entwickler

1. **[Technologie-Stack](docs/architecture/MASTER_BLUEPRINT.md#5-technologie-stack)** - Welche Technologien wir verwenden
2. **[Repository-Spezifikationen](docs/architecture/MASTER_BLUEPRINT.md#3-repository-spezifikationen)** - Details zu jedem Repository
3. **[API-Spezifikation](docs/architecture/api/PRIVACY_GATEWAY_API.md)** - REST API Design

### Für Compliance-Teams

1. **[Project Overview](docs/related-informations/PROJECT_OVERVIEW.md)** - Fachliche Projektübersicht
2. **[OSCAL-Konzept](docs/architecture/decisions/ADR-001-oscal-als-basis-standard.md)** - Warum OSCAL?
3. **[Dokumenten-Index](docs/related-informations/DOCUMENTS_INDEX.md)** - Alle Hintergrunddokumente

---

## Repository-Struktur

```
opengov-oscal-privacy-project/
│
├── docs/
│   ├── architecture/
│   │   ├── MASTER_BLUEPRINT.md      # Zentrale Architektur-Dokumentation
│   │   ├── ARCHITECTURE.md          # Technische Architektur
│   │   ├── decisions/               # Architecture Decision Records (ADRs)
│   │   │   ├── ADR-001-oscal-als-basis-standard.md
│   │   │   ├── ADR-002-multi-repository-architektur.md
│   │   │   ├── ADR-003-client-side-viewer.md
│   │   │   └── ADR-004-python-backend-libraries.md
│   │   ├── diagrams/                # Visuelle Diagramme
│   │   │   └── ECOSYSTEM_OVERVIEW.md
│   │   └── api/                     # API-Spezifikationen
│   │
│   ├── guides/                      # Anleitungen
│   │   ├── DEPLOYMENT.md
│   │   ├── SECURITY.md
│   │   └── IMPLEMENTATION.md
│   │
│   ├── related-informations/        # Hintergrunddokumente
│   │   ├── PROJECT_OVERVIEW.md      # Fachliche Übersicht
│   │   ├── DOCUMENTS_INDEX.md       # Dokumenten-Index
│   │   └── *.rtf                    # Quelldokumente
│   │
│   └── team-knowledge/              # Team-spezifisches Wissen
│
└── README.md                        # Dieses Dokument
```

---

## Das Ecosystem: 10 Repositories

| Repository | Beschreibung | Status |
|------------|--------------|--------|
| **[privacy-oscal](https://github.com/open-gov-group/opengov-privacy-oscal)** | DSGVO/SDM Kataloge in OSCAL | Active |
| **[security-oscal](https://github.com/open-gov-group/opengov-security-oscal)** | NIST/BSI/ISO Kataloge | Geplant |
| **[privacy-mappings](https://github.com/open-gov-group/opengov-privacy-mappings)** | Framework-Mappings | Teilweise |
| **[privacy-viewer](https://github.com/open-gov-group/opengov-oscal-privacy-viewer)** | Web Viewer (Read-Only) | Alpha |
| **[privacy-app](https://github.com/open-gov-group/opengov-privacy-app)** | RoPA Manager | MVP |
| **[oscal-workbench](https://github.com/open-gov-group/opengov-oscal-workbench)** | Authoring Tool | Geplant |
| **[privacy-gateway](https://github.com/open-gov-group/opengov-privacy-gateway)** | REST API | Geplant |
| **[oscal-pyprivacy](https://github.com/open-gov-group/opengov-oscal-pyprivacy)** | Python Library | Active |
| **[pylegal-utils](https://github.com/open-gov-group/opengov-pylegal-utils)** | Legal Text Processing | Geplant |
| **[privacy-data](https://github.com/open-gov-group/opengov-privacy-data)** | Operative Daten | In App |

---

## Zielgruppen

### Bürger
- Verstehen ihre Datenschutzrechte in einfacher Sprache
- Zugang über den **privacy-viewer** (Bürgeransicht)
- Mehrsprachig: DE, EN, FR

### Datenschutzbeauftragte (DPO/DSB)
- Führen das Verarbeitungsverzeichnis (RoPA)
- Weisen OSCAL-Controls zu
- Erstellen Compliance-Berichte

### IT-/Sicherheitsteams
- Implementieren technische Maßnahmen
- Dokumentieren Evidenz
- Verknüpfen mit ISO 27001/BSI

### Auditoren
- Prüfen Compliance-Status
- Nutzen Mapping zu internationalen Standards
- Exportieren Audit-Berichte

---

## Technologie-Stack

| Bereich | Technologie |
|---------|-------------|
| **Frontend** | React 18, TypeScript, Vite, Tailwind |
| **Backend** | Python 3.10+, FastAPI |
| **Datenformat** | OSCAL 1.1.2 (JSON) |
| **API** | REST, OpenAPI 3.0 |
| **CI/CD** | GitHub Actions |

---

## Mitmachen

### Für Entwickler

1. Repository klonen
2. Relevantes Sub-Repository auswählen
3. Issue erstellen oder Pull Request einreichen

### Für Compliance-Experten

- Katalog-Erweiterungen vorschlagen
- Mappings zu weiteren Standards beitragen
- Dokumentation verbessern

### Kommunikation

- **GitHub Issues**: Technische Aufgaben und Bugs
- **GitHub Discussions**: Architektur-Vorschläge, RFCs
- **Channel**: #opengov-privacy

---

## Roadmap

| Phase | Fokus | Status |
|-------|-------|--------|
| **Phase 1** | MVP Foundation (privacy-oscal, viewer, app) | In Arbeit |
| **Phase 2** | Integration (mappings, gateway) | Geplant |
| **Phase 3** | Erweiterung (workbench, security-oscal) | Geplant |
| **Phase 4** | Enterprise (SSP, Audit-Integration) | Zukunft |

Siehe [ROADMAP.md](docs/architecture/ROADMAP.md) für Details.

---

## Lizenz

MIT License - siehe [LICENSE](LICENSE) für Details.

---

## Kontakt

- **GitHub Organisation**: [open-gov-group](https://github.com/open-gov-group)
- **Architecture Team**: Über GitHub Discussions

---

**Letzte Aktualisierung**: 2026-02-02
