# Erweitertes Control-Schema: Privacy + Resilience Integration

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Spezifikation für BSI-kompatible Erweiterungen

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [Neue Properties (BSI-inspiriert)](#2-neue-properties-bsi-inspiriert)
3. [Erweiterte Links-Struktur](#3-erweiterte-links-struktur)
4. [Vollständiges Control-Template](#4-vollständiges-control-template)
5. [Beispiel-Controls](#5-beispiel-controls)
6. [Migration bestehender Controls](#6-migration-bestehender-controls)

---

## 1. Übersicht

Dieses Dokument spezifiziert die Erweiterungen des OpenGov Privacy Catalog Control-Schemas zur besseren Integration mit BSI Grundschutz++ und anderen Resilienz-Frameworks.

### 1.1 Erweiterungsübersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ERWEITERTES CONTROL-SCHEMA                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   BESTEHENDE STRUKTUR          +   NEUE ERWEITERUNGEN                       │
│   ══════════════════               ══════════════════                       │
│                                                                             │
│   props:                           props (NEU):                             │
│   • legal                          • modalverb (MUSS/SOLLTE/KANN)           │
│   • assurance_goal                 • effort_level (0-4)                     │
│   • maturity-domain                • bsi-mapping                            │
│   • target-maturity                • iso27001-mapping                       │
│   • measure-type                   • implementation-priority                │
│   • evidence-type                                                           │
│                                                                             │
│   parts:                           parts (NEU):                             │
│   • statement                      • documentation-requirements             │
│   • maturity-hints                 • compliance-evidence                    │
│   • typical-measures               • audit-criteria                         │
│   • assessment-questions                                                    │
│   • risk-guidance                                                           │
│   • risk-hint                                                               │
│                                                                             │
│   links:                           links (NEU):                             │
│   • related-control                • required (Abhängigkeit)                │
│   • reference                      • implements (Umsetzung)                 │
│                                    • supersedes (Ersetzt)                   │
│                                    • bsi-baustein                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Neue Properties (BSI-inspiriert)

### 2.1 Modalverb (Verbindlichkeit) - MoSCoW-Konvention

**Namespace**: `https://open-gov-group.org/oscal/privacy`

Die Werte sind **internationalisiert** (MoSCoW: Must/Should/Could/Would), mit deutschen Übersetzungen in `remarks`. Dies ermöglicht spätere maschinelle Verarbeitung in pyprivacy.

```json
{
  "name": "modalverb",
  "value": "must",
  "ns": "https://open-gov-group.org/oscal/privacy",
  "class": "verbindlichkeit",
  "remarks": "MUSS - Zwingende Anforderung aus DSGVO"
}
```

| value (int'l) | remarks (DE) | Beschreibung | DSGVO-Bezug | BSI-Äquivalent |
|---------------|--------------|--------------|-------------|----------------|
| `must` | MUSS | Zwingende Anforderung | Explizite DSGVO-Pflicht | MUSS |
| `should` | SOLLTE | Starke Empfehlung | Best Practice, Erwägungsgründe | SOLLTE |
| `could` | KÖNNTE | Wünschenswert | Nice-to-have | (kein Äquivalent) |
| `would` | WÜRDE | Zukünftige Anforderung | Geplante Regulierung | (kein Äquivalent) |

**Hinweis**: BSI verwendet nur MUSS/SOLLTE/KANN. Für volle MoSCoW-Kompatibilität werden `could` und `would` ergänzt.

**Mapping-Logik DSGVO → Modalverb**:

| DSGVO-Formulierung | value | remarks |
|--------------------|-------|---------|
| "hat ... zu gewährleisten" | `must` | MUSS |
| "stellt sicher" | `must` | MUSS |
| "meldet unverzüglich" | `must` | MUSS |
| "sollte in Betracht ziehen" | `should` | SOLLTE |
| "kann ... vorsehen" | `could` | KÖNNTE |
| Erwägungsgründe (ohne Artikel) | `should` | SOLLTE |

### 2.2 Effort-Level (Aufwand)

```json
{
  "name": "effort_level",
  "value": "2",
  "ns": "https://open-gov-group.org/oscal/privacy",
  "class": "ressourcenplanung",
  "remarks": "Mittlerer Aufwand"
}
```

| Level | Bezeichnung | Typischer Aufwand | Beispiele |
|-------|-------------|-------------------|-----------|
| `0` | Trivial | < 1 PT | Richtlinie prüfen |
| `1` | Einfach | 1-5 PT | Prozess dokumentieren |
| `2` | Mittel | 5-20 PT | System konfigurieren |
| `3` | Aufwendig | 20-50 PT | Tool einführen |
| `4` | Sehr aufwendig | > 50 PT | Architektur-Änderung |

### 2.3 BSI-Mapping

```json
{
  "name": "bsi-mapping",
  "value": "ORP.4",
  "ns": "https://open-gov-group.org/oscal/privacy",
  "class": "framework-mapping",
  "remarks": "BSI IT-Grundschutz Baustein"
}
```

### 2.4 ISO 27001 Mapping

```json
{
  "name": "iso27001-mapping",
  "value": "A.9.2.1",
  "ns": "https://open-gov-group.org/oscal/privacy",
  "class": "framework-mapping",
  "remarks": "ISO/IEC 27001:2022 Annex A Control"
}
```

### 2.5 Implementation Priority

```json
{
  "name": "implementation-priority",
  "value": "high",
  "ns": "https://open-gov-group.org/oscal/privacy",
  "class": "priorisierung",
  "remarks": "Hohe Priorität aufgrund Bußgeld-Risiko"
}
```

| Wert | Beschreibung | Kriterien |
|------|--------------|-----------|
| `critical` | Sofort umsetzen | Art. 83 Abs. 5 DSGVO Bußgeld-Risiko |
| `high` | Kurzfristig | Art. 83 Abs. 4 DSGVO Bußgeld-Risiko |
| `medium` | Mittelfristig | Best Practice |
| `low` | Langfristig | Nice-to-have |

---

## 3. Erweiterte Links-Struktur

### 3.1 Abhängigkeits-Links

```json
{
  "links": [
    {
      "href": "#GOV-01",
      "rel": "required",
      "text": "Setzt Datenschutz-Governance voraus"
    },
    {
      "href": "#ACC-01",
      "rel": "required",
      "text": "Erfordert dokumentiertes DSMS"
    }
  ]
}
```

### 3.2 Implementierungs-Links

```json
{
  "links": [
    {
      "href": "#SDM-TOM-AC-01",
      "rel": "implements",
      "text": "Technische Umsetzung im SDM-Katalog"
    },
    {
      "href": "https://example.com/policy-template.docx",
      "rel": "template",
      "text": "Vorlage Access-Control-Policy"
    }
  ]
}
```

### 3.3 BSI-Baustein-Links

```json
{
  "links": [
    {
      "href": "https://www.bsi.bund.de/grundschutz/bausteine/ORP.4",
      "rel": "bsi-baustein",
      "text": "BSI ORP.4 Identitäts- und Berechtigungsmanagement"
    }
  ]
}
```

### 3.4 Link-Typen Übersicht

| rel | Beschreibung | Verwendung |
|-----|--------------|------------|
| `required` | Abhängigkeit | Control X muss vor Control Y umgesetzt werden |
| `implements` | Umsetzung | SDM-Control setzt Privacy-Control um |
| `related-control` | Verwandt | Thematisch verwandte Controls |
| `bsi-baustein` | BSI-Referenz | Link zu BSI IT-Grundschutz Baustein |
| `iso27001-control` | ISO-Referenz | Link zu ISO 27001 Control |
| `template` | Vorlage | Link zu Dokumentenvorlage |
| `evidence` | Nachweis | Link zu Evidenz-Anforderungen |
| `supersedes` | Ersetzt | Dieses Control ersetzt ein anderes |

---

## 4. Vollständiges Control-Template

```json
{
  "id": "TOM-02",
  "class": "safeguard",
  "title": "Zugriffs- und Berechtigungsmanagement",
  "props": [
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-32",
      "class": "proof",
      "ns": "de",
      "group": "reference",
      "remarks": "Art. 32 DS-GVO"
    },
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-5_ABS-1_LIT-f",
      "class": "proof",
      "ns": "de",
      "group": "reference",
      "remarks": "Art. 5 Abs. 1 lit. f DS-GVO"
    },
    {
      "name": "assurance_goal",
      "value": "confidentiality",
      "class": "teleological_interpretation",
      "ns": "de",
      "group": "aim_of_measure",
      "remarks": "Vertraulichkeit"
    },
    {
      "name": "assurance_goal",
      "value": "integrity",
      "class": "teleological_interpretation",
      "ns": "de",
      "group": "aim_of_measure",
      "remarks": "Integrität"
    },
    {
      "name": "maturity-domain",
      "value": "access-control"
    },
    {
      "name": "target-maturity",
      "value": "4"
    },
    {
      "name": "measure-type",
      "value": "technical"
    },
    {
      "name": "evidence-type",
      "value": "access-control-policy, iam-configuration, access-review-records"
    },
    {
      "name": "modalverb",
      "value": "must",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "verbindlichkeit",
      "remarks": "MUSS - Art. 32 DSGVO: 'hat ... zu gewährleisten'"
    },
    {
      "name": "effort_level",
      "value": "2",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "ressourcenplanung",
      "remarks": "Mittlerer Aufwand (5-20 PT initial)"
    },
    {
      "name": "implementation-priority",
      "value": "high",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "priorisierung"
    },
    {
      "name": "bsi-mapping",
      "value": "ORP.4",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "BSI IT-Grundschutz: Identitäts- und Berechtigungsmanagement"
    },
    {
      "name": "iso27001-mapping",
      "value": "A.9.2.1, A.9.2.3",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "ISO/IEC 27001:2022"
    }
  ],
  "links": [
    {
      "href": "#GOV-01",
      "rel": "required",
      "text": "Setzt Datenschutz-Governance und organisatorische Verankerung voraus"
    },
    {
      "href": "#ACC-01",
      "rel": "required",
      "text": "Erfordert dokumentiertes Datenschutz-Managementsystem"
    },
    {
      "href": "#SDM-TOM-AC-01",
      "rel": "implements",
      "text": "Technische Umsetzung im SDM-Katalog"
    },
    {
      "href": "https://www.bsi.bund.de/grundschutz/bausteine/ORP.4",
      "rel": "bsi-baustein",
      "text": "BSI ORP.4 Identitäts- und Berechtigungsmanagement"
    }
  ],
  "parts": [
    {
      "id": "tom-02-stmt",
      "name": "statement",
      "prose": "Die Organisation MUSS durch ein systematisches Zugriffs- und Berechtigungsmanagement sicherstellen, dass nur berechtigte Personen entsprechend dem Prinzip der geringsten Rechte auf personenbezogene Daten zugreifen können, und die Berechtigungen regelmäßig überprüfen."
    },
    {
      "id": "tom-02-maturity",
      "name": "maturity-hints",
      "parts": [
        {
          "id": "tom-02-maturity-level-01",
          "name": "maturity-level-1",
          "prose": "Level 1: Berechtigungen werden überwiegend manuell und ohne einheitliche Rollenmodelle vergeben; Joiner-Mover-Leaver-Prozesse sind unklar.",
          "props": [{ "name": "maturity-level", "value": "1" }]
        },
        {
          "id": "tom-02-maturity-level-03",
          "name": "maturity-level-3",
          "prose": "Level 3: Es existiert eine dokumentierte Access-Control-Policy mit Rollen- und Rechtekonzept; regelmäßige Rezertifizierungen finden statt.",
          "props": [{ "name": "maturity-level", "value": "3" }]
        },
        {
          "id": "tom-02-maturity-level-05",
          "name": "maturity-level-5",
          "prose": "Level 5: Das Berechtigungsmanagement ist weitgehend automatisiert (IAM/IDM), mit risikobasierten Review-Zyklen und Kennzahlen.",
          "props": [{ "name": "maturity-level", "value": "5" }]
        }
      ]
    },
    {
      "id": "tom-02-typical-measures",
      "name": "typical-measures",
      "parts": [
        {
          "id": "TOM-02-typical-measure-1",
          "name": "measure",
          "prose": "Erstellung einer Access-Control-Policy mit Rollen- und Rechtekonzept."
        },
        {
          "id": "TOM-02-typical-measure-2",
          "name": "measure",
          "prose": "Implementierung von Joiner-Mover-Leaver-Prozessen, idealerweise über IAM/IDM."
        },
        {
          "id": "TOM-02-typical-measure-3",
          "name": "measure",
          "prose": "Einführung regelmäßiger Berechtigungsreviews (Rezertifizierungen)."
        },
        {
          "id": "TOM-02-typical-measure-4",
          "name": "measure",
          "prose": "Definition von Standardrollen und Einsatz starker Authentisierung (MFA)."
        }
      ]
    },
    {
      "id": "tom-02-questions",
      "name": "assessment-questions",
      "parts": [
        {
          "id": "TOM-02-assessment-question-1",
          "name": "question",
          "prose": "Bestehen dokumentierte Rollen- und Berechtigungskonzepte?"
        },
        {
          "id": "TOM-02-assessment-question-2",
          "name": "question",
          "prose": "Werden Zugriffsrechte regelmäßig rezertifiziert?"
        },
        {
          "id": "TOM-02-assessment-question-3",
          "name": "question",
          "prose": "Ist der Joiner-Mover-Leaver-Prozess definiert und wird er eingehalten?"
        }
      ]
    },
    {
      "id": "tom-02-risk-guidance",
      "name": "risk-guidance",
      "class": "dp-risk-overview",
      "prose": "Risikobeschreibung aus Sicht der betroffenen Personen",
      "parts": [
        {
          "id": "tom-02-risk-impact-normal",
          "name": "risk-impact-scenario",
          "class": "dp-risk-impact",
          "props": [
            { "name": "impact-level", "class": "dp-risk", "value": "normal" },
            { "name": "data-category-example", "class": "dp-data-category", "value": "Stammdaten, Kontaktdaten" }
          ],
          "prose": "Bei unzureichendem Berechtigungsmanagement können unbefugte Stellen Einsicht erhalten. Risiken: unerwünschte Kontaktaufnahme, Vertrauensverlust."
        },
        {
          "id": "tom-02-risk-impact-moderate",
          "name": "risk-impact-scenario",
          "class": "dp-risk-impact",
          "props": [
            { "name": "impact-level", "class": "dp-risk", "value": "moderate" },
            { "name": "data-category-example", "class": "dp-data-category", "value": "Finanzdaten, Standortdaten" }
          ],
          "prose": "Bei Data Breach drohen finanzielle Schäden, Identitätsmissbrauch, Erpressungsversuche."
        },
        {
          "id": "tom-02-risk-impact-high",
          "name": "risk-impact-scenario",
          "class": "dp-risk-impact",
          "props": [
            { "name": "impact-level", "class": "dp-risk", "value": "high" },
            { "name": "data-category-example", "class": "dp-data-category", "value": "Art. 9/10 DSGVO Daten" }
          ],
          "prose": "Erhebliche Risiken: Diskriminierung, Stigmatisierung, psychische Belastungen bis hin zu physischer Gefährdung."
        }
      ]
    },
    {
      "id": "TOM-02-risk-hint",
      "name": "risk-hint",
      "prose": "Dieses Control ist für alle Verarbeitungen relevant. Bei hohem Impact ist regelmäßig eine DSFA erforderlich."
    },
    {
      "id": "tom-02-documentation-requirements",
      "name": "documentation-requirements",
      "prose": "Erforderliche Dokumentation gemäß Art. 5 Abs. 2 DSGVO (Rechenschaftspflicht):",
      "parts": [
        {
          "id": "tom-02-doc-1",
          "name": "document",
          "prose": "Access-Control-Policy / Berechtigungsrichtlinie"
        },
        {
          "id": "tom-02-doc-2",
          "name": "document",
          "prose": "Rollen- und Rechtekonzept mit Zuordnung zu Verarbeitungstätigkeiten"
        },
        {
          "id": "tom-02-doc-3",
          "name": "document",
          "prose": "Rezertifizierungsprotokolle (mindestens jährlich)"
        },
        {
          "id": "tom-02-doc-4",
          "name": "document",
          "prose": "Joiner-Mover-Leaver Prozessbeschreibung"
        }
      ]
    },
    {
      "id": "tom-02-audit-criteria",
      "name": "audit-criteria",
      "prose": "Prüfkriterien für interne/externe Audits:",
      "parts": [
        {
          "id": "tom-02-audit-1",
          "name": "criterion",
          "prose": "Aktualität des Berechtigungsverzeichnisses (< 3 Monate)"
        },
        {
          "id": "tom-02-audit-2",
          "name": "criterion",
          "prose": "Nachweis der letzten Rezertifizierung"
        },
        {
          "id": "tom-02-audit-3",
          "name": "criterion",
          "prose": "Stichprobe: 5 ausgeschiedene Mitarbeiter → Berechtigungen entzogen?"
        },
        {
          "id": "tom-02-audit-4",
          "name": "criterion",
          "prose": "Technische Prüfung: Keine verwaisten Accounts im IAM-System"
        }
      ]
    }
  ]
}
```

---

## 5. Beispiel-Controls

### 5.1 GOV-01: Datenschutz-Organisation (Erweitert)

```json
{
  "id": "GOV-01",
  "class": "management",
  "title": "Datenschutz-Organisation",
  "props": [
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-24",
      "class": "proof",
      "remarks": "Art. 24 DS-GVO - Verantwortung des Verantwortlichen"
    },
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-37",
      "class": "proof",
      "remarks": "Art. 37 DS-GVO - Benennung DSB"
    },
    {
      "name": "assurance_goal",
      "value": "transparency",
      "class": "teleological_interpretation",
      "remarks": "Transparenz"
    },
    {
      "name": "modalverb",
      "value": "must",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "MUSS - Art. 24: 'setzt ... um'"
    },
    {
      "name": "effort_level",
      "value": "2",
      "ns": "https://open-gov-group.org/oscal/privacy"
    },
    {
      "name": "implementation-priority",
      "value": "critical",
      "ns": "https://open-gov-group.org/oscal/privacy"
    },
    {
      "name": "bsi-mapping",
      "value": "GC.4.1, GC.4.3",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "BSI Grundschutz++ Sicherheitsorganisation"
    }
  ],
  "links": [
    {
      "href": "#GOV-02",
      "rel": "related-control",
      "text": "Siehe auch: Datenschutzbeauftragter"
    },
    {
      "href": "https://github.com/BSI-Bund/Stand-der-Technik-Bibliothek",
      "rel": "bsi-baustein",
      "text": "BSI GC.4 Sicherheitsorganisation"
    }
  ],
  "parts": [
    {
      "id": "gov-01-stmt",
      "name": "statement",
      "prose": "Die Organisation MUSS eine Datenschutz-Organisationsstruktur etablieren, die klare Verantwortlichkeiten, Berichtswege und Eskalationspfade definiert und die Einbindung des Datenschutzes in alle relevanten Geschäftsprozesse sicherstellt."
    },
    {
      "id": "gov-01-documentation-requirements",
      "name": "documentation-requirements",
      "parts": [
        { "name": "document", "prose": "Organigramm mit Datenschutz-Verantwortlichkeiten" },
        { "name": "document", "prose": "Stellenbeschreibung DSB (sofern benannt)" },
        { "name": "document", "prose": "Eskalationsmatrix für Datenschutzvorfälle" }
      ]
    }
  ]
}
```

### 5.2 INC-02: Meldung an Aufsichtsbehörde (Art. 33) - Erweitert

```json
{
  "id": "INC-02",
  "class": "process",
  "title": "Meldung von Datenschutzverletzungen an Aufsichtsbehörde",
  "props": [
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-33",
      "class": "proof",
      "remarks": "Art. 33 DS-GVO - Meldung an Aufsichtsbehörde"
    },
    {
      "name": "assurance_goal",
      "value": "transparency",
      "remarks": "Transparenz"
    },
    {
      "name": "assurance_goal",
      "value": "intervenability",
      "remarks": "Intervenierbarkeit"
    },
    {
      "name": "modalverb",
      "value": "must",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "MUSS - Art. 33 Abs. 1: 'meldet ... unverzüglich'"
    },
    {
      "name": "effort_level",
      "value": "1",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "Geringer Aufwand bei vorbereitetem Prozess"
    },
    {
      "name": "implementation-priority",
      "value": "critical",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "72-Stunden-Frist, hohes Bußgeld-Risiko"
    },
    {
      "name": "bsi-mapping",
      "value": "DER.2.1",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "BSI DER.2.1 - erweitert um DSGVO-Meldefrist"
    },
    {
      "name": "time-constraint",
      "value": "72h",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "remarks": "Meldung binnen 72 Stunden nach Kenntnisnahme"
    }
  ],
  "links": [
    {
      "href": "#INC-01",
      "rel": "required",
      "text": "Setzt Vorfallserkennung voraus"
    },
    {
      "href": "#INC-03",
      "rel": "related-control",
      "text": "Siehe auch: Benachrichtigung Betroffener"
    },
    {
      "href": "#GOV-02",
      "rel": "required",
      "text": "DSB muss eingebunden werden"
    }
  ],
  "parts": [
    {
      "id": "inc-02-stmt",
      "name": "statement",
      "prose": "Die Organisation MUSS Verletzungen des Schutzes personenbezogener Daten unverzüglich und möglichst binnen 72 Stunden, nachdem die Verletzung bekannt wurde, der zuständigen Aufsichtsbehörde melden, es sei denn, die Verletzung führt voraussichtlich nicht zu einem Risiko für die Rechte und Freiheiten natürlicher Personen."
    },
    {
      "id": "inc-02-typical-measures",
      "name": "typical-measures",
      "parts": [
        { "name": "measure", "prose": "Melde-Workflow mit definierten Eskalationsstufen etablieren" },
        { "name": "measure", "prose": "Melde-Template der zuständigen Aufsichtsbehörde vorhalten" },
        { "name": "measure", "prose": "Rufbereitschaft für Wochenenden/Feiertage einrichten" },
        { "name": "measure", "prose": "Kriterien für Risikobewertung (meldepflichtig ja/nein) dokumentieren" }
      ]
    },
    {
      "id": "inc-02-audit-criteria",
      "name": "audit-criteria",
      "parts": [
        { "name": "criterion", "prose": "Melde-Prozess dokumentiert und getestet (Tabletop-Übung)?" },
        { "name": "criterion", "prose": "Kontaktdaten Aufsichtsbehörde aktuell und erreichbar?" },
        { "name": "criterion", "prose": "DSB und Stellvertreter kurzfristig erreichbar?" },
        { "name": "criterion", "prose": "Verzeichnis vergangener Meldungen geführt?" }
      ]
    }
  ]
}
```

---

## 6. Migration bestehender Controls

### 6.1 Migrations-Checkliste

Für jedes bestehende Control:

- [ ] `modalverb` Property hinzufügen (MUSS/SOLLTE/KANN)
- [ ] `effort_level` Property hinzufügen (0-4)
- [ ] `implementation-priority` Property hinzufügen
- [ ] `bsi-mapping` Property hinzufügen (falls zutreffend)
- [ ] `iso27001-mapping` Property hinzufügen (falls zutreffend)
- [ ] Abhängigkeits-Links (`rel="required"`) ergänzen
- [ ] `documentation-requirements` Part ergänzen
- [ ] `audit-criteria` Part ergänzen

### 6.2 Automatisierbare Migration

```python
# Beispiel: Migrations-Skript (Pseudocode)
def migrate_control(control):
    # 1. Modalverb aus legal-props ableiten
    if has_explicit_gdpr_requirement(control):
        control.props.append({
            "name": "modalverb",
            "value": "must",
            "ns": "https://open-gov-group.org/oscal/privacy",
            "remarks": "MUSS"  # Deutsche Übersetzung
        })

    # 2. BSI-Mapping aus Mapping-Datei laden
    bsi_mapping = lookup_bsi_mapping(control.id)
    if bsi_mapping:
        control.props.append({
            "name": "bsi-mapping",
            "value": bsi_mapping,
            "ns": "https://open-gov-group.org/oscal/privacy"
        })

    # 3. Effort-Level aus maturity-domain schätzen
    effort = estimate_effort(control.props.get("maturity-domain"))
    control.props.append({
        "name": "effort_level",
        "value": str(effort),
        "ns": "https://open-gov-group.org/oscal/privacy"
    })

    return control
```

---

## Referenzen

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – Basis-Katalog-Spezifikation
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – BSI Mapping
- [opengov_privacy_to_bsi_grundschutz.json](../../oscal/mappings/opengov_privacy_to_bsi_grundschutz.json) – OSCAL Mapping-Datei

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
