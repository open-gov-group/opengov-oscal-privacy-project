# Kommunikation im OpenGov Privacy Ecosystem

**Stand**: 2026-02-03
**Phase**: Startphase

---

## Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    KOMMUNIKATIONSKANÄLE                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   DISCUSSIONS   │  │     ISSUES      │  │    PROJECTS     │             │
│  │                 │  │                 │  │                 │             │
│  │  💬 Diskussion  │  │  🐛 Bugs        │  │  📋 Planung     │             │
│  │  💡 Ideen       │  │  ✨ Features    │  │  📊 Status      │             │
│  │  📢 Ankündig.   │  │  📝 Tasks       │  │  🔄 Workflow    │             │
│  │  ❓ Fragen      │  │                 │  │                 │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  URL: github.com/open-gov-group/opengov-oscal-privacy-project              │
│        └─> /discussions    └─> /issues         └─> /projects               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 1. GitHub Discussions

**URL**: https://github.com/open-gov-group/opengov-oscal-privacy-project/discussions

### Wann nutzen?

| Situation | → Discussions |
|-----------|---------------|
| Architektur-Frage diskutieren | ✅ Ja |
| Neue Idee vorstellen | ✅ Ja |
| Feedback einholen | ✅ Ja |
| Ankündigung machen | ✅ Ja |
| Allgemeine Frage stellen | ✅ Ja |
| Konkreten Bug melden | ❌ Nein → Issue |
| Spezifische Aufgabe zuweisen | ❌ Nein → Issue |

### Kategorien

| Kategorie | Symbol | Verwendung |
|-----------|--------|------------|
| **📣 Announcements** | 📣 | Wichtige Ankündigungen, Releases, Meilensteine |
| **💡 Ideas** | 💡 | Neue Feature-Ideen, Verbesserungsvorschläge |
| **🏗️ Architecture** | 🏗️ | Architektur-Diskussionen, RFCs, Design-Entscheidungen |
| **❓ Q&A** | ❓ | Fragen & Antworten, Hilfe |
| **🗣️ General** | 🗣️ | Allgemeine Diskussionen |
| **🎉 Show & Tell** | 🎉 | Demos, Erfolge, Showcase |

### Best Practices

```markdown
## Gute Discussion erstellen

1. **Aussagekräftiger Titel**
   ❌ "Frage"
   ✅ "RFC: Sollen wir Redis für Caching verwenden?"

2. **Kontext geben**
   - Was ist das Problem/die Idee?
   - Warum ist es relevant?
   - Was sind mögliche Lösungen?

3. **Richtige Kategorie wählen**
   - Architecture für technische Diskussionen
   - Ideas für neue Features
   - Q&A für konkrete Fragen

4. **Labels verwenden** (falls verfügbar)
   - `area:frontend`, `area:backend`, etc.
```

---

## 2. GitHub Issues

**URL**: https://github.com/open-gov-group/opengov-oscal-privacy-project/issues

### Wann nutzen?

| Situation | → Issue |
|-----------|---------|
| Bug melden | ✅ Ja |
| Feature Request (konkret) | ✅ Ja |
| Aufgabe dokumentieren | ✅ Ja |
| Arbeitspaket tracken | ✅ Ja |
| Diskussion starten | ❌ Nein → Discussion |
| Allgemeine Frage | ❌ Nein → Discussion |

### Issue Labels

| Label | Farbe | Verwendung |
|-------|-------|------------|
| `bug` | 🔴 red | Fehler/Bugs |
| `enhancement` | 🔵 blue | Verbesserungen |
| `documentation` | 📝 | Dokumentation |
| `good first issue` | 🟢 green | Einsteigerfreundlich |
| `help wanted` | 🟡 yellow | Hilfe benötigt |
| `area:architecture` | 🟣 purple | Architektur |
| `area:frontend` | 🔵 blue | Frontend |
| `area:backend` | 🟢 green | Backend |
| `area:compliance` | 🟠 orange | Compliance/Kataloge |
| `priority:high` | 🔴 | Hohe Priorität |
| `priority:low` | ⚪ | Niedrige Priorität |

### Issue Templates

Beim Erstellen eines Issues stehen Templates zur Verfügung:
- **Bug Report** - Für Fehlermeldungen
- **Feature Request** - Für neue Features

---

## 3. GitHub Projects

**URL**: https://github.com/open-gov-group/opengov-oscal-privacy-project/projects

### Repository Project Board

Für die Aufgabenplanung:

```
📥 Backlog → 📋 To Do → 🔄 In Progress → 👀 Review → ✅ Done
```

### Wann nutzen?

- Sprint-Planung
- Aufgaben-Übersicht
- Fortschritts-Tracking
- Priorisierung

---

## 4. Entscheidungsbaum

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    WO POSTE ICH WAS?                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  START: Was möchte ich tun?                                                 │
│         │                                                                   │
│         ├─── Bug melden ──────────────────────────► ISSUE (bug)            │
│         │                                                                   │
│         ├─── Konkrete Aufgabe ────────────────────► ISSUE (task)           │
│         │                                                                   │
│         ├─── Feature vorschlagen ─┬─ Konkret? ────► ISSUE (enhancement)    │
│         │                         └─ Diskussion? ─► DISCUSSION (Ideas)     │
│         │                                                                   │
│         ├─── Architektur-Frage ───────────────────► DISCUSSION (Arch.)     │
│         │                                                                   │
│         ├─── Allgemeine Frage ────────────────────► DISCUSSION (Q&A)       │
│         │                                                                   │
│         ├─── Ankündigung machen ──────────────────► DISCUSSION (Announce)  │
│         │                                                                   │
│         └─── Demo/Erfolg teilen ──────────────────► DISCUSSION (Show&Tell) │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Cross-Repository Kommunikation

### Bei Themen, die mehrere Repos betreffen:

1. **Zentrale Discussion** in `opengov-oscal-privacy-project` erstellen
2. **Verlinken** aus den betroffenen Repos:
   ```markdown
   Siehe Diskussion: open-gov-group/opengov-oscal-privacy-project/discussions/123
   ```
3. **Bei Entscheidung**: ADR erstellen in `docs/architecture/decisions/`

### Beispiel: Feature betrifft Viewer und Gateway

```markdown
# In der zentralen Discussion:

## Betroffene Repositories
- [ ] privacy-viewer (Frontend-Änderungen)
- [ ] privacy-gateway (API-Änderungen)

## Tracking Issues
- privacy-viewer#45
- privacy-gateway#23
```

---

## 6. Benachrichtigungen einrichten

### Empfohlene Einstellungen

1. Gehen Sie zu: https://github.com/settings/notifications

2. **Watching** für das zentrale Repo:
   - `opengov-oscal-privacy-project` → "All Activity" oder "Discussions"

3. **Participating**: Automatisch bei @mentions und Antworten

### Per E-Mail oder Web?

| Einstellung | Empfehlung |
|-------------|------------|
| Discussions | E-Mail (um nichts zu verpassen) |
| Issues (assigned) | E-Mail |
| PRs (review requested) | E-Mail |
| Alles andere | Web-Notifications |

---

## 7. Schnelllinks

| Ressource | Link |
|-----------|------|
| **Discussions** | [/discussions](https://github.com/open-gov-group/opengov-oscal-privacy-project/discussions) |
| **Neue Discussion** | [/discussions/new](https://github.com/open-gov-group/opengov-oscal-privacy-project/discussions/new) |
| **Issues** | [/issues](https://github.com/open-gov-group/opengov-oscal-privacy-project/issues) |
| **Neues Issue** | [/issues/new](https://github.com/open-gov-group/opengov-oscal-privacy-project/issues/new/choose) |
| **Projects** | [/projects](https://github.com/open-gov-group/opengov-oscal-privacy-project/projects) |

---

**Fragen?** Erstellen Sie eine Discussion in der Kategorie "Q&A"!
