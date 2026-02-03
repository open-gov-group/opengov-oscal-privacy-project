# OpenGov OSCAL Privacy Ecosystem - Governance & Kommunikation

**Version**: 1.0.0
**Stand**: 2026-02-02
**Status**: Aktiv

---

## 1. Organisationsstruktur

```
                    ┌─────────────────────────────────┐
                    │     STEERING COMMITTEE          │
                    │   (Strategische Entscheidungen) │
                    └────────────────┬────────────────┘
                                     │
                    ┌────────────────┴────────────────┐
                    │                                  │
         ┌──────────▼──────────┐          ┌──────────▼──────────┐
         │  ARCHITECTURE TEAM  │          │   PRODUCT OWNER     │
         │  (Tech. Richtung)   │          │   (Fachliche Prio)  │
         └──────────┬──────────┘          └──────────┬──────────┘
                    │                                 │
         ┌──────────┴──────────────────────┬─────────┴────────┐
         │                                 │                  │
┌────────▼────────┐  ┌────────────────────▼┐  ┌─────────────▼─────────────┐
│  DEVELOPMENT    │  │  COMPLIANCE/STANDARDS│  │       OPERATIONS          │
│    TEAMS        │  │       TEAM           │  │         TEAM              │
│                 │  │                      │  │                           │
│ • Frontend      │  │ • Katalog-Pflege     │  │ • Deployment              │
│ • Backend       │  │ • Mappings           │  │ • Monitoring              │
│ • Full-Stack    │  │ • Dokumentation      │  │ • Support                 │
└─────────────────┘  └──────────────────────┘  └───────────────────────────┘
```

---

## 2. Rollen & Verantwortlichkeiten

### 2.1 Steering Committee

**Zusammensetzung:**
- Projektleiter
- Leitender Datenschutzbeauftragter
- IT-Leitung
- Vertreter Pilotbehörden

**Aufgaben:**
- Strategische Richtung
- Budget-Freigaben
- Eskalationsstufe
- Externe Kommunikation

**Treffen:** Quartalsweise

### 2.2 Architecture Team

**Zusammensetzung:**
- Lead Architect (Verantwortlich für dieses Repository)
- Senior Backend Developer
- Senior Frontend Developer
- Compliance Architect

**Aufgaben:**
- Technische Architektur-Entscheidungen (ADRs)
- Repository-übergreifende Koordination
- Technologie-Auswahl
- Code-Review für kritische Änderungen

**Treffen:** Wöchentlich

### 2.3 Product Owner

**Aufgaben:**
- Fachliche Priorisierung
- User-Story-Definition
- Stakeholder-Kommunikation
- Abnahme von Features

### 2.4 Team Leads

| Team | Verantwortlich für |
|------|-------------------|
| **Frontend** | privacy-viewer, oscal-workbench |
| **Backend** | oscal-pyprivacy, privacy-gateway, pylegal-utils |
| **Full-Stack** | privacy-app, privacy-data |
| **Compliance** | privacy-oscal, security-oscal, privacy-mappings |

---

## 3. Kommunikationskanäle

### 3.1 Asynchrone Kommunikation

| Kanal | Zweck | Zielgruppe |
|-------|-------|------------|
| **GitHub Issues** | Bugs, Features, Tasks | Entwickler |
| **GitHub Discussions** | Architektur-RFCs, Fragen | Alle |
| **GitHub Projects** | Sprint-Planung, Kanban | Teams |
| **E-Mail** | Formelle Kommunikation | Stakeholder |

### 3.2 Synchrone Kommunikation

| Meeting | Frequenz | Teilnehmer | Dauer |
|---------|----------|------------|-------|
| **Daily Standup** | Täglich | Team | 15 min |
| **Sprint Planning** | Alle 2 Wochen | Team + PO | 2 h |
| **Sprint Review** | Alle 2 Wochen | Team + Stakeholder | 1 h |
| **Retrospektive** | Alle 2 Wochen | Team | 1 h |
| **Architecture Review** | Wöchentlich | Arch Team | 1 h |
| **Stakeholder Demo** | Monatlich | Alle | 1 h |
| **Steering Committee** | Quartalsweise | SC | 2 h |

### 3.3 Dokumentation

| Typ | Ort | Verantwortlich |
|-----|-----|----------------|
| **Architektur** | Dieses Repository | Architecture Team |
| **API-Docs** | Swagger (auto-generiert) | Backend Team |
| **User-Docs** | docs/guides/ | Technical Writer |
| **ADRs** | docs/architecture/decisions/ | Architecture Team |

---

## 4. Entscheidungsprozesse

### 4.1 Technische Entscheidungen

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ENTSCHEIDUNGSPROZESS                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. VORSCHLAG                                                       │
│     └─> GitHub Discussion oder Issue erstellen                      │
│                                                                     │
│  2. DISKUSSION (1-2 Wochen)                                         │
│     └─> Team diskutiert Pros/Cons                                   │
│     └─> Alternativen werden dokumentiert                            │
│                                                                     │
│  3. ENTSCHEIDUNG                                                    │
│     ├─> Klein (1 Repo): Team Lead entscheidet                       │
│     ├─> Mittel (mehrere Repos): Architecture Team                   │
│     └─> Groß (Strategie): Steering Committee                        │
│                                                                     │
│  4. DOKUMENTATION                                                   │
│     └─> ADR erstellen (für mittlere/große Entscheidungen)           │
│                                                                     │
│  5. IMPLEMENTIERUNG                                                 │
│     └─> Pull Request mit Referenz zur Entscheidung                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.2 Entscheidungsmatrix

| Entscheidungstyp | Beispiel | Entscheider | Dokumentation |
|------------------|----------|-------------|---------------|
| **Code-Style** | Lint-Regeln | Team Lead | CONTRIBUTING.md |
| **Library-Wahl** | React vs Vue | Team Lead + Arch | ADR |
| **API-Design** | Endpoint-Struktur | Arch Team | API-Spec |
| **Framework** | OSCAL vs Custom | Arch Team + SC | ADR |
| **Roadmap** | Meilenstein-Änderung | PO + SC | ROADMAP.md |

---

## 5. Stakeholder-Kommunikation

### 5.1 Stakeholder-Gruppen

| Gruppe | Interesse | Kommunikation |
|--------|-----------|---------------|
| **Pilotbehörden** | Funktionierendes System | Monatliche Demos, Support-Kanal |
| **DPOs** | Compliance nachweisen | Newsletter, Webinare |
| **IT-Abteilungen** | Technische Integration | Technische Dokumentation |
| **Aufsichtsbehörden** | Standards-Konformität | Quartals-Reports |
| **Open-Source-Community** | Beitragen, Nutzen | GitHub, Blogs |
| **Management** | ROI, Fortschritt | Steering Committee, Dashboards |

### 5.2 Kommunikationsplan

| Stakeholder | Kanal | Frequenz | Inhalt | Verantwortlich |
|-------------|-------|----------|--------|----------------|
| Pilotbehörden | E-Mail + Teams | Wöchentlich | Status-Update | PO |
| Pilotbehörden | Workshop | Monatlich | Demo + Feedback | Team |
| Aufsichtsbehörden | Bericht | Quartalsweise | Compliance-Status | DPO |
| Community | Blog | Monatlich | Release Notes | Tech Writer |
| Community | GitHub | Kontinuierlich | Issues, PRs | Team |
| Management | Dashboard | Echtzeit | KPIs | DevOps |
| Management | Präsentation | Quartalsweise | Fortschritt | PO |

### 5.3 Eskalationspfad

```
Level 1: Team Lead
    │
    │ Nicht gelöst nach 2 Tagen
    ▼
Level 2: Architecture Team / Product Owner
    │
    │ Nicht gelöst nach 1 Woche
    ▼
Level 3: Projektleiter
    │
    │ Strategische Entscheidung nötig
    ▼
Level 4: Steering Committee
```

---

## 6. Review-Prozesse

### 6.1 Code Review

| Repository-Typ | Reviewer | Kriterien |
|----------------|----------|-----------|
| OSCAL-Kataloge | 2 (inkl. DPO) | Fachliche Korrektheit, OSCAL-Konformität |
| Mappings | 2 + Extern | Mapping-Qualität, Standards-Kenntnis |
| Libraries | 1 | Code-Qualität, Tests, Docs |
| Apps | 1 | Funktionalität, UX, Tests |

### 6.2 Architecture Review

- **Wann**: Vor größeren Änderungen (>3 Tage Arbeit)
- **Wer**: Architecture Team
- **Was**: Design-Dokument oder RFC
- **Output**: Approved / Changes Requested / Rejected

### 6.3 Security Review

- **Wann**: Vor jedem Release
- **Wer**: Security-Verantwortlicher
- **Was**: Dependency-Audit, Code-Scan
- **Output**: Security Report

---

## 7. Release-Prozess

### 7.1 Versioning

Alle Repositories folgen **Semantic Versioning**:
- **MAJOR**: Breaking Changes
- **MINOR**: Neue Features (abwärtskompatibel)
- **PATCH**: Bugfixes

### 7.2 Release-Zyklus

```
┌─────────────────────────────────────────────────────────────────────┐
│                       RELEASE-PROZESS                               │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. FEATURE FREEZE (T-7)                                            │
│     └─> Keine neuen Features mehr                                   │
│                                                                     │
│  2. RELEASE CANDIDATE (T-5)                                         │
│     └─> RC-Branch erstellen                                         │
│     └─> Intensive Tests                                             │
│                                                                     │
│  3. BUGFIX PHASE (T-5 bis T-1)                                      │
│     └─> Nur kritische Fixes                                         │
│                                                                     │
│  4. RELEASE (T)                                                     │
│     └─> Tag erstellen                                               │
│     └─> Changelog generieren                                        │
│     └─> Deployment                                                  │
│                                                                     │
│  5. POST-RELEASE (T+1)                                              │
│     └─> Kommunikation                                               │
│     └─> Monitoring                                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 7.3 Compatibility Matrix

| privacy-viewer | privacy-oscal | oscal-pyprivacy | privacy-gateway |
|----------------|---------------|-----------------|-----------------|
| 1.0.x | >= 1.0.0 | >= 1.0.0 | - |
| 1.1.x | >= 1.0.0 | >= 1.0.0 | >= 1.0.0 |
| 2.0.x | >= 2.0.0 | >= 2.0.0 | >= 2.0.0 |

---

## 8. Onboarding neuer Teammitglieder

### 8.1 Checkliste

- [ ] GitHub-Organisation einladen
- [ ] Dokumentation durchgehen (dieses Repo)
- [ ] Development Setup (siehe DEVELOPMENT.md)
- [ ] Architektur-Überblick (MASTER_BLUEPRINT.md)
- [ ] ADRs lesen
- [ ] Erstes "Good First Issue" zuweisen
- [ ] Buddy zuweisen

### 8.2 Ressourcen

| Thema | Dokument |
|-------|----------|
| Architektur | [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) |
| OSCAL-Einführung | [ADR-001](decisions/ADR-001-oscal-als-basis-standard.md) |
| Code-Style | [CODE_STYLE.md](CODE_STYLE.md) |
| Development | [DEVELOPMENT.md](DEVELOPMENT.md) |
| Roadmap | [ROADMAP.md](ROADMAP.md) |

---

## 9. Metriken & Reporting

### 9.1 KPIs

| KPI | Ziel | Messung |
|-----|------|---------|
| **Pilotbehörden** | 10 bis Q4 2026 | Registrierungen |
| **Control-Abdeckung** | 100 Controls | Katalog-Count |
| **Test-Coverage** | >80% | CI/CD |
| **Uptime** | 99.5% | Monitoring |
| **Issue-Resolution** | <7 Tage | GitHub |
| **User-Satisfaction** | >80% | Umfragen |

### 9.2 Dashboards

- **Development**: GitHub Insights
- **Operations**: Grafana / Datadog
- **Business**: Custom Dashboard (geplant)

---

## 10. Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-02 | Initiale Version |

---

**Nächste Review**: 2026-05-01
**Verantwortlich**: Architecture Team
