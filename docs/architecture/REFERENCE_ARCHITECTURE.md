# Referenzierungsarchitektur: OPC ↔ SPC ↔ Frameworks

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Architektur-Spezifikation

---

## Inhaltsverzeichnis

1. [Einleitung](#1-einleitung)
2. [Das Zwei-Katalog-Prinzip](#2-das-zwei-katalog-prinzip)
3. [Referenzierungsmatrix](#3-referenzierungsmatrix)
4. [OPC-Referenzierungen im Detail](#4-opc-referenzierungen-im-detail)
5. [SPC-Referenzierungen im Detail](#5-spc-referenzierungen-im-detail)
6. [ISO 27701 Sonderstellung](#6-iso-27701-sonderstellung)
7. [OSCAL-Implementierung](#7-oscal-implementierung)
8. [Anwendungsbeispiele](#8-anwendungsbeispiele)

---

## 1. Einleitung

### 1.1 Zweck dieses Dokuments

Dieses Dokument definiert die **Referenzierungsarchitektur** zwischen:
- **OPC** (Open Privacy Catalog) - Das Datenschutz-Kompendium
- **SPC** (SDM Privacy Catalog) - Der Maßnahmenkatalog
- **Externe Frameworks** - ISO 27701, ISO 27001, BSI Grundschutz, NIST, KRITIS-VO

### 1.2 Kernprinzip

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         REFERENZIERUNGS-PRINZIP                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   OPC referenziert auf ANFORDERUNGS-Frameworks:                                 │
│   → "WAS muss erfüllt werden?" (normativ, rechtlich, Governance)                │
│                                                                                  │
│   SPC referenziert auf MASSNAHMEN-Frameworks:                                   │
│   → "WIE wird es umgesetzt?" (technisch, organisatorisch, operativ)             │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Das Zwei-Katalog-Prinzip

### 2.1 Architekturübersicht

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         ZWEI-KATALOG-ARCHITEKTUR                                │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   ┌───────────────────────────────────────────────────────────────────────┐     │
│   │                    OPC (Open Privacy Catalog)                          │     │
│   │                                                                        │     │
│   │   Perspektive:    Betroffenen-zentriert, rechtlich-normativ           │     │
│   │   Fragestellung:  "WAS muss beachtet werden?"                         │     │
│   │   Zielgruppe:     DSB, DPO, Compliance, Management                    │     │
│   │                                                                        │     │
│   │   Attribute:                                                           │     │
│   │   ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐       │     │
│   │   │ Reifegrad       │  │ Risiko bei      │  │ Modalverb       │       │     │
│   │   │ (1-5, CNIL)     │  │ Nichtbeachtung  │  │ (MUSS/SOLLTE)   │       │     │
│   │   └─────────────────┘  └─────────────────┘  └─────────────────┘       │     │
│   │                                                                        │     │
│   │   Gruppen: GOV | ACC | LAW | DSR | REG | TOM | DPIA | OPS | XFER | INC │     │
│   │                                                                        │     │
│   └────────────────────────────────┬──────────────────────────────────────┘     │
│                                    │                                            │
│                                    │ links: rel="implements"                    │
│                                    │        rel="related-control"               │
│                                    ▼                                            │
│   ┌───────────────────────────────────────────────────────────────────────┐     │
│   │                    SPC (SDM Privacy Catalog)                           │     │
│   │                                                                        │     │
│   │   Perspektive:    Umsetzungs-zentriert, technisch-organisatorisch     │     │
│   │   Fragestellung:  "WIE wird es umgesetzt?"                            │     │
│   │   Zielgruppe:     IT-Security, ISB, Entwicklung, Betrieb              │     │
│   │                                                                        │     │
│   │   Attribute:                                                           │     │
│   │   ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐       │     │
│   │   │ Schutzniveau    │  │ Eintritts-      │  │ MoSCoW          │       │     │
│   │   │ (baseline/      │  │ wahrschein-     │  │ (Must/Should/   │       │     │
│   │   │ standard/enh.)  │  │ lichkeit        │  │ Could/Won't)    │       │     │
│   │   └─────────────────┘  └─────────────────┘  └─────────────────┘       │     │
│   │                                                                        │     │
│   │   Gruppen: SDM-TRA | SDM-ITV | SDM-NVK | SDM-VCI | SDM-DMI | SDM-MGT  │     │
│   │                                                                        │     │
│   └───────────────────────────────────────────────────────────────────────┘     │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Abgrenzung der Kataloge

| Aspekt | OPC (Kompendium) | SPC (Maßnahmenkatalog) |
|--------|------------------|------------------------|
| **Fokus** | Anforderungen | Umsetzung |
| **Frage** | "Was ist zu tun?" | "Wie wird es gemacht?" |
| **Perspektive** | Betroffene, Recht | Technik, Organisation |
| **Detailgrad** | Prinzipien, Ziele | Konkrete Maßnahmen |
| **Prüfung** | Compliance-Check | Audit, Penetration |
| **Lebenszyklus** | Stabil (gesetzlich) | Dynamisch (State of Art) |

---

## 3. Referenzierungsmatrix

### 3.1 Framework-Zuordnung

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    REFERENZIERUNGS-MATRIX                                       │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│                              OPC                    SPC                         │
│   Framework                  (Kompendium)           (Maßnahmen)                 │
│   ─────────────────────────────────────────────────────────────────────────     │
│                                                                                  │
│   DSGVO                      ████████████████       ░░░░░░░░░░░░░░░░            │
│   (Art. 5-49)                Rechtsgrundlage        -                           │
│                                                                                  │
│   ISO 27701 Kl. 4-10         ████████████████       ░░░░░░░░░░░░░░░░            │
│   (PIMS Management)          PIMS-Anforderungen     -                           │
│                                                                                  │
│   ISO 27701 A.1.2            ████████████████       ░░░░░░░░░░░░░░░░            │
│   (Bedingungen)              Anforderungen          -                           │
│                                                                                  │
│   ISO 27701 A.1.3            ████████████████       ░░░░░░░░░░░░░░░░            │
│   (Betroffenenrechte)        Anforderungen          -                           │
│                                                                                  │
│   ISO 27701 A.1.4            ████████                ████████████████           │
│   (Privacy by Design)        Prinzipien             Maßnahmen                   │
│                                                                                  │
│   ISO 27701 A.3              ░░░░░░░░░░░░░░░░       ████████████████            │
│   (Security Controls)        -                      Maßnahmen                   │
│                                                                                  │
│   ISO 27001 Annex A          ░░░░░░░░░░░░░░░░       ████████████████            │
│   (Security Controls)        -                      Maßnahmen                   │
│                                                                                  │
│   BSI Methodik GC.*          ████████████████       ░░░░░░░░░░░░░░░░            │
│   (Governance Controls)      Prinzipien             -                           │
│                                                                                  │
│   BSI Bausteine ORP/CON/OPS  ░░░░░░░░░░░░░░░░       ████████████████            │
│   (Technische Maßnahmen)     -                      Maßnahmen                   │
│                                                                                  │
│   NIST SP 800-53             ░░░░░░░░░░░░░░░░       ████████████████            │
│   (Security Controls)        -                      Maßnahmen                   │
│                                                                                  │
│   KRITIS-VO                  ░░░░░░░░░░░░░░░░       ████████████████            │
│   (Resilienzanforderungen)   -                      Maßnahmen                   │
│                                                                                  │
│   CNIL/DSK Leitlinien        ████████████████       ░░░░░░░░░░░░░░░░            │
│   (Aufsichtsbehörden)        Reifegrad-Modell       -                           │
│                                                                                  │
│   ─────────────────────────────────────────────────────────────────────────     │
│   Legende:  ████ = Primäre Referenz    ░░░░ = Keine/Indirekte Referenz         │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Tabellarische Übersicht

| Framework | OPC referenziert | SPC referenziert | Sinn & Zweck |
|-----------|------------------|------------------|--------------|
| **DSGVO Art. 5-49** | Ja (legal-property) | Nein | Rechtsgrundlage für alle Anforderungen |
| **ISO 27701 Kl. 4-10** | Ja | Nein | PIMS Management-Anforderungen |
| **ISO 27701 A.1.2** | Ja | Nein | Bedingungen für Verarbeitung |
| **ISO 27701 A.1.3** | Ja | Nein | Betroffenenrechte (Gap zu BSI!) |
| **ISO 27701 A.1.4** | Prinzipien | Maßnahmen | Privacy by Design (beide!) |
| **ISO 27701 A.3** | Nein | Ja | Security Controls für PII |
| **ISO 27001 Annex A** | Nein | Ja | Security-Maßnahmen |
| **BSI GC.*** | Ja | Nein | Governance-Prinzipien |
| **BSI ORP/CON/OPS** | Nein | Ja | Technische Bausteine |
| **NIST SP 800-53** | Nein | Ja | Resilience Controls |
| **KRITIS-VO** | Nein | Ja | Kritische Infrastruktur |
| **CNIL/DSK** | Ja | Nein | Reifegrad-Modell, Leitlinien |

---

## 4. OPC-Referenzierungen im Detail

### 4.1 Struktur der OPC-Referenzen

```json
{
  "id": "DSR-02",
  "title": "Auskunftsrecht",
  "props": [
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-15",
      "class": "proof",
      "remarks": "Art. 15 DSGVO - Auskunftsrecht"
    },
    {
      "name": "iso27701-mapping",
      "value": "A.1.3.7, A.1.3.9, A.1.3.10",
      "class": "framework-mapping",
      "remarks": "Access, Copy, Handling Requests"
    },
    {
      "name": "bsi-methodik-mapping",
      "value": "GC.7.1",
      "class": "framework-mapping",
      "remarks": "Vorgehensweisen dokumentieren (indirekt)"
    },
    {
      "name": "assurance_goal",
      "value": "intervenability",
      "class": "sdm-goal",
      "remarks": "Intervenierbarkeit"
    }
  ],
  "links": [
    {
      "href": "sdm_privacy_catalog_v1.0.0.json#SDM-ITV-01",
      "rel": "implements",
      "text": "SDM: Auskunftsmechanismus implementieren"
    }
  ]
}
```

### 4.2 OPC-Referenzierungszwecke

| Referenz-Typ | Zweck | Beispiel |
|--------------|-------|----------|
| **legal** | Rechtsgrundlage nachweisen | `EU:REG:GDPR:ART-15` |
| **iso27701-mapping** | Internationale Compliance zeigen | `A.1.3.7` |
| **bsi-methodik-mapping** | Governance-Äquivalenz | `GC.4.1` |
| **assurance_goal** | SDM-Gewährleistungsziel | `intervenability` |
| **cnil-reference** | Aufsichtsbehörden-Leitlinie | `CNIL-PIA-Guide` |

### 4.3 OPC → ISO 27701 Mapping (Anforderungsniveau)

| OPC-Gruppe | ISO 27701 Referenz | Coverage | Begründung |
|------------|-------------------|----------|------------|
| **GOV** | Kl. 5.1-5.3 | 85% | Führung, Policy, Rollen |
| **ACC** | Kl. 7.5, 9.1-9.3 | 90% | Dokumentation, Bewertung |
| **LAW** | A.1.2.2-A.1.2.5 | 95% | Zweck, Rechtsgrundlage, Einwilligung |
| **DSR** | **A.1.3.2-A.1.3.11** | **95%** | Betroffenenrechte (kritisch!) |
| **REG** | A.1.2.9, A.2.2.7 | 90% | Records of Processing |
| **TOM** | Kl. 6 (Planung) | 60% | Nur Planungsaspekte |
| **DPIA** | A.1.2.6, Kl. 6.1.2 | 95% | Privacy Impact Assessment |
| **OPS** | Kl. 8, A.1.2.7 | 85% | Betrieb, Processor-Verträge |
| **XFER** | A.1.5.2-A.1.5.5 | 92% | Transfer-Anforderungen |
| **INC** | Kl. 10.2 | 60% | Korrekturmaßnahmen |

---

## 5. SPC-Referenzierungen im Detail

### 5.1 Struktur der SPC-Referenzen

```json
{
  "id": "SDM-ITV-01",
  "title": "Auskunftsmechanismus implementieren",
  "props": [
    {
      "name": "schutzniveau",
      "value": "standard",
      "remarks": "Für normale personenbezogene Daten"
    },
    {
      "name": "eintrittswahrscheinlichkeit",
      "value": "medium",
      "remarks": "Auskunftsanfragen sind häufig"
    },
    {
      "name": "moscow",
      "value": "must",
      "remarks": "Gesetzliche Pflicht"
    },
    {
      "name": "iso27701-mapping",
      "value": "A.1.3.9, A.3.9",
      "class": "framework-mapping",
      "remarks": "Copy of PII, Access Rights"
    },
    {
      "name": "iso27001-mapping",
      "value": "A.5.15, A.8.3",
      "class": "framework-mapping",
      "remarks": "Access Control, Information Access"
    },
    {
      "name": "bsi-mapping",
      "value": "ORP.4, APP.4.3",
      "class": "framework-mapping",
      "remarks": "Identitätsmanagement, Datenbanken"
    },
    {
      "name": "nist-mapping",
      "value": "AC-2, AC-3",
      "class": "framework-mapping",
      "remarks": "Account Management, Access Enforcement"
    }
  ],
  "links": [
    {
      "href": "open_privacy_catalog_risk_v0.7.0.json#DSR-02",
      "rel": "implements",
      "text": "OPC: Auskunftsrecht (Anforderung)"
    }
  ]
}
```

### 5.2 SPC-Referenzierungszwecke

| Referenz-Typ | Zweck | Beispiel |
|--------------|-------|----------|
| **iso27701-mapping** | Privacy-Maßnahmen-Äquivalenz | `A.1.4.5, A.3.26` |
| **iso27001-mapping** | Security-Baseline zeigen | `A.8.10, A.8.24` |
| **bsi-mapping** | IT-Grundschutz-Kompatibilität | `ORP.4, CON.2` |
| **nist-mapping** | US/Internationale Äquivalenz | `AC-2, SC-13` |
| **kritis-mapping** | KRITIS-Compliance | `§8a BSIG` |

### 5.3 SPC → Framework Mapping (Maßnahmenniveau)

| SPC-Gruppe | ISO 27701 | ISO 27001 | BSI Bausteine | NIST |
|------------|-----------|-----------|---------------|------|
| **SDM-TRA** | A.1.3.3-4 | A.5.37 | - | - |
| **SDM-ITV** | A.1.3.5-11 | A.5.15 | ORP.4 | AC-2/3 |
| **SDM-NVK** | A.1.4.5-6 | - | - | - |
| **SDM-VCI** | A.3.24-26 | A.8.13-15 | CON.3, OPS.1.1.5 | CP-9, AU-2 |
| **SDM-DMI** | A.1.4.2-3 | A.8.10 | CON.2 | - |
| **SDM-MGT** | A.3.3-4 | A.5.1-2 | ISMS.1 | PL-1 |

---

## 6. ISO 27701 Sonderstellung

### 6.1 Warum ISO 27701 zweigeteilt referenziert wird

ISO 27701 ist das **einzige Framework**, das **beide Kataloge** referenzieren:

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    ISO 27701:2025 - DUALE REFERENZIERUNG                        │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   ISO 27701:2025                                                                │
│   │                                                                             │
│   │                                                                             │
│   ├─── ANFORDERUNGS-TEIL (OPC referenziert) ────────────────────────────────   │
│   │    │                                                                        │
│   │    ├── Klauseln 4-10: PIMS Management-System                               │
│   │    │   • Kl. 4: Kontext → OPC-GOV (Rollen definieren)                      │
│   │    │   • Kl. 5: Führung → OPC-GOV (Management-Commitment)                  │
│   │    │   • Kl. 6: Planung → OPC-DPIA (Risikobewertung)                       │
│   │    │   • Kl. 7: Unterstützung → OPC-ACC, OPC-TRAIN                         │
│   │    │   • Kl. 8: Betrieb → OPC-OPS                                          │
│   │    │   • Kl. 9: Leistung → OPC-ACC (Überprüfung)                           │
│   │    │   • Kl. 10: Verbesserung → OPC-ACC                                    │
│   │    │                                                                        │
│   │    ├── A.1.2: Bedingungen für Erhebung/Verarbeitung                        │
│   │    │   • A.1.2.2: Zweckbindung → OPC-LAW-02                                │
│   │    │   • A.1.2.3: Rechtsgrundlage → OPC-LAW-01                             │
│   │    │   • A.1.2.4/5: Einwilligung → OPC-LAW-04                              │
│   │    │   • A.1.2.6: DSFA → OPC-DPIA-02                                       │
│   │    │   • A.1.2.7: Auftragsverarbeitung → OPC-OPS-01                        │
│   │    │   • A.1.2.9: Verarbeitungsverzeichnis → OPC-REG-01                    │
│   │    │                                                                        │
│   │    └── A.1.3: Pflichten gegenüber Betroffenen (KRITISCH!)                  │
│   │        • A.1.3.3/4: Informationspflichten → OPC-DSR-01                     │
│   │        • A.1.3.5: Einwilligungswiderruf → OPC-LAW-04                       │
│   │        • A.1.3.6: Widerspruchsrecht → OPC-DSR-06                           │
│   │        • A.1.3.7: Auskunft/Berichtigung/Löschung → OPC-DSR-02/03          │
│   │        • A.1.3.9: Kopie → OPC-DSR-05                                       │
│   │        • A.1.3.10: Anfragenbearbeitung → OPC-DSR-02                        │
│   │        • A.1.3.11: Automatisierte Entscheidung → OPC-DSR-06               │
│   │                                                                             │
│   │                                                                             │
│   ├─── MASSNAHMEN-TEIL (SPC referenziert) ──────────────────────────────────   │
│   │    │                                                                        │
│   │    ├── A.1.4: Privacy by Design & Default                                  │
│   │    │   • A.1.4.2: Erhebung begrenzen → SPC-SDM-DMI-*                       │
│   │    │   • A.1.4.3: Verarbeitung begrenzen → SPC-SDM-DMI-*                   │
│   │    │   • A.1.4.5: Minimierungsziele → SPC-SDM-DMI-*                        │
│   │    │   • A.1.4.6: De-Identifizierung → SPC-SDM-NVK-*                       │
│   │    │   • A.1.4.8: Aufbewahrung → SPC-SDM-TOM-LC-*                          │
│   │    │   • A.1.4.9: Entsorgung → SPC-SDM-TOM-DEL-*                           │
│   │    │   • A.1.4.10: Übertragungskontrollen → SPC-SDM-VCI-*                  │
│   │    │                                                                        │
│   │    ├── A.2: Processor-Controls (analog zu A.1)                             │
│   │    │                                                                        │
│   │    └── A.3: Security Controls für PII                                      │
│   │        • A.3.8: Identitätsmanagement → SPC-SDM-TOM-AC-*                    │
│   │        • A.3.9: Zugriffsrechte → SPC-SDM-TOM-AC-*                          │
│   │        • A.3.23: Authentifizierung → SPC-SDM-VCI-*                         │
│   │        • A.3.24: Backup → SPC-SDM-VCI-*                                    │
│   │        • A.3.25: Logging → SPC-SDM-TOM-LG-*                                │
│   │        • A.3.26: Kryptographie → SPC-SDM-VCI-*                             │
│   │                                                                             │
│   │                                                                             │
│   └─── GRENZFALL: A.1.5 / A.2.5 (Transfer) ─────────────────────────────────   │
│        │                                                                        │
│        ├── Anforderung (OPC): "Drittlandübermittlung braucht Rechtsgrundlage"  │
│        │   → OPC-XFER-01, OPC-XFER-02                                          │
│        │                                                                        │
│        └── Maßnahme (SPC): "SCCs implementieren, TIA durchführen"              │
│            → SPC-SDM-XFER-*                                                    │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Sinn & Zweck der ISO 27701-Referenzierung

| Katalog | ISO 27701-Teil | Sinn & Zweck |
|---------|----------------|--------------|
| **OPC** | Kl. 4-10, A.1.2, A.1.3 | **Internationale Compliance-Anerkennung**: Zeigt, dass OPC-Anforderungen ISO-konform sind. **Kritisch**: A.1.3 schließt den BSI-Gap bei Betroffenenrechten (95% vs. 0%). |
| **SPC** | A.1.4, A.3 | **Technische Äquivalenz**: SPC-Maßnahmen sind mit ISO 27001/27701 auditierbar. Ermöglicht Integration in bestehende ISMS-Audits. |

### 6.3 Vergleich: ISO 27701 vs. andere Frameworks

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    FRAMEWORK-VERGLEICH FÜR OPC/SPC                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   OPC-Referenzierung (Anforderungen)                                            │
│   ──────────────────────────────────                                            │
│                                                                                  │
│   Framework          DSR-Coverage    LAW-Coverage    Eignung für OPC            │
│   ─────────────────────────────────────────────────────────────────────         │
│   DSGVO              100%            100%            ████████████████ Basis     │
│   ISO 27701          95%             95%             ████████████████ Optimal   │
│   BSI Methodik       0%              40%             ████████         Ergänzend │
│   ISO 27001          0%              60%             ████             Gering    │
│                                                                                  │
│                                                                                  │
│   SPC-Referenzierung (Maßnahmen)                                                │
│   ──────────────────────────────                                                │
│                                                                                  │
│   Framework          TOM-Coverage    VCI-Coverage    Eignung für SPC            │
│   ─────────────────────────────────────────────────────────────────────         │
│   ISO 27001          85%             90%             ████████████████ Optimal   │
│   BSI Bausteine      90%             85%             ████████████████ Optimal   │
│   ISO 27701 A.3/A.1.4 80%            85%             ████████████     Gut       │
│   NIST SP 800-53     85%             90%             ████████████     Gut       │
│   KRITIS-VO          60%             70%             ████████         Ergänzend │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. OSCAL-Implementierung

### 7.1 Property-Schema für Referenzen

#### OPC-Properties (props)

```json
{
  "props": [
    {
      "name": "legal",
      "value": "EU:REG:GDPR:ART-15",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "proof",
      "group": "reference",
      "remarks": "Art. 15 DS-GVO"
    },
    {
      "name": "iso27701-mapping",
      "value": "A.1.3.7",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "ISO 27701:2025 - Access, correction or erasure"
    },
    {
      "name": "bsi-methodik-mapping",
      "value": "GC.4.1",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "BSI Grundschutz++ Methodik - Rollen und Zuständigkeiten"
    }
  ]
}
```

#### SPC-Properties (props)

```json
{
  "props": [
    {
      "name": "iso27701-mapping",
      "value": "A.3.9",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "ISO 27701:2025 - Access rights"
    },
    {
      "name": "iso27001-mapping",
      "value": "A.5.15",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "ISO 27001:2022 - Access control"
    },
    {
      "name": "bsi-baustein-mapping",
      "value": "ORP.4",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "BSI IT-Grundschutz - Identitäts- und Berechtigungsmanagement"
    },
    {
      "name": "nist-mapping",
      "value": "AC-2",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "class": "framework-mapping",
      "remarks": "NIST SP 800-53 - Account Management"
    }
  ]
}
```

### 7.2 Links-Schema für Katalog-Verbindung

```json
{
  "links": [
    {
      "href": "sdm_privacy_catalog_v1.0.0.json#SDM-ITV-01",
      "rel": "implements",
      "text": "SDM: Auskunftsmechanismus implementieren"
    },
    {
      "href": "#DSR-03",
      "rel": "related",
      "text": "Verwandt: Berichtigung und Löschung"
    }
  ]
}
```

### 7.3 Mapping-Datei-Struktur

Separate Mapping-Dateien in `oscal/mappings/`:

| Datei | Inhalt | Richtung |
|-------|--------|----------|
| `opengov_privacy_to_iso27701.json` | OPC ↔ ISO 27701 | Bidirektional |
| `opengov_privacy_to_bsi_grundschutz.json` | OPC ↔ BSI Methodik | Bidirektional |
| `sdm_privacy_to_iso27001.json` | SPC ↔ ISO 27001 | Bidirektional |
| `sdm_privacy_to_bsi_bausteine.json` | SPC ↔ BSI Bausteine | Bidirektional |

---

## 8. Anwendungsbeispiele

### 8.1 Beispiel: DSR-02 (Auskunftsrecht) - Vollständiger Referenzfluss

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    REFERENZFLUSS: AUSKUNFTSRECHT                                │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   RECHTSGRUNDLAGE                                                               │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  DSGVO Art. 15: "Die betroffene Person hat das Recht, von dem           │   │
│   │  Verantwortlichen eine Bestätigung darüber zu verlangen, ob sie         │   │
│   │  betreffende personenbezogene Daten verarbeitet werden..."              │   │
│   └─────────────────────────────────┬───────────────────────────────────────┘   │
│                                     │                                           │
│                                     ▼                                           │
│   OPC (Kompendium)                                                              │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  DSR-02: Auskunftsrecht                                                 │   │
│   │                                                                          │   │
│   │  props:                                                                  │   │
│   │  ├── legal: "EU:REG:GDPR:ART-15"                                        │   │
│   │  ├── iso27701-mapping: "A.1.3.7, A.1.3.9, A.1.3.10"                    │   │
│   │  ├── bsi-methodik-mapping: "-" (kein Äquivalent!)                       │   │
│   │  ├── reifegrad: target-maturity="3"                                     │   │
│   │  └── assurance_goal: "intervenability"                                  │   │
│   │                                                                          │   │
│   │  Anforderung: "Die Organisation muss auf Anfrage einer betroffenen      │   │
│   │  Person Auskunft über die sie betreffenden Daten erteilen."             │   │
│   └─────────────────────────────────┬───────────────────────────────────────┘   │
│                                     │                                           │
│                                     │ links: rel="implements"                   │
│                                     ▼                                           │
│   SPC (Maßnahmenkatalog)                                                        │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  SDM-ITV-01: Auskunftsmechanismus implementieren                        │   │
│   │                                                                          │   │
│   │  props:                                                                  │   │
│   │  ├── schutzniveau: "standard"                                           │   │
│   │  ├── eintrittswahrscheinlichkeit: "medium"                              │   │
│   │  ├── moscow: "must"                                                     │   │
│   │  ├── iso27701-mapping: "A.3.9" (Access rights)                         │   │
│   │  ├── iso27001-mapping: "A.5.15" (Access control)                       │   │
│   │  └── bsi-baustein-mapping: "ORP.4" (Berechtigungsmanagement)           │   │
│   │                                                                          │   │
│   │  Maßnahme: "Implementierung eines Self-Service-Portals oder             │   │
│   │  definierten Prozesses zur Beantwortung von Auskunftsanfragen           │   │
│   │  innerhalb der gesetzlichen Frist von 1 Monat."                         │   │
│   │                                                                          │   │
│   │  Technische Umsetzung:                                                  │   │
│   │  ├── Datenexport-Funktion in Anwendungen                               │   │
│   │  ├── Identitätsprüfung vor Auskunftserteilung                          │   │
│   │  ├── Protokollierung aller Auskunftsanfragen                           │   │
│   │  └── Fristenmanagement (30 Tage)                                       │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 8.2 Beispiel: TOM-02 (Verschlüsselung) - Technische Maßnahme

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                    REFERENZFLUSS: VERSCHLÜSSELUNG                               │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   RECHTSGRUNDLAGE                                                               │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  DSGVO Art. 32 Abs. 1 lit. a: "...die Pseudonymisierung und             │   │
│   │  Verschlüsselung personenbezogener Daten..."                            │   │
│   └─────────────────────────────────┬───────────────────────────────────────┘   │
│                                     │                                           │
│                                     ▼                                           │
│   OPC (Kompendium)                                                              │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  TOM-02: Verschlüsselung                                                │   │
│   │                                                                          │   │
│   │  props:                                                                  │   │
│   │  ├── legal: "EU:REG:GDPR:ART-32_ABS-1_LIT-A"                           │   │
│   │  ├── iso27701-mapping: "A.1.4.10" (Transmission controls)              │   │
│   │  ├── bsi-methodik-mapping: "GC.7.4" (Risikoanalyse)                    │   │
│   │  └── assurance_goal: "confidentiality, integrity"                       │   │
│   │                                                                          │   │
│   │  Anforderung: "Die Organisation muss personenbezogene Daten             │   │
│   │  angemessen verschlüsseln (at rest und in transit)."                    │   │
│   └─────────────────────────────────┬───────────────────────────────────────┘   │
│                                     │                                           │
│                                     │ links: rel="implements"                   │
│                                     ▼                                           │
│   SPC (Maßnahmenkatalog)                                                        │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │  SDM-VCI-CRYPT-01: Verschlüsselung implementieren                       │   │
│   │                                                                          │   │
│   │  props:                                                                  │   │
│   │  ├── schutzniveau: "standard" / "enhanced"                              │   │
│   │  ├── moscow: "must"                                                     │   │
│   │  ├── iso27701-mapping: "A.3.26" (Use of cryptography)                  │   │
│   │  ├── iso27001-mapping: "A.8.24" (Use of cryptography)                  │   │
│   │  ├── bsi-baustein-mapping: "CON.1" (Kryptokonzept)                     │   │
│   │  └── nist-mapping: "SC-13" (Cryptographic Protection)                  │   │
│   │                                                                          │   │
│   │  Maßnahmen nach Schutzniveau:                                           │   │
│   │  ├── baseline: TLS 1.2+ für Transit, AES-128 für Rest                  │   │
│   │  ├── standard: TLS 1.3, AES-256, Key Management                        │   │
│   │  └── enhanced: HSM, Post-Quantum-Ready, E2E-Encryption                 │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Anhang A: Referenz-Property-Namenskonventionen

### A.1 OPC-Properties (Anforderungsniveau)

| Property-Name | Namespace | Zweck | Beispielwert |
|---------------|-----------|-------|--------------|
| `legal` | `de` | DSGVO-Artikel | `EU:REG:GDPR:ART-15` |
| `iso27701-mapping` | `https://open-gov-group.org/oscal/privacy` | ISO 27701 Klauseln/A.1.x | `A.1.3.7` |
| `bsi-methodik-mapping` | `https://open-gov-group.org/oscal/privacy` | BSI GC.* Controls | `GC.4.1` |
| `cnil-reference` | `https://open-gov-group.org/oscal/privacy` | CNIL-Leitlinien | `CNIL-PIA-2018` |
| `assurance_goal` | `de` | SDM-Gewährleistungsziel | `intervenability` |

### A.2 SPC-Properties (Maßnahmenniveau)

| Property-Name | Namespace | Zweck | Beispielwert |
|---------------|-----------|-------|--------------|
| `iso27701-mapping` | `https://open-gov-group.org/oscal/privacy` | ISO 27701 A.1.4/A.3 | `A.3.26` |
| `iso27001-mapping` | `https://open-gov-group.org/oscal/privacy` | ISO 27001 Annex A | `A.8.24` |
| `bsi-baustein-mapping` | `https://open-gov-group.org/oscal/privacy` | BSI Bausteine | `CON.1, ORP.4` |
| `nist-mapping` | `https://open-gov-group.org/oscal/privacy` | NIST SP 800-53 | `SC-13` |
| `kritis-mapping` | `https://open-gov-group.org/oscal/privacy` | KRITIS-VO | `§8a BSIG` |
| `schutzniveau` | `https://open-gov-group.org/oscal/privacy` | SDM Protection Level | `baseline/standard/enhanced` |
| `moscow` | `https://open-gov-group.org/oscal/privacy` | Umsetzungspriorität | `must/should/could/wont` |

---

## Anhang B: Mapping-Dateien Übersicht

| Datei | Beschreibung | Stand |
|-------|--------------|-------|
| `opengov_privacy_to_iso27701.json` | OPC ↔ ISO 27701:2025 | v1.0.0 (2026-02-05) |
| `opengov_privacy_to_bsi_grundschutz.json` | OPC ↔ BSI Methodik | v1.0.0 (2026-02-05) |
| `sdm_privacy_to_security.json` | SPC ↔ Resilience Baseline | v0.1.0-draft |

---

*Erstellt: 2026-02-05 | OpenGov Privacy Group*
