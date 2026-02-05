# Gruppierungsanalyse: OPC ↔ SDM ↔ BSI ↔ ISO

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Analyse-Dokument
**Verantwortlich**: Architecture Team

---

## Inhaltsverzeichnis

1. [Zusammenfassung](#1-zusammenfassung)
2. [Framework-Strukturen im Überblick](#2-framework-strukturen-im-überblick)
3. [OPC-Gruppen → SDM-Gewährleistungsziele](#3-opc-gruppen--sdm-gewährleistungsziele)
4. [OPC-Gruppen → BSI Grundschutz++](#4-opc-gruppen--bsi-grundschutz)
5. [OPC-Gruppen → ISO 27001:2022](#5-opc-gruppen--iso-270012022)
6. [OPC-Gruppen → ISO 27701:2019/2025](#6-opc-gruppen--iso-2770120192025)
7. [Integrierte Mapping-Matrix](#7-integrierte-mapping-matrix)
8. [Gap-Analyse](#8-gap-analyse)
9. [Empfehlungen für SDM-Gliederung](#9-empfehlungen-für-sdm-gliederung)
10. [Referenzen](#10-referenzen)

---

## 1. Zusammenfassung

Diese Analyse untersucht die Gruppierungsstruktur des **Open Privacy Catalogs (OPC)** und deren Verknüpfungen zu:

| Framework | Struktur | Fokus |
|-----------|----------|-------|
| **SDM** (Standard-Datenschutzmodell) | 7 Gewährleistungsziele + 9 Bausteine | Betroffenen-Perspektive |
| **BSI Grundschutz++** | 7 GC-Gruppen (GC.1-GC.7) | Organisations-/ISMS-Perspektive |
| **ISO 27001:2022** | 4 Control-Kategorien (93 Controls) | Informationssicherheit |
| **ISO 27701:2019/2025** | Clause 7/8 + Annex A/B | Privacy Information Management |

### Kernerkenntnisse

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MAPPING-ÜBERSICHT                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OPC (11 Gruppen)                                                          │
│   ════════════════                                                          │
│   │                                                                         │
│   ├── GOV ──────► SDM: Transparenz, Intervenierbarkeit                     │
│   │              BSI: GC.4, GC.5 (80%)                                      │
│   │              ISO: A.5 Organizational (Policies)                         │
│   │              27701: 7.2 Conditions for collection                       │
│   │                                                                         │
│   ├── ACC ──────► SDM: Transparenz (Dokumentieren)                         │
│   │              BSI: GC.1, GC.7 (70%)                                      │
│   │              ISO: A.5 Organizational (Documentation)                    │
│   │              27701: 5.2 PIMS-specific requirements                      │
│   │                                                                         │
│   ├── LAW ──────► SDM: Alle (Rechtsgrundlage für alles)                    │
│   │              BSI: GC.2 (40%) - nur Kontext                              │
│   │              ISO: A.5.31-34 Legal compliance                            │
│   │              27701: 7.2.1 Legal basis identification                    │
│   │                                                                         │
│   ├── DSR ──────► SDM: Intervenierbarkeit (primär)                         │
│   │              BSI: KEIN ÄQUIVALENT (0%)                                  │
│   │              ISO: KEIN ÄQUIVALENT                                       │
│   │              27701: 7.3 Data subject rights (Annex A.7.3)               │
│   │                                                                         │
│   ├── REG ──────► SDM: Transparenz (Dokumentieren)                         │
│   │              BSI: GC.3 (50%)                                            │
│   │              ISO: A.5.9-14 Asset management                             │
│   │              27701: 7.2.8 Records of processing                         │
│   │                                                                         │
│   ├── TOM ──────► SDM: Verfügbarkeit, Integrität, Vertraulichkeit          │
│   │              BSI: ORP, CON, OPS Bausteine (85%)                         │
│   │              ISO: A.7 Physical, A.8 Technological                       │
│   │              27701: 6.9-6.15 Security controls                          │
│   │                                                                         │
│   ├── DPIA ─────► SDM: Alle (Risikobewertung)                              │
│   │              BSI: GC.7.4-7.6 (60%)                                      │
│   │              ISO: A.5.8 Risk assessment                                 │
│   │              27701: 7.2.5 Privacy impact assessment                     │
│   │                                                                         │
│   ├── OPS ──────► SDM: Alle (Betriebsebene)                                │
│   │              BSI: GC.7 (75%)                                            │
│   │              ISO: A.5.1-37 Operational procedures                       │
│   │              27701: 6.1-6.8 Operational controls                        │
│   │                                                                         │
│   ├── XFER ─────► SDM: Vertraulichkeit, Nichtverkettung                    │
│   │              BSI: GC.3.2 (30%)                                          │
│   │              ISO: A.5.19-23 Supplier relations                          │
│   │              27701: 7.5 International transfers (Annex A.7.5)           │
│   │                                                                         │
│   ├── INC ──────► SDM: Transparenz, Intervenierbarkeit                     │
│   │              BSI: DER-Bausteine (70%)                                   │
│   │              ISO: A.5.24-28 Incident management                         │
│   │              27701: 6.13 Incident management                            │
│   │                                                                         │
│   └── TRAIN ────► SDM: Transparenz                                         │
│                  BSI: GC.4.4 (equivalent)                                   │
│                  ISO: A.6 People controls                                   │
│                  27701: 6.4 Human resources                                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Framework-Strukturen im Überblick

### 2.1 OPC - Open Privacy Catalog (11 Gruppen)

| Gruppe | ID | Beschreibung | DSGVO-Artikel |
|--------|-----|--------------|---------------|
| Governance & Organisation | GOV | Datenschutz-Organisation | Art. 5(2), 24, 37-39 |
| Rechenschaft & Dokumentation | ACC | Nachweisführung, DSMS | Art. 5(2), 30 |
| Rechtsgrundlagen | LAW | Rechtmäßigkeit, Zweckbindung | Art. 5-11 |
| Betroffenenrechte | DSR | Auskunft, Löschung, etc. | Art. 12-22 |
| Verarbeitungsverzeichnis | REG | VVT, Datenflüsse | Art. 30 |
| Technisch-Organisatorische Maßnahmen | TOM | Sicherheitsmaßnahmen | Art. 32 |
| Datenschutz-Folgenabschätzung | DPIA | Risikoanalyse | Art. 35-36 |
| Betriebsprozesse | OPS | Change, Release, Operations | Art. 24, 25 |
| Datenübermittlung | XFER | Drittland, AV | Art. 44-49, 28 |
| Vorfälle & Meldungen | INC | Data Breach | Art. 33-34 |
| Schulung & Awareness | TRAIN | Kompetenzentwicklung | Art. 39(1)b |

### 2.2 SDM - Standard-Datenschutzmodell

#### 2.2.1 Gewährleistungsziele (7)

| Gewährleistungsziel | Abkürzung | DSGVO-Grundlage | Beschreibung |
|---------------------|-----------|-----------------|--------------|
| Verfügbarkeit | VER | Art. 32(1)b | Zugriff auf Daten sichergestellt |
| Integrität | INT | Art. 32(1)b | Unversehrtheit der Daten |
| Vertraulichkeit | VRT | Art. 32(1)b | Schutz vor unbefugtem Zugriff |
| Transparenz | TRA | Art. 5(1)a, 12-14 | Nachvollziehbarkeit |
| Intervenierbarkeit | ITV | Art. 15-22 | Betroffenenrechte ausübbar |
| Nichtverkettung | NVK | Art. 5(1)b,c | Zweckbindung technisch umgesetzt |
| Datenminimierung | DMI | Art. 5(1)c | Erforderlichkeitsprinzip |

#### 2.2.2 SDM-Bausteine (9)

| Nr. | Baustein | Zugeordnete Gewährleistungsziele |
|-----|----------|----------------------------------|
| 11 | Aufbewahren | VER, INT, VRT, DMI |
| 41 | Planen und Spezifizieren | TRA |
| 42 | Dokumentieren | TRA |
| 43 | Protokollieren | TRA |
| 50 | Trennen | NVK, DMI, VRT, ITV |
| 51 | Zugriffe regeln | INT, VER, NVK, VRT, DMI |
| 60 | Löschen und Vernichten | NVK, DMI, INT, VRT, ITV |
| 61 | Berichtigen | ITV, INT |
| 62 | Einschränken der Verarbeitung | NVK, DMI, INT, VRT, ITV |

### 2.3 BSI Grundschutz++ Methodik (GC-Gruppen)

| Gruppe | Titel | Beschreibung |
|--------|-------|--------------|
| GC.1 | Grundlagen | ISMS etablieren und aufrechterhalten |
| GC.2 | Kontext | Kontext der Organisation analysieren |
| GC.3 | Informationsverbund | Assets und Schnittstellen definieren |
| GC.4 | Sicherheitsorganisation | Rollen, Zuständigkeiten |
| GC.5 | Leitlinie | Sicherheitsstrategie und -politik |
| GC.6 | Kommunikation | Interne/externe Kommunikation |
| GC.7 | Vorgehensweisen | Dokumentation, Risikomanagement, Methodik |

### 2.4 ISO 27001:2022 Annex A (4 Kategorien)

| Kategorie | Controls | Beschreibung |
|-----------|----------|--------------|
| A.5 Organizational | 37 | Policies, Rollen, Prozesse |
| A.6 People | 8 | HR-Sicherheit, Awareness |
| A.7 Physical | 14 | Physische Sicherheit |
| A.8 Technological | 34 | Technische Maßnahmen |

### 2.5 ISO 27701:2019/2025 Struktur

| Clause | Titel | Beschreibung |
|--------|-------|--------------|
| 5 | PIMS requirements (ISO 27001) | ISMS-Erweiterungen |
| 6 | PIMS guidance (ISO 27002) | Implementierungshinweise |
| 7 | PII Controller Controls | Controller-spezifisch |
| 8 | PII Processor Controls | Processor-spezifisch |
| Annex A | Controller Controls | Detaillierte Controller-Maßnahmen |
| Annex B | Processor Controls | Detaillierte Processor-Maßnahmen |

**Hinweis**: ISO 27701:2025 ist nun standalone und erfordert nicht mehr zwingend ISO 27001.

---

## 3. OPC-Gruppen → SDM-Gewährleistungsziele

### 3.1 Mapping-Matrix

```
                    ┌─────────────────────────────────────────────────────────────┐
                    │           SDM GEWÄHRLEISTUNGSZIELE                          │
                    ├───────┬───────┬───────┬───────┬───────┬───────┬───────┬────┤
                    │  VER  │  INT  │  VRT  │  TRA  │  ITV  │  NVK  │  DMI  │ Σ  │
┌───────────────────┼───────┼───────┼───────┼───────┼───────┼───────┼───────┼────┤
│ GOV  Governance   │   ○   │   ○   │   ○   │   ●   │   ●   │   ○   │   ○   │ 2  │
│ ACC  Rechenschaft │   ○   │   ○   │   ○   │   ●   │   ◐   │   ○   │   ○   │1.5 │
│ LAW  Rechtsgrund. │   ◐   │   ◐   │   ◐   │   ●   │   ●   │   ●   │   ●   │ 7  │
│ DSR  Betroffenenr │   ○   │   ◐   │   ○   │   ●   │   ●   │   ◐   │   ○   │3.5 │
│ REG  VVT          │   ○   │   ○   │   ○   │   ●   │   ○   │   ◐   │   ◐   │ 2  │
│ TOM  Maßnahmen    │   ●   │   ●   │   ●   │   ◐   │   ◐   │   ●   │   ●   │6.5 │
│ DPIA Folgenabs.   │   ●   │   ●   │   ●   │   ●   │   ●   │   ●   │   ●   │ 7  │
│ OPS  Betrieb      │   ●   │   ●   │   ●   │   ◐   │   ◐   │   ◐   │   ◐   │ 5  │
│ XFER Transfer     │   ○   │   ◐   │   ●   │   ●   │   ◐   │   ●   │   ○   │4.5 │
│ INC  Vorfälle     │   ●   │   ●   │   ●   │   ●   │   ●   │   ○   │   ○   │ 5  │
│ TRAIN Schulung    │   ○   │   ○   │   ○   │   ●   │   ○   │   ○   │   ○   │ 1  │
└───────────────────┴───────┴───────┴───────┴───────┴───────┴───────┴───────┴────┘

Legende: ● = primär zugeordnet (1.0)  ◐ = sekundär (0.5)  ○ = nicht zugeordnet (0)
```

### 3.2 Detaillierte Zuordnung

| OPC-Gruppe | Primäre GZ | Sekundäre GZ | SDM-Bausteine |
|------------|------------|--------------|---------------|
| **GOV** | Transparenz, Intervenierbarkeit | - | B41, B42 |
| **ACC** | Transparenz | Intervenierbarkeit | B42, B43 |
| **LAW** | Alle | - | Übergreifend |
| **DSR** | Transparenz, Intervenierbarkeit | Integrität, Nichtverkettung | B60, B61, B62 |
| **REG** | Transparenz | Nichtverkettung, Datenminimierung | B42 |
| **TOM** | VER, INT, VRT, NVK, DMI | Transparenz, Intervenierbarkeit | B11, B50, B51 |
| **DPIA** | Alle | - | Übergreifend |
| **OPS** | VER, INT, VRT | TRA, ITV, NVK, DMI | B11, B51 |
| **XFER** | Vertraulichkeit, Nichtverkettung | Transparenz, Intervenierbarkeit, Integrität | B50, B51 |
| **INC** | VER, INT, VRT, TRA, ITV | - | B43, B61 |
| **TRAIN** | Transparenz | - | B41 |

---

## 4. OPC-Gruppen → BSI Grundschutz++

### 4.1 Gruppen-Mapping

| OPC | BSI GC-Gruppen | Relationship | Coverage |
|-----|----------------|--------------|----------|
| GOV | GC.4 (Sicherheitsorganisation), GC.5 (Leitlinie) | related | 80% |
| ACC | GC.1 (Grundlagen), GC.7 (Vorgehensweisen) | related/partial | 70% |
| LAW | GC.2 (Kontext) | related | 40% |
| **DSR** | **-** | **none** | **0%** |
| REG | GC.3 (Informationsverbund) | related | 50% |
| TOM | ORP, CON, OPS Bausteine | extends | 85% |
| DPIA | GC.7.4, GC.7.5, GC.7.6 | partial | 60% |
| OPS | GC.7 (Vorgehensweisen) | related | 75% |
| XFER | GC.3.2 (Schnittstellen) | partial | 30% |
| INC | DER-Bausteine | extends | 70% |
| TRAIN | GC.4.4 (Qualifikation) | equivalent | 90% |

### 4.2 Kritische Gaps

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    GAPS: OPC → BSI GRUNDSCHUTZ++                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ❌ DSR (Betroffenenrechte) - KEIN ÄQUIVALENT                             │
│      → Art. 12-22 DSGVO nicht abgedeckt                                    │
│      → BSI fokussiert auf Organisation, nicht auf Betroffene               │
│                                                                             │
│   ⚠️ LAW (Rechtsgrundlagen) - NUR TEILWEISE                                │
│      → GC.2 analysiert Kontext, aber nicht DSGVO-spezifisch                │
│      → Zweckbindung, Datenminimierung nicht abgedeckt                      │
│                                                                             │
│   ⚠️ XFER (Transfers) - NUR TECHNISCH                                      │
│      → Schnittstellen ja, Drittland-Compliance nein                        │
│      → BCR, SCC nicht in BSI                                               │
│                                                                             │
│   ⚠️ INC (Vorfälle) - ERGÄNZT BSI                                          │
│      → DER deckt Detektion/Reaktion ab                                     │
│      → Art. 33/34 Meldepflichten nicht spezifisch                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. OPC-Gruppen → ISO 27001:2022

### 5.1 Kategorien-Mapping

| OPC | ISO 27001:2022 Kategorie | Relevante Controls |
|-----|-------------------------|-------------------|
| GOV | A.5 Organizational | A.5.1-5.4 (Policies, Roles) |
| ACC | A.5 Organizational | A.5.1, A.5.35-37 (Documentation) |
| LAW | A.5 Organizational | A.5.31-34 (Legal compliance) |
| **DSR** | **-** | **Kein Äquivalent** |
| REG | A.5 Organizational | A.5.9-14 (Asset management) |
| TOM | A.7 Physical, A.8 Technological | A.7.1-14, A.8.1-34 |
| DPIA | A.5 Organizational | A.5.8 (Risk assessment) |
| OPS | A.5 Organizational | A.5.1-37 (diverse) |
| XFER | A.5 Organizational | A.5.19-23 (Supplier relations) |
| INC | A.5 Organizational | A.5.24-28 (Incident management) |
| TRAIN | A.6 People | A.6.1-8 (HR security) |

### 5.2 Control-Mapping (Auswahl)

| OPC Control | ISO 27001:2022 Control | Mapping |
|-------------|------------------------|---------|
| GOV-01 | A.5.1 Policies, A.5.2 Roles | related |
| GOV-05 | A.5.4 Management responsibility | equivalent |
| ACC-04 | A.6.3 Awareness training | equivalent |
| TOM-01 | A.8.24 Cryptography | related |
| TOM-02 | A.5.15-18 Access control | equivalent |
| DPIA-02 | A.5.8 Information security risk assessment | partial |
| INC-01 | A.5.24-25 Incident management | related |
| INC-02 | A.5.26 Response to incidents | extends |

### 5.3 Gap: Betroffenenrechte

ISO 27001:2022 enthält **keine spezifischen Controls für Betroffenenrechte** (DSR). Die Norm fokussiert auf:
- Informationssicherheit der Organisation
- Schutz von Information Assets
- Nicht: Rechte der betroffenen Personen

**→ ISO 27701 schließt diese Lücke.**

---

## 6. OPC-Gruppen → ISO 27701:2019/2025

### 6.1 Vollständiges Mapping

ISO 27701 ist die **einzige ISO-Norm**, die Betroffenenrechte vollständig abdeckt.

| OPC | ISO 27701 Clause/Annex | Coverage | Bemerkung |
|-----|------------------------|----------|-----------|
| GOV | 5.2 PIMS context | 85% | PIMS-spezifische Governance |
| ACC | 5.2, 7.2.8 Records | 80% | Dokumentation und Nachweise |
| LAW | 7.2.1-7.2.4 Legal basis | 90% | Rechtsgrundlagen identifizieren |
| **DSR** | **7.3 Data subject rights (A.7.3)** | **95%** | **Vollständige Abdeckung** |
| REG | 7.2.8 Records of processing | 90% | VVT-Äquivalent |
| TOM | 6.9-6.15 Security controls | 85% | Security measures |
| DPIA | 7.2.5 Privacy impact assessment | 95% | PIA/DPIA vollständig |
| OPS | 6.1-6.8 Operational controls | 80% | Betriebliche Maßnahmen |
| XFER | 7.5 International transfers (A.7.5) | 90% | Drittland-Transfers |
| INC | 6.13 Incident management | 80% | Security incidents |
| TRAIN | 6.4 Human resources | 85% | Awareness und Training |

### 6.2 ISO 27701 Annex A.7.3 - Betroffenenrechte

| ISO 27701 Control | DSGVO-Artikel | OPC DSR Control |
|-------------------|---------------|-----------------|
| A.7.3.1 Determining obligations | Art. 12-14 | DSR-01 (Informationspflichten) |
| A.7.3.2 Providing information | Art. 13-14 | DSR-01 |
| A.7.3.3 Access to PII | Art. 15 | DSR-02 (Auskunft) |
| A.7.3.4 Rectification | Art. 16 | DSR-03 (Berichtigung) |
| A.7.3.5 Erasure | Art. 17 | DSR-04 (Löschung) |
| A.7.3.6 Restriction of processing | Art. 18 | DSR-05 (Einschränkung) |
| A.7.3.7 Data portability | Art. 20 | DSR-06 (Übertragbarkeit) |
| A.7.3.8 Objection | Art. 21 | DSR-07 (Widerspruch) |
| A.7.3.9 Automated decision-making | Art. 22 | DSR-08 (Automatisierung) |

---

## 7. Integrierte Mapping-Matrix

### 7.1 Vollständige Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                              INTEGRIERTE MAPPING-MATRIX                                         │
├─────────┬─────────────────┬─────────────────┬─────────────────┬─────────────────┬──────────────┤
│   OPC   │      SDM        │  BSI GS++       │  ISO 27001:2022 │  ISO 27701      │  Coverage    │
│ Gruppe  │  Gewährl.ziele  │  GC-Gruppen     │  Annex A        │  Clause/Annex   │  Ø          │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ GOV     │ TRA, ITV        │ GC.4, GC.5      │ A.5.1-4         │ 5.2             │ 82%          │
│         │                 │ (80%)           │ (75%)           │ (85%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ ACC     │ TRA             │ GC.1, GC.7      │ A.5.1, A.5.35-37│ 5.2, 7.2.8      │ 77%          │
│         │                 │ (70%)           │ (70%)           │ (80%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ LAW     │ Alle            │ GC.2            │ A.5.31-34       │ 7.2.1-4         │ 63%          │
│         │                 │ (40%)           │ (60%)           │ (90%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ DSR     │ TRA, ITV        │ KEINE           │ KEINE           │ 7.3, A.7.3      │ 32%          │
│         │                 │ (0%)            │ (0%)            │ (95%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ REG     │ TRA             │ GC.3            │ A.5.9-14        │ 7.2.8           │ 77%          │
│         │                 │ (50%)           │ (70%)           │ (90%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ TOM     │ VER,INT,VRT,    │ ORP,CON,OPS     │ A.7, A.8        │ 6.9-15          │ 88%          │
│         │ NVK,DMI         │ (85%)           │ (90%)           │ (85%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ DPIA    │ Alle            │ GC.7.4-6        │ A.5.8           │ 7.2.5           │ 78%          │
│         │                 │ (60%)           │ (70%)           │ (95%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ OPS     │ VER,INT,VRT     │ GC.7            │ A.5.x (diverse) │ 6.1-8           │ 78%          │
│         │                 │ (75%)           │ (75%)           │ (80%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ XFER    │ VRT, NVK        │ GC.3.2          │ A.5.19-23       │ 7.5, A.7.5      │ 58%          │
│         │                 │ (30%)           │ (50%)           │ (90%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ INC     │ VER,INT,VRT,    │ DER             │ A.5.24-28       │ 6.13            │ 78%          │
│         │ TRA,ITV         │ (70%)           │ (80%)           │ (80%)           │              │
├─────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤
│ TRAIN   │ TRA             │ GC.4.4          │ A.6.1-8         │ 6.4             │ 88%          │
│         │                 │ (90%)           │ (85%)           │ (85%)           │              │
└─────────┴─────────────────┴─────────────────┴─────────────────┴─────────────────┴──────────────┘

Durchschnittliche Coverage:
├── SDM:          Konzeptionell vollständig (100%)
├── BSI GS++:     58% (DSR = 0%)
├── ISO 27001:    61% (DSR = 0%)
└── ISO 27701:    85%
```

---

## 8. Gap-Analyse

### 8.1 Framework-übergreifende Gaps

| Gap-ID | OPC-Bereich | BSI GS++ | ISO 27001 | ISO 27701 | Kritikalität |
|--------|-------------|----------|-----------|-----------|--------------|
| G1 | DSR (komplett) | ❌ | ❌ | ✅ | **Kritisch** |
| G2 | LAW-02-05 (Grundsätze) | ❌ | ⚠️ | ✅ | Hoch |
| G3 | XFER-03 (BCR) | ❌ | ❌ | ✅ | Mittel |
| G4 | INC-03 (Betroffene) | ❌ | ❌ | ⚠️ | Hoch |
| G5 | DPIA (Art. 35 spezifisch) | ⚠️ | ⚠️ | ✅ | Mittel |

### 8.2 Schlussfolgerungen

1. **BSI Grundschutz++** ist **nicht ausreichend für DSGVO-Compliance**
   - Betroffenenrechte fehlen komplett
   - Datenschutz-Grundsätze nur implizit
   - Ergänzung durch OPC oder SDM erforderlich

2. **ISO 27001:2022** hat **dieselben Privacy-Gaps**
   - Fokus auf Informationssicherheit
   - Betroffenenrechte nicht adressiert
   - Ergänzung durch ISO 27701 erforderlich

3. **ISO 27701** bietet die **beste Abdeckung** für Privacy
   - Explizite Betroffenenrechte (A.7.3)
   - DSGVO-nah konzipiert
   - 2025-Version standalone nutzbar

4. **SDM** ist **konzeptionell vollständig**
   - Alle Gewährleistungsziele decken DSGVO ab
   - Aber: Keine Gruppen-Gliederung vorgegeben
   - OPC kann als Strukturvorlage dienen

---

## 9. Empfehlungen für SDM-Gliederung

Da das SDM keine feste Gruppen-Gliederung vorgibt, können OPC-Gruppen als Strukturvorlage dienen.

### 9.1 Vorgeschlagene SDM-Gruppierung (basierend auf OPC)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              EMPFOHLENE SDM-GRUPPENSTRUKTUR                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   MANAGEMENT & GOVERNANCE                                                   │
│   ═══════════════════════                                                   │
│   ├── SDM-GOV: Organisation & Verantwortung                                │
│   │   └─► GZ: Transparenz, Intervenierbarkeit                              │
│   │   └─► Bausteine: B41, B42                                              │
│   │                                                                         │
│   ├── SDM-ACC: Rechenschaft & Dokumentation                                │
│   │   └─► GZ: Transparenz                                                  │
│   │   └─► Bausteine: B42, B43                                              │
│   │                                                                         │
│   └── SDM-LAW: Rechtsgrundlagen & Grundsätze                               │
│       └─► GZ: Alle (übergreifend)                                          │
│       └─► Bausteine: übergreifend                                          │
│                                                                             │
│   BETROFFENENRECHTE                                                         │
│   ═════════════════                                                         │
│   └── SDM-DSR: Auskunft, Löschung, Berichtigung, etc.                      │
│       └─► GZ: Intervenierbarkeit (primär), Transparenz                     │
│       └─► Bausteine: B60, B61, B62                                         │
│                                                                             │
│   VERARBEITUNG                                                              │
│   ════════════                                                              │
│   ├── SDM-REG: Verarbeitungsverzeichnis                                    │
│   │   └─► GZ: Transparenz                                                  │
│   │   └─► Bausteine: B42                                                   │
│   │                                                                         │
│   ├── SDM-OPS: Betriebsprozesse                                            │
│   │   └─► GZ: Verfügbarkeit, Integrität, Vertraulichkeit                   │
│   │   └─► Bausteine: B11, B51                                              │
│   │                                                                         │
│   └── SDM-XFER: Datenübermittlung                                          │
│       └─► GZ: Vertraulichkeit, Nichtverkettung                             │
│       └─► Bausteine: B50, B51                                              │
│                                                                             │
│   TECHNISCH-ORGANISATORISCHE MASSNAHMEN                                     │
│   ═════════════════════════════════════                                     │
│   └── SDM-TOM: Sicherheitsmaßnahmen nach Art. 32                           │
│       └─► GZ: VER, INT, VRT, NVK, DMI                                      │
│       └─► Bausteine: B11, B50, B51                                         │
│                                                                             │
│   RISIKO & VORFÄLLE                                                         │
│   ═════════════════                                                         │
│   ├── SDM-DPIA: Datenschutz-Folgenabschätzung                              │
│   │   └─► GZ: Alle                                                         │
│   │   └─► Bausteine: übergreifend                                          │
│   │                                                                         │
│   └── SDM-INC: Vorfälle & Meldungen                                        │
│       └─► GZ: VER, INT, VRT, TRA, ITV                                      │
│       └─► Bausteine: B43, B61                                              │
│                                                                             │
│   AWARENESS                                                                 │
│   ═════════                                                                 │
│   └── SDM-TRAIN: Schulung & Kompetenzentwicklung                           │
│       └─► GZ: Transparenz                                                  │
│       └─► Bausteine: B41                                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 9.2 Mapping SDM-Bausteine → OPC-Gruppen

| SDM-Baustein | Primäre OPC-Gruppe | Sekundäre OPC-Gruppen |
|--------------|--------------------|-----------------------|
| B11 Aufbewahren | TOM | OPS |
| B41 Planen | GOV | DPIA |
| B42 Dokumentieren | ACC, REG | GOV, OPS |
| B43 Protokollieren | ACC | INC |
| B50 Trennen | TOM | XFER |
| B51 Zugriffe regeln | TOM | OPS, XFER |
| B60 Löschen | DSR | TOM |
| B61 Berichtigen | DSR | INC |
| B62 Einschränken | DSR | - |

---

## 10. Referenzen

### Quellen

- [SDM - Standard-Datenschutzmodell (ULD)](https://www.datenschutzzentrum.de/sdm/)
- [SDM V3.1 Methodenhandbuch (DSK)](https://www.datenschutzkonferenz-online.de/media/ah/SDM-Methode-V31.pdf)
- [SDM-Bausteine Übersicht (caralegal)](https://caralegal.eu/blog/sdm-bausteine/)
- [BSI Grundschutz++ (ISMS-Ratgeber)](https://wiki.isms-ratgeber.info/wiki/Grundschutz++)
- [BSI Stand-der-Technik-Bibliothek (GitHub)](https://github.com/BSI-Bund/Stand-der-Technik-Bibliothek)
- [ISO 27001:2022 Annex A (DataGuard)](https://www.dataguard.com/iso-27001/annex-a/)
- [ISO 27001:2022 Controls Reference (HighTable)](https://hightable.io/iso-27001-annex-a-controls-reference-guide/)
- [ISO 27701:2019 (ISO.org)](https://www.iso.org/standard/71670.html)
- [ISO 27701:2025 (ISO.org)](https://www.iso.org/standard/85819.html)
- [ISO 27701 PIMS (ISMS.online)](https://www.isms.online/privacy-information-management-system-pims/)

### Verwandte Projektdokumente

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – Katalog-Spezifikation
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – BSI-Mapping
- [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) – Property-Erweiterungen
- [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) – Integrations-Architektur

---

## Änderungshistorie

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0.0 | 2026-02-05 | Initiale Analyse aller Framework-Mappings |

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Status**: Analyse abgeschlossen
