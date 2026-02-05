# OSCAL Privacy Kataloge - Konzept und Spezifikation

**Version**: 1.2.1
**Stand**: 2026-02-05
**Status**: BSI Grundschutz++ Mapping integriert

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [open_privacy_catalog (Implementierte Struktur)](#2-open_privacy_catalog-implementierte-struktur)
3. [SDM-Integration im Katalog](#3-sdm-integration-im-katalog)
4. [Component-Definition](#4-component-definition)
5. [Profile-Definition](#5-profile-definition)
6. [Reifegrad- und Risiko-Integration (Implementiert)](#6-reifegrad--und-risiko-integration-implementiert)
7. [Vergabeverfahren-Nutzung](#7-vergabeverfahren-nutzung)
8. [Beispiele](#8-beispiele)
9. [Nächste Schritte](#9-nächste-schritte)
10. [Referenzen](#10-referenzen)
11. [Änderungshistorie](#11-änderungshistorie)

---

## 1. Übersicht

### 1.1 Katalog-Architektur (Implementiert)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    OPEN PRIVACY CATALOG - VOLLSTÄNDIGE STRUKTUR             │
│                              (10 Gruppen)                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   GOVERNANCE & COMPLIANCE                                                   │
│   ═══════════════════════                                                   │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                        │
│   │     GOV     │  │     ACC     │  │    DPIA     │                        │
│   │ Governance  │  │Accountability│ │Risk-Assessm.│                        │
│   │ & Organis.  │  │ & Dokument. │  │ & DSFA      │                        │
│   │             │  │             │  │             │                        │
│   │ Art. 24,    │  │ Art. 5(2),  │  │ Art. 35, 36 │                        │
│   │ 37-39       │  │ 30          │  │             │                        │
│   └─────────────┘  └─────────────┘  └─────────────┘                        │
│                                                                             │
│   RECHTLICHE ANFORDERUNGEN                                                  │
│   ════════════════════════                                                  │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                        │
│   │     LAW     │  │     DSR     │  │    XFER     │                        │
│   │ Rechtsgrund-│  │ Betroffenen-│  │ Datenüber-  │                        │
│   │ lagen       │  │ rechte      │  │ mittlung    │                        │
│   │             │  │             │  │             │                        │
│   │ Art. 5-11   │  │ Art. 12-22  │  │ Art. 44-49  │                        │
│   └─────────────┘  └─────────────┘  └─────────────┘                        │
│                                                                             │
│   OPERATIVE UMSETZUNG (Resilienz-relevant)                                  │
│   ════════════════════════════════════════                                  │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │
│   │     REG     │  │     TOM     │  │     OPS     │  │     INC     │      │
│   │ Verarbeit.- │  │ Techn. &    │  │ Betriebs-   │  │ Incident-   │      │
│   │ verzeichnis │  │ Org. Maßn.  │  │ prozesse    │  │ Management  │      │
│   │             │  │             │  │             │  │             │      │
│   │ Art. 30     │  │ Art. 25,    │  │ Operational │  │ Art. 33, 34 │      │
│   │             │  │ 32-34       │  │             │  │             │      │
│   └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘      │
│                                                                             │
│   Jedes Control enthält:                                                    │
│   • statement (Anforderung)                                                 │
│   • maturity-hints (Reifegrad-Stufen 1, 3, 5)                              │
│   • typical-measures (Umsetzungsmaßnahmen)                                 │
│   • assessment-questions (Prüffragen)                                      │
│   • risk-guidance (Risiko-Szenarien: normal/moderate/high)                 │
│   • risk-hint (Risiko-Einordnung)                                          │
│                                                                             │
│   Fokus: Integrierter Ansatz - WAS und WIE in einem Katalog                 │
│                                                                             │
│   • DSGVO-Anforderungen mit direktem Rechtsbezug                            │
│   • Gewährleistungsziele (SDM) als assurance_goal                           │
│   • Risiko-Perspektive aus Sicht der betroffenen Personen                   │
│   • Reifegrad-Modell (5 Stufen) pro Control                                 │
│   • Typische Maßnahmen und Prüffragen integriert                            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Beziehung der Artefakte

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         OSCAL ARTEFAKT-HIERARCHIE                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CATALOGS (Was ist möglich?)                                               │
│   ══════════════════════════                                                │
│   ┌──────────────────┐     ┌──────────────────┐                            │
│   │oscal-privacy-cat.│     │ sdm-privacy-cat. │                            │
│   │   (Anforderungen)│     │   (Maßnahmen)    │                            │
│   └────────┬─────────┘     └────────┬─────────┘                            │
│            │                        │                                       │
│            └────────────┬───────────┘                                       │
│                         │                                                   │
│                         ▼                                                   │
│   COMPONENTS (Was kann ein Baustein?)                                       │
│   ═══════════════════════════════════                                       │
│   ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐         │
│   │ Prozess-         │  │ Applikations-    │  │ Infrastruktur-   │         │
│   │ Component        │  │ Component        │  │ Component        │         │
│   │                  │  │                  │  │                  │         │
│   │ "OZG-Antrag"     │  │ "Web-Portal"     │  │ "Cloud-Hosting"  │         │
│   │ implementiert:   │  │ implementiert:   │  │ implementiert:   │         │
│   │ • Control A      │  │ • Control B      │  │ • Control C      │         │
│   │ • Control B      │  │ • Control D      │  │ • Control E      │         │
│   └────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘         │
│            │                     │                     │                    │
│            └─────────────────────┼─────────────────────┘                    │
│                                  │                                          │
│                                  ▼                                          │
│   PROFILES (Was braucht ein Anwendungsfall?)                                │
│   ══════════════════════════════════════════                                │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ Profile: "Bürgerportal Standard"                                    │   │
│   │                                                                     │   │
│   │ Kombiniert: OZG-Antrag + Web-Portal + Cloud-Hosting                 │   │
│   │ Tailoring:  Control X → enhanced, Control Y → excluded             │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                  │                                          │
│                                  ▼                                          │
│   SSP (Wie ist es konkret umgesetzt?)                                       │
│   ═══════════════════════════════════                                       │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ SSP: "Bürgerportal Musterstadt"                                     │   │
│   │                                                                     │   │
│   │ Basiert auf: Profile "Bürgerportal Standard"                        │   │
│   │ Evidenz: Screenshots, Konfigurationen, Zertifikate                  │   │
│   │ Verantwortlich: IT-Abteilung Musterstadt                            │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                  │                                          │
│                                  ▼                                          │
│   RoPA (Wie wird es dokumentiert?)                                          │
│   ════════════════════════════════                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ Verarbeitungsverzeichnis                                            │   │
│   │                                                                     │   │
│   │ Verarbeitung: "Bürgerregistrierung"                                 │   │
│   │ Referenziert: SSP "Bürgerportal Musterstadt"                        │   │
│   │ Rechtsgrundlage: Art. 6 Abs. 1 lit. e DSGVO                         │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. open_privacy_catalog (Implementierte Struktur)

### 2.1 Zweck

Der **open_privacy_catalog** ist ein integrierter Katalog, der Datenschutz-Anforderungen und deren Umsetzung verbindet. Er beantwortet sowohl *"Was muss beachtet werden?"* als auch *"Wie wird es umgesetzt?"* und *"Welche Risiken bestehen?"*

**Repository:** [opengov-privacy-oscal](https://github.com/open-gov-group/opengov-privacy-oscal)

### 2.2 Gruppen-Struktur (Implementiert - 10 Gruppen)

```yaml
catalog:
  uuid: "0b431870-7f9d-440f-ac7d-d42bb92e3acb"
  metadata:
    title: "OSCAL-Datenschutzkatalog nach DSGVO"
    version: "0.5.0"
    oscal-version: "1.1.2"

  groups:
    # GOVERNANCE & COMPLIANCE
    - id: "GOV"
      class: "governance"
      title: "GOV – Governance & Organisation"

    - id: "ACC"
      class: "accountability"
      title: "ACC – Rechenschaft & Dokumentation"

    - id: "DPIA"
      class: "data-protection-impact-assessment"
      title: "DPIA – Datenschutz-Folgenabschätzung & Risikomanagement"

    # RECHTLICHE ANFORDERUNGEN
    - id: "LAW"
      class: "legal"
      title: "LAW – Rechtsgrundlagen, Zweckbindung & Datenminimierung"

    - id: "DSR"
      class: "data-subject-rights"
      title: "DSR – Rechte der betroffenen Personen"

    - id: "XFER"
      class: "transfers"
      title: "XFER – Datenübermittlungen & internationale Transfers"

    # OPERATIVE UMSETZUNG (Resilienz-relevant)
    - id: "REG"
      class: "records-of-processing"
      title: "REG – Verarbeitungsverzeichnis & Informationsflüsse"

    - id: "TOM"
      class: "technical-organizational-measures"
      title: "TOM – Technische und organisatorische Maßnahmen"

    - id: "OPS"
      class: "operations"
      title: "OPS – Betriebsprozesse & operative Umsetzung"

    - id: "INC"
      class: "incident-management"
      title: "INC – Datenschutzvorfälle & Meldungen"
```

### 2.2.1 Gruppen-Übersicht (Vollständig)

| Gruppe | Class | DSGVO-Bezug | Fokus | Resilienz-Relevanz |
|--------|-------|-------------|-------|-------------------|
| **GOV** | governance | Art. 24, 37-39 | Aufbauorganisation, DSB, Verantwortlichkeiten | Organisatorische Resilienz |
| **ACC** | accountability | Art. 5 Abs. 2, 30 | Dokumentation, Nachweisführung, DSMS | Nachweisfähigkeit |
| **LAW** | legal | Art. 5-11 | Rechtsgrundlagen, Zweckbindung, Datenminimierung | Compliance |
| **DSR** | data-subject-rights | Art. 12-22 | Betroffenenrechte (Auskunft, Löschung, etc.) | Intervenierbarkeit |
| **REG** | records-of-processing | Art. 30 | Verarbeitungsverzeichnis, Informationsflüsse | Transparenz |
| **TOM** | technical-organizational-measures | Art. 25, 32-34 | Technische & organisatorische Maßnahmen | **Kern-Resilienz** |
| **DPIA** | data-protection-impact-assessment | Art. 35, 36 | Datenschutz-Folgenabschätzung, Risikomanagement | Risikomanagement |
| **OPS** | operations | Operational | Betriebsprozesse, operative Umsetzung | **Betriebsresilienz** |
| **XFER** | transfers | Art. 44-49 | Datenübermittlungen, internationale Transfers | Supply Chain |
| **INC** | incident-management | Art. 33, 34 | Datenschutzvorfälle, Meldungen | **Incident Response** |

### 2.2.2 Kategorisierung nach Domänen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         DOMÄNEN-ZUORDNUNG                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   GOVERNANCE & COMPLIANCE          RECHTLICHE ANFORDERUNGEN                 │
│   ┌─────┐ ┌─────┐ ┌──────┐        ┌─────┐ ┌─────┐ ┌──────┐                │
│   │ GOV │ │ ACC │ │ DPIA │        │ LAW │ │ DSR │ │ XFER │                │
│   └──┬──┘ └──┬──┘ └──┬───┘        └──┬──┘ └──┬──┘ └──┬───┘                │
│      │       │       │               │       │       │                      │
│      └───────┼───────┘               └───────┼───────┘                      │
│              │                               │                              │
│              ▼                               ▼                              │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    OPERATIVE UMSETZUNG                              │   │
│   │                  (Resilienz-Schnittstelle)                          │   │
│   │                                                                     │   │
│   │   ┌─────┐         ┌─────┐         ┌─────┐         ┌─────┐          │   │
│   │   │ REG │ ◄─────► │ TOM │ ◄─────► │ OPS │ ◄─────► │ INC │          │   │
│   │   │     │         │     │         │     │         │     │          │   │
│   │   │VVT  │         │Maßn.│         │Betr.│         │Vorfl.│          │   │
│   │   └─────┘         └─────┘         └─────┘         └─────┘          │   │
│   │                                                                     │   │
│   │   Diese 4 Gruppen haben die stärkste Verbindung zu                  │   │
│   │   Security-/Resilienz-Frameworks (BSI, ISO 27001, NIST)             │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.3 Control-Eigenschaften (Props) - Implementiert

Jedes Control enthält folgende Properties mit erweiterter Taxonomie:

#### 2.3.1 Rechtsbezug (legal)

```json
{
  "name": "legal",
  "value": "EU:REG:GDPR:ART-32",
  "class": "proof",
  "ns": "de",
  "group": "reference",
  "remarks": "Art. 32 DS-GVO"
}
```

| Attribut | Beschreibung | Beispiel |
|----------|--------------|----------|
| `value` | Strukturierte Rechtsreferenz | `EU:REG:GDPR:ART-32_ABS-1_LIT-a` |
| `class` | Art der Referenz | `proof` |
| `ns` | Namespace/Sprache | `de`, `en` |
| `group` | Gruppierung | `reference` |
| `remarks` | Lesbare Bezeichnung | `Art. 32 DS-GVO` |

**Referenz-Format:** `{Jurisdiction}:{Type}:{Regulation}:{Article}[_ABS-x][_LIT-y]`

#### 2.3.2 Gewährleistungsziel (assurance_goal)

```json
{
  "name": "assurance_goal",
  "value": "confidentiality",
  "class": "teleological_interpretation",
  "ns": "de",
  "group": "aim_of_measure",
  "remarks": "Vertraulichkeit"
}
```

| Wert | SDM-Gewährleistungsziel | Beschreibung |
|------|-------------------------|--------------|
| `availability` | Verfügbarkeit | Daten stehen zur Verfügung |
| `integrity` | Integrität | Daten sind korrekt und unverändert |
| `confidentiality` | Vertraulichkeit | Nur Berechtigte haben Zugriff |
| `transparency` | Transparenz | Verarbeitung ist nachvollziehbar |
| `intervenability` | Intervenierbarkeit | Betroffene können eingreifen |
| `unlinkability` | Nichtverkettung | Keine unzulässige Verknüpfung |
| `data-minimization` | Datenminimierung | Nur notwendige Daten |

#### 2.3.3 Reifegrad und Maßnahmentyp

| Property | Beschreibung | Beispielwerte |
|----------|--------------|---------------|
| `maturity-domain` | Fachbereich des Reifegrads | `access-control`, `encryption`, `documentation` |
| `target-maturity` | Ziel-Reifegrad | `1`-`5` |
| `measure-type` | Art der Maßnahme | `technical`, `organizational`, `hybrid` |
| `evidence-type` | Nachweisarten | `access-control-policy, iam-configuration, audit-logs` |

### 2.4 Control-Parts-Struktur (Implementiert)

Jedes Control enthält die folgenden standardisierten Parts:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CONTROL PARTS STRUKTUR                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. STATEMENT                                                              │
│      └─► Hauptanforderung des Controls                                      │
│                                                                             │
│   2. MATURITY-HINTS                                                         │
│      ├─► maturity-level-1 (Initial)                                         │
│      ├─► maturity-level-3 (Defined)                                         │
│      └─► maturity-level-5 (Optimized)                                       │
│                                                                             │
│   3. TYPICAL-MEASURES                                                       │
│      ├─► measure-1                                                          │
│      ├─► measure-2                                                          │
│      └─► measure-n                                                          │
│                                                                             │
│   4. ASSESSMENT-QUESTIONS                                                   │
│      ├─► question-1                                                         │
│      └─► question-2                                                         │
│                                                                             │
│   5. RISK-GUIDANCE (class: dp-risk-overview)                                │
│      ├─► risk-impact-scenario (impact-level: normal)                        │
│      ├─► risk-impact-scenario (impact-level: moderate)                      │
│      └─► risk-impact-scenario (impact-level: high)                          │
│                                                                             │
│   6. RISK-HINT                                                              │
│      └─► Zusammenfassende Risiko-Einordnung                                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 2.4.1 Part: statement

Die Kernaussage des Controls – was erfüllt werden muss.

#### 2.4.2 Part: maturity-hints

Beschreibt die Reifegrad-Stufen für dieses Control mit konkreten Merkmalen:

| Sub-Part | Reifegrad | Beschreibung |
|----------|-----------|--------------|
| `maturity-level-1` | Initial | Ad-hoc, unstrukturiert, keine Dokumentation |
| `maturity-level-3` | Defined | Dokumentiert, standardisiert, regelmäßig |
| `maturity-level-5` | Optimized | Automatisiert, gemessen, kontinuierlich verbessert |

#### 2.4.3 Part: typical-measures

Konkrete Umsetzungsmaßnahmen für das Control, jeweils als `measure` Sub-Part.

#### 2.4.4 Part: assessment-questions

Prüffragen zur Bewertung der Umsetzung, jeweils als `question` Sub-Part.

#### 2.4.5 Part: risk-guidance

Risikobeschreibung aus Sicht der betroffenen Personen mit drei Szenarien:

| Impact-Level | Datenkategorien | Typische Risiken |
|--------------|-----------------|------------------|
| `normal` | Stammdaten, Kontaktdaten | Unerwünschte Kontaktaufnahme, Vertrauensverlust |
| `moderate` | Finanzdaten, Standortdaten | Identitätsmissbrauch, Erpressung |
| `high` | Art. 9/10 DSGVO Daten | Diskriminierung, Stigmatisierung, physische Gefährdung |

#### 2.4.6 Part: risk-hint

Zusammenfassende Einordnung wann welche Risikobetrachtung erforderlich ist.

### 2.5 Beispiel-Control: TOM-02 (Vollständig)

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
    { "name": "maturity-domain", "value": "access-control" },
    { "name": "target-maturity", "value": "4" },
    { "name": "measure-type", "value": "technical" },
    { "name": "evidence-type", "value": "access-control-policy, iam-configuration, access-review-records" }
  ],
  "parts": [
    {
      "id": "tom-02-stmt",
      "name": "statement",
      "prose": "Die Organisation stellt durch ein systematisches Zugriffs- und Berechtigungsmanagement sicher, dass nur berechtigte Personen entsprechend dem Prinzip der geringsten Rechte auf personenbezogene Daten zugreifen können, und überprüft die Berechtigungen regelmäßig."
    },
    {
      "id": "tom-02-maturity",
      "name": "maturity-hints",
      "prose": "...",
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
        }
      ]
    },
    {
      "id": "tom-02-risk-guidance",
      "name": "risk-guidance",
      "class": "dp-risk-overview",
      "prose": "Risikobeschreibung aus Sicht der betroffenen Personen...",
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
    }
  ]
}
```

### 2.6 Gruppen-Übersicht und DSGVO-Bezug (Vollständig)

| Gruppe | Primäre DSGVO-Artikel | Fokus | Status |
|--------|----------------------|-------|--------|
| **GOV** | Art. 24, 37-39 | Organisation, DSB, Verantwortlichkeiten | Implementiert |
| **ACC** | Art. 5 Abs. 2, 30 | Rechenschaftspflicht, Dokumentation, DSMS | Implementiert |
| **LAW** | Art. 5-11 | Rechtmäßigkeit, Zweckbindung, Datenminimierung | Implementiert |
| **DSR** | Art. 12-22 | Betroffenenrechte (Auskunft, Berichtigung, Löschung) | Implementiert |
| **REG** | Art. 30 | Verarbeitungsverzeichnis, Informationsflüsse | Implementiert |
| **TOM** | Art. 25, 32-34 | Technische & organisatorische Maßnahmen | Implementiert |
| **DPIA** | Art. 35, 36 | Datenschutz-Folgenabschätzung, Risikomanagement | Implementiert |
| **OPS** | Operational | Betriebsprozesse, operative Umsetzung | Implementiert |
| **XFER** | Art. 44-49 | Datenübermittlungen, internationale Transfers | Implementiert |
| **INC** | Art. 33, 34 | Datenschutzvorfälle, Meldungen an Aufsichtsbehörden | Implementiert |

### 2.7 Control-Klassen

| Class | Beschreibung | Beispiel-Controls |
|-------|--------------|-------------------|
| `management` | Managementbezogene Controls | GOV-01: Datenschutzorganisation |
| `procedure` | Verfahrensbezogene Controls | ACC-01: DSMS dokumentiert |
| `policy` | Richtlinien-Controls | LAW-01: Rechtsgrundlagen festgelegt |
| `process` | Prozess-Controls | DSR-01: Betroffenenrechte-Governance |
| `record` | Dokumentations-Controls | REG-01: Verarbeitungsverzeichnis |
| `safeguard` | Schutzmaßnahmen (TOM) | TOM-02: Berechtigungsmanagement |

### 2.8 Resilienz-Schnittstellen

Die Gruppen **REG**, **TOM**, **OPS** und **INC** bilden die Resilienz-Schnittstelle zum Security-/Resilience-Framework:

| Privacy-Gruppe | Resilienz-Bezug | Mapping zu Security-Frameworks |
|----------------|-----------------|--------------------------------|
| **TOM** | Kern-Resilienz | BSI IT-Grundschutz, ISO 27001 Annex A |
| **OPS** | Betriebsresilienz | ISO 27001 A.12 (Operations), ITIL |
| **INC** | Incident Response | ISO 27001 A.16, NIST IR, BSI IT-Notfallmanagement |
| **REG** | Asset Management | ISO 27001 A.8, BSI CON.2 |

---

## 3. SDM-Integration im Katalog

### 3.1 Ansatz

Anstatt eines separaten SDM-Katalogs werden die **SDM-Gewährleistungsziele** direkt in die Controls des open_privacy_catalog integriert. Dies erfolgt über die `assurance_goal`-Properties.

### 3.2 Gewährleistungsziele (assurance_goal)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SDM GEWÄHRLEISTUNGSZIELE IM KATALOG                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Jedes Control kann mehrere assurance_goals haben:                         │
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ TOM-02: Zugriffs- und Berechtigungsmanagement                       │   │
│   │                                                                     │   │
│   │ assurance_goals:                                                    │   │
│   │   • confidentiality (Vertraulichkeit) ◄──── Primärziel             │   │
│   │   • integrity (Integrität) ◄──────────────  Sekundärziel           │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│   Die 7 SDM-Gewährleistungsziele:                                          │
│   ═══════════════════════════════                                          │
│                                                                             │
│   1. availability       │ Verfügbarkeit      │ Daten stehen zur Verfügung  │
│   2. integrity          │ Integrität         │ Daten sind korrekt          │
│   3. confidentiality    │ Vertraulichkeit    │ Zugriff nur für Berechtigte │
│   4. transparency       │ Transparenz        │ Verarbeitung nachvollziehbar│
│   5. intervenability    │ Intervenierbarkeit │ Betroffene können eingreifen│
│   6. unlinkability      │ Nichtverkettung    │ Keine unzulässige Verkn.    │
│   7. data-minimization  │ Datenminimierung   │ Nur notwendige Daten        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.3 Property-Struktur für assurance_goal

```json
{
  "name": "assurance_goal",
  "value": "confidentiality",
  "class": "teleological_interpretation",
  "ns": "de",
  "group": "aim_of_measure",
  "remarks": "Vertraulichkeit"
}
```

| Attribut | Beschreibung |
|----------|--------------|
| `class` | `teleological_interpretation` – teleologische Auslegung |
| `group` | `aim_of_measure` – Maßnahmenziel |
| `remarks` | Deutsche Bezeichnung |

### 3.4 Mapping: Controls → Gewährleistungsziele

| Control-Gruppe | Typische assurance_goals |
|----------------|-------------------------|
| **GOV** | transparency, accountability |
| **ACC** | transparency, accountability |
| **LAW** | data-minimization, unlinkability |
| **TOM** | confidentiality, integrity, availability |

### 3.5 Abgrenzung zum separaten SDM-Katalog (Geplant)

Ein separater `sdm-privacy-catalog` kann künftig erstellt werden für:
- Detaillierte Maßnahmen-Kataloge je Gewährleistungsziel
- Framework-Mappings (ISO 27001, BSI IT-Grundschutz, NIST)
- SDM-Schichten (Prozess, Applikation, Infrastruktur)

**Aktueller Stand:** Die Gewährleistungsziele sind als Properties in den open_privacy_catalog integriert.

### 3.6 Maßnahmentypen (measure-type)

Die Controls unterscheiden verschiedene Maßnahmentypen:

| measure-type | Beschreibung | Beispiele |
|--------------|--------------|-----------|
| `technical` | Technische Maßnahmen | Verschlüsselung, Zugriffskontrolle, Logging |
| `organizational` | Organisatorische Maßnahmen | Richtlinien, Schulungen, Prozesse |
| `hybrid` | Kombiniert | Incident Response, Berechtigungsreviews |

### 3.7 Mapping zu Resilienz-Frameworks (Geplant)

Mappings zu anderen Frameworks erfolgen künftig über das [opengov-privacy-mappings](https://github.com/open-gov-group/opengov-privacy-mappings) Repository:

| Open Privacy Control | ISO 27001:2022 | BSI IT-Grundschutz | NIST CSF |
|---------------------|----------------|--------------------|---------|
| TOM-02 | A.9.2.1, A.9.2.3 | ORP.4.A1 | PR.AC-1 |
| TOM-03 | A.10.1.1 | CON.1.A1 | PR.DS-1 |
| GOV-01 | A.5.1.1 | ISMS.1.A1 | ID.GV-1 |

**Mapping-Confidence-Levels:**
- `equivalent`: Direkte Entsprechung
- `related`: Thematisch verwandt
- `partial`: Teilweise Abdeckung
- `extends`: Erweitert das Control

---

## 4. Component-Definition

### 4.1 Was ist eine Component?

Eine **Component** ist ein wiederverwendbarer Baustein, der bestimmte Controls aus den Katalogen implementiert. Components sind die "Lego-Steine" des Systems.

### 4.2 Wann definiere ich eine Component?

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ENTSCHEIDUNGSBAUM: COMPONENT?                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Frage 1: Ist es wiederverwendbar?                                         │
│            │                                                                │
│            ├── NEIN → Keine Component (direkter SSP-Eintrag)                │
│            │                                                                │
│            └── JA → Frage 2: Implementiert es Controls?                     │
│                      │                                                      │
│                      ├── NEIN → Keine Component (kein Datenschutz-Bezug)    │
│                      │                                                      │
│                      └── JA → Frage 3: Welche Schicht?                      │
│                                │                                            │
│                                ├── Prozess → Prozess-Component              │
│                                │   (z.B. OZG-Antragsprozess)                │
│                                │                                            │
│                                ├── Applikation → Applikations-Component     │
│                                │   (z.B. Web-Portal, CMS)                   │
│                                │                                            │
│                                └── Infrastruktur → Infrastruktur-Component  │
│                                    (z.B. Cloud-Hosting, Datenbank)          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.3 Component-Typen

| Typ | Schicht | Beispiele | Verantwortlich |
|-----|---------|-----------|----------------|
| **Prozess-Component** | process | OZG-Antragsprozess, Meldevorgang, Auskunftsverfahren | Fachbereich |
| **Applikations-Component** | application | Web-Portal, E-Mail-System, CMS, Fachverfahren | Entwicklung |
| **Infrastruktur-Component** | infrastructure | Cloud-Hosting, Datenbank-Cluster, Firewall-Appliance | IT-Betrieb |
| **Hybrid-Component** | multiple | Standard-Software mit Hosting (z.B. "SAP on Azure") | Shared |

### 4.4 Component-Struktur

```json
{
  "component-definition": {
    "uuid": "uuid-component-web-portal",
    "metadata": {
      "title": "Standard Web-Portal Component",
      "version": "1.0.0"
    },
    "components": [
      {
        "uuid": "uuid-comp-1",
        "type": "software",
        "title": "Web-Portal für Bürgerservices",
        "description": "React-basiertes Portal für Bürgeranträge",
        "props": [
          { "name": "sdm-layer", "value": "application" },
          { "name": "vendor", "value": "Eigenentwicklung" },
          { "name": "maturity-level", "value": "3" }
        ],
        "control-implementations": [
          {
            "uuid": "uuid-impl-1",
            "source": "#sdm-privacy-catalog",
            "description": "Implementierte Datenschutz-Maßnahmen",
            "implemented-requirements": [
              {
                "uuid": "uuid-req-1",
                "control-id": "SDM-TOM-AC-01",
                "description": "RBAC über Spring Security implementiert",
                "props": [
                  { "name": "implementation-status", "value": "implemented" },
                  { "name": "implementation-level", "value": "standard" }
                ]
              },
              {
                "uuid": "uuid-req-2",
                "control-id": "SDM-TOM-LG-01",
                "description": "Logging über ELK-Stack",
                "props": [
                  { "name": "implementation-status", "value": "implemented" },
                  { "name": "implementation-level", "value": "enhanced" }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}
```

### 4.5 Beispiel-Components

| Component | Typ | Implementiert | Reifegrad |
|-----------|-----|---------------|-----------|
| **OZG-Antragsprozess** | Prozess | PRIV-TRANS-01, PRIV-CONSENT-01, SDM-TOM-ORG-04 | 3 |
| **Web-Portal Standard** | Applikation | SDM-TOM-AC-01, SDM-TOM-LG-01, SDM-TOM-CR-01 | 3 |
| **Cloud-Hosting BSI-C5** | Infrastruktur | SDM-TOM-INF-01, SDM-TOM-INF-02, SDM-TOM-BK-01 | 4 |
| **Auth-Service (OIDC)** | Applikation | SDM-TOM-AC-01, SDM-TOM-AC-02 | 4 |

---

## 5. Profile-Definition

### 5.1 Was ist ein Profile?

Ein **Profile** kombiniert Components und passt Controls an einen spezifischen Anwendungsfall an. Profiles definieren, welche Controls für einen bestimmten Einsatzzweck relevant sind.

### 5.2 Profile-Struktur

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         PROFILE-AUFBAU                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   PROFILE: "Bürgerportal Standard"                                          │
│   ═══════════════════════════════                                           │
│                                                                             │
│   1. IMPORTS (Welche Kataloge?)                                             │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ • oscal-privacy-catalog (alle relevanten Controls)              │    │
│      │ • sdm-privacy-catalog (alle relevanten TOM)                     │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   2. MERGE (Welche Components?)                                             │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ • Component: Web-Portal Standard                                │    │
│      │ • Component: Auth-Service (OIDC)                                │    │
│      │ • Component: Cloud-Hosting BSI-C5                               │    │
│      │ • Component: OZG-Antragsprozess                                 │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   3. MODIFY (Anpassungen)                                                   │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ • SDM-TOM-AC-01: implementation-level → "enhanced"              │    │
│      │ • SDM-TOM-CR-01: Zusätzliche Anforderung (TLS 1.3)              │    │
│      │ • PRIV-CONSENT-01: Parameter für Online-Einwilligung            │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   4. EXCLUDE (Nicht relevant)                                               │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ • SDM-TOM-PHY-01: Physische Sicherheit (Cloud-Provider)         │    │
│      │ • PRIV-PROFIL-01: Kein Profiling vorgesehen                     │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.3 Tailoring-Regeln

| Aktion | Beschreibung | Beispiel |
|--------|--------------|----------|
| **include** | Control aufnehmen | Alle Controls aus Gruppe X |
| **exclude** | Control ausschließen | Nicht relevant für Use-Case |
| **modify** | Control anpassen | implementation-level ändern |
| **add** | Parameter hinzufügen | Spezifische Konfiguration |

### 5.4 Beispiel-Profile

```json
{
  "profile": {
    "uuid": "uuid-profile-buergerportal",
    "metadata": {
      "title": "Bürgerportal Standard Profile",
      "version": "1.0.0"
    },
    "imports": [
      {
        "href": "#oscal-privacy-catalog",
        "include-controls": [
          { "with-ids": ["PRIV-TRANS-*", "PRIV-CONSENT-*", "PRIV-RIGHTS-*"] }
        ]
      },
      {
        "href": "#sdm-privacy-catalog",
        "include-controls": [
          { "with-ids": ["SDM-TOM-AC-*", "SDM-TOM-LG-*", "SDM-TOM-CR-*"] }
        ],
        "exclude-controls": [
          { "with-ids": ["SDM-TOM-PHY-*"] }
        ]
      }
    ],
    "merge": {
      "combine": { "method": "merge" }
    },
    "modify": {
      "set-parameters": [
        {
          "param-id": "ac-01_retention",
          "values": ["90 Tage"]
        }
      ],
      "alters": [
        {
          "control-id": "SDM-TOM-AC-01",
          "adds": [
            {
              "position": "after",
              "parts": [
                {
                  "name": "additional-requirement",
                  "prose": "Für Bürgerportale ist zusätzlich 2FA erforderlich."
                }
              ]
            }
          ]
        }
      ]
    }
  }
}
```

### 5.5 Standard-Profile (geplant)

| Profile | Zielgruppe | Controls | Reifegrad |
|---------|------------|----------|-----------|
| **Bürgerportal Basis** | Kleine Gemeinden | ~30 | 2-3 |
| **Bürgerportal Standard** | Mittlere Kommunen | ~50 | 3 |
| **Bürgerportal Erweitert** | Große Städte | ~70 | 3-4 |
| **OZG-Fachverfahren** | Alle OZG-Leistungen | ~60 | 3 |
| **Kritische Infrastruktur** | KRITIS-Betreiber | ~80 | 4-5 |

---

## 6. Reifegrad- und Risiko-Integration (Implementiert)

### 6.1 Risiko-Perspektive: Betroffene Personen

Die Risikobewertung im Katalog erfolgt konsequent aus der **Perspektive der betroffenen Personen** – nicht aus Unternehmenssicht. Dies entspricht dem DSGVO-Ansatz.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RISIKO-IMPACT-SZENARIEN (Implementiert)                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                        risk-guidance                                │   │
│   │                    (class: dp-risk-overview)                        │   │
│   │                                                                     │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │ risk-impact-scenario (impact-level: normal)                 │   │   │
│   │   │                                                             │   │   │
│   │   │ data-category-example: Stammdaten, Kontaktdaten             │   │   │
│   │   │                                                             │   │   │
│   │   │ Typische Risiken:                                           │   │   │
│   │   │ • Unerwünschte Kontaktaufnahme                              │   │   │
│   │   │ • Unberechtigte interne Einsichtnahme                       │   │   │
│   │   │ • Spürbarer Vertrauensverlust                               │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │ risk-impact-scenario (impact-level: moderate)               │   │   │
│   │   │                                                             │   │   │
│   │   │ data-category-example: Finanz-, Standort-, Kommunikations-  │   │   │
│   │   │                        daten, vulnerable Gruppen            │   │   │
│   │   │                                                             │   │   │
│   │   │ Typische Risiken:                                           │   │   │
│   │   │ • Finanzielle Schäden, Identitätsmissbrauch                 │   │   │
│   │   │ • Erpressungsversuche                                       │   │   │
│   │   │ • Nachhaltiger Vertrauensverlust                            │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │ risk-impact-scenario (impact-level: high)                   │   │   │
│   │   │                                                             │   │   │
│   │   │ data-category-example: Art. 9 DSGVO (besondere Kategorien), │   │   │
│   │   │                        Art. 10 DSGVO (Strafdaten), Profiling│   │   │
│   │   │                                                             │   │   │
│   │   │ Typische Risiken:                                           │   │   │
│   │   │ • Diskriminierung, Stigmatisierung                          │   │   │
│   │   │ • Soziale Ausgrenzung                                       │   │   │
│   │   │ • Psychische Belastungen                                    │   │   │
│   │   │ • Physische Gefährdung                                      │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Risk-Impact-Scenario Struktur

```json
{
  "id": "tom-02-risk-impact-high",
  "name": "risk-impact-scenario",
  "class": "dp-risk-impact",
  "props": [
    {
      "name": "impact-level",
      "class": "dp-risk",
      "value": "high"
    },
    {
      "name": "data-category-example",
      "class": "dp-data-category",
      "value": "Besondere Kategorien nach Art. 9 DSGVO, Strafdaten nach Art. 10 DSGVO"
    }
  ],
  "prose": "Detaillierte Beschreibung der Risiken für betroffene Personen..."
}
```

### 6.3 Datenkategorien und Impact-Levels

| Impact-Level | Datenkategorien | DSFA erforderlich? |
|--------------|-----------------|-------------------|
| **normal** | Stammdaten, Kontaktdaten, einfache Nutzungsdaten | In der Regel nein |
| **moderate** | Finanzdaten, Standortdaten, Kommunikationsmetadaten, vulnerable Gruppen | Prüfung empfohlen |
| **high** | Art. 9 DSGVO (Gesundheit, Religion, politische Meinung, sexuelle Orientierung), Art. 10 DSGVO (Strafdaten), umfangreiches Profiling | Regelmäßig erforderlich |

### 6.4 Reifegrad-Modell (Implementiert)

Das Reifegrad-Modell verwendet 5 Stufen, wobei im Katalog die Stufen 1, 3 und 5 als Orientierung beschrieben werden:

| Stufe | Name | Beschreibung | Im Katalog |
|-------|------|--------------|------------|
| **1** | Initial | Ad-hoc, unstrukturiert, keine Dokumentation | ✓ maturity-level-1 |
| **2** | Repeatable | Teilweise umgesetzt, wiederholbar | (interpoliert) |
| **3** | Defined | Dokumentiert, standardisiert, regelmäßig | ✓ maturity-level-3 |
| **4** | Managed | Gemessen, bewertet, gesteuert | (interpoliert) |
| **5** | Optimized | Automatisiert, kontinuierlich verbessert | ✓ maturity-level-5 |

### 6.5 Maturity-Hints Struktur

```json
{
  "id": "tom-02-maturity",
  "name": "maturity-hints",
  "parts": [
    {
      "id": "tom-02-maturity-level-01",
      "name": "maturity-level-1",
      "prose": "Level 1: Berechtigungen werden manuell ohne einheitliche Modelle vergeben...",
      "props": [{ "name": "maturity-level", "value": "1" }]
    },
    {
      "id": "tom-02-maturity-level-03",
      "name": "maturity-level-3",
      "prose": "Level 3: Dokumentierte Policy, regelmäßige Rezertifizierungen...",
      "props": [{ "name": "maturity-level", "value": "3" }]
    },
    {
      "id": "tom-02-maturity-level-05",
      "name": "maturity-level-5",
      "prose": "Level 5: Automatisiert (IAM/IDM), risikobasierte Reviews, Kennzahlen...",
      "props": [{ "name": "maturity-level", "value": "5" }]
    }
  ]
}
```

### 6.6 Reifegrad-Properties auf Control-Ebene

| Property | Beschreibung | Beispiel |
|----------|--------------|----------|
| `maturity-domain` | Fachbereich | `access-control`, `encryption` |
| `target-maturity` | Empfohlener Ziel-Reifegrad | `4` |

### 6.7 Kombinierte Bewertung (Anwendungsbeispiel)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CONTROL-BEWERTUNG: TOM-02                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Control: TOM-02 (Zugriffs- und Berechtigungsmanagement)                   │
│                                                                             │
│   RISIKO-DIMENSION                    REIFEGRAD-DIMENSION                   │
│   ══════════════════                  ═══════════════════                   │
│                                                                             │
│   Kontext: Gesundheitsdaten           target-maturity: 4                    │
│   → impact-level: HIGH                maturity-domain: access-control       │
│   ─────────────────                   ───────────────────                   │
│   DSFA erforderlich: JA               Aktueller Stand: Level 3              │
│                                                                             │
│   PRÜFUNG ANHAND DER PARTS                                                  │
│   ════════════════════════                                                  │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ assessment-questions:                                               │   │
│   │                                                                     │   │
│   │ ✓ Bestehen dokumentierte Rollen- und Berechtigungskonzepte?         │   │
│   │ ✓ Werden Zugriffsrechte regelmäßig rezertifiziert?                  │   │
│   │                                                                     │   │
│   │ typical-measures umgesetzt:                                         │   │
│   │                                                                     │   │
│   │ ✓ Access-Control-Policy vorhanden                                   │   │
│   │ ✓ Joiner-Mover-Leaver-Prozesse definiert                            │   │
│   │ ○ Regelmäßige Rezertifizierungen (teilweise)                        │   │
│   │ ○ Standardrollen + MFA (in Einführung)                              │   │
│   │                                                                     │   │
│   │ Reifegrad-Einordnung (maturity-hints):                              │   │
│   │                                                                     │   │
│   │ Level 1: ────── Level 3: ══════ Level 5:                            │   │
│   │                    ▲                                                │   │
│   │              Aktueller Stand                                        │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│   ERGEBNIS: Maßnahmen für Level 4/5 planen (IAM-Automatisierung)            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. Vergabeverfahren-Nutzung

### 7.1 Anwendungsfall

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    VERGABEVERFAHREN MIT OSCAL                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   AUFTRAGGEBER (Behörde)                                                    │
│   ══════════════════════                                                    │
│                                                                             │
│   1. ANFORDERUNGEN DEFINIEREN                                               │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ "Die zu beschaffende Lösung muss folgende Datenschutz-          │    │
│      │  Anforderungen erfüllen:                                        │    │
│      │                                                                 │    │
│      │  • Profile: Bürgerportal Standard (oder gleichwertig)           │    │
│      │  • Mindest-Reifegrad: 3                                         │    │
│      │  • Nachweis: OSCAL Component-Definition                         │    │
│      │                                                                 │    │
│      │  Referenz: https://github.com/open-gov-group/profiles/          │    │
│      │            buergerportal-standard.json                          │    │
│      │ "                                                               │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   ANBIETER                                                                  │
│   ════════                                                                  │
│                                                                             │
│   2. NACHWEIS LIEFERN                                                       │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ Component-Definition:                                           │    │
│      │ {                                                               │    │
│      │   "component": "Anbieter Web-Portal v3.0",                      │    │
│      │   "control-implementations": [                                  │    │
│      │     {                                                           │    │
│      │       "control-id": "SDM-TOM-AC-01",                            │    │
│      │       "implementation-status": "implemented",                   │    │
│      │       "implementation-level": "standard",                       │    │
│      │       "evidence": "Zertifikat ISO 27001, Audit-Report"          │    │
│      │     },                                                          │    │
│      │     ...                                                         │    │
│      │   ]                                                             │    │
│      │ }                                                               │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│   PRÜFUNG                                                                   │
│   ═══════                                                                   │
│                                                                             │
│   3. AUTOMATISIERTE VALIDIERUNG                                             │
│      ┌─────────────────────────────────────────────────────────────────┐    │
│      │ • Component gegen Profile validieren                            │    │
│      │ • Lücken-Analyse: Welche Controls fehlen?                       │    │
│      │ • Reifegrad-Prüfung: Mindestens Stufe 3?                        │    │
│      │ • Evidenz-Prüfung: Sind Nachweise plausibel?                    │    │
│      │                                                                 │    │
│      │ Ergebnis: Compliance-Score, Gap-Report                          │    │
│      └─────────────────────────────────────────────────────────────────┘    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.2 Formulierung für Ausschreibungen

**Beispiel-Textbaustein:**

```markdown
## 3.4 Datenschutz-Anforderungen

Der Auftragnehmer muss nachweisen, dass die angebotene Lösung die
Datenschutz-Anforderungen gemäß dem OpenGov Privacy Profile
"Bürgerportal Standard" (Version 1.0) erfüllt.

### Nachweisführung

Der Nachweis erfolgt durch Vorlage einer OSCAL Component-Definition
(JSON-Format, OSCAL 1.1.2), die mindestens enthält:

1. Implementierungsstatus für alle im Profil geforderten Controls
2. Reifegrad-Bewertung (mindestens Stufe 3)
3. Referenzen zu Evidenzen (Zertifikate, Audit-Reports, Dokumentation)

### Bewertung

| Kriterium | Gewichtung |
|-----------|------------|
| Control-Abdeckung (% der Profil-Controls) | 40% |
| Durchschnittlicher Reifegrad | 30% |
| Qualität der Evidenzen | 30% |

### Referenz

Das Profil ist verfügbar unter:
https://github.com/open-gov-group/opengov-privacy-oscal/profiles/buergerportal-standard.json
```

### 7.3 Vorteile für Beteiligte

| Rolle | Vorteil |
|-------|---------|
| **Auftraggeber** | Standardisierte, vergleichbare Anforderungen |
| **Anbieter** | Klare Erwartungen, wiederverwendbare Nachweise |
| **Prüfer** | Automatisierbare Validierung |
| **DPO** | Nachvollziehbare Compliance |

---

## 8. Beispiele

### 8.1 Vollständiges Beispiel: Web-Portal

```
┌─────────────────────────────────────────────────────────────────────────────┐
│           BEISPIEL: BÜRGERPORTAL VOLLSTÄNDIGE DOKUMENTATION                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   KATALOGE (Basis)                                                          │
│   ════════════════                                                          │
│   oscal-privacy-catalog ──┐                                                 │
│   sdm-privacy-catalog ────┼─────────────────────────────────────────┐       │
│                           │                                         │       │
│                           ▼                                         │       │
│   COMPONENTS (Bausteine)                                            │       │
│   ══════════════════════                                            │       │
│   ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐    │       │
│   │ Web-Portal      │  │ Auth-Service    │  │ Cloud-Hosting   │    │       │
│   │ Standard        │  │ (Keycloak)      │  │ (BSI-C5)        │    │       │
│   │                 │  │                 │  │                 │    │       │
│   │ • SDM-TOM-AC-01 │  │ • SDM-TOM-AC-01 │  │ • SDM-TOM-INF-01│    │       │
│   │ • SDM-TOM-LG-01 │  │ • SDM-TOM-AC-02 │  │ • SDM-TOM-BK-01 │    │       │
│   │ • SDM-TOM-CR-01 │  │ • SDM-TOM-LG-01 │  │ • SDM-TOM-INF-02│    │       │
│   │                 │  │                 │  │                 │    │       │
│   │ Reifegrad: 3    │  │ Reifegrad: 4    │  │ Reifegrad: 4    │    │       │
│   └────────┬────────┘  └────────┬────────┘  └────────┬────────┘    │       │
│            │                    │                    │              │       │
│            └────────────────────┼────────────────────┘              │       │
│                                 │                                   │       │
│                                 ▼                                   │       │
│   PROFILE (Zusammenstellung)                                        │       │
│   ══════════════════════════                                        │       │
│   ┌─────────────────────────────────────────────────────────────┐  │       │
│   │ Profile: "Bürgerportal Standard"                            │  │       │
│   │                                                             │◄─┘       │
│   │ Imports: oscal-privacy-catalog, sdm-privacy-catalog         │          │
│   │ Components: Web-Portal + Auth-Service + Cloud-Hosting       │          │
│   │                                                             │          │
│   │ Tailoring:                                                  │          │
│   │ • SDM-TOM-AC-01 → enhanced (wegen Bürgerdaten)              │          │
│   │ • SDM-TOM-PHY-* → excluded (Cloud-Provider)                 │          │
│   │                                                             │          │
│   │ Resultierender Control-Count: 45                            │          │
│   │ Durchschnittlicher Reifegrad: 3.5                           │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                 │                                           │
│                                 ▼                                           │
│   SSP (Konkrete Umsetzung)                                                  │
│   ════════════════════════                                                  │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ SSP: "Bürgerportal Musterstadt"                                     │   │
│   │                                                                     │   │
│   │ Basiert auf: Profile "Bürgerportal Standard"                        │   │
│   │                                                                     │   │
│   │ Verantwortlich: IT-Abteilung Musterstadt                            │   │
│   │ System-Owner: Bürgermeisteramt                                      │   │
│   │                                                                     │   │
│   │ Evidenzen:                                                          │   │
│   │ • Keycloak-Konfiguration (Screenshot)                               │   │
│   │ • Cloud-Vertrag mit BSI-C5-Testat                                   │   │
│   │ • Penetrationstest-Bericht (extern)                                 │   │
│   │ • Datenschutz-Schulungsnachweis                                     │   │
│   │                                                                     │   │
│   │ Control-Status:                                                     │   │
│   │ • 42/45 implemented                                                 │   │
│   │ • 2/45 partially implemented                                        │   │
│   │ • 1/45 planned                                                      │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                 │                                           │
│                                 ▼                                           │
│   RoPA (Verarbeitungsverzeichnis)                                           │
│   ═══════════════════════════════                                           │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ Verarbeitung: "Online-Bürgeranträge"                                │   │
│   │                                                                     │   │
│   │ Zweck: Entgegennahme und Bearbeitung von Bürgeranträgen             │   │
│   │ Rechtsgrundlage: Art. 6 Abs. 1 lit. e DSGVO                         │   │
│   │ Datenkategorien: Name, Adresse, Antragsdaten                        │   │
│   │ Speicherdauer: 10 Jahre (Aufbewahrungspflicht)                      │   │
│   │                                                                     │   │
│   │ Technische Umsetzung: → SSP "Bürgerportal Musterstadt"              │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 9. Nächste Schritte

### 9.1 Kurzfristig (Q1 2026)

- [x] Katalog-Struktur finalisiert (GOV, ACC, LAW, TOM)
- [x] Control-Parts-Struktur implementiert (maturity-hints, typical-measures, etc.)
- [x] Risk-guidance mit Impact-Szenarien implementiert
- [ ] Abstimmung mit Stakeholdern
- [ ] Citizen-Titles für alle Controls ergänzen
- [ ] Validierung gegen OSCAL 1.1.2 Schema

### 9.2 Mittelfristig (Q2 2026)

- [ ] Vollständiger Katalog (~75 Controls in allen Gruppen)
- [ ] Framework-Mappings (ISO 27001, BSI IT-Grundschutz)
- [ ] 3 Standard-Profile erstellen
- [ ] Viewer für Katalog-Darstellung erweitern

### 9.3 Langfristig (Q3+ 2026)

- [ ] Separater SDM-Maßnahmen-Katalog (optional)
- [ ] Vergabeverfahren-Textbausteine
- [ ] Automatische Validierung
- [ ] Integration mit Beschaffungsportalen

---

## 10. Referenzen

### Externe Referenzen

- [NIST OSCAL Specification](https://pages.nist.gov/OSCAL/)
- [Standard-Datenschutzmodell (SDM)](https://www.datenschutzzentrum.de/sdm/)
- [DSGVO / DS-GVO](https://dsgvo-gesetz.de/)

### Projekt-Referenzen

- [VISION_AND_CONCEPT.md](VISION_AND_CONCEPT.md)
- [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md)
- [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) – Integration: Privacy → SDM → Resilience → Standards
- [MVP_ROPA_ARCHITECTURE.md](MVP_ROPA_ARCHITECTURE.md) – RoPa MVP (Privacy App, Gateway, Mappings)
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – **NEU:** Privacy ↔ BSI Grundschutz++ Mapping-Methodik
- [CORE_TEAM_LIBRARIES.md](CORE_TEAM_LIBRARIES.md) – Python Core Libraries (pyprivacy, pylegal-utils)
- [Open Privacy Catalog (JSON)](https://github.com/open-gov-group/opengov-privacy-oscal/blob/main/oscal/catalog/open_privacy_catalog_risk.json) – Implementierter Katalog
- [opengov_privacy_to_bsi_grundschutz.json](../../oscal/mappings/opengov_privacy_to_bsi_grundschutz.json) – **NEU:** OSCAL Mapping-Datei Privacy ↔ BSI
- [opengov-privacy-mappings](https://github.com/open-gov-group/opengov-privacy-mappings) – Framework-Mappings
- [open-oscal-workbench](https://github.com/open-gov-group/open-oscal-workbench) – Workbench-Implementierung

---

## 11. Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-04 | Initiales Konzept-Dokument |
| 1.1.0 | 2026-02-04 | Aktualisierung basierend auf implementiertem Katalog (open_privacy_catalog_risk.json) |
| 1.2.0 | 2026-02-05 | Vollständige 10-Gruppen-Struktur dokumentiert |
| 1.2.1 | 2026-02-05 | BSI Grundschutz++ Mapping-Dokumentation referenziert |

**Wichtigste Änderungen in 1.2.1:**
- Referenzen zu BSI Grundschutz++ Mapping-Dokumentation hinzugefügt
- MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md – Architektur-Dokumentation für Mapping-Methodik
- opengov_privacy_to_bsi_grundschutz.json – OSCAL-konforme Mapping-Datei
- CORE_TEAM_LIBRARIES.md – Python Core Libraries referenziert

**Wichtigste Änderungen in 1.2.0:**
- Vollständige Katalog-Struktur mit allen 10 Gruppen dokumentiert
- Neue Gruppen hinzugefügt: DSR (Betroffenenrechte), REG (Verarbeitungsverzeichnis), DPIA (Folgenabschätzung), OPS (Betriebsprozesse), XFER (Datenübermittlung), INC (Vorfälle)
- Domänen-Kategorisierung: Governance & Compliance, Rechtliche Anforderungen, Operative Umsetzung
- Resilienz-Schnittstellen identifiziert (TOM, OPS, INC, REG)
- Erweiterte Control-Klassen-Taxonomie

**Wichtigste Änderungen in 1.1.0:**
- Gruppen-Struktur: GOV, ACC, LAW, TOM anstelle der konzeptionellen DSGVO-Kapitel
- Property-Taxonomie: `legal` mit class/ns/group/remarks, `assurance_goal`
- Control-Parts: statement, maturity-hints (1/3/5), typical-measures, assessment-questions, risk-guidance, risk-hint
- Risk-Impact-Szenarien: normal, moderate, high aus Perspektive der Betroffenen
- Vollständiges TOM-02 Beispiel

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Status**: Aktualisiert – Vollständige 10-Gruppen-Struktur
