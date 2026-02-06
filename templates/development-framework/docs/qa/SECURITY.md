# Security Guidelines

**Version**: 1.0.0

---

## 1. Security Principles

### 1.1 Defense in Depth

Mehrere Sicherheitsebenen implementieren:

```
┌─────────────────────────────────────┐
│         Browser Security            │  CSP, HTTPS, Secure Headers
├─────────────────────────────────────┤
│         Input Validation            │  Sanitization, Type Checking
├─────────────────────────────────────┤
│         Authentication              │  Sessions, Tokens
├─────────────────────────────────────┤
│         Authorization               │  Role-Based Access
├─────────────────────────────────────┤
│         Data Protection             │  Encryption, Secure Storage
└─────────────────────────────────────┘
```

### 1.2 Least Privilege

- Nur notwendige Berechtigungen anfordern
- Minimale API-Scopes
- Keine übermäßigen Dateizugriffe

### 1.3 Secure by Default

- Sicherheitseinstellungen standardmäßig aktiviert
- Opt-in für weniger sichere Optionen
- Sichere Defaults für Konfigurationen

---

## 2. OWASP Top 10 Prevention

### 2.1 Injection (A03:2021)

```typescript
// ❌ Anfällig für XSS
element.innerHTML = userInput

// ✅ Sicher
element.textContent = userInput

// ❌ Anfällig für Template Injection
const html = `<div>${userInput}</div>`

// ✅ Sicher: Sanitization
import DOMPurify from 'dompurify'
const html = `<div>${DOMPurify.sanitize(userInput)}</div>`
```

### 2.2 Broken Access Control (A01:2021)

```typescript
// Für Client-Only Apps relevant bei:
// - localStorage/sessionStorage Zugriff
// - URL-Parameter Manipulation
// - Client-side Routing

// ✅ Validiere alle Eingaben
function loadDocument(id: string): Document | null {
  // Validiere Format
  if (!isValidUUID(id)) {
    return null
  }

  // Prüfe ob Dokument existiert
  const doc = documents.get(id)
  if (!doc) {
    return null
  }

  return doc
}
```

### 2.3 Security Misconfiguration (A05:2021)

```typescript
// vite.config.ts - Sichere Build-Konfiguration
export default defineConfig({
  build: {
    // Keine Source Maps in Production
    sourcemap: false,
  },
  server: {
    // Nur localhost in Development
    host: 'localhost',
  }
})
```

### 2.4 Vulnerable Dependencies (A06:2021)

```bash
# Regelmäßig prüfen
npm audit

# Automatische Updates (Dependabot)
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

---

## 3. Content Security Policy (CSP)

### 3.1 Strikte CSP

```html
<!-- index.html -->
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data: blob:;
  font-src 'self';
  connect-src 'self';
  frame-ancestors 'none';
  form-action 'self';
  base-uri 'self';
">
```

### 3.2 CSP Erklärung

| Direktive | Wert | Bedeutung |
|-----------|------|-----------|
| `default-src` | 'self' | Nur eigene Domain als Default |
| `script-src` | 'self' | Keine Inline-Scripts, keine externen |
| `style-src` | 'self' 'unsafe-inline' | Eigene CSS + Inline für Frameworks |
| `img-src` | 'self' data: blob: | Bilder, Data URLs, Blobs |
| `connect-src` | 'self' | Fetch/XHR nur zu eigener Domain |
| `frame-ancestors` | 'none' | Nicht in iframes einbettbar |

---

## 4. Secure Headers

```typescript
// Bei GitHub Pages werden diese oft via _headers oder netlify.toml gesetzt

// Empfohlene Security Headers:
{
  "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
  "X-Content-Type-Options": "nosniff",
  "X-Frame-Options": "DENY",
  "X-XSS-Protection": "1; mode=block",
  "Referrer-Policy": "strict-origin-when-cross-origin",
  "Permissions-Policy": "camera=(), microphone=(), geolocation=()"
}
```

---

## 5. Client-Side Security

### 5.1 Input Validation

```typescript
// Alle externen Inputs validieren
interface OscalDocument {
  uuid: string
  metadata: {
    title: string
    'oscal-version': string
  }
}

function isValidOscalDocument(data: unknown): data is OscalDocument {
  if (typeof data !== 'object' || data === null) {
    return false
  }

  const obj = data as Record<string, unknown>

  // Prüfe Struktur
  if (!obj.uuid || typeof obj.uuid !== 'string') {
    return false
  }

  if (!obj.metadata || typeof obj.metadata !== 'object') {
    return false
  }

  const metadata = obj.metadata as Record<string, unknown>

  if (!metadata.title || typeof metadata.title !== 'string') {
    return false
  }

  return true
}

// Verwendung
function parseDocument(json: unknown): Result<OscalDocument> {
  if (!isValidOscalDocument(json)) {
    return { success: false, error: 'Invalid document structure' }
  }
  return { success: true, data: json }
}
```

### 5.2 Secure Storage

```typescript
// ❌ Keine sensitiven Daten im localStorage
localStorage.setItem('apiKey', secretKey)

// ✅ Nur nicht-sensitive Daten
localStorage.setItem('theme', 'dark')
localStorage.setItem('lastOpenedFile', 'catalog.json')

// Für Session-Daten: sessionStorage
sessionStorage.setItem('currentDocumentId', docId)
```

### 5.3 URL/Query Parameter

```typescript
// Validiere URL Parameter
const params = new URLSearchParams(window.location.search)
const docId = params.get('doc')

if (docId && !isValidDocumentId(docId)) {
  // Redirect to safe page
  window.location.href = '/'
}
```

---

## 6. File Handling Security

### 6.1 File Type Validation

```typescript
const ALLOWED_TYPES = ['application/json', 'text/xml']
const MAX_FILE_SIZE = 10 * 1024 * 1024 // 10MB

function validateFile(file: File): Result<File> {
  // Prüfe Dateityp
  if (!ALLOWED_TYPES.includes(file.type)) {
    return {
      success: false,
      error: `Invalid file type: ${file.type}`
    }
  }

  // Prüfe Dateigröße
  if (file.size > MAX_FILE_SIZE) {
    return {
      success: false,
      error: 'File too large (max 10MB)'
    }
  }

  // Prüfe Dateiendung
  const extension = file.name.split('.').pop()?.toLowerCase()
  if (!['json', 'xml'].includes(extension || '')) {
    return {
      success: false,
      error: 'Invalid file extension'
    }
  }

  return { success: true, data: file }
}
```

### 6.2 Content Parsing

```typescript
function parseJsonSafely(content: string): Result<unknown> {
  try {
    // JSON.parse ist sicher gegen Code Injection
    const data = JSON.parse(content)
    return { success: true, data }
  } catch (e) {
    return {
      success: false,
      error: 'Invalid JSON format'
    }
  }
}

// XML parsing mit DOMParser (sicher gegen XXE in Browsern)
function parseXmlSafely(content: string): Result<Document> {
  const parser = new DOMParser()
  const doc = parser.parseFromString(content, 'text/xml')

  const parseError = doc.querySelector('parsererror')
  if (parseError) {
    return {
      success: false,
      error: 'Invalid XML format'
    }
  }

  return { success: true, data: doc }
}
```

---

## 7. Dependencies

### 7.1 Dependency Review

```yaml
# .github/workflows/security.yml
name: Security

on:
  push:
    branches: [main]
  pull_request:
  schedule:
    - cron: '0 0 * * 1'  # Wöchentlich Montags

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Run npm audit
        run: npm audit --audit-level=high

      - name: Run Snyk
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

### 7.2 Lock File

```bash
# Immer mit Lock File installieren
npm ci  # nicht npm install in CI

# Lock File committen
git add package-lock.json
```

### 7.3 Minimal Dependencies

```json
// Vor dem Hinzufügen einer Dependency prüfen:
// 1. Ist sie wirklich notwendig?
// 2. Wie groß ist sie? (bundlephobia.com)
// 3. Wird sie aktiv gepflegt?
// 4. Hat sie bekannte Vulnerabilities?
```

---

## 8. Security Testing

### 8.1 Static Analysis

```bash
# ESLint Security Plugin
npm install eslint-plugin-security --save-dev
```

```javascript
// .eslintrc.js
module.exports = {
  plugins: ['security'],
  extends: ['plugin:security/recommended'],
  rules: {
    'security/detect-object-injection': 'warn',
    'security/detect-non-literal-regexp': 'warn',
    'security/detect-unsafe-regex': 'error'
  }
}
```

### 8.2 Automated Scans

```yaml
# GitHub CodeQL Analysis
name: CodeQL

on:
  push:
    branches: [main]
  pull_request:
  schedule:
    - cron: '0 0 * * 0'

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript-typescript
      - uses: github/codeql-action/analyze@v3
```

### 8.3 Manual Review Checklist

- [ ] Keine sensitiven Daten im Code/Repository
- [ ] Alle Inputs werden validiert
- [ ] Keine `innerHTML` ohne Sanitization
- [ ] CSP ist konfiguriert
- [ ] Dependencies sind aktuell
- [ ] Keine Development-Secrets in Production

---

## 9. Incident Response

### 9.1 Bei Security Issues

1. **Nicht öffentlich diskutieren** - Kein öffentliches Issue erstellen
2. **Security Advisory nutzen** - GitHub Security Advisories
3. **Fix entwickeln** - In privatem Fork
4. **Koordiniert veröffentlichen** - Mit Advisory und Fix zusammen

### 9.2 Kontakt

Security-relevante Issues melden an:
- GitHub Security Advisory erstellen
- Oder: security@[project-domain].org

---

## 10. Compliance

### 10.1 Datenschutz (für Client-Only Apps)

- Keine Telemetrie ohne Consent
- Keine Cookies ohne Notwendigkeit
- Klare Datenschutzhinweise wenn Daten gespeichert werden

### 10.2 Lizenz-Compliance

```bash
# Lizenz-Check für Dependencies
npx license-checker --summary
npx license-checker --onlyAllow "MIT;Apache-2.0;BSD-3-Clause;ISC"
```

---

**Letzte Aktualisierung**: [DATUM]
