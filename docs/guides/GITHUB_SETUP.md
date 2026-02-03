# GitHub Organisation Setup - Manuelle Anleitung

Diese Anleitung beschreibt die manuelle Einrichtung der GitHub-Organisation für das OpenGov Privacy Ecosystem.

**Alternative:** Verwenden Sie das automatische Setup-Script: `scripts/setup-github-org.sh` oder `scripts/setup-github-org.ps1`

---

## Inhaltsverzeichnis

1. [Voraussetzungen](#1-voraussetzungen)
2. [GitHub Teams erstellen](#2-github-teams-erstellen)
3. [Team-Berechtigungen setzen](#3-team-berechtigungen-setzen)
4. [Project Board erstellen](#4-project-board-erstellen)
5. [Teammitglieder hinzufügen](#5-teammitglieder-hinzufügen)
6. [CODEOWNERS in Repos kopieren](#6-codeowners-in-repos-kopieren)

---

## 1. Voraussetzungen

- Sie müssen **Owner** oder **Admin** der GitHub Organisation `open-gov-group` sein
- Alle Repositories sollten bereits erstellt sein (können aber auch später hinzugefügt werden)

---

## 2. GitHub Teams erstellen

### Schritt-für-Schritt

1. Gehen Sie zu: **https://github.com/orgs/open-gov-group/teams**
2. Klicken Sie auf **"New team"** (grüner Button)
3. Erstellen Sie folgende Teams:

| Team Name | Beschreibung | Sichtbarkeit |
|-----------|--------------|--------------|
| `steering-committee` | Strategische Entscheidungen und Budget | Secret |
| `architecture-team` | Technische Architektur und ADRs | Secret |
| `product-owner` | Fachliche Priorisierung | Secret |
| `compliance-team` | OSCAL Kataloge und Standards | Secret |
| `frontend-team` | React/TypeScript Entwicklung | Secret |
| `backend-team` | Python/FastAPI Entwicklung | Secret |
| `operations-team` | DevOps und Deployment | Secret |
| `security-team` | Security Reviews | Secret |
| `tech-leads` | Alle Team Leads | Secret |
| `devops-team` | CI/CD und Automatisierung | Secret |

### Für jedes Team:

```
Team name: [Name aus Tabelle]
Description: [Beschreibung aus Tabelle]
Team visibility: ○ Visible  ● Secret
□ Create a child team (nicht ankreuzen)
[Create team]
```

---

## 3. Team-Berechtigungen setzen

### 3.1 Über die Team-Seite

1. Gehen Sie zum Team: `https://github.com/orgs/open-gov-group/teams/[team-name]`
2. Klicken Sie auf **"Repositories"** Tab
3. Klicken Sie auf **"Add repository"**
4. Wählen Sie das Repository und die Berechtigung

### 3.2 Berechtigungsmatrix

| Repository | Team | Berechtigung |
|------------|------|--------------|
| **opengov-oscal-privacy-project** | architecture-team | Admin |
| **opengov-privacy-oscal** | compliance-team | Maintain |
| **opengov-security-oscal** | compliance-team | Maintain |
| **opengov-privacy-mappings** | compliance-team | Maintain |
| **opengov-oscal-privacy-viewer** | frontend-team | Maintain |
| **opengov-privacy-app** | tech-leads | Maintain |
| **opengov-oscal-workbench** | frontend-team | Maintain |
| **opengov-privacy-gateway** | backend-team | Maintain |
| **opengov-oscal-pyprivacy** | backend-team | Maintain |
| **opengov-pylegal-utils** | backend-team | Maintain |
| **opengov-privacy-data** | operations-team | Maintain |

### 3.3 Zusätzliche Berechtigungen

Das **architecture-team** sollte auf alle Repositories **Write**-Zugriff haben:

1. Gehen Sie zu `https://github.com/orgs/open-gov-group/teams/architecture-team/repositories`
2. Fügen Sie alle Repositories mit **Write** hinzu

---

## 4. Project Board erstellen

### 4.1 Neues Project erstellen

1. Gehen Sie zu: **https://github.com/orgs/open-gov-group/projects**
2. Klicken Sie auf **"New project"**
3. Wählen Sie **"Board"** als Template
4. Name: **"Ecosystem Roadmap"**
5. Klicken Sie auf **"Create project"**

### 4.2 Custom Fields hinzufügen

Im Project Board:

1. Klicken Sie auf **"+"** neben den Spalten
2. Wählen Sie **"+ New field"**
3. Erstellen Sie folgende Fields:

| Field Name | Typ | Optionen |
|------------|-----|----------|
| **Repository** | Single select | privacy-oscal, security-oscal, privacy-viewer, privacy-app, privacy-gateway, oscal-pyprivacy, pylegal-utils, privacy-mappings, oscal-workbench, privacy-data |
| **Team** | Single select | compliance-team, frontend-team, backend-team, operations-team, architecture-team |
| **Priority** | Single select | P0-Critical, P1-High, P2-Medium, P3-Low |
| **Phase** | Single select | Phase 1 (MVP), Phase 2 (Integration), Phase 3 (Erweiterung), Phase 4 (Enterprise) |
| **Dependencies** | Text | (für Cross-Repo Links) |

### 4.3 Spalten konfigurieren

Passen Sie die Spalten an:

```
📥 Backlog | 📋 Phase 1 | 📋 Phase 2 | 📋 Phase 3 | ✅ Done
```

### 4.4 Automatisierungen (optional)

1. Klicken Sie auf **"..."** → **"Workflows"**
2. Aktivieren Sie:
   - "Item added to project" → Status: Backlog
   - "Item closed" → Status: Done
   - "Pull request merged" → Status: Done

---

## 5. Teammitglieder hinzufügen

### 5.1 Mitglieder zu Teams hinzufügen

1. Gehen Sie zum Team: `https://github.com/orgs/open-gov-group/teams/[team-name]`
2. Klicken Sie auf **"Members"** Tab
3. Klicken Sie auf **"Add a member"**
4. Suchen Sie den GitHub-Benutzernamen
5. Wählen Sie die Rolle: **Member** oder **Maintainer**

### 5.2 Empfohlene Team-Struktur

```
steering-committee
├── Projektleiter (Maintainer)
├── IT-Leitung (Member)
└── DPO (Member)

architecture-team
├── Lead Architect (Maintainer)
├── Senior Backend Dev (Member)
├── Senior Frontend Dev (Member)
└── Compliance Architect (Member)

tech-leads (übergreifend)
├── Lead Architect
├── Frontend Lead
├── Backend Lead
└── Compliance Lead

frontend-team
├── Frontend Lead (Maintainer)
└── Frontend Developers (Member)

backend-team
├── Backend Lead (Maintainer)
└── Backend Developers (Member)

compliance-team
├── Compliance Lead (Maintainer)
├── DPO (Member)
└── Standards-Experten (Member)
```

---

## 6. CODEOWNERS in Repos kopieren

### 6.1 Template verwenden

Die CODEOWNERS-Datei aus `templates/repo-template/.github/CODEOWNERS` in jedes Sub-Repository kopieren.

### 6.2 Anpassen pro Repository

Ersetzen Sie `{PRIMARY_TEAM}` mit dem zuständigen Team:

| Repository | PRIMARY_TEAM |
|------------|--------------|
| privacy-oscal | compliance-team |
| security-oscal | compliance-team |
| privacy-mappings | compliance-team |
| privacy-viewer | frontend-team |
| privacy-app | tech-leads |
| oscal-workbench | frontend-team |
| privacy-gateway | backend-team |
| oscal-pyprivacy | backend-team |
| pylegal-utils | backend-team |
| privacy-data | operations-team |

### 6.3 Beispiel CODEOWNERS für privacy-viewer

```
# CODEOWNERS für privacy-viewer

# Globaler Owner
*                           @open-gov-group/frontend-team

# Architecture Review für kritische Änderungen
/docs/                      @open-gov-group/frontend-team @open-gov-group/architecture-team
/.github/                   @open-gov-group/frontend-team @open-gov-group/architecture-team
/src/components/oscal/      @open-gov-group/frontend-team @open-gov-group/compliance-team
```

---

## 7. Verifizierung

### Checkliste

- [ ] Alle 10 Teams erstellt
- [ ] Team-Berechtigungen für alle existierenden Repositories gesetzt
- [ ] Project Board "Ecosystem Roadmap" erstellt
- [ ] Custom Fields im Project Board konfiguriert
- [ ] Mindestens ein Mitglied pro Team hinzugefügt
- [ ] CODEOWNERS in privacy-project Repository vorhanden

### Test: CODEOWNERS funktioniert

1. Erstellen Sie einen Test-PR
2. Prüfen Sie, ob automatisch Reviewer zugewiesen werden
3. Löschen Sie den Test-PR

---

## Troubleshooting

### "Team not found" bei CODEOWNERS

- Stellen Sie sicher, dass der Team-Name exakt stimmt (case-sensitive)
- Das Team muss mindestens **Read**-Zugriff auf das Repository haben

### Keine automatischen Reviewer

- CODEOWNERS muss im Default-Branch sein (main)
- Die Datei muss in `.github/CODEOWNERS` oder `CODEOWNERS` liegen
- Branch Protection Rules müssen "Require review from Code Owners" aktiviert haben

### Project Board nicht sichtbar

- Prüfen Sie die Sichtbarkeits-Einstellungen des Projects
- Organisation members sollten Zugriff haben

---

**Fragen?** Öffnen Sie ein Issue in [privacy-project](https://github.com/open-gov-group/opengov-oscal-privacy-project/issues)

---

**Letzte Aktualisierung**: 2026-02-03
