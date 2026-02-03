# OSCAL Part Structures - Technical Reference

**Purpose**: Clarify the correct OSCAL part structures used in the OpenGov Privacy Catalog
**Last Updated**: 2026-01-30
**Status**: ✅ Verified against actual TOM-02 control

---

## Overview

This document clarifies the **correct OSCAL part structures** used in the `open_privacy_catalog_risk.json` catalog. The structures were verified from the TOM-02 control sample provided by the Backend Developer.

**Key Principle**: Most structured parts use a **parent-child pattern** where:
- Parent part defines the category (e.g., `typical-measures`)
- Child sub-parts contain individual items (e.g., `typical-measure` - singular!)

---

## 1. Statement Part

**Structure**: Simple part with prose

```json
{
  "id": "TOM-02_smt",
  "name": "statement",
  "prose": "Daten sollen bei Speicherung und Übertragung verschlüsselt werden."
}
```

**Parsing**:
```typescript
const statementPart = control.parts?.find(p => p.name === 'statement');
const prose = statementPart?.prose;
```

**Display**: Show prose as formatted text

---

## 2. Typical Measures Part

**Structure**: Parent part with `typical-measure` sub-parts (singular!)

```json
{
  "id": "TOM-02_typical-measures",
  "name": "typical-measures",
  "parts": [
    {
      "id": "TOM-02_typical-measures.1",
      "name": "typical-measure",
      "prose": "AES-256 Verschlüsselung für Daten at rest"
    },
    {
      "id": "TOM-02_typical-measures.2",
      "name": "typical-measure",
      "prose": "TLS 1.3 für Daten in transit"
    },
    {
      "id": "TOM-02_typical-measures.3",
      "name": "typical-measure",
      "prose": "Hardware Security Module (HSM) für Schlüsselverwaltung"
    }
  ]
}
```

**⚠️ Important**: Sub-parts use **singular** `typical-measure`, NOT plural `typical-measures`!

**Parsing**:
```typescript
interface TypicalMeasure {
  id: string;
  prose: string;
}

function parseTypicalMeasures(control: OSCALControl): TypicalMeasure[] {
  const parent = control.parts?.find(p => p.name === 'typical-measures');
  if (!parent?.parts) return [];

  return parent.parts
    .filter(p => p.name === 'typical-measure') // Singular!
    .map(p => ({
      id: p.id,
      prose: p.prose || ''
    }));
}
```

**Display**:
- Numbered list (1, 2, 3, ...)
- OR: Bulleted list with checkboxes

---

## 3. Risk Guidance Part

**Structure**: Parent part with prose + `risk-level-*` sub-parts

```json
{
  "id": "TOM-02_risk-guidance",
  "name": "risk-guidance",
  "prose": "Ohne angemessene Verschlüsselung besteht erhöhtes Risiko bei Datenverlust oder unbefugtem Zugriff.",
  "parts": [
    {
      "id": "TOM-02_risk-guidance.normal",
      "name": "risk-level-normal",
      "props": [{ "name": "risk-level", "value": "normal" }],
      "prose": "Bei internen Systemen ohne personenbezogene Daten reicht Transport-Verschlüsselung."
    },
    {
      "id": "TOM-02_risk-guidance.moderate",
      "name": "risk-level-moderate",
      "props": [{ "name": "risk-level", "value": "moderate" }],
      "prose": "Bei personenbezogenen Daten ist zusätzliche Verschlüsselung at rest erforderlich."
    },
    {
      "id": "TOM-02_risk-guidance.high",
      "name": "risk-level-high",
      "props": [{ "name": "risk-level", "value": "high" }],
      "prose": "Bei Art. 9 DSGVO Daten (besondere Kategorien) ist Ende-zu-Ende Verschlüsselung und HSM erforderlich."
    }
  ]
}
```

**Key Points**:
- Parent has **overview prose**
- Each sub-part has **props** with risk-level value
- Sub-part names: `risk-level-normal`, `risk-level-moderate`, `risk-level-high`

**Parsing**:
```typescript
interface RiskLevelGuidance {
  level: 'normal' | 'moderate' | 'high';
  prose: string;
  id: string;
}

interface RiskGuidance {
  prose?: string; // Parent prose (overview)
  levels: RiskLevelGuidance[]; // Sub-parts
}

function parseRiskGuidance(control: OSCALControl): RiskGuidance | undefined {
  const parent = control.parts?.find(p => p.name === 'risk-guidance');
  if (!parent) return undefined;

  const levels: RiskLevelGuidance[] = [];

  for (const subPart of parent.parts || []) {
    const match = subPart.name.match(/risk-level-(normal|moderate|high)/);
    if (!match) continue;

    levels.push({
      level: match[1] as 'normal' | 'moderate' | 'high',
      prose: subPart.prose || '',
      id: subPart.id
    });
  }

  // Sort by severity
  const order = { normal: 1, moderate: 2, high: 3 };
  levels.sort((a, b) => order[a.level] - order[b.level]);

  return { prose: parent.prose, levels };
}
```

**Display**:
- Show parent prose as overview
- Display each risk level as expandable card with color coding:
  - Normal: Green (✓)
  - Moderate: Yellow (⚠️)
  - High: Red (🚨)

---

## 4. Maturity Hints Part

**Structure**: Parent part with `maturity-level-*` sub-parts

```json
{
  "id": "TOM-02_maturity-hints",
  "name": "maturity-hints",
  "parts": [
    {
      "id": "TOM-02_maturity-hints.1",
      "name": "maturity-level-1",
      "prose": "Basis: TLS für Web-Traffic"
    },
    {
      "id": "TOM-02_maturity-hints.3",
      "name": "maturity-level-3",
      "prose": "Standard: Datenbank-Verschlüsselung + Key Rotation"
    },
    {
      "id": "TOM-02_maturity-hints.5",
      "name": "maturity-level-5",
      "prose": "Fortgeschritten: Zero-Knowledge Encryption + HSM"
    }
  ]
}
```

**⚠️ Note**: In the TOM-02 sample, sub-parts do NOT have props with maturity-level value. However, for consistency with risk-guidance, we recommend adding them in future updates:

```json
{
  "id": "TOM-02_maturity-hints.3",
  "name": "maturity-level-3",
  "props": [{ "name": "maturity-level", "value": "3" }],
  "prose": "Standard: Datenbank-Verschlüsselung + Key Rotation"
}
```

**Parsing**:
```typescript
interface MaturityHint {
  level: 1 | 2 | 3 | 4 | 5;
  prose: string;
  id: string;
}

function parseMaturityHints(control: OSCALControl): MaturityHint[] {
  const parent = control.parts?.find(p => p.name === 'maturity-hints');
  if (!parent?.parts) return [];

  const hints: MaturityHint[] = [];

  for (const subPart of parent.parts) {
    const match = subPart.name.match(/maturity-level-(\d+)/);
    if (!match) continue;

    const level = parseInt(match[1], 10);
    if (level < 1 || level > 5) continue;

    hints.push({
      level: level as 1 | 2 | 3 | 4 | 5,
      prose: subPart.prose || '',
      id: subPart.id
    });
  }

  return hints.sort((a, b) => a.level - b.level);
}
```

**Display**:
- Accordion with expandable sections per level
- 5-dot visual indicator (filled dots up to current level)

---

## 5. Assessment Questions Part

**Structure**: Parent part with `assessment-question` sub-parts (singular!)

```json
{
  "id": "TOM-02_assessment-questions",
  "name": "assessment-questions",
  "parts": [
    {
      "id": "TOM-02_assessment-questions.1",
      "name": "assessment-question",
      "prose": "Ist TLS 1.2+ für alle externen Verbindungen aktiviert?"
    },
    {
      "id": "TOM-02_assessment-questions.2",
      "name": "assessment-question",
      "prose": "Werden Datenbanken mit AES-256 verschlüsselt?"
    },
    {
      "id": "TOM-02_assessment-questions.3",
      "name": "assessment-question",
      "prose": "Gibt es ein dokumentiertes Key-Management-Verfahren?"
    }
  ]
}
```

**⚠️ Important**: Sub-parts use **singular** `assessment-question`, NOT plural!

**Parsing**:
```typescript
interface AssessmentQuestion {
  id: string;
  prose: string;
  answered?: boolean; // From localStorage
}

function parseAssessmentQuestions(control: OSCALControl, controlId: string): AssessmentQuestion[] {
  const parent = control.parts?.find(p => p.name === 'assessment-questions');
  if (!parent?.parts) return [];

  return parent.parts
    .filter(p => p.name === 'assessment-question') // Singular!
    .map(p => {
      const storageKey = `oscal-assessment-${controlId}-${p.id}`;
      const answered = localStorage.getItem(storageKey) === 'true';

      return {
        id: p.id,
        prose: p.prose || '',
        answered
      };
    });
}
```

**Display**:
- Interactive checklist with checkboxes
- Progress bar: X of Y questions completed
- Persist checkbox state to localStorage

---

## 6. Links Array

**Structure**: Array of link objects (NOT a part!)

```json
{
  "id": "TOM-02",
  "links": [
    {
      "href": "https://dsgvo-gesetz.de/art-32-dsgvo/",
      "rel": "reference",
      "text": "Art. 32 DSGVO"
    }
  ]
}
```

**Parsing**:
```typescript
interface Link {
  href: string;
  rel?: string;
  text?: string;
}

const links = control.links || [];
```

**Display**: See OSCAL-008 for grouping strategy

---

## Quick Reference: Part Names

| Part Name | Sub-Part Name | Has Parent Prose? | Has Sub-Part Props? |
|-----------|---------------|-------------------|---------------------|
| `statement` | - | ✅ Yes | - |
| `typical-measures` | `typical-measure` | ❌ No | ❌ No |
| `risk-guidance` | `risk-level-{level}` | ✅ Yes | ✅ Yes (`risk-level`) |
| `maturity-hints` | `maturity-level-{num}` | ❌ No | ⚠️ Recommended* |
| `assessment-questions` | `assessment-question` | ❌ No | ❌ No |

*Note: maturity-level props recommended for consistency but not present in TOM-02 sample

---

## Common Mistakes to Avoid

### ❌ Mistake 1: Using Plural for Sub-Parts

```typescript
// WRONG
parent.parts.filter(p => p.name === 'typical-measures') // Plural!

// CORRECT
parent.parts.filter(p => p.name === 'typical-measure') // Singular!
```

### ❌ Mistake 2: Accessing Parent Prose for Measures/Questions

```typescript
// WRONG
const measuresParent = control.parts?.find(p => p.name === 'typical-measures');
const prose = measuresParent.prose; // Parent has no prose!

// CORRECT
const measuresParent = control.parts?.find(p => p.name === 'typical-measures');
const measures = measuresParent.parts.map(p => p.prose); // Access sub-part prose
```

### ❌ Mistake 3: Missing Risk-Level Props Check

```typescript
// WRONG
const level = subPart.name.split('-').pop(); // Fragile!

// CORRECT
const levelProp = subPart.props?.find(p => p.name === 'risk-level');
const level = levelProp?.value || subPart.name.match(/risk-level-(normal|moderate|high)/)?.[1];
```

---

## Testing Your Parser

**Test Fixture** (TOM-02 Complete):
```json
{
  "id": "TOM-02",
  "title": "Verschlüsselung",
  "parts": [
    { "name": "statement", "prose": "..." },
    {
      "name": "typical-measures",
      "parts": [
        { "name": "typical-measure", "prose": "Measure 1" },
        { "name": "typical-measure", "prose": "Measure 2" }
      ]
    },
    {
      "name": "risk-guidance",
      "prose": "Overview",
      "parts": [
        { "name": "risk-level-normal", "props": [{"name": "risk-level", "value": "normal"}], "prose": "..." }
      ]
    },
    {
      "name": "maturity-hints",
      "parts": [
        { "name": "maturity-level-1", "prose": "Level 1" }
      ]
    },
    {
      "name": "assessment-questions",
      "parts": [
        { "name": "assessment-question", "prose": "Question 1?" }
      ]
    }
  ],
  "links": [{ "href": "...", "rel": "reference", "text": "..." }]
}
```

**Expected Results**:
- `parseTypicalMeasures()` → 2 measures
- `parseRiskGuidance()` → 1 level + overview prose
- `parseMaturityHints()` → 1 hint
- `parseAssessmentQuestions()` → 1 question

---

## References

- **TOM-02 Sample**: `docs/team-knowledge/backend-developer/EXTERNAL-PR-TOM02-UPDATE.md`
- **Feature Spec**: `docs/features/OSCAL-006-risk-guidance-tabs.md`
- **OSCAL Standard**: https://pages.nist.gov/OSCAL/

---

**Last Updated**: 2026-01-30
**Maintained By**: Solution Architect
**Questions?** Ask in #architecture Slack
