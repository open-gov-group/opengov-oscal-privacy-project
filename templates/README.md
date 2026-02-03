# Repository Templates

Diese Templates sollten in allen Sub-Repositories des OpenGov Privacy Ecosystems verwendet werden, um Konsistenz zu gewährleisten.

## Inhalt

```
templates/
└── repo-template/
    ├── README-TEMPLATE.md          # Anpassen für jedes Repo
    └── .github/
        ├── CODEOWNERS              # Anpassen: {PRIMARY_TEAM}
        ├── PULL_REQUEST_TEMPLATE.md
        └── ISSUE_TEMPLATE/
            ├── bug_report.md
            └── feature_request.md
```

## Verwendung

### Neues Repository einrichten

1. Repository in der GitHub Organisation erstellen
2. Template-Dateien kopieren:
   ```bash
   cp -r templates/repo-template/.github /path/to/new-repo/
   cp templates/repo-template/README-TEMPLATE.md /path/to/new-repo/README.md
   ```
3. Platzhalter ersetzen:
   - `{REPO_NAME}` → Name des Repositories
   - `{STATUS}` → Active, Alpha, MVP, etc.
   - `{KURZBESCHREIBUNG}` → Was macht dieses Repo?
   - `{TEAM}` → Verantwortliches GitHub Team
   - `{PRIMARY_TEAM}` → Team für CODEOWNERS
   - `{DEPENDENCIES}` → Abhängigkeiten zu anderen Repos
   - `{DEPENDENTS}` → Repos die dieses nutzen
   - `{DATE}` → Aktuelles Datum

### Platzhalter pro Repository

| Repository | PRIMARY_TEAM | STATUS |
|------------|--------------|--------|
| privacy-oscal | compliance-team | Active |
| security-oscal | compliance-team | Planned |
| privacy-mappings | compliance-team | Partial |
| privacy-viewer | frontend-team | Alpha |
| privacy-app | tech-leads | MVP |
| oscal-workbench | frontend-team | Planned |
| privacy-gateway | backend-team | Planned |
| oscal-pyprivacy | backend-team | Active |
| pylegal-utils | backend-team | Planned |
| privacy-data | operations-team | In-App |

## Aktualisieren

Wenn Templates geändert werden, sollten die Änderungen in alle Sub-Repositories propagiert werden:

```bash
# Beispiel-Script für Update aller Repos
repos=(
  "privacy-oscal"
  "privacy-viewer"
  "privacy-app"
  # ...
)

for repo in "${repos[@]}"; do
  cp .github/PULL_REQUEST_TEMPLATE.md "../$repo/.github/"
  # Commit und Push
done
```

---

**Verantwortlich**: Architecture Team
