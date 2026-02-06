# Quality Gates

**Version**: 1.0.0

---

## 1. Übersicht

Quality Gates sind definierte Prüfpunkte, die Code passieren muss, bevor er in bestimmte Branches gemerged oder deployed werden darf.

```
Code → Pre-commit → PR Checks → Merge → Deploy
         │             │          │        │
         │             │          │        └─ Production Gate
         │             │          └─ Main Branch Gate
         │             └─ Pull Request Gate
         └─ Local Gate
```

---

## 2. Local Gate (Pre-commit)

### 2.1 Automatische Checks

```bash
# .husky/pre-commit
#!/bin/sh

# Lint staged files
npx lint-staged

# Type check
npm run type-check

# Quick unit tests
npm test -- --changed --bail
```

### 2.2 Kriterien

| Check | Tool | Bedingung |
|-------|------|-----------|
| Linting | ESLint | 0 Errors |
| Formatierung | Prettier | Alle Dateien formatiert |
| Type Check | TypeScript | 0 Errors |
| Unit Tests | Vitest | Alle bestanden |

### 2.3 Bypass (Nur in Ausnahmen!)

```bash
# NICHT empfohlen, nur für echte Notfälle
git commit --no-verify -m "hotfix: critical bug"
```

---

## 3. Pull Request Gate

### 3.1 GitHub Actions Workflow

```yaml
# .github/workflows/pr-checks.yml
name: PR Checks

on:
  pull_request:
    branches: [main]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install
        run: npm ci

      - name: Lint
        run: npm run lint

      - name: Type Check
        run: npm run type-check

      - name: Test with Coverage
        run: npm test -- --coverage

      - name: Coverage Threshold
        run: |
          COVERAGE=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
          if (( $(echo "$COVERAGE < 80" | bc -l) )); then
            echo "Coverage $COVERAGE% is below 80%"
            exit 1
          fi

      - name: Build
        run: npm run build

      - name: Bundle Size
        uses: andresz1/size-limit-action@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

### 3.2 Kriterien

| Check | Bedingung | Blocking |
|-------|-----------|----------|
| Linting | 0 Errors | ✅ Ja |
| Type Check | 0 Errors | ✅ Ja |
| Unit Tests | 100% bestanden | ✅ Ja |
| Coverage | ≥ 80% | ✅ Ja |
| Build | Erfolgreich | ✅ Ja |
| Bundle Size | < 200KB (gzip) | ⚠️ Warning |
| Security | Keine High/Critical | ✅ Ja |

### 3.3 Branch Protection Rules

```yaml
# GitHub Branch Protection für main
- Require pull request reviews: 1
- Dismiss stale pull request approvals: true
- Require status checks to pass:
  - quality
  - security
- Require branches to be up to date: true
- Require linear history: true
```

---

## 4. Main Branch Gate

### 4.1 Post-Merge Checks

```yaml
# .github/workflows/main-quality.yml
name: Main Quality

on:
  push:
    branches: [main]

jobs:
  full-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci

      # Vollständige Testsuite
      - run: npm test -- --coverage

      # E2E Tests
      - run: npx playwright install --with-deps
      - run: npm run test:e2e

      # Accessibility Audit
      - run: npm run test:a11y

      # Performance Budget
      - run: npm run lighthouse

  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm audit --audit-level=moderate
      - uses: github/codeql-action/init@v3
      - uses: github/codeql-action/analyze@v3
```

### 4.2 Kriterien

| Check | Bedingung |
|-------|-----------|
| Full Test Suite | 100% bestanden |
| E2E Tests | 100% bestanden |
| Accessibility | 0 Violations (axe) |
| Lighthouse Performance | ≥ 90 |
| Lighthouse Accessibility | ≥ 90 |
| Security Scan | Keine High/Critical |

---

## 5. Production Gate (Deploy)

### 5.1 Pre-Deploy Checks

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Verify tag is on main
      - name: Verify Tag
        run: |
          git fetch origin main
          if ! git merge-base --is-ancestor HEAD origin/main; then
            echo "Tag must be on main branch"
            exit 1
          fi

      # Run all quality checks
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build

  deploy:
    needs: verify
    runs-on: ubuntu-latest
    environment:
      name: production
      url: ${{ steps.deploy.outputs.url }}
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run build
      - name: Deploy
        id: deploy
        run: # Deploy steps...
```

### 5.2 Environment Protection

```yaml
# GitHub Environment: production
- Required reviewers: 1-2 Team Leads
- Wait timer: 5 minutes (optional)
- Deployment branches: main only
```

### 5.3 Rollback-Strategie

```yaml
# Schnelles Rollback über GitHub Actions
workflow_dispatch:
  inputs:
    version:
      description: 'Version to rollback to'
      required: true
```

---

## 6. Metrics & Thresholds

### 6.1 Code Quality Metriken

| Metrik | Threshold | Messung |
|--------|-----------|---------|
| Test Coverage | ≥ 80% | Lines covered |
| Cyclomatic Complexity | ≤ 10 | Per function |
| Code Duplication | ≤ 3% | Duplicate blocks |
| Technical Debt | ≤ 30min | SonarQube ratio |

### 6.2 Performance Metriken

| Metrik | Threshold | Tool |
|--------|-----------|------|
| First Contentful Paint | ≤ 1.8s | Lighthouse |
| Time to Interactive | ≤ 3.8s | Lighthouse |
| Bundle Size (gzip) | ≤ 200KB | size-limit |
| JS Parse Time | ≤ 500ms | Performance API |

### 6.3 Accessibility Metriken

| Metrik | Threshold | Tool |
|--------|-----------|------|
| WCAG 2.1 AA | 100% | axe-core |
| Lighthouse a11y | ≥ 90 | Lighthouse |
| Color Contrast | ≥ 4.5:1 | contrast-ratio |

---

## 7. Size Limits

```javascript
// size-limit.config.js
module.exports = [
  {
    path: 'dist/assets/*.js',
    limit: '150 KB',
    gzip: true
  },
  {
    path: 'dist/assets/*.css',
    limit: '50 KB',
    gzip: true
  },
  {
    path: 'dist/**/*',
    limit: '500 KB',
    gzip: true
  }
]
```

---

## 8. Gate Exceptions

### 8.1 Hotfix-Prozess

```markdown
## Hotfix Exception Request

- [ ] Production-kritischer Bug
- [ ] Keine Alternative möglich
- [ ] Tech Lead Approval
- [ ] Post-Hotfix Review geplant

Beschreibung:
[Was ist das Problem und warum ist ein Hotfix notwendig?]

Risiko-Bewertung:
[Welche Tests werden übersprungen? Welches Risiko besteht?]

Rollback-Plan:
[Wie kann der Hotfix rückgängig gemacht werden?]
```

### 8.2 Approval-Prozess

1. Issue mit `hotfix-exception` Label erstellen
2. Tech Lead Review und Approval
3. Hotfix durchführen mit eingeschränkten Checks
4. Post-Hotfix: Vollständige Tests + Review

---

## 9. Monitoring

### 9.1 Dashboard

Tracking der Gate-Metriken über Zeit:

- Pass/Fail Rate pro Gate
- Durchschnittliche Build-Zeit
- Coverage-Trend
- Bundle Size Trend
- Security Vulnerability Count

### 9.2 Alerting

```yaml
# Bei Threshold-Verletzungen
- Coverage dropped below 80%: Alert to #dev-alerts
- Security vulnerability found: Alert to #security
- Build time > 10min: Alert to #devops
```

---

## 10. Continuous Improvement

### 10.1 Quartalseview

- Gates noch relevant?
- Thresholds angemessen?
- Neue Checks notwendig?
- Bottlenecks identifiziert?

### 10.2 Feedback Loop

```markdown
## Gate Improvement Proposal

**Gate**: [PR Gate / Main Gate / Deploy Gate]
**Änderung**: [Neuer Check / Threshold-Anpassung / Check entfernen]
**Begründung**: [Warum ist diese Änderung sinnvoll?]
**Impact**: [Auswirkung auf Entwicklungsgeschwindigkeit]
```

---

**Letzte Aktualisierung**: [DATUM]
