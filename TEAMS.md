# Teams & Verantwortlichkeiten

**Version**: 1.0.0
**Stand**: 2026-02-03

---

## Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         TEAM-STRUKTUR                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    ┌─────────────────────────┐                              │
│                    │   STEERING COMMITTEE    │                              │
│                    │   (Strategie & Budget)  │                              │
│                    └───────────┬─────────────┘                              │
│                                │                                            │
│            ┌───────────────────┼───────────────────┐                        │
│            │                   │                   │                        │
│            ▼                   ▼                   ▼                        │
│   ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐              │
│   │  ARCHITECTURE   │ │  PRODUCT OWNER  │ │    COMPLIANCE   │              │
│   │     TEAM        │ │                 │ │      TEAM       │              │
│   └────────┬────────┘ └────────┬────────┘ └────────┬────────┘              │
│            │                   │                   │                        │
│            └───────────────────┼───────────────────┘                        │
│                                │                                            │
│         ┌──────────────────────┼──────────────────────┐                     │
│         │                      │                      │                     │
│         ▼                      ▼                      ▼                     │
│ ┌───────────────┐    ┌───────────────┐    ┌───────────────┐                │
│ │   FRONTEND    │    │   BACKEND     │    │  OPERATIONS   │                │
│ │     TEAM      │    │    TEAM       │    │    TEAM       │                │
│ └───────────────┘    └───────────────┘    └───────────────┘                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 1. Repository-Verantwortlichkeits-Matrix (RACI)

| Repository | Frontend | Backend | Compliance | Operations | Architecture |
|------------|:--------:|:-------:|:----------:|:----------:|:------------:|
| **privacy-oscal** | I | I | **R/A** | I | C |
| **security-oscal** | I | I | **R/A** | I | C |
| **privacy-mappings** | I | C | **R/A** | I | C |
| **privacy-viewer** | **R/A** | C | I | C | C |
| **privacy-app** | **R** | **R** | C | C | **A** |
| **oscal-workbench** | **R/A** | C | C | C | C |
| **privacy-gateway** | I | **R/A** | I | C | C |
| **oscal-pyprivacy** | I | **R/A** | C | I | C |
| **pylegal-utils** | I | **R/A** | C | I | C |
| **privacy-data** | I | **R** | C | **A** | C |
| **privacy-project** (dieses Repo) | I | I | C | I | **R/A** |

**Legende:**
- **R** = Responsible (führt aus)
- **A** = Accountable (verantwortlich/genehmigt)
- **C** = Consulted (wird befragt)
- **I** = Informed (wird informiert)

---

## 2. GitHub Teams einrichten

### Benötigte Teams in der GitHub Organisation

```bash
# Teams in open-gov-group Organisation erstellen
# (manuell in GitHub Settings > Teams)

@open-gov-group/steering-committee    # Strategie
@open-gov-group/architecture-team     # Technische Architektur
@open-gov-group/product-owner         # Fachliche Priorisierung
@open-gov-group/compliance-team       # Kataloge & Standards
@open-gov-group/frontend-team         # React/TypeScript
@open-gov-group/backend-team          # Python/FastAPI
@open-gov-group/operations-team       # DevOps/Deployment
@open-gov-group/security-team         # Security Review
@open-gov-group/tech-leads            # Alle Team Leads
@open-gov-group/devops-team           # CI/CD
```

### Team-Berechtigungen pro Repository

| Repository | Admin | Maintain | Write | Triage | Read |
|------------|-------|----------|-------|--------|------|
| privacy-oscal | arch | compliance | compliance | - | all |
| privacy-viewer | arch | frontend | frontend | - | all |
| privacy-app | arch | tech-leads | frontend, backend | - | all |
| privacy-gateway | arch | backend | backend | - | all |
| oscal-pyprivacy | arch | backend | backend | - | all |
| privacy-project | arch | arch | tech-leads | compliance | all |

---

## 3. Synchronisations-Mechanismen

### 3.1 Zentrale Informationsquellen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SINGLE SOURCE OF TRUTH                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    privacy-project Repository                        │   │
│   │                    (Dieses Repository)                               │   │
│   │                                                                     │   │
│   │   • MASTER_BLUEPRINT.md    → Gesamtarchitektur                      │   │
│   │   • ROADMAP.md             → Zeitplan alle Repos                    │   │
│   │   • TEAMS.md               → Verantwortlichkeiten                   │   │
│   │   • GOVERNANCE.md          → Prozesse                               │   │
│   │   • ADRs                   → Architektur-Entscheidungen             │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                     │                                       │
│                                     ▼                                       │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    GitHub Organization Projects                      │   │
│   │                                                                     │   │
│   │   • Ecosystem Roadmap Board    → Cross-Repo Planung                 │   │
│   │   • Sprint Board               → Aktuelle Arbeiten                  │   │
│   │   • Dependency Tracker         → Repo-Abhängigkeiten                │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Kommunikations-Rhythmus

| Meeting | Frequenz | Teilnehmer | Inhalt |
|---------|----------|------------|--------|
| **Daily Standup** | Täglich | Team | Blocker, Status |
| **Cross-Team Sync** | 2x/Woche | Tech Leads | Abhängigkeiten |
| **Architecture Review** | Wöchentlich | Arch Team | ADRs, Design |
| **Sprint Planning** | 2-wöchentlich | Alle Teams | Koordination |
| **Stakeholder Demo** | Monatlich | Alle + Stakeholder | Fortschritt |

### 3.3 Benachrichtigungen einrichten

Jedes Team sollte folgende GitHub-Benachrichtigungen aktivieren:

```yaml
# Empfohlene Watch-Einstellungen pro Team

Frontend-Team:
  - privacy-viewer: All Activity
  - privacy-app: All Activity
  - oscal-workbench: All Activity
  - privacy-project: Releases + Discussions

Backend-Team:
  - privacy-gateway: All Activity
  - oscal-pyprivacy: All Activity
  - pylegal-utils: All Activity
  - privacy-project: Releases + Discussions

Compliance-Team:
  - privacy-oscal: All Activity
  - security-oscal: All Activity
  - privacy-mappings: All Activity
  - privacy-project: All Activity

Architecture-Team:
  - Alle Repos: All Activity
```

---

## 4. GitHub Projects Board-Struktur

### 4.1 Organisation-Level Project: "Ecosystem Roadmap"

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         ECOSYSTEM ROADMAP BOARD                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐           │
│  │ Backlog │  │ Phase 1 │  │ Phase 2 │  │ Phase 3 │  │  Done   │           │
│  │         │  │ Q1-Q2   │  │ Q2-Q3   │  │ Q3-Q4   │  │         │           │
│  ├─────────┤  ├─────────┤  ├─────────┤  ├─────────┤  ├─────────┤           │
│  │         │  │         │  │         │  │         │  │         │           │
│  │ [Idea]  │  │[Viewer] │  │[Gateway]│  │[Workb.] │  │[Catalog]│           │
│  │ [Idea]  │  │[App]    │  │[Mapping]│  │[Sec-OSC]│  │         │           │
│  │         │  │[pypri.] │  │         │  │         │  │         │           │
│  │         │  │         │  │         │  │         │  │         │           │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘           │
│                                                                             │
│  Custom Fields:                                                             │
│  • Repository (dropdown)                                                    │
│  • Team (dropdown)                                                          │
│  • Priority (P0-P3)                                                         │
│  • Dependencies (linked issues)                                             │
│  • Phase (dropdown)                                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.2 Cross-Repository Issue Linking

Bei Abhängigkeiten zwischen Repos:

```markdown
# In Issue-Beschreibung:

## Abhängigkeiten
- [ ] Blocked by: open-gov-group/oscal-pyprivacy#42
- [ ] Blocks: open-gov-group/privacy-gateway#15
- [ ] Related: open-gov-group/privacy-oscal#8

## Betroffene Teams
- @open-gov-group/backend-team (primary)
- @open-gov-group/compliance-team (review)
```

---

## 5. Vermeidung von Doppelarbeit

### 5.1 Vor Arbeitsbeginn prüfen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CHECKLISTE VOR ARBEITSBEGINN                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  □ 1. Existiert bereits ein Issue/PR für diese Aufgabe?                     │
│       → GitHub Search: org:open-gov-group "keyword"                         │
│                                                                             │
│  □ 2. Ist die Aufgabe im richtigen Repository?                              │
│       → Siehe RACI-Matrix oben                                              │
│                                                                             │
│  □ 3. Gibt es Abhängigkeiten zu anderen Repos?                              │
│       → Check Ecosystem Board                                               │
│                                                                             │
│  □ 4. Ist das zuständige Team informiert?                                   │
│       → @mention im Issue                                                   │
│                                                                             │
│  □ 5. Gibt es bereits ähnliche Implementierungen?                           │
│       → Check oscal-pyprivacy für Backend-Utils                             │
│       → Check privacy-viewer für Frontend-Komponenten                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.2 Shared Libraries & Components

| Typ | Repository | Beschreibung | Nutzer |
|-----|------------|--------------|--------|
| **Python OSCAL Utilities** | oscal-pyprivacy | OSCAL parsing, validation | gateway, app |
| **Legal Text Processing** | pylegal-utils | NLP für Rechtstexte | pyprivacy, app |
| **React OSCAL Components** | privacy-viewer | Wiederverwendbare UI | app, workbench |
| **OSCAL Schemas** | privacy-oscal | JSON Schemas | alle |

### 5.3 RFC-Prozess für neue Features

Für Features, die mehrere Repos betreffen:

1. **RFC erstellen** in privacy-project/discussions
2. **Betroffene Teams taggen**
3. **2 Wochen Diskussion**
4. **Architecture Review**
5. **ADR dokumentieren** (wenn genehmigt)
6. **Issues in jeweiligen Repos erstellen**

---

## 6. Onboarding neuer Teammitglieder

### 6.1 Onboarding-Checkliste

```markdown
## Woche 1: Orientierung

- [ ] GitHub Organisation beitreten
- [ ] Dem richtigen Team zugewiesen werden
- [ ] README.md und VISION_AND_CONCEPT.md lesen
- [ ] MASTER_BLUEPRINT.md durcharbeiten
- [ ] Alle ADRs lesen
- [ ] Watch-Einstellungen für relevante Repos setzen

## Woche 2: Einarbeitung

- [ ] Lokales Development Setup
- [ ] "Good First Issue" bearbeiten
- [ ] An Daily Standups teilnehmen
- [ ] Buddy-Gespräch mit Team Lead

## Woche 3+: Produktiv

- [ ] Eigenständig Issues bearbeiten
- [ ] Code Reviews durchführen
- [ ] An Sprint Planning teilnehmen
```

### 6.2 Buddy-System

Jedes neue Teammitglied bekommt einen Buddy aus dem gleichen Team:

| Neues Mitglied in | Buddy aus |
|-------------------|-----------|
| Frontend-Team | Frontend-Team (Senior) |
| Backend-Team | Backend-Team (Senior) |
| Compliance-Team | Architecture-Team |

---

## 7. Eskalationspfade

```
Problem in einem Repository
         │
         ▼
┌─────────────────────┐
│ Team Lead des Repos │
└─────────┬───────────┘
          │ Nicht lösbar
          ▼
┌─────────────────────┐
│ Cross-Team Sync     │
│ (Tech Leads)        │
└─────────┬───────────┘
          │ Architektur-Entscheidung nötig
          ▼
┌─────────────────────┐
│ Architecture Team   │
└─────────┬───────────┘
          │ Strategische Entscheidung
          ▼
┌─────────────────────┐
│ Steering Committee  │
└─────────────────────┘
```

---

## 8. Tools & Automatisierung

### 8.1 Empfohlene GitHub Apps

| App | Zweck |
|-----|-------|
| **Renovate** | Automatische Dependency Updates |
| **CodeQL** | Security Scanning |
| **Mergify** | Auto-Merge wenn CI grün |
| **Stale** | Alte Issues markieren |

### 8.2 Cross-Repo Automatisierung

```yaml
# Beispiel: Workflow der bei Release in pyprivacy
# automatisch Issues in abhängigen Repos erstellt

name: Notify Dependents
on:
  release:
    types: [published]
jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - name: Create update issues
        uses: actions/github-script@v7
        with:
          script: |
            const dependents = ['privacy-gateway', 'privacy-app'];
            for (const repo of dependents) {
              await github.rest.issues.create({
                owner: 'open-gov-group',
                repo: repo,
                title: `Update oscal-pyprivacy to ${context.payload.release.tag_name}`,
                labels: ['dependencies']
              });
            }
```

---

**Nächste Schritte:**

1. GitHub Teams in der Organisation erstellen
2. CODEOWNERS in alle Repos kopieren
3. Organization Project Board einrichten
4. Team-Meetings in Kalender eintragen

---

**Letzte Aktualisierung**: 2026-02-03
**Verantwortlich**: Architecture Team
