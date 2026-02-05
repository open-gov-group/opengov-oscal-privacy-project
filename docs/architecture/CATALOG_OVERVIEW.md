# OSCAL Privacy Ecosystem - Katalog-Übersicht

**Version**: 1.0.0
**Stand**: 2026-02-05
**Status**: Architektur-Übersicht für alle Stakeholder

---

## Executive Summary

Das OpenGov OSCAL Privacy Ecosystem basiert auf einem **zweischichtigen Katalog-System**, das Datenschutz-Anforderungen (WAS) von technisch-organisatorischen Maßnahmen (WIE) trennt und beide mit etablierten Resilienz- und Sicherheitsstandards verknüpft.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    KATALOG-ECOSYSTEM ÜBERSICHT                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ╔═══════════════════════════════════════════════════════════════════════╗ │
│   ║  LAYER 1: OPEN PRIVACY CATALOG                                        ║ │
│   ║  ════════════════════════════════                                     ║ │
│   ║                                                                       ║ │
│   ║  Frage: WAS muss der Verantwortliche tun?                            ║ │
│   ║                                                                       ║ │
│   ║  • DSGVO-Anforderungen mit direktem Artikelbezug                     ║ │
│   ║  • Berücksichtigt EU-Aufsichtsbehörden (CNIL, DSK, ICO, AEPD, etc.) ║ │
│   ║  • Risiko-Perspektive: Was passiert dem Betroffenen bei Verstoß?    ║ │
│   ║  • Reifegrad-Modell: Wie gut ist die Umsetzung? (Level 1-5)         ║ │
│   ║                                                                       ║ │
│   ║  Zielgruppe: DSB, DPO, Compliance, Management                        ║ │
│   ║                                                                       ║ │
│   ╚═══════════════════════════════════════════════════════════════════════╝ │
│                                  │                                          │
│                                  │ links: rel="related-control"             │
│                                  │ referenziert auf SDM-Maßnahmen           │
│                                  ▼                                          │
│   ╔═══════════════════════════════════════════════════════════════════════╗ │
│   ║  LAYER 2: SDM PRIVACY CATALOG                                         ║ │
│   ║  ════════════════════════════════                                     ║ │
│   ║                                                                       ║ │
│   ║  Frage: WIE wird es technisch/organisatorisch umgesetzt?             ║ │
│   ║                                                                       ║ │
│   ║  • Detaillierte Maßnahmen (technisch + organisatorisch)              ║ │
│   ║  • Schutzniveau: baseline | standard | enhanced                      ║ │
│   ║  • Eintrittswahrscheinlichkeit: low | moderate | high                ║ │
│   ║  • Umsetzungsnotwendigkeit: must | should | could (MoSCoW)           ║ │
│   ║  • Verknüpfung mit Resilienz-/Sicherheitsnormen                      ║ │
│   ║                                                                       ║ │
│   ║  Zielgruppe: ISB, IT-Security, Entwicklung, IT-Betrieb               ║ │
│   ║                                                                       ║ │
│   ╚═══════════════════════════════════════════════════════════════════════╝ │
│                                  │                                          │
│                                  │ mappings + props                         │
│                                  ▼                                          │
│   ╔═══════════════════════════════════════════════════════════════════════╗ │
│   ║  LAYER 3: EXTERNE STANDARDS                                           ║ │
│   ║  ══════════════════════════                                           ║ │
│   ║                                                                       ║ │
│   ║  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                ║ │
│   ║  │ BSI          │  │ ISO/IEC      │  │ ISO/IEC      │                ║ │
│   ║  │ Grundschutz  │  │ 27001:2022   │  │ 27701 (PIMS) │                ║ │
│   ║  │ + Grundschutz│  │              │  │              │                ║ │
│   ║  │ ++ Methodik  │  │              │  │              │                ║ │
│   ║  └──────────────┘  └──────────────┘  └──────────────┘                ║ │
│   ║                                                                       ║ │
│   ╚═══════════════════════════════════════════════════════════════════════╝ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Verwandte Dokumente

| Dokument | Beschreibung |
|----------|--------------|
| [REFERENCE_ARCHITECTURE.md](REFERENCE_ARCHITECTURE.md) | Referenzierungsarchitektur OPC ↔ SPC ↔ Frameworks |
| [MAPPING_PRIVACY_TO_ISO27701.md](MAPPING_PRIVACY_TO_ISO27701.md) | Detailliertes ISO 27701 Mapping |
| [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) | BSI Grundschutz++ Mapping |

---

## 1. Open Privacy Catalog - Datenschutz-Kompendium

### 1.1 Zweck

Der **Open Privacy Catalog** ist das **Datenschutz-Kompendium**, das alle grundsätzlich geforderten bzw. umzusetzenden Aufgaben beschreibt. Er zahlt konkret auf die Umsetzung der DS-GVO und nationaler Datenschutznormen ein.

### 1.2 Struktur

| Gruppe | Fokus | DSGVO-Artikel | Aufsichtsbehörden-Bezug |
|--------|-------|---------------|------------------------|
| **GOV** | Governance & Organisation | Art. 24, 37-39 | DSK: Kurzpapier Nr. 12 (DSB) |
| **ACC** | Rechenschaft & Dokumentation | Art. 5(2), 30 | DSK: Kurzpapier Nr. 1 |
| **LAW** | Rechtsgrundlagen & Datenminimierung | Art. 5-11 | CNIL: Guides Pratiques |
| **DSR** | Betroffenenrechte | Art. 12-22 | EDPB: Guidelines on Data Subject Rights |
| **REG** | Verarbeitungsverzeichnis | Art. 30 | DSK: Kurzpapier Nr. 1 |
| **TOM** | Technische & Org. Maßnahmen | Art. 25, 32-34 | ENISA: Guidelines |
| **DPIA** | Datenschutz-Folgenabschätzung | Art. 35, 36 | CNIL: PIA Methodik |
| **OPS** | Betriebsprozesse | Operational | Praxis-Anforderungen |
| **XFER** | Datenübermittlung | Art. 44-49 | EDPB: Recommendations 01/2020 |
| **INC** | Vorfälle & Meldungen | Art. 33, 34 | DSK: Kurzpapier Nr. 18 |

### 1.3 Control-Eigenschaften

Jedes Control im Open Privacy Catalog enthält:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    OPEN PRIVACY CATALOG - CONTROL STRUKTUR                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   PROPS (Metadaten)                                                         │
│   ═════════════════                                                         │
│   • legal: EU:REG:GDPR:ART-32            Rechtsbezug                        │
│   • assurance_goal: confidentiality       Gewährleistungsziel (SDM)         │
│   • maturity-domain: access-control       Reifegrad-Domäne                  │
│   • target-maturity: 4                    Ziel-Reifegrad                    │
│                                                                             │
│   PARTS (Inhalte)                                                           │
│   ═══════════════                                                           │
│   • statement           WAS muss getan werden?                              │
│   • maturity-hints      Wie sieht Level 1, 3, 5 aus?                        │
│   • typical-measures    Welche Maßnahmen sind typisch?                      │
│   • assessment-questions Wie wird geprüft?                                  │
│   • risk-guidance       Was passiert dem Betroffenen bei Verstoß?           │
│     ├─ normal:   Stammdaten → Vertrauensverlust                             │
│     ├─ moderate: Finanzdaten → Identitätsmissbrauch                         │
│     └─ high:     Art. 9 Daten → Diskriminierung, Gefährdung                 │
│   • risk-hint           Wann ist DSFA erforderlich?                         │
│                                                                             │
│   LINKS (Verknüpfungen)                                                     │
│   ═════════════════════                                                     │
│   • rel="related-control" → SDM-TOM-AC-01   Verweis auf SDM-Maßnahme        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. SDM Privacy Catalog - Technische Maßnahmen

### 2.1 Zweck

Der **SDM Privacy Catalog** gliedert die Anforderungen aus dem Open Privacy Catalog auf und beschreibt **detaillierte technische und organisatorische Maßnahmen (TOM)**. Er ist vollständig mit Resilienz- und Sicherheitsnormen verknüpft.

### 2.2 Zielgruppe und Austausch

Der SDM-Katalog ermöglicht den **direkten Austausch mit den Beteiligten**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BIDIREKTIONALER AUSTAUSCH                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   DSB / DPO                                                                 │
│   ─────────                                                                 │
│        │                                                                    │
│        │ Fordert: "Für TOM-02 brauchen wir Berechtigungsmanagement"        │
│        │          (Open Privacy Catalog)                                    │
│        ▼                                                                    │
│   ╔═══════════════════════════════════════════════════════════════════╗    │
│   ║                      SDM PRIVACY CATALOG                          ║    │
│   ║                                                                   ║    │
│   ║  SDM-TOM-AC-01: Rollenbasiertes Berechtigungsmanagement          ║    │
│   ║  ├─ SDM-TOM-AC-01-01 (baseline): Grundlegendes IAM               ║    │
│   ║  ├─ SDM-TOM-AC-01-02 (standard): Regelmäßige Rezertifizierung   ║    │
│   ║  └─ SDM-TOM-AC-01-03 (enhanced): Automatisiertes IAM/IDM        ║    │
│   ║                                                                   ║    │
│   ║  Props:                                                           ║    │
│   ║  • dp-risk-impact: normal | moderate | high (Schutzniveau)       ║    │
│   ║  • dp-likelihood: low | moderate | high (Eintrittswahrscheinl.)  ║    │
│   ║  • modalverb: must | should | could (MoSCoW)                     ║    │
│   ║  • bsi-mapping: ORP.4                                            ║    │
│   ║  • iso27001-mapping: A.9.2.1                                     ║    │
│   ║                                                                   ║    │
│   ╚═══════════════════════════════════════════════════════════════════╝    │
│        │                              ▲                                     │
│        │                              │                                     │
│        ▼                              │                                     │
│   ISB / IT-Security                   │                                     │
│   ─────────────────                   │                                     │
│                                       │                                     │
│   Option A: Maßnahme adressieren      │                                     │
│   "SDM-TOM-AC-01-02 wird umgesetzt"   │                                     │
│                                       │                                     │
│   Option B: Maßnahme melden           │                                     │
│   "ORP.4 bereits auditiert (BSI)"     │                                     │
│   → Mapping zeigt Abdeckung           ────────────────────────────────────  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.3 Control-Eigenschaften

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SDM PRIVACY CATALOG - CONTROL STRUKTUR                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   PROPS (Metadaten)                                                         │
│   ═════════════════                                                         │
│                                                                             │
│   Schutzniveau (Data Protection Risk)                                       │
│   ──────────────────────────────────                                        │
│   • dp-risk-impact: normal      → Basis-Schutzmaßnahmen                     │
│   • dp-risk-impact: moderate    → Erweiterte Maßnahmen                      │
│   • dp-risk-impact: high        → Maximale Schutzmaßnahmen                  │
│                                                                             │
│   Eintrittswahrscheinlichkeit                                               │
│   ─────────────────────────────                                             │
│   • dp-likelihood: low          → Geringe Wahrscheinlichkeit                │
│   • dp-likelihood: moderate     → Mittlere Wahrscheinlichkeit               │
│   • dp-likelihood: high         → Hohe Wahrscheinlichkeit                   │
│                                                                             │
│   Umsetzungsnotwendigkeit (MoSCoW)                                          │
│   ─────────────────────────────────                                         │
│   • modalverb: must (MUSS)      → Zwingende Anforderung                     │
│   • modalverb: should (SOLLTE)  → Starke Empfehlung                         │
│   • modalverb: could (KÖNNTE)   → Wünschenswert                             │
│                                                                             │
│   Framework-Mappings                                                        │
│   ───────────────────                                                       │
│   • bsi-mapping: ORP.4          → BSI IT-Grundschutz                        │
│   • iso27001-mapping: A.9.2.1   → ISO/IEC 27001:2022                        │
│   • iso27701-mapping: 7.3.6     → ISO/IEC 27701 (PIMS)                      │
│                                                                             │
│   PARTS (Inhalte)                                                           │
│   ═══════════════                                                           │
│   • statement           Detaillierte Maßnahmenbeschreibung                  │
│   • legal-justification Datenschutzrechtliche Begründung                    │
│   • warranty-mapping    Beitrag zu SDM-Gewährleistungszielen                │
│   • typical-measures    Konkrete Umsetzungsschritte                         │
│   • guidance            Technische Hinweise                                 │
│                                                                             │
│   SUB-CONTROLS (Abstufung)                                                  │
│   ════════════════════════                                                  │
│   • -01 (baseline):   Mindestanforderung                                    │
│   • -02 (standard):   Regelfall                                             │
│   • -03 (enhanced):   Erweitert für hohes Risiko                            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Verknüpfung: Open Privacy → SDM → Resilienz

### 3.1 Beispiel: TOM-02 (Berechtigungsmanagement)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DURCHGÄNGIGE VERKNÜPFUNG                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   OPEN PRIVACY CATALOG                                                      │
│   ════════════════════                                                      │
│   TOM-02: Zugriffs- und Berechtigungsmanagement                            │
│   ├─ legal: Art. 32 DSGVO                                                  │
│   ├─ risk-guidance: normal | moderate | high                               │
│   ├─ maturity-hints: Level 1, 3, 5                                         │
│   └─ links: rel="related-control" → #SDM-TOM-AC-01                         │
│                                  │                                          │
│                                  ▼                                          │
│   SDM PRIVACY CATALOG                                                       │
│   ═══════════════════                                                       │
│   SDM-TOM-AC-01: Rollenbasiertes Berechtigungsmanagement                   │
│   ├─ dp-risk-impact: normal | moderate | high                              │
│   ├─ dp-likelihood: low | moderate | high                                  │
│   ├─ modalverb: must (MUSS)                                                │
│   ├─ bsi-mapping: ORP.4                                                    │
│   ├─ iso27001-mapping: A.9.2.1                                             │
│   └─ Sub-Controls:                                                          │
│       ├─ SDM-TOM-AC-01-01 (baseline)                                       │
│       ├─ SDM-TOM-AC-01-02 (standard)                                       │
│       └─ SDM-TOM-AC-01-03 (enhanced)                                       │
│                                  │                                          │
│                                  ▼                                          │
│   EXTERNE STANDARDS                                                         │
│   ═════════════════                                                         │
│   ┌──────────────────────┐  ┌──────────────────────┐                       │
│   │ BSI ORP.4            │  │ ISO 27001 A.9.2.1    │                       │
│   │ Berechtigungsmgmt    │  │ User Access Mgmt     │                       │
│   │                      │  │                      │                       │
│   │ Modalverb: MUSS      │  │ Shall                │                       │
│   │ → Bereits auditiert? │  │ → Zertifiziert?      │                       │
│   └──────────────────────┘  └──────────────────────┘                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Rollen und Verantwortlichkeiten

| Rolle | Primärer Katalog | Aufgabe |
|-------|------------------|---------|
| **DSB/DPO** | Open Privacy Catalog | Anforderungen definieren, Compliance überwachen |
| **ISB/CISO** | SDM Privacy Catalog | Technische Umsetzung koordinieren, BSI-Mapping nutzen |
| **IT-Security** | SDM Privacy Catalog | Maßnahmen implementieren, Audit-Nachweise liefern |
| **Compliance/Audit** | Beide + Mappings | Multi-Framework-Compliance prüfen |
| **Management** | Open Privacy Catalog | Risiko-Übersicht, Reifegrad-Reporting |

---

## 5. Aufsichtsbehörden-Referenzen

Der Open Privacy Catalog berücksichtigt Guidance von:

| Behörde | Land | Relevante Dokumente |
|---------|------|---------------------|
| **DSK** | DE | Kurzpapiere Nr. 1-20, SDM V3.0 |
| **CNIL** | FR | Guides Pratiques, PIA-Methodik |
| **ICO** | UK | Guidance on Data Protection |
| **EDPB** | EU | Guidelines, Recommendations |
| **AEPD** | ES | Guías y Herramientas |
| **ENISA** | EU | Technical Guidelines |

---

## 6. Referenzen

- [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) – Detaillierte Katalog-Spezifikation
- [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) – Integrations-Architektur
- [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) – Erweitertes Control-Schema
- [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) – BSI Mapping

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
