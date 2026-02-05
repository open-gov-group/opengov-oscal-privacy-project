# Mapping: OpenGov Privacy Catalog ↔ BSI Grundschutz++ Methodik

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Initial Draft
**Verantwortlich**: Architecture Team

---

## Inhaltsverzeichnis

1. [Übersicht](#1-übersicht)
2. [Mapping-Methodik](#2-mapping-methodik)
3. [Gruppen-Mapping](#3-gruppen-mapping)
4. [Control-zu-Control Mapping](#4-control-zu-control-mapping)
5. [Bidirektionale Mapping-Tabelle](#5-bidirektionale-mapping-tabelle)
6. [OSCAL-Mapping-Datei](#6-oscal-mapping-datei)
7. [Implementierungshinweise](#7-implementierungshinweise)
8. [Gap-Analyse](#8-gap-analyse)
9. [Referenzen](#9-referenzen)

---

## 1. Übersicht

Dieses Dokument definiert das Mapping zwischen dem **OpenGov Privacy Catalog** und der **BSI Grundschutz++ Methodik**. Beide Kataloge nutzen OSCAL 1.1.2 als gemeinsames Datenformat, verfolgen jedoch unterschiedliche Perspektiven.

### 1.1 Perspektiven-Unterschied

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PERSPEKTIVEN-VERGLEICH                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OpenGov Privacy Catalog              BSI Grundschutz++ Methodik           │
│   ═══════════════════════              ══════════════════════════           │
│                                                                             │
│   ┌─────────────────────────┐         ┌─────────────────────────┐          │
│   │     BETROFFENE          │         │     ORGANISATION        │          │
│   │     PERSON              │         │     (ISMS)              │          │
│   │                         │         │                         │          │
│   │  "Was kann MIR          │         │  "Was MUSS die          │          │
│   │   passieren?"           │         │   Institution tun?"     │          │
│   └─────────────────────────┘         └─────────────────────────┘          │
│                                                                             │
│   Regulatorischer Rahmen:              Regulatorischer Rahmen:              │
│   • DSGVO (primär)                     • BSI-Gesetz                         │
│   • SDM (Gewährleistungsziele)         • ISO 27001                          │
│   • nationale DS-Gesetze               • KRITIS-Verordnung                  │
│                                                                             │
│   Risiko-Modell:                       Risiko-Modell:                       │
│   • Impact auf Betroffene              • Schutzbedarf der Institution       │
│   • normal / moderate / high           • normal / hoch / sehr hoch          │
│   • DSFA-Trigger                       • Sicherheitsniveau (SdT)            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Katalog-Übersicht

| Aspekt | OpenGov Privacy Catalog | BSI Grundschutz++ |
|--------|------------------------|-------------------|
| **Gruppen** | 10 (GOV, ACC, LAW, DSR, REG, TOM, DPIA, OPS, XFER, INC) | 7 (GC.1 - GC.7) |
| **Hierarchie** | Flach (Gruppe → Controls) | Verschachtelt (Gruppe → Untergruppe → Control → Sub-Control) |
| **OSCAL-Version** | 1.1.2 | 1.1.2 |
| **Namespace** | `https://open-gov-group.org/oscal/privacy` | `https://bsi.bund.de/grundschutz-plus-plus` |

---

## 2. Mapping-Methodik

### 2.1 Mapping-Typen

| Typ | Beschreibung | Symbol |
|-----|--------------|--------|
| **equivalent** | 1:1 Entsprechung, gleiche Anforderung | ≡ |
| **related** | Thematisch verwandt, ähnliche Zielsetzung | ≈ |
| **partial** | Teilweise Abdeckung, Schnittmenge vorhanden | ∩ |
| **extends** | Erweitert/ergänzt das andere Control | ⊃ |
| **none** | Keine direkte Entsprechung | ∅ |

### 2.2 Mapping-Richtung

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BIDIREKTIONALES MAPPING                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OpenGov Privacy                         BSI Grundschutz++                 │
│                                                                             │
│   ┌─────────┐                             ┌─────────┐                       │
│   │  GOV-01 │ ────── related ──────────► │ GC.4.1  │                       │
│   │         │ ◄───── related ──────────  │         │                       │
│   └─────────┘                             └─────────┘                       │
│                                                                             │
│   ┌─────────┐                             ┌─────────┐                       │
│   │  ACC-01 │ ────── partial ──────────► │ GC.1.1  │                       │
│   │         │ ◄───── extends ──────────  │         │                       │
│   └─────────┘                             └─────────┘                       │
│                                                                             │
│   Hinweis: Die Mapping-Typen können in beide Richtungen unterschiedlich    │
│   sein, da die Abdeckungsgrade asymmetrisch sein können.                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.3 Confidence-Level

| Level | Beschreibung | Verwendung |
|-------|--------------|------------|
| **high** | Mapping durch Experten validiert | Produktiv-Einsatz |
| **medium** | Plausibles Mapping, Review ausstehend | Beta-Phase |
| **low** | Automatisch generiert oder unsicher | Manueller Review erforderlich |

---

## 3. Gruppen-Mapping

### 3.1 Übersichts-Matrix

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    GRUPPEN-MAPPING MATRIX                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OpenGov Privacy    BSI Grundschutz++     Mapping   Confidence             │
│   ═══════════════    ════════════════      ═══════   ══════════             │
│                                                                             │
│   GOV (Governance)   GC.4 (Sicherheits-    related   high                   │
│                           organisation)                                     │
│                      GC.5 (Leitlinie)       partial   high                   │
│                                                                             │
│   ACC (Rechenschaft) GC.1 (Grundlagen)     related   high                   │
│                      GC.7 (Vorgehensweisen) partial   medium                 │
│                                                                             │
│   LAW (Rechtsgrund.) GC.2 (Kontext)        related   high                   │
│                      GC.2.2 (Verfahren)    partial   high                   │
│                                                                             │
│   DSR (Betroffenen-  [Kein Äquivalent]     none      -                      │
│        rechte)       → Privacy-spezifisch                                   │
│                                                                             │
│   REG (Verarbeit.-   GC.3 (Informations-   related   medium                 │
│        verzeichnis)       verbund)                                          │
│                                                                             │
│   TOM (Maßnahmen)    [Baustein-Kataloge]   extends   high                   │
│                      ORP, CON, OPS, etc.                                    │
│                                                                             │
│   DPIA (Folgen-      GC.7.4 (Risiko-       partial   medium                 │
│         abschätzung)      management)                                       │
│                                                                             │
│   OPS (Betriebs-     GC.7 (Vorgehensweisen) related   medium                 │
│        prozesse)                                                            │
│                                                                             │
│   XFER (Datenüber-   GC.3.2 (Schnittstellen) partial   medium                 │
│         mittlung)                                                           │
│                                                                             │
│   INC (Vorfälle)     [DER-Bausteine]       extends   high                   │
│                      Detektion & Reaktion                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Gruppen-Beschreibungen

#### 3.2.1 GOV ↔ GC.4, GC.5

| OpenGov Privacy: GOV | BSI Grundschutz++: GC.4 + GC.5 |
|---------------------|--------------------------------|
| Art. 24 (Verantwortlicher) | Sicherheitsorganisation |
| Art. 37-39 (DSB) | Rollen und Zuständigkeiten |
| Datenschutz-Organisation | Informationssicherheitsleitlinie |

**Mapping-Begründung**: Beide adressieren die organisatorische Verankerung von Compliance-Verantwortlichkeiten. GOV fokussiert auf den DSB und Datenschutz-Verantwortlichen, GC.4/GC.5 auf den ISB und die Sicherheitsorganisation.

#### 3.2.2 ACC ↔ GC.1, GC.7

| OpenGov Privacy: ACC | BSI Grundschutz++: GC.1 + GC.7 |
|---------------------|--------------------------------|
| Art. 5(2) (Rechenschaftspflicht) | ISMS etablieren |
| Art. 30 (Dokumentation) | Vorgehensweisen dokumentieren |
| DSMS-Anforderungen | Managementsystem-Methodik |

**Mapping-Begründung**: Rechenschaftspflicht (Accountability) entspricht der Nachweisführung im ISMS. Die DSGVO-Anforderungen ergänzen die ISMS-Anforderungen um datenschutzspezifische Aspekte.

#### 3.2.3 LAW ↔ GC.2

| OpenGov Privacy: LAW | BSI Grundschutz++: GC.2 |
|---------------------|-------------------------|
| Art. 5-11 (Rechtmäßigkeit) | Kontext der Organisation |
| Zweckbindung, Datenminimierung | Interessierte Parteien |
| Rechtsgrundlagen-Prüfung | Gesetzliche Verpflichtungen |

**Mapping-Begründung**: Beide analysieren den regulatorischen Kontext. LAW ist DSGVO-spezifisch, GC.2 umfasst alle rechtlichen Anforderungen inkl. Datenschutz.

#### 3.2.4 DSR (kein Äquivalent)

Die Gruppe **DSR (Betroffenenrechte)** hat keine direkte Entsprechung in der BSI Grundschutz++ Methodik. Dies ist ein **Privacy-spezifischer Gap**, der die Notwendigkeit des OpenGov Privacy Catalogs unterstreicht.

**Betroffenenrechte nach DSGVO (Art. 12-22)**:
- Informationspflichten (Art. 13, 14)
- Auskunftsrecht (Art. 15)
- Berichtigung (Art. 16)
- Löschung (Art. 17)
- Einschränkung (Art. 18)
- Datenübertragbarkeit (Art. 20)
- Widerspruch (Art. 21)
- Automatisierte Entscheidungen (Art. 22)

---

## 4. Control-zu-Control Mapping

### 4.1 Governance (GOV) → GC.4, GC.5

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **GOV-01** Datenschutz-Organisation | **GC.4.1** Rollen und Zuständigkeiten | related | high |
| **GOV-01** Datenschutz-Organisation | **GC.4.3** Sicherheitsorganisation | related | high |
| **GOV-02** Datenschutzbeauftragter | **GC.4.1** Rollen und Zuständigkeiten | partial | high |
| **GOV-02** Datenschutzbeauftragter | **GC.4.5** Stellvertreterregelungen | partial | medium |
| **GOV-03** Verantwortlichkeiten | **GC.4.1** Rollen und Zuständigkeiten | equivalent | high |
| **GOV-03** Verantwortlichkeiten | **GC.4.2** Interessenkonflikte vermeiden | related | medium |
| **GOV-04** Datenschutz-Strategie | **GC.5.1** Sicherheitsziele | related | high |
| **GOV-04** Datenschutz-Strategie | **GC.5.1.1** Sicherheitsstrategie | related | high |
| **GOV-05** Management-Verpflichtung | **GC.5.2** Verpflichtung der Leitung | equivalent | high |

### 4.2 Rechenschaft (ACC) → GC.1, GC.7

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **ACC-01** DSMS dokumentiert | **GC.1.1** ISMS etablieren | related | high |
| **ACC-01** DSMS dokumentiert | **GC.5.3** Leitlinie erstellen | partial | high |
| **ACC-02** Nachweisführung | **GC.7.1** Vorgehensweisen dokumentieren | related | high |
| **ACC-02** Nachweisführung | **GC.7.2** Freigabe von Vorgehensweisen | related | medium |
| **ACC-03** Dokumentenlenkung | **GC.7.1** Vorgehensweisen dokumentieren | partial | medium |
| **ACC-04** Schulungen & Awareness | **GC.4.4** Qualifikation sicherstellen | equivalent | high |
| **ACC-04** Schulungen & Awareness | **GC.6.1** Kommunikation festlegen | partial | medium |

### 4.3 Rechtsgrundlagen (LAW) → GC.2

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **LAW-01** Rechtsgrundlagen festlegen | **GC.2.2** Verfahren und Regelungen | related | high |
| **LAW-01** Rechtsgrundlagen festlegen | **GC.2.2.1** Gesetzliche Verpflichtungen | partial | high |
| **LAW-02** Zweckbindung | [kein Äquivalent] | none | - |
| **LAW-03** Datenminimierung | [kein Äquivalent] | none | - |
| **LAW-04** Richtigkeit | [kein Äquivalent] | none | - |
| **LAW-05** Speicherbegrenzung | [kein Äquivalent] | none | - |
| **LAW-06** Einwilligung | **GC.2.2.3** Vertragliche Verpflichtungen | partial | low |

### 4.4 Verarbeitungsverzeichnis (REG) → GC.3

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **REG-01** Verarbeitungsverzeichnis | **GC.3.1** Informationsverbund definieren | related | medium |
| **REG-02** Informationsflüsse | **GC.3.2** Schnittstellen festlegen | related | medium |
| **REG-03** Datenkategorien | **GC.7.7** Schutzbedarf identifizieren | partial | medium |

### 4.5 TOM → Baustein-Kataloge

| OpenGov Privacy Control | BSI Baustein | Mapping | Conf. |
|------------------------|--------------|---------|-------|
| **TOM-01** Pseudonymisierung/Verschlüsselung | CON.1 (Kryptokonzept) | related | high |
| **TOM-02** Zugriffs-/Berechtigungsmanagement | ORP.4 (Identitäts-/Berechtigungsmanagement) | equivalent | high |
| **TOM-03** Datenintegrität | OPS.1.1.3 (Patch-Management) | partial | medium |
| **TOM-04** Verfügbarkeit | CON.3 (Datensicherung) | related | high |
| **TOM-05** Belastbarkeit | OPS.1.1.4 (Schutz vor Schadprogrammen) | partial | medium |
| **TOM-06** Wiederherstellung | CON.3 (Datensicherung) | equivalent | high |
| **TOM-07** Überprüfungsverfahren | ORP.5 (Compliance Management) | related | medium |

### 4.6 DPIA → GC.7.4, GC.7.5, GC.7.6

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **DPIA-01** Schwellwertprüfung | **GC.7.6** Kritikalitätskriterien | related | medium |
| **DPIA-02** Risikoanalyse | **GC.7.4** Methodik Risikomanagement | related | high |
| **DPIA-03** Maßnahmenbewertung | **GC.7.4** Methodik Risikomanagement | partial | medium |
| **DPIA-04** Konsultation (Art. 36) | **GC.2.2.2** Anhörung zuständiger Stellen | related | medium |

### 4.7 Betriebsprozesse (OPS) → GC.7

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **OPS-01** Änderungsmanagement | **GC.7.1.1** Änderungen im ISMS | related | high |
| **OPS-02** Prozessdokumentation | **GC.7.1** Vorgehensweisen dokumentieren | equivalent | high |
| **OPS-03** Freigabeprozesse | **GC.7.2** Freigabe von Vorgehensweisen | equivalent | high |
| **OPS-04** Kennzahlen | **GC.7.3** Freigabe Managementbericht | related | medium |

### 4.8 Datenübermittlung (XFER) → GC.3.2

| OpenGov Privacy Control | BSI Grundschutz++ | Mapping | Conf. |
|------------------------|-------------------|---------|-------|
| **XFER-01** Drittland-Transfers | **GC.3.2** Schnittstellen festlegen | partial | low |
| **XFER-02** Standardvertragsklauseln | **GC.2.2.3** Vertragliche Verpflichtungen | partial | low |
| **XFER-03** Binding Corporate Rules | [kein Äquivalent] | none | - |
| **XFER-04** Auftragsverarbeitung | **GC.2.1** Interessierte Parteien | partial | medium |

### 4.9 Vorfälle (INC) → DER-Bausteine

| OpenGov Privacy Control | BSI Baustein | Mapping | Conf. |
|------------------------|--------------|---------|-------|
| **INC-01** Vorfallserkennung | DER.1 (Detektion) | related | high |
| **INC-02** Meldung an Aufsicht (Art. 33) | DER.2.1 (Behandlung) | extends | high |
| **INC-03** Benachrichtigung Betroffener (Art. 34) | [kein Äquivalent] | none | - |
| **INC-04** Dokumentation | DER.2.2 (Vorfallsbehandlung) | related | high |

---

## 5. Bidirektionale Mapping-Tabelle

### 5.1 OpenGov Privacy → BSI Grundschutz++

| OpenGov Group | BSI Grundschutz++ | Coverage |
|---------------|-------------------|----------|
| GOV | GC.4, GC.5 | 80% |
| ACC | GC.1, GC.7 | 70% |
| LAW | GC.2 | 40% |
| DSR | - | 0% (Gap) |
| REG | GC.3 | 50% |
| TOM | ORP, CON, OPS | 85% |
| DPIA | GC.7.4-7.6 | 60% |
| OPS | GC.7 | 75% |
| XFER | GC.3.2 | 30% |
| INC | DER | 70% |

### 5.2 BSI Grundschutz++ → OpenGov Privacy

| BSI Group | OpenGov Privacy | Coverage |
|-----------|-----------------|----------|
| GC.1 | ACC | 60% |
| GC.2 | LAW, GOV | 50% |
| GC.3 | REG, XFER | 45% |
| GC.4 | GOV | 75% |
| GC.5 | GOV, ACC | 70% |
| GC.6 | ACC, OPS | 40% |
| GC.7 | ACC, OPS, DPIA | 65% |

---

## 6. OSCAL-Mapping-Datei

### 6.1 Dateistruktur

Die folgende Struktur kann als `opengov_privacy_to_bsi_grundschutz.json` implementiert werden:

```json
{
  "mapping-collection": {
    "uuid": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "metadata": {
      "title": "OpenGov Privacy Catalog ↔ BSI Grundschutz++ Methodik Mapping",
      "version": "1.0.0",
      "oscal-version": "1.1.2",
      "last-modified": "2026-02-05T12:00:00Z",
      "published": "2026-02-05T12:00:00Z",
      "parties": [
        {
          "uuid": "party-opengov",
          "type": "organization",
          "name": "OpenGov Privacy Group"
        },
        {
          "uuid": "party-bsi",
          "type": "organization",
          "name": "BSI - Bundesamt für Sicherheit in der Informationstechnik"
        }
      ],
      "responsible-parties": [
        {
          "role-id": "creator",
          "party-uuids": ["party-opengov"]
        }
      ]
    },
    "source-catalog": {
      "href": "https://github.com/open-gov-group/opengov-privacy-oscal/blob/main/oscal/catalog/open_privacy_catalog_risk.json",
      "title": "OpenGov Privacy Catalog",
      "namespace": "https://open-gov-group.org/oscal/privacy"
    },
    "target-catalog": {
      "href": "https://github.com/BSI-Bund/Stand-der-Technik-Bibliothek/blob/main/Quellkataloge/Methodik-Grundschutz%2B%2B/BSI-Methodik-Grundschutz%2B%2B-catalog.json",
      "title": "BSI Methodik Grundschutz++",
      "namespace": "https://bsi.bund.de/grundschutz-plus-plus"
    },
    "mappings": [
      {
        "uuid": "map-gov01-gc41",
        "source-control-id": "GOV-01",
        "target-control-id": "GC.4.1",
        "relationship": "related",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "Beide Controls adressieren die organisatorische Verankerung von Verantwortlichkeiten. GOV-01 fokussiert auf Datenschutz-Organisation, GC.4.1 auf allgemeine Sicherheitsrollen."
          },
          {
            "name": "coverage-source-to-target",
            "value": "80"
          },
          {
            "name": "coverage-target-to-source",
            "value": "60"
          }
        ],
        "remarks": "GC.4.1 MUSS umgesetzt werden; GOV-01 ergänzt um DSB-spezifische Anforderungen (Art. 37-39 DSGVO)"
      },
      {
        "uuid": "map-gov05-gc52",
        "source-control-id": "GOV-05",
        "target-control-id": "GC.5.2",
        "relationship": "equivalent",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "Beide fordern explizit die Verpflichtung der obersten Leitung. GC.5.2 verwendet MUSS-Modalverb."
          }
        ],
        "remarks": "Direkte Entsprechung: Management Commitment"
      },
      {
        "uuid": "map-acc04-gc44",
        "source-control-id": "ACC-04",
        "target-control-id": "GC.4.4",
        "relationship": "equivalent",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "GC.4.4 fordert Sicherstellung der Qualifikation (MUSS), ACC-04 fordert Schulungen und Awareness für Datenschutz."
          }
        ]
      },
      {
        "uuid": "map-tom02-orp4",
        "source-control-id": "TOM-02",
        "target-control-id": "ORP.4",
        "relationship": "equivalent",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "Beide Controls behandeln Zugriffs- und Berechtigungsmanagement. TOM-02 betont die Datenschutz-Perspektive (Vertraulichkeit personenbezogener Daten), ORP.4 die IT-Sicherheitsperspektive."
          },
          {
            "name": "bsi-baustein",
            "value": "ORP.4"
          }
        ],
        "links": [
          {
            "href": "#SDM-TOM-AC-01",
            "rel": "related-control",
            "text": "Siehe auch SDM-Maßnahme für technische Umsetzung"
          }
        ]
      },
      {
        "uuid": "map-dpia02-gc74",
        "source-control-id": "DPIA-02",
        "target-control-id": "GC.7.4",
        "relationship": "related",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "GC.7.4 definiert die Methodik für Risikomanagement (MUSS). DPIA-02 wendet diese Methodik auf Datenschutz-Folgenabschätzungen an mit Fokus auf Rechte und Freiheiten der Betroffenen."
          }
        ],
        "remarks": "GC.7.4 ist methodisch breiter, DPIA-02 ist spezifisch für Art. 35 DSGVO"
      },
      {
        "uuid": "map-inc02-der21",
        "source-control-id": "INC-02",
        "target-control-id": "DER.2.1",
        "relationship": "extends",
        "confidence": "high",
        "props": [
          {
            "name": "mapping-rationale",
            "value": "INC-02 erweitert DER.2.1 um die DSGVO-spezifische 72-Stunden-Meldefrist an die Aufsichtsbehörde (Art. 33)."
          },
          {
            "name": "dsgvo-article",
            "value": "Art. 33"
          }
        ]
      }
    ],
    "gaps": [
      {
        "uuid": "gap-dsr",
        "gap-type": "source-only",
        "source-group-id": "DSR",
        "description": "Die gesamte Gruppe DSR (Betroffenenrechte) hat keine Entsprechung in BSI Grundschutz++. Dies umfasst Art. 12-22 DSGVO.",
        "recommendation": "Bei BSI-Grundschutz-Anwendung zusätzlich OpenGov Privacy Catalog für DSR-Anforderungen heranziehen."
      },
      {
        "uuid": "gap-inc03",
        "gap-type": "source-only",
        "source-control-id": "INC-03",
        "description": "Benachrichtigung Betroffener (Art. 34 DSGVO) hat keine Entsprechung im BSI-Katalog.",
        "recommendation": "Ergänzende Implementierung aus OpenGov Privacy Catalog erforderlich."
      },
      {
        "uuid": "gap-xfer-bcr",
        "gap-type": "source-only",
        "source-control-id": "XFER-03",
        "description": "Binding Corporate Rules für internationale Transfers (Art. 47 DSGVO) nicht in BSI abgedeckt.",
        "recommendation": "DSGVO-spezifische Compliance zusätzlich sicherstellen."
      }
    ]
  }
}
```

### 6.2 Verwendung in Profiles

Das Mapping kann in OSCAL-Profiles referenziert werden:

```json
{
  "profile": {
    "uuid": "profile-combined-privacy-security",
    "metadata": {
      "title": "Kombiniertes Privacy + Security Profil"
    },
    "imports": [
      {
        "href": "open_privacy_catalog_risk.json",
        "include-controls": [
          { "with-ids": ["GOV-*", "TOM-*", "INC-*"] }
        ]
      },
      {
        "href": "BSI-Methodik-Grundschutz++-catalog.json",
        "include-controls": [
          { "with-ids": ["GC.*"] }
        ]
      }
    ],
    "merge": {
      "combine": { "method": "merge" }
    },
    "back-matter": {
      "resources": [
        {
          "uuid": "res-mapping",
          "title": "Privacy-Security Mapping",
          "rlinks": [
            {
              "href": "opengov_privacy_to_bsi_grundschutz.json"
            }
          ]
        }
      ]
    }
  }
}
```

---

## 7. Implementierungshinweise

### 7.1 Nutzung in der Praxis

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PRAKTISCHE ANWENDUNG                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   SZENARIO 1: Behörde mit BSI-Grundschutz-Zertifizierung                   │
│   ══════════════════════════════════════════════════════                   │
│                                                                             │
│   1. BSI Grundschutz++ als Basis implementieren                            │
│   2. Mapping nutzen um Privacy-Gaps zu identifizieren                      │
│   3. OpenGov Privacy Controls für Gaps ergänzen:                           │
│      • DSR (komplett) - Betroffenenrechte                                  │
│      • XFER-03 - BCR                                                       │
│      • INC-03 - Betroffenen-Benachrichtigung                               │
│   4. Gemeinsame Controls mit Privacy-Ergänzungen versehen                  │
│                                                                             │
│   SZENARIO 2: Behörde mit DSGVO-Fokus                                      │
│   ═══════════════════════════════════                                      │
│                                                                             │
│   1. OpenGov Privacy Catalog als Basis                                     │
│   2. Für TOM, OPS, INC: BSI-Bausteine referenzieren                        │
│   3. BSI-Modalverben (MUSS/SOLLTE) übernehmen                              │
│   4. Effort-Level für Ressourcenplanung nutzen                             │
│                                                                             │
│   SZENARIO 3: Integriertes DSMS + ISMS                                     │
│   ═══════════════════════════════════                                      │
│                                                                             │
│   1. Gemeinsames Profil erstellen (siehe 6.2)                              │
│   2. Equivalent-Mappings zusammenführen                                    │
│   3. Related-Mappings mit beiden Perspektiven dokumentieren                │
│   4. Gaps explizit addressieren                                            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.2 Empfohlene Erweiterungen des OpenGov Privacy Catalog

Basierend auf dem Mapping sollte der OpenGov Privacy Catalog folgende BSI-Konzepte übernehmen:

| Erweiterung | BSI-Konzept | Implementierung |
|-------------|-------------|-----------------|
| **Modalverben** | `modalverb` (MUSS/SOLLTE/KANN) | Neue prop in allen Controls |
| **Effort-Level** | `effort_level` (0-4) | Ergänzend zu `maturity-domain` |
| **Abhängigkeits-Links** | `rel="required"` | Links zwischen Controls |
| **Dokumentations-Empfehlungen** | `dokumentation` | Neuer Part `documentation-requirements` |

### 7.3 Beispiel: Erweitertes Control

```json
{
  "id": "TOM-02",
  "title": "Zugriffs- und Berechtigungsmanagement",
  "props": [
    { "name": "legal", "value": "EU:REG:GDPR:ART-32" },
    { "name": "assurance_goal", "value": "confidentiality" },
    { "name": "maturity-domain", "value": "access-control" },
    { "name": "target-maturity", "value": "4" },
    { "name": "modalverb", "value": "MUSS", "ns": "https://open-gov-group.org/oscal/privacy" },
    { "name": "effort_level", "value": "2", "ns": "https://open-gov-group.org/oscal/privacy" },
    { "name": "bsi-mapping", "value": "ORP.4", "class": "equivalent" }
  ],
  "links": [
    {
      "href": "#GOV-01",
      "rel": "required",
      "text": "Setzt Datenschutz-Governance voraus"
    },
    {
      "href": "#SDM-TOM-AC-01",
      "rel": "related-control",
      "text": "Technische Umsetzung im SDM-Katalog"
    }
  ],
  "parts": [
    {
      "name": "documentation-requirements",
      "prose": "Erforderliche Dokumentation: Access-Control-Policy, Rollen- und Rechtekonzept, Rezertifizierungsprotokolle"
    }
  ]
}
```

---

## 8. Gap-Analyse

### 8.1 Privacy-Gaps in BSI Grundschutz++

| Gap | OpenGov Privacy | Beschreibung | Kritikalität |
|-----|-----------------|--------------|--------------|
| **G1** | DSR (komplett) | Betroffenenrechte fehlen vollständig | Kritisch |
| **G2** | INC-03 | Betroffenen-Benachrichtigung | Hoch |
| **G3** | XFER-03 | Binding Corporate Rules | Mittel |
| **G4** | LAW-02 bis LAW-05 | Datenminimierung, Zweckbindung, etc. | Hoch |
| **G5** | DPIA-Schwellwerte | Art. 35 Abs. 3 DSGVO Kriterien | Mittel |

### 8.2 Security-Gaps in OpenGov Privacy

| Gap | BSI Grundschutz++ | Beschreibung | Empfehlung |
|-----|-------------------|--------------|------------|
| **G6** | GC.6.2 | Projektmanagement-Kommunikation | Optional ergänzen |
| **G7** | Baustein-Kataloge | Detaillierte technische Maßnahmen | Via TOM-Mapping referenzieren |
| **G8** | Modalverben-System | Explizite Verbindlichkeit | Übernehmen (siehe 7.2) |

### 8.3 Visualisierung

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    GAP-ANALYSE VISUALISIERUNG                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Coverage: OpenGov Privacy ───────────────────────────────────────►        │
│                                                                             │
│   ████████████████████████████████░░░░░░░░░░░░░░░░░░░░  (60% abgedeckt)    │
│                                                                             │
│   Coverage: BSI Grundschutz++ ─────────────────────────────────────►        │
│                                                                             │
│   █████████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░  (50% abgedeckt)    │
│                                                                             │
│   Legende:                                                                  │
│   ████ = Covered durch Mapping                                              │
│   ░░░░ = Gap (nur in einem Katalog vorhanden)                              │
│                                                                             │
│   Gemeinsame Abdeckung (Schnittmenge):                                      │
│   ┌───────────────────────────────────────────────────────────────────┐    │
│   │ ██████████████████████████████████████████████████ (45% overlap)  │    │
│   │                                                                   │    │
│   │ GOV ↔ GC.4/5 | ACC ↔ GC.1/7 | TOM ↔ ORP/CON | OPS ↔ GC.7         │    │
│   └───────────────────────────────────────────────────────────────────┘    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 9. Referenzen

### 9.1 Quell-Kataloge

| Katalog | URL |
|---------|-----|
| OpenGov Privacy Catalog | [open_privacy_catalog_risk.json](https://github.com/open-gov-group/opengov-privacy-oscal/blob/main/oscal/catalog/open_privacy_catalog_risk.json) |
| BSI Grundschutz++ Methodik | [BSI-Methodik-Grundschutz++-catalog.json](https://github.com/BSI-Bund/Stand-der-Technik-Bibliothek/blob/main/Quellkataloge/Methodik-Grundschutz%2B%2B/BSI-Methodik-Grundschutz%2B%2B-catalog.json) |
| BSI IT-Grundschutz Kompendium | [BSI Grundschutz](https://www.bsi.bund.de/grundschutz) |

### 9.2 Verwandte Dokumente

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – OpenGov Privacy Katalog Spezifikation
- [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) – Privacy → SDM → Resilience Integration
- [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) – System-Architektur

### 9.3 Standards

| Standard | Relevanz |
|----------|----------|
| NIST OSCAL 1.1.2 | Gemeinsames Datenformat |
| DSGVO (EU 2016/679) | Rechtliche Basis OpenGov Privacy |
| BSI-Standard 200-1/2/3 | Methodische Basis BSI Grundschutz++ |
| ISO/IEC 27001:2022 | Gemeinsame Referenz für beide Kataloge |

---

## Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-05 | Initiale Version mit vollständigem Mapping |

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Status**: Initial Draft - Review erforderlich
