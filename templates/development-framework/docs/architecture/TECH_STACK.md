# Technology Stack

**Version**: 1.0.0

---

## 1. Übersicht

### 1.1 Stack-Philosophie

- **Minimal Dependencies**: Nur was wirklich gebraucht wird
- **Performance First**: Kleine Bundle-Größe, schnelle Ladezeiten
- **Developer Experience**: Schnelle Builds, gutes Tooling
- **Long-Term Maintainability**: Etablierte, aktiv gepflegte Tools

### 1.2 Technology Radar

| Kategorie | Technology | Status |
|-----------|------------|--------|
| UI Framework | Preact | Adopt |
| Build Tool | Vite | Adopt |
| Language | TypeScript | Adopt |
| Styling | CSS Custom Properties | Adopt |
| Testing | Vitest | Adopt |
| E2E Testing | Playwright | Trial |
| State Management | Preact Signals | Trial |

---

## 2. Core Technologies

### 2.1 Preact

**Version**: 10.x

**Warum Preact?**
- 3KB (gzip) vs React's 40KB+
- 100% React-kompatible API
- Schnellere Runtime
- Ideal für Client-Only Apps

**Verwendung**:
```typescript
import { h, Component } from 'preact'
import { useState, useEffect } from 'preact/hooks'

// Funktionale Komponente mit Hooks
function DocumentViewer({ document }: Props) {
  const [expanded, setExpanded] = useState(false)

  return (
    <div class="viewer">
      {/* JSX wie in React */}
    </div>
  )
}
```

**Konfiguration**:
```typescript
// vite.config.ts
import preact from '@preact/preset-vite'

export default defineConfig({
  plugins: [preact()],
  esbuild: {
    jsxFactory: 'h',
    jsxFragment: 'Fragment'
  }
})
```

### 2.2 TypeScript

**Version**: 5.x

**Warum TypeScript?**
- Typsicherheit zur Compile-Zeit
- Bessere IDE-Unterstützung
- Self-documenting Code
- Einfacheres Refactoring

**Konfiguration**:
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "jsx": "react-jsx",
    "jsxImportSource": "preact",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### 2.3 Vite

**Version**: 5.x

**Warum Vite?**
- Extrem schnelle Dev-Server-Starts (ES Modules)
- Hot Module Replacement (HMR)
- Optimierte Production Builds (Rollup)
- Native TypeScript-Unterstützung

**Konfiguration**:
```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import preact from '@preact/preset-vite'

export default defineConfig({
  plugins: [preact()],
  base: './',  // Für GitHub Pages
  build: {
    target: 'es2022',
    outDir: 'dist',
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['preact']
        }
      }
    }
  },
  resolve: {
    alias: {
      '@': '/src'
    }
  }
})
```

---

## 3. Styling

### 3.1 CSS Custom Properties

**Warum?**
- Keine Build-Time-Dependencies
- Native Browser-Unterstützung
- Einfaches Theming (Dark Mode)
- Gute Performance

**Struktur**:
```css
/* src/styles/variables.css */
:root {
  /* Colors */
  --color-primary: #0066cc;
  --color-background: #ffffff;
  --color-text: #333333;

  /* Spacing */
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 1.5rem;

  /* Typography */
  --font-family: system-ui, sans-serif;
  --font-size-base: 1rem;
}

[data-theme="dark"] {
  --color-background: #1a1a1a;
  --color-text: #f0f0f0;
}
```

### 3.2 CSS Architektur

```
src/styles/
├── base.css           # Reset, Typography, Base Styles
├── variables.css      # CSS Custom Properties
├── utilities.css      # Utility Classes
└── components/        # Component-spezifische Styles
    ├── button.css
    └── input.css
```

---

## 4. Testing

### 4.1 Vitest

**Version**: 1.x

**Warum Vitest?**
- Vite-native (gleiche Config)
- Jest-kompatible API
- Sehr schnell
- Built-in Coverage

**Konfiguration**:
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./tests/setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html'],
      thresholds: {
        statements: 80,
        branches: 75,
        functions: 80,
        lines: 80
      }
    }
  }
})
```

**Test Utilities**:
```typescript
// Testing Library für Component Tests
import { render, screen, fireEvent } from '@testing-library/preact'

// Axe für Accessibility Tests
import { axe, toHaveNoViolations } from 'jest-axe'
```

### 4.2 Playwright (E2E)

**Version**: 1.x

**Warum Playwright?**
- Cross-Browser (Chromium, Firefox, WebKit)
- Schnelle Ausführung
- Auto-Wait Features
- Gute Debugging Tools

**Konfiguration**:
```typescript
// playwright.config.ts
import { defineConfig } from '@playwright/test'

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  webServer: {
    command: 'npm run preview',
    port: 4173,
    reuseExistingServer: !process.env.CI
  },
  use: {
    baseURL: 'http://localhost:4173',
    trace: 'on-first-retry'
  }
})
```

---

## 5. Linting & Formatting

### 5.1 ESLint

**Konfiguration**:
```javascript
// eslint.config.js
import eslint from '@eslint/js'
import tseslint from 'typescript-eslint'
import preact from 'eslint-plugin-preact'

export default [
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  {
    plugins: { preact },
    rules: {
      'no-console': 'error',
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/explicit-function-return-type': 'warn'
    }
  }
]
```

### 5.2 Prettier

**Konfiguration**:
```json
// .prettierrc
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100
}
```

---

## 6. Build & Deploy

### 6.1 GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test
      - run: npm run build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: dist
      - uses: actions/deploy-pages@v4
```

### 6.2 GitHub Pages

- Statisches Hosting
- Automatisches HTTPS
- Custom Domain möglich
- CDN-Distribution

---

## 7. Development Tools

### 7.1 Package Manager

**npm** (Built-in)

```bash
# Installation
npm install

# Development Server
npm run dev

# Build
npm run build

# Test
npm test
```

### 7.2 Git Hooks

**Husky + lint-staged**

```json
// package.json
{
  "lint-staged": {
    "*.{ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.css": ["prettier --write"]
  }
}
```

---

## 8. Browser Support

### 8.1 Target Browsers

```
Browserslist:
> 0.5%
last 2 versions
not dead
not ie 11
```

### 8.2 Feature Requirements

| Feature | Support |
|---------|---------|
| ES Modules | Required |
| CSS Custom Properties | Required |
| Fetch API | Required |
| File API | Required |
| localStorage | Required |
| CSS Grid | Required |
| CSS Flexbox | Required |

---

## 9. Optional Dependencies

### 9.1 Recommended (As Needed)

| Package | Purpose | When to Add |
|---------|---------|-------------|
| `dompurify` | HTML Sanitization | Bei User-Generated Content |
| `idb` | IndexedDB Wrapper | Bei größerer Datenpersistenz |
| `@preact/signals` | Reactive State | Bei komplexem State |
| `preact-router` | Routing | Bei Multi-Page App |

### 9.2 Not Recommended

| Package | Reason | Alternative |
|---------|--------|-------------|
| `moment.js` | Zu groß (300KB) | `date-fns` oder native Date |
| `lodash` (full) | Zu groß | Einzelne Funktionen oder native |
| `axios` | Nicht nötig | Native `fetch` |
| `styled-components` | Runtime Overhead | CSS Custom Properties |

---

## 10. Upgrade-Strategie

### 10.1 Regelmäßige Updates

- Wöchentlich: `npm audit` für Security
- Monatlich: Minor Version Updates
- Quartalsweise: Major Version Evaluation

### 10.2 Major Upgrades

1. **Vorbereitung**
   - Changelog lesen
   - Breaking Changes identifizieren
   - Test Coverage sicherstellen

2. **Durchführung**
   - In separatem Branch
   - Schrittweise upgraden
   - Tests nach jedem Upgrade

3. **Validierung**
   - Alle Tests bestanden
   - Manuelles Testing
   - Performance-Vergleich

---

**Letzte Aktualisierung**: [DATUM]
