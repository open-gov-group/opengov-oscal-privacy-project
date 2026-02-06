# Release Checklist

**Version**: 1.0.0

---

## 1. Pre-Release Phase

### 1.1 Feature Freeze

- [ ] Alle geplanten Features für dieses Release gemerged
- [ ] Feature Freeze kommuniziert an Team
- [ ] Nur Bugfixes ab jetzt

### 1.2 Code Quality

- [ ] Alle Unit Tests bestanden
- [ ] Alle Integration Tests bestanden
- [ ] Test Coverage ≥ 80%
- [ ] Keine offenen kritischen Bugs
- [ ] Code Review für alle PRs abgeschlossen

### 1.3 Dependencies

- [ ] `npm audit` zeigt keine kritischen Vulnerabilities
- [ ] Dependencies auf aktuellem Stand
- [ ] Keine deprecated Packages
- [ ] Lock File aktuell (`package-lock.json`)

---

## 2. Testing Phase

### 2.1 E2E Tests

- [ ] Alle E2E Tests bestanden
- [ ] Kritische User Journeys manuell getestet:
  - [ ] Datei hochladen (drag & drop)
  - [ ] Datei hochladen (click)
  - [ ] Katalog anzeigen
  - [ ] Profil anzeigen
  - [ ] SSP anzeigen
  - [ ] Component Definition anzeigen
  - [ ] Navigation zwischen Dokumenten
  - [ ] Export-Funktionen

### 2.2 Cross-Browser Testing

| Browser | Version | Status |
|---------|---------|--------|
| Chrome | Latest | [ ] |
| Firefox | Latest | [ ] |
| Safari | Latest | [ ] |
| Edge | Latest | [ ] |

### 2.3 Responsive Testing

| Breakpoint | Status |
|------------|--------|
| Mobile (320px) | [ ] |
| Mobile (375px) | [ ] |
| Tablet (768px) | [ ] |
| Desktop (1024px) | [ ] |
| Large (1440px) | [ ] |

### 2.4 Accessibility Testing

- [ ] axe-core: 0 Violations
- [ ] Keyboard-Navigation funktioniert
- [ ] Screen Reader Test (NVDA/VoiceOver)
- [ ] Color Contrast ≥ 4.5:1
- [ ] Focus States sichtbar

### 2.5 Performance Testing

| Metrik | Ziel | Aktuell | Status |
|--------|------|---------|--------|
| Lighthouse Performance | ≥ 90 | ___ | [ ] |
| First Contentful Paint | ≤ 1.8s | ___ | [ ] |
| Time to Interactive | ≤ 3.8s | ___ | [ ] |
| Bundle Size (gzip) | ≤ 200KB | ___ | [ ] |

---

## 3. Documentation Phase

### 3.1 Changelog

- [ ] CHANGELOG.md aktualisiert
- [ ] Alle Features dokumentiert
- [ ] Breaking Changes hervorgehoben
- [ ] Migration Guide bei Breaking Changes

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Feature 1 (#PR)
- Feature 2 (#PR)

### Changed
- Change 1 (#PR)

### Fixed
- Bug fix 1 (#PR)

### Breaking Changes
- Breaking change 1 (see Migration Guide)
```

### 3.2 README

- [ ] Installation Instructions aktuell
- [ ] Neue Features dokumentiert
- [ ] Screenshots aktualisiert (falls UI-Änderungen)
- [ ] Supported Browser aktuell

### 3.3 API Documentation

- [ ] Alle neuen Funktionen dokumentiert
- [ ] JSDoc vollständig
- [ ] Beispiele aktuell

---

## 4. Release Build

### 4.1 Version Bump

```bash
# Semantic Versioning
# MAJOR.MINOR.PATCH

# Für Bugfixes
npm version patch -m "Release v%s"

# Für neue Features
npm version minor -m "Release v%s"

# Für Breaking Changes
npm version major -m "Release v%s"
```

### 4.2 Build Verification

- [ ] Production Build erfolgreich: `npm run build`
- [ ] Build-Output sauber (keine Warnings)
- [ ] Source Maps ausgeschaltet
- [ ] Environment Variables korrekt
- [ ] Base URL konfiguriert

### 4.3 Final Checks

```bash
# Preview Production Build lokal
npm run preview

# Manuelle Verifikation
# - App startet
# - Keine Console Errors
# - Alle Features funktionieren
```

---

## 5. Release Execution

### 5.1 Git Tag

```bash
# Tag erstellen
git tag -a v1.2.0 -m "Release v1.2.0"

# Tag pushen
git push origin v1.2.0
```

### 5.2 GitHub Release

- [ ] Release Draft erstellen
- [ ] Changelog in Release Notes
- [ ] Build Artifacts anhängen (falls relevant)
- [ ] Release veröffentlichen

```bash
# Via CLI
gh release create v1.2.0 --title "v1.2.0" --notes-file RELEASE_NOTES.md
```

### 5.3 Deployment

- [ ] GitHub Actions Workflow gestartet
- [ ] Build erfolgreich
- [ ] Deployment erfolgreich
- [ ] URL erreichbar

---

## 6. Post-Release Verification

### 6.1 Production Smoke Tests

- [ ] App lädt korrekt
- [ ] Keine JavaScript Errors in Console
- [ ] Kritische Funktionen arbeiten:
  - [ ] File Upload
  - [ ] Document Parsing
  - [ ] Navigation
  - [ ] Export

### 6.2 Monitoring

- [ ] Error Tracking aktiv (falls konfiguriert)
- [ ] Keine unerwarteten Errors
- [ ] Performance wie erwartet

---

## 7. Communication

### 7.1 Internal

- [ ] Team über Release informiert
- [ ] Known Issues kommuniziert
- [ ] Support-Dokumentation aktualisiert

### 7.2 External

- [ ] Release Announcement (falls öffentlich)
- [ ] Social Media (falls relevant)
- [ ] Dokumentationsseite aktualisiert

---

## 8. Rollback Plan

### 8.1 Bei kritischen Issues

```bash
# Schnelles Rollback auf vorherige Version
git checkout v1.1.0
npm run build
# Deploy previous version

# Oder via GitHub Actions
gh workflow run rollback -f version=v1.1.0
```

### 8.2 Entscheidungskriterien

| Issue | Rollback? |
|-------|-----------|
| App lädt nicht | ✅ Sofort |
| Kritische Funktion defekt | ✅ Sofort |
| Minor UI Bug | ❌ Hotfix |
| Performance degradiert | ⚠️ Prüfen |

---

## 9. Post-Mortem (bei Issues)

### 9.1 Template

```markdown
## Release Post-Mortem: vX.Y.Z

### Was ist passiert?
[Beschreibung des Problems]

### Timeline
- HH:MM: Release deployed
- HH:MM: Issue bemerkt
- HH:MM: Rollback durchgeführt

### Root Cause
[Ursache des Problems]

### Was hat funktioniert?
- [Positives]

### Was muss verbessert werden?
- [Verbesserungen]

### Action Items
- [ ] Action 1 (Owner)
- [ ] Action 2 (Owner)
```

---

## 10. Signaturen

| Rolle | Name | Datum | Signatur |
|-------|------|-------|----------|
| Tech Lead | | | |
| QA Lead | | | |
| DevOps | | | |

---

**Letzte Aktualisierung**: [DATUM]
