# OSCAL Privacy Kataloge - Konzept und Spezifikation

**Version**: 1.0.0
**Stand**: 2026-02-04
**Status**: Konzept zur Abstimmung

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [oscal-privacy-catalog (DS Kompendium)](#2-oscal-privacy-catalog-ds-kompendium)
3. [sdm-privacy-catalog (Maßnahmen-Katalog)](#3-sdm-privacy-catalog-maßnahmen-katalog)
4. [Component-Definition](#4-component-definition)
5. [Profile-Definition](#5-profile-definition)
6. [Reifegrad- und Risiko-Integration](#6-reifegrad--und-risiko-integration)
7. [Vergabeverfahren-Nutzung](#7-vergabeverfahren-nutzung)
8. [Beispiele](#8-beispiele)

---

## 1. Übersicht

### 1.1 Die zwei Katalog-Typen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         KATALOG-ARCHITEKTUR                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     oscal-privacy-catalog                           │   │
│   │                     (Datenschutz-Kompendium)                        │   │
│   │                                                                     │   │
│   │   Fokus: WAS muss geschützt werden?                                 │   │
│   │                                                                     │   │
│   │   • Datenschutz-Anforderungen aus DSGVO                             │   │
│   │   • Risiko-Perspektive (Schutzniveau, Eintrittswahrscheinlichkeit)  │   │
│   │   • Reifegrad-Stufen                                                │   │
│   │   • Bürgerfreundliche Beschreibungen                                │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                     │                                       │
│                                     │ referenziert                          │
│                                     ▼                                       │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                      sdm-privacy-catalog                            │   │
│   │                      (Maßnahmen-Katalog)                            │   │
│   │                                                                     │   │
│   │   Fokus: WIE wird geschützt?                                        │   │
│   │                                                                     │   │
│   │   • Technische und organisatorische Maßnahmen (TOM)                 │   │
│   │   • SDM-Dreischicht (Prozess/Applikation/Infrastruktur)             │   │
│   │   • Gewährleistungsziele                                            │   │
│   │   • Mapping zu Resilienz-Frameworks (ISO, BSI, NIST)                │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
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

## 2. oscal-privacy-catalog (DS Kompendium)

### 2.1 Zweck

Der **oscal-privacy-catalog** definiert Datenschutz-Anforderungen aus der Perspektive des Schutzbedarfs. Er beantwortet: *"Was muss aus Datenschutzsicht beachtet werden?"*

### 2.2 Struktur

```yaml
catalog:
  uuid: "uuid-oscal-privacy-catalog"
  metadata:
    title: "OpenGov Privacy Catalog - Datenschutz-Kompendium"
    version: "1.0.0"
    oscal-version: "1.1.2"

  groups:
    - id: "dsgvo-grundsaetze"
      title: "DSGVO Grundsätze (Art. 5)"

    - id: "betroffenenrechte"
      title: "Betroffenenrechte (Art. 12-22)"

    - id: "verantwortlicher"
      title: "Pflichten des Verantwortlichen (Art. 24-31)"

    - id: "auftragsverarbeitung"
      title: "Auftragsverarbeitung (Art. 28)"

    - id: "sicherheit"
      title: "Sicherheit der Verarbeitung (Art. 32)"

    - id: "datenschutzfolgen"
      title: "Datenschutz-Folgenabschätzung (Art. 35)"
```

### 2.3 Control-Eigenschaften (Props)

Jedes Control im oscal-privacy-catalog enthält folgende Properties:

| Property | Typ | Beschreibung | Werte |
|----------|-----|--------------|-------|
| `gdpr-article` | string | DSGVO-Artikel-Referenz | z.B. "Art. 5 Abs. 1 lit. a" |
| `dp-risk-impact` | integer | Schutzniveau/Auswirkung bei Verletzung | 1-5 |
| `dp-likelihood` | integer | Eintrittswahrscheinlichkeit | 1-5 |
| `implementation-level` | enum | Erforderliches Umsetzungsniveau | baseline, standard, enhanced |
| `maturity-level` | integer | Empfohlener Reifegrad | 1-5 |
| `citizen-title-de` | string | Bürgerfreundlicher Titel (DE) | Freitext |
| `citizen-title-en` | string | Bürgerfreundlicher Titel (EN) | Freitext |
| `citizen-description-de` | string | Bürgerfreundliche Beschreibung (DE) | Freitext |

### 2.4 Beispiel-Control

```json
{
  "id": "PRIV-TRANS-01",
  "class": "privacy-requirement",
  "title": "Transparenz der Datenverarbeitung",
  "props": [
    { "name": "gdpr-article", "value": "Art. 5 Abs. 1 lit. a" },
    { "name": "dp-risk-impact", "value": "4" },
    { "name": "dp-likelihood", "value": "3" },
    { "name": "implementation-level", "value": "standard" },
    { "name": "maturity-level", "value": "3" },
    { "name": "citizen-title-de", "value": "Verständliche Information" },
    { "name": "citizen-title-en", "value": "Understandable Information" },
    { "name": "citizen-description-de", "value": "Sie haben das Recht zu erfahren, wie Ihre Daten verarbeitet werden - in einer Sprache, die Sie verstehen." }
  ],
  "parts": [
    {
      "id": "PRIV-TRANS-01_stmt",
      "name": "statement",
      "prose": "Die Organisation stellt sicher, dass betroffene Personen in klarer, verständlicher Sprache über die Verarbeitung ihrer personenbezogenen Daten informiert werden."
    },
    {
      "id": "PRIV-TRANS-01_guide",
      "name": "guidance",
      "prose": "Die Information muss zum Zeitpunkt der Erhebung erfolgen (Art. 13) oder unverzüglich bei Dritterhebung (Art. 14)."
    }
  ],
  "links": [
    { "rel": "implements", "href": "#SDM-TOM-TR-01" }
  ]
}
```

### 2.5 Gruppierung nach DSGVO-Kapiteln

| Gruppe | DSGVO-Artikel | Anzahl Controls (geplant) |
|--------|---------------|---------------------------|
| Grundsätze | Art. 5 | ~10 |
| Rechtmäßigkeit | Art. 6-11 | ~15 |
| Betroffenenrechte | Art. 12-22 | ~20 |
| Verantwortlicher | Art. 24-31 | ~15 |
| Sicherheit | Art. 32-34 | ~10 |
| DSFA | Art. 35-36 | ~5 |
| **Gesamt** | | **~75 Controls** |

---

## 3. sdm-privacy-catalog (Maßnahmen-Katalog)

### 3.1 Zweck

Der **sdm-privacy-catalog** definiert konkrete technische und organisatorische Maßnahmen (TOM) zur Umsetzung der Datenschutz-Anforderungen. Er beantwortet: *"Wie setze ich Datenschutz um?"*

### 3.2 Struktur nach SDM-Gewährleistungszielen

```yaml
catalog:
  uuid: "uuid-sdm-privacy-catalog"
  metadata:
    title: "SDM Privacy Catalog - Maßnahmen-Katalog"
    version: "1.0.0"
    oscal-version: "1.1.2"

  groups:
    - id: "gz-verfuegbarkeit"
      title: "Verfügbarkeit"

    - id: "gz-integritaet"
      title: "Integrität"

    - id: "gz-vertraulichkeit"
      title: "Vertraulichkeit"

    - id: "gz-transparenz"
      title: "Transparenz"

    - id: "gz-intervenierbarkeit"
      title: "Intervenierbarkeit"

    - id: "gz-nichtverkettung"
      title: "Nichtverkettung"

    - id: "gz-datenminimierung"
      title: "Datenminimierung"
```

### 3.3 Control-Eigenschaften (Props)

| Property | Typ | Beschreibung | Werte |
|----------|-----|--------------|-------|
| `sdm-layer` | enum | SDM-Schicht | process, application, infrastructure |
| `sdm-goal` | enum | Gewährleistungsziel | availability, integrity, confidentiality, transparency, intervenability, unlinkability, data-minimization |
| `implementation-level` | enum | Umsetzungsniveau | baseline, standard, enhanced |
| `resilience-mapping-iso27001` | string | ISO 27001:2022 Control | z.B. "A.8.2.1" |
| `resilience-mapping-bsi` | string | BSI IT-Grundschutz | z.B. "ORP.4.A1" |
| `resilience-mapping-nist` | string | NIST CSF | z.B. "PR.AC-1" |
| `audit-frequency` | enum | Empfohlene Prüffrequenz | continuous, monthly, quarterly, annual |

### 3.4 Beispiel-Control

```json
{
  "id": "SDM-TOM-AC-01",
  "class": "technical-measure",
  "title": "Rollenbasierte Zugriffskontrolle (RBAC)",
  "props": [
    { "name": "sdm-layer", "value": "application" },
    { "name": "sdm-goal", "value": "confidentiality" },
    { "name": "implementation-level", "value": "standard" },
    { "name": "resilience-mapping-iso27001", "value": "A.9.2.1" },
    { "name": "resilience-mapping-bsi", "value": "ORP.4.A1" },
    { "name": "resilience-mapping-nist", "value": "PR.AC-1" },
    { "name": "audit-frequency", "value": "quarterly" }
  ],
  "parts": [
    {
      "id": "SDM-TOM-AC-01_stmt",
      "name": "statement",
      "prose": "Die Organisation implementiert eine rollenbasierte Zugriffskontrolle, die sicherstellt, dass Benutzer nur auf die für ihre Rolle erforderlichen Daten zugreifen können."
    },
    {
      "id": "SDM-TOM-AC-01_impl-baseline",
      "name": "implementation",
      "class": "baseline",
      "prose": "Mindestens: Definierte Rollen, dokumentierte Berechtigungen, regelmäßige Review (jährlich)."
    },
    {
      "id": "SDM-TOM-AC-01_impl-standard",
      "name": "implementation",
      "class": "standard",
      "prose": "Zusätzlich: Automatisierte Provisionierung, quartalsweise Review, Logging aller Zugriffe."
    },
    {
      "id": "SDM-TOM-AC-01_impl-enhanced",
      "name": "implementation",
      "class": "enhanced",
      "prose": "Zusätzlich: Just-in-time Access, Anomalie-Erkennung, kontinuierliches Monitoring."
    }
  ],
  "links": [
    { "rel": "related", "href": "#PRIV-CONF-01" }
  ]
}
```

### 3.5 Dreischicht-Betrachtung

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      SDM DREISCHICHT-MODELL                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   PROZESS-SCHICHT (process)                                                 │
│   ══════════════════════════                                                │
│   Organisatorische Maßnahmen, Richtlinien, Verantwortlichkeiten             │
│                                                                             │
│   Beispiele:                                                                │
│   • SDM-TOM-ORG-01: Datenschutzrichtlinie                                   │
│   • SDM-TOM-ORG-02: Schulungskonzept                                        │
│   • SDM-TOM-ORG-03: Incident-Response-Prozess                               │
│   • SDM-TOM-ORG-04: Löschkonzept                                            │
│                                                                             │
│   Verantwortlich: DPO, Management, Fachbereich                              │
│   ─────────────────────────────────────────────────────────────────────     │
│                                                                             │
│   APPLIKATIONS-SCHICHT (application)                                        │
│   ═══════════════════════════════════                                       │
│   Software-seitige Maßnahmen, Konfigurationen, Features                     │
│                                                                             │
│   Beispiele:                                                                │
│   • SDM-TOM-AC-01: Zugriffskontrolle (RBAC)                                 │
│   • SDM-TOM-LG-01: Protokollierung                                          │
│   • SDM-TOM-CR-01: Verschlüsselung                                          │
│   • SDM-TOM-AN-01: Anonymisierung                                           │
│                                                                             │
│   Verantwortlich: Entwicklung, IT-Betrieb                                   │
│   ─────────────────────────────────────────────────────────────────────     │
│                                                                             │
│   INFRASTRUKTUR-SCHICHT (infrastructure)                                    │
│   ═══════════════════════════════════════                                   │
│   Technische Basis, Hardware, Netzwerk, Cloud                               │
│                                                                             │
│   Beispiele:                                                                │
│   • SDM-TOM-INF-01: Firewall-Konfiguration                                  │
│   • SDM-TOM-INF-02: Backup-Strategie                                        │
│   • SDM-TOM-INF-03: Netzwerksegmentierung                                   │
│   • SDM-TOM-INF-04: Physische Sicherheit                                    │
│                                                                             │
│   Verantwortlich: IT-Betrieb, Rechenzentrum, Cloud-Provider                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.6 Mapping zu Resilienz-Frameworks

| SDM Control | ISO 27001:2022 | BSI IT-Grundschutz | NIST CSF |
|-------------|----------------|--------------------|---------|
| SDM-TOM-AC-01 | A.9.2.1 | ORP.4.A1 | PR.AC-1 |
| SDM-TOM-LG-01 | A.12.4.1 | OPS.1.1.5.A1 | DE.CM-1 |
| SDM-TOM-CR-01 | A.10.1.1 | CON.1.A1 | PR.DS-1 |
| SDM-TOM-BK-01 | A.12.3.1 | OPS.1.1.6.A1 | PR.IP-4 |
| ... | ... | ... | ... |

**Mapping-Typen:**
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

## 6. Reifegrad- und Risiko-Integration

### 6.1 Risiko-Berechnung

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      RISIKO-MATRIX                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   RISIKO = dp-risk-impact × dp-likelihood                                   │
│                                                                             │
│                        dp-likelihood (Eintrittswahrscheinlichkeit)          │
│                        1        2        3        4        5                │
│                     (sehr    (unwahr-  (möglich) (wahr-   (sehr             │
│                     unwahr-  schein-            schein-  wahr-             │
│   dp-risk-impact    schein-  lich)              lich)    schein-           │
│   (Schutzniveau)    lich)                                lich)             │
│   ─────────────────────────────────────────────────────────────            │
│   5 (sehr hoch)  │   5    │   10   │   15   │   20   │   25   │            │
│   4 (hoch)       │   4    │    8   │   12   │   16   │   20   │            │
│   3 (mittel)     │   3    │    6   │    9   │   12   │   15   │            │
│   2 (niedrig)    │   2    │    4   │    6   │    8   │   10   │            │
│   1 (sehr niedr.)│   1    │    2   │    3   │    4   │    5   │            │
│                                                                             │
│   ─────────────────────────────────────────────────────────────            │
│   Risiko-Score    →    Implementation-Level                                 │
│   ─────────────────────────────────────────────────────────────            │
│   1-6   (grün)    →    baseline                                             │
│   7-12  (gelb)    →    standard                                             │
│   13-25 (rot)     →    enhanced                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Reifegrad-Modell (CNIL-orientiert)

| Stufe | Name | Beschreibung | Nachweise |
|-------|------|--------------|-----------|
| **1** | Initial | Control bekannt, nicht umgesetzt | Awareness |
| **2** | Managed | Teilweise umgesetzt, ad-hoc | Erste Maßnahmen |
| **3** | Defined | Vollständig umgesetzt, dokumentiert | Dokumentation, Richtlinien |
| **4** | Measured | Umgesetzt, gemessen, bewertet | KPIs, Metriken, Reviews |
| **5** | Optimized | Kontinuierlich verbessert, auditiert | Audit-Berichte, Zertifikate |

### 6.3 Reifegrad in OSCAL-Properties

```json
{
  "props": [
    { "name": "maturity-level-current", "value": "3" },
    { "name": "maturity-level-target", "value": "4" },
    { "name": "maturity-assessment-date", "value": "2026-01-15" },
    { "name": "maturity-evidence", "value": "Dokumentation vorhanden, jährliche Reviews" }
  ]
}
```

### 6.4 Kombinierte Bewertung

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CONTROL-BEWERTUNG                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Control: SDM-TOM-AC-01 (Zugriffskontrolle)                                │
│                                                                             │
│   RISIKO-DIMENSION                    REIFEGRAD-DIMENSION                   │
│   ══════════════════                  ═══════════════════                   │
│                                                                             │
│   dp-risk-impact: 4                   maturity-current: 3                   │
│   dp-likelihood: 3                    maturity-target: 4                    │
│   ─────────────────                   ───────────────────                   │
│   Risiko-Score: 12                    Gap: 1 Stufe                          │
│   → implementation-level: standard    → Maßnahmen definieren                │
│                                                                             │
│   ERGEBNIS                                                                  │
│   ════════                                                                  │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │ Status: TEILWEISE KONFORM                                           │   │
│   │                                                                     │   │
│   │ • Risiko erfordert: standard                     ✓                  │   │
│   │ • Aktueller Reifegrad: 3 (Defined)              ✓                  │   │
│   │ • Ziel-Reifegrad: 4 (Measured)                  → Action needed    │   │
│   │                                                                     │   │
│   │ Empfehlung: KPIs definieren, quartalsweise Messung einführen        │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
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

- [ ] Finalisierung der Katalog-Struktur (dieses Dokument)
- [ ] Abstimmung mit Stakeholdern
- [ ] Erste 20 Controls im oscal-privacy-catalog
- [ ] Erste 20 Maßnahmen im sdm-privacy-catalog

### 9.2 Mittelfristig (Q2 2026)

- [ ] Vollständiger oscal-privacy-catalog (~75 Controls)
- [ ] Vollständiger sdm-privacy-catalog (~60 Maßnahmen)
- [ ] 3 Standard-Profile erstellen
- [ ] Viewer erweitern für Component/Profile-Ansicht

### 9.3 Langfristig (Q3+ 2026)

- [ ] Vergabeverfahren-Textbausteine
- [ ] Automatische Validierung
- [ ] Integration mit Beschaffungsportalen

---

## 10. Referenzen

- [NIST OSCAL Specification](https://pages.nist.gov/OSCAL/)
- [Standard-Datenschutzmodell (SDM)](https://www.datenschutzzentrum.de/sdm/)
- [VISION_AND_CONCEPT.md](VISION_AND_CONCEPT.md)
- [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md)

---

**Letzte Aktualisierung**: 2026-02-04
**Verantwortlich**: Architecture Team
**Status**: Zur Abstimmung mit Stakeholdern
