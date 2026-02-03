# Beitragsrichtlinien / Contributing Guidelines

**Sprache / Language**: Deutsch (primär) | English (welcome)

---

## Willkommen!

Vielen Dank für Ihr Interesse am OpenGov OSCAL Privacy Ecosystem! Wir freuen uns über jeden Beitrag - sei es Code, Dokumentation, Feedback oder Ideen.

---

## Wie kann ich beitragen?

### 1. Issues erstellen

- **Bug-Reports**: Beschreiben Sie das Problem, Schritte zur Reproduktion und erwartetes Verhalten
- **Feature-Requests**: Erklären Sie den Use-Case und den erwarteten Nutzen
- **Fragen**: Nutzen Sie GitHub Discussions für allgemeine Fragen

### 2. Pull Requests einreichen

1. **Fork** des Repositories erstellen
2. **Branch** erstellen: `git checkout -b feature/mein-feature`
3. **Änderungen** vornehmen und testen
4. **Commit** mit aussagekräftiger Message
5. **Pull Request** erstellen

### 3. Dokumentation verbessern

- Tippfehler korrigieren
- Erklärungen verbessern
- Übersetzungen beitragen (DE, EN, FR)
- Diagramme und Beispiele hinzufügen

### 4. OSCAL-Kataloge erweitern

- Neue Controls vorschlagen
- Mappings zu Standards beitragen
- Bürgerfreundliche Beschreibungen verbessern

---

## Code-Standards

### Commit Messages

Wir folgen [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: Neues Feature
- `fix`: Bugfix
- `docs`: Dokumentation
- `style`: Formatierung (kein Code-Change)
- `refactor`: Code-Umstrukturierung
- `test`: Tests hinzufügen/ändern
- `chore`: Build, Dependencies, etc.

**Beispiele:**
```
feat(catalog): Add GDPR Article 17 controls
fix(viewer): Correct rendering of nested controls
docs(readme): Update installation instructions
```

### Code-Style

| Bereich | Standard |
|---------|----------|
| **TypeScript/React** | ESLint + Prettier (Projektconfig) |
| **Python** | Black + isort + flake8 |
| **Markdown** | markdownlint |
| **OSCAL JSON** | OSCAL 1.1.2 Schema Validation |

### Branch-Naming

```
feature/kurze-beschreibung
fix/issue-nummer-beschreibung
docs/dokumentations-thema
```

---

## Pull Request Checkliste

- [ ] Code folgt den Projektstandards
- [ ] Tests hinzugefügt/aktualisiert (falls zutreffend)
- [ ] Dokumentation aktualisiert (falls zutreffend)
- [ ] Commit Messages folgen Conventional Commits
- [ ] OSCAL-Änderungen gegen Schema validiert
- [ ] Keine sensiblen Daten enthalten

---

## Review-Prozess

1. **Automatische Checks**: CI/CD prüft Formatierung, Tests, Schema-Validierung
2. **Code Review**: Mindestens ein Teammitglied reviewed
3. **Fachliche Prüfung**: Bei OSCAL-Katalog-Änderungen zusätzlich durch Compliance-Team
4. **Merge**: Nach Approval durch Maintainer

### Review-Kriterien

- **Korrektheit**: Funktioniert der Code wie erwartet?
- **Klarheit**: Ist der Code verständlich?
- **Konsistenz**: Passt er zum bestehenden Stil?
- **Vollständigkeit**: Sind alle Aspekte berücksichtigt?

---

## Spezielle Beiträge

### OSCAL-Kataloge

Bei Änderungen an OSCAL-Katalogen beachten Sie:

1. **Schema-Konformität**: Validieren gegen OSCAL 1.1.2
2. **Property-Struktur**: Nutzen Sie die definierten `props`:
   - `citizen-title-de`, `citizen-title-en`: Bürgerfreundliche Titel
   - `dp-risk-impact`: Schutzniveau (1-5)
   - `dp-likelihood`: Eintrittswahrscheinlichkeit (1-5)
   - `implementation-level`: baseline | standard | enhanced
   - `gdpr-article`: DSGVO-Artikel-Referenz
3. **Mapping-Qualität**: Dokumentieren Sie Framework-Mappings mit Confidence-Level

### Mappings

Bei Framework-Mappings:

- Geben Sie `mapping-type` an: `equivalent`, `related`, `partial`
- Dokumentieren Sie `confidence` (0.0-1.0)
- Fügen Sie Erläuterungen in `notes` hinzu

---

## Kommunikation

| Kanal | Zweck |
|-------|-------|
| **GitHub Issues** | Bugs, Features, konkrete Aufgaben |
| **GitHub Discussions** | Fragen, Ideen, RFCs |
| **Pull Requests** | Code-Review, Feedback |

### Verhaltenskodex

- Respektvoller Umgang
- Konstruktive Kritik
- Offenheit für verschiedene Perspektiven
- Fokus auf das Projektziel

---

## Entwickler-Setup

### Voraussetzungen

- Node.js 18+ (Frontend)
- Python 3.10+ (Backend)
- Git

### Schnellstart

```bash
# Repository klonen
git clone https://github.com/open-gov-group/opengov-oscal-privacy-project.git
cd opengov-oscal-privacy-project

# Dokumentation lokal ansehen
# (kein Build nötig für Markdown)
```

Für spezifische Repositories siehe deren jeweilige README.md.

---

## Anerkennung

Alle Beitragenden werden in den Release Notes erwähnt. Signifikante Beiträge werden im CONTRIBUTORS.md aufgeführt.

---

## Fragen?

- Öffnen Sie eine [GitHub Discussion](https://github.com/open-gov-group/opengov-oscal-privacy-project/discussions)
- Lesen Sie die [Architektur-Dokumentation](docs/architecture/README.md)
- Schauen Sie in die [ADRs](docs/architecture/decisions/) für Hintergrund zu Entscheidungen

---

**Vielen Dank für Ihren Beitrag zum OpenGov Privacy Ecosystem!**
