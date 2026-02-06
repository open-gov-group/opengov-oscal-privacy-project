# Accessibility Guidelines

**Version**: 1.0.0
**Standard**: WCAG 2.1 Level AA

---

## 1. Grundprinzipien (POUR)

### 1.1 Perceivable (Wahrnehmbar)

Informationen müssen für alle Sinne zugänglich sein.

- Textalternativen für Nicht-Text-Inhalte
- Untertitel für Audio/Video
- Anpassbare Darstellung
- Ausreichende Kontraste

### 1.2 Operable (Bedienbar)

Alle Funktionen müssen bedienbar sein.

- Tastaturzugänglichkeit
- Ausreichend Zeit
- Keine Anfälle auslösen
- Navigierbar

### 1.3 Understandable (Verständlich)

Inhalte und Bedienung müssen verständlich sein.

- Lesbare Texte
- Vorhersehbares Verhalten
- Hilfe bei Fehlereingaben

### 1.4 Robust

Inhalte müssen robust genug für assistive Technologien sein.

- Valides HTML
- ARIA korrekt eingesetzt
- Kompatibilität mit Hilfstechnologien

---

## 2. Semantisches HTML

### 2.1 Dokumentstruktur

```html
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Seitentitel | Applikationsname</title>
</head>
<body>
  <header role="banner">
    <nav aria-label="Hauptnavigation">...</nav>
  </header>

  <main id="main-content">
    <h1>Seitenüberschrift</h1>
    <!-- Inhalt -->
  </main>

  <aside aria-label="Sidebar">...</aside>

  <footer role="contentinfo">...</footer>
</body>
</html>
```

### 2.2 Überschriften-Hierarchie

```html
<!-- ✅ Korrekte Hierarchie -->
<h1>Katalog: NIST 800-53</h1>
  <h2>Access Control (AC)</h2>
    <h3>AC-1: Policy and Procedures</h3>
    <h3>AC-2: Account Management</h3>
  <h2>Awareness Training (AT)</h2>

<!-- ❌ Übersprungene Ebenen -->
<h1>Katalog</h1>
  <h3>Control</h3>  <!-- h2 fehlt! -->
```

### 2.3 Listen

```html
<!-- Ungeordnete Liste für Items ohne Reihenfolge -->
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
</ul>

<!-- Geordnete Liste für Schritte/Reihenfolge -->
<ol>
  <li>Schritt 1</li>
  <li>Schritt 2</li>
</ol>

<!-- Description List für Key-Value -->
<dl>
  <dt>Version</dt>
  <dd>1.1.2</dd>
  <dt>Status</dt>
  <dd>Active</dd>
</dl>
```

---

## 3. Tastaturzugänglichkeit

### 3.1 Fokusreihenfolge

```html
<!-- Natürliche Tab-Reihenfolge folgen -->
<!-- tabindex="0": In Fokusreihenfolge aufnehmen -->
<!-- tabindex="-1": Programmierbar fokussierbar, nicht in Tab-Reihenfolge -->
<!-- tabindex > 0: VERMEIDEN! -->

<div tabindex="0" role="button" onclick="handleClick()" onkeydown="handleKeyDown(event)">
  Custom Button
</div>
```

### 3.2 Fokus sichtbar

```css
/* Niemals Fokus komplett entfernen! */
/* ❌ Schlecht */
*:focus { outline: none; }

/* ✅ Gut: Custom aber sichtbarer Fokus */
:focus-visible {
  outline: 2px solid var(--color-primary-500);
  outline-offset: 2px;
}

/* Für Mouse-User dezenter */
:focus:not(:focus-visible) {
  outline: none;
}
```

### 3.3 Keyboard Interactions

| Element | Taste | Aktion |
|---------|-------|--------|
| Button | Enter, Space | Aktivieren |
| Link | Enter | Navigieren |
| Checkbox | Space | Toggle |
| Radio | Pfeiltasten | Auswahl ändern |
| Dropdown | Pfeiltasten | Navigieren |
| Modal | Escape | Schließen |
| Tab Panel | Pfeiltasten | Tab wechseln |

### 3.4 Skip Links

```html
<body>
  <a href="#main-content" class="skip-link">
    Zum Hauptinhalt springen
  </a>
  <header>...</header>
  <main id="main-content" tabindex="-1">
    ...
  </main>
</body>
```

```css
.skip-link {
  position: absolute;
  left: -9999px;
}

.skip-link:focus {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 9999;
  padding: var(--space-2) var(--space-4);
  background: var(--color-primary-500);
  color: white;
}
```

---

## 4. ARIA (Accessible Rich Internet Applications)

### 4.1 ARIA Grundregeln

1. **Kein ARIA ist besser als schlechtes ARIA**
2. **Native HTML bevorzugen** (`<button>` statt `<div role="button">`)
3. **Interaktive Elemente brauchen accessible names**
4. **Versteckte Elemente nicht fokussierbar machen**

### 4.2 Häufige ARIA-Attribute

```html
<!-- Accessible Name -->
<button aria-label="Schließen">
  <svg>...</svg>
</button>

<!-- Beschreibung -->
<input type="text" aria-describedby="hint">
<span id="hint">Mindestens 8 Zeichen</span>

<!-- Expanded State -->
<button aria-expanded="false" aria-controls="menu">
  Menü
</button>
<ul id="menu" hidden>...</ul>

<!-- Live Regions -->
<div aria-live="polite" aria-atomic="true">
  <!-- Änderungen werden vorgelesen -->
  Datei erfolgreich geladen
</div>

<!-- Fehler -->
<input type="email" aria-invalid="true" aria-errormessage="email-error">
<span id="email-error">Ungültige E-Mail</span>
```

### 4.3 ARIA Roles

```html
<!-- Landmark Roles (meist implizit durch HTML5) -->
<header role="banner">
<nav role="navigation">
<main role="main">
<aside role="complementary">
<footer role="contentinfo">

<!-- Widget Roles -->
<div role="tablist">
  <button role="tab" aria-selected="true">Tab 1</button>
  <button role="tab" aria-selected="false">Tab 2</button>
</div>
<div role="tabpanel">Inhalt Tab 1</div>

<!-- Alert für wichtige Meldungen -->
<div role="alert">Fehler beim Speichern!</div>
```

---

## 5. Formulare

### 5.1 Labels

```html
<!-- ✅ Explizites Label -->
<label for="email">E-Mail</label>
<input type="email" id="email">

<!-- ✅ Label umschließt Input -->
<label>
  <input type="checkbox">
  Ich akzeptiere die AGB
</label>

<!-- ❌ Nur Placeholder ist KEIN Label -->
<input type="email" placeholder="E-Mail">
```

### 5.2 Feldgruppen

```html
<fieldset>
  <legend>Benachrichtigungen</legend>
  <label>
    <input type="checkbox" name="notify" value="email">
    E-Mail
  </label>
  <label>
    <input type="checkbox" name="notify" value="sms">
    SMS
  </label>
</fieldset>
```

### 5.3 Fehlermeldungen

```html
<div class="form-group">
  <label for="password">Passwort</label>
  <input
    type="password"
    id="password"
    aria-invalid="true"
    aria-describedby="password-error password-hint"
  >
  <span id="password-error" class="error" role="alert">
    Passwort muss mindestens 8 Zeichen haben
  </span>
  <span id="password-hint" class="hint">
    Verwenden Sie Groß- und Kleinbuchstaben
  </span>
</div>
```

---

## 6. Bilder und Medien

### 6.1 Alt-Texte

```html
<!-- Informative Bilder -->
<img src="chart.png" alt="Balkendiagramm: 60% der Controls erfüllt">

<!-- Dekorative Bilder -->
<img src="decoration.svg" alt="" role="presentation">

<!-- Komplexe Bilder -->
<figure>
  <img src="architecture.png" alt="Systemarchitektur" aria-describedby="arch-desc">
  <figcaption id="arch-desc">
    Die Architektur besteht aus drei Schichten: ...
  </figcaption>
</figure>

<!-- SVG Icons -->
<button>
  <svg aria-hidden="true" focusable="false">...</svg>
  <span>Löschen</span>
</button>

<!-- Icon-only Button -->
<button aria-label="Löschen">
  <svg aria-hidden="true" focusable="false">...</svg>
</button>
```

### 6.2 Video/Audio

- Untertitel für Videos
- Transkripte für Audio
- Audiodeskription für wichtige visuelle Inhalte
- Keine automatische Wiedergabe

---

## 7. Farben und Kontraste

### 7.1 Kontrastverhältnisse

| Element | Minimum (AA) | Empfohlen (AAA) |
|---------|--------------|-----------------|
| Normaler Text | 4.5:1 | 7:1 |
| Großer Text (18px+/14px bold) | 3:1 | 4.5:1 |
| UI-Komponenten | 3:1 | - |
| Graphische Objekte | 3:1 | - |

### 7.2 Nicht nur Farbe

```html
<!-- ❌ Nur Farbe unterscheidet -->
<span class="status-green">Aktiv</span>
<span class="status-red">Inaktiv</span>

<!-- ✅ Farbe + Text/Icon -->
<span class="status-success">
  <svg aria-hidden="true">✓</svg>
  Aktiv
</span>
<span class="status-error">
  <svg aria-hidden="true">✗</svg>
  Inaktiv
</span>
```

---

## 8. Testen

### 8.1 Automatisierte Tests

```typescript
// Mit axe-core
import { axe, toHaveNoViolations } from 'jest-axe'

expect.extend(toHaveNoViolations)

it('should have no accessibility violations', async () => {
  const { container } = render(<MyComponent />)
  const results = await axe(container)
  expect(results).toHaveNoViolations()
})
```

### 8.2 Manuelle Tests

**Tastatur-Test:**
1. Tab durch alle interaktiven Elemente
2. Alle Funktionen ohne Maus bedienbar?
3. Fokus immer sichtbar?
4. Keine Tastaturfallen?

**Screen Reader Test:**
- Windows: NVDA (kostenlos), JAWS
- macOS: VoiceOver (integriert)
- Mobile: TalkBack (Android), VoiceOver (iOS)

**Browser Extensions:**
- axe DevTools
- WAVE
- Lighthouse (Chrome DevTools)

### 8.3 Checkliste

- [ ] Alle Bilder haben sinnvolle Alt-Texte
- [ ] Überschriften-Hierarchie ist korrekt
- [ ] Alle Formulare haben Labels
- [ ] Farbkontraste erfüllen 4.5:1
- [ ] Information wird nicht nur durch Farbe vermittelt
- [ ] Fokus ist immer sichtbar
- [ ] Keine Tastaturfallen
- [ ] Skip-Link vorhanden
- [ ] ARIA korrekt eingesetzt
- [ ] Kein automatisch startender Content

---

## 9. Ressourcen

### 9.1 Standards

- [WCAG 2.1](https://www.w3.org/TR/WCAG21/)
- [WAI-ARIA 1.2](https://www.w3.org/TR/wai-aria-1.2/)
- [ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/)

### 9.2 Tools

- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [axe DevTools](https://www.deque.com/axe/devtools/)
- [Stark (Figma Plugin)](https://www.getstark.co/)

---

**Letzte Aktualisierung**: [DATUM]
