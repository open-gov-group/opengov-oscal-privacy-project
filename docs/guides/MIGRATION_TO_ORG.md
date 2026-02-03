# Migration zu GitHub Organisation

**Status**: 📅 Geplant für Q2/Q3 2026
**Voraussetzung**: Erfolgreiche Stakeholder-Abstimmung

---

## Übersicht

Dieses Dokument beschreibt den geplanten Migrationspfad von einem GitHub User-Account (`open-gov-group`) zu einer vollwertigen GitHub Organisation.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         MIGRATIONS-TIMELINE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  JETZT              Q2 2026              Q2/Q3 2026           Q3 2026       │
│    │                   │                     │                   │          │
│    ▼                   ▼                     ▼                   ▼          │
│  ┌─────┐           ┌─────┐              ┌─────┐             ┌─────┐        │
│  │Start│           │Stake│              │Migra│             │Teams│        │
│  │phase│──────────▶│holder│────────────▶│tion │────────────▶│Setup│        │
│  │     │           │Go   │              │     │             │     │        │
│  └─────┘           └─────┘              └─────┘             └─────┘        │
│                                                                             │
│  User-Account      Entscheidung         Neue Org +          Vollständige   │
│  @open-gov-group   zur Migration        Repo-Transfer       Team-Struktur  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 1. Voraussetzungen vor Migration

### 1.1 Stakeholder-Abstimmung

- [ ] Alle relevanten Stakeholder informiert
- [ ] Unterstützung für das Projekt bestätigt
- [ ] Budget/Ressourcen für Weiterentwicklung gesichert
- [ ] Organisations-Name abgestimmt

### 1.2 Custom Domain (kritisch!)

**Vor der Migration unbedingt einrichten:**

| Dienst | Aktuelle URL | Neue Custom Domain |
|--------|--------------|-------------------|
| MVP App | `open-gov-group.github.io/opengov-privacy-app` | `app.opengov-privacy.eu` |
| Dokumentation | `open-gov-group.github.io/...` | `docs.opengov-privacy.eu` |

**Schritte:**
1. Domain registrieren/bereitstellen
2. DNS-Einträge konfigurieren (CNAME)
3. In GitHub Pages einrichten
4. HTTPS aktivieren
5. **Testen** vor Migration

### 1.3 Kommunikation

- [ ] Ankündigung an alle Nutzer/Forks
- [ ] Dokumentation der neuen URLs
- [ ] Redirect-Strategie festlegen

---

## 2. Migrations-Schritte

### Phase 1: Vorbereitung (1 Woche vor Migration)

```markdown
## Checkliste

- [ ] Custom Domains funktionieren
- [ ] Alle offenen PRs gemerged oder geschlossen
- [ ] Backup aller Repositories (git clone --mirror)
- [ ] GitHub Actions Secrets dokumentiert
- [ ] Externe Integrationen inventarisiert
- [ ] Stakeholder über Zeitpunkt informiert
```

### Phase 2: Organisation erstellen

1. **Neuen Account erstellen** (falls nötig für Org-Admin)
   - Da `open-gov-group` die Org wird, brauchen Sie einen persönlichen Account

2. **Organisation erstellen**
   ```
   https://github.com/organizations/new
   ```
   - Name: `opengov-privacy` (oder abgestimmter Name)
   - Plan: Free (für Open Source)
   - Billing E-Mail eintragen

### Phase 3: Repositories transferieren

Für jedes Repository:

1. Gehen Sie zu: `https://github.com/open-gov-group/REPO-NAME/settings`
2. Scrollen Sie zu "Danger Zone"
3. Klicken Sie auf "Transfer"
4. Geben Sie die neue Organisation ein
5. Bestätigen Sie

**Reihenfolge:**
1. `opengov-oscal-privacy-project` (zuerst - zentrale Doku)
2. `opengov-privacy-oscal` (Kataloge)
3. `opengov-oscal-pyprivacy` (Library)
4. `opengov-privacy-app` (MVP)
5. Restliche Repositories

**Hinweis:** GitHub richtet automatisch Redirects ein (1 Jahr gültig)

### Phase 4: GitHub Teams einrichten

Nach Transfer das Setup-Script ausführen:

```powershell
# Windows
.\scripts\setup-github-org.ps1 -Org "opengov-privacy"

# macOS/Linux
./scripts/setup-github-org.sh --org opengov-privacy
```

Oder manuell: Siehe [GITHUB_SETUP.md](GITHUB_SETUP.md)

### Phase 5: Nacharbeiten

```markdown
## Post-Migration Checkliste

- [ ] Alle Repositories erfolgreich transferiert
- [ ] GitHub Teams erstellt und Mitglieder zugewiesen
- [ ] CODEOWNERS in allen Repos aktualisiert
- [ ] GitHub Actions Secrets neu konfiguriert
- [ ] Project Board erstellt
- [ ] Custom Domains verifiziert
- [ ] Externe Links aktualisiert (Docs, Blogs, etc.)
- [ ] npm/PyPI Pakete aktualisiert (falls vorhanden)
- [ ] Forks informiert
```

---

## 3. Risiken und Mitigationen

| Risiko | Wahrscheinlichkeit | Auswirkung | Mitigation |
|--------|-------------------|------------|------------|
| GitHub Pages URL bricht | Hoch | Hoch | Custom Domain VOR Migration |
| Externe Links brechen | Mittel | Mittel | GitHub Redirects (1 Jahr) |
| Actions Secrets fehlen | Hoch | Mittel | Vorher dokumentieren |
| Forks verlieren Sync | Niedrig | Niedrig | Kommunikation, Redirects |

---

## 4. Rollback-Plan

Falls kritische Probleme auftreten:

1. **Repositories zurück-transferieren** (innerhalb 24h einfach)
2. **Custom Domain zurücksetzen**
3. **Kommunikation** an Nutzer

---

## 5. Nach der Migration

### 5.1 CODEOWNERS aktualisieren

In allen Repositories:

```diff
- *   @open-gov-group
+ *   @opengov-privacy/architecture-team
```

### 5.2 Dokumentation aktualisieren

- README.md in allen Repos
- TEAMS.md → Version 2.0
- Alle internen Links prüfen

### 5.3 Externe Kommunikation

- Blog-Post zur Migration
- Newsletter an Stakeholder
- Social Media Ankündigung

---

## 6. Zeitplan-Template

| Woche | Aktivität | Verantwortlich |
|-------|-----------|----------------|
| W-2 | Custom Domain einrichten | DevOps |
| W-1 | Backup, Secrets dokumentieren | DevOps |
| W-1 | Stakeholder informieren | Projektleitung |
| W0 | Organisation erstellen | Admin |
| W0 | Repositories transferieren | Admin |
| W0 | Teams einrichten | Admin |
| W+1 | Nacharbeiten, Tests | Alle |
| W+1 | Kommunikation | Projektleitung |

---

## 7. Ressourcen

- **Setup-Script (Windows)**: `scripts/setup-github-org.ps1`
- **Setup-Script (Bash)**: `scripts/setup-github-org.sh`
- **Manuelle Anleitung**: `docs/guides/GITHUB_SETUP.md`
- **Templates**: `templates/repo-template/`

---

## 8. Kontakt

Bei Fragen zur Migration:
- Issue erstellen: [privacy-project/issues](https://github.com/open-gov-group/opengov-oscal-privacy-project/issues)
- Label: `migration`

---

**Letzte Aktualisierung**: 2026-02-03
**Status**: Warten auf Stakeholder-Abstimmung
