# ADR-004: Python für Backend-Libraries und Services

**Status**: Akzeptiert
**Datum**: 2026-02-02
**Entscheider**: Architecture Team, Backend Team
**Technische Story**: Wahl der Programmiersprache für Backend-Komponenten

---

## Kontext

Das Ecosystem benötigt Backend-Komponenten für:
- OSCAL-Parsing und -Validierung
- Profile-Resolution (Imports auflösen)
- Control-Mapping-Logik
- REST API Gateway
- Rechtstext-Verarbeitung

Die Frage ist: **Welche Sprache für Backend-Komponenten?**

---

## Entscheidung

Wir verwenden **Python 3.10+** für alle Backend-Libraries und Services.

### Komponenten

| Komponente | Framework | Version |
|------------|-----------|---------|
| `oscal-pyprivacy` | Pure Python | 3.10+ |
| `pylegal-utils` | Pure Python | 3.10+ |
| `privacy-gateway` | FastAPI | 0.100+ |

### Tech Stack

```
┌─────────────────────────────────────────────────────────────────┐
│                      Python Backend Stack                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                    privacy-gateway                           ││
│  │                                                              ││
│  │  FastAPI + Uvicorn (ASGI)                                   ││
│  │  • OpenAPI 3.0 Auto-Dokumentation                           ││
│  │  • Pydantic Validation                                      ││
│  │  • Async/Await Support                                      ││
│  └─────────────────────────────────────────────────────────────┘│
│                              │                                   │
│                              v                                   │
│  ┌──────────────────────────────────────────────────────────── ┐│
│  │                    Core Libraries                            ││
│  │                                                              ││
│  │  ┌─────────────────────┐  ┌─────────────────────┐           ││
│  │  │   oscal-pyprivacy   │  │   pylegal-utils     │           ││
│  │  │                     │  │                     │           ││
│  │  │ • CatalogLoader     │  │ • GDPRParser        │           ││
│  │  │ • ProfileResolver   │  │ • ArticleExtractor  │           ││
│  │  │ • ControlMapper     │  │ • LegalNormalizer   │           ││
│  │  │ • OSCALValidator    │  │                     │           ││
│  │  └─────────────────────┘  └─────────────────────┘           ││
│  └─────────────────────────────────────────────────────────────┘│
│                              │                                   │
│                              v                                   │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                    Foundation                                ││
│  │                                                              ││
│  │  • pydantic (Validation)                                    ││
│  │  • httpx (HTTP Client)                                      ││
│  │  • pytest (Testing)                                         ││
│  │  • mypy (Type Checking)                                     ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Gründe für Python

| Kriterium | Python | Node.js | Go | Rust |
|-----------|--------|---------|-----|------|
| **Lernkurve** | Niedrig | Mittel | Hoch | Sehr hoch |
| **JSON-Handling** | Exzellent | Exzellent | Gut | Mittel |
| **Data Science** | Beste | Begrenzt | Begrenzt | Begrenzt |
| **Typing** | Gut (3.10+) | TS nötig | Stark | Stark |
| **Verfügbarkeit** | Sehr hoch | Hoch | Mittel | Niedrig |
| **API Framework** | FastAPI | Express | Gin | Actix |
| **OSCAL Tools** | vorhanden | begrenzt | keine | keine |

### Hauptgründe

1. **Team-Expertise**: Backend-Team kennt Python
2. **Data Processing**: JSON/XML-Verarbeitung ist Pythons Stärke
3. **Pydantic**: Perfekt für OSCAL-Datenmodelle
4. **FastAPI**: Modern, schnell, automatische Docs
5. **Type Hints**: Python 3.10+ hat gutes Typing
6. **PyPI**: Einfache Distribution der Libraries

---

## Konsequenzen

### Positiv

- **Schnelle Entwicklung**: Python ist produktiv
- **Gutes Ökosystem**: Libraries für alles verfügbar
- **FastAPI**: Automatische OpenAPI-Dokumentation
- **Type Safety**: Pydantic validiert zur Laufzeit
- **Testing**: pytest ist mächtig und einfach

### Negativ

- **Performance**: Langsamer als Go/Rust (aber schnell genug)
- **Deployment**: Größere Container als Go
- **Concurrency**: GIL limitiert Multi-Threading

### Mitigationsmaßnahmen

1. **Async/Await**: FastAPI + Uvicorn für Concurrency
2. **Caching**: Redis für häufige Anfragen
3. **Profiling**: Hotspots identifizieren und optimieren
4. **Optional: Go**: Für performance-kritische Teile später

---

## Code-Stil

```python
# Example: oscal-pyprivacy

from pydantic import BaseModel
from typing import Optional, List

class OSCALControl(BaseModel):
    """OSCAL Control mit OpenGov Privacy Erweiterungen."""

    id: str
    title: str
    description: str
    gdpr_articles: Optional[List[str]] = None
    citizen_title_de: Optional[str] = None
    implementation_level: str = "standard"

    class Config:
        extra = "allow"  # Erlaube zusätzliche OSCAL-Properties

async def load_catalog(url: str) -> OSCALCatalog:
    """Lädt OSCAL-Katalog von URL."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        data = response.json()
        return OSCALCatalog.model_validate(data)
```

---

## Versionsanforderungen

| Paket | Mindestversion | Grund |
|-------|----------------|-------|
| Python | 3.10 | Union Types, Pattern Matching |
| FastAPI | 0.100 | Pydantic v2 Support |
| Pydantic | 2.0 | Performance, neue API |
| httpx | 0.24 | Async HTTP |
| pytest | 7.0 | Modern Testing |

---

## Alternativen

### Nicht gewählt: Node.js/TypeScript

- **Pro**: Gleiche Sprache wie Frontend
- **Contra**: JSON-Handling weniger elegant, keine Pydantic

### Nicht gewählt: Go

- **Pro**: Schnell, kleine Binaries
- **Contra**: Weniger produktiv, Team kennt es nicht

### Nicht gewählt: Rust

- **Pro**: Sehr schnell, memory-safe
- **Contra**: Lernkurve zu steil, Overkill für unsere Anforderungen

---

## Referenzen

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [MASTER_BLUEPRINT.md](../MASTER_BLUEPRINT.md)
