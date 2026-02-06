# Testing Strategy

**Version**: 1.0.0

---

## 1. Test-Philosophie

### 1.1 Grundsätze

- **Tests sind Dokumentation** - Sie zeigen erwartetes Verhalten
- **Test früh, test oft** - Fehler früh finden ist günstiger
- **Tests müssen schnell sein** - Langsame Tests werden nicht ausgeführt
- **Tests müssen zuverlässig sein** - Flaky Tests zerstören Vertrauen

### 1.2 Testing-Pyramide

```
          /\
         /  \
        / E2E\         5-10%  Kritische User Journeys
       /------\
      /        \
     / Integr.  \      20-30% Komponenten-Zusammenspiel
    /------------\
   /              \
  /     Unit       \   60-70% Einzelne Funktionen/Komponenten
 /------------------\
```

---

## 2. Test-Typen

### 2.1 Unit Tests

**Ziel**: Einzelne Funktionen/Komponenten isoliert testen

**Charakteristiken**:
- Schnell (< 100ms pro Test)
- Isoliert (keine externen Dependencies)
- Deterministisch (immer gleiches Ergebnis)

```typescript
// Beispiel: Unit Test für Parser
import { describe, it, expect } from 'vitest'
import { detectDocumentType } from '@/services/parser'

describe('detectDocumentType', () => {
  it('should detect catalog type', () => {
    const json = { catalog: { uuid: '123', metadata: {} } }
    expect(detectDocumentType(json)).toBe('catalog')
  })

  it('should return unknown for invalid input', () => {
    expect(detectDocumentType(null)).toBe('unknown')
    expect(detectDocumentType({})).toBe('unknown')
  })
})
```

**Coverage-Ziele**:
- Statements: 80%
- Branches: 75%
- Functions: 80%
- Lines: 80%

### 2.2 Integration Tests

**Ziel**: Zusammenspiel mehrerer Komponenten testen

**Charakteristiken**:
- Testen reale Interaktionen
- Können langsamer sein
- Mocken externe Services

```typescript
// Beispiel: Integration Test für File Upload
import { render, fireEvent, screen, waitFor } from '@testing-library/preact'
import { App } from '@/App'

describe('File Upload Flow', () => {
  it('should parse and display uploaded OSCAL catalog', async () => {
    const { container } = render(<App />)

    const file = new File(
      [JSON.stringify({ catalog: { uuid: '123', metadata: { title: 'Test' } } })],
      'catalog.json',
      { type: 'application/json' }
    )

    const dropzone = screen.getByTestId('file-dropzone')
    fireEvent.drop(dropzone, { dataTransfer: { files: [file] } })

    await waitFor(() => {
      expect(screen.getByText('Test')).toBeInTheDocument()
    })
  })
})
```

### 2.3 End-to-End Tests

**Ziel**: Komplette User Journeys im Browser testen

**Charakteristiken**:
- Testen aus User-Perspektive
- Langsam, aber wertvoll
- Nur kritische Pfade

```typescript
// Beispiel: E2E Test mit Playwright
import { test, expect } from '@playwright/test'

test('user can upload and view OSCAL catalog', async ({ page }) => {
  await page.goto('/')

  // Upload file
  const fileChooser = await page.waitForEvent('filechooser')
  await page.click('[data-testid="upload-button"]')
  await fileChooser.setFiles('fixtures/catalog.json')

  // Verify catalog is displayed
  await expect(page.locator('h1')).toContainText('NIST 800-53')

  // Navigate to control
  await page.click('text=AC-1')
  await expect(page.locator('.control-detail')).toBeVisible()
})
```

### 2.4 Accessibility Tests

```typescript
// Automatisierte a11y Tests mit axe
import { axe, toHaveNoViolations } from 'jest-axe'

expect.extend(toHaveNoViolations)

describe('Accessibility', () => {
  it('should have no violations on main page', async () => {
    const { container } = render(<App />)
    const results = await axe(container)
    expect(results).toHaveNoViolations()
  })
})
```

### 2.5 Visual Regression Tests

```typescript
// Mit Playwright
test('catalog view matches snapshot', async ({ page }) => {
  await page.goto('/catalog/test')
  await expect(page).toHaveScreenshot('catalog-view.png')
})
```

---

## 3. Test-Struktur

### 3.1 Dateiorganisation

```
src/
├── components/
│   ├── FileDropZone.tsx
│   └── FileDropZone.test.tsx    # Co-located Tests
├── services/
│   ├── parser.ts
│   └── parser.test.ts
tests/
├── integration/
│   └── file-upload.test.tsx
├── e2e/
│   ├── catalog-viewer.spec.ts
│   └── fixtures/
│       └── catalog.json
└── setup.ts
```

### 3.2 Test-Benennung

```typescript
describe('ComponentName', () => {
  describe('method/behavior', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange
      // Act
      // Assert
    })
  })
})

// Beispiele:
// 'should parse valid JSON when file is uploaded'
// 'should show error message when file is invalid'
// 'should disable button when form is incomplete'
```

### 3.3 AAA Pattern

```typescript
it('should calculate total correctly', () => {
  // Arrange - Setup
  const items = [{ price: 10 }, { price: 20 }]

  // Act - Execute
  const total = calculateTotal(items)

  // Assert - Verify
  expect(total).toBe(30)
})
```

---

## 4. Mocking

### 4.1 Wann Mocken

| Mocken | Nicht Mocken |
|--------|--------------|
| Externe APIs | Eigene Business Logic |
| Dateisystem | Utility Functions |
| Zeitabhängige Funktionen | Pure Functions |
| Netzwerk-Requests | State Management |

### 4.2 Mock-Beispiele

```typescript
// API Mock
import { vi } from 'vitest'

vi.mock('@/services/api', () => ({
  fetchCatalog: vi.fn().mockResolvedValue({
    catalog: { uuid: '123', metadata: { title: 'Test' } }
  })
}))

// Timer Mock
beforeEach(() => {
  vi.useFakeTimers()
})

afterEach(() => {
  vi.useRealTimers()
})

it('should debounce search', async () => {
  const onSearch = vi.fn()
  render(<SearchInput onSearch={onSearch} />)

  fireEvent.change(input, { target: { value: 'test' } })
  expect(onSearch).not.toHaveBeenCalled()

  vi.advanceTimersByTime(300)
  expect(onSearch).toHaveBeenCalledWith('test')
})
```

---

## 5. Test-Fixtures

### 5.1 Factory Functions

```typescript
// tests/factories.ts
export function createCatalog(overrides = {}): Catalog {
  return {
    uuid: crypto.randomUUID(),
    metadata: {
      title: 'Test Catalog',
      'oscal-version': '1.1.2',
      ...overrides.metadata
    },
    groups: [],
    ...overrides
  }
}

// Verwendung
const catalog = createCatalog({
  metadata: { title: 'Custom Title' }
})
```

### 5.2 Test Data Files

```
tests/
├── fixtures/
│   ├── catalog-minimal.json
│   ├── catalog-full.json
│   ├── profile-basic.json
│   └── invalid-document.json
```

---

## 6. CI/CD Integration

### 6.1 GitHub Actions

```yaml
# .github/workflows/test.yml
name: Test

on: [push, pull_request]

jobs:
  unit-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test -- --coverage
      - uses: codecov/codecov-action@v4

  e2e-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run test:e2e
      - uses: actions/upload-artifact@v4
        if: failure()
        with:
          name: playwright-report
          path: playwright-report/
```

### 6.2 Pre-commit Hook

```bash
#!/bin/sh
# .husky/pre-commit

# Run tests for changed files
npm test -- --changed
```

---

## 7. Performance Testing

### 7.1 Lighthouse CI

```yaml
# lighthouserc.js
module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/'],
      numberOfRuns: 3
    },
    assert: {
      assertions: {
        'categories:performance': ['error', { minScore: 0.9 }],
        'categories:accessibility': ['error', { minScore: 0.9 }],
        'categories:best-practices': ['error', { minScore: 0.9 }],
        'first-contentful-paint': ['error', { maxNumericValue: 2000 }]
      }
    }
  }
}
```

### 7.2 Bundle Size

```javascript
// vite.config.ts
import { visualizer } from 'rollup-plugin-visualizer'

export default {
  plugins: [
    visualizer({
      filename: 'dist/stats.html',
      open: false
    })
  ]
}
```

---

## 8. Test-Metriken

### 8.1 Coverage Reports

```bash
# Generiere Coverage Report
npm test -- --coverage

# Coverage Thresholds in vitest.config.ts
export default {
  test: {
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html', 'lcov'],
      thresholds: {
        statements: 80,
        branches: 75,
        functions: 80,
        lines: 80
      }
    }
  }
}
```

### 8.2 Test Health Dashboard

| Metrik | Ziel | Warnung |
|--------|------|---------|
| Coverage | > 80% | < 70% |
| Test Duration | < 2min | > 5min |
| Flaky Tests | 0 | > 0 |
| Skipped Tests | < 5% | > 10% |

---

## 9. Troubleshooting

### 9.1 Flaky Tests

- Timeouts erhöhen für async Operations
- `waitFor` statt fester Delays
- Test-Isolation sicherstellen
- Shared State vermeiden

### 9.2 Langsame Tests

- Teure Setup-Operationen cachen
- Parallele Ausführung nutzen
- Unnötige E2E Tests in Unit Tests umwandeln
- Mock statt echte APIs

---

**Letzte Aktualisierung**: [DATUM]
