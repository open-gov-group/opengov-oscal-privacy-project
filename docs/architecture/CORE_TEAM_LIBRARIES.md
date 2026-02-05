# Core Team Libraries – Architektur und Integration

> **Version:** 1.0.0
> **Status:** Draft
> **Zielgruppe:** Alle Entwicklungsteams (Workbench, RoPa, Crossover)

---

## 1. Übersicht

Das Core Team entwickelt zwei Python-Bibliotheken, die als Fundament für alle anderen Teams dienen:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Anwendungsteams                                  │
│    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐            │
│    │  Workbench   │    │    RoPa      │    │  Crossover   │            │
│    └──────┬───────┘    └──────┬───────┘    └──────┬───────┘            │
│           │                   │                   │                     │
│           └───────────────────┼───────────────────┘                     │
│                               ▼                                         │
│    ┌────────────────────────────────────────────────────────────────┐  │
│    │                    opengov-oscal-pyprivacy                      │  │
│    │  ┌────────────────────┐    ┌─────────────────────────────────┐ │  │
│    │  │ opengov_oscal_     │    │ opengov_oscal_pyprivacy         │ │  │
│    │  │ pycore             │    │ (Privacy-Controls, SDM, TOM)    │ │  │
│    │  │ (OSCAL Core)       │    │                                 │ │  │
│    │  └────────────────────┘    └─────────────────────────────────┘ │  │
│    └────────────────────────────────────────────────────────────────┘  │
│                               │                                         │
│                               ▼                                         │
│    ┌────────────────────────────────────────────────────────────────┐  │
│    │                    opengov-pylegal-utils                        │  │
│    │         (Normalisierung rechtlicher Referenzen)                 │  │
│    └────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

### Kernprinzipien

| Prinzip | Umsetzung |
|---------|-----------|
| **CSV-first Vocabularies** | Fachliche Taxonomien als CSV, nicht als Code |
| **Round-trip Safety** | Pydantic v2 `extra="allow"` für unbekannte Felder |
| **Zero Dependencies** | pylegal-utils ohne externe Abhängigkeiten |
| **Immutable Data** | Dataclasses mit `frozen=True` |
| **Policy ≠ Code** | Vokabulare änderbar ohne Deployment |

---

## 2. opengov-oscal-pyprivacy

### 2.1 Package-Struktur

```
opengov-oscal-pyprivacy/
├── src/
│   ├── opengov_oscal_pycore/          # OSCAL Core (allgemein)
│   │   ├── models/
│   │   │   ├── base.py                # OscalBaseModel (Pydantic v2)
│   │   │   ├── catalog.py             # Catalog, Group, Control
│   │   │   ├── metadata.py            # Metadata, Party, Role
│   │   │   └── common.py              # Property, Part, Link
│   │   ├── utils/
│   │   │   ├── prop_utils.py          # CRUD für Properties
│   │   │   ├── part_utils.py          # CRUD für Parts
│   │   │   └── control_utils.py       # Control-Operationen
│   │   └── __init__.py
│   │
│   └── opengov_oscal_pyprivacy/       # Privacy-spezifisch
│       ├── models/
│       │   └── privacy_control.py     # PrivacyControl(Control)
│       ├── vocabularies/              # CSV-basierte Taxonomien
│       │   ├── assurance_goals.csv
│       │   ├── measures.csv
│       │   ├── evidence_types.csv
│       │   ├── maturity_domains.csv
│       │   └── risk_scenarios.csv
│       ├── domain/
│       │   ├── typical_measures.py
│       │   ├── assessment_questions.py
│       │   ├── risk_scenarios.py
│       │   └── maturity_levels.py
│       └── __init__.py
│
├── tests/
└── pyproject.toml
```

### 2.2 Pydantic v2 Base Model

```python
from pydantic import BaseModel, ConfigDict

class OscalBaseModel(BaseModel):
    """
    Basis-Klasse für alle OSCAL-Modelle.

    Kritisch: extra="allow" erhält unbekannte Felder beim Round-trip.
    """
    model_config = ConfigDict(
        extra="allow",           # Unbekannte Felder behalten
        populate_by_name=True,   # Alias-Support
        validate_assignment=True # Re-Validierung bei Zuweisung
    )
```

**Warum `extra="allow"`?**

OSCAL-Kataloge können herstellerspezifische Erweiterungen enthalten. Ohne diese Einstellung würden beim Laden/Speichern Felder verloren gehen:

```python
# Beispiel: Katalog mit Custom-Extension
catalog_json = {
    "catalog": {
        "uuid": "...",
        "metadata": {...},
        "x-vendor-extension": {"custom": "data"}  # Würde ohne extra="allow" verloren gehen
    }
}
```

### 2.3 Property/Part CRUD Operations

```python
from opengov_oscal_pycore.utils import prop_utils, part_utils

# Properties hinzufügen
control = prop_utils.add_prop(
    control,
    name="assurance_goal",
    value="intervenability",
    ns="https://opengov.de/ns/privacy"
)

# Properties abfragen
goals = prop_utils.get_props_by_name(control, "assurance_goal")

# Parts hinzufügen
control = part_utils.add_part(
    control,
    id="tom-02-stmt",
    name="statement",
    prose="Die Organisation stellt technische Mechanismen bereit..."
)

# Parts nach Name filtern
statements = part_utils.get_parts_by_name(control, "statement")
```

### 2.4 CSV-basierte Vocabularies

**Beispiel: `assurance_goals.csv`**

```csv
id,label_de,label_en,description_de,sdm_reference
availability,Verfügbarkeit,Availability,"Gewährleistung der Verfügbarkeit...",SDM-D1
integrity,Integrität,Integrity,"Gewährleistung der Datenintegrität...",SDM-D2
confidentiality,Vertraulichkeit,Confidentiality,"Gewährleistung der Vertraulichkeit...",SDM-D3
transparency,Transparenz,Transparency,"Nachvollziehbarkeit der Verarbeitung...",SDM-D4
intervenability,Intervenierbarkeit,Intervenability,"Umsetzung der Betroffenenrechte...",SDM-D5
unlinkability,Nichtverkettung,Unlinkability,"Verhinderung der Profilbildung...",SDM-D6
data_minimization,Datenminimierung,Data Minimization,"Beschränkung auf das Erforderliche...",SDM-D7
```

**Zugriff über Python:**

```python
from opengov_oscal_pyprivacy.vocabularies import load_vocabulary

assurance_goals = load_vocabulary("assurance_goals")
goal = assurance_goals.get("intervenability")
print(goal.label_de)  # "Intervenierbarkeit"
print(goal.sdm_reference)  # "SDM-D5"
```

### 2.5 Privacy Control Domain Functions

```python
from opengov_oscal_pyprivacy.domain import (
    typical_measures,
    assessment_questions,
    risk_scenarios,
    maturity_levels
)

# Typische Maßnahmen für ein Gewährleistungsziel
measures = typical_measures.get_for_goal("intervenability")
# → ["Self-Service Portal", "API für Betroffenenrechte", ...]

# Assessment-Fragen generieren
questions = assessment_questions.generate(
    control_id="TOM-02",
    maturity_level=3
)
# → ["Existiert ein dokumentiertes Verfahren?", ...]

# Risiko-Szenarien für Impact-Level
scenarios = risk_scenarios.get_for_impact(
    goal="intervenability",
    impact="high"
)
# → [RiskScenario(id="RS-INT-H-01", description="...")]
```

### 2.6 Legal Reference Integration

```python
from opengov_oscal_pyprivacy.legal import normalize_reference
from opengov_pylegal_utils import parse_reference

# Integration mit pylegal-utils
ref = parse_reference("Art. 17 DSGVO")
normalized = normalize_reference(ref)
# → "EU:REG:GDPR:ART-17"

# Für OSCAL Property
control = prop_utils.add_prop(
    control,
    name="legal-reference",
    value=normalized,
    ns="https://opengov.de/ns/legal"
)
```

---

## 3. opengov-pylegal-utils

### 3.1 Package-Struktur

```
opengov-pylegal-utils/
├── src/
│   └── opengov_pylegal_utils/
│       ├── __init__.py
│       ├── parser.py              # Regex-basierter Parser
│       ├── normalizer.py          # URN-Generierung
│       ├── registry.py            # Gesetzes-Registry
│       ├── models.py              # Immutable Dataclasses
│       └── data/
│           └── laws.csv           # Gesetzes-Katalog
├── tests/
└── pyproject.toml
```

### 3.2 Immutable Data Models

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class NormSegment:
    """Ein Segment einer Norm-Referenz (z.B. Artikel, Absatz, Satz)."""
    type: str      # "article", "paragraph", "sentence", "number"
    value: str     # "17", "1", "2"

@dataclass(frozen=True)
class NormLocation:
    """Vollständige Lokalisierung innerhalb einer Norm."""
    segments: tuple[NormSegment, ...]

@dataclass(frozen=True)
class NormIdentity:
    """Identität einer Rechtsnorm."""
    jurisdiction: str  # "EU", "DE", "CH", "GB"
    type: str          # "REG", "DIR", "LAW", "ORD"
    code: str          # "GDPR", "BDSG", "TTDSG"

@dataclass(frozen=True)
class NormReference:
    """Vollständige normalisierte Referenz."""
    identity: NormIdentity
    location: NormLocation
    original_text: str

    def to_urn(self) -> str:
        """Generiert URN im Format: EU:REG:GDPR:ART-17_ABS-1"""
        ...
```

### 3.3 Parser-Architektur

Der Parser verwendet eine 4-stufige Regex-Kaskade:

```python
PATTERNS = [
    # Stufe 1: Vollständige Artikelreferenz
    # "Art. 17 Abs. 1 S. 2 DSGVO"
    (r"Art\.?\s*(\d+)\s+Abs\.?\s*(\d+)\s+S\.?\s*(\d+)\s+(\w+)",
     ["article", "paragraph", "sentence"]),

    # Stufe 2: Artikel mit mehreren Absätzen
    # "Art. 17 Abs. 1, 2 DSGVO"
    (r"Art\.?\s*(\d+)\s+Abs\.?\s*(\d+(?:,\s*\d+)*)\s+(\w+)",
     ["article", "multi_paragraph"]),

    # Stufe 3: Artikel mit einzelnem Absatz
    # "Art. 17 Abs. 1 DSGVO"
    (r"Art\.?\s*(\d+)\s+Abs\.?\s*(\d+)\s+(\w+)",
     ["article", "paragraph"]),

    # Stufe 4: Nur Artikel
    # "Art. 17 DSGVO"
    (r"Art\.?\s*(\d+)\s+(\w+)",
     ["article"])
]
```

### 3.4 Gesetzes-Registry (CSV)

**`laws.csv`**

```csv
alias,jurisdiction,type,code,full_name
DSGVO,EU,REG,GDPR,Datenschutz-Grundverordnung
GDPR,EU,REG,GDPR,General Data Protection Regulation
BDSG,DE,LAW,BDSG,Bundesdatenschutzgesetz
TTDSG,DE,LAW,TTDSG,Telekommunikation-Telemedien-Datenschutz-Gesetz
UK-GDPR,GB,REG,UKGDPR,UK General Data Protection Regulation
DSG,CH,LAW,DSG,Bundesgesetz über den Datenschutz
ePrivacy-RL,EU,DIR,EPRIVACY,ePrivacy-Richtlinie
NIS2-RL,EU,DIR,NIS2,NIS-2-Richtlinie
KRITIS-DachG,DE,LAW,KRITISDG,KRITIS-Dachgesetz
AI-Act,EU,REG,AIACT,AI Act / KI-Verordnung
CRA,EU,REG,CRA,Cyber Resilience Act
DGA,EU,REG,DGA,Data Governance Act
```

### 3.5 Nutzung

```python
from opengov_pylegal_utils import parse_reference, normalize_to_urn

# Einfache Referenz
ref = parse_reference("Art. 17 DSGVO")
print(ref.to_urn())  # "EU:REG:GDPR:ART-17"

# Komplexe Referenz
ref = parse_reference("Art. 5 Abs. 1 lit. a DSGVO")
print(ref.to_urn())  # "EU:REG:GDPR:ART-5_ABS-1_LIT-A"

# Mehrere Absätze
ref = parse_reference("Art. 17 Abs. 1, 2 DSGVO")
print(ref.to_urn())  # "EU:REG:GDPR:ART-17_ABS-1,2"

# Direkter URN-Output
urn = normalize_to_urn("§ 22 BDSG")
print(urn)  # "DE:LAW:BDSG:PARA-22"

# Bulk-Normalisierung
texts = [
    "gemäß Art. 6 Abs. 1 lit. a DSGVO",
    "nach § 26 BDSG",
    "im Sinne von Art. 4 Nr. 1 DSGVO"
]
refs = [parse_reference(t) for t in texts]
```

### 3.6 Erweiterbarkeit

Neue Gesetze werden ausschließlich über CSV hinzugefügt:

```csv
# Neues Gesetz hinzufügen
DORA,EU,REG,DORA,Digital Operational Resilience Act
```

Keine Code-Änderung erforderlich - die Registry lädt die CSV dynamisch.

---

## 4. Integrationsmuster für Teams

### 4.1 RoPa Team (privacy-mappings)

```python
# In privacy-mappings/transformers/
from opengov_oscal_pyprivacy.models import PrivacyControl
from opengov_oscal_pyprivacy.utils import prop_utils, part_utils
from opengov_pylegal_utils import normalize_to_urn

def transform_xdomea_to_oscal(xdomea_record: dict) -> PrivacyControl:
    """Transformiert xDOMEA-Record zu OSCAL Privacy Control."""

    control = PrivacyControl(
        id=generate_control_id(xdomea_record),
        title=xdomea_record["title"]
    )

    # Legal References normalisieren
    for legal_ref in xdomea_record.get("legal_basis", []):
        urn = normalize_to_urn(legal_ref)
        control = prop_utils.add_prop(
            control,
            name="legal-reference",
            value=urn
        )

    # Statement Part hinzufügen
    control = part_utils.add_part(
        control,
        name="statement",
        prose=xdomea_record["description"]
    )

    return control
```

### 4.2 Workbench Team

```python
# In workbench/catalog-builder/
from opengov_oscal_pyprivacy.vocabularies import load_vocabulary
from opengov_oscal_pyprivacy.domain import maturity_levels

def enrich_control_with_maturity(control: Control, level: int) -> Control:
    """Reichert Control mit Maturity-Informationen an."""

    maturity_vocab = load_vocabulary("maturity_domains")
    hints = maturity_levels.get_hints_for_level(level)

    control = part_utils.add_part(
        control,
        name="maturity-hints",
        prose=hints[level]
    )

    return control
```

### 4.3 Gateway Team (Cloudflare Workers)

Da die Gateway-Komponente in TypeScript/JavaScript läuft, erfolgt die Integration über JSON-Schemas, die aus den Python-Modellen generiert werden:

```python
# Schema-Export für TypeScript
from opengov_oscal_pyprivacy.models import PrivacyControl

schema = PrivacyControl.model_json_schema()
# → Wird zu TypeScript-Types konvertiert
```

```typescript
// In privacy-gateway/src/types/
import type { PrivacyControl } from './generated/privacy-control';

export function validateControl(data: unknown): PrivacyControl {
    // Validierung gegen generiertes Schema
}
```

---

## 5. Abhängigkeitsmatrix

```
┌─────────────────────────┬─────────────────────┬─────────────────────┐
│ Komponente              │ pyprivacy           │ pylegal-utils       │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│ privacy-mappings        │ ✓ (Transformation)  │ ✓ (Normalisierung)  │
│ privacy-gateway         │ ○ (JSON Schema)     │ ○ (JSON Schema)     │
│ privacy-app             │ ○ (via Gateway)     │ ○ (via Gateway)     │
│ workbench               │ ✓ (Katalog-Build)   │ ✓ (Referenzen)      │
│ security-oscal          │ ○ (Mapping-Import)  │ –                   │
└─────────────────────────┴─────────────────────┴─────────────────────┘

Legende: ✓ = direkte Abhängigkeit, ○ = indirekte Nutzung, – = keine
```

---

## 6. Versionierung und Releases

### Semantic Versioning

```
MAJOR.MINOR.PATCH
│     │     └── Bug-Fixes, keine API-Änderung
│     └──────── Neue Features, abwärtskompatibel
└────────────── Breaking Changes
```

### Release-Koordination

| pyprivacy Version | pylegal-utils Version | Kompatibilität |
|-------------------|----------------------|----------------|
| 0.1.x             | 0.1.x                | Initial Draft  |
| 0.2.x             | 0.1.x                | Stabil         |
| 1.0.x             | 1.0.x                | Production     |

### Changelog-Anforderungen

Jede Änderung an Vocabularies (CSV) oder Modellen muss im CHANGELOG dokumentiert werden, da andere Teams davon abhängen.

---

## 7. Testing-Strategie

### Unit Tests (pytest)

```python
# tests/test_legal_parser.py
import pytest
from opengov_pylegal_utils import parse_reference

@pytest.mark.parametrize("input_text,expected_urn", [
    ("Art. 17 DSGVO", "EU:REG:GDPR:ART-17"),
    ("Art. 5 Abs. 1 DSGVO", "EU:REG:GDPR:ART-5_ABS-1"),
    ("§ 22 BDSG", "DE:LAW:BDSG:PARA-22"),
])
def test_legal_normalization(input_text, expected_urn):
    ref = parse_reference(input_text)
    assert ref.to_urn() == expected_urn
```

### Round-trip Tests

```python
# tests/test_roundtrip.py
import json
from opengov_oscal_pyprivacy.models import Catalog

def test_catalog_roundtrip():
    """Stellt sicher, dass unbekannte Felder erhalten bleiben."""
    original = {
        "catalog": {
            "uuid": "...",
            "metadata": {...},
            "x-custom-extension": {"preserved": True}
        }
    }

    catalog = Catalog.model_validate(original["catalog"])
    exported = catalog.model_dump(by_alias=True)

    assert "x-custom-extension" in exported
    assert exported["x-custom-extension"]["preserved"] is True
```

---

## 8. Roadmap

### Phase 1: Foundation (aktuell)
- [x] Basis-Modelle für OSCAL Core
- [x] Legal Reference Parser
- [x] CSV-basierte Vocabularies
- [ ] Vollständige Test-Coverage

### Phase 2: Integration
- [ ] JSON Schema Export für TypeScript
- [ ] CLI-Tools für Normalisierung
- [ ] PyPI-Veröffentlichung

### Phase 3: Erweiterung
- [ ] Weitere Jurisdiktionen (AT, weitere EU-Mitgliedstaaten)
- [ ] Automatische Mapping-Generierung
- [ ] LLM-gestützte Referenz-Extraktion

---

## Anhang A: Installation

```bash
# Entwicklungs-Setup
pip install -e path/to/opengov-oscal-pyprivacy
pip install -e path/to/opengov-pylegal-utils

# Oder via requirements.txt
# -e ../opengov-oscal-pyprivacy
# -e ../opengov-pylegal-utils
```

## Anhang B: Kontakt

- **Core Team Lead:** [TBD]
- **Repository pyprivacy:** opengov-oscal-pyprivacy
- **Repository pylegal-utils:** opengov-pylegal-utils
