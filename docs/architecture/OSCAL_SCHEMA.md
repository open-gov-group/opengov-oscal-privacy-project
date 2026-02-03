# OSCAL Schema & Privacy Extensions

## OSCAL Version

This project targets **OSCAL 1.1.2** with plans to upgrade to 1.4+ when released.

- Official Spec: https://pages.nist.gov/OSCAL/
- GitHub: https://github.com/usnistgov/OSCAL
- Schemas: https://github.com/usnistgov/OSCAL/tree/main/json/schema

## Supported OSCAL Models

### 1. Catalog (Primary)

**Purpose:** Define privacy controls and requirements

**Structure:**
```json
{
  "catalog": {
    "uuid": "uuid-string",
    "metadata": { /* ... */ },
    "groups": [
      {
        "id": "gdpr-transparency",
        "title": "Transparency Requirements",
        "controls": [ /* ... */ ]
      }
    ],
    "back-matter": { /* ... */ }
  }
}
```

**Key Fields:**
- `uuid`: Unique identifier for catalog
- `metadata`: Title, version, last-modified, parties
- `groups`: Logical grouping of controls (e.g., by GDPR chapter)
- `controls`: Individual privacy controls
- `back-matter`: Resources, references, attachments

### 2. Profile

**Purpose:** Baseline privacy requirements (e.g., "GDPR Baseline")

```json
{
  "profile": {
    "uuid": "uuid-string",
    "metadata": { /* ... */ },
    "imports": [
      {
        "href": "https://github.com/open-gov-group/oscal-privacy-catalog/raw/main/catalog.json",
        "include-controls": [
          { "with-id": "gdpr-art-13" },
          { "with-id": "gdpr-art-14" }
        ]
      }
    ],
    "modify": {
      "set-parameters": [ /* ... */ ],
      "alters": [ /* ... */ ]
    }
  }
}
```

### 3. Component Definition

**Purpose:** Reusable privacy components (e.g., "Cookie Banner Component")

```json
{
  "component-definition": {
    "uuid": "uuid-string",
    "metadata": { /* ... */ },
    "components": [
      {
        "uuid": "component-uuid",
        "type": "software",
        "title": "Cookie Consent Manager",
        "description": "GDPR-compliant cookie consent implementation",
        "control-implementations": [
          {
            "uuid": "impl-uuid",
            "source": "catalog-url",
            "implemented-requirements": [
              {
                "uuid": "req-uuid",
                "control-id": "gdpr-art-13",
                "description": "Implementation details..."
              }
            ]
          }
        ]
      }
    ]
  }
}
```

### 4. System Security Plan (SSP)

**Purpose:** Document how privacy controls are implemented in a specific system

```json
{
  "system-security-plan": {
    "uuid": "uuid-string",
    "metadata": { /* ... */ },
    "system-characteristics": {
      "system-name": "Citizen Portal",
      "description": "Public-facing portal for citizen services",
      "security-sensitivity-level": "moderate",
      "system-information": {
        "information-types": [
          {
            "title": "Personal Data",
            "description": "Citizen personal information",
            "confidentiality-impact": { "base": "moderate" },
            "integrity-impact": { "base": "high" },
            "availability-impact": { "base": "moderate" }
          }
        ]
      }
    },
    "control-implementation": {
      "description": "Privacy control implementation",
      "implemented-requirements": [ /* ... */ ]
    }
  }
}
```

## Privacy Catalog Extensions

### Custom Namespace

All OpenGov privacy extensions use:
```
namespace: "https://open-gov-group.org/oscal/privacy"
```

### Custom Properties

#### 1. GDPR Article Mapping

**Property:** `gdpr-article`

**Usage:** Link control to GDPR article

```json
{
  "props": [
    {
      "name": "gdpr-article",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "Art. 13",
      "remarks": "Transparency - Information to be provided"
    }
  ]
}
```

#### 2. Data Protection Impact Assessment (DPIA)

**Property:** `dpia-required`

**Values:** `true`, `false`, `conditional`

```json
{
  "props": [
    {
      "name": "dpia-required",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "true",
      "remarks": "High risk processing requires DPIA"
    }
  ]
}
```

#### 3. Data Subject Rights

**Property:** `data-subject-right`

**Values:** `access`, `rectification`, `erasure`, `restriction`, `portability`, `objection`

```json
{
  "props": [
    {
      "name": "data-subject-right",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "access",
      "remarks": "GDPR Art. 15 - Right of access"
    }
  ]
}
```

#### 4. Processing Activity Type

**Property:** `processing-type`

**Values:** `collection`, `storage`, `analysis`, `sharing`, `deletion`

```json
{
  "props": [
    {
      "name": "processing-type",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "collection",
      "remarks": "Data collection from data subjects"
    }
  ]
}
```

#### 5. Legal Basis

**Property:** `legal-basis`

**Values:** `consent`, `contract`, `legal-obligation`, `vital-interests`, `public-task`, `legitimate-interests`

```json
{
  "props": [
    {
      "name": "legal-basis",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "legal-obligation",
      "remarks": "GDPR Art. 6(1)(c)"
    }
  ]
}
```

#### 6. ISO 27001/27701 Mapping

**Property:** `iso27001-control`, `iso27701-control`

```json
{
  "props": [
    {
      "name": "iso27001-control",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "A.18.1.4",
      "remarks": "Privacy and protection of PII"
    },
    {
      "name": "iso27701-control",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "7.2.1",
      "remarks": "Identifying the basis for PII processing"
    }
  ]
}
```

#### 7. Citizen-Friendly Title

**Property:** `citizen-title-{lang}`

**Languages:** `de`, `en`, `fr`

```json
{
  "props": [
    {
      "name": "citizen-title-de",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "Ihr Recht auf Auskunft",
      "remarks": "Plain language title for German citizens"
    },
    {
      "name": "citizen-title-en",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "Your Right to Access Your Data"
    }
  ]
}
```

#### 8. RoPA Mapping

**Property:** `ropa-category`

**Values:** Based on RoPA tool categories

```json
{
  "props": [
    {
      "name": "ropa-category",
      "ns": "https://open-gov-group.org/oscal/privacy",
      "value": "citizen-services",
      "remarks": "Maps to RoPA processing activity category"
    }
  ]
}
```

## Validation Rules

### Schema Validation

Use `compliance-trestle` or `Ajv` for validation:

```typescript
import Ajv from 'ajv';
import addFormats from 'ajv-formats';

const ajv = new Ajv({ strict: true });
addFormats(ajv);

// Load OSCAL catalog schema
const catalogSchema = await fetch(
  'https://raw.githubusercontent.com/usnistgov/OSCAL/main/json/schema/oscal_catalog_schema.json'
).then(r => r.json());

const validate = ajv.compile(catalogSchema);

// Validate catalog
const isValid = validate(catalogData);
if (!isValid) {
  console.error(validate.errors);
}
```

### Custom Validation Rules

#### 1. UUID Format

```typescript
function validateUUID(uuid: string): boolean {
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  return uuidRegex.test(uuid);
}
```

#### 2. Required Metadata Fields

```typescript
function validateMetadata(metadata: Metadata): boolean {
  return !!(
    metadata.title &&
    metadata['last-modified'] &&
    metadata.version &&
    metadata.oscalVersion
  );
}
```

#### 3. Control ID Format

```typescript
// Format: lowercase letters, numbers, hyphens
function validateControlId(id: string): boolean {
  const idRegex = /^[a-z0-9-]+$/;
  return idRegex.test(id);
}
```

#### 4. GDPR Article Reference

```typescript
function validateGDPRArticle(article: string): boolean {
  // Format: "Art. X" or "Art. X(Y)" or "Art. X(Y)(z)"
  const gdprRegex = /^Art\. \d+(\(\d+\))?(\([a-z]\))?$/;
  return gdprRegex.test(article);
}
```

## TypeScript Type Definitions

### Core OSCAL Types

```typescript
// src/types/oscal.d.ts

export interface OSCALCatalog {
  uuid: string;
  metadata: Metadata;
  groups?: Group[];
  controls?: Control[];
  'back-matter'?: BackMatter;
}

export interface Metadata {
  title: string;
  'last-modified': string; // ISO 8601 timestamp
  version: string;
  'oscal-version': string;
  parties?: Party[];
  roles?: Role[];
  props?: Property[];
}

export interface Group {
  id: string;
  class?: string;
  title: string;
  params?: Parameter[];
  props?: Property[];
  parts?: Part[];
  groups?: Group[];
  controls?: Control[];
}

export interface Control {
  id: string;
  class?: string;
  title: string;
  params?: Parameter[];
  props?: Property[];
  parts?: Part[];
  controls?: Control[]; // Sub-controls
}

export interface Property {
  name: string;
  ns?: string; // Namespace
  value: string;
  class?: string;
  remarks?: string;
}

export interface Part {
  id?: string;
  name: string;
  ns?: string;
  class?: string;
  title?: string;
  prose?: string;
  parts?: Part[];
  props?: Property[];
}

export interface Parameter {
  id: string;
  class?: string;
  label?: string;
  props?: Property[];
  guidelines?: Guideline[];
  values?: string[];
  select?: Select;
}

export interface BackMatter {
  resources?: Resource[];
}

export interface Resource {
  uuid: string;
  title?: string;
  description?: string;
  props?: Property[];
  rlinks?: ResourceLink[];
  citation?: Citation;
}
```

### Privacy-Specific Types

```typescript
// src/types/privacy.d.ts

export type GDPRArticle = 
  | 'Art. 5' | 'Art. 6' | 'Art. 13' | 'Art. 14' | 'Art. 15'
  | 'Art. 16' | 'Art. 17' | 'Art. 18' | 'Art. 20' | 'Art. 21'
  | 'Art. 25' | 'Art. 32' | 'Art. 33' | 'Art. 34' | 'Art. 35';

export type DataSubjectRight = 
  | 'access'
  | 'rectification'
  | 'erasure'
  | 'restriction'
  | 'portability'
  | 'objection';

export type LegalBasis =
  | 'consent'
  | 'contract'
  | 'legal-obligation'
  | 'vital-interests'
  | 'public-task'
  | 'legitimate-interests';

export type ProcessingType =
  | 'collection'
  | 'storage'
  | 'analysis'
  | 'sharing'
  | 'deletion';

export interface PrivacyControl extends Control {
  props: Array<Property & {
    name: 'gdpr-article' | 'dpia-required' | 'data-subject-right' | 'legal-basis';
  }>;
}
```

## Utility Functions

### Extract Custom Properties

```typescript
function getCustomProp(
  control: Control,
  propName: string,
  namespace: string = 'https://open-gov-group.org/oscal/privacy'
): string | undefined {
  return control.props
    ?.find(p => p.name === propName && p.ns === namespace)
    ?.value;
}

// Usage
const gdprArticle = getCustomProp(control, 'gdpr-article');
const dpiaRequired = getCustomProp(control, 'dpia-required') === 'true';
```

### Get Localized Title

```typescript
function getLocalizedTitle(
  control: Control,
  lang: 'de' | 'en' | 'fr',
  viewMode: 'citizen' | 'dpo'
): string {
  if (viewMode === 'citizen') {
    const citizenTitle = getCustomProp(control, `citizen-title-${lang}`);
    if (citizenTitle) return citizenTitle;
  }
  
  return control.title;
}
```

### Filter Controls by GDPR Article

```typescript
function filterByGDPRArticle(
  catalog: OSCALCatalog,
  article: GDPRArticle
): Control[] {
  const allControls = getAllControls(catalog);
  return allControls.filter(control => 
    getCustomProp(control, 'gdpr-article') === article
  );
}
```

## Sample OSCAL Catalog Snippet

```json
{
  "catalog": {
    "uuid": "a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d",
    "metadata": {
      "title": "GDPR Privacy Controls Catalog",
      "last-modified": "2024-01-15T10:30:00Z",
      "version": "1.0.0",
      "oscal-version": "1.1.2",
      "props": [
        {
          "name": "keywords",
          "value": "GDPR, privacy, data protection, EU"
        }
      ]
    },
    "groups": [
      {
        "id": "gdpr-transparency",
        "title": "Transparency Requirements",
        "controls": [
          {
            "id": "gdpr-art-13",
            "title": "Information to be provided where personal data are collected from the data subject",
            "props": [
              {
                "name": "gdpr-article",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "Art. 13"
              },
              {
                "name": "dpia-required",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "false"
              },
              {
                "name": "legal-basis",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "legal-obligation"
              },
              {
                "name": "citizen-title-de",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "Informationen die Sie erhalten müssen"
              },
              {
                "name": "citizen-title-en",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "Information You Must Receive"
              },
              {
                "name": "iso27001-control",
                "ns": "https://open-gov-group.org/oscal/privacy",
                "value": "A.18.1.4"
              }
            ],
            "parts": [
              {
                "name": "statement",
                "prose": "The controller shall provide the data subject with information about..."
              },
              {
                "name": "guidance",
                "prose": "This includes identity of controller, purpose of processing, legal basis..."
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## Best Practices

1. **Always validate OSCAL against official schemas before processing**
2. **Use custom namespace for all extensions**
3. **Provide both technical and citizen-friendly titles**
4. **Link to GDPR articles and ISO controls where applicable**
5. **Include multilingual support (DE/EN/FR minimum)**
6. **Document custom properties in back-matter/resources**
7. **Use UUIDs (v4) for all unique identifiers**
8. **Keep control IDs lowercase with hyphens**
9. **Use ISO 8601 timestamps for dates**
10. **Test with compliance-trestle validation before publishing**
