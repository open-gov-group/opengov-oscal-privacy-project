# Teams & Verantwortlichkeiten

**Version**: 1.2.0
**Stand**: 2026-02-06
**Phase**: 🚀 Startphase (User-Account)

---

## Aktuelle Projektphase

> **Hinweis:** Das Projekt befindet sich in der **Startphase** und läuft unter einem GitHub User-Account (`open-gov-group`). Nach erfolgreicher Stakeholder-Abstimmung (geplant Q2/Q3 2026) erfolgt die Migration zu einer GitHub Organisation mit vollständiger Team-Struktur.
>
> Siehe: [Migrations-Plan](docs/guides/MIGRATION_TO_ORG.md)

---

## 1. Übersicht Startphase

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TEAM-STRUKTUR (Startphase)                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                         ┌─────────────────────┐                             │
│                         │   PROJEKT-OWNER     │                             │
│                         │   @open-gov-group   │                             │
│                         └──────────┬──────────┘                             │
│                                    │                                        │
│         ┌──────────────────────────┼──────────────────────────┐             │
│         │                          │                          │             │
│         ▼                          ▼                          ▼             │
│  ┌─────────────┐          ┌─────────────┐          ┌─────────────┐         │
│  │  ARCHITEKTUR │          │  ENTWICKLUNG │          │  COMPLIANCE  │         │
│  │  & Konzept   │          │  & Code      │          │  & Kataloge  │         │
│  └─────────────┘          └─────────────┘          └─────────────┘         │
│                                                                             │
│  Koordination über:                                                         │
│  • GitHub Issues mit Labels                                                 │
│  • Repository Project Boards                                                │
│  • Direkte Kommunikation                                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Repository-Verantwortlichkeiten

### 2.1 Verantwortlichkeits-Matrix

| Repository | Hauptverantwortung | Fokus |
|------------|-------------------|-------|
| **opengov-oscal-privacy-project** | Architektur | Koordination, Dokumentation |
| **opengov-privacy-oscal** | Compliance | DSGVO/SDM Kataloge |
| **opengov-security-oscal** | Compliance | NIST/BSI/ISO Kataloge |
| **opengov-privacy-mappings** | Compliance | Framework-Mappings |
| **opengov-oscal-privacy-viewer** | Entwicklung | React Frontend |
| **opengov-privacy-app** | Entwicklung | RoPA Manager (MVP) |
| **opengov-oscal-workbench** | Entwicklung | Authoring Tool |
| **opengov-privacy-gateway** | Entwicklung | REST API |
| **opengov-oscal-pyprivacy** | Entwicklung | Python Library |
| **opengov-pylegal-utils** | Entwicklung | Legal Text Processing |
| **opengov-privacy-data** | Operations | Operative Daten |

### 2.2 Issue Labels für Zuständigkeiten

Verwenden Sie Labels um Verantwortlichkeiten zuzuweisen:

| Label | Farbe | Beschreibung |
|-------|-------|--------------|
| `area:architecture` | 🟣 purple | Architektur & Konzept |
| `area:frontend` | 🔵 blue | React/TypeScript |
| `area:backend` | 🟢 green | Python/FastAPI |
| `area:compliance` | 🟠 orange | Kataloge & Standards |
| `area:operations` | ⚫ gray | DevOps & Deployment |
| `area:security` | 🔴 red | Security-relevant |

---

## 3. Koordination in der Startphase

### 3.1 Kommunikationskanäle

| Kanal | Zweck |
|-------|-------|
| **GitHub Issues** | Aufgaben, Bugs, Feature Requests |
| **GitHub Discussions** | Architektur-Fragen, RFCs |
| **GitHub Projects** | Sprint-Planung (Repository-Level) |
| **E-Mail/Chat** | Direkte Abstimmung |

### 3.2 Review-Prozess

Da keine GitHub Teams verfügbar sind:

1. **CODEOWNERS** weist `@open-gov-group` als Reviewer zu
2. **Manuelle Zuweisung** von zusätzlichen Reviewern bei Bedarf
3. **Labels** kennzeichnen den Fachbereich

### 3.3 Project Boards (Repository-Level)

Für jedes aktive Repository ein Project Board einrichten:

```
Spalten:
📥 Backlog | 📋 To Do | 🔄 In Progress | 👀 Review | ✅ Done
```

---

## 4. Entscheidungsprozesse

### 4.1 In der Startphase

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ENTSCHEIDUNGSPROZESS (Startphase)                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. VORSCHLAG                                                               │
│     └─> GitHub Issue oder Discussion erstellen                              │
│                                                                             │
│  2. DISKUSSION                                                              │
│     └─> Kommentare sammeln                                                  │
│     └─> Bei Bedarf: Stakeholder einbeziehen                                 │
│                                                                             │
│  3. ENTSCHEIDUNG                                                            │
│     └─> Projekt-Owner (@open-gov-group) entscheidet                         │
│     └─> Bei größeren Änderungen: ADR dokumentieren                          │
│                                                                             │
│  4. UMSETZUNG                                                               │
│     └─> Pull Request mit Referenz zur Entscheidung                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.2 ADR-Prozess bleibt bestehen

Architektur-Entscheidungen werden weiterhin als ADRs dokumentiert:
- Speicherort: `docs/architecture/decisions/`
- Format: Siehe bestehende ADRs

---

## 5. Onboarding (Startphase)

### 5.1 Für neue Mitwirkende

```markdown
## Schnellstart

1. [ ] README.md lesen
2. [ ] VISION_AND_CONCEPT.md durcharbeiten
3. [ ] CONTRIBUTING.md beachten
4. [ ] Relevantes Repository forken
5. [ ] Issue auswählen oder erstellen
6. [ ] Pull Request einreichen
```

### 5.2 Kontakt

- **Projekt-Owner**: @open-gov-group
- **Issues**: https://github.com/open-gov-group/opengov-oscal-privacy-project/issues
- **Discussions**: https://github.com/open-gov-group/opengov-oscal-privacy-project/discussions

---

## 6. Spezialisierte Teams

### 6.1 Viewer Team (NEU)

> **Mission**: Entwicklung eines OSCAL 1.1.2-kompatiblen Viewers als Ersatz für viewer.oscal.io (nur bis 1.0.4)

| Attribut | Beschreibung |
|----------|--------------|
| **Status** | Neu gegründet (2026-02-06) |
| **Repository** | opengov-oscal-privacy-viewer |
| **Deployment** | GitHub Pages |
| **Spezifikation** | [OSCAL_VIEWER_TEAM.md](docs/architecture/OSCAL_VIEWER_TEAM.md) |

**Kernaufgaben:**

| Phase | Aufgaben | Timeline |
|-------|----------|----------|
| **Phase 1** | OSCAL Parser, Catalog Renderer | KW 6-9 |
| **Phase 2** | Profile, Component, SSP Renderer | KW 10-12 |
| **Phase 3** | GitHub Pages Deploy, PWA, Docs | KW 13-14 |

**Technologie-Stack:**
- TypeScript + Preact/Lit (< 10KB Bundle)
- Vite Build
- Client-Side Only (Zero-Backend)
- PWA-fähig

**Warum eigenes Team?**

Der bestehende viewer.oscal.io unterstützt nur OSCAL bis Version 1.0.4. Da das OpenGov Ecosystem OSCAL 1.1.2 verwendet, benötigen wir einen eigenen Viewer, der:
- Alle Custom Properties (assurance_goal, legal, etc.) anzeigt
- Offline-fähig ist (für Air-gapped Behördennetze)
- Als Open Source für die Community verfügbar ist

---

## 7. Geplante Professionalisierung (Q2/Q3 2026)

Nach erfolgreicher Stakeholder-Abstimmung:

### 7.1 Migration zu GitHub Organisation

- [ ] Custom Domain einrichten (vor Migration)
- [ ] Neue Organisation erstellen
- [ ] Repositories transferieren
- [ ] GitHub Teams einrichten
- [ ] Organization Project Board erstellen

### 7.2 Zukünftige Team-Struktur

| Team | Repositories |
|------|--------------|
| `@org/architecture-team` | privacy-project, alle (review) |
| `@org/frontend-team` | privacy-viewer, oscal-workbench, privacy-app |
| `@org/backend-team` | privacy-gateway, oscal-pyprivacy, pylegal-utils |
| `@org/compliance-team` | privacy-oscal, security-oscal, privacy-mappings |
| `@org/operations-team` | privacy-data, deployment |

### 7.3 Vorbereitete Ressourcen

Die folgenden Dateien sind bereits vorbereitet:
- `scripts/setup-github-org.ps1` - Automatisches Setup-Script
- `scripts/setup-github-org.sh` - Bash-Version
- `docs/guides/GITHUB_SETUP.md` - Manuelle Anleitung
- `templates/` - Repository-Templates

---

## 8. Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.2.0 | 2026-02-06 | **Viewer Team** hinzugefügt – OSCAL 1.1.2 Viewer als Ersatz für viewer.oscal.io |
| 1.1.0 | 2026-02-03 | Anpassung für Startphase (User-Account) |
| 1.0.0 | 2026-02-03 | Initiale Version (Organisation geplant) |

---

**Nächste Review**: Nach Stakeholder-Abstimmung
**Verantwortlich**: @open-gov-group
