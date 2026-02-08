# OSCAL Import & Referenzierung: Team-Briefing

**Version**: 1.0.0
**Stand**: 2026-02-08
**Verantwortlich**: OSCAL Expert / Architecture Team

---

## Inhaltsverzeichnis

1. [Das OSCAL-Referenzmodell](#1-das-oscal-referenzmodell)
2. [Aktueller Stand im Projekt](#2-aktueller-stand-im-projekt)
3. [Import-Mechanismen im Detail](#3-import-mechanismen-im-detail)
4. [Die vier HREF-Patterns](#4-die-vier-href-patterns)
5. [Auswirkung auf Viewer & Auswertung](#5-auswirkung-auf-viewer--auswertung)
6. [Regeln & Best Practices](#6-regeln--best-practices)

---

## 1. Das OSCAL-Referenzmodell

OSCAL definiert eine **hierarchische Modellkette**, in der jede Schicht die darunter liegende importiert und erweitert:

```
┌──────────────────────────────────────────────────────────────────┐
│  SSP (System Security Plan)                                      │
│  "WER implementiert WAS in WELCHEM System?"                      │
│  → importiert Profile + Component-Definitions                    │
├──────────────────────────────────────────────────────────────────┤
│  Component-Definition                                            │
│  "WELCHE Bausteine implementieren WELCHE Controls?"              │
│  → referenziert Catalog-Controls via source + control-id         │
├──────────────────────────────────────────────────────────────────┤
│  Profile                                                         │
│  "WELCHE Controls aus den Catalogen bilden unsere Baseline?"     │
│  → importiert aus einem oder mehreren Catalogen                  │
├──────────────────────────────────────────────────────────────────┤
│  Catalog (Basis)                                                 │
│  "WAS muss geschützt/umgesetzt werden?"                          │
│  → Standalone, wird von allen anderen Modellen referenziert      │
└──────────────────────────────────────────────────────────────────┘
```

---

## 2. Aktueller Stand im Projekt

| OSCAL-Modell | Datei(en) | Status |
|---|---|---|
| **Catalog** | `open_privacy_catalog_risk_v0.7.0.json` (OPC) | Implementiert |
| **Catalog** | `sdm_privacy_catalog_v2.0.0.json` (SDM) | Implementiert |
| **Mapping** | `opengov_privacy_to_bsi_grundschutz.json` | Implementiert |
| **Mapping** | `opengov_privacy_to_iso27701.json` | Implementiert |
| **Profile** | `profile_integrated_privacy_security.json` | Implementiert |
| **Component-Definition** | – | Geplant (Phase 3-4) |
| **SSP** | – | Geplant (Phase 3-4) |

---

## 3. Import-Mechanismen im Detail

### 3.1 Profile importiert Catalog(e)

Dies ist der zentrale Mechanismus. Unser bestehendes Profil zeigt das Pattern:

```json
{
  "profile": {
    "imports": [
      {
        "href": "../catalog/open_privacy_catalog_risk.json",
        "include-controls": {
          "with-ids": ["GOV-01", "GOV-02", "ACC-01", "LAW-01"]
        }
      },
      {
        "href": "https://github.com/BSI-Bund/.../catalog.json",
        "include-controls": {
          "with-ids": ["GC.1.1", "GC.2.1"]
        }
      }
    ],
    "merge": {
      "combine": { "method": "merge" },
      "custom": {
        "groups": [
          { "id": "integrated-governance" },
          { "id": "privacy-specific" },
          { "id": "security-specific" }
        ]
      }
    },
    "modify": {
      "set-parameters": [ "..." ],
      "alters": [
        {
          "control-id": "GOV-01",
          "adds": [{ "position": "after", "by-id": "gov-01-stmt", "parts": ["..."] }]
        }
      ]
    }
  }
}
```

**Schlüsselprinzipien:**

| Abschnitt | Funktion |
|-----------|----------|
| `imports` | Liste der Quell-Kataloge mit Kontrollauswahl |
| `merge` | Wie werden importierte Controls zusammengeführt? |
| `modify` | Parameter setzen oder Controls erweitern (z.B. Integrations-Hinweise) |

### 3.2 Catalog verweist auf Catalog (Cross-Referenz)

Der SDM-Katalog verweist auf konkrete OPC-Controls per **Fragment-Identifier**:

```json
{
  "id": "SDM-TRA-42",
  "title": "Dokumentieren",
  "links": [
    {
      "href": "open_privacy_catalog_risk_v0.7.0.json#ACC-01",
      "rel": "implements",
      "text": "SDM: Protokollieren (Nachweisführung)"
    },
    {
      "href": "open_privacy_catalog_risk_v0.7.0.json#REG-01",
      "rel": "implements",
      "text": "SDM: Verarbeitungsverzeichnis"
    }
  ]
}
```

**Format:** `dateiname.json#CONTROL-ID`

### 3.3 Component-Definition referenziert Catalog (geplant)

Eine Component-Definition beschreibt, *welcher Baustein welches Control umsetzt*:

```json
{
  "component-definition": {
    "components": [
      {
        "uuid": "...",
        "type": "software",
        "title": "Cookie Consent Manager",
        "control-implementations": [
          {
            "uuid": "...",
            "source": "../catalog/open_privacy_catalog_risk_v0.7.0.json",
            "implemented-requirements": [
              {
                "uuid": "...",
                "control-id": "DSR-01",
                "description": "Einwilligungs-Management gemäss Art. 7 DSGVO"
              }
            ]
          }
        ]
      }
    ]
  }
}
```

**Schlüssel:** `source` verweist auf den Katalog, `control-id` auf das konkrete Control.

### 3.4 SSP referenziert Profile + Components (geplant)

Der SSP verbindet alles für ein konkretes System:

```json
{
  "system-security-plan": {
    "import-profile": {
      "href": "../profiles/profile_integrated_privacy_security.json"
    },
    "control-implementation": {
      "implemented-requirements": [
        {
          "uuid": "...",
          "control-id": "GOV-01",
          "by-components": [
            { "component-uuid": "uuid-des-cookie-managers" }
          ],
          "statements": [
            {
              "statement-id": "gov-01-stmt",
              "description": "Umgesetzt durch Organigramm und DSB-Bestellung"
            }
          ]
        }
      ]
    }
  }
}
```

---

## 4. Die vier HREF-Patterns

| Pattern | Beispiel | Einsatz |
|---|---|---|
| **Relativer Pfad** | `../catalog/file.json` | Dateien im selben Repository |
| **Fragment-ID** | `catalog.json#GOV-01` | Verweis auf ein konkretes Control |
| **GitHub-URL** | `https://github.com/.../catalog.json` | Externe öffentliche Kataloge |
| **URN** | `urn:iso:std:iso-iec:27701:ed-2:2025` | Formale Normen-Referenz |

### Prioritätsregel

1. **Innerhalb des Repos** → Relativer Pfad
2. **Auf ein Control** → Fragment-ID anhängen (`#CONTROL-ID`)
3. **Externer Katalog** → Volle GitHub-URL
4. **Normenverweis** → URN-Format

---

## 5. Auswirkung auf Viewer & Auswertung

Damit der Viewer (Client-Side, ADR-003) referenzierte Daten auflösen kann, braucht es einen **Resolution-Prozess**:

```
┌─────────────────────────────────────────────────────┐
│ 1. SSP laden                                        │
│    ↓ import-profile.href auflösen                   │
│ 2. Profile laden                                    │
│    ↓ imports[].href auflösen                        │
│ 3. Catalog(e) laden                                 │
│    ↓ include-controls filtern                       │
│ 4. Merge: Controls zusammenführen                   │
│ 5. Modify: Parameter & Alters anwenden              │
│ 6. Resolved Catalog → an Viewer übergeben           │
│                                                     │
│ Parallel: Component-Definitions laden               │
│    ↓ source-href auflösen                           │
│    ↓ control-id → Control zuordnen                  │
│    → "Welche Komponente implementiert dieses Control"│
└─────────────────────────────────────────────────────┘
```

### Strategien für den Viewer

| Strategie | Beschreibung | Vorteil | Nachteil |
|-----------|--------------|---------|----------|
| **Build-Time Resolution** | Alle Referenzen vorab auflösen, eine zusammengeführte Datei deployen | Schnell, einfach | Keine dynamischen Updates |
| **Lazy Loading** | Referenzen zur Laufzeit per `fetch()` auflösen | Immer aktuell | Komplexer, CORS beachten |
| **Hybrid** | Basis-Katalog vorgeladen, Mappings/Externe lazy | Guter Kompromiss | Build-Pipeline nötig |

### CORS-Hinweis

Externe GitHub-URLs (z.B. BSI-Katalog) erfordern Zugriff auf `raw.githubusercontent.com`. Bei CORS-Problemen: lokale Kopie im Repo oder Build-Step zum Vorab-Download.

---

## 6. Regeln & Best Practices

### Namespace-Regel

Custom-Properties **immer** mit gültigem URI-Namespace:

```json
"ns": "https://open-gov-group.org/oscal/privacy"
```

Niemals Sprach-Kürzel wie ~~`"ns": "de"`~~ verwenden. Das OSCAL-Schema erfordert eine gültige URI (`^[a-zA-Z][a-zA-Z0-9+\-.]+:.+$`).

### Leere Arrays vermeiden

Wenn `parts`, `props` oder `links` keine Einträge haben, das Attribut **weglassen** statt `[]` zu setzen. Das OSCAL-Schema verlangt `minItems: 1`.

```json
// FALSCH
{ "name": "assessment-questions", "parts": [] }

// RICHTIG
{ "name": "assessment-questions" }
```

### Link-Beziehungstypen (`rel`)

| rel | Bedeutung | Beispiel |
|-----|-----------|---------|
| `implements` | Setzt ein höheres Control um | SDM → OPC |
| `required` | Abhängigkeit (muss vorher umgesetzt sein) | INC-02 → INC-01 |
| `related-control` | Thematisch verwandt | GOV-01 ↔ GOV-02 |
| `bsi-baustein` | Verweis auf BSI IT-Grundschutz | → BSI ORP.4 |
| `supersedes` | Ersetzt ein anderes Control | – |
| `template` | Verweis auf Dokumentenvorlage | → Policy-Template |

### Checkliste für neue OSCAL-Dateien

- [ ] `uuid` mit UUIDv4 vergeben
- [ ] `metadata.oscal-version` auf `1.1.2` setzen
- [ ] `metadata.last-modified` mit ISO-8601-Timestamp
- [ ] Alle `href`-Referenzen prüfen (existiert das Ziel?)
- [ ] Custom-Props mit Namespace `https://open-gov-group.org/oscal/privacy`
- [ ] Keine leeren Arrays (`[]`) bei `parts`, `props`, `links`
- [ ] Gegen OSCAL-Schema validieren vor Commit

---

## Referenzen

- [OSCAL_SCHEMA.md](../../architecture/OSCAL_SCHEMA.md) – Schema & Privacy Extensions
- [EXTENDED_CONTROL_SCHEMA.md](../../architecture/EXTENDED_CONTROL_SCHEMA.md) – Erweitertes Control-Schema
- [OSCAL_PRIVACY_CATALOGS.md](../../architecture/OSCAL_PRIVACY_CATALOGS.md) – Katalog-Spezifikation
- [CATALOG_INTEGRATION.md](../../architecture/CATALOG_INTEGRATION.md) – Multi-Layer-Katalog-Architektur
- [ADR-003](../../architecture/decisions/ADR-003-client-side-viewer.md) – Client-Side Viewer Architektur
- [NIST OSCAL Specification](https://pages.nist.gov/OSCAL/) – Offizielle OSCAL-Dokumentation

---

**Letzte Aktualisierung**: 2026-02-08
**Verantwortlich**: OSCAL Expert / Architecture Team
