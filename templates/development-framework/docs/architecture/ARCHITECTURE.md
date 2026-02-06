# System Architecture

**Version**: 1.0.0

---

## 1. Übersicht

### 1.1 System Context

```
┌──────────────────────────────────────────────────────────┐
│                     External Systems                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                │
│  │ OSCAL    │  │ GitHub   │  │ External │                │
│  │ Files    │  │ Pages    │  │ Catalogs │                │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘                │
│       │             │             │                       │
│       ▼             ▼             ▼                       │
│  ┌─────────────────────────────────────────────────┐     │
│  │              [Application Name]                  │     │
│  │     Client-Side Web Application (SPA)           │     │
│  └─────────────────────────────────────────────────┘     │
│                          │                                │
│                          ▼                                │
│  ┌─────────────────────────────────────────────────┐     │
│  │                   Browser                        │     │
│  │        (localStorage, IndexedDB)                 │     │
│  └─────────────────────────────────────────────────┘     │
└──────────────────────────────────────────────────────────┘
```

### 1.2 Architektur-Prinzipien

| Prinzip | Beschreibung |
|---------|--------------|
| **Client-First** | Alle Logik läuft im Browser, kein Backend erforderlich |
| **Offline-Capable** | Kernfunktionalität auch ohne Internet |
| **Privacy by Design** | Keine Daten verlassen den Client ohne Einwilligung |
| **Progressive Enhancement** | Grundfunktionen überall, erweiterte Features wo unterstützt |

---

## 2. Container-Diagramm

```
┌─────────────────────────────────────────────────────────┐
│                    Web Application                       │
│  ┌─────────────────────────────────────────────────┐   │
│  │                 Presentation Layer               │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐    │   │
│  │  │  Views   │ │Components│ │   Layouts    │    │   │
│  │  └──────────┘ └──────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │                Application Layer                 │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐    │   │
│  │  │  Hooks   │ │  State   │ │   Services   │    │   │
│  │  └──────────┘ └──────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │                  Domain Layer                    │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐    │   │
│  │  │  Types   │ │ Parsers  │ │  Validators  │    │   │
│  │  └──────────┘ └──────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │               Infrastructure Layer               │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐    │   │
│  │  │ Storage  │ │  File IO │ │    Utils     │    │   │
│  │  └──────────┘ └──────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 3. Layer-Beschreibung

### 3.1 Presentation Layer

**Verantwortung**: UI-Rendering, User Interaction

```
src/
├── components/
│   ├── common/          # Wiederverwendbare UI-Komponenten
│   │   ├── Button.tsx
│   │   ├── Input.tsx
│   │   └── Modal.tsx
│   └── features/        # Feature-spezifische Komponenten
│       ├── FileDropZone.tsx
│       └── DocumentViewer.tsx
├── layouts/
│   └── MainLayout.tsx
└── views/
    ├── Home.tsx
    └── Viewer.tsx
```

**Regeln**:
- Keine Business-Logik in Komponenten
- Nutzt Hooks für State und Side Effects
- Styled über CSS Modules oder Utility Classes

### 3.2 Application Layer

**Verantwortung**: Koordination, State Management, Use Cases

```
src/
├── hooks/
│   ├── useDocument.ts    # Dokument-bezogene Logik
│   └── useFileParser.ts  # Datei-Parsing
├── state/
│   ├── store.ts          # Globaler State
│   └── actions.ts        # State-Mutationen
└── services/
    ├── parser.ts         # Parsing-Koordination
    └── export.ts         # Export-Funktionen
```

**Regeln**:
- Orchestriert Domain-Operationen
- Managed Application State
- Abstrahiert Infrastructure Details

### 3.3 Domain Layer

**Verantwortung**: Business-Logik, Domain-Modelle

```
src/
├── types/
│   ├── oscal.ts          # OSCAL-Typen
│   └── document.ts       # Interne Modelle
├── parsers/
│   ├── catalog.ts        # Catalog-Parser
│   ├── profile.ts        # Profile-Parser
│   └── ssp.ts            # SSP-Parser
└── validators/
    └── schema.ts         # JSON-Schema Validierung
```

**Regeln**:
- Unabhängig von UI-Framework
- Unabhängig von Infrastructure
- Pure Functions wo möglich

### 3.4 Infrastructure Layer

**Verantwortung**: Externe Systeme, Persistenz, Utilities

```
src/
├── storage/
│   ├── local.ts          # localStorage Abstraktion
│   └── indexed.ts        # IndexedDB Abstraktion
├── fileio/
│   └── reader.ts         # File API Wrapper
└── utils/
    ├── date.ts           # Datums-Utilities
    └── format.ts         # Formatierungs-Utilities
```

**Regeln**:
- Interfaces für alle externen Abhängigkeiten
- Leicht austauschbar durch Abstraktion
- Enthält Adapter-Logik

---

## 4. Datenfluss

### 4.1 File Upload Flow

```
User                 UI                   Application            Domain
 │                   │                        │                    │
 │  Drop File        │                        │                    │
 ├──────────────────►│                        │                    │
 │                   │  onFileDrop(file)      │                    │
 │                   ├───────────────────────►│                    │
 │                   │                        │  readFile(file)    │
 │                   │                        ├───────────────────►│
 │                   │                        │                    │
 │                   │                        │  parseOscal(json)  │
 │                   │                        ├───────────────────►│
 │                   │                        │   ◄────────────────┤
 │                   │                        │   OscalDocument    │
 │                   │  setDocument(doc)      │                    │
 │                   │◄───────────────────────┤                    │
 │  Render Document  │                        │                    │
 │◄──────────────────┤                        │                    │
```

### 4.2 State Updates

```typescript
// Unidirektionaler Datenfluss
Action → Reducer → New State → Re-render

// Beispiel
const [state, dispatch] = useReducer(reducer, initialState)

function handleFileLoad(file: File) {
  dispatch({ type: 'LOADING_START' })

  parseFile(file)
    .then(doc => dispatch({ type: 'DOCUMENT_LOADED', payload: doc }))
    .catch(err => dispatch({ type: 'ERROR', payload: err }))
}
```

---

## 5. Komponenten-Kommunikation

### 5.1 Props (Parent → Child)

```typescript
// Daten fließen nach unten
<DocumentViewer document={currentDoc} onClose={handleClose} />
```

### 5.2 Callbacks (Child → Parent)

```typescript
// Events fließen nach oben
function FileDropZone({ onFileDrop }: Props) {
  const handleDrop = (e: DragEvent) => {
    const file = e.dataTransfer.files[0]
    onFileDrop(file)
  }
}
```

### 5.3 Context (Cross-Component)

```typescript
// Für globalen State
const ThemeContext = createContext<ThemeContextValue>(defaultValue)

function App() {
  return (
    <ThemeContext.Provider value={themeValue}>
      <MainLayout />
    </ThemeContext.Provider>
  )
}
```

---

## 6. Error Handling Strategie

### 6.1 Error Boundaries

```typescript
// Für UI-Fehler
<ErrorBoundary fallback={<ErrorPage />}>
  <DocumentViewer />
</ErrorBoundary>
```

### 6.2 Result Pattern

```typescript
// Für erwartete Fehler in Domain-Logik
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E }

function parseDocument(content: string): Result<OscalDocument, ParseError> {
  // ...
}
```

### 6.3 Error Logging

```typescript
// Zentrale Fehler-Erfassung
function logError(error: Error, context?: Record<string, unknown>) {
  console.error('Application Error:', {
    message: error.message,
    stack: error.stack,
    ...context
  })
  // Optional: Error Tracking Service
}
```

---

## 7. Performance-Strategien

### 7.1 Code Splitting

```typescript
// Route-basiertes Splitting
const CatalogViewer = lazy(() => import('./views/CatalogViewer'))

// Conditional Loading
if (needsFeature) {
  const module = await import('./features/advanced')
}
```

### 7.2 Memoization

```typescript
// Komponenten-Memoization
const MemoizedList = memo(ControlList)

// Value Memoization
const expensiveValue = useMemo(() => compute(data), [data])
```

### 7.3 Virtual Scrolling

```typescript
// Für große Listen
import { VirtualList } from '@/components/common'

<VirtualList
  items={controls}
  itemHeight={50}
  renderItem={control => <ControlRow data={control} />}
/>
```

---

## 8. Security Considerations

### 8.1 Input Validation

- Alle File-Uploads validieren
- JSON-Parsing in try-catch
- Schema-Validierung vor Verarbeitung

### 8.2 Content Security

- Strikte CSP konfiguriert
- Keine `innerHTML` ohne Sanitization
- Keine `eval()` oder dynamische Skript-Ausführung

### 8.3 Data Handling

- Keine Secrets im Client
- Sensitive Daten nur in Memory
- Keine Persistierung von Credentials

---

## 9. Erweiterbarkeit

### 9.1 Plugin-Architektur (Optional)

```typescript
interface ParserPlugin {
  name: string
  supportedTypes: string[]
  parse(content: unknown): OscalDocument
}

// Neue Parser registrieren
registerParser(customPlugin)
```

### 9.2 Feature Flags

```typescript
const features = {
  experimentalExport: false,
  darkMode: true,
}

if (features.experimentalExport) {
  // Enable feature
}
```

---

## 10. Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    GitHub Repository                     │
│  ┌───────────────────────────────────────────────────┐ │
│  │                    main branch                     │ │
│  └───────────────────────────────────────────────────┘ │
│                           │                              │
│                           │ push                         │
│                           ▼                              │
│  ┌───────────────────────────────────────────────────┐ │
│  │                  GitHub Actions                    │ │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────┐   │ │
│  │  │  Build   │→ │  Test    │→ │   Deploy     │   │ │
│  │  └──────────┘  └──────────┘  └──────────────┘   │ │
│  └───────────────────────────────────────────────────┘ │
│                           │                              │
│                           │ deploy                       │
│                           ▼                              │
│  ┌───────────────────────────────────────────────────┐ │
│  │                  GitHub Pages                      │ │
│  │          Static File Hosting (CDN)                 │ │
│  └───────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

---

**Letzte Aktualisierung**: [DATUM]
