# Development Guidelines

**Version**: 1.0.0

---

## 1. Entwicklungsprinzipien

### 1.1 Clean Code

- **Lesbarkeit**: Code wird häufiger gelesen als geschrieben
- **Einfachheit**: Die einfachste Lösung ist oft die beste (KISS)
- **DRY**: Don't Repeat Yourself - Duplizierung vermeiden
- **YAGNI**: You Ain't Gonna Need It - Nur implementieren, was gebraucht wird

### 1.2 Single Responsibility

Jede Funktion, Klasse oder Modul hat genau eine Aufgabe:

```typescript
// ❌ Schlecht: Mehrere Verantwortlichkeiten
function processUserAndSendEmail(userData: UserData) {
  const user = validateUser(userData)
  saveToDatabase(user)
  sendWelcomeEmail(user.email)
}

// ✅ Gut: Separate Funktionen
function createUser(userData: UserData): User {
  return validateUser(userData)
}

function notifyNewUser(user: User): void {
  sendWelcomeEmail(user.email)
}
```

---

## 2. Code-Organisation

### 2.1 Verzeichnisstruktur

```
src/
├── components/       # UI-Komponenten
│   ├── common/       # Wiederverwendbare Komponenten
│   └── features/     # Feature-spezifische Komponenten
├── hooks/            # Custom Hooks
├── services/         # Business Logic, API-Calls
├── utils/            # Hilfsfunktionen
├── types/            # TypeScript Typen/Interfaces
├── styles/           # Globale Styles
└── constants/        # Konstanten, Konfiguration
```

### 2.2 Datei-Benennung

| Typ | Konvention | Beispiel |
|-----|------------|----------|
| Komponenten | PascalCase | `FileDropZone.tsx` |
| Hooks | camelCase mit `use` | `useFileParser.ts` |
| Utils | camelCase | `formatDate.ts` |
| Types | PascalCase | `OscalDocument.ts` |
| Tests | `.test.ts` Suffix | `parser.test.ts` |
| Styles | kebab-case | `file-drop-zone.css` |

### 2.3 Import-Reihenfolge

```typescript
// 1. External libraries
import { useState, useEffect } from 'preact/hooks'
import { render } from 'preact'

// 2. Internal modules (absolute imports)
import { parseOscal } from '@/services/parser'
import { FileDropZone } from '@/components/FileDropZone'

// 3. Types
import type { OscalDocument } from '@/types'

// 4. Styles
import './styles.css'
```

---

## 3. TypeScript Best Practices

### 3.1 Strikte Typisierung

```typescript
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true
  }
}
```

### 3.2 Type vs Interface

```typescript
// Interface für Objekte und Erweiterbarkeit
interface OscalDocument {
  uuid: string
  metadata: Metadata
}

interface Catalog extends OscalDocument {
  groups: Group[]
}

// Type für Unions, Mapped Types, Utilities
type DocumentType = 'catalog' | 'profile' | 'component-definition' | 'ssp'
type ReadonlyDocument = Readonly<OscalDocument>
```

### 3.3 Generics sinnvoll einsetzen

```typescript
// Generische Parser-Funktion
function parseDocument<T extends OscalDocument>(
  json: unknown,
  validator: (data: unknown) => data is T
): T | null {
  if (validator(json)) {
    return json
  }
  return null
}
```

---

## 4. Error Handling

### 4.1 Explizite Fehlerbehandlung

```typescript
// Result Pattern für erwartete Fehler
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E }

function parseFile(content: string): Result<OscalDocument, ParseError> {
  try {
    const json = JSON.parse(content)
    const document = validateOscal(json)
    return { success: true, data: document }
  } catch (e) {
    return {
      success: false,
      error: new ParseError('Invalid JSON format')
    }
  }
}

// Verwendung
const result = parseFile(content)
if (result.success) {
  displayDocument(result.data)
} else {
  showError(result.error.message)
}
```

### 4.2 Error Boundaries

```typescript
// Error Boundary Komponente für UI-Fehler
class ErrorBoundary extends Component<Props, State> {
  state = { hasError: false, error: null }

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error }
  }

  componentDidCatch(error: Error, info: ErrorInfo) {
    logError(error, info)
  }

  render() {
    if (this.state.hasError) {
      return <ErrorFallback error={this.state.error} />
    }
    return this.props.children
  }
}
```

---

## 5. Performance Guidelines

### 5.1 Lazy Loading

```typescript
// Lazy load große Komponenten
import { lazy, Suspense } from 'preact/compat'

const CatalogViewer = lazy(() => import('./CatalogViewer'))

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <CatalogViewer document={doc} />
    </Suspense>
  )
}
```

### 5.2 Memoization

```typescript
import { useMemo, useCallback } from 'preact/hooks'

function DocumentList({ documents, filter }: Props) {
  // Teure Berechnungen cachen
  const filteredDocs = useMemo(
    () => documents.filter(d => d.type === filter),
    [documents, filter]
  )

  // Callback-Stabilität für Child-Komponenten
  const handleSelect = useCallback(
    (id: string) => onSelect(id),
    [onSelect]
  )

  return <List items={filteredDocs} onItemSelect={handleSelect} />
}
```

### 5.3 Bundle Size

- Tree-shaking: Nur benötigte Exports importieren
- Code-Splitting: Routen-basiertes Splitting
- Dependency Audit: `npm ls` und Bundle-Analyzer nutzen

---

## 6. Kommentare und Dokumentation

### 6.1 Wann Kommentare

```typescript
// ✅ Gut: Erklären WARUM, nicht WAS
// OSCAL 1.0.x verwendet 'id', ab 1.1.0 wurde zu 'uuid' gewechselt
const identifier = document.uuid ?? document.id

// ❌ Schlecht: Offensichtliches kommentieren
// Erhöhe counter um 1
counter++
```

### 6.2 JSDoc für öffentliche APIs

```typescript
/**
 * Parst ein OSCAL-Dokument aus einem JSON-String.
 *
 * @param content - Der JSON-String des OSCAL-Dokuments
 * @returns Das geparste Dokument oder null bei ungültigem Input
 * @throws {ParseError} Bei syntaktisch ungültigem JSON
 *
 * @example
 * const doc = parseOscalDocument(jsonString)
 * if (doc) {
 *   console.log(doc.metadata.title)
 * }
 */
function parseOscalDocument(content: string): OscalDocument | null
```

---

## 7. Peer Review Kriterien

### 7.1 Review Checklist

- [ ] Code ist verständlich ohne zusätzliche Erklärung
- [ ] Funktionen sind klein und fokussiert (< 30 Zeilen)
- [ ] Keine Code-Duplizierung
- [ ] Edge Cases werden behandelt
- [ ] TypeScript Typen sind korrekt und spezifisch
- [ ] Tests sind vorhanden und aussagekräftig
- [ ] Performance wurde berücksichtigt
- [ ] Accessibility wurde berücksichtigt

### 7.2 Konstruktives Feedback

```markdown
// ✅ Gut
"Hier könnte ein `useMemo` die Performance verbessern,
da `filteredItems` bei jedem Render neu berechnet wird."

// ❌ Schlecht
"Das ist falsch"
```

---

## 8. Debugging

### 8.1 Console-Nutzung

```typescript
// Strukturiertes Logging
console.group('Document Parsing')
console.log('Input:', content.substring(0, 100))
console.log('Type detected:', docType)
console.log('Version:', version)
console.groupEnd()

// Entferne alle console.* vor Commit
// Nutze ESLint Rule: no-console
```

### 8.2 Browser DevTools

- **Elements**: DOM-Inspektion, CSS-Debugging
- **Console**: JavaScript-Fehler, Logging
- **Network**: API-Calls, Ladezeiten
- **Performance**: Profiling, Flame Charts
- **Lighthouse**: Performance, Accessibility Audits

---

**Letzte Aktualisierung**: [DATUM]
