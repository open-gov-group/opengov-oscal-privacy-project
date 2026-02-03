# Architecture Decision Records (ADRs)

Dieses Verzeichnis enthält die Architektur-Entscheidungen für das OpenGov OSCAL Privacy Ecosystem.

## Was sind ADRs?

Architecture Decision Records dokumentieren wichtige Architektur-Entscheidungen zusammen mit ihrem Kontext und Konsequenzen. Sie helfen Teams zu verstehen:
- **Warum** eine Entscheidung getroffen wurde
- **Welche Alternativen** betrachtet wurden
- **Welche Konsequenzen** zu erwarten sind

## ADR-Index

| ID | Titel | Status | Datum |
|----|-------|--------|-------|
| [ADR-001](ADR-001-oscal-als-basis-standard.md) | OSCAL als Basis-Standard | Akzeptiert | 2026-02-02 |
| [ADR-002](ADR-002-multi-repository-architektur.md) | Multi-Repository-Architektur | Akzeptiert | 2026-02-02 |
| [ADR-003](ADR-003-client-side-viewer.md) | Client-Side-First für Viewer | Akzeptiert | 2026-02-02 |
| [ADR-004](ADR-004-python-backend-libraries.md) | Python für Backend | Akzeptiert | 2026-02-02 |

## ADR-Status

- **Vorgeschlagen**: Zur Diskussion
- **Akzeptiert**: Entscheidung getroffen
- **Abgelehnt**: Nicht umgesetzt
- **Ersetzt**: Durch neuere ADR ersetzt
- **Veraltet**: Nicht mehr relevant

## Neue ADR erstellen

1. Kopiere die Vorlage `_ADR-TEMPLATE.md`
2. Vergib nächste ID (z.B. ADR-005)
3. Fülle alle Abschnitte aus
4. Erstelle Pull Request für Review
5. Nach Genehmigung: Status auf "Akzeptiert" setzen

## Vorlage

```markdown
# ADR-XXX: Titel

**Status**: Vorgeschlagen
**Datum**: YYYY-MM-DD
**Entscheider**: Team
**Technische Story**: Kurzbeschreibung

---

## Kontext

Was ist das Problem? Warum müssen wir entscheiden?

## Entscheidung

Was haben wir entschieden?

## Konsequenzen

### Positiv
- ...

### Negativ
- ...

## Alternativen

### Nicht gewählt: Alternative A
- **Pro**: ...
- **Contra**: ...

## Referenzen

- Links zu relevanten Dokumenten
```
