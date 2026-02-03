# Dokumenten-Index: Related Informations

Dieses Verzeichnis enthält Hintergrunddokumente und Konzeptpapiere für das OpenGov OSCAL Privacy Ecosystem.

---

## Übersicht der Dokumente

| Dokument | Typ | Thema | Relevanz |
|----------|-----|-------|----------|
| [PROJECT_OVERVIEW.md](PROJECT_OVERVIEW.md) | Markdown | Gesamtübersicht des Ecosystems | Hoch |
| OSCAL-Catalog für den Datenschutz.rtf | RTF | OSCAL-Katalog-Konzept | Hoch |
| oscal_privacy_catolag_meta.rtf | RTF | Metadaten für Privacy-Kataloge | Mittel |
| Ontologie der Verantwortlichkeit.rtf | RTF | Datenschutz-Verantwortlichkeiten | Mittel |
| Verwaltungstool-OSCAL-DS.rtf | RTF | Tool-Konzept für OSCAL | Mittel |
| DataPrivacy_Tooling-Classes.rtf | RTF | Klassen-Strukturen | Mittel |
| ROPA_Entwicklung.rtf | RTF | RoPA-App Entwicklung | Hoch |
| Popa-xoev-Eu-Standards.rtf | RTF | EU-Standards Integration | Mittel |
| Standard-OSCAL-python-Modul.rtf | RTF | Python-Modul-Konzept | Mittel |
| 20250814_Aktenführungspflicht...rtf | RTF | Rechtsstaatliche Überlegungen | Niedrig |

---

## Dokument-Beschreibungen

### PROJECT_OVERVIEW.md (Lesbar)

**Inhalt**: Vollständige Projektübersicht inklusive:
- Vision und Mission
- Repository-Struktur (10 Repositories)
- Use Cases (Bürger, DPO, Auditor)
- Technologie-Stack
- Roadmap und Prioritäten

**Status**: Aktuell, umfassend

---

### OSCAL-Catalog für den Datenschutz.rtf

**Erwarteter Inhalt** (basierend auf Dateiname und Kontext):
- Konzept für DSGVO-basierte OSCAL-Kataloge
- Control-Definitionen für Datenschutz
- Integration von SDM (Standard-Datenschutzmodell)
- Mapping zu GDPR-Artikeln

**Relevanz**: Grundlage für `privacy-oscal` Repository

---

### oscal_privacy_catolag_meta.rtf

**Erwarteter Inhalt**:
- Metadaten-Schema für Privacy-Kataloge
- Custom OSCAL Properties:
  - `dp-risk-impact`
  - `dp-likelihood`
  - `citizen-title-de/en/fr`
  - `gdpr-article`
  - `implementation-level`

**Relevanz**: Definition der Custom Properties

---

### Ontologie der Verantwortlichkeit.rtf

**Erwarteter Inhalt**:
- Verantwortlichkeitsmodell nach DSGVO
- Rollen: Verantwortlicher, Auftragsverarbeiter
- Hierarchien und Beziehungen
- Mapping zu OSCAL-Components

**Relevanz**: Für RoPA und Compliance-Tracking

---

### Verwaltungstool-OSCAL-DS.rtf

**Erwarteter Inhalt**:
- Konzept für Datenschutz-Verwaltungstool
- UI/UX-Anforderungen
- Funktionale Anforderungen
- Integration mit OSCAL

**Relevanz**: Grundlage für `privacy-app` und `oscal-workbench`

---

### DataPrivacy_Tooling-Classes.rtf

**Erwarteter Inhalt**:
- Klassendiagramme für Datenschutz-Tools
- Datenmodelle
- Service-Interfaces
- TypeScript/Python-Strukturen

**Relevanz**: Für Backend-Entwicklung (`oscal-pyprivacy`)

---

### ROPA_Entwicklung.rtf

**Erwarteter Inhalt**:
- Anforderungen an RoPA-Tool (GDPR Art. 30)
- Datenmodell für Verarbeitungsverzeichnis
- Workflow für Verarbeitungseinträge
- Integration mit OSCAL-Controls

**Relevanz**: Kernkonzept für `privacy-app`

---

### Popa-xoev-Eu-Standards.rtf

**Erwarteter Inhalt**:
- EU-Interoperabilitäts-Standards
- XÖV (XML in der öffentlichen Verwaltung)
- Integration mit europäischen Frameworks
- Datenaustausch zwischen Behörden

**Relevanz**: Für zukünftige EU-Integration

---

### Standard-OSCAL-python-Modul.rtf

**Erwarteter Inhalt**:
- Konzept für `oscal-pyprivacy`
- API-Design
- Funktionen: Load, Validate, Resolve
- PyPI-Packaging

**Relevanz**: Grundlage für Python-Library

---

### 20250814_Aktenführungspflicht und Datenschutz rechtsstaatliche Überlegungen.rtf

**Erwarteter Inhalt**:
- Rechtliche Analyse
- Aktenführungspflicht vs. Löschpflicht
- Rechtsstaatliche Abwägungen
- Archivierungsanforderungen

**Relevanz**: Hintergrund für rechtliche Compliance

---

## Empfehlung

Die RTF-Dateien sollten in Markdown konvertiert werden für:
- Bessere Lesbarkeit
- Versionierung (Git-freundlich)
- Integration in die Dokumentation

**Priorität der Konvertierung**:
1. OSCAL-Catalog für den Datenschutz.rtf (Hoch)
2. ROPA_Entwicklung.rtf (Hoch)
3. oscal_privacy_catolag_meta.rtf (Mittel)
4. Standard-OSCAL-python-Modul.rtf (Mittel)
5. Andere (Niedrig)

---

**Erstellt**: 2026-02-02
**Autor**: Architecture Team
