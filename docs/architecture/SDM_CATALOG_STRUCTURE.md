# SDM Privacy Catalog - Gliederungsspezifikation v2.0

**Version**: 2.0.0
**Stand**: 2026-02-05
**Status**: Erweiterte Struktur durch Reverse Engineering
**Verantwortlich**: Architecture Team

---

## 1. Übersicht

Diese Spezifikation definiert die **verbindliche Gliederungsstruktur** für den SDM Privacy Catalog v2.0. Die Struktur basiert auf einem Reverse-Engineering-Ansatz, bei dem technisch-organisatorische Maßnahmen aus ISO 27701, ISO 27001 und BSI IT-Grundschutz konsolidiert und aus Datenschutz-Perspektive interpretiert wurden.

### 1.1 Design-Prinzipien

1. **Gewährleistungsziel-orientiert**: Primäre Strukturierung nach den 7 SDM-Gewährleistungszielen
2. **OPC-harmonisiert**: Mapping zu den 11 OPC-Gruppen
3. **Framework-konsolidiert**: 31 Controls aus ~330 Quell-Maßnahmen (ISO 27701 + ISO 27001 + BSI)
4. **Schutzniveau-basiert**: Drei Implementierungsebenen (baseline/standard/enhanced)
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

| Gruppe-ID | Titel | Controls | Gewährleistungsziele | OPC-Bezug |
|-----------|-------|----------|----------------------|-----------|
| **SDM-TRA** | Transparenz | 5 | TRA | GOV, ACC, REG, TRAIN |
| **SDM-ITV** | Intervenierbarkeit | 5 | ITV | DSR |
| **SDM-NVK** | Nichtverkettung | 4 | NVK | LAW, XFER, OPS |
| **SDM-VCI** | Verfügbarkeit, Vertraulichkeit, Integrität | 8 | VER, VRT, INT | TOM, OPS, INC |
| **SDM-DMI** | Datenminimierung | 4 | DMI | LAW, DPIA |
| **SDM-MGT** | Management & Übergreifend | 5 | Alle | GOV, ACC, DPIA, INC |
| | **GESAMT** | **31** | | |

### 2.2 Vollständige Hierarchie (v2.0 - 31 Controls)

```
SDM PRIVACY CATALOG v2.0
════════════════════════

SDM-TRA: Transparenz (5 Controls)
├── SDM-TRA-41: Planen und Spezifizieren [B41]
├── SDM-TRA-42: Dokumentieren [B42, ISO A.5.33/A.5.37, BSI ORP.1]
├── SDM-TRA-43: Protokollieren [B43, ISO A.8.15/A.8.16, BSI OPS.1.1.5]
├── SDM-TRA-44: Klassifizieren und Kennzeichnen [ISO A.5.12/A.5.13]
└── SDM-TRA-45: Schulen und Sensibilisieren [ISO A.6.3, BSI ORP.2/ORP.3]

SDM-ITV: Intervenierbarkeit (5 Controls)
├── SDM-ITV-60: Löschen und Vernichten [B60, ISO A.8.10, BSI CON.6]
├── SDM-ITV-61: Berichtigen [B61, ISO 27701 A.1.4.4]
├── SDM-ITV-62: Einschränken der Verarbeitung [B62]
├── SDM-ITV-63: Auskunft erteilen [ISO 27701 A.1.3.7/A.1.3.9/A.1.3.10]
└── SDM-ITV-64: Datenportabilität ermöglichen [ISO 27701 A.1.3.9]

SDM-NVK: Nichtverkettung (4 Controls)
├── SDM-NVK-50: Trennen [B50, ISO A.8.22/A.8.31, BSI APP.4.3]
├── SDM-NVK-51: Pseudonymisieren [ISO A.8.11, ISO 27701 A.1.2.4]
├── SDM-NVK-52: Lieferanten- und Auftragsverarbeiter-Management [ISO A.5.19-A.5.23, BSI OPS.2.3]
└── SDM-NVK-53: Drittlandtransfer absichern [ISO 27701 A.1.2.7/A.1.2.8]

SDM-VCI: Verfügbarkeit, Vertraulichkeit, Integrität (8 Controls)
├── SDM-VCI-11: Aufbewahren und Sichern [B11, ISO A.8.13, BSI CON.3]
├── SDM-VCI-12: Zugriffe steuern [B51, ISO A.5.15-A.5.18/A.8.2-A.8.3, BSI ORP.4]
├── SDM-VCI-13: Authentisieren [ISO A.5.17/A.8.5]
├── SDM-VCI-14: Verschlüsseln [ISO A.8.24, BSI CON.1]
├── SDM-VCI-15: Übertragung schützen [ISO A.8.20/A.8.21, BSI NET.1.1/NET.3.1]
├── SDM-VCI-16: Endgeräte schützen [ISO A.8.1, BSI SYS.2.1/SYS.3.1]
├── SDM-VCI-17: Datenträger handhaben [ISO A.7.10, BSI CON.6]
└── SDM-VCI-18: Sichere Entwicklung [ISO A.8.25-A.8.32, BSI CON.8]

SDM-DMI: Datenminimierung (4 Controls)
├── SDM-DMI-01: Datenerhebung minimieren [ISO 27701 A.1.2.2/A.1.2.3]
├── SDM-DMI-02: Verarbeitung beschränken [ISO 27701 A.1.2.6]
├── SDM-DMI-03: Speicherdauer begrenzen [ISO 27701 A.1.2.9/A.1.4.6]
└── SDM-DMI-04: Testdaten anonymisieren [ISO A.8.33, ISO 27701 A.3.22]

SDM-MGT: Management & Übergreifend (5 Controls)
├── SDM-MGT-01: Datenschutzmanagementsystem etablieren [ISO 27701 Kl.4-10, BSI ISMS.1]
├── SDM-MGT-02: Risiken managen [ISO A.5.7, ISO 27701 A.1.2.1]
├── SDM-MGT-03: Audits durchführen [ISO A.5.35/A.5.36, BSI DER.3.1]
├── SDM-MGT-04: Vorfälle managen [ISO A.5.24-A.5.27, BSI DER.2.1]
└── SDM-MGT-05: Compliance nachweisen [ISO 27701 A.1.3.1-A.1.3.4]

LEGENDE: [Bxx] = Original SDM-Baustein | ISO = ISO 27001:2022 | BSI = BSI IT-Grundschutz
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
| 1.0.0 | 2026-02-05 | Initiale festgeschriebene Gliederungsstruktur (12 Controls) |
| 2.0.0 | 2026-02-05 | Erweiterung auf 31 Controls durch Reverse Engineering aus ISO 27701/27001/BSI |

### v2.0 Änderungen im Detail

**Neue Controls:**
- **SDM-TRA**: +2 (Klassifizieren, Schulen)
- **SDM-ITV**: +2 (Auskunft, Portabilität)
- **SDM-NVK**: +3 (Pseudonymisieren, Lieferanten, Drittland)
- **SDM-VCI**: +6 (Auth, Krypto, Netzwerk, Endpoint, Medien, DevSecOps)
- **SDM-DMI**: +4 (Erhebung, Verarbeitung, Speicher, Testdaten)
- **SDM-MGT**: +2 (Vorfälle, Compliance)

**Strukturelle Erweiterungen:**
- Dreistufiges Implementierungsmodell (baseline/standard/enhanced)
- Privacy-Rationale für jeden Control
- Vollständige Framework-Referenzen (ISO 27701, ISO 27001, BSI)
- OPC-Verlinkung pro Control

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Status**: Festgeschrieben v2.0
