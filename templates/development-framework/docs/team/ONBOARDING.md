# Onboarding Guide

**Version**: 1.0.0

---

## Willkommen im Team!

Dieser Guide hilft Dir, schnell produktiv zu werden. Arbeite die Abschnitte der Reihe nach durch.

---

## 1. Erster Tag

### 1.1 Zugänge einrichten

- [ ] GitHub Account mit Organisations-Zugang
- [ ] Repository Zugriff (Read/Write)
- [ ] Kommunikationskanäle (Slack/Discord/Teams)
- [ ] Projektmanagement-Tool (GitHub Issues/Projects)

### 1.2 Entwicklungsumgebung

```bash
# Repository klonen
git clone https://github.com/[org]/[repo].git
cd [repo]

# Dependencies installieren
npm install

# Dev Server starten
npm run dev
```

### 1.3 IDE Setup

**Empfohlen**: VS Code mit Extensions:
- ESLint
- Prettier
- TypeScript
- Error Lens
- GitLens

**Settings** (`.vscode/settings.json`):
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "typescript.preferences.importModuleSpecifier": "relative"
}
```

---

## 2. Erste Woche

### 2.1 Codebase kennenlernen

**Lese diese Dokumente** (in dieser Reihenfolge):
1. `README.md` - Projekt-Übersicht
2. `docs/architecture/ARCHITECTURE.md` - System-Architektur
3. `docs/architecture/TECH_STACK.md` - Verwendete Technologien
4. `docs/guidelines/CODE_STYLE.md` - Code-Konventionen

**Erkunde den Code**:
```
src/
├── components/     # UI-Komponenten
├── hooks/          # Custom Hooks
├── services/       # Business Logic
├── types/          # TypeScript Typen
└── utils/          # Hilfsfunktionen
```

### 2.2 Erstes Issue bearbeiten

Suche ein Issue mit Label `good-first-issue`:

```bash
# Branch erstellen
git checkout -b feature/123-mein-erstes-issue

# Änderungen committen
git add .
git commit -m "feat: beschreibung"

# Push und PR erstellen
git push -u origin feature/123-mein-erstes-issue
```

### 2.3 Code Review erhalten

- Erwarte konstruktives Feedback
- Stelle Fragen wenn etwas unklar ist
- Lerne von den Vorschlägen

---

## 3. Erste zwei Wochen

### 3.1 Workflow verstehen

**Daily Workflow**:
```
1. Morning: Stand-up (falls vorhanden)
2. Pull latest main
3. Arbeite an zugewiesenem Issue
4. Push regelmäßig
5. Review anderer PRs
```

**Definition of Done**:
- [ ] Code geschrieben und funktioniert
- [ ] Tests hinzugefügt
- [ ] Dokumentation aktualisiert (falls nötig)
- [ ] PR erstellt und reviewed
- [ ] CI/CD grün
- [ ] Gemerged

### 3.2 Testing kennenlernen

```bash
# Unit Tests
npm test

# Mit Coverage
npm test -- --coverage

# Einzelne Datei testen
npm test -- src/utils/parser.test.ts
```

### 3.3 Builds verstehen

```bash
# Production Build
npm run build

# Build analysieren
npm run build -- --analyze
```

---

## 4. Erster Monat

### 4.1 Tieferes Verständnis

- [ ] Alle Architektur-Entscheidungen (ADRs) lesen
- [ ] Deployment-Prozess verstehen
- [ ] Monitoring/Logging kennenlernen
- [ ] Security-Guidelines durcharbeiten

### 4.2 Eigenständiger arbeiten

- Übernimm komplexere Issues
- Gib selbst Code Reviews
- Schlage Verbesserungen vor
- Dokumentiere was Du lernst

### 4.3 Pair Programming

- Mach Pair Programming mit erfahrenen Teammitgliedern
- Lerne deren Arbeitsweise
- Stelle Fragen!

---

## 5. Wichtige Ressourcen

### 5.1 Dokumentation

| Dokument | Inhalt |
|----------|--------|
| `ARCHITECTURE.md` | System-Design |
| `TECH_STACK.md` | Technologien |
| `DEVELOPMENT.md` | Entwicklungs-Guidelines |
| `CODE_STYLE.md` | Code-Konventionen |
| `TESTING_STRATEGY.md` | Test-Ansatz |
| `SECURITY.md` | Sicherheits-Guidelines |

### 5.2 Externe Ressourcen

- [Preact Documentation](https://preactjs.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [OSCAL Documentation](https://pages.nist.gov/OSCAL/)

### 5.3 Kontakte

| Rolle | Kontakt |
|-------|---------|
| Tech Lead | @[name] |
| QA Lead | @[name] |
| Product Owner | @[name] |

---

## 6. Häufige Fragen

### Wie deploye ich?

Deployments passieren automatisch:
- Push zu `main` → Deployment zu Production (GitHub Pages)

### Wie debugge ich?

1. Browser DevTools öffnen (F12)
2. Console für Errors checken
3. Source Maps ermöglichen Breakpoints im Original-Code

### Was wenn Tests fehlschlagen?

```bash
# Test im Watch-Mode
npm test -- --watch

# Einzelnen Test fokussieren
it.only('should work', () => {...})
```

### Wie frage ich um Hilfe?

1. Erst selbst recherchieren (15-30 Min)
2. Problem klar formulieren
3. Was hast Du bereits versucht?
4. Frage im Team-Channel mit Kontext

---

## 7. Onboarding Feedback

Nach 2 Wochen und nach 1 Monat:
- Was hat gut funktioniert?
- Was könnte verbessert werden?
- Fehlt etwas in diesem Guide?

Feedback hilft uns, das Onboarding für zukünftige Teammitglieder zu verbessern!

---

## 8. Checkliste

### Tag 1
- [ ] Zugänge funktionieren
- [ ] Repository geklont
- [ ] Dev Server läuft
- [ ] IDE eingerichtet

### Woche 1
- [ ] README und Architektur-Docs gelesen
- [ ] Codebase erkundet
- [ ] Erstes Issue bearbeitet
- [ ] Ersten PR erstellt

### Woche 2
- [ ] Workflow verstanden
- [ ] Tests geschrieben
- [ ] Code Review gegeben
- [ ] Eigenen Code reviewed bekommen

### Monat 1
- [ ] Alle Guidelines gelesen
- [ ] Komplexeres Feature umgesetzt
- [ ] Pair Programming gemacht
- [ ] Onboarding Feedback gegeben

---

**Fragen?** Wende Dich an @[tech-lead] oder frage im #dev-channel!

---

**Letzte Aktualisierung**: [DATUM]
