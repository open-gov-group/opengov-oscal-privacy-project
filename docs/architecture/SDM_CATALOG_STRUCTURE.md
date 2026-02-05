# SDM Privacy Catalog - Gliederungsspezifikation v1.0

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Festgeschriebene Referenzstruktur
**Verantwortlich**: Architecture Team

---

## 1. Übersicht

Diese Spezifikation definiert die **verbindliche Gliederungsstruktur** für den SDM Privacy Catalog. Die Struktur ist auf die bestehende Open Privacy Catalog (OPC) Architektur abgestimmt und ermöglicht durchgängige Referenzierungen.

### 1.1 Design-Prinzipien

1. **Gewährleistungsziel-orientiert**: Primäre Strukturierung nach den 7 SDM-Gewährleistungszielen
2. **OPC-harmonisiert**: Mapping zu den 11 OPC-Gruppen
3. **Baustein-integriert**: Alle 9 existierenden SDM-Bausteine eingeordnet
4. **Erweiterbar**: Nummerierung erlaubt zukünftige Bausteine
5. **OSCAL-konform**: Kompatibel mit OSCAL 1.1.2 Catalog-Schema

### 1.2 Architektur-Kontext

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ZWEI-KATALOG-ARCHITEKTUR                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌───────────────────────────────────────────────────────────────────┐    │
│   │                 OPEN PRIVACY CATALOG (OPC)                        │    │
│   │                      "WAS" - Anforderungen                        │    │
│   │                                                                   │    │
│   │   GOV │ ACC │ LAW │ DSR │ REG │ TOM │ DPIA │ OPS │ XFER │ INC │ TRAIN │    │
│   │                                                                   │    │
│   │   Perspektive: DSGVO-Anforderungen, Rechtsreferenzen              │    │
│   └───────────────────────────────────────────────────────────────────┘    │
│                              │                                              │
│                              ▼ verweist auf                                 │
│   ┌───────────────────────────────────────────────────────────────────┐    │
│   │                 SDM PRIVACY CATALOG                               │    │
│   │                   "WIE" - Maßnahmen                               │    │
│   │                                                                   │    │
│   │   SDM-TRA │ SDM-ITV │ SDM-NVK │ SDM-VCI │ SDM-DMI │ SDM-MGT      │    │
│   │                                                                   │    │
│   │   Perspektive: Gewährleistungsziele, technische Umsetzung         │    │
│   └───────────────────────────────────────────────────────────────────┘    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. SDM-Gruppenstruktur (Festgeschrieben v1.0)

### 2.1 Übersicht der Hauptgruppen

| Gruppe-ID | Titel | Gewährleistungsziele | OPC-Bezug |
|-----------|-------|----------------------|-----------|
| **SDM-TRA** | Transparenz | TRA | GOV, ACC, REG, TRAIN |
| **SDM-ITV** | Intervenierbarkeit | ITV | DSR |
| **SDM-NVK** | Nichtverkettung | NVK | LAW, XFER |
| **SDM-VCI** | Verfügbarkeit, Vertraulichkeit, Integrität | VER, VRT, INT | TOM, OPS, INC |
| **SDM-DMI** | Datenminimierung | DMI | LAW, DPIA |
| **SDM-MGT** | Management & Übergreifend | Alle | GOV, ACC, DPIA |

### 2.2 Vollständige Hierarchie

```
SDM PRIVACY CATALOG v1.0
════════════════════════

SDM-TRA: Transparenz
├── SDM-TRA-41: Planen und Spezifizieren
├── SDM-TRA-42: Dokumentieren
├── SDM-TRA-43: Protokollieren
└── [Erweiterung: SDM-TRA-44 bis SDM-TRA-49 reserviert]

SDM-ITV: Intervenierbarkeit
├── SDM-ITV-60: Löschen und Vernichten (+ NVK, DMI, INT, VRT)
├── SDM-ITV-61: Berichtigen (+ INT)
├── SDM-ITV-62: Einschränken der Verarbeitung (+ NVK, DMI, INT, VRT)
└── [Erweiterung: SDM-ITV-63 bis SDM-ITV-69 reserviert]

SDM-NVK: Nichtverkettung
├── SDM-NVK-50: Trennen (+ DMI, VRT, ITV)
└── [Erweiterung: SDM-NVK-51 bis SDM-NVK-59 reserviert]

SDM-VCI: Verfügbarkeit, Vertraulichkeit, Integrität
├── SDM-VCI-11: Aufbewahren (+ DMI)
├── SDM-VCI-51: Zugriffe auf Daten, Systeme und Prozesse regeln (+ NVK, DMI)
└── [Erweiterung: SDM-VCI-12 bis SDM-VCI-19, SDM-VCI-52 bis SDM-VCI-59 reserviert]

SDM-DMI: Datenminimierung
└── [Konzeptionelle Gruppe - Bausteine primär in anderen Gruppen]
    └── Referenziert: SDM-ITV-60, SDM-ITV-62, SDM-NVK-50, SDM-VCI-11, SDM-VCI-51

SDM-MGT: Management & Übergreifend
├── SDM-MGT-01: Datenschutz-Managementsystem (DSMS)
├── SDM-MGT-02: Risikomanagement & DSFA
├── SDM-MGT-03: Audit & Kontrolle
└── [Erweiterung: SDM-MGT-04 bis SDM-MGT-09 reserviert]
```

---

## 3. Detaillierte Gruppen-Definition

### 3.1 SDM-TRA: Transparenz

**Beschreibung**: Maßnahmen zur Sicherstellung der Nachvollziehbarkeit und Verständlichkeit von Verarbeitungen für Betroffene und Aufsichtsbehörden.

**Gewährleistungsziel**: Transparenz (TRA)

**DSGVO-Bezug**: Art. 5(1)a, 12-14, 30

```yaml
group:
  id: "SDM-TRA"
  class: "transparency"
  title: "SDM-TRA – Transparenz"
  props:
    - name: "assurance-goal"
      value: "transparency"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "sdm-version"
      value: "3.1"

  controls:
    - id: "SDM-TRA-41"
      title: "Planen und Spezifizieren"
      # Existierender SDM-Baustein 41

    - id: "SDM-TRA-42"
      title: "Dokumentieren"
      # Existierender SDM-Baustein 42

    - id: "SDM-TRA-43"
      title: "Protokollieren"
      # Existierender SDM-Baustein 43
```

**OPC-Mapping**:

| SDM-Control | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|-------------|--------------------|-----------------------|
| SDM-TRA-41 | GOV | DPIA |
| SDM-TRA-42 | ACC, REG | GOV, OPS |
| SDM-TRA-43 | ACC | INC, OPS |

---

### 3.2 SDM-ITV: Intervenierbarkeit

**Beschreibung**: Maßnahmen zur Gewährleistung der Betroffenenrechte - Umsetzung von Löschung, Berichtigung, Einschränkung.

**Gewährleistungsziel**: Intervenierbarkeit (ITV)

**DSGVO-Bezug**: Art. 15-22

```yaml
group:
  id: "SDM-ITV"
  class: "intervenability"
  title: "SDM-ITV – Intervenierbarkeit"
  props:
    - name: "assurance-goal"
      value: "intervenability"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "sdm-version"
      value: "3.1"

  controls:
    - id: "SDM-ITV-60"
      title: "Löschen und Vernichten"
      props:
        - name: "secondary-goals"
          value: "non-linkability, data-minimization, integrity, confidentiality"
      # Existierender SDM-Baustein 60

    - id: "SDM-ITV-61"
      title: "Berichtigen"
      props:
        - name: "secondary-goals"
          value: "integrity"
      # Existierender SDM-Baustein 61

    - id: "SDM-ITV-62"
      title: "Einschränken der Verarbeitung"
      props:
        - name: "secondary-goals"
          value: "non-linkability, data-minimization, integrity, confidentiality"
      # Existierender SDM-Baustein 62
```

**OPC-Mapping**:

| SDM-Control | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|-------------|--------------------|-----------------------|
| SDM-ITV-60 | DSR (DSR-04 Löschung) | TOM |
| SDM-ITV-61 | DSR (DSR-03 Berichtigung) | INC |
| SDM-ITV-62 | DSR (DSR-05 Einschränkung) | - |

---

### 3.3 SDM-NVK: Nichtverkettung

**Beschreibung**: Maßnahmen zur Sicherstellung der Zweckbindung und Verhinderung unzulässiger Datenverknüpfungen.

**Gewährleistungsziel**: Nichtverkettung (NVK)

**DSGVO-Bezug**: Art. 5(1)b (Zweckbindung)

```yaml
group:
  id: "SDM-NVK"
  class: "non-linkability"
  title: "SDM-NVK – Nichtverkettung"
  props:
    - name: "assurance-goal"
      value: "non-linkability"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "sdm-version"
      value: "3.1"

  controls:
    - id: "SDM-NVK-50"
      title: "Trennen"
      props:
        - name: "secondary-goals"
          value: "data-minimization, confidentiality, intervenability"
      # Existierender SDM-Baustein 50
```

**OPC-Mapping**:

| SDM-Control | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|-------------|--------------------|-----------------------|
| SDM-NVK-50 | LAW (Zweckbindung) | XFER, TOM |

---

### 3.4 SDM-VCI: Verfügbarkeit, Vertraulichkeit, Integrität

**Beschreibung**: Klassische IT-Sicherheitsmaßnahmen adaptiert für Datenschutz - Schutz personenbezogener Daten.

**Gewährleistungsziele**: Verfügbarkeit (VER), Vertraulichkeit (VRT), Integrität (INT)

**DSGVO-Bezug**: Art. 32

```yaml
group:
  id: "SDM-VCI"
  class: "security-triad"
  title: "SDM-VCI – Verfügbarkeit, Vertraulichkeit, Integrität"
  props:
    - name: "assurance-goal"
      value: "availability, confidentiality, integrity"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "sdm-version"
      value: "3.1"

  controls:
    - id: "SDM-VCI-11"
      title: "Aufbewahren"
      props:
        - name: "secondary-goals"
          value: "data-minimization"
      # Existierender SDM-Baustein 11

    - id: "SDM-VCI-51"
      title: "Zugriffe auf Daten, Systeme und Prozesse regeln"
      props:
        - name: "secondary-goals"
          value: "non-linkability, data-minimization"
      # Existierender SDM-Baustein 51
```

**OPC-Mapping**:

| SDM-Control | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|-------------|--------------------|-----------------------|
| SDM-VCI-11 | TOM | OPS |
| SDM-VCI-51 | TOM | OPS, XFER |

---

### 3.5 SDM-DMI: Datenminimierung

**Beschreibung**: Übergreifendes Gewährleistungsziel - wird primär durch Maßnahmen in anderen Gruppen realisiert.

**Gewährleistungsziel**: Datenminimierung (DMI)

**DSGVO-Bezug**: Art. 5(1)c

```yaml
group:
  id: "SDM-DMI"
  class: "data-minimization"
  title: "SDM-DMI – Datenminimierung"
  props:
    - name: "assurance-goal"
      value: "data-minimization"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "implementation-note"
      value: "Cross-cutting concern - realized through controls in other groups"

  # Referenzen auf Maßnahmen in anderen Gruppen
  links:
    - href: "#SDM-ITV-60"
      rel: "implements"
      text: "Löschen reduziert Datenbestand"
    - href: "#SDM-ITV-62"
      rel: "implements"
      text: "Einschränkung begrenzt Verarbeitung"
    - href: "#SDM-NVK-50"
      rel: "implements"
      text: "Trennung verhindert unnötige Aggregation"
    - href: "#SDM-VCI-11"
      rel: "implements"
      text: "Aufbewahrung mit Löschkonzept"
    - href: "#SDM-VCI-51"
      rel: "implements"
      text: "Zugriffsbeschränkung auf Erforderliches"
```

**OPC-Mapping**:

| Konzept | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|---------|--------------------|-----------------------|
| Datenminimierung | LAW (LAW-03) | DPIA, REG |

---

### 3.6 SDM-MGT: Management & Übergreifend

**Beschreibung**: Übergreifende Management-Maßnahmen für das Datenschutz-Managementsystem.

**Gewährleistungsziele**: Alle (übergreifend)

**DSGVO-Bezug**: Art. 5(2), 24, 35

```yaml
group:
  id: "SDM-MGT"
  class: "management"
  title: "SDM-MGT – Management & Übergreifend"
  props:
    - name: "assurance-goal"
      value: "all"
      ns: "https://open-gov-group.org/oscal/sdm"
    - name: "implementation-note"
      value: "Übergreifende Controls für DSMS-Betrieb"

  controls:
    - id: "SDM-MGT-01"
      title: "Datenschutz-Managementsystem (DSMS)"
      # Neu definiert - kein existierender SDM-Baustein

    - id: "SDM-MGT-02"
      title: "Risikomanagement & DSFA"
      # Neu definiert - kein existierender SDM-Baustein

    - id: "SDM-MGT-03"
      title: "Audit & Kontrolle"
      # Neu definiert - kein existierender SDM-Baustein
```

**OPC-Mapping**:

| SDM-Control | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|-------------|--------------------|-----------------------|
| SDM-MGT-01 | GOV, ACC | OPS |
| SDM-MGT-02 | DPIA | GOV |
| SDM-MGT-03 | ACC | GOV, OPS |

---

## 4. Vollständige Mapping-Matrix

### 4.1 SDM → OPC (Bidirektional)

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                       SDM → OPC MAPPING MATRIX                                          │
├──────────────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┤
│ SDM-Baustein │ GOV  │ ACC  │ LAW  │ DSR  │ REG  │ TOM  │ DPIA │ OPS  │ XFER │ INC  │TRAIN │
├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ SDM-TRA-41   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ◐   │  ○   │  ○   │  ○   │  ◐   │
│ SDM-TRA-42   │  ◐   │  ●   │  ○   │  ○   │  ●   │  ○   │  ○   │  ◐   │  ○   │  ○   │  ○   │
│ SDM-TRA-43   │  ○   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ◐   │  ○   │  ◐   │  ○   │
├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ SDM-ITV-60   │  ○   │  ○   │  ○   │  ●   │  ○   │  ◐   │  ○   │  ○   │  ○   │  ○   │  ○   │
│ SDM-ITV-61   │  ○   │  ○   │  ○   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ◐   │  ○   │
│ SDM-ITV-62   │  ○   │  ○   │  ○   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ○   │  ○   │
├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ SDM-NVK-50   │  ○   │  ○   │  ●   │  ○   │  ○   │  ◐   │  ○   │  ○   │  ◐   │  ○   │  ○   │
├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ SDM-VCI-11   │  ○   │  ○   │  ○   │  ○   │  ○   │  ●   │  ○   │  ◐   │  ○   │  ○   │  ○   │
│ SDM-VCI-51   │  ○   │  ○   │  ○   │  ○   │  ○   │  ●   │  ○   │  ◐   │  ◐   │  ○   │  ○   │
├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ SDM-MGT-01   │  ●   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ◐   │  ○   │  ○   │  ○   │
│ SDM-MGT-02   │  ◐   │  ○   │  ○   │  ○   │  ○   │  ○   │  ●   │  ○   │  ○   │  ○   │  ○   │
│ SDM-MGT-03   │  ◐   │  ●   │  ○   │  ○   │  ○   │  ○   │  ○   │  ◐   │  ○   │  ○   │  ○   │
└──────────────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘

Legende: ● = primäre Zuordnung  ◐ = sekundäre Zuordnung  ○ = keine Zuordnung
```

### 4.2 OPC → SDM (Inverse Richtung)

| OPC-Gruppe | Primäre SDM-Bausteine | Sekundäre SDM-Bausteine |
|------------|----------------------|------------------------|
| **GOV** | SDM-MGT-01, SDM-TRA-41 | SDM-MGT-02, SDM-MGT-03 |
| **ACC** | SDM-TRA-42, SDM-TRA-43, SDM-MGT-01, SDM-MGT-03 | - |
| **LAW** | SDM-NVK-50 | - |
| **DSR** | SDM-ITV-60, SDM-ITV-61, SDM-ITV-62 | - |
| **REG** | SDM-TRA-42 | - |
| **TOM** | SDM-VCI-11, SDM-VCI-51 | SDM-ITV-60, SDM-NVK-50 |
| **DPIA** | SDM-MGT-02 | SDM-TRA-41 |
| **OPS** | - | SDM-TRA-42, SDM-TRA-43, SDM-VCI-11, SDM-VCI-51, SDM-MGT-01, SDM-MGT-03 |
| **XFER** | - | SDM-NVK-50, SDM-VCI-51 |
| **INC** | - | SDM-TRA-43, SDM-ITV-61 |
| **TRAIN** | - | SDM-TRA-41 |

---

## 5. Nummerierungsschema

### 5.1 ID-Struktur

```
SDM-{GRUPPE}-{NUMMER}

Wobei:
- GRUPPE: 3-Buchstaben-Code (TRA, ITV, NVK, VCI, DMI, MGT)
- NUMMER: 2-stellige Nummer (00-99)
```

### 5.2 Nummernbereiche (Reserviert)

| Gruppe | Bereich | Beschreibung |
|--------|---------|--------------|
| SDM-TRA | 40-49 | Transparenz-Bausteine |
| SDM-ITV | 60-69 | Intervenierbarkeits-Bausteine |
| SDM-NVK | 50-59 | Nichtverkettungs-Bausteine |
| SDM-VCI | 10-19 | Verfügbarkeits-/Integritäts-Bausteine (Aufbewahren etc.) |
| SDM-VCI | 51-59 | Vertraulichkeits-/Zugriffs-Bausteine |
| SDM-MGT | 01-09 | Management-Bausteine |

### 5.3 Mapping zu Original-SDM-Bausteinnummern

| Original-Nr. | Original-Name | Neue SDM-ID |
|--------------|---------------|-------------|
| B11 | Aufbewahren | SDM-VCI-11 |
| B41 | Planen und Spezifizieren | SDM-TRA-41 |
| B42 | Dokumentieren | SDM-TRA-42 |
| B43 | Protokollieren | SDM-TRA-43 |
| B50 | Trennen | SDM-NVK-50 |
| B51 | Zugriffe regeln | SDM-VCI-51 |
| B60 | Löschen und Vernichten | SDM-ITV-60 |
| B61 | Berichtigen | SDM-ITV-61 |
| B62 | Einschränken | SDM-ITV-62 |
| - | DSMS (neu) | SDM-MGT-01 |
| - | Risikomanagement (neu) | SDM-MGT-02 |
| - | Audit (neu) | SDM-MGT-03 |

---

## 6. OSCAL-Implementierung

### 6.1 Catalog-Struktur (JSON)

```json
{
  "catalog": {
    "uuid": "sdm-privacy-catalog-v1-uuid",
    "metadata": {
      "title": "SDM Privacy Catalog",
      "version": "1.0.0",
      "oscal-version": "1.1.2",
      "last-modified": "2026-02-05T00:00:00Z",
      "props": [
        {
          "name": "catalog-type",
          "value": "privacy-measures",
          "ns": "https://open-gov-group.org/oscal/sdm"
        },
        {
          "name": "sdm-version",
          "value": "3.1"
        }
      ],
      "links": [
        {
          "href": "https://www.datenschutzzentrum.de/sdm/",
          "rel": "canonical"
        }
      ]
    },
    "groups": [
      {
        "id": "SDM-TRA",
        "class": "transparency",
        "title": "SDM-TRA – Transparenz",
        "props": [
          {
            "name": "assurance-goal",
            "value": "transparency",
            "ns": "https://open-gov-group.org/oscal/sdm"
          }
        ],
        "controls": [
          {
            "id": "SDM-TRA-41",
            "title": "Planen und Spezifizieren",
            "props": [
              {
                "name": "original-sdm-id",
                "value": "B41"
              },
              {
                "name": "opc-mapping",
                "value": "GOV",
                "class": "primary"
              }
            ]
          }
        ]
      }
    ]
  }
}
```

### 6.2 Verknüpfung mit OPC

```json
{
  "control": {
    "id": "GOV-01",
    "title": "Datenschutzorganisation definiert",
    "links": [
      {
        "href": "sdm-privacy-catalog.json#SDM-TRA-41",
        "rel": "implements",
        "text": "SDM: Planen und Spezifizieren"
      },
      {
        "href": "sdm-privacy-catalog.json#SDM-TRA-42",
        "rel": "implements",
        "text": "SDM: Dokumentieren"
      },
      {
        "href": "sdm-privacy-catalog.json#SDM-MGT-01",
        "rel": "implements",
        "text": "SDM: DSMS"
      }
    ]
  }
}
```

---

## 7. Visualisierung

### 7.1 Gewährleistungsziel-Matrix

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              SDM GEWÄHRLEISTUNGSZIELE → BAUSTEINE                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                           GEWÄHRLEISTUNGSZIELE                              │
│   ┌─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┐ │
│   │   VER   │   INT   │   VRT   │   TRA   │   ITV   │   NVK   │   DMI   │ │
│   │Verfügb. │Integrit.│Vertraul.│Transpar.│Interven.│Nichtver.│Datenmin.│ │
│   └────┬────┴────┬────┴────┬────┴────┬────┴────┬────┴────┬────┴────┬────┘ │
│        │         │         │         │         │         │         │       │
│   ┌────┴────┬────┴────┬────┴────┐    │         │         │         │       │
│   │         │         │         │    │         │         │         │       │
│   │       SDM-VCI     │         │    │         │         │         │       │
│   │    (11, 51)       │         │    │         │         │         │       │
│   │                   │         │    │         │         │         │       │
│   └───────────────────┘         │    │         │         │         │       │
│                                 │    │         │         │         │       │
│                            ┌────┴────┴────┐    │         │         │       │
│                            │              │    │         │         │       │
│                            │   SDM-TRA    │    │         │         │       │
│                            │  (41,42,43)  │    │         │         │       │
│                            │              │    │         │         │       │
│                            └──────────────┘    │         │         │       │
│                                                │         │         │       │
│                                           ┌────┴────┐    │         │       │
│                                           │         │    │         │       │
│                                           │ SDM-ITV │    │         │       │
│                                           │(60,61,62)    │         │       │
│                                           │         │    │         │       │
│                                           └─────────┘    │         │       │
│                                                          │         │       │
│                                                     ┌────┴────┐    │       │
│                                                     │         │    │       │
│                                                     │ SDM-NVK │    │       │
│                                                     │  (50)   │    │       │
│                                                     │         │    │       │
│                                                     └─────────┘    │       │
│                                                                    │       │
│   ┌─────────────────────────────────────────────────────────┐     │       │
│   │                      SDM-DMI                            │◄────┘       │
│   │         (Cross-cutting: 11, 50, 51, 60, 62)            │             │
│   └─────────────────────────────────────────────────────────┘             │
│                                                                           │
│   ┌─────────────────────────────────────────────────────────────────────┐ │
│   │                        SDM-MGT (01, 02, 03)                         │ │
│   │                    Übergreifend: Alle Ziele                         │ │
│   └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### 7.2 Architektur-Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SDM PRIVACY CATALOG v1.0 - ARCHITEKTUR                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   MANAGEMENT-EBENE                                                          │
│   ════════════════                                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐  │
│   │                         SDM-MGT                                     │  │
│   │   ┌───────────┐   ┌───────────┐   ┌───────────┐                    │  │
│   │   │ MGT-01    │   │ MGT-02    │   │ MGT-03    │                    │  │
│   │   │ DSMS      │   │ Risiko    │   │ Audit     │                    │  │
│   │   └───────────┘   └───────────┘   └───────────┘                    │  │
│   └─────────────────────────────────────────────────────────────────────┘  │
│                               │                                             │
│                               ▼                                             │
│   OPERATIVE EBENE                                                           │
│   ═══════════════                                                           │
│                                                                             │
│   ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐            │
│   │    SDM-TRA      │  │    SDM-VCI      │  │    SDM-NVK      │            │
│   │  Transparenz    │  │ VER/INT/VRT     │  │ Nichtverkettung │            │
│   ├─────────────────┤  ├─────────────────┤  ├─────────────────┤            │
│   │ TRA-41 Planen   │  │ VCI-11 Aufbew.  │  │ NVK-50 Trennen  │            │
│   │ TRA-42 Dokum.   │  │ VCI-51 Zugriffe │  │                 │            │
│   │ TRA-43 Protok.  │  │                 │  │                 │            │
│   └─────────────────┘  └─────────────────┘  └─────────────────┘            │
│                                                                             │
│   ┌─────────────────┐  ┌─────────────────────────────────────────────────┐ │
│   │    SDM-ITV      │  │                   SDM-DMI                       │ │
│   │ Intervenierb.   │  │              (Cross-Cutting)                    │ │
│   ├─────────────────┤  │  Referenziert: ITV-60, ITV-62, NVK-50,         │ │
│   │ ITV-60 Löschen  │  │               VCI-11, VCI-51                    │ │
│   │ ITV-61 Berich.  │  └─────────────────────────────────────────────────┘ │
│   │ ITV-62 Einschr. │                                                      │
│   └─────────────────┘                                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 8. Referenzen

### 8.1 Projekt-Dokumentation

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – OPC-Spezifikation
- [GROUP_MAPPING_ANALYSIS.md](GROUP_MAPPING_ANALYSIS.md) – Mapping-Analyse
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – BSI-Mapping

### 8.2 Externe Quellen

- [SDM - Standard-Datenschutzmodell (ULD)](https://www.datenschutzzentrum.de/sdm/)
- [SDM V3.1 Methodenhandbuch (DSK)](https://www.datenschutzkonferenz-online.de/media/ah/SDM-Methode-V31.pdf)
- [SDM-Bausteine (LfD MV)](https://www.datenschutz-mv.de/datenschutz/datenschutzmodell/)

---

## Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-05 | Initiale festgeschriebene Gliederungsstruktur |

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Status**: Festgeschrieben v1.0
