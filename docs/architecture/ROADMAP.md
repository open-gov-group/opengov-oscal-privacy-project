# OpenGov OSCAL Privacy Ecosystem - Roadmap

**Version**: 1.3.0
**Stand**: 2026-02-06
**Status**: Aktiv – Phase 1 bei 70%, Phase 2 Mappings vorgezogen, Viewer Team gegründet

---

## Übersicht

```
2026                                    2027
Q1          Q2          Q3          Q4          Q1          Q2
│           │           │           │           │           │
▼           ▼           ▼           ▼           ▼           ▼
┌───────────────────────┬───────────────────────┬───────────────────────┐
│      PHASE 1          │      PHASE 2          │      PHASE 3          │
│   MVP Foundation      │    Integration        │    Erweiterung        │
│                       │                       │                       │
│ • privacy-oscal       │ • privacy-mappings    │ • oscal-workbench     │
│ • privacy-viewer      │ • privacy-gateway     │ • security-oscal      │
│ • privacy-app (MVP)   │ • privacy-data        │ • pylegal-utils       │
│ • oscal-pyprivacy     │                       │                       │
└───────────────────────┴───────────────────────┴───────────────────────┘
```

---

## Phase 1: MVP Foundation (Q1-Q2 2026)

**Ziel**: Funktionierendes End-to-End-System für erste Pilotanwender

### Meilenstein 1.1: OSCAL-Katalog-Basis
**Deadline**: Ende Februar 2026
**Status**: 90% abgeschlossen

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| DSGVO-Katalog fertigstellen | privacy-oscal | ✓ Abgeschlossen | Kritisch |
| SDM/TOM-Katalog erweitern | privacy-oscal | ✓ Struktur v1.0 | Kritisch |
| Custom Properties dokumentieren | privacy-oscal | ✓ Dokumentiert | Hoch |
| BSI Grundschutz++ Mapping | privacy-oscal | ✓ Abgeschlossen | Kritisch |
| OSCAL 1.1.2 Validierung | oscal-pyprivacy | In Arbeit | Hoch |
| Profile für Melderegister | privacy-oscal | In Arbeit | Mittel |

**Erfolgskriterien**:
- [x] Mindestens 30 DSGVO-Controls definiert (50+ erreicht)
- [x] 10 OPC-Gruppen vollständig strukturiert
- [x] SDM-Katalogstruktur v1.0 festgeschrieben
- [x] BSI Grundschutz++ Mapping abgeschlossen
- [ ] Validierung gegen OSCAL-Schema bestanden
- [ ] Profile-Resolution funktioniert

### Meilenstein 1.2: OSCAL Viewer v1.0 (Viewer Team)
**Deadline**: Ende April 2026
**Status**: NEU – Viewer Team gegründet (2026-02-06)

> **Hintergrund**: Der bestehende viewer.oscal.io unterstützt nur OSCAL bis Version 1.0.4. Da das OpenGov Ecosystem OSCAL 1.1.2 verwendet, entwickelt das Viewer Team einen eigenen, leichtgewichtigen Viewer.

**Phase 1 – Foundation (KW 6-9):**

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| Architektur-Design (ADR) | privacy-viewer | Offen | Kritisch |
| OSCAL 1.1.2 Parser | privacy-viewer | Offen | Kritisch |
| Catalog Renderer | privacy-viewer | Offen | Kritisch |
| Schema-Erkennung (1.0.x → 1.1.x) | privacy-viewer | Offen | Hoch |

**Phase 2 – Erweiterung (KW 10-12):**

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| Profile Renderer | privacy-viewer | Offen | Hoch |
| Component-Definition Renderer | privacy-viewer | Offen | Hoch |
| SSP Renderer | privacy-viewer | Offen | Hoch |
| Suchfunktion & Filter | privacy-viewer | Offen | Mittel |

**Phase 3 – Deploy (KW 13-14):**

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| GitHub Pages Deployment | privacy-viewer | Offen | Kritisch |
| PWA-Unterstützung (Offline) | privacy-viewer | Offen | Mittel |
| Dokumentation | privacy-viewer | Offen | Hoch |
| Shared Components Export | privacy-viewer | Offen | Mittel |

**Technologie-Stack:**
- TypeScript + Preact/Lit (< 10KB Bundle)
- Vite Build
- Client-Side Only (Zero-Backend)
- PWA-fähig für Offline-Betrieb

**Erfolgskriterien**:
- [ ] Alle OSCAL 1.1.2 Artefakttypen anzeigbar (Catalog, Profile, Component, SSP)
- [ ] Custom Properties (assurance_goal, legal, etc.) werden dargestellt
- [ ] Deployment auf GitHub Pages
- [ ] Bundle Size < 100KB gzipped
- [ ] WCAG 2.1 AA Accessibility
- [ ] PWA Offline-Modus funktioniert

**Team-Spezifikation**: [OSCAL_VIEWER_TEAM.md](OSCAL_VIEWER_TEAM.md)

### Meilenstein 1.3: Privacy App MVP
**Deadline**: Ende April 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| RoPA CRUD-Operationen | privacy-app | In Arbeit | Kritisch |
| Control-Zuweisung | privacy-app | Offen | Kritisch |
| Basis-Dashboard | privacy-app | Offen | Hoch |
| Benutzer-Authentifizierung | privacy-app | Offen | Hoch |
| Datenbank-Schema | privacy-app | In Arbeit | Hoch |

**Erfolgskriterien**:
- [ ] DPO kann Verarbeitungstätigkeit anlegen
- [ ] Controls können zugewiesen werden
- [ ] Einfache Compliance-Übersicht
- [ ] OAuth2-Login funktioniert

### Meilenstein 1.4: Python Library v1.0
**Deadline**: Ende Mai 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| CatalogLoader fertigstellen | oscal-pyprivacy | In Arbeit | Kritisch |
| ProfileResolver implementieren | oscal-pyprivacy | Offen | Kritisch |
| OSCALValidator fertigstellen | oscal-pyprivacy | In Arbeit | Hoch |
| PyPI-Packaging | oscal-pyprivacy | Offen | Hoch |
| Dokumentation | oscal-pyprivacy | Offen | Mittel |

**Erfolgskriterien**:
- [ ] `pip install opengov-oscal-pyprivacy` funktioniert
- [ ] Profile können aufgelöst werden
- [ ] 80% Test-Coverage
- [ ] API-Dokumentation vollständig

---

## Phase 2: Integration (Q2-Q3 2026)

**Ziel**: Vollständige Framework-Mappings und unified API

### Meilenstein 2.1: Privacy Mappings
**Deadline**: Ende Juni 2026
**Status**: Vorgezogen – BSI + ISO 27701 Mappings Q1 2026 abgeschlossen

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| BSI Grundschutz++ Mapping | privacy-oscal | ✓ Abgeschlossen | Kritisch |
| Mapping-Methodologie dokumentieren | privacy-oscal | ✓ Dokumentiert | Hoch |
| **ISO 27701:2025 Mapping** | privacy-oscal | **✓ Abgeschlossen** | Kritisch |
| ISO 27001:2022 Mapping | privacy-mappings | Teilweise | Kritisch |
| Mapping-Validierung | privacy-mappings | In Arbeit | Hoch |

**Erfolgskriterien**:
- [x] BSI Grundschutz++ Mapping vollständig (10 Gruppen, 60% Coverage)
- [x] **ISO 27701:2025 Mapping vollständig (11 Gruppen, 89% Coverage)**
- [x] Mapping-Methodik dokumentiert (BSI: 742 Zeilen, ISO: 435 Zeilen)
- [x] OSCAL-Mapping-Dateien erstellt (BSI: 947 Zeilen, ISO: 1546 Zeilen)
- [x] **Referenzierungsarchitektur OPC ↔ SPC ↔ Frameworks dokumentiert**
- [ ] ISO 27001 Mapping vollständig
- [ ] Mappings extern validiert
- [ ] Viewer zeigt Mappings an

### Meilenstein 2.2: Privacy Gateway v1.0
**Deadline**: Ende Juli 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| OpenAPI-Spezifikation | privacy-gateway | Offen | Kritisch |
| Katalog-Endpoints | privacy-gateway | Offen | Kritisch |
| Profile-Resolution-Endpoint | privacy-gateway | Offen | Hoch |
| Authentifizierung (OAuth2) | privacy-gateway | Offen | Hoch |
| Caching (Redis) | privacy-gateway | Offen | Mittel |

**Erfolgskriterien**:
- [ ] Swagger-Dokumentation verfügbar
- [ ] Alle Katalog-Operationen via API
- [ ] Rate Limiting implementiert
- [ ] 95% Uptime

### Meilenstein 2.3: Privacy Data Extraktion
**Deadline**: Ende August 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| Datenmodell finalisieren | privacy-data | Offen | Kritisch |
| Migration aus privacy-app | privacy-data | Offen | Kritisch |
| Audit-Trail implementieren | privacy-data | Offen | Hoch |
| Backup-Strategie | privacy-data | Offen | Hoch |

**Erfolgskriterien**:
- [ ] privacy-app nutzt separates Data-Repository
- [ ] Alle Änderungen protokolliert
- [ ] Backup/Restore getestet

---

## Phase 3: Erweiterung (Q3-Q4 2026)

**Ziel**: Authoring-Werkzeuge und Security-Integration

### Meilenstein 3.1: OSCAL Workbench v1.0
**Deadline**: Ende Oktober 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| Katalog-Editor UI | oscal-workbench | Offen | Kritisch |
| Profile-Builder | oscal-workbench | Offen | Kritisch |
| Mapping-Editor | oscal-workbench | Offen | Hoch |
| Git-Integration | oscal-workbench | Offen | Hoch |
| Preview im Viewer | oscal-workbench | Offen | Mittel |

**Erfolgskriterien**:
- [ ] Standards-Team kann Kataloge ohne JSON-Kenntnisse bearbeiten
- [ ] Änderungen werden direkt committet
- [ ] Live-Preview der Änderungen

### Meilenstein 3.2: Security OSCAL
**Deadline**: Ende November 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| NIST SP 800-53 importieren | security-oscal | Offen | Hoch |
| BSI IT-Grundschutz konvertieren | security-oscal | Offen | Hoch |
| ISO 27001 Annex A erstellen | security-oscal | Offen | Mittel |
| Integration mit privacy-oscal | security-oscal | Offen | Hoch |

**Erfolgskriterien**:
- [ ] Vollständiger NIST-Katalog verfügbar
- [ ] BSI-Mapping zu NIST dokumentiert
- [ ] Viewer zeigt beide Katalog-Typen

### Meilenstein 3.3: Legal Utilities
**Deadline**: Ende Dezember 2026

| Aufgabe | Repository | Status | Priorität |
|---------|------------|--------|-----------|
| GDPRParser implementieren | pylegal-utils | Offen | Mittel |
| Artikel-Extraktion | pylegal-utils | Offen | Mittel |
| Mehrsprachige Normalisierung | pylegal-utils | Offen | Niedrig |
| PyPI-Packaging | pylegal-utils | Offen | Niedrig |

**Erfolgskriterien**:
- [ ] DSGVO-Artikel können automatisch extrahiert werden
- [ ] Bürger-freundliche Texte generierbar
- [ ] DE/EN/FR unterstützt

---

## Phase 4: Enterprise Features (2027+)

**Ziel**: Enterprise-Readiness und erweiterte Integrationen

### Geplante Features

| Feature | Beschreibung | Priorität |
|---------|--------------|-----------|
| **SSP-Unterstützung** | System Security Plans in OSCAL | Hoch |
| **Automatisierte Evidence** | CI/CD-Integration für Compliance-Nachweise | Hoch |
| **AI-gestützte DSFA** | ML für Risikovorschläge | Mittel |
| **Multi-Tenant** | Mandantenfähigkeit für SaaS | Mittel |
| **Audit-Workflow** | Integrierter Audit-Prozess | Mittel |
| **Echtzeit-Dashboard** | WebSocket-basierte Updates | Niedrig |

---

## Abhängigkeiten zwischen Meilensteinen

```
M1.1 (Kataloge)
    │
    ├──────────────────────┬───────────────────┐
    │                      │                   │
    ▼                      ▼                   ▼
M1.4 (pyprivacy)      M1.2 (Viewer)       M1.3 (App)
    │                      │                   │
    │                      │                   │
    └──────────┬───────────┴───────────────────┘
               │
               ▼
          M2.1 (Mappings)
               │
               ▼
          M2.2 (Gateway)
               │
               ├───────────────────┐
               │                   │
               ▼                   ▼
          M2.3 (Data)         M3.1 (Workbench)
               │                   │
               │                   │
               └─────────┬─────────┘
                         │
                         ▼
                    M3.2 (Security)
                         │
                         ▼
                    M3.3 (Legal)
```

---

## Erfolgskriterien Gesamtprojekt

### MVP (Q2 2026)
- [ ] 2+ Pilotbehörden nutzen das System
- [ ] Bürger-Usability-Test > 80% Zufriedenheit
- [ ] DPO kann vollständiges RoPA führen
- [ ] Viewer öffentlich deployed

### v1.0 (Q4 2026)
- [ ] 10+ Behörden aktiv
- [ ] ISO 27001-Zertifizierung mit dem Tool durchgeführt
- [ ] Workbench in Produktion
- [ ] 90% Test-Coverage

### Langfristig (2027+)
- [ ] 100+ europäische Behörden
- [ ] Anerkennung durch Aufsichtsbehörden
- [ ] Community-getriebene Katalog-Pflege
- [ ] Kommerzieller Support verfügbar

---

## Risiken und Mitigationen

| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| OSCAL-Komplexität überschätzt | Mittel | Hoch | Frühe Prototypen, Schulungen |
| Zu wenig Pilotanwender | Mittel | Mittel | Aktive Akquise, Demos |
| Ressourcenmangel | Hoch | Hoch | Priorisierung, Open Source Community |
| OSCAL-Standard ändert sich | Niedrig | Mittel | Abstraktion in pyprivacy |
| Rechtliche Änderungen (DSGVO 2.0) | Niedrig | Hoch | Modulare Katalog-Struktur |

---

## Review-Zyklen

- **Wöchentlich**: Sprint-Review (technische Teams)
- **Monatlich**: Meilenstein-Review (alle Stakeholder)
- **Quartalsweise**: Roadmap-Review (Architecture Team)

---

## Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-02 | Initiale Roadmap |
| 1.1.0 | 2026-02-05 | Status-Update: M1.1 90%, M2.1 BSI-Mapping vorgezogen und abgeschlossen |
| 1.2.0 | 2026-02-05 | **ISO 27701:2025 Mapping abgeschlossen** (89% Coverage, 1546 Zeilen), Referenzierungsarchitektur dokumentiert |
| 1.3.0 | 2026-02-06 | **Viewer Team gegründet** – OSCAL 1.1.2 Viewer als Ersatz für viewer.oscal.io (nur 1.0.4), M1.2 neu strukturiert |

---

**Nächste Review**: 2026-03-01
**Verantwortlich**: Architecture Team
