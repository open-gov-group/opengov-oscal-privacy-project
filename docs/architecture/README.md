# Architecture Documentation

Zentrale Architektur-Dokumentation für das OpenGov OSCAL Privacy Ecosystem.

---

## Schnellnavigation

| Dokument | Beschreibung |
|----------|--------------|
| **[MANAGEMENT_SUMMARY.md](MANAGEMENT_SUMMARY.md)** | **Executive Summary für Stakeholder** |
| [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) | Gesamtarchitektur des Ecosystems |
| [ROADMAP.md](ROADMAP.md) | Phasen, Meilensteine, Zeitplan |
| [GOVERNANCE.md](GOVERNANCE.md) | Rollen, Prozesse, Kommunikation |

### Katalog-Spezifikationen

| Dokument | Beschreibung |
|----------|--------------|
| [CATALOG_OVERVIEW.md](CATALOG_OVERVIEW.md) | Zwei-Katalog-Architektur Übersicht |
| [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) | Open Privacy Catalog (OPC) Spezifikation |
| [SDM_CATALOG_STRUCTURE.md](SDM_CATALOG_STRUCTURE.md) | SDM Privacy Catalog Gliederung |
| [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) | Integration Workflow |

### Framework-Mappings

| Dokument | Beschreibung |
|----------|--------------|
| **[MAPPING_PRIVACY_TO_ISO27701.md](MAPPING_PRIVACY_TO_ISO27701.md)** | **NEU: Privacy ↔ ISO 27701:2025 Mapping (89% Coverage)** |
| [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) | Privacy ↔ BSI Grundschutz++ Mapping (60% Coverage) |
| [GROUP_MAPPING_ANALYSIS.md](GROUP_MAPPING_ANALYSIS.md) | OPC ↔ SDM ↔ BSI ↔ ISO Mapping-Analyse |
| [REFERENCE_ARCHITECTURE.md](REFERENCE_ARCHITECTURE.md) | **NEU: OPC ↔ SPC ↔ Frameworks Referenzierung** |
| [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) | BSI-kompatible Control-Erweiterungen |

### Team-Dokumentation

| Dokument | Beschreibung |
|----------|--------------|
| [CORE_TEAM_LIBRARIES.md](CORE_TEAM_LIBRARIES.md) | Python Core Libraries (pyprivacy, pylegal-utils) |
| [MVP_ROPA_ARCHITECTURE.md](MVP_ROPA_ARCHITECTURE.md) | RoPa MVP Architektur |

---

## Verzeichnisstruktur

```
docs/architecture/
│
├── MASTER_BLUEPRINT.md      # Zentrale Architektur-Referenz
├── ROADMAP.md               # Projektplan und Meilensteine
├── GOVERNANCE.md            # Governance und Kommunikation
├── ARCHITECTURE.md          # Technische Details
├── CODE_STYLE.md            # Coding-Standards
├── DEVELOPMENT.md           # Entwickler-Setup
├── OSCAL_SCHEMA.md          # OSCAL-spezifische Infos
│
├── decisions/               # Architecture Decision Records
│   ├── README.md            # ADR-Index
│   ├── ADR-001-oscal-als-basis-standard.md
│   ├── ADR-002-multi-repository-architektur.md
│   ├── ADR-003-client-side-viewer.md
│   └── ADR-004-python-backend-libraries.md
│
├── diagrams/                # Visuelle Dokumentation
│   └── ECOSYSTEM_OVERVIEW.md
│
└── api/                     # API-Spezifikationen
    └── PRIVACY_GATEWAY_API.md
```

---

## Dokumenten-Hierarchie

```
                    ┌─────────────────────────┐
                    │    MASTER_BLUEPRINT     │
                    │   (Big Picture)         │
                    └────────────┬────────────┘
                                 │
          ┌──────────────────────┼──────────────────────┐
          │                      │                      │
          ▼                      ▼                      ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│    ROADMAP      │    │   GOVERNANCE    │    │   API SPECS     │
│   (Wann)        │    │   (Wer/Wie)     │    │   (Was)         │
└─────────────────┘    └─────────────────┘    └─────────────────┘
          │                      │                      │
          ▼                      ▼                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Architecture Decision Records                 │
│                    (Warum-Entscheidungen)                       │
└─────────────────────────────────────────────────────────────────┘
```

---

## Für verschiedene Zielgruppen

### Für neue Teammitglieder
1. Beginnen mit [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) - Gesamtübersicht
2. Dann [ADRs](decisions/README.md) lesen - Verständnis der Entscheidungen
3. Schließlich [DEVELOPMENT.md](DEVELOPMENT.md) - Lokales Setup

### Für Architekten
1. [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) - Referenz
2. [decisions/](decisions/) - ADRs für neue Entscheidungen nutzen
3. [GOVERNANCE.md](GOVERNANCE.md) - Review-Prozesse

### Für Projektleiter
1. [ROADMAP.md](ROADMAP.md) - Planung und Status
2. [GOVERNANCE.md](GOVERNANCE.md) - Kommunikation und Stakeholder
3. [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) - Abhängigkeiten

### Für externe Entwickler
1. [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) - Architektur verstehen
2. [api/PRIVACY_GATEWAY_API.md](api/PRIVACY_GATEWAY_API.md) - API nutzen
3. [diagrams/](diagrams/) - Visuelle Übersicht

---

## Aktualisierung

Diese Dokumentation wird gepflegt vom **Architecture Team**.

| Dokument | Review-Zyklus |
|----------|---------------|
| MASTER_BLUEPRINT | Monatlich |
| ROADMAP | Wöchentlich |
| GOVERNANCE | Quartalsweise |
| ADRs | Bei Bedarf |

---

**Letzte Aktualisierung**: 2026-02-05
