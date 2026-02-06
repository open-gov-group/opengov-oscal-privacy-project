# Rollen und Verantwortlichkeiten

**Version**: 1.0.0

---

## 1. Tech Lead

### Verantwortlichkeiten

- Technische Architektur-Entscheidungen treffen und dokumentieren
- Code-Qualität sicherstellen durch Reviews und Standards
- Team technisch mentoren und weiterentwickeln
- Technische Risiken identifizieren und mitigieren
- Schnittstelle zum Architecture Team

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| System Design | Expert | Skalierbare Architekturen entwerfen |
| TypeScript/JavaScript | Expert | Tiefes Verständnis der Sprache |
| Code Review | Expert | Konstruktives, lehrreiches Feedback |
| Kommunikation | Fortgeschritten | Technische Konzepte erklären können |
| Mentoring | Fortgeschritten | Wissen effektiv weitergeben |

### Zeitaufteilung

```
Code Review & Mentoring:  40%
Architektur & Design:     30%
Entwicklung:              20%
Meetings & Koordination:  10%
```

---

## 2. UI/UX Designer

### Verantwortlichkeiten

- User Research und Persona-Entwicklung
- Wireframes und High-Fidelity Designs erstellen
- Design System aufbauen und pflegen
- Accessibility (WCAG 2.1 AA) sicherstellen
- Usability Tests durchführen

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| Figma | Expert | Komponenten, Auto-Layout, Prototyping |
| Design Systems | Fortgeschritten | Skalierbare Designsysteme aufbauen |
| WCAG/Accessibility | Fortgeschritten | Barrierefreies Design |
| User Research | Mittel | Interviews, Usability Tests |
| HTML/CSS | Mittel | Design-Implementierung verstehen |

### Deliverables

- Figma Design Files (Komponenten, Screens)
- Design System Dokumentation
- Accessibility Audit Reports
- User Flow Diagramme

---

## 3. Frontend Developer

### Verantwortlichkeiten

- UI-Komponenten implementieren nach Design
- Performance optimieren (Bundle Size, FCP, TTI)
- Unit und Integration Tests schreiben
- Accessibility in Code umsetzen
- Code Reviews durchführen

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| TypeScript | Fortgeschritten | Typsicherer Code |
| React/Preact | Fortgeschritten | Komponenten, Hooks, State |
| CSS/Tailwind | Fortgeschritten | Responsive, accessible Styles |
| Testing | Fortgeschritten | Vitest, Testing Library |
| Performance | Mittel | Lighthouse, Bundle Analysis |

### Code-Qualität

- Alle Komponenten mit TypeScript typisiert
- Unit Tests für Logik (min. 80% Coverage)
- Accessibility Tests (axe-core)
- Keine ESLint Errors

---

## 4. Backend Developer

### Verantwortlichkeiten

- API-Endpoints designen und implementieren
- Datenmodelle und Datenbankschema
- Integration mit externen Services
- API-Dokumentation pflegen

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| Python/Node.js | Fortgeschritten | Backend-Entwicklung |
| REST API Design | Fortgeschritten | OpenAPI, Best Practices |
| Datenbanken | Fortgeschritten | SQL, NoSQL |
| Testing | Fortgeschritten | Unit, Integration Tests |
| Security | Mittel | OWASP, Auth, Verschlüsselung |

---

## 5. QA Engineer

### Verantwortlichkeiten

- Test-Strategie definieren und dokumentieren
- Automatisierte Tests schreiben und pflegen
- Manuelle Tests durchführen
- Bug Reports erstellen und tracken
- Quality Gates definieren und überwachen

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| Test Automation | Fortgeschritten | Playwright, Vitest |
| Test Design | Fortgeschritten | Edge Cases, Grenzwerte |
| CI/CD | Mittel | GitHub Actions, Test-Integration |
| Security Testing | Mittel | Grundlegende Security Tests |
| Accessibility Testing | Mittel | axe-core, Screen Reader |

### Test-Pyramide

```
        /\
       /E2E\        10% - Kritische User Journeys
      /------\
     /Integr. \     30% - Komponenten-Integration
    /----------\
   /   Unit     \   60% - Logik, Funktionen
  /--------------\
```

---

## 6. DevOps Engineer

### Verantwortlichkeiten

- CI/CD Pipelines aufbauen und pflegen
- Deployment-Prozesse automatisieren
- Infrastructure as Code
- Monitoring und Alerting
- Security Hardening

### Erwartete Skills

| Skill | Level | Beschreibung |
|-------|-------|--------------|
| GitHub Actions | Fortgeschritten | Workflows, Secrets, Caching |
| Docker | Mittel | Container für Builds |
| Cloud (Vercel/Netlify) | Mittel | Deployment-Plattformen |
| Security | Mittel | CSP, HTTPS, Secrets Management |
| Monitoring | Mittel | Error Tracking, Analytics |

### Verantwortliche Systeme

- GitHub Actions Workflows
- GitHub Pages Deployment
- Security Headers Konfiguration
- Dependency Updates (Dependabot)

---

## 7. Skill-Matrix Template

Team-Mitglieder dokumentieren ihre Skills in dieser Matrix:

| Skill | [Name 1] | [Name 2] | [Name 3] |
|-------|----------|----------|----------|
| TypeScript | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| React/Preact | ⭐⭐⭐ | ⭐ | ⭐⭐ |
| CSS | ⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| Testing | ⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| Accessibility | ⭐ | ⭐⭐⭐ | ⭐⭐ |
| CI/CD | ⭐⭐ | ⭐ | ⭐⭐⭐ |

**Legende**: ⭐ = Grundlagen, ⭐⭐ = Fortgeschritten, ⭐⭐⭐ = Expert

---

**Letzte Aktualisierung**: [DATUM]
