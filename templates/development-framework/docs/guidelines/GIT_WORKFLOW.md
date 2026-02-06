# Git Workflow

**Version**: 1.0.0

---

## 1. Branching-Strategie

### 1.1 Branch-Typen

```
main                    # Produktionscode, immer deploybar
├── feature/XXX-name    # Neue Features
├── fix/XXX-name        # Bugfixes
├── docs/XXX-name       # Dokumentation
└── refactor/XXX-name   # Refactoring
```

### 1.2 Branch-Benennung

```
<type>/<issue-number>-<kurze-beschreibung>

Beispiele:
feature/42-catalog-viewer
fix/37-nested-groups-rendering
docs/15-api-documentation
refactor/23-parser-cleanup
```

### 1.3 Branch-Lebenszyklus

```
1. Branch von main erstellen
2. Entwickeln und committen
3. Push und Pull Request erstellen
4. Code Review
5. Nach Approval: Squash & Merge in main
6. Branch löschen
```

---

## 2. Commit Guidelines

### 2.1 Atomic Commits

Ein Commit = Eine logische Änderung

```bash
# ✅ Gut: Separate Commits
git commit -m "feat(parser): add version detection"
git commit -m "test(parser): add version detection tests"

# ❌ Schlecht: Gemischte Änderungen
git commit -m "add parser, tests, and fix styling"
```

### 2.2 Commit Message Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Subject-Regeln:**
- Imperativ verwenden ("add" nicht "added")
- Keine Großschreibung am Anfang
- Kein Punkt am Ende
- Max. 72 Zeichen

### 2.3 Commit Types

| Type | Beschreibung | Beispiel |
|------|--------------|----------|
| `feat` | Neues Feature | `feat(viewer): add dark mode toggle` |
| `fix` | Bugfix | `fix(parser): handle empty metadata` |
| `docs` | Dokumentation | `docs(readme): update installation steps` |
| `style` | Formatierung | `style: apply prettier formatting` |
| `refactor` | Refactoring | `refactor(utils): simplify date parsing` |
| `test` | Tests | `test(parser): add edge case tests` |
| `chore` | Maintenance | `chore(deps): update vitest to 1.2.0` |
| `perf` | Performance | `perf(render): memoize control list` |

---

## 3. Pull Request Workflow

### 3.1 PR erstellen

```bash
# Branch aktuell halten
git checkout main
git pull origin main
git checkout feature/42-catalog-viewer
git rebase main

# Push mit Branch-Tracking
git push -u origin feature/42-catalog-viewer
```

### 3.2 PR Template

```markdown
## Beschreibung
[Was wurde geändert und warum?]

## Issue
Closes #XX

## Art der Änderung
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation

## Checkliste
- [ ] Code folgt den Style Guidelines
- [ ] Self-Review durchgeführt
- [ ] Tests hinzugefügt/aktualisiert
- [ ] Dokumentation aktualisiert
- [ ] Keine neuen Warnings

## Screenshots (falls UI-Änderung)
[Vorher/Nachher Screenshots]

## Test-Anweisungen
[Wie kann der Reviewer die Änderungen testen?]
```

### 3.3 Review-Prozess

1. **Autor**
   - PR erstellen mit aussagekräftiger Beschreibung
   - Reviewer zuweisen
   - Labels setzen

2. **Reviewer**
   - Code-Qualität prüfen
   - Tests lokal ausführen (bei größeren Änderungen)
   - Konstruktives Feedback geben
   - Approve oder Request Changes

3. **Nach Approval**
   - Squash & Merge durchführen
   - Branch löschen

---

## 4. Merge-Strategien

### 4.1 Squash and Merge (Standard)

- Alle Commits zu einem zusammenfassen
- Saubere main-History
- Für Feature-Branches

```
Before:                After Squash & Merge:
feature/42             main
  │                      │
  ├── wip commit        ├── feat(viewer): add catalog viewer (#42)
  ├── fix typo          │
  └── cleanup           │
```

### 4.2 Rebase and Merge

- Commits einzeln übernehmen
- Für wichtige, gut strukturierte Commits

### 4.3 Merge Commit

- Für Release-Branches
- Erhält vollständige History

---

## 5. Konflikt-Lösung

### 5.1 Rebase bei Konflikten

```bash
# Branch aktualisieren
git fetch origin
git rebase origin/main

# Bei Konflikten
# 1. Konflikte in Dateien lösen
# 2. Änderungen stagen
git add <resolved-files>

# 3. Rebase fortsetzen
git rebase --continue

# Force Push (nur eigener Branch!)
git push --force-with-lease
```

### 5.2 Konflikt-Prävention

- Regelmäßig main in Feature-Branch mergen/rebasen
- Kleine, fokussierte PRs
- Kommunikation bei überlappenden Änderungen

---

## 6. Git Hooks

### 6.1 Pre-commit Hook

```bash
#!/bin/sh
# .husky/pre-commit

# Lint staged files
npx lint-staged

# Type check
npm run type-check
```

### 6.2 Commit-msg Hook

```bash
#!/bin/sh
# .husky/commit-msg

# Validate commit message format
npx commitlint --edit $1
```

### 6.3 lint-staged Konfiguration

```json
// package.json
{
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{css,md,json}": [
      "prettier --write"
    ]
  }
}
```

---

## 7. Release-Workflow

### 7.1 Semantic Versioning

```
MAJOR.MINOR.PATCH

1.0.0 → 1.0.1  # Patch: Bugfixes
1.0.1 → 1.1.0  # Minor: Neue Features (rückwärtskompatibel)
1.1.0 → 2.0.0  # Major: Breaking Changes
```

### 7.2 Release erstellen

```bash
# Version bumpen
npm version minor -m "Release v%s"

# Tag pushen
git push origin main --tags

# GitHub Release erstellen (via gh CLI)
gh release create v1.1.0 --generate-notes
```

### 7.3 Changelog

```markdown
# Changelog

## [1.1.0] - 2024-XX-XX

### Added
- Catalog viewer component (#42)
- Dark mode support (#45)

### Fixed
- Nested group rendering (#37)

### Changed
- Updated OSCAL parser for 1.1.2 (#50)
```

---

## 8. Nützliche Git-Befehle

### 8.1 Alltägliche Befehle

```bash
# Status und Diff
git status
git diff --staged

# Interaktives Stagen
git add -p

# Letzten Commit ändern
git commit --amend

# Commits anzeigen
git log --oneline -10
git log --graph --all --oneline
```

### 8.2 Branch-Management

```bash
# Alle Branches (lokal + remote)
git branch -a

# Branch löschen
git branch -d feature/done
git push origin --delete feature/done

# Remote-Branches aufräumen
git fetch --prune
```

### 8.3 Stash

```bash
# Änderungen zwischenspeichern
git stash push -m "WIP: catalog viewer"

# Stash anzeigen
git stash list

# Stash wiederherstellen
git stash pop
```

---

## 9. Geschützte Branches

### 9.1 main Branch Regeln

- Direct Push verboten
- Mindestens 1 Approval erforderlich
- Status Checks müssen bestanden sein:
  - Build
  - Tests
  - Linting
- Up-to-date mit main vor Merge

---

**Letzte Aktualisierung**: [DATUM]
