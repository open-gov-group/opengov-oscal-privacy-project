# ADR-001: OSCAL als Basis-Standard für Compliance-Artefakte

**Status**: Akzeptiert
**Datum**: 2026-02-02
**Entscheider**: Architecture Team
**Technische Story**: Auswahl eines maschinenlesbaren Standards für Compliance-Dokumentation

---

## Kontext

Das OpenGov Privacy Ecosystem benötigt ein standardisiertes Format für:
- Datenschutz-Controls (DSGVO, SDM)
- Sicherheits-Controls (ISO 27001, BSI, NIST)
- Compliance-Mappings zwischen Frameworks
- Profile (angepasste Control-Sets für spezifische Anwendungsfälle)

Bisherige Ansätze in der Verwaltung nutzen Word-Dokumente, Excel-Tabellen oder proprietäre Tools, was zu Inkonsistenzen und mangelnder Interoperabilität führt.

---

## Entscheidung

Wir verwenden **NIST OSCAL (Open Security Controls Assessment Language) Version 1.1.2** als Basis-Standard für alle Compliance-Artefakte.

### Gründe für OSCAL

| Kriterium | OSCAL | Alternativen (STIX, Custom JSON) |
|-----------|-------|----------------------------------|
| **Standardisiert** | NIST-Standard, international anerkannt | Proprietär oder bereichsspezifisch |
| **Maschinenlesbar** | JSON/XML/YAML | Variiert |
| **Erweiterbar** | Custom Properties via Namespace | Eingeschränkt |
| **Tooling** | Wachsendes Ökosystem | Begrenzt |
| **Dokumentation** | Umfassend (pages.nist.gov/OSCAL) | Variiert |
| **Versionierung** | Stabile Releases | Variiert |

### OSCAL-Modelle im Einsatz

```
┌─────────────────────────────────────────────────────────────────┐
│                     OSCAL Document Models                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │   Catalog    │───>│   Profile    │───>│  Component   │       │
│  │              │    │              │    │  Definition  │       │
│  │ (Controls)   │    │ (Tailoring)  │    │              │       │
│  └──────────────┘    └──────────────┘    └──────────────┘       │
│         │                   │                   │                │
│         └───────────────────┴───────────────────┘                │
│                             │                                    │
│                             v                                    │
│                    ┌──────────────┐                              │
│                    │     SSP      │  (Future)                    │
│                    │ System Sec.  │                              │
│                    │    Plan      │                              │
│                    └──────────────┘                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Konsequenzen

### Positiv

- **Interoperabilität**: Austausch mit anderen OSCAL-basierten Systemen möglich
- **Zukunftssicherheit**: NIST entwickelt aktiv weiter
- **Tooling**: Nutzung existierender OSCAL-Tools (Validator, Resolver)
- **Community**: Wachsende Open-Source-Community
- **Auditierbarkeit**: Standardformat erleichtert Audits

### Negativ

- **Lernkurve**: OSCAL ist komplex, Team benötigt Einarbeitung
- **Anpassung**: Datenschutz-spezifische Erweiterungen nötig (Custom Properties)
- **Tooling-Lücken**: Nicht alle Tools unterstützen Custom Properties

### Mitigationsmaßnahmen

1. **Schulungen**: OSCAL-Workshops für alle Teams
2. **Dokumentation**: Eigene OSCAL-Styleguide erstellen
3. **Custom Namespace**: `https://open-gov-group.org/oscal/privacy` für Erweiterungen
4. **Library**: `oscal-pyprivacy` kapselt OSCAL-Komplexität

---

## Alternativen

### Nicht gewählt: Custom JSON Schema

- **Pro**: Volle Kontrolle, einfacher zu lernen
- **Contra**: Kein Standard, keine Tool-Unterstützung, Insellösung

### Nicht gewählt: STIX/TAXII

- **Pro**: Etabliert im Security-Bereich
- **Contra**: Fokus auf Threat Intelligence, nicht Compliance

### Nicht gewählt: Word/Excel

- **Pro**: Bekannt, einfach
- **Contra**: Nicht maschinenlesbar, keine Versionierung, inkonsistent

---

## Referenzen

- [NIST OSCAL Documentation](https://pages.nist.gov/OSCAL/)
- [OSCAL 1.1.2 JSON Schema](https://github.com/usnistgov/OSCAL/releases)
- [PROJECT_OVERVIEW.md](../../related-informations/PROJECT_OVERVIEW.md)
