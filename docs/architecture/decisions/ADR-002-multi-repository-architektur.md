# ADR-002: Multi-Repository-Architektur

**Status**: Akzeptiert
**Datum**: 2026-02-02
**Entscheider**: Architecture Team
**Technische Story**: Strukturierung des Projekts in mehrere Repositories

---

## Kontext

Das OpenGov Privacy Ecosystem umfasst verschiedene Komponenten:
- Datenschutz-Kataloge (OSCAL JSON)
- Sicherheits-Kataloge (OSCAL JSON)
- Control-Mappings
- Web-Viewer (React)
- RoPA-Anwendung (Full-Stack)
- Authoring-Workbench
- REST API Gateway
- Python-Libraries

Die Frage ist: **Monorepo oder Multi-Repository?**

---

## Entscheidung

Wir verwenden eine **Multi-Repository-Architektur** mit 10 separaten Repositories unter der GitHub-Organisation `open-gov-group`.

### Repository-Aufteilung

```
open-gov-group/
│
├── DATEN-REPOSITORIES (OSCAL Artefakte)
│   ├── opengov-privacy-oscal       # DSGVO/SDM Kataloge
│   ├── opengov-security-oscal      # NIST/BSI/ISO Kataloge
│   ├── opengov-privacy-mappings    # Framework-Mappings
│   └── opengov-privacy-data        # RoPA Daten
│
├── APPLIKATIONS-REPOSITORIES
│   ├── opengov-oscal-privacy-viewer  # Web Viewer (Read-Only)
│   ├── opengov-privacy-app           # RoPA Manager (CRUD)
│   └── opengov-oscal-workbench       # Authoring Tool
│
└── UTILITY-REPOSITORIES
    ├── opengov-privacy-gateway       # REST API
    ├── opengov-oscal-pyprivacy       # Python Core Library
    └── opengov-pylegal-utils         # Legal Text Processing
```

---

## Gründe für Multi-Repository

| Aspekt | Multi-Repository | Monorepo |
|--------|------------------|----------|
| **Team-Autonomie** | Jedes Team verwaltet sein Repo | Alle arbeiten im gleichen Repo |
| **Release-Zyklen** | Unabhängig | Gekoppelt |
| **Zugriffskontrolle** | Granular pro Repo | Einheitlich |
| **CI/CD** | Isoliert, schneller | Komplex, langsamer |
| **Daten vs. Code** | Getrennt verwaltbar | Vermischt |
| **Open Source** | Selektive Veröffentlichung | Alles oder nichts |

### Hauptgründe

1. **Verschiedene Lebenszyklus**: OSCAL-Kataloge ändern sich selten, Apps häufig
2. **Verschiedene Teams**: Compliance-Team pflegt Kataloge, Dev-Team die Apps
3. **Verschiedene Zugriffe**: Kataloge öffentlich, RoPA-Daten intern
4. **Unabhängige Releases**: Viewer kann unabhängig von Gateway released werden

---

## Konsequenzen

### Positiv

- **Klare Ownership**: Jedes Repo hat einen verantwortlichen Owner
- **Einfache CI/CD**: Jedes Repo hat eigene Pipeline
- **Flexibilität**: Repos können unabhängig deprecated werden
- **Open Source**: Öffentliche Repos ohne interne Daten

### Negativ

- **Koordination**: Änderungen über Repos hinweg erfordern Abstimmung
- **Versionierung**: Kompatibilität zwischen Repos muss gepflegt werden
- **Overhead**: Mehr Repos = mehr Verwaltung

### Mitigationsmaßnahmen

1. **Semantic Versioning**: Alle Repos folgen SemVer
2. **Compatibility Matrix**: Dokumentiert welche Versionen zusammenarbeiten
3. **Dependency Management**: Automatische Updates via Dependabot
4. **Monorepo-Koordination**: Dieses Repo (`opengov-oscal-privacy-project`) als Meta-Repository

---

## Meta-Repository

Dieses Repository dient als **Architektur-Hub**:

```
opengov-oscal-privacy-project/
├── docs/
│   ├── architecture/
│   │   ├── MASTER_BLUEPRINT.md      # Gesamtarchitektur
│   │   ├── decisions/               # ADRs
│   │   └── diagrams/                # Visualisierungen
│   ├── related-informations/        # Hintergrunddokumente
│   └── guides/                      # Anleitungen
└── README.md                        # Einstiegspunkt
```

---

## Alternativen

### Nicht gewählt: Monorepo

- **Pro**: Einfache Koordination, atomare Commits
- **Contra**: Zu komplex für heterogene Komponenten (JSON-Daten + React + Python)

### Nicht gewählt: Weniger Repositories (Konsolidierung)

- **Pro**: Weniger Overhead
- **Contra**: Vermischt unterschiedliche Verantwortlichkeiten

---

## Referenzen

- [MASTER_BLUEPRINT.md](../MASTER_BLUEPRINT.md)
- [PROJECT_OVERVIEW.md](../../related-informations/PROJECT_OVERVIEW.md)
