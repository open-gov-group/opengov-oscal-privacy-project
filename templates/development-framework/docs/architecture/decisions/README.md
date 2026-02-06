# Architecture Decision Records (ADRs)

Dieses Verzeichnis enthält Architecture Decision Records (ADRs) - kurze Dokumente, die wichtige Architekturentscheidungen und deren Begründungen festhalten.

## Was sind ADRs?

ADRs dokumentieren:
- **Warum** eine Entscheidung getroffen wurde (Kontext)
- **Was** entschieden wurde (Entscheidung)
- **Welche Konsequenzen** sich daraus ergeben (Auswirkungen)

## Warum ADRs?

- **Wissenstransfer**: Neue Team-Mitglieder verstehen, warum Dinge so sind
- **Vermeidung von Wiederholungen**: Wir diskutieren nicht dieselben Themen erneut
- **Nachvollziehbarkeit**: Entscheidungen können später validiert werden
- **Verantwortlichkeit**: Klare Zuordnung von Entscheidungen

## ADR Status

| Status | Bedeutung |
|--------|-----------|
| `Proposed` | Vorgeschlagen, in Diskussion |
| `Accepted` | Angenommen, wird umgesetzt |
| `Deprecated` | Veraltet, sollte nicht mehr befolgt werden |
| `Superseded` | Ersetzt durch neueres ADR |

## ADR Index

| Nr. | Titel | Status | Datum |
|-----|-------|--------|-------|
| 001 | [Beispiel: UI Framework Auswahl] | Accepted | YYYY-MM-DD |
| ... | ... | ... | ... |

## Neues ADR erstellen

1. Kopiere `ADR_TEMPLATE.md`
2. Benenne die Datei: `ADR_XXX_kurzer_titel.md`
3. Fülle alle Abschnitte aus
4. Erstelle PR für Review
5. Nach Akzeptanz: Status auf `Accepted` setzen

## Namenskonvention

```
ADR_XXX_kurzer_beschreibender_name.md

Beispiele:
ADR_001_preact_als_ui_framework.md
ADR_002_css_custom_properties_fuer_theming.md
ADR_003_vitest_als_test_framework.md
```

## Wann ein ADR schreiben?

Schreibe ein ADR wenn:
- Du eine Technologie-Entscheidung triffst
- Du eine Architektur-Entscheidung triffst
- Du von einem etablierten Pattern abweichst
- Die Entscheidung schwer rückgängig zu machen ist
- Mehrere valide Alternativen existieren

## Template

Siehe [ADR_TEMPLATE.md](./ADR_TEMPLATE.md) für das Standard-Template.
