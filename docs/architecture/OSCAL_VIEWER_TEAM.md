# OSCAL Viewer Team – Spezifikation und Aufgaben

**Version**: 1.0.0
**Stand**: 2026-02-06
**Status**: Neu gegründet
**Verantwortlich**: Viewer Team

---

## 1. Hintergrund und Problemstellung

### 1.1 Ausgangslage

Der bestehende **viewer.oscal.io** unterstützt nur OSCAL-Versionen bis **1.0.4**. Das OpenGov Privacy Ecosystem verwendet jedoch **OSCAL 1.1.2**, was folgende Probleme verursacht:

| Problem | Auswirkung |
|---------|------------|
| Inkompatible Schema-Version | Kataloge können nicht angezeigt werden |
| Fehlende Custom Properties | Privacy-spezifische Attribute werden ignoriert |
| Keine lokale Kontrolle | Abhängigkeit von externem Service |
| Kein Offline-Betrieb | Behörden benötigen ggf. Air-gapped Lösungen |

### 1.2 Lösungsansatz

Entwicklung eines **leichtgewichtigen OSCAL Viewers** als:
- **Stylesheet-basierte Transformation** (analog XML → XSL → HTML)
- **Client-Side Rendering** (keine Backend-Abhängigkeit)
- **GitHub Pages Deployment** (kostenlos, zuverlässig, einfach)

---

## 2. Team-Mission

> **Mission**: Einen universellen, OSCAL 1.1.2-kompatiblen Viewer entwickeln, der alle OSCAL-Artefakttypen im Browser anzeigt – ohne Backend, ohne Login, ohne Komplexität.

### 2.1 Kernprinzipien

| Prinzip | Beschreibung |
|---------|--------------|
| **Zero-Backend** | Reine Client-Side JavaScript/TypeScript Anwendung |
| **Stylesheet-Paradigma** | OSCAL JSON → HTML-Transformation wie XSL für XML |
| **Framework-agnostisch** | Minimale Abhängigkeiten (Vanilla JS oder Preact) |
| **Offline-fähig** | Progressive Web App (PWA) Unterstützung |
| **Accessibility** | WCAG 2.1 AA Konformität |

---

## 3. Aufgaben und Deliverables

### 3.1 Phase 1: Foundation (4 Wochen)

#### Aufgabe 1.1: Architektur-Design
**Priorität**: Kritisch

```
VIEWER ARCHITEKTUR
══════════════════

┌─────────────────────────────────────────────────────────────────────────────┐
│                           OSCAL VIEWER (Client-Side)                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐        │
│   │   File Input    │    │   URL Input     │    │   Drag & Drop   │        │
│   │   (local .json) │    │   (remote URL)  │    │   (file drop)   │        │
│   └────────┬────────┘    └────────┬────────┘    └────────┬────────┘        │
│            │                      │                      │                  │
│            └──────────────────────┼──────────────────────┘                  │
│                                   ▼                                         │
│                    ┌──────────────────────────────┐                         │
│                    │      OSCAL Parser            │                         │
│                    │  (Schema Detection 1.0-1.1.2)│                         │
│                    └──────────────┬───────────────┘                         │
│                                   │                                         │
│            ┌──────────────────────┼──────────────────────┐                  │
│            ▼                      ▼                      ▼                  │
│   ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐        │
│   │ Catalog Renderer│    │ Profile Renderer│    │Component Renderer│       │
│   └─────────────────┘    └─────────────────┘    └─────────────────┘        │
│            │                      │                      │                  │
│            │             ┌────────┴────────┐             │                  │
│            │             ▼                 │             │                  │
│            │    ┌─────────────────┐        │             │                  │
│            │    │  SSP Renderer   │        │             │                  │
│            │    └─────────────────┘        │             │                  │
│            │             │                 │             │                  │
│            └─────────────┼─────────────────┴─────────────┘                  │
│                          ▼                                                  │
│           ┌──────────────────────────────────┐                              │
│           │        HTML Output               │                              │
│           │  (Responsive, Accessible, Print) │                              │
│           └──────────────────────────────────┘                              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Deliverables:**
- [ ] ADR für Technologie-Entscheidung (Vanilla JS vs Preact vs Lit)
- [ ] Komponenten-Architektur dokumentiert
- [ ] Build-Tooling entschieden (Vite, esbuild, oder none)

#### Aufgabe 1.2: OSCAL Parser implementieren
**Priorität**: Kritisch

| Anforderung | Beschreibung |
|-------------|--------------|
| Schema-Erkennung | Automatische Erkennung von OSCAL 1.0.x vs 1.1.x |
| Artefakt-Typen | catalog, profile, component-definition, system-security-plan |
| Fehlerbehandlung | Graceful degradation bei ungültigen Dateien |
| Performance | Streaming-Parsing für große Dateien (>10MB) |

**Deliverables:**
- [ ] `oscal-parser.ts` – Universeller OSCAL JSON Parser
- [ ] Unit Tests für alle OSCAL-Versionen
- [ ] Beispiel-Dateien für Tests

#### Aufgabe 1.3: Catalog Renderer
**Priorität**: Kritisch

Der Catalog Renderer ist der wichtigste Renderer, da er die Basis für alle anderen bildet.

**Funktionen:**
- Hierarchische Anzeige (Gruppen → Controls → Sub-Controls)
- Property-Anzeige (alle Custom Properties wie `assurance_goal`, `legal`, etc.)
- Part-Rendering (statement, guidance, maturity-hints)
- Link-Auflösung (interne und externe Links)
- Suchfunktion (Volltext über Controls)
- Filter (nach Gruppe, Property-Werten)

**Deliverables:**
- [ ] `catalog-renderer.ts` – Catalog zu HTML Transformation
- [ ] CSS Stylesheet für Katalog-Darstellung
- [ ] Responsive Design (Mobile, Tablet, Desktop)

### 3.2 Phase 2: Erweiterung (3 Wochen)

#### Aufgabe 2.1: Profile Renderer
**Priorität**: Hoch

| Funktion | Beschreibung |
|----------|--------------|
| Import-Auflösung | Anzeige welche Controls importiert werden |
| Modify-Visualisierung | Änderungen (alter, exclude) hervorheben |
| Merge-Vorschau | Simuliertes Ergebnis der Profile-Resolution |

**Deliverables:**
- [ ] `profile-renderer.ts`
- [ ] Diff-Ansicht für Modifikationen

#### Aufgabe 2.2: Component-Definition Renderer
**Priorität**: Hoch

| Funktion | Beschreibung |
|----------|--------------|
| Komponenten-Übersicht | Liste aller definierten Komponenten |
| Control-Implementation | Welche Controls werden wie implementiert |
| Responsibility-Matrix | Anzeige der Verantwortlichkeiten |

**Deliverables:**
- [ ] `component-renderer.ts`
- [ ] Interaktive Komponenten-Diagramme

#### Aufgabe 2.3: SSP Renderer
**Priorität**: Hoch

| Funktion | Beschreibung |
|----------|--------------|
| System-Übersicht | Metadaten, Stakeholder, Autorisierung |
| Control-Status | Implementiert, geplant, nicht anwendbar |
| Nachweis-Anzeige | Verknüpfte Evidenz und Dokumentation |

**Deliverables:**
- [ ] `ssp-renderer.ts`
- [ ] Compliance-Dashboard-Ansicht

### 3.3 Phase 3: Polish & Deploy (2 Wochen)

#### Aufgabe 3.1: GitHub Pages Deployment
**Priorität**: Kritisch

```yaml
# .github/workflows/deploy.yml
name: Deploy to GitHub Pages
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci && npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

**Deliverables:**
- [ ] GitHub Actions Workflow
- [ ] Custom Domain Setup (oscal-viewer.opengov.de)
- [ ] HTTPS Konfiguration

#### Aufgabe 3.2: Progressive Web App (PWA)
**Priorität**: Mittel

| Feature | Beschreibung |
|---------|--------------|
| Service Worker | Offline-Caching der App |
| Manifest | Installation als Desktop-App |
| Cache-Strategie | Network-first für Dateien, Cache-first für Assets |

**Deliverables:**
- [ ] `service-worker.js`
- [ ] `manifest.json`
- [ ] PWA Icons (192px, 512px)

#### Aufgabe 3.3: Dokumentation
**Priorität**: Hoch

**Deliverables:**
- [ ] README.md mit Nutzungsanleitung
- [ ] CONTRIBUTING.md für Entwickler
- [ ] API-Dokumentation für Erweiterungen
- [ ] Beispiel-Integration in Drittanbieter-Websites

---

## 4. Technologie-Stack

### 4.1 Empfohlener Stack (Minimal)

| Komponente | Technologie | Begründung |
|------------|-------------|------------|
| **Sprache** | TypeScript | Typsicherheit, IDE-Support |
| **Framework** | Preact oder Lit | Minimale Bundle-Size (<10KB) |
| **Build** | Vite | Schnelles HMR, optimierter Build |
| **Styling** | CSS Modules oder Tailwind | Scoped Styles, keine Runtime |
| **Testing** | Vitest | Schnell, Vite-kompatibel |

### 4.2 Alternative: Zero-Framework

```javascript
// Beispiel: Vanilla JS Template Literals
function renderControl(control) {
  return `
    <article class="control" id="${control.id}">
      <h3>${control.title}</h3>
      <div class="properties">
        ${control.props?.map(renderProperty).join('') || ''}
      </div>
      <div class="parts">
        ${control.parts?.map(renderPart).join('') || ''}
      </div>
    </article>
  `;
}
```

### 4.3 Abhängigkeiten

| Typ | Erlaubt | Nicht erlaubt |
|-----|---------|---------------|
| **Runtime** | Preact (<5KB), Lit (<10KB) | React, Vue, Angular |
| **Utilities** | date-fns (tree-shakable) | moment.js, lodash (full) |
| **Build** | Vite, esbuild | Webpack (zu komplex) |
| **CSS** | PostCSS, Tailwind | CSS-in-JS mit Runtime |

---

## 5. Integration mit Ecosystem

### 5.1 Beziehung zu anderen Repositories

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ECOSYSTEM INTEGRATION                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   privacy-oscal ────────────────┐                                           │
│   (Kataloge)                    │                                           │
│                                 ▼                                           │
│                    ┌────────────────────────┐                               │
│                    │   OSCAL VIEWER         │◄─────── opengov-oscal-        │
│                    │   (GitHub Pages)       │         pyprivacy             │
│                    └────────────────────────┘         (Validierung)         │
│                                 ▲                                           │
│   privacy-mappings ─────────────┘                                           │
│   (Mappings)                                                                │
│                                                                             │
│   oscal-workbench ──────────────────────────────────────────────────────────│
│   (Authoring)         Teilt Rendering-Komponenten mit Viewer               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.2 Shared Components

Der Viewer soll Komponenten exportieren, die vom Workbench wiederverwendet werden können:

```typescript
// @opengov/oscal-renderer (npm package)
export { CatalogRenderer } from './renderers/catalog';
export { ProfileRenderer } from './renderers/profile';
export { ControlCard } from './components/control-card';
export { PropertyBadge } from './components/property-badge';
```

---

## 6. Akzeptanzkriterien

### 6.1 Funktionale Kriterien

| Kriterium | Beschreibung | Test |
|-----------|--------------|------|
| **Catalog-Anzeige** | Alle 10 OPC-Gruppen korrekt dargestellt | open_privacy_catalog_risk_v0.7.0.json laden |
| **Profile-Anzeige** | Import/Modify/Exclude visualisiert | profile_integrated_privacy_security.json laden |
| **SSP-Anzeige** | Compliance-Status pro Control | Test-SSP erstellen und laden |
| **URL-Import** | Direkter Link zu OSCAL-Datei funktioniert | `?url=https://...` Parameter |
| **Suche** | Volltextsuche über Controls | Nach "Verschlüsselung" suchen |
| **Filter** | Nach Gruppe/Property filtern | TOM-Gruppe filtern |

### 6.2 Nicht-funktionale Kriterien

| Kriterium | Ziel | Messung |
|-----------|------|---------|
| **Bundle Size** | < 100KB gzipped | Lighthouse |
| **First Contentful Paint** | < 1.5s | Lighthouse |
| **Accessibility** | WCAG 2.1 AA | axe DevTools |
| **Browser-Support** | Chrome, Firefox, Safari, Edge (letzte 2 Versionen) | Playwright Tests |
| **Mobile** | Vollständig responsive | Manuelle Tests |

---

## 7. Repository-Struktur

```
opengov-oscal-privacy-viewer/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Pages Deployment
├── src/
│   ├── parser/
│   │   ├── oscal-parser.ts     # Universeller OSCAL Parser
│   │   └── schema-detector.ts  # Version Detection
│   ├── renderers/
│   │   ├── catalog.ts          # Catalog → HTML
│   │   ├── profile.ts          # Profile → HTML
│   │   ├── component.ts        # Component-Definition → HTML
│   │   └── ssp.ts              # SSP → HTML
│   ├── components/
│   │   ├── control-card.ts     # Einzelne Control-Anzeige
│   │   ├── property-badge.ts   # Property-Anzeige
│   │   ├── search-bar.ts       # Suchleiste
│   │   └── filter-panel.ts     # Filter-Panel
│   ├── styles/
│   │   ├── base.css            # Basis-Styles
│   │   ├── catalog.css         # Katalog-spezifisch
│   │   └── print.css           # Druck-Styles
│   ├── app.ts                  # Hauptanwendung
│   └── index.html              # Entry Point
├── public/
│   ├── examples/               # Beispiel OSCAL-Dateien
│   └── icons/                  # PWA Icons
├── tests/
│   ├── parser.test.ts
│   └── renderers.test.ts
├── package.json
├── vite.config.ts
├── tsconfig.json
└── README.md
```

---

## 8. Zeitplan

```
VIEWER TEAM ROADMAP
═══════════════════

Februar 2026                    März 2026                      April 2026
├────────────────────────────────┼────────────────────────────────┼─────────────
│                                │                                │
│  ┌──────────────────────────┐  │  ┌──────────────────────────┐  │ ┌─────────┐
│  │  PHASE 1: Foundation     │  │  │  PHASE 2: Erweiterung    │  │ │ PHASE 3 │
│  │  • Architektur           │  │  │  • Profile Renderer      │  │ │ • Deploy│
│  │  • Parser                │  │  │  • Component Renderer    │  │ │ • PWA   │
│  │  • Catalog Renderer      │  │  │  • SSP Renderer          │  │ │ • Docs  │
│  └──────────────────────────┘  │  └──────────────────────────┘  │ └─────────┘
│                                │                                │
│  KW 6-9                        │  KW 10-12                      │ KW 13-14
└────────────────────────────────┴────────────────────────────────┴─────────────
```

---

## 9. Risiken und Mitigationen

| Risiko | Wahrscheinlichkeit | Auswirkung | Mitigation |
|--------|-------------------|------------|------------|
| Große OSCAL-Dateien verlangsamen Browser | Mittel | Hoch | Web Workers, virtualisiertes Scrolling |
| OSCAL 1.2 kommt mit Breaking Changes | Niedrig | Mittel | Modularer Parser, Schema-Abstraktion |
| Cross-Origin-Einschränkungen bei URL-Import | Hoch | Mittel | Proxy-Option dokumentieren, lokaler Upload |
| Browser-Inkompatibilitäten | Niedrig | Mittel | Polyfills, Feature Detection |

---

## 10. Erfolgsmetriken

| Metrik | Ziel (3 Monate) | Messung |
|--------|-----------------|---------|
| **Deployments** | Viewer live auf GitHub Pages | URL erreichbar |
| **Nutzung** | 100 Unique Visitors/Monat | GitHub Pages Analytics |
| **Ecosystem-Adoption** | 2 andere Repos nutzen Viewer | Integration-Links |
| **Community-Beiträge** | 3 externe PRs | GitHub Insights |

---

## 11. Team-Besetzung

### 11.1 Benötigte Rollen

| Rolle | Verantwortung | Zeitaufwand |
|-------|---------------|-------------|
| **Viewer Lead** | Architektur, Code-Review | 50% |
| **Frontend Dev** | Implementierung Renderer | 100% |
| **UX/Design** | UI Design, Accessibility | 25% |
| **QA** | Testing, Browser-Kompatibilität | 25% |

### 11.2 Kompetenzen

| Kompetenz | Erforderlich |
|-----------|--------------|
| TypeScript | Fortgeschritten |
| OSCAL-Spezifikation | Grundkenntnisse |
| HTML/CSS | Fortgeschritten |
| Accessibility (WCAG) | Grundkenntnisse |
| Git/GitHub | Fortgeschritten |

---

## 12. Referenzen

### 12.1 Externe Referenzen

- [OSCAL 1.1.2 Specification](https://pages.nist.gov/OSCAL/)
- [viewer.oscal.io (Legacy)](https://viewer.oscal.io/) – Nur bis OSCAL 1.0.4
- [Preact](https://preactjs.com/) – Minimal React Alternative
- [Lit](https://lit.dev/) – Web Components Library
- [Vite](https://vitejs.dev/) – Build Tool

### 12.2 Projekt-Referenzen

- [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) – Ecosystem-Architektur
- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – OPC-Spezifikation
- [CORE_TEAM_LIBRARIES.md](CORE_TEAM_LIBRARIES.md) – Python Libraries

---

## Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-06 | Initiale Team-Spezifikation |

---

**Letzte Aktualisierung**: 2026-02-06
**Verantwortlich**: Viewer Team
**Status**: Neu gegründet
