# UI/UX Standards

**Version**: 1.0.0

---

## 1. Design Principles

### 1.1 Grundprinzipien

| Prinzip | Beschreibung |
|---------|--------------|
| **Klarheit** | Informationen sind sofort verständlich |
| **Konsistenz** | Gleiche Aktionen, gleiches Verhalten |
| **Effizienz** | Aufgaben mit minimalen Schritten erledigen |
| **Feedback** | System reagiert auf jede Benutzeraktion |
| **Fehlertoleranz** | Fehler vermeiden und Korrektur ermöglichen |

### 1.2 User-Centered Design

```
1. Verstehen    → User Research, Personas
2. Definieren   → User Stories, Requirements
3. Entwerfen    → Wireframes, Prototypen
4. Testen       → Usability Tests
5. Iterieren    → Feedback einarbeiten
```

---

## 2. Design System

### 2.1 Farbpalette

```css
:root {
  /* Primary */
  --color-primary-50: #e3f2fd;
  --color-primary-100: #bbdefb;
  --color-primary-500: #2196f3;
  --color-primary-700: #1976d2;
  --color-primary-900: #0d47a1;

  /* Neutral */
  --color-gray-50: #fafafa;
  --color-gray-100: #f5f5f5;
  --color-gray-300: #e0e0e0;
  --color-gray-500: #9e9e9e;
  --color-gray-700: #616161;
  --color-gray-900: #212121;

  /* Semantic */
  --color-success: #4caf50;
  --color-warning: #ff9800;
  --color-error: #f44336;
  --color-info: #2196f3;
}
```

### 2.2 Kontrastverhältnisse (WCAG)

| Verwendung | Minimum | Empfohlen |
|------------|---------|-----------|
| Normaler Text | 4.5:1 | 7:1 |
| Großer Text (18px+) | 3:1 | 4.5:1 |
| UI-Komponenten | 3:1 | 4.5:1 |

### 2.3 Typografie

```css
:root {
  /* Font Family */
  --font-family-base: 'Inter', system-ui, sans-serif;
  --font-family-mono: 'Fira Code', 'Consolas', monospace;

  /* Font Sizes (Modular Scale 1.25) */
  --font-size-xs: 0.64rem;   /* 10.24px */
  --font-size-sm: 0.8rem;    /* 12.8px */
  --font-size-base: 1rem;    /* 16px */
  --font-size-lg: 1.25rem;   /* 20px */
  --font-size-xl: 1.563rem;  /* 25px */
  --font-size-2xl: 1.953rem; /* 31.25px */
  --font-size-3xl: 2.441rem; /* 39px */

  /* Line Height */
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;
}
```

### 2.4 Spacing

```css
:root {
  /* 4px Base Grid */
  --space-1: 0.25rem;  /* 4px */
  --space-2: 0.5rem;   /* 8px */
  --space-3: 0.75rem;  /* 12px */
  --space-4: 1rem;     /* 16px */
  --space-5: 1.25rem;  /* 20px */
  --space-6: 1.5rem;   /* 24px */
  --space-8: 2rem;     /* 32px */
  --space-10: 2.5rem;  /* 40px */
  --space-12: 3rem;    /* 48px */
  --space-16: 4rem;    /* 64px */
}
```

---

## 3. Komponenten-Patterns

### 3.1 Buttons

```css
/* Button Hierarchie */
.btn-primary {
  /* Hauptaktion - max. 1 pro View */
  background: var(--color-primary-500);
  color: white;
}

.btn-secondary {
  /* Sekundäre Aktionen */
  background: transparent;
  border: 1px solid var(--color-primary-500);
  color: var(--color-primary-500);
}

.btn-ghost {
  /* Tertiäre Aktionen */
  background: transparent;
  color: var(--color-primary-500);
}
```

**Button States:**
- Default
- Hover (leicht dunkler)
- Active/Pressed (noch dunkler)
- Focus (sichtbarer Fokusring)
- Disabled (reduzierte Opacity, kein Pointer)

### 3.2 Formulare

```html
<!-- Label immer über dem Input -->
<div class="form-group">
  <label for="email">E-Mail-Adresse</label>
  <input type="email" id="email" placeholder="name@example.com">
  <span class="hint">Wir senden keine Spam-Mails</span>
</div>

<!-- Fehlerzustand -->
<div class="form-group has-error">
  <label for="email">E-Mail-Adresse</label>
  <input type="email" id="email" aria-invalid="true" aria-describedby="email-error">
  <span id="email-error" class="error">Bitte geben Sie eine gültige E-Mail-Adresse ein</span>
</div>
```

### 3.3 Feedback-Komponenten

| Typ | Verwendung | Dauer |
|-----|------------|-------|
| Toast | Kurze Bestätigung | 3-5 Sekunden |
| Inline Message | Kontextbezogene Info | Persistent |
| Modal | Kritische Entscheidung | Bis User reagiert |
| Banner | Systemweite Info | Dismissable |

---

## 4. Responsive Design

### 4.1 Breakpoints

```css
/* Mobile First Breakpoints */
:root {
  --breakpoint-sm: 640px;   /* Kleine Tablets */
  --breakpoint-md: 768px;   /* Tablets */
  --breakpoint-lg: 1024px;  /* Kleine Laptops */
  --breakpoint-xl: 1280px;  /* Desktops */
  --breakpoint-2xl: 1536px; /* Große Screens */
}
```

### 4.2 Layout-Patterns

```css
/* Container mit responsive Padding */
.container {
  width: 100%;
  max-width: var(--breakpoint-xl);
  margin: 0 auto;
  padding: var(--space-4);
}

@media (min-width: 768px) {
  .container {
    padding: var(--space-6);
  }
}

/* Responsive Grid */
.grid {
  display: grid;
  gap: var(--space-4);
  grid-template-columns: 1fr;
}

@media (min-width: 768px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

### 4.3 Touch Targets

```css
/* Minimum Touch Target: 44x44px (WCAG) */
.touch-target {
  min-width: 44px;
  min-height: 44px;
  padding: var(--space-2);
}

/* Abstand zwischen Touch Targets */
.button-group button + button {
  margin-left: var(--space-2);
}
```

---

## 5. Interaktionen

### 5.1 Loading States

```typescript
// Skeleton Loading für Listen
<div class="skeleton-list">
  <div class="skeleton-item" />
  <div class="skeleton-item" />
  <div class="skeleton-item" />
</div>

// Spinner für Aktionen
<button disabled={isLoading}>
  {isLoading ? <Spinner /> : 'Speichern'}
</button>

// Progress für längere Operationen
<progress value={progress} max={100} />
```

### 5.2 Transitions

```css
:root {
  /* Timing */
  --duration-fast: 150ms;
  --duration-normal: 250ms;
  --duration-slow: 400ms;

  /* Easing */
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
}

/* Standard Transition */
.interactive {
  transition: all var(--duration-normal) var(--ease-in-out);
}
```

### 5.3 Micro-Interactions

| Aktion | Feedback |
|--------|----------|
| Hover | Farbänderung, Cursor change |
| Click | Ripple, Scale down |
| Drag Start | Elevation, Cursor grab |
| Drop | Highlight Target |
| Success | Checkmark Animation |
| Error | Shake Animation |

---

## 6. Dark Mode

### 6.1 Color Tokens

```css
:root {
  --bg-primary: white;
  --bg-secondary: var(--color-gray-50);
  --text-primary: var(--color-gray-900);
  --text-secondary: var(--color-gray-700);
  --border-color: var(--color-gray-300);
}

[data-theme="dark"] {
  --bg-primary: var(--color-gray-900);
  --bg-secondary: #1a1a1a;
  --text-primary: var(--color-gray-50);
  --text-secondary: var(--color-gray-300);
  --border-color: var(--color-gray-700);
}
```

### 6.2 Implementierung

```typescript
// Theme Toggle
function useTheme() {
  const [theme, setTheme] = useState(() => {
    // System Preference als Default
    return window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light'
  })

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
  }, [theme])

  return { theme, setTheme }
}
```

---

## 7. Icons

### 7.1 Icon Guidelines

- **Größen**: 16px, 20px, 24px, 32px
- **Stroke**: Konsistent (1.5px oder 2px)
- **Style**: Outline für UI, Filled für aktive States
- **Farbe**: currentColor verwenden für Flexibilität

### 7.2 Icon + Text

```css
/* Icon vor Text */
.icon-text {
  display: inline-flex;
  align-items: center;
  gap: var(--space-2);
}

.icon-text svg {
  flex-shrink: 0;
}
```

---

## 8. Motion Principles

### 8.1 Wann Animation

| Sinnvoll | Vermeiden |
|----------|-----------|
| Orientierung nach Navigation | Rein dekorative Animation |
| Feedback auf Interaktion | Lange Ladeanimationen |
| Aufmerksamkeit lenken | Ablenkende Bewegung |
| Zustandsübergänge | Animationen ohne Opt-out |

### 8.2 Reduced Motion

```css
/* Respektiere User-Preference */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## 9. Design Review Checklist

- [ ] Farbkontraste erfüllen WCAG AA (4.5:1)
- [ ] Touch Targets mindestens 44x44px
- [ ] Konsistente Spacing (4px Grid)
- [ ] Klare visuelle Hierarchie
- [ ] Feedback für alle interaktiven Elemente
- [ ] Loading und Error States definiert
- [ ] Dark Mode funktioniert
- [ ] Responsive auf allen Breakpoints
- [ ] Reduced Motion berücksichtigt
- [ ] Fokuszustände sichtbar

---

**Letzte Aktualisierung**: [DATUM]
