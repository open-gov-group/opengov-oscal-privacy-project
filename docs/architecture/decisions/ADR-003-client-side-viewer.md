# ADR-003: Client-Side-First Architektur für den Privacy Viewer

**Status**: Akzeptiert
**Datum**: 2026-02-02
**Entscheider**: Architecture Team, Frontend Team
**Technische Story**: Architektur des OSCAL Privacy Viewers

---

## Kontext

Der `opengov-oscal-privacy-viewer` soll:
- OSCAL-Kataloge visualisieren
- Für Bürger und DPOs gleichermaßen nutzbar sein
- Datenschutz-konform sein (Privacy by Design)
- Einfach zu deployen sein (ohne Backend-Infrastruktur)
- Offline funktionieren können

---

## Entscheidung

Der Privacy Viewer wird als **100% Client-Side Web Application** implementiert, ohne eigenes Backend.

### Architektur

```
┌─────────────────────────────────────────────────────────────────┐
│                         Browser (Client)                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                  React Application (SPA)                    │ │
│  │                                                             │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │ │
│  │  │   Views     │  │  Services   │  │   State     │        │ │
│  │  │             │  │             │  │             │        │ │
│  │  │ • Catalog   │  │ • OSCAL     │  │ • Zustand/  │        │ │
│  │  │ • Profile   │  │   Parser    │  │   Context   │        │ │
│  │  │ • Component │  │ • Filter    │  │             │        │ │
│  │  │ • Export    │  │ • Export    │  │             │        │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘        │ │
│  │                                                             │ │
│  └────────────────────────────────────────────────────────────┘ │
│                             │                                    │
│                             │ fetch()                            │
│                             v                                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ HTTPS (Static JSON Files)
                              v
┌─────────────────────────────────────────────────────────────────┐
│            Static File Hosting (GitHub Pages / CDN)             │
│                                                                  │
│  • privacy-oscal/catalog/*.json                                 │
│  • privacy-mappings/*.json                                      │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Datenfluss

1. **Benutzer öffnet Viewer** -> Statische React-App wird geladen
2. **App lädt Katalog** -> `fetch()` zu statischer JSON-Datei
3. **Parsing & Rendering** -> Komplett im Browser
4. **Export (PDF/CSV)** -> Client-seitige Generierung
5. **Keine Daten an Server** -> Privacy by Design

---

## Gründe

| Aspekt | Client-Side | Server-Side |
|--------|-------------|-------------|
| **Datenschutz** | Keine Daten an Server | Server sieht alles |
| **Hosting** | GitHub Pages (kostenlos) | Server nötig |
| **Skalierung** | CDN = unbegrenzt | Server-Kapazität |
| **Offline** | Mit Service Worker möglich | Nicht möglich |
| **Komplexität** | Einfacher | Backend-Logik nötig |
| **Latenz** | Nach initialem Load schnell | Jeder Request = Latenz |

### Datenschutz-Vorteile

- **Keine Tracking**: Keine Server-Logs, keine Analytics
- **Keine Accounts**: Keine Benutzerregistrierung nötig
- **Lokale Verarbeitung**: Daten bleiben im Browser
- **Transparenz**: Open Source, vollständig inspizierbar

---

## Konsequenzen

### Positiv

- **Einfaches Deployment**: `npm run build` -> GitHub Pages
- **Keine Infrastruktur**: Kein Server zu warten
- **Datenschutz**: Höchste Stufe (keine Serververbindung für Nutzerdaten)
- **Performance**: Nach initialem Load sehr schnell
- **Offline-fähig**: Mit PWA-Erweiterung möglich

### Negativ

- **Große Kataloge**: Initial Load kann bei großen Katalogen langsam sein
- **Kein serverseitiges Caching**: Browser-Cache muss reichen
- **Keine Suche über alle Kataloge**: Nur lokale Suche

### Mitigationsmaßnahmen

1. **Lazy Loading**: Kataloge erst bei Bedarf laden
2. **Caching**: Service Worker für Offline-Nutzung
3. **Pagination**: Große Listen virtualisiert rendern
4. **Optional Gateway**: `privacy-gateway` für erweiterte Features

---

## Tech Stack

| Komponente | Technologie | Begründung |
|------------|-------------|------------|
| **Framework** | React 18 | Große Community, gutes Ökosystem |
| **Language** | TypeScript | Typsicherheit, bessere DX |
| **Build** | Vite | Schnell, modern |
| **Styling** | Tailwind CSS | Utility-First, konsistent |
| **PDF Export** | jsPDF + html2canvas | Client-seitig |
| **CSV Export** | Native JS | Kein Framework nötig |

---

## Alternativen

### Nicht gewählt: Next.js mit Server Components

- **Pro**: SSR, bessere SEO
- **Contra**: Server nötig, Datenschutzbedenken

### Nicht gewählt: Backend-API erforderlich

- **Pro**: Mehr Möglichkeiten (Suche, Auth)
- **Contra**: Komplexer, teurer, Datenschutzrisiko

---

## Weiterentwicklung

Falls erweiterte Features benötigt werden (z.B. Speichern von Filtern, übergreifende Suche), kann der optionale `privacy-gateway` als Backend dienen. Der Viewer bleibt aber auch ohne Gateway voll funktionsfähig.

---

## Referenzen

- [MASTER_BLUEPRINT.md](../MASTER_BLUEPRINT.md)
- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vitejs.dev/)
