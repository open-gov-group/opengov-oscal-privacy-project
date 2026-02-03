# Code Style Guide

## TypeScript Conventions

### Strict Mode
Always use TypeScript strict mode. The `tsconfig.json` enforces:
```json
{
  "strict": true,
  "noImplicitAny": true,
  "strictNullChecks": true,
  "strictFunctionTypes": true
}
```

### Type Definitions

**Prefer interfaces over types for object shapes:**
```typescript
// ✅ Good
interface OSCALCatalog {
  uuid: string;
  metadata: Metadata;
  controls: Control[];
}

// ❌ Avoid (unless using union/intersection)
type OSCALCatalog = {
  uuid: string;
  metadata: Metadata;
  controls: Control[];
}
```

**Use types for unions, intersections, and utilities:**
```typescript
// ✅ Good
type ViewMode = 'citizen' | 'dpo';
type Language = 'de' | 'en' | 'fr';
type OSCALDocument = OSCALCatalog | OSCALProfile | OSCALComponent;
```

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Components | PascalCase | `CitizenView`, `ControlCard` |
| Functions/Variables | camelCase | `loadCatalog`, `userName` |
| Constants | SCREAMING_SNAKE_CASE | `CACHE_TTL`, `API_BASE_URL` |
| Types/Interfaces | PascalCase | `OSCALCatalog`, `ViewMode` |
| Files (components) | PascalCase | `CitizenView.tsx` |
| Files (utils) | kebab-case | `oscal-validator.ts` |
| Hooks | use + PascalCase | `useOSCALLoader`, `useURLParams` |

### Type Annotations

**Always annotate function parameters and return types:**
```typescript
// ✅ Good
function parseControl(raw: unknown): Control | null {
  if (!isValidControl(raw)) return null;
  return raw as Control;
}

// ❌ Avoid
function parseControl(raw) {
  if (!isValidControl(raw)) return null;
  return raw;
}
```

**Let TypeScript infer variable types when obvious:**
```typescript
// ✅ Good
const catalog = await loadCatalog(url); // Type inferred from loadCatalog return

// ❌ Avoid (redundant)
const catalog: OSCALCatalog = await loadCatalog(url);
```

## React Patterns

### Functional Components

**Always use functional components with hooks:**
```typescript
// ✅ Good
export function CitizenView({ catalogUrl }: CitizenViewProps) {
  const [catalog, setCatalog] = useState<OSCALCatalog | null>(null);
  
  useEffect(() => {
    loadCatalog(catalogUrl).then(setCatalog);
  }, [catalogUrl]);
  
  return <div>{/* ... */}</div>;
}

// ❌ Avoid (class components)
class CitizenView extends React.Component {
  // ...
}
```

### Props Interfaces

**Define props in separate interfaces:**
```typescript
interface CitizenViewProps {
  catalogUrl: string;
  language: Language;
  onError?: (error: Error) => void;
}

export function CitizenView({ catalogUrl, language, onError }: CitizenViewProps) {
  // ...
}
```

### Component Size

**Keep components under 200 lines. Split if larger:**
```typescript
// ✅ Good - Split into smaller components
function DPOView() {
  return (
    <div>
      <DPOHeader />
      <ControlList />
      <MappingView />
    </div>
  );
}

// ❌ Avoid - 500-line monolithic component
function DPOView() {
  // Hundreds of lines of logic and JSX
}
```

### State Management

**Use Zustand for global state, useState for local:**
```typescript
// Global state (oscalStore.ts)
const useOSCALStore = create<OSCALStore>((set) => ({
  catalog: null,
  loadCatalog: async (url) => {
    const catalog = await fetchCatalog(url);
    set({ catalog });
  },
}));

// Local state (component)
function ControlCard({ control }: ControlCardProps) {
  const [expanded, setExpanded] = useState(false);
  // ...
}
```

### Event Handlers

**Use inline arrow functions for simple handlers, named functions for complex:**
```typescript
// ✅ Simple handler - inline
<button onClick={() => setExpanded(!expanded)}>Toggle</button>

// ✅ Complex handler - named function
function handleExport() {
  const data = transformCatalog(catalog);
  generatePDF(data);
  trackEvent('export', { format: 'pdf' });
}

<button onClick={handleExport}>Export</button>
```

### Conditional Rendering

**Prefer ternary for simple conditions, early returns for complex:**
```typescript
// ✅ Simple condition
{isLoading ? <Spinner /> : <CatalogView catalog={catalog} />}

// ✅ Complex conditions - early return
if (!catalog) return <EmptyState />;
if (error) return <ErrorView error={error} />;
if (isLoading) return <LoadingView />;

return <CatalogView catalog={catalog} />;
```

## OSCAL-Specific Patterns

### Parsing OSCAL Documents

**Always validate before parsing:**
```typescript
async function loadCatalog(url: string): Promise<OSCALCatalog> {
  const response = await fetch(url);
  const data = await response.json();
  
  // Validate against OSCAL schema
  if (!validateOSCAL(data, 'catalog')) {
    throw new Error('Invalid OSCAL catalog');
  }
  
  return data as OSCALCatalog;
}
```

### Working with Controls

**Use utility functions for control operations:**
```typescript
// ✅ Good - Reusable utilities
function getControlById(catalog: OSCALCatalog, id: string): Control | undefined {
  return catalog.groups
    ?.flatMap(g => g.controls)
    .find(c => c.id === id);
}

function getControlTitle(control: Control, lang: Language): string {
  return control.props
    ?.find(p => p.name === `title-${lang}`)
    ?.value || control.title;
}

// Usage in component
const control = getControlById(catalog, 'ac-1');
const title = getControlTitle(control, 'de');
```

### Custom Properties

**Extract custom props with type safety:**
```typescript
type CustomProp = 'gdpr-article' | 'dpia-required' | 'iso27001-mapping';

function getCustomProp(
  control: Control, 
  name: CustomProp
): string | undefined {
  return control.props
    ?.find(p => p.name === name && p.ns === 'https://open-gov-group.org/oscal/privacy')
    ?.value;
}
```

## File Organization

### Component Files

**One component per file, with tests alongside:**
```
src/components/CitizenView/
├── CitizenView.tsx           # Main component
├── CitizenView.test.tsx      # Tests
├── CitizenHeader.tsx         # Sub-component
├── CitizenControlCard.tsx    # Sub-component
└── index.ts                  # Barrel export
```

### Barrel Exports

**Use index.ts for clean imports:**
```typescript
// src/components/CitizenView/index.ts
export { CitizenView } from './CitizenView';
export type { CitizenViewProps } from './CitizenView';

// Usage elsewhere
import { CitizenView } from '@/components/CitizenView';
```

## Error Handling

### Try-Catch for Async Operations

```typescript
// ✅ Good
async function loadCatalog(url: string): Promise<OSCALCatalog | null> {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Failed to load catalog:', error);
    return null;
  }
}
```

### Error Boundaries

**Wrap routes in error boundaries:**
```typescript
<ErrorBoundary fallback={<ErrorView />}>
  <ViewRouter />
</ErrorBoundary>
```

## Styling with Tailwind

### Component Classes

**Use consistent spacing and responsive design:**
```typescript
// ✅ Good
<div className="p-4 md:p-6 bg-white rounded-lg shadow-md">
  <h2 className="text-xl md:text-2xl font-bold mb-4">
    {title}
  </h2>
</div>

// ❌ Avoid - Inline styles
<div style={{ padding: '1rem', background: 'white' }}>
  <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold' }}>
    {title}
  </h2>
</div>
```

### Custom Classes

**Define custom utilities in tailwind.config.js:**
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'oscal-blue': '#1e40af',
        'oscal-green': '#059669',
      },
    },
  },
};
```

## Testing

### Test File Structure

```typescript
import { render, screen } from '@testing-library/react';
import { CitizenView } from './CitizenView';

describe('CitizenView', () => {
  it('renders catalog title', () => {
    const mockCatalog = createMockCatalog();
    render(<CitizenView catalog={mockCatalog} />);
    expect(screen.getByText('Privacy Catalog')).toBeInTheDocument();
  });
  
  it('handles missing catalog gracefully', () => {
    render(<CitizenView catalog={null} />);
    expect(screen.getByText(/no catalog/i)).toBeInTheDocument();
  });
});
```

### Test Utilities

**Create reusable test fixtures:**
```typescript
// src/utils/test-helpers.ts
export function createMockCatalog(overrides?: Partial<OSCALCatalog>): OSCALCatalog {
  return {
    uuid: 'test-uuid',
    metadata: createMockMetadata(),
    groups: [],
    ...overrides,
  };
}
```

## Accessibility

### Semantic HTML

```typescript
// ✅ Good
<nav aria-label="Main navigation">
  <ul>
    <li><a href="/citizen">Citizen View</a></li>
    <li><a href="/dpo">DPO View</a></li>
  </ul>
</nav>

// ❌ Avoid
<div className="nav">
  <div onClick={() => navigate('/citizen')}>Citizen View</div>
</div>
```

### ARIA Labels

```typescript
// ✅ Good
<button 
  aria-label="Export catalog as PDF"
  onClick={handleExport}
>
  <DownloadIcon />
</button>

// ❌ Avoid
<button onClick={handleExport}>
  <DownloadIcon />
</button>
```

## Performance

### Memoization

**Use React.memo for expensive renders:**
```typescript
export const ControlCard = React.memo(function ControlCard({ control }: ControlCardProps) {
  // Expensive rendering logic
  return <div>{/* ... */}</div>;
});
```

**Use useMemo for expensive computations:**
```typescript
const filteredControls = useMemo(() => {
  return catalog.controls.filter(c => c.class === selectedClass);
}, [catalog.controls, selectedClass]);
```

### Lazy Loading

**Code-split views:**
```typescript
const CitizenView = lazy(() => import('./components/CitizenView'));
const DPOView = lazy(() => import('./components/DPOView'));

function App() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <Routes>
        <Route path="/citizen" element={<CitizenView />} />
        <Route path="/dpo" element={<DPOView />} />
      </Routes>
    </Suspense>
  );
}
```

## Comments

### When to Comment

**Comment complex logic, not obvious code:**
```typescript
// ✅ Good - Explains WHY
// OSCAL 1.1.2 allows controls in both groups and directly in catalog
// We need to flatten both to get all controls
const allControls = [
  ...(catalog.controls || []),
  ...(catalog.groups?.flatMap(g => g.controls) || [])
];

// ❌ Avoid - States the obvious
// Set loading to true
setLoading(true);
```

### JSDoc for Public APIs

```typescript
/**
 * Loads and validates an OSCAL catalog from a URL
 * 
 * @param url - URL to the OSCAL catalog (JSON or XML)
 * @param options - Loading options
 * @returns Validated OSCAL catalog or null on error
 * 
 * @example
 * const catalog = await loadCatalog('https://example.com/catalog.json');
 */
export async function loadCatalog(
  url: string,
  options?: LoadOptions
): Promise<OSCALCatalog | null> {
  // ...
}
```

## Imports

### Import Order

```typescript
// 1. React & external libraries
import { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

// 2. Internal utilities & hooks
import { useOSCALStore } from '@/store/oscalStore';
import { validateOSCAL } from '@/utils/oscal-validator';

// 3. Components
import { ControlCard } from '@/components/Shared/ControlCard';

// 4. Types
import type { OSCALCatalog, Control } from '@/types/oscal';

// 5. Styles
import './CitizenView.css';
```

### Path Aliases

**Use @ for src/ imports:**
```typescript
// ✅ Good
import { useOSCALStore } from '@/store/oscalStore';

// ❌ Avoid
import { useOSCALStore } from '../../../store/oscalStore';
```

## Common Patterns Checklist

When creating a new component, ensure:

- [ ] TypeScript strict mode (no `any` types)
- [ ] Props interface defined
- [ ] Functional component with hooks
- [ ] Error handling for async operations
- [ ] Accessibility (semantic HTML, ARIA labels)
- [ ] Responsive design (Tailwind breakpoints)
- [ ] Tests written
- [ ] JSDoc for exported functions
- [ ] Proper import order
- [ ] Under 200 lines (or split)

## AI Tool Usage

When using GitHub Copilot, Cursor, or Claude Code:

1. **Reference this file:** "Following CODE_STYLE.md, create a component for..."
2. **Be specific:** "Create a TypeScript function that parses OSCAL controls with strict type checking"
3. **Request tests:** "Add tests for this component using Vitest and Testing Library"
4. **Ask for docs:** "Add JSDoc comments to all exported functions"

## Examples Repository

See `src/examples/` for reference implementations:
- `examples/CitizenView.example.tsx` - Complete citizen view pattern
- `examples/OSCALParser.example.ts` - OSCAL parsing utilities
- `examples/CustomHook.example.ts` - Hook pattern with TypeScript
