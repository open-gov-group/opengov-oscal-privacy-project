# SPC Reverse Engineering - Technische Maßnahmen aus Datenschutz-Sicht

**Version**: 1.0.0-draft
**Stand**: 2026-02-05
**Status**: Konzept zur Konsolidierung technischer Maßnahmen

---

## 1. Methodik

### 1.1 Ansatz: Reverse Engineering

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    REVERSE ENGINEERING ANSATZ                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   QUELL-KATALOGE (Technisch/Organisatorisch)                                    │
│   ═══════════════════════════════════════════                                   │
│                                                                                  │
│   ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐                │
│   │ ISO 27701       │  │ ISO 27001:2022  │  │ BSI Grundschutz │                │
│   │ A.1.4, A.3      │  │ Annex A         │  │ ORP, CON, OPS   │                │
│   │ (38 Controls)   │  │ (93 Controls)   │  │ (~200 Anforder.)│                │
│   └────────┬────────┘  └────────┬────────┘  └────────┬────────┘                │
│            │                    │                    │                          │
│            └────────────────────┼────────────────────┘                          │
│                                 │                                               │
│                                 ▼                                               │
│   TRANSFORMATION (Datenschutz-Perspektive)                                      │
│   ═════════════════════════════════════════                                     │
│                                 │                                               │
│   1. Extraktion: Welche Maßnahmen sind PII-relevant?                           │
│   2. Konsolidierung: Doppelte Themen zusammenführen                            │
│   3. Datenschutz-Interpretation: "Was bedeutet das für den Betroffenen?"       │
│   4. Einordnung: In SDM-Gewährleistungsziele kategorisieren                    │
│                                 │                                               │
│                                 ▼                                               │
│   ZIEL-KATALOG (SPC)                                                            │
│   ══════════════════                                                            │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │                      SDM Privacy Catalog                                 │  │
│   │                                                                          │  │
│   │   SDM-TRA │ SDM-ITV │ SDM-NVK │ SDM-VCI │ SDM-DMI │ SDM-MGT            │  │
│   │                                                                          │  │
│   │   + Framework-Referenzen (ISO, BSI)                                     │  │
│   │   + Datenschutz-Begründung                                              │  │
│   │   + Schutzniveau (baseline/standard/enhanced)                           │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Konsolidierungsprinzip

**Regel**: Wenn mehrere Frameworks dieselbe technische Maßnahme beschreiben, wird **ein** SPC-Control erstellt mit **allen Referenzen**.

```
Beispiel: Zugriffsmanagement

ISO 27701 A.3.8/A.3.9  ─┐
ISO 27001 A.5.15-A.5.18 ─┼──► SPC: SDM-VCI-AC-01 "Zugriffskontrolle"
BSI ORP.4              ─┘     mit allen drei Referenzen
```

---

## 2. Quell-Analyse: Technische Maßnahmen

### 2.1 ISO 27701:2025 - Privacy-relevante Maßnahmen

#### A.1.4 Privacy by Design und Default (9 Controls)

| Control | Titel | Datenschutz-Relevanz | SPC-Ziel |
|---------|-------|---------------------|----------|
| A.1.4.2 | Limit collection | Datenminimierung bei Erhebung | SDM-DMI |
| A.1.4.3 | Limit processing | Datenminimierung bei Verarbeitung | SDM-DMI |
| A.1.4.4 | Accuracy and quality | Datenrichtigkeit | SDM-ITV |
| A.1.4.5 | PII minimization objectives | Minimierungsziele definieren | SDM-DMI |
| A.1.4.6 | De-identification and deletion | Anonymisierung/Löschung | SDM-NVK, SDM-ITV |
| A.1.4.7 | Temporary files | Temp-Dateien löschen | SDM-ITV |
| A.1.4.8 | Retention | Speicherbegrenzung | SDM-DMI |
| A.1.4.9 | Disposal | Sichere Entsorgung | SDM-ITV |
| A.1.4.10 | Transmission controls | Übertragungsschutz | SDM-VCI |

#### A.3 Security Controls (29 Controls)

| Control | Titel | Datenschutz-Relevanz | SPC-Ziel |
|---------|-------|---------------------|----------|
| A.3.3 | Policies for information security | Datenschutz-Policy | SDM-MGT |
| A.3.4 | Roles and responsibilities | Rollen für PII-Verarbeitung | SDM-MGT |
| A.3.5 | Classification of information | PII-Klassifizierung | SDM-TRA |
| A.3.6 | Labelling of information | PII-Kennzeichnung | SDM-TRA |
| A.3.7 | Information transfer | Sichere Datenübertragung | SDM-VCI |
| A.3.8 | Identity management | Identitätsmanagement | SDM-VCI |
| A.3.9 | Access rights | Zugriffsrechte | SDM-VCI |
| A.3.10 | Supplier agreements | Auftragsverarbeiter-Kontrolle | SDM-NVK |
| A.3.11 | Incident management planning | Vorfallsplanung | SDM-MGT |
| A.3.12 | Response to incidents | Vorfallsreaktion | SDM-MGT |
| A.3.13 | Legal requirements | Rechtliche Anforderungen | SDM-TRA |
| A.3.14 | Protection of records | Aufzeichnungsschutz | SDM-TRA |
| A.3.15 | Independent review | Unabhängige Prüfung | SDM-MGT |
| A.3.16 | Compliance with policies | Policy-Einhaltung | SDM-MGT |
| A.3.17 | Awareness and training | Schulung | SDM-TRA |
| A.3.18 | Confidentiality agreements | Vertraulichkeitsvereinbarungen | SDM-VCI |
| A.3.19 | Clear desk/screen | Clean Desk Policy | SDM-VCI |
| A.3.20 | Storage media | Speichermedien-Verwaltung | SDM-VCI |
| A.3.21 | Secure disposal | Sichere Entsorgung | SDM-ITV |
| A.3.22 | User endpoint devices | Endgeräte-Schutz | SDM-VCI |
| A.3.23 | Secure authentication | Authentifizierung | SDM-VCI |
| A.3.24 | Information backup | Datensicherung | SDM-VCI |
| A.3.25 | Logging | Protokollierung | SDM-TRA |
| A.3.26 | Use of cryptography | Verschlüsselung | SDM-VCI |
| A.3.27 | Secure development lifecycle | Sichere Entwicklung | SDM-VCI |
| A.3.28 | Application security requirements | Anwendungssicherheit | SDM-VCI |
| A.3.29 | Secure architecture | Sichere Architektur | SDM-VCI |
| A.3.30 | Outsourced development | Ausgelagerte Entwicklung | SDM-NVK |
| A.3.31 | Test information | Testdaten-Schutz | SDM-DMI |

### 2.2 ISO 27001:2022 Annex A - PII-relevante Maßnahmen (Auszug)

| Control | Titel | Äquivalent in ISO 27701 | SPC-Ziel |
|---------|-------|------------------------|----------|
| A.5.1 | Policies | A.3.3 | SDM-MGT |
| A.5.2 | Roles | A.3.4 | SDM-MGT |
| A.5.10 | Acceptable use | - | SDM-VCI |
| A.5.12 | Classification | A.3.5 | SDM-TRA |
| A.5.13 | Labelling | A.3.6 | SDM-TRA |
| A.5.15 | Access control | A.3.9 | SDM-VCI |
| A.5.16 | Identity management | A.3.8 | SDM-VCI |
| A.5.17 | Authentication | A.3.23 | SDM-VCI |
| A.5.31 | Legal requirements | A.3.13 | SDM-TRA |
| A.5.33 | Protection of records | A.3.14 | SDM-TRA |
| A.5.34 | Privacy protection | - | SDM-DMI |
| A.5.37 | Documented procedures | - | SDM-TRA |
| A.8.2 | Privileged access | A.3.9 | SDM-VCI |
| A.8.3 | Access restriction | A.3.9 | SDM-VCI |
| A.8.5 | Secure authentication | A.3.23 | SDM-VCI |
| A.8.10 | Information deletion | A.1.4.6 | SDM-ITV |
| A.8.11 | Data masking | A.1.4.6 | SDM-NVK |
| A.8.12 | Data leakage prevention | - | SDM-VCI |
| A.8.13 | Information backup | A.3.24 | SDM-VCI |
| A.8.15 | Logging | A.3.25 | SDM-TRA |
| A.8.24 | Cryptography | A.3.26 | SDM-VCI |
| A.8.25-28 | Secure development | A.3.27-29 | SDM-VCI |
| A.8.33 | Test information | A.3.31 | SDM-DMI |

### 2.3 BSI IT-Grundschutz - PII-relevante Bausteine

| Baustein | Titel | ISO-Äquivalent | SPC-Ziel |
|----------|-------|----------------|----------|
| **ISMS.1** | Sicherheitsmanagement | A.5.1, A.3.3 | SDM-MGT |
| **ORP.1** | Organisation | A.3.4 | SDM-MGT |
| **ORP.2** | Personal | A.3.17 | SDM-TRA |
| **ORP.3** | Sensibilisierung | A.3.17 | SDM-TRA |
| **ORP.4** | Identitäts- und Berechtigungsmanagement | A.3.8, A.3.9 | SDM-VCI |
| **ORP.5** | Compliance | A.3.13, A.3.16 | SDM-MGT |
| **CON.1** | Kryptokonzept | A.3.26 | SDM-VCI |
| **CON.2** | Datenschutz | - (Privacy-spezifisch) | SDM-DMI |
| **CON.3** | Datensicherungskonzept | A.3.24 | SDM-VCI |
| **CON.6** | Löschen und Vernichten | A.1.4.6, A.3.21 | SDM-ITV |
| **CON.7** | Informationssicherheit auf Reisen | A.3.22 | SDM-VCI |
| **OPS.1.1.3** | Patch-Management | A.8.8 | SDM-VCI |
| **OPS.1.1.4** | Schutz vor Schadprogrammen | A.8.7 | SDM-VCI |
| **OPS.1.1.5** | Protokollierung | A.3.25 | SDM-TRA |
| **OPS.1.1.6** | Software-Tests | A.3.31 | SDM-DMI |
| **OPS.1.2.4** | Telearbeit | A.3.22 | SDM-VCI |
| **OPS.2.1** | Outsourcing | A.3.10, A.3.30 | SDM-NVK |
| **OPS.2.2** | Cloud-Nutzung | A.3.10 | SDM-NVK |
| **APP.4.3** | Relationale Datenbanken | - | SDM-VCI |
| **DER.1** | Detektion | - | SDM-TRA |
| **DER.2.1** | Behandlung von Sicherheitsvorfällen | A.3.11, A.3.12 | SDM-MGT |
| **DER.3.1** | Audits und Revisionen | A.3.15 | SDM-MGT |

---

## 3. Konsolidierte SPC-Control-Struktur

### 3.1 Konsolidierungsmatrix

Die folgenden Controls werden aus mehreren Frameworks konsolidiert:

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    KONSOLIDIERUNGS-MATRIX                                       │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   SPC-CONTROL              │ ISO 27701   │ ISO 27001   │ BSI          │ SDM-B  │
│   ─────────────────────────┼─────────────┼─────────────┼──────────────┼────────│
│                            │             │             │              │        │
│   SDM-TRA                  │             │             │              │        │
│   ├── TRA-DOC-01 Doku      │ A.3.14      │ A.5.33,37   │ ORP.1        │ B42    │
│   ├── TRA-LOG-01 Logging   │ A.3.25      │ A.8.15,16   │ OPS.1.1.5    │ B43    │
│   ├── TRA-CLS-01 Klassif.  │ A.3.5,6     │ A.5.12,13   │ -            │ -      │
│   └── TRA-AWA-01 Schulung  │ A.3.17      │ A.7.2,3     │ ORP.2,3      │ -      │
│                            │             │             │              │        │
│   SDM-ITV                  │             │             │              │        │
│   ├── ITV-DEL-01 Löschen   │ A.1.4.6,9   │ A.8.10      │ CON.6        │ B60    │
│   ├── ITV-COR-01 Berichtig.│ A.1.4.4     │ -           │ -            │ B61    │
│   └── ITV-RES-01 Einschrän.│ -           │ -           │ -            │ B62    │
│                            │             │             │              │        │
│   SDM-NVK                  │             │             │              │        │
│   ├── NVK-SEP-01 Trennung  │ -           │ -           │ -            │ B50    │
│   ├── NVK-PSE-01 Pseudonym.│ A.1.4.5,6   │ A.8.11      │ CON.2        │ -      │
│   ├── NVK-SUP-01 Lieferant.│ A.3.10,30   │ A.5.19-23   │ OPS.2.1,2.2  │ -      │
│   └── NVK-TRF-01 Transfer  │ A.1.5       │ -           │ -            │ -      │
│                            │             │             │              │        │
│   SDM-VCI                  │             │             │              │        │
│   ├── VCI-AC-01 Zugriff    │ A.3.8,9     │ A.5.15-18   │ ORP.4        │ B51    │
│   ├── VCI-AUT-01 Auth.     │ A.3.23      │ A.8.5       │ ORP.4        │ -      │
│   ├── VCI-CRY-01 Krypto    │ A.3.26      │ A.8.24      │ CON.1        │ -      │
│   ├── VCI-BAK-01 Backup    │ A.3.24      │ A.8.13      │ CON.3        │ B11    │
│   ├── VCI-TRM-01 Transmit  │ A.1.4.10,A.3.7│ A.5.14    │ -            │ -      │
│   ├── VCI-END-01 Endgeräte │ A.3.22      │ A.8.1       │ CON.7        │ -      │
│   ├── VCI-MED-01 Medien    │ A.3.20,21   │ A.7.9,10    │ CON.6        │ -      │
│   └── VCI-DEV-01 Entwickl. │ A.3.27-29   │ A.8.25-31   │ APP.*        │ -      │
│                            │             │             │              │        │
│   SDM-DMI                  │             │             │              │        │
│   ├── DMI-COL-01 Erhebung  │ A.1.4.2     │ -           │ CON.2        │ -      │
│   ├── DMI-PRO-01 Verarbeit.│ A.1.4.3     │ -           │ CON.2        │ -      │
│   ├── DMI-RET-01 Speicher  │ A.1.4.8     │ -           │ -            │ -      │
│   └── DMI-TST-01 Testdaten │ A.3.31      │ A.8.33      │ OPS.1.1.6    │ -      │
│                            │             │             │              │        │
│   SDM-MGT                  │             │             │              │        │
│   ├── MGT-POL-01 Policies  │ A.3.3       │ A.5.1       │ ISMS.1       │ -      │
│   ├── MGT-ORG-01 Orga.     │ A.3.4       │ A.5.2       │ ORP.1        │ -      │
│   ├── MGT-INC-01 Vorfälle  │ A.3.11,12   │ A.5.24-30   │ DER.2.1      │ -      │
│   ├── MGT-AUD-01 Audit     │ A.3.15,16   │ A.5.35,36   │ DER.3.1      │ -      │
│   └── MGT-COM-01 Compliance│ A.3.13      │ A.5.31      │ ORP.5        │ -      │
│                            │             │             │              │        │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Neue SPC-Struktur (Erweitert)

```
SDM PRIVACY CATALOG v2.0 (Vorschlag)
════════════════════════════════════

SDM-TRA: Transparenz
├── SDM-TRA-41: Planen und Spezifizieren (Original SDM B41)
├── SDM-TRA-42: Dokumentieren (Original SDM B42)
│   └── Konsolidiert: ISO 27701 A.3.14, ISO 27001 A.5.33/A.5.37, BSI ORP.1
├── SDM-TRA-43: Protokollieren (Original SDM B43)
│   └── Konsolidiert: ISO 27701 A.3.25, ISO 27001 A.8.15/A.8.16, BSI OPS.1.1.5
├── SDM-TRA-44: Klassifizieren und Kennzeichnen (NEU)
│   └── Konsolidiert: ISO 27701 A.3.5/A.3.6, ISO 27001 A.5.12/A.5.13
└── SDM-TRA-45: Schulen und Sensibilisieren (NEU)
    └── Konsolidiert: ISO 27701 A.3.17, ISO 27001 A.7.2/A.7.3, BSI ORP.2/ORP.3

SDM-ITV: Intervenierbarkeit
├── SDM-ITV-60: Löschen und Vernichten (Original SDM B60)
│   └── Konsolidiert: ISO 27701 A.1.4.6/A.1.4.9/A.3.21, ISO 27001 A.8.10, BSI CON.6
├── SDM-ITV-61: Berichtigen (Original SDM B61)
│   └── Konsolidiert: ISO 27701 A.1.4.4
├── SDM-ITV-62: Einschränken der Verarbeitung (Original SDM B62)
├── SDM-ITV-63: Auskunft erteilen (NEU)
│   └── Basis: ISO 27701 A.1.3.7/A.1.3.9 (technische Umsetzung)
└── SDM-ITV-64: Datenportabilität ermöglichen (NEU)
    └── Basis: ISO 27701 A.1.3.9

SDM-NVK: Nichtverkettung
├── SDM-NVK-50: Trennen (Original SDM B50)
├── SDM-NVK-51: Pseudonymisieren und Anonymisieren (NEU)
│   └── Konsolidiert: ISO 27701 A.1.4.5/A.1.4.6, ISO 27001 A.8.11, BSI CON.2
├── SDM-NVK-52: Lieferanten und Auftragsverarbeiter steuern (NEU)
│   └── Konsolidiert: ISO 27701 A.3.10/A.3.30, ISO 27001 A.5.19-A.5.23, BSI OPS.2.1/OPS.2.2
└── SDM-NVK-53: Drittlandübermittlung absichern (NEU)
    └── Basis: ISO 27701 A.1.5, A.2.5

SDM-VCI: Verfügbarkeit, Vertraulichkeit, Integrität
├── SDM-VCI-11: Aufbewahren (Original SDM B11)
│   └── Konsolidiert: BSI CON.3
├── SDM-VCI-51: Zugriffe regeln (Original SDM B51)
│   └── Konsolidiert: ISO 27701 A.3.8/A.3.9, ISO 27001 A.5.15-A.5.18, BSI ORP.4
├── SDM-VCI-12: Authentisieren (NEU)
│   └── Konsolidiert: ISO 27701 A.3.23, ISO 27001 A.8.5, BSI ORP.4
├── SDM-VCI-13: Verschlüsseln (NEU)
│   └── Konsolidiert: ISO 27701 A.3.26, ISO 27001 A.8.24, BSI CON.1
├── SDM-VCI-14: Sicher übertragen (NEU)
│   └── Konsolidiert: ISO 27701 A.1.4.10/A.3.7, ISO 27001 A.5.14
├── SDM-VCI-15: Endgeräte schützen (NEU)
│   └── Konsolidiert: ISO 27701 A.3.22, ISO 27001 A.8.1, BSI CON.7
├── SDM-VCI-16: Speichermedien verwalten (NEU)
│   └── Konsolidiert: ISO 27701 A.3.20/A.3.21, ISO 27001 A.7.9/A.7.10, BSI CON.6
└── SDM-VCI-17: Sicher entwickeln (NEU)
    └── Konsolidiert: ISO 27701 A.3.27-A.3.29, ISO 27001 A.8.25-A.8.31, BSI APP.*

SDM-DMI: Datenminimierung
├── SDM-DMI-01: Erhebung begrenzen (NEU)
│   └── Basis: ISO 27701 A.1.4.2, BSI CON.2
├── SDM-DMI-02: Verarbeitung begrenzen (NEU)
│   └── Basis: ISO 27701 A.1.4.3
├── SDM-DMI-03: Speicherdauer begrenzen (NEU)
│   └── Basis: ISO 27701 A.1.4.8
├── SDM-DMI-04: Testdaten schützen (NEU)
│   └── Konsolidiert: ISO 27701 A.3.31, ISO 27001 A.8.33, BSI OPS.1.1.6
└── [Referenziert: SDM-ITV-60, SDM-NVK-51]

SDM-MGT: Management & Übergreifend
├── SDM-MGT-01: DSMS betreiben (bestehend)
│   └── Konsolidiert: ISO 27701 A.3.3, ISO 27001 A.5.1, BSI ISMS.1
├── SDM-MGT-02: Risikomanagement durchführen (bestehend)
├── SDM-MGT-03: Audits durchführen (bestehend)
│   └── Konsolidiert: ISO 27701 A.3.15/A.3.16, ISO 27001 A.5.35/A.5.36, BSI DER.3.1
├── SDM-MGT-04: Vorfälle behandeln (NEU)
│   └── Konsolidiert: ISO 27701 A.3.11/A.3.12, ISO 27001 A.5.24-A.5.30, BSI DER.2.1
└── SDM-MGT-05: Compliance sicherstellen (NEU)
    └── Konsolidiert: ISO 27701 A.3.13, ISO 27001 A.5.31, BSI ORP.5
```

---

## 4. Detaillierte Control-Definitionen

### 4.1 Beispiel: SDM-VCI-13 (Verschlüsseln) - Konsolidiert

```yaml
control:
  id: "SDM-VCI-13"
  title: "Verschlüsseln"
  class: "technical"

  # Datenschutz-Perspektive (WAS es für den Betroffenen bedeutet)
  parts:
    - name: "statement"
      prose: |
        Die Organisation setzt Verschlüsselung ein, um personenbezogene Daten
        vor unbefugtem Zugriff zu schützen - sowohl bei der Speicherung (at rest)
        als auch bei der Übertragung (in transit).

    - name: "privacy-rationale"
      prose: |
        Verschlüsselung schützt die VERTRAULICHKEIT personenbezogener Daten und
        gewährleistet, dass selbst bei einem Datenverlust (z.B. verlorener Laptop,
        abgefangene Übertragung) die Daten für Unbefugte unlesbar bleiben.

        DSGVO-Bezug: Art. 32 Abs. 1 lit. a nennt Verschlüsselung explizit als
        geeignete technische Maßnahme.

    - name: "implementation-levels"
      parts:
        - name: "baseline"
          prose: |
            - TLS 1.2+ für alle Datenübertragungen
            - AES-128 für Festplattenverschlüsselung
            - Passwort-Hashing (bcrypt, Argon2)

        - name: "standard"
          prose: |
            - TLS 1.3 bevorzugt
            - AES-256 für Speicherung
            - Key Management Policy
            - Zertifikatsmanagement

        - name: "enhanced"
          prose: |
            - Hardware Security Modules (HSM)
            - Ende-zu-Ende-Verschlüsselung
            - Post-Quantum-Ready Algorithmen
            - Automatische Key-Rotation

  # Framework-Referenzen (WOHER die Anforderung kommt)
  props:
    - name: "assurance-goals"
      value: "confidentiality, integrity"
      ns: "https://open-gov-group.org/oscal/sdm"

    - name: "iso27701-mapping"
      value: "A.3.26"
      ns: "https://open-gov-group.org/oscal/privacy"
      class: "framework-mapping"
      remarks: "Use of cryptography - Regeln für Kryptographie bei PII-Verarbeitung"

    - name: "iso27001-mapping"
      value: "A.8.24"
      ns: "https://open-gov-group.org/oscal/privacy"
      class: "framework-mapping"
      remarks: "Use of cryptography - Kryptographische Kontrollen"

    - name: "bsi-mapping"
      value: "CON.1"
      ns: "https://open-gov-group.org/oscal/privacy"
      class: "framework-mapping"
      remarks: "Kryptokonzept"

    - name: "dp-risk-impact"
      value: "high"
      remarks: "Bei Verstoß: Unbefugter Zugriff auf sensible Daten möglich"

    - name: "moscow"
      value: "must"
      remarks: "Art. 32 DSGVO explizit genannt"

  # Verknüpfung zu OPC
  links:
    - href: "open_privacy_catalog_risk_v0.7.0.json#TOM-02"
      rel: "implements"
      text: "OPC: Verschlüsselung (Anforderung)"
```

### 4.2 Beispiel: SDM-NVK-51 (Pseudonymisieren) - Konsolidiert

```yaml
control:
  id: "SDM-NVK-51"
  title: "Pseudonymisieren und Anonymisieren"
  class: "technical"

  parts:
    - name: "statement"
      prose: |
        Die Organisation setzt Pseudonymisierungs- und Anonymisierungstechniken
        ein, um die direkte Identifizierbarkeit von Personen zu reduzieren oder
        aufzuheben.

    - name: "privacy-rationale"
      prose: |
        Pseudonymisierung und Anonymisierung sind zentrale Datenschutzmaßnahmen:

        - PSEUDONYMISIERUNG reduziert das Risiko bei Datenpannen, da die Zuordnung
          zu Personen erschwert wird (Art. 4 Nr. 5 DSGVO)
        - ANONYMISIERUNG hebt den Personenbezug vollständig auf, sodass die DSGVO
          nicht mehr anwendbar ist (Erwägungsgrund 26)

        Beide Techniken dienen dem Gewährleistungsziel NICHTVERKETTUNG und
        unterstützen die DATENMINIMIERUNG.

    - name: "implementation-levels"
      parts:
        - name: "baseline"
          prose: |
            - Ersetzung direkter Identifikatoren durch Pseudonyme
            - Getrennte Speicherung der Zuordnungstabelle
            - Zugriffsbeschränkung auf Zuordnungstabelle

        - name: "standard"
          prose: |
            - Tokenisierung für wiederkehrende Analysen
            - k-Anonymität (k ≥ 5) für Auswertungen
            - Differenzierte Zugriffe je nach Bedarf

        - name: "enhanced"
          prose: |
            - Differential Privacy für statistische Analysen
            - Secure Multi-Party Computation
            - Homomorphe Verschlüsselung für Berechnungen
            - Regelmäßige Re-Pseudonymisierung

  props:
    - name: "assurance-goals"
      value: "non-linkability, data-minimization"

    - name: "iso27701-mapping"
      value: "A.1.4.5, A.1.4.6"
      class: "framework-mapping"
      remarks: "PII minimization objectives, De-identification"

    - name: "iso27001-mapping"
      value: "A.8.11"
      class: "framework-mapping"
      remarks: "Data masking"

    - name: "bsi-mapping"
      value: "CON.2"
      class: "framework-mapping"
      remarks: "Datenschutz"

    - name: "moscow"
      value: "should"
      remarks: "Art. 25, 32 DSGVO empfohlen"

  links:
    - href: "open_privacy_catalog_risk_v0.7.0.json#TOM-03"
      rel: "implements"
      text: "OPC: Pseudonymisierung (Anforderung)"
    - href: "#SDM-ITV-60"
      rel: "related"
      text: "Anonymisierung kann Alternative zur Löschung sein"
```

---

## 5. Zusammenfassung: Neue SPC-Controls

### 5.1 Statistik

| Gruppe | Original SDM | Neue Controls | Gesamt |
|--------|--------------|---------------|--------|
| SDM-TRA | 3 | +2 | 5 |
| SDM-ITV | 3 | +2 | 5 |
| SDM-NVK | 1 | +3 | 4 |
| SDM-VCI | 2 | +6 | 8 |
| SDM-DMI | 0 (Referenz) | +4 | 4 |
| SDM-MGT | 3 | +2 | 5 |
| **Gesamt** | **12** | **+19** | **31** |

### 5.2 Nächste Schritte

1. **Review**: Prüfung der konsolidierten Struktur
2. **OSCAL-Implementierung**: JSON-Katalog erstellen
3. **OPC-Verlinkung**: Bidirektionale Links aktualisieren
4. **Validierung**: OSCAL-Schema-Konformität prüfen

---

## Anhang: Framework-Referenz-Übersicht

### A.1 ISO 27701:2025 Control-Referenzen im SPC

| ISO 27701 | SPC-Control | Beschreibung |
|-----------|-------------|--------------|
| A.1.4.2 | SDM-DMI-01 | Erhebung begrenzen |
| A.1.4.3 | SDM-DMI-02 | Verarbeitung begrenzen |
| A.1.4.4 | SDM-ITV-61 | Berichtigen |
| A.1.4.5 | SDM-NVK-51 | Pseudonymisieren |
| A.1.4.6 | SDM-NVK-51, SDM-ITV-60 | De-Identifizierung, Löschen |
| A.1.4.7 | SDM-ITV-60 | Temporäre Dateien löschen |
| A.1.4.8 | SDM-DMI-03 | Speicherdauer begrenzen |
| A.1.4.9 | SDM-ITV-60 | Sichere Entsorgung |
| A.1.4.10 | SDM-VCI-14 | Sicher übertragen |
| A.1.5.x | SDM-NVK-53 | Drittlandübermittlung |
| A.3.3 | SDM-MGT-01 | Policies |
| A.3.4 | SDM-MGT-01 | Rollen |
| A.3.5/6 | SDM-TRA-44 | Klassifizieren |
| A.3.7 | SDM-VCI-14 | Übertragung |
| A.3.8/9 | SDM-VCI-51 | Zugriffe |
| A.3.10 | SDM-NVK-52 | Lieferanten |
| A.3.11/12 | SDM-MGT-04 | Vorfälle |
| A.3.13 | SDM-MGT-05 | Compliance |
| A.3.14 | SDM-TRA-42 | Aufzeichnungen |
| A.3.15/16 | SDM-MGT-03 | Audit |
| A.3.17 | SDM-TRA-45 | Schulung |
| A.3.20/21 | SDM-VCI-16 | Medien |
| A.3.22 | SDM-VCI-15 | Endgeräte |
| A.3.23 | SDM-VCI-12 | Authentisieren |
| A.3.24 | SDM-VCI-11 | Backup |
| A.3.25 | SDM-TRA-43 | Logging |
| A.3.26 | SDM-VCI-13 | Verschlüsseln |
| A.3.27-29 | SDM-VCI-17 | Entwicklung |
| A.3.30 | SDM-NVK-52 | Ausgelagerte Entwicklung |
| A.3.31 | SDM-DMI-04 | Testdaten |

### A.2 BSI Baustein-Referenzen im SPC

| BSI Baustein | SPC-Control | Beschreibung |
|--------------|-------------|--------------|
| ISMS.1 | SDM-MGT-01 | Sicherheitsmanagement |
| ORP.1 | SDM-TRA-42 | Organisation |
| ORP.2/3 | SDM-TRA-45 | Schulung |
| ORP.4 | SDM-VCI-51, SDM-VCI-12 | Berechtigungen |
| ORP.5 | SDM-MGT-05 | Compliance |
| CON.1 | SDM-VCI-13 | Krypto |
| CON.2 | SDM-NVK-51, SDM-DMI-01/02 | Datenschutz |
| CON.3 | SDM-VCI-11 | Backup |
| CON.6 | SDM-ITV-60, SDM-VCI-16 | Löschen |
| CON.7 | SDM-VCI-15 | Reisen/Mobile |
| OPS.1.1.5 | SDM-TRA-43 | Protokollierung |
| OPS.1.1.6 | SDM-DMI-04 | Software-Tests |
| OPS.2.1/2.2 | SDM-NVK-52 | Outsourcing/Cloud |
| DER.2.1 | SDM-MGT-04 | Vorfälle |
| DER.3.1 | SDM-MGT-03 | Audits |

---

*Erstellt: 2026-02-05 | OpenGov Privacy Group*
