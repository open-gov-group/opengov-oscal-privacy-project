# OpenGov OSCAL Privacy Ecosystem – Management Summary

**Version**: 1.2.0
**Stand**: 2026-02-05
**Status**: Projektfortschritt Q1 2026 – Phase 1 bei 70%, Mappings vorgezogen

---

## Executive Summary

Das **OpenGov OSCAL Privacy Ecosystem** ist ein Open-Source-Framework zur maschinenlesbaren Abbildung von Datenschutz-Compliance auf Basis des NIST OSCAL-Standards (Open Security Controls Assessment Language). Das Projekt ermöglicht erstmals eine durchgängige, standardisierte Dokumentation von DSGVO-Anforderungen, deren technische Umsetzung (SDM/TOM) und die Verknüpfung mit etablierten Security-Frameworks (BSI Grundschutz++, ISO 27001, **ISO 27701:2025**).

---

## Ziel, Umfang und Stand

### Projektziel

> **Maschinenlesbare Datenschutz-Compliance für den öffentlichen Sektor etablieren**

| Dimension | Beschreibung |
|-----------|--------------|
| **Vision** | Einheitliche, interoperable Datenschutz-Dokumentation für Behörden in Europa |
| **Mission** | OSCAL-basierte Kataloge, Mappings und Werkzeuge für DSGVO-Compliance bereitstellen |
| **Differenzierung** | Durchgängige Kette: DSGVO-Anforderung → SDM-Maßnahme → BSI/ISO-Control → Nachweis |

### Projektumfang (Scope)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PROJEKTUMFANG                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   IN SCOPE                              OUT OF SCOPE                        │
│   ════════                              ════════════                        │
│                                                                             │
│   ✓ DSGVO-Anforderungskatalog           ✗ Kommerzielle SaaS-Lösung         │
│   ✓ SDM-Maßnahmenkatalog                ✗ Rechtsberatung                   │
│   ✓ BSI Grundschutz++ Mapping           ✗ Zertifizierung                   │
│   ✓ ISO 27001/27701 Mapping             ✗ Branchenspezifische Kataloge     │
│   ✓ Python Core Libraries               ✗ Mobile Apps                       │
│   ✓ Web-Viewer (Bürger/DPO)             ✗ Legacy-System-Integration        │
│   ✓ RoPa MVP (Verarbeitungsverzeichnis) ✗ KI-gestützte Compliance          │
│   ✓ OSCAL Workbench (Authoring)                                            │
│   ✓ REST API (Gateway)                                                      │
│                                                                             │
│   Zielgruppe: Behörden, DPOs, Aufsichtsbehörden, Anbieter                  │
│   Region: Deutschland → EU (erweiterbar)                                    │
│   Lizenz: Open Source (MIT/Apache 2.0)                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Aktueller Stand (Februar 2026)

| Bereich | Status | Fortschritt |
|---------|--------|-------------|
| **Phase 1: MVP Foundation** | In Umsetzung | **70%** |
| Architektur-Dokumentation | Abgeschlossen | 100% |
| DSGVO-Katalog (OPC) | 10 Gruppen, 50+ Controls | 90% |
| SDM-Katalog Struktur | v1.0 festgeschrieben | 100% |
| BSI Grundschutz++ Mapping | Vollständig (60% Coverage) | 100% |
| **ISO 27701:2025 Mapping** | **Vollständig (89% Coverage)** | **100%** |
| Python Libraries | Architektur definiert | 50% |
| Privacy Viewer | In Entwicklung | 40% |
| RoPa MVP | Architektur definiert | 35% |

**Gesamtfortschritt Phase 1**: █████████░░░░░░░░░░░ **70%**

---

### Kernnutzen

| Stakeholder | Nutzen |
|-------------|--------|
| **Behörden** | Standardisierte Compliance-Dokumentation, wiederverwendbare Nachweise |
| **DPOs** | Strukturierte Verarbeitungsverzeichnisse, automatisierte Gap-Analysen |
| **Bürger** | Transparente Darstellung ihrer Datenschutzrechte in verständlicher Sprache |
| **Aufsichtsbehörden** | Maschinenlesbare Prüfungen, vereinfachte Audits |
| **Anbieter** | Klare Anforderungen für Vergabeverfahren, wiederverwendbare Nachweise |

---

## Projektstatus auf einen Blick

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PROJEKTSTATUS FEBRUAR 2026                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ARCHITEKTUR-DOKUMENTATION                              ████████████ 100%  │
│   • MASTER_BLUEPRINT, VISION, GOVERNANCE                                    │
│   • Alle ADRs dokumentiert                                                  │
│                                                                             │
│   KATALOG-ENTWICKLUNG (OPC + SDM)                        ████████░░░░  70%  │
│   • Open Privacy Catalog: 10 Gruppen, ~50 Controls                         │
│   • SDM Privacy Catalog: Struktur v1.0 festgeschrieben                     │
│                                                                             │
│   BSI GRUNDSCHUTZ++ MAPPING                              ████████████ 100%  │
│   • Mapping-Methodik dokumentiert (742 Zeilen)                             │
│   • OSCAL Mapping-Datei erstellt (947 Zeilen)                              │
│   • Coverage-Analyse: TOM 85%, DSR 0% (erwartete Gap)                      │
│                                                                             │
│   ISO 27701:2025 MAPPING                                 ████████████ 100%  │
│   • Mapping-Methodik dokumentiert (435 Zeilen)                             │
│   • OSCAL Mapping-Datei erstellt (1546 Zeilen)                             │
│   • Coverage-Analyse: DSR 95%, LAW 95% (kritischer Vorteil!)               │
│   • Referenzierungsarchitektur OPC ↔ SPC ↔ Frameworks dokumentiert        │
│                                                                             │
│   CORE LIBRARIES (Python)                                ██████░░░░░░  50%  │
│   • pyprivacy: Architektur definiert                                       │
│   • pylegal-utils: Architektur definiert                                   │
│                                                                             │
│   TEAM-SPEZIFISCHE MVPs                                  ████░░░░░░░░  35%  │
│   • RoPa MVP: Architektur dokumentiert                                     │
│   • Workbench: In Entwicklung                                              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Zentrale Ergebnisse Q1 2026

### 1. Zwei-Katalog-Architektur etabliert

```
┌───────────────────────────────────────────────────────────────────┐
│                 OPEN PRIVACY CATALOG (OPC)                        │
│                      "WAS" - Anforderungen                        │
│                                                                   │
│   GOV │ ACC │ LAW │ DSR │ REG │ TOM │ DPIA │ OPS │ XFER │ INC    │
│                                                                   │
│   Perspektive: DSGVO-Anforderungen, Rechtsreferenzen              │
└────────────────────────────┬──────────────────────────────────────┘
                             │ verweist auf
                             ▼
┌───────────────────────────────────────────────────────────────────┐
│                 SDM PRIVACY CATALOG                               │
│                   "WIE" - Maßnahmen                               │
│                                                                   │
│   SDM-TRA │ SDM-ITV │ SDM-NVK │ SDM-VCI │ SDM-DMI │ SDM-MGT      │
│                                                                   │
│   Perspektive: Gewährleistungsziele, technische Umsetzung         │
└───────────────────────────────────────────────────────────────────┘
```

**10 OPC-Gruppen definiert:**

| Domäne | Gruppen | Status |
|--------|---------|--------|
| **Governance & Compliance** | GOV, ACC, DPIA | Implementiert |
| **Rechtliche Anforderungen** | LAW, DSR, XFER | Implementiert |
| **Operative Umsetzung** | REG, TOM, OPS, INC | Implementiert |

### 2. BSI Grundschutz++ Mapping abgeschlossen

| Metrik | Wert |
|--------|------|
| Gemappte Gruppen | 10/10 |
| Control-Mappings | 25+ detailliert |
| Durchschnittliche Coverage (Privacy → BSI) | 62% |
| Identifizierte Gaps | 8 dokumentiert |
| Empfehlungen | 4 priorisiert |

**Coverage-Analyse nach Gruppen:**

| OPC-Gruppe | BSI-Coverage | Bewertung |
|------------|--------------|-----------|
| TOM | 85% | Hohe Übereinstimmung |
| OPS | 75% | Gute Übereinstimmung |
| GOV | 70% | Strukturelle Ähnlichkeit |
| INC | 70% | Security-fokussiert |
| DPIA | 60% | Methodische Entsprechung |
| ACC | 50% | Teilweise Abdeckung |
| LAW | 25% | Datenschutz-spezifisch |
| DSR | 0% | **Kritischer Privacy-Gap** |

### 3. ISO 27701:2025 Mapping abgeschlossen ⭐ NEU

| Metrik | Wert |
|--------|------|
| Gemappte Gruppen | 11/11 |
| Control-Mappings | 56 detailliert |
| Durchschnittliche Coverage (Privacy → ISO) | **89%** |
| OSCAL-Mapping-Datei | 1546 Zeilen |

**Coverage-Analyse nach Gruppen:**

| OPC-Gruppe | ISO 27701-Coverage | BSI-Coverage | Differenz |
|------------|-------------------|--------------|-----------|
| DSR | **95%** | 0% | **+95%** ⭐ |
| LAW | **95%** | 25% | +70% |
| DPIA | **95%** | 60% | +35% |
| TRAIN | **95%** | 70% | +25% |
| TOM | 93% | 85% | +8% |
| XFER | 92% | 30% | +62% |
| ACC | 90% | 50% | +40% |
| REG | 90% | 50% | +40% |

**Kritischer Vorteil**: ISO 27701 schließt den BSI-Gap bei Betroffenenrechten (DSR) vollständig.

### 4. SDM-Katalogstruktur festgeschrieben (v1.0)

```
SDM PRIVACY CATALOG v1.0
════════════════════════

SDM-TRA: Transparenz (41, 42, 43)
SDM-ITV: Intervenierbarkeit (60, 61, 62)
SDM-NVK: Nichtverkettung (50)
SDM-VCI: Verfügbarkeit/Vertraulichkeit/Integrität (11, 51)
SDM-DMI: Datenminimierung (Cross-Cutting)
SDM-MGT: Management (01, 02, 03)

Alle 9 Original-SDM-Bausteine + 3 neue Management-Controls
```

---

## Architektur-Übersicht

### Repository-Landschaft

```
                    ┌─────────────────────────────────────┐
                    │      opengov-privacy-oscal          │
                    │      (Dieses Repository)            │
                    │                                     │
                    │  • OSCAL Kataloge (OPC, SDM)        │
                    │  • Mappings (BSI, ISO)              │
                    │  • Profile                          │
                    │  • Architektur-Dokumentation        │
                    └─────────────────┬───────────────────┘
                                      │
           ┌──────────────────────────┼──────────────────────────┐
           │                          │                          │
           ▼                          ▼                          ▼
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│ opengov-oscal-      │    │ open-oscal-         │    │ opengov-privacy-    │
│ pyprivacy           │    │ workbench           │    │ viewer              │
│                     │    │                     │    │                     │
│ Python Core Library │    │ Authoring Tool      │    │ Bürger-/DPO-UI      │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
```

### Team-Struktur und Verantwortlichkeiten

| Team | Fokus | Repositories | Status |
|------|-------|--------------|--------|
| **Core Team** | Python Libraries, OSCAL-Konformität | pyprivacy, pylegal-utils | Architektur definiert |
| **Standards Team** | Kataloge, Mappings, Profile | privacy-oscal | Aktiv entwickelnd |
| **Workbench Team** | Authoring UI, Viewer | oscal-workbench | In Entwicklung |
| **RoPa Team** | Verarbeitungsverzeichnis MVP | privacy-app, privacy-gateway | Architektur definiert |
| **Crossover Team** | Framework-Integration | privacy-mappings | BSI-Mapping abgeschlossen |

---

## Deliverables

### Dokumentation (docs/architecture/)

| Dokument | Inhalt | Version |
|----------|--------|---------|
| [MASTER_BLUEPRINT.md](MASTER_BLUEPRINT.md) | Gesamtarchitektur | 1.0 |
| [VISION_AND_CONCEPT.md](VISION_AND_CONCEPT.md) | Vision & Konzept | 1.0 |
| [CATALOG_OVERVIEW.md](CATALOG_OVERVIEW.md) | Zwei-Katalog-Architektur Übersicht | 1.0 |
| [OSCAL_PRIVACY_CATALOGS.md](OSCAL_PRIVACY_CATALOGS.md) | OPC-Spezifikation | 1.2.1 |
| [SDM_CATALOG_STRUCTURE.md](SDM_CATALOG_STRUCTURE.md) | SDM-Gliederung | 1.0.0 |
| [MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md](MAPPING_PRIVACY_TO_BSI_GRUNDSCHUTZ.md) | BSI-Mapping Methodik | 1.0 |
| [GROUP_MAPPING_ANALYSIS.md](GROUP_MAPPING_ANALYSIS.md) | OPC ↔ SDM ↔ BSI ↔ ISO Analyse | 1.0 |
| [CORE_TEAM_LIBRARIES.md](CORE_TEAM_LIBRARIES.md) | Python Libraries | 1.0 |
| [MVP_ROPA_ARCHITECTURE.md](MVP_ROPA_ARCHITECTURE.md) | RoPa MVP | 1.0 |
| [CATALOG_INTEGRATION.md](CATALOG_INTEGRATION.md) | Integration Workflow | 1.1 |
| [EXTENDED_CONTROL_SCHEMA.md](EXTENDED_CONTROL_SCHEMA.md) | BSI-kompatible Erweiterungen | 1.0 |

### OSCAL-Artefakte (oscal/)

| Artefakt | Pfad | Beschreibung |
|----------|------|--------------|
| OPC v0.7.0 | catalog/open_privacy_catalog_risk_v0.7.0.json | Aktueller Katalog (10 Gruppen) |
| OPC v0.6.0 | catalog/open_privacy_catalog_risk_v0.6.0.json | Vorherige stabile Version |
| BSI-Mapping | mappings/opengov_privacy_to_bsi_grundschutz.json | OSCAL Mapping-Datei (947 Zeilen) |
| Integriertes Profil | profiles/profile_integrated_privacy_security.json | Privacy + Security kombiniert |

---

## Roadmap-Status

```
2026                                    2027
Q1          Q2          Q3          Q4          Q1
│           │           │           │           │
▼           ▼           ▼           ▼           ▼
┌───────────────────────┬───────────────────────┬───────────────────────┐
│      PHASE 1          │      PHASE 2          │      PHASE 3          │
│   MVP Foundation      │    Integration        │    Erweiterung        │
│                       │                       │                       │
│ ▓▓▓▓▓▓▓▓░░░░ 70%     │ ░░░░░░░░░░░░ 0%      │ ░░░░░░░░░░░░ 0%      │
│                       │                       │                       │
│ • Kataloge ✓          │ • privacy-mappings    │ • oscal-workbench     │
│ • SDM-Struktur ✓      │ • privacy-gateway     │ • security-oscal      │
│ • BSI-Mapping ✓       │ • privacy-data        │ • pylegal-utils       │
│ • Architektur ✓       │                       │                       │
│ • pyprivacy ◐         │                       │                       │
│ • privacy-app ◐       │                       │                       │
└───────────────────────┴───────────────────────┴───────────────────────┘

Legende: ✓ = abgeschlossen  ◐ = in Arbeit  ░ = offen
```

### Nächste Meilensteine

| Meilenstein | Deadline | Status |
|-------------|----------|--------|
| M1.1: OSCAL-Katalog-Basis | Ende Feb 2026 | 90% ✓ |
| M1.2: Privacy Viewer Beta | Ende Mär 2026 | 40% |
| M1.3: Privacy App MVP | Ende Apr 2026 | 25% |
| M1.4: Python Library v1.0 | Ende Mai 2026 | 35% |

---

## Risikobewertung

| Risiko | Wahrscheinlichkeit | Impact | Mitigation | Status |
|--------|-------------------|--------|------------|--------|
| DSR-Controls nicht in BSI abgebildet | Hoch | Mittel | Privacy-spezifische Erweiterung dokumentiert | Akzeptiert |
| OSCAL-Komplexität | Mittel | Hoch | Core Libraries abstrahieren Komplexität | In Arbeit |
| Ressourcenmangel | Mittel | Hoch | Priorisierung, Open Source Community | Überwacht |
| Pilotanwender-Akquise | Mittel | Mittel | Demos, Workshops geplant | Geplant |

---

## Strategische Empfehlungen

### Kurzfristig (Q1 2026)

1. **Python Libraries priorisieren** – pyprivacy ist Voraussetzung für alle Downstream-Projekte
2. **Viewer MVP deployen** – Sichtbarkeit für Stakeholder erhöhen
3. **Pilot-Behörde gewinnen** – Validierung des Ansatzes in der Praxis

### Mittelfristig (Q2-Q3 2026)

1. **Gateway API entwickeln** – Unified API für alle Konsumenten
2. **ISO 27701 Mapping** – Ergänzung zum BSI-Mapping für internationale Anwendbarkeit
3. **Workbench-Beta** – Standards-Team von JSON-Bearbeitung entlasten

### Langfristig (Q4 2026+)

1. **Community aufbauen** – Katalog-Pflege durch die Datenschutz-Community
2. **Aufsichtsbehörden einbinden** – Anerkennung der Nachweisführung
3. **SSP-Unterstützung** – Vollständiger OSCAL-Lebenszyklus

---

## Key Takeaways

1. **Architektur ist solide** – Zwei-Katalog-Ansatz (OPC/SDM) und OSCAL 1.1.2 Basis sind etabliert

2. **BSI-Integration erreicht** – Erstmals systematisches Mapping Privacy ↔ Security dokumentiert

3. **Gaps sind bekannt** – DSR (Betroffenenrechte) hat 0% BSI-Abdeckung – dies ist erwartbar und kein Mangel des Mappings, sondern Natur des Security-Fokus von BSI

4. **Nächster kritischer Pfad** – Python Libraries → Viewer → App MVP

5. **Differenzierungsmerkmal** – Maschinenlesbare Compliance mit durchgängiger Kette: DSGVO → SDM → BSI/ISO → Nachweis

---

## Kontakt & Governance

| Rolle | Verantwortung |
|-------|---------------|
| Architecture Team | Technische Entscheidungen, ADRs |
| Standards Team | Katalog-Inhalte, Mappings |
| Projekt-Sponsor | Strategische Ausrichtung |

**Dokumenten-Review**: Monatlich (Architecture Team)
**Roadmap-Review**: Quartalsweise (alle Stakeholder)

---

**Letzte Aktualisierung**: 2026-02-05
**Verantwortlich**: Architecture Team
**Distribution**: Management, Projekt-Sponsoren, Team-Leads
