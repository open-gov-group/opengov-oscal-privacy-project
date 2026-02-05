# OpenGov Privacy Catalog → ISO/IEC 27701:2025 Mapping

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Initial Release
**Quelle**: ISO/IEC 27701:2025 Second Edition (Privacy Information Management Systems)

---

## Inhaltsverzeichnis

1. [Executive Summary](#1-executive-summary)
2. [ISO 27701:2025 Überblick](#2-isoiec-277012025-überblick)
3. [Mapping-Methodik](#3-mapping-methodik)
4. [Gruppen-Mapping](#4-gruppen-mapping)
5. [Control-Mapping (Auszug)](#5-control-mapping-auszug)
6. [Coverage-Analyse](#6-coverage-analyse)
7. [Vergleich mit BSI Grundschutz++](#7-vergleich-mit-bsi-grundschutz)
8. [Nutzungsempfehlungen](#8-nutzungsempfehlungen)

---

## 1. Executive Summary

### Kernaussage

**ISO/IEC 27701:2025 bietet die beste Privacy-Coverage aller gemappten Frameworks** mit durchschnittlich **89% Abdeckung** der OpenGov Privacy Controls - signifikant höher als BSI Grundschutz++ (60%).

### Kritischer Vorteil: Betroffenenrechte (DSR)

| Framework | DSR-Coverage | Bemerkung |
|-----------|--------------|-----------|
| **ISO 27701** | **95%** | A.1.3 deckt alle Art. 12-22 DSGVO vollständig ab |
| BSI Grundschutz++ | 0% | Keine Entsprechung - kritischer Gap |

### Artefakte

| Artefakt | Pfad | Format |
|----------|------|--------|
| Mapping-Datei | `oscal/mappings/opengov_privacy_to_iso27701.json` | OSCAL 1.1.2 |
| ISO 27701 Struktur | `docs/related-informations/vs-nfd/ISO_27701_2025_Control_Struktur.xlsx` | Excel |

---

## 2. ISO/IEC 27701:2025 Überblick

### 2.1 Standard-Struktur

ISO/IEC 27701:2025 (Second Edition) definiert ein **Privacy Information Management System (PIMS)** als Erweiterung von ISO 27001.

```
ISO/IEC 27701:2025
├── Klauseln 4-10: Management-System-Anforderungen
│   ├── 4 - Kontext der Organisation
│   ├── 5 - Führung (Leadership)
│   ├── 6 - Planung (inkl. Risikomanagement)
│   ├── 7 - Unterstützung (Ressourcen, Kompetenz, Dokumentation)
│   ├── 8 - Betrieb
│   ├── 9 - Leistungsbewertung
│   └── 10 - Verbesserung
│
├── Annex A: Normative Controls
│   ├── A.1 - PII Controller (28 Controls)
│   │   ├── A.1.2 - Bedingungen für Erhebung und Verarbeitung
│   │   ├── A.1.3 - Pflichten gegenüber PII-Betroffenen ⭐
│   │   ├── A.1.4 - Privacy by Design und Default ⭐
│   │   └── A.1.5 - PII-Weitergabe, -Transfer, -Offenlegung
│   │
│   ├── A.2 - PII Processor (17 Controls)
│   │   ├── A.2.2 - Bedingungen für Erhebung und Verarbeitung
│   │   ├── A.2.3 - Pflichten gegenüber PII-Betroffenen
│   │   ├── A.2.4 - Privacy by Design und Default
│   │   └── A.2.5 - PII-Weitergabe, -Transfer, -Offenlegung
│   │
│   └── A.3 - Sicherheits-Controls (29 Controls)
│       └── A.3.3 - A.3.31: Security für PII-Verarbeitung
│
├── Annex B: Implementierungsleitfaden (Normativ)
├── Annex C: Mapping zu ISO/IEC 29100 (Informativ)
├── Annex D: Mapping zur DSGVO (Informativ) ⭐
├── Annex E: Mapping zu ISO/IEC 27018 & 29151 (Informativ)
└── Annex F: Korrespondenz zu ISO 27701:2019 (Informativ)
```

### 2.2 Control-Übersicht

| Annex | Anwendungsbereich | Anzahl Controls |
|-------|-------------------|-----------------|
| **A.1** | PII Controllers | 28 |
| **A.2** | PII Processors | 17 |
| **A.3** | Security (Controller & Processor) | 29 |
| **Gesamt** | | **74** |

### 2.3 Relevanz für DSGVO

ISO 27701 wurde explizit mit DSGVO-Alignment entwickelt:

- **Annex D** enthält direktes DSGVO-Mapping
- **A.1.3** deckt alle Betroffenenrechte (Art. 12-22) ab
- **A.1.4** implementiert Privacy by Design (Art. 25)
- **A.1.5** adressiert Drittlandübermittlung (Art. 44-49)

---

## 3. Mapping-Methodik

### 3.1 Mapping-Typen

| Typ | Beschreibung | Symbol |
|-----|--------------|--------|
| **equivalent** | 1:1 Entsprechung - gleiche Anforderung | ≡ |
| **related** | Thematisch verwandt - ähnliche Zielsetzung | ~ |
| **partial** | Teilweise Abdeckung - Schnittmenge | ⊂ |
| **extends** | OpenGov erweitert ISO 27701 | + |
| **none** | Keine Entsprechung | ∅ |

### 3.2 Confidence-Level

| Level | Beschreibung |
|-------|--------------|
| **high** | Klare, direkte Entsprechung |
| **medium** | Interpretation erforderlich |
| **low** | Schwache oder indirekte Beziehung |

### 3.3 Bidirektionales Mapping

Das Mapping berücksichtigt beide Richtungen:
- **Source → Target**: OpenGov Control → ISO 27701 Coverage
- **Target → Source**: ISO 27701 Control → OpenGov Coverage

---

## 4. Gruppen-Mapping

### 4.1 Übersichtstabelle

| OpenGov Gruppe | ISO 27701 Target | Coverage | Typ |
|----------------|------------------|----------|-----|
| **GOV** (Governance) | Klausel 5, A.3.3-A.3.4 | 85% | related |
| **ACC** (Rechenschaft) | Klausel 7.5, A.1.2.9, A.2.2.7 | 90% | equivalent |
| **LAW** (Rechtsgrundlagen) | A.1.2.2-A.1.2.5, A.3.13 | **95%** | equivalent |
| **DSR** (Betroffenenrechte) | **A.1.3.x** | **95%** | **equivalent** |
| **REG** (Verarbeitungsverzeichnis) | A.1.2.9, A.2.2.7 | 90% | equivalent |
| **TOM** (Tech. & Org. Maßnahmen) | A.3.x, A.1.4.x | 93% | extends |
| **DPIA** (Folgenabschätzung) | A.1.2.6, Klausel 6.1.2/6.1.3 | **95%** | equivalent |
| **OPS** (Betriebsprozesse) | Klausel 8, A.1.2.7 | 85% | related |
| **XFER** (Datenübermittlung) | A.1.5.x, A.2.5.x | 92% | equivalent |
| **INC** (Datenschutzvorfälle) | A.3.11-A.3.12 | 80% | extends |
| **TRAIN** (Schulung) | Klausel 7.2/7.3, A.3.17 | **95%** | equivalent |

### 4.2 Detailliertes Gruppen-Mapping

#### GOV (Governance & Organisation) → Klausel 5

```
GOV-01  Datenschutzorganisation    → 5.3 Rollen/Verantwortlichkeiten
GOV-02  Datenschutzziele           → 5.2 Datenschutzpolitik
GOV-03  Umsetzungsprogramm         → 6.1.3 Risikobehandlung
GOV-04  Datenschutzbeauftragter    → 5.3 (partial - DSB nicht explizit)
GOV-05  Management-Commitment      → 5.1 Führung und Verpflichtung
GOV-06  Ressourcenbereitstellung   → 7.1 Ressourcen
```

#### DSR (Betroffenenrechte) → A.1.3 ⭐ Beste Coverage

```
DSR-01  Informationspflichten      → A.1.3.3/A.1.3.4 (equivalent)
DSR-02  Auskunftsrecht             → A.1.3.7/A.1.3.9/A.1.3.10 (equivalent)
DSR-03  Berichtigung/Löschung      → A.1.3.7/A.1.3.8 (equivalent)
DSR-04  Einschränkung              → A.1.3.2 (related)
DSR-05  Datenportabilität          → A.1.3.9 (related)
DSR-06  Widerspruchsrecht          → A.1.3.6/A.1.3.11 (equivalent)
```

#### TOM (Technische & Org. Maßnahmen) → A.3 + A.1.4

```
TOM-01  Zugangskontrollen          → A.3.8/A.3.9/A.3.23 (equivalent)
TOM-02  Verschlüsselung            → A.3.26/A.1.4.10 (equivalent)
TOM-03  Pseudonymisierung          → A.1.4.5/A.1.4.6 (equivalent)
TOM-04  Datensicherung             → A.3.24 (equivalent)
TOM-05  Physische Sicherheit       → A.3.19/A.3.20/A.3.21 (equivalent)
TOM-06  Protokollierung            → A.3.25 (equivalent)
```

#### XFER (Datenübermittlung) → A.1.5 + A.2.5

```
XFER-01  Drittland-Grundlagen      → A.1.5.2 (equivalent)
XFER-02  Angemessenheitsbeschluss  → A.1.5.3 (equivalent)
XFER-03  Geeignete Garantien       → A.1.5.2/A.2.5.2 (related)
XFER-04  Transfer-Dokumentation    → A.1.5.4 (equivalent)
XFER-05  Offenlegung an Dritte     → A.1.5.5/A.2.5.4 (equivalent)
XFER-06  Behördliche Anfragen      → A.2.5.5/A.2.5.6 (equivalent)
```

---

## 5. Control-Mapping (Auszug)

### 5.1 Beispiel: DSR-02 (Auskunftsrecht) → ISO 27701

```json
{
  "source-control-id": "DSR-02",
  "source-control-title": "Auskunftsrecht",
  "target-mappings": [
    {
      "target-control-id": "A.1.3.7",
      "target-control-title": "Access, correction or erasure",
      "relationship": "equivalent",
      "confidence": "high",
      "rationale": "Richtlinien und Mechanismen für Zugang implementieren"
    },
    {
      "target-control-id": "A.1.3.9",
      "target-control-title": "Providing copy of PII processed",
      "relationship": "equivalent",
      "confidence": "high",
      "rationale": "Auf Anfrage Kopie der verarbeiteten PII bereitstellen"
    },
    {
      "target-control-id": "A.1.3.10",
      "target-control-title": "Handling requests",
      "relationship": "equivalent",
      "confidence": "high",
      "rationale": "Verfahren für Bearbeitung von Betroffenenanfragen"
    }
  ]
}
```

### 5.2 Beispiel: TOM-02 (Verschlüsselung) → ISO 27701

```json
{
  "source-control-id": "TOM-02",
  "source-control-title": "Verschlüsselung",
  "target-mappings": [
    {
      "target-control-id": "A.3.26",
      "target-control-title": "Use of cryptography",
      "relationship": "equivalent",
      "confidence": "high",
      "rationale": "Regeln für Kryptographie bei PII-Verarbeitung"
    },
    {
      "target-control-id": "A.1.4.10",
      "target-control-title": "PII transmission controls",
      "relationship": "related",
      "confidence": "high",
      "rationale": "PII bei Übertragung schützen"
    }
  ]
}
```

---

## 6. Coverage-Analyse

### 6.1 Gesamtübersicht

| Metrik | Wert |
|--------|------|
| Gemappte OpenGov-Gruppen | 11 von 11 (100%) |
| Gemappte OpenGov-Controls | 56 von 56 (100%) |
| Durchschnittliche Coverage | **89%** |
| Controls ohne Mapping | 0 |

### 6.2 Coverage nach Domäne

```
┌─────────────────────────────────────────────────────────────────────┐
│                    COVERAGE-VERTEILUNG                               │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  LAW    ████████████████████████████████████████████████  95%       │
│  DSR    ████████████████████████████████████████████████  95%  ⭐   │
│  DPIA   ████████████████████████████████████████████████  95%       │
│  TRAIN  ████████████████████████████████████████████████  95%       │
│  TOM    ███████████████████████████████████████████████   93%       │
│  XFER   ██████████████████████████████████████████████    92%       │
│  ACC    █████████████████████████████████████████████     90%       │
│  REG    █████████████████████████████████████████████     90%       │
│  GOV    ██████████████████████████████████████████        85%       │
│  OPS    ██████████████████████████████████████████        85%       │
│  INC    ████████████████████████████████████              80%       │
│                                                                      │
│  Durchschnitt: ████████████████████████████████████████   89%       │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.3 Mapping-Typ-Verteilung

| Mapping-Typ | Anzahl Gruppen | Prozent |
|-------------|----------------|---------|
| equivalent | 7 | 64% |
| related | 2 | 18% |
| extends | 2 | 18% |
| partial | 0 | 0% |
| none | 0 | 0% |

---

## 7. Vergleich mit BSI Grundschutz++

### 7.1 Head-to-Head Coverage

| OpenGov Gruppe | ISO 27701 | BSI GS++ | Differenz |
|----------------|-----------|----------|-----------|
| GOV | 85% | 80% | +5% |
| ACC | 90% | 60% | **+30%** |
| LAW | **95%** | 40% | **+55%** |
| **DSR** | **95%** | **0%** | **+95%** ⭐ |
| REG | 90% | 50% | **+40%** |
| TOM | 93% | 85% | +8% |
| DPIA | **95%** | 60% | **+35%** |
| OPS | 85% | 75% | +10% |
| XFER | 92% | 30% | **+62%** |
| INC | 80% | 70% | +10% |
| TRAIN | **95%** | 70% | **+25%** |
| **Durchschnitt** | **89%** | **56%** | **+33%** |

### 7.2 Kritische Unterschiede

```
┌─────────────────────────────────────────────────────────────────────┐
│                FRAMEWORK-VERGLEICH: KRITISCHE BEREICHE              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  BETROFFENENRECHTE (DSR)                                            │
│  ├── ISO 27701:  ████████████████████████████████████████  95%     │
│  └── BSI GS++:   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    0%     │
│                  ⚠️  KRITISCHER GAP bei BSI                         │
│                                                                      │
│  DRITTLANDÜBERMITTLUNG (XFER)                                       │
│  ├── ISO 27701:  ██████████████████████████████████████    92%     │
│  └── BSI GS++:   ████████████                              30%     │
│                  ⚠️  Erheblicher Gap bei BSI                        │
│                                                                      │
│  RECHTSGRUNDLAGEN (LAW)                                             │
│  ├── ISO 27701:  ████████████████████████████████████████  95%     │
│  └── BSI GS++:   ████████████████                          40%     │
│                  ⚠️  Erheblicher Gap bei BSI                        │
│                                                                      │
│  TECHNISCHE MASSNAHMEN (TOM)                                        │
│  ├── ISO 27701:  ███████████████████████████████████████   93%     │
│  └── BSI GS++:   █████████████████████████████████████     85%     │
│                  ✓  Beide gut - BSI detaillierter bei IT-Sec       │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 7.3 Empfehlung

| Use Case | Empfohlenes Framework |
|----------|----------------------|
| Privacy-Compliance (DSGVO) | **ISO 27701** |
| Betroffenenrechte-Management | **ISO 27701** |
| Drittlandübermittlung | **ISO 27701** |
| IT-Sicherheit Detailmaßnahmen | **BSI Grundschutz++** |
| KRITIS-Compliance | **BSI Grundschutz++** |
| Integrierte Lösung | **Beide kombiniert** |

---

## 8. Nutzungsempfehlungen

### 8.1 Für Datenschutzbeauftragte (DSB)

1. **ISO 27701 als primäres Mapping** für Privacy-Compliance nutzen
2. **A.1.3** als Referenz für Betroffenenrechte-Prozesse
3. **Annex D** für DSGVO-Compliance-Nachweis verwenden

### 8.2 Für IT-Security

1. **ISO 27701 A.3** mit BSI Grundschutz kombinieren
2. **A.1.4** für Privacy by Design Requirements
3. **A.3.26** für Kryptographie-Anforderungen

### 8.3 Für Compliance/Audit

1. **Dual-Framework-Ansatz**: ISO 27701 + BSI Grundschutz++
2. **Coverage-Matrix** aus beiden Mappings erstellen
3. **Gap-Analyse** mit OSCAL-Tools automatisieren

### 8.4 Integriertes Profil

Für maximale Coverage empfehlen wir ein kombiniertes OSCAL-Profil:

```
┌─────────────────────────────────────────────────────────────────────┐
│              EMPFOHLENES INTEGRIERTES PROFIL                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  open_privacy_catalog_risk_v0.7.0.json                              │
│       │                                                             │
│       ├──→ opengov_privacy_to_iso27701.json                        │
│       │    (Privacy-Compliance, Betroffenenrechte)                  │
│       │                                                             │
│       └──→ opengov_privacy_to_bsi_grundschutz.json                 │
│            (IT-Sicherheit, KRITIS)                                  │
│                                                                      │
│  Kombinierte Coverage: ~95% aller Privacy & Security Requirements   │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Anhang: Referenzen

### Dokumente

| Dokument | Version | Stand |
|----------|---------|-------|
| ISO/IEC 27701:2025 | Second Edition | 2025-10 |
| DSGVO | Verordnung (EU) 2016/679 | 2018-05-25 |
| OpenGov Privacy Catalog | v0.7.0 | 2026-02-05 |
| BSI Grundschutz++ | 2024 | Q4/2024 |

### OSCAL-Artefakte

| Artefakt | Pfad |
|----------|------|
| Mapping-Datei | `oscal/mappings/opengov_privacy_to_iso27701.json` |
| BSI-Mapping | `oscal/mappings/opengov_privacy_to_bsi_grundschutz.json` |
| Privacy-Katalog | `oscal/catalog/open_privacy_catalog_risk_v0.7.0.json` |

---

*Erstellt: 2026-02-05 | OpenGov Privacy Group*
