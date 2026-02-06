# Code Style Guide

**Version**: 1.0.0

---

## 1. Formatierung

### 1.1 Automatische Formatierung

Wir verwenden Prettier für konsistente Formatierung:

```json
// .prettierrc
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100,
  "bracketSpacing": true,
  "arrowParens": "avoid"
}
```

### 1.2 Einrückung

- **2 Spaces** für alle Dateien
- Keine Tabs

### 1.3 Zeilenlänge

- Maximum **100 Zeichen** pro Zeile
- Bei langen Strings: Template Literals oder Konkatenation

---

## 2. Naming Conventions

### 2.1 Variablen und Funktionen

```typescript
// camelCase für Variablen und Funktionen
const documentCount = 5
function parseDocument(content: string): Document {}

// Boolesche Variablen mit Prefix
const isLoading = false
const hasError = true
const canSubmit = true
const shouldRefresh = false
```

### 2.2 Konstanten

```typescript
// UPPER_SNAKE_CASE für echte Konstanten
const MAX_FILE_SIZE = 10 * 1024 * 1024  // 10MB
const SUPPORTED_VERSIONS = ['1.0.0', '1.0.4', '1.1.0', '1.1.2'] as const
const API_ENDPOINTS = {
  CATALOG: '/api/catalog',
  PROFILE: '/api/profile',
} as const
```

### 2.3 Typen und Interfaces

```typescript
// PascalCase für Typen und Interfaces
interface OscalDocument {
  uuid: string
  metadata: DocumentMetadata
}

type DocumentType = 'catalog' | 'profile' | 'ssp'

// Props-Interface mit Suffix
interface FileDropZoneProps {
  onFileDrop: (file: File) => void
  acceptedTypes: string[]
}
```

### 2.4 Komponenten

```typescript
// PascalCase für Komponenten
function FileDropZone({ onFileDrop }: FileDropZoneProps) {
  return <div className="file-drop-zone">...</div>
}

// Keine Default Exports für Komponenten
export { FileDropZone }
```

### 2.5 Event Handler

```typescript
// handle + Element + Event
function handleButtonClick() {}
function handleInputChange() {}
function handleFormSubmit() {}

// on + Action für Props
interface Props {
  onSelect: (id: string) => void
  onChange: (value: string) => void
  onSubmit: (data: FormData) => void
}
```

---

## 3. TypeScript Spezifisch

### 3.1 Type Annotations

```typescript
// Explizite Return Types für öffentliche Funktionen
function parseVersion(doc: OscalDocument): string {
  return doc.metadata['oscal-version']
}

// Inferenz für lokale Variablen ist OK
const version = parseVersion(doc)  // string wird inferiert
```

### 3.2 Type Assertions

```typescript
// ❌ Vermeiden: as any
const data = response as any

// ✅ Besser: Explizite Typen oder Type Guards
function isOscalDocument(data: unknown): data is OscalDocument {
  return (
    typeof data === 'object' &&
    data !== null &&
    'uuid' in data &&
    'metadata' in data
  )
}

if (isOscalDocument(response)) {
  // response ist jetzt typsicher OscalDocument
}
```

### 3.3 Nullish Handling

```typescript
// Nullish Coalescing für Defaults
const title = document.metadata.title ?? 'Untitled'

// Optional Chaining für sichere Zugriffe
const version = document?.metadata?.['oscal-version']

// Nicht verwenden wenn undefined ein gültiger Wert ist
const count = items.length || 10  // ❌ 0 wird zu 10
const count = items.length ?? 10  // ✅ 0 bleibt 0
```

---

## 4. JSX/TSX Konventionen

### 4.1 Komponenten-Struktur

```typescript
// Empfohlene Reihenfolge in Komponenten
function DocumentViewer({ document, onClose }: DocumentViewerProps) {
  // 1. Hooks
  const [isExpanded, setIsExpanded] = useState(false)
  const ref = useRef<HTMLDivElement>(null)

  // 2. Derived State / Computed Values
  const title = document.metadata.title
  const controlCount = document.controls?.length ?? 0

  // 3. Effects
  useEffect(() => {
    // ...
  }, [document])

  // 4. Event Handlers
  const handleToggle = () => {
    setIsExpanded(prev => !prev)
  }

  // 5. Early Returns
  if (!document) {
    return <EmptyState />
  }

  // 6. Main Render
  return (
    <div ref={ref} className="document-viewer">
      ...
    </div>
  )
}
```

### 4.2 Props Destructuring

```typescript
// ✅ Destructure in der Funktionssignatur
function Button({ label, onClick, disabled = false }: ButtonProps) {
  return <button onClick={onClick} disabled={disabled}>{label}</button>
}

// ❌ Nicht im Body destructuren
function Button(props: ButtonProps) {
  const { label, onClick } = props  // Vermeiden
}
```

### 4.3 Conditional Rendering

```typescript
// Einfache Bedingungen: &&
{isLoading && <Spinner />}

// Mit Fallback: Ternary
{isLoading ? <Spinner /> : <Content />}

// Komplexere Logik: Early Return oder Variable
function Status({ state }: { state: 'loading' | 'error' | 'success' }) {
  if (state === 'loading') return <Spinner />
  if (state === 'error') return <Error />
  return <Success />
}
```

### 4.4 Listen und Keys

```typescript
// Stabile Keys verwenden (IDs, nicht Indices)
{controls.map(control => (
  <Control key={control.id} data={control} />
))}

// Wenn keine ID verfügbar: Kombination aus stabilen Werten
{items.map((item, index) => (
  <Item key={`${item.name}-${item.type}`} data={item} />
))}
```

---

## 5. CSS Konventionen

### 5.1 Klassennamen (BEM-inspiriert)

```css
/* Block */
.document-viewer { }

/* Element */
.document-viewer__header { }
.document-viewer__content { }

/* Modifier */
.document-viewer--expanded { }
.document-viewer__header--sticky { }
```

### 5.2 CSS Custom Properties

```css
:root {
  /* Colors */
  --color-primary: #0066cc;
  --color-text: #333333;
  --color-background: #ffffff;

  /* Spacing */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;

  /* Typography */
  --font-family-base: system-ui, sans-serif;
  --font-family-mono: 'Fira Code', monospace;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.25rem;
}
```

### 5.3 Responsive Design

```css
/* Mobile First */
.container {
  padding: var(--spacing-sm);
}

@media (min-width: 768px) {
  .container {
    padding: var(--spacing-md);
  }
}

@media (min-width: 1024px) {
  .container {
    padding: var(--spacing-lg);
  }
}
```

---

## 6. Imports und Exports

### 6.1 Named Exports bevorzugen

```typescript
// ✅ Named Exports
export function parseDocument() {}
export const VERSION = '1.0.0'
export type { DocumentType }

// Komponenten-Export
export { FileDropZone }

// ❌ Default Exports vermeiden (außer bei Seiten/Routes)
export default function Component() {}
```

### 6.2 Barrel Exports

```typescript
// components/index.ts
export { FileDropZone } from './FileDropZone'
export { DocumentViewer } from './DocumentViewer'
export { ControlList } from './ControlList'

// Verwendung
import { FileDropZone, DocumentViewer } from '@/components'
```

---

## 7. ESLint Konfiguration

```javascript
// .eslintrc.js
module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:preact/recommended',
    'prettier'
  ],
  rules: {
    // Errors
    'no-console': 'error',
    'no-debugger': 'error',
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],

    // Warnings
    'prefer-const': 'warn',
    '@typescript-eslint/explicit-function-return-type': ['warn', {
      allowExpressions: true
    }],

    // Off
    'react/prop-types': 'off'  // TypeScript übernimmt
  }
}
```

---

## 8. Git Commit Messages

### 8.1 Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 8.2 Types

| Type | Beschreibung |
|------|--------------|
| `feat` | Neues Feature |
| `fix` | Bugfix |
| `docs` | Dokumentation |
| `style` | Formatierung (kein Code-Change) |
| `refactor` | Code-Änderung ohne Feature/Fix |
| `test` | Tests hinzufügen/ändern |
| `chore` | Build, Dependencies, Config |

### 8.3 Beispiele

```
feat(parser): add support for OSCAL 1.1.2

- Implement new control structure parsing
- Add backward compatibility for 1.0.x format
- Update type definitions

Closes #42
```

```
fix(viewer): correct rendering of nested groups

The recursive group rendering was not handling empty
subgroups correctly, causing a blank screen.

Fixes #37
```

---

**Letzte Aktualisierung**: [DATUM]
