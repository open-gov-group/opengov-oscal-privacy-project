# 🌍 OpenGov OSCAL Privacy Ecosystem - Project Overview

**Vision**: Integrate data protection into resilience and security frameworks to protect both individuals and society

**Target**: European government sector
**Stage**: MVP - Proof of Concept
**Approach**: OSCAL-based, multi-repository microservices architecture

---

## 🎯 Project Mission


## 🏗️ Architecture - public repositories


```
open-gov-group/
├── opengov-privacy-oscal/         # GDPR catalog in OSCAL format - Privacy baselines & profiles
├── opengov-security-oscal         # NIST/BSI-compliant controls 
├── opengov-privacy-mappings/      # ISO 27001/27701, NIST, BSI mappings
├── opengov-oscal-workbench/       # Web-based workbench for maintaining OSCAL artifacts in the OpenGov context 
├── opengov-privacy-gateway/       # REST API for OSCAL data 
├── opengov-oscal-privacy-viewer/  # ← This repo (web viewer)
├── opengov-privacy-app/           # Data protection management
├── opengov-privacy-data /         # data storage for the RoPA app 
├── opengov-oscal-pyprivacy/       # Lightweight core utilities for working with OpenGOV OSCAL Privacy in Python
└── opengov-pylegal-utils          # A Python Libary to handle and normalize legal information. 
```

### The Challenge
European government agencies face complex, overlapping compliance requirements:
- **Data Protection**: GDPR (privacy, individual rights)
- **Information Security**: ISO 27001, BSI IT-Grundschutz, NIST frameworks
- **Privacy Management**: ISO 27701 PIMS (Privacy Information Management System)
- **Operational Requirements**: RoPA (Records of Processing Activities), DPIA, breach management

These frameworks are traditionally managed in **silos**, leading to:
- ❌ Duplicate documentation
- ❌ Inconsistent controls
- ❌ No unified view of compliance status
- ❌ Difficult audits and evidence collection

### Our Solution
A **unified, OSCAL-based ecosystem** that:
- ✅ **Integrates** data protection into security/resilience frameworks
- ✅ **Maps** GDPR controls to ISO 27001/27701, NIST, BSI
- ✅ **Automates** compliance evidence collection
- ✅ **Provides** both citizen-friendly and professional views
- ✅ **Enables** machine-readable, version-controlled compliance artifacts

### Target Outcome
Government agencies can:
1. Maintain **one source of truth** for privacy and security controls
2. Show citizens their rights in **plain language** (transparency)
3. Demonstrate compliance to **multiple frameworks** simultaneously
4. Collaborate using **open standards** (OSCAL 1.1.2)
5. Integrate compliance into **DevSecOps** workflows

---

## 🏗️ Multi-Repository Architecture

The OpenGov OSCAL Privacy project is organized into specialized repositories:

```
┌─────────────────────────────────────────────────────────────────┐
│                    OpenGov Privacy Ecosystem                     │
└─────────────────────────────────────────────────────────────────┘

┌───────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   DATA SOURCES    │  │   TOOLS & APPS   │  │   INTEGRATIONS   │
└───────────────────┘  └──────────────────┘  └──────────────────┘

📦 OSCAL Artifacts         🔧 Management Tools        🔗 API & Utilities
─────────────────         ──────────────────        ────────────────
1. privacy-oscal          6. privacy-app             9. privacy-gateway
2.security-oscal         7. oscal-workbench        10. oscal-pyprivacy
3. privacy-mappings       8. oscal-privacy-viewer   11. pylegal-utils
4. privacy-data
5. (future: ssp-catalog)
```

---

## 📚 Repository Breakdown

### 1️⃣ opengov-privacy-oscal
**Type**: Data Repository (OSCAL Catalogs & Profiles)
**Status**: 🟢 Active - Core artifact
**Primary Maintainer**: Compliance/DPO team

**Purpose**:
Source of truth for GDPR-focused privacy controls in OSCAL 1.1.2 format.

**Contents**:
```
opengov-privacy-oscal/
├── catalog/
│   ├── open_privacy_catalog_risk.json      # Risk-based privacy baseline
│   │   └── Controls: DSR-01 to DSR-06 (data subject rights)
│   │               OPS-04 (operational processes)
│   │               TOM-02 (technical/organizational measures)
│   └── sdm_privacy_catalog.json            # SDM/TOM technical controls
│       └── Controls: SDM-TOM-AC-01 (access), CR-01 (crypto),
│                     LG-01 (logging), DEL-01 (deletion), etc.
│
├── profile/
│   ├── profile-melderegister-privacy-sdm.json  # Citizen registration system
│   └── profile_standard_web_app.json           # Standard web app baseline
│
└── component/
    └── comp_app_fachverfahren_base.json        # Generic line-of-business app
```

**Key Features**:
- **Custom OSCAL properties** using namespace `https://open-gov-group.org/oscal/privacy`
- **Risk-based control selection**: `dp-risk-impact` × `dp-likelihood` → `implementation-level`
- **Multilingual support**: `citizen-title-de`, `citizen-title-en`, `citizen-title-fr`
- **GDPR mapping**: `gdpr-article` property (Art. 15, Art. 17, etc.)
- **Maturity levels**: CNIL-inspired 1-5 scale

**Relationships**:
- Used by: `oscal-privacy-viewer`, `privacy-app`, `oscal-workbench`
- Imports: Referenced by profiles in `profile/`
- Mappings: Linked via `privacy-mappings` repository

---

### 2️⃣ opengov-security-oscal
**Type**: Data Repository (Security Controls)
**Status**: 🟡 Planned/Early Stage
**Primary Maintainer**: InfoSec team

**Purpose**:
NIST SP 800-53 and BSI IT-Grundschutz controls in OSCAL format.

**Expected Contents**:
```
opengov-security-oscal/
├── catalog/
│   ├── nist_sp800-53_rev5.json      # NIST security controls
│   ├── bsi_grundschutz_2023.json    # BSI IT-Grundschutz
│   └── iso27001_controls.json        # ISO 27001 Annex A
│
└── profile/
    ├── profile_government_baseline.json
    └── profile_critical_infrastructure.json
```

**Key Features**:
- Standard security controls (access control, encryption, monitoring)
- Complementary to privacy controls (defense in depth)
- Supports integrated compliance (security + privacy)

**Relationships**:
- Complements: `privacy-oscal`
- Mapped via: `privacy-mappings`
- Used by: `oscal-workbench`, `privacy-app`

---

### 3️⃣ opengov-privacy-mappings
**Type**: Data Repository (Control Mappings)
**Status**: 🟢 Active - Critical for compliance
**Primary Maintainer**: Compliance/Standards team

**Purpose**:
Machine-readable mappings between OSCAL privacy controls and international frameworks.

**Expected Contents**:
```
opengov-privacy-mappings/
├── mappings/
│   ├── oscal_to_iso27001.json       # OSCAL → ISO 27001 Annex A
│   ├── oscal_to_iso27701.json       # OSCAL → ISO 27701 PIMS
│   ├── oscal_to_nist_privacy.json   # OSCAL → NIST Privacy Framework
│   ├── oscal_to_bsi.json            # OSCAL → BSI Grundschutz
│   └── oscal_to_sdm.json            # OSCAL → Standard-Datenschutzmodell
│
└── metadata/
    ├── framework_info.json          # Framework versions, authorities
    └── mapping_methodology.md       # How mappings were created
```

**Mapping Structure Example**:
```json
{
  "mapping_id": "sdm-tom-ac-01-to-iso27001",
  "source": {
    "framework": "OpenGov OSCAL Privacy",
    "control_id": "SDM-TOM-AC-01",
    "control_title": "Role-based Access Control"
  },
  "targets": [
    {
      "framework": "ISO/IEC 27001:2022",
      "control_id": "A.9.2.1",
      "control_title": "User registration and de-registration",
      "mapping_type": "equivalent"
    },
    {
      "framework": "ISO/IEC 27701:2019",
      "control_id": "7.2.2",
      "control_title": "Identify and document purpose",
      "mapping_type": "related"
    }
  ]
}
```

**Relationships**:
- Maps: `privacy-oscal` + `security-oscal` ↔ International standards
- Used by: `oscal-privacy-viewer` (mapping display), `privacy-app` (compliance matrix)

---

### 4️⃣ opengov-privacy-data
**Type**: Data Repository (Application Data)
**Status**: 🟡 Planned
**Primary Maintainer**: Backend team

**Purpose**:
Persistent storage for RoPA (Records of Processing Activities) and operational data.

**Expected Contents**:
```
opengov-privacy-data/
├── ropa/
│   ├── processing_activities/       # Individual RoPA entries
│   ├── data_categories/             # Types of personal data processed
│   ├── legal_bases/                 # Lawfulness of processing
│   └── recipients/                  # Data recipients/processors
│
├── assessments/
│   ├── dpia/                        # Data Protection Impact Assessments
│   └── pia/                         # Privacy Impact Assessments
│
└── incidents/
    ├── breach_records/              # GDPR Art. 33/34 breach notifications
    └── data_subject_requests/       # DSR handling logs
```

**Data Format**:
- JSON or SQLite database
- Links to OSCAL controls (e.g., processing activity → required controls)
- Audit trail for all changes

**Relationships**:
- Used by: `privacy-app` (primary consumer)
- Referenced by: `privacy-gateway` (API access)

---

### 5️⃣ opengov-privacy-app
**Type**: Web Application (RoPA & Compliance Management)
**Status**: 🟢 Active - MVP
**Primary Maintainer**: Full-stack team
**Tech Stack**: React/Vue + Node.js + Database

**Purpose**:
Main operational tool for Data Protection Officers (DPOs) to manage:
1. **Records of Processing Activities (RoPA)** - GDPR Art. 30 compliance
2. **Control implementations** - Link processing to required OSCAL controls
3. **Risk assessments** - DPIA workflows
4. **Data subject requests** - DSR case management
5. **Compliance dashboard** - Multi-framework status

**Key Features**:
```
privacy-app/
├── modules/
│   ├── ropa/                    # Processing activity management
│   │   ├── ProcessingList.tsx
│   │   ├── ProcessingDetail.tsx
│   │   └── DPIAWizard.tsx
│   │
│   ├── controls/                # OSCAL control integration
│   │   ├── ControlMapping.tsx   # Link processing → controls
│   │   └── ImplementationStatus.tsx
│   │
│   ├── dsr/                     # Data Subject Requests
│   │   ├── RequestInbox.tsx
│   │   └── RequestWorkflow.tsx
│   │
│   └── compliance/              # Dashboard
│       ├── ComplianceMatrix.tsx # Show ISO/NIST/BSI status
│       └── AuditReport.tsx
```

**User Personas**:
- **Data Protection Officer (DPO)**: Primary user, manages all aspects
- **Process Owner**: Responsible for individual processing activities
- **IT/Security Team**: Implements technical controls
- **Auditor**: Reviews compliance evidence

**Data Flow**:
1. DPO creates processing activity in RoPA module
2. System suggests required OSCAL controls based on risk level
3. DPO assigns controls to IT team
4. IT team marks controls as implemented
5. System generates compliance report showing ISO 27001/27701 coverage

**Relationships**:
- Reads: `privacy-oscal` (catalog), `privacy-mappings` (compliance matrix)
- Writes: `privacy-data` (RoPA records, assessments)
- API: `privacy-gateway` (may act as middleware)
- Displays: Uses `oscal-privacy-viewer` as embedded component (future)

---

### 6️⃣ opengov-oscal-workbench
**Type**: Web Application (OSCAL Maintenance Tool)
**Status**: 🟡 Planned/Early Stage
**Primary Maintainer**: Compliance/Standards team
**Tech Stack**: React + Monaco Editor

**Purpose**:
Authoring and maintenance tool for OSCAL artifacts (catalogs, profiles, components).

**Key Features**:
```
oscal-workbench/
├── features/
│   ├── catalog-editor/
│   │   ├── ControlEditor.tsx        # Visual control editing
│   │   ├── PropertyManager.tsx      # Manage custom props
│   │   └── ValidationPanel.tsx      # OSCAL schema validation
│   │
│   ├── profile-builder/
│   │   ├── ImportSelector.tsx       # Select catalog imports
│   │   ├── ModifyControls.tsx       # Tailor controls
│   │   └── ProfilePreview.tsx       # Show resolved profile
│   │
│   ├── mapping-editor/
│   │   ├── MappingTable.tsx         # Visual mapping interface
│   │   └── BulkImport.tsx           # Import from Excel
│   │
│   └── collaboration/
│       ├── VersionControl.tsx       # Git integration
│       └── ReviewWorkflow.tsx       # Approval process
```

**Workflow Example**:
1. Standards expert creates new control in catalog editor
2. Adds custom properties (GDPR article, ISO mapping)
3. Validates against OSCAL 1.1.2 schema
4. Previews in embedded viewer
5. Commits to `privacy-oscal` repository
6. Triggers CI/CD to validate and publish

**Relationships**:
- Edits: `privacy-oscal`, `security-oscal`, `privacy-mappings`
- Uses: `oscal-pyprivacy` (validation backend)
- Integrates: `oscal-privacy-viewer` (preview mode)

---

### 7️⃣ opengov-oscal-privacy-viewer
**Type**: Web Application (Public Viewer) **← THIS REPOSITORY**
**Status**: 🟢 Active - Alpha → Beta
**Primary Maintainer**: Frontend team
**Tech Stack**: React 18 + TypeScript + Vite

**Purpose**:
Dual-audience OSCAL viewer:
1. **Citizens**: Understand data protection rights in plain language
2. **DPOs/Auditors**: Navigate technical compliance controls

**Key Features**:
- **Catalog Viewer**: Browse OSCAL catalogs with tree navigation
- **Profile Resolver**: Show tailored control sets
- **Component Viewer**: See control implementations
- **Dual Views**: Toggle citizen-friendly ↔ professional terminology
- **Multilingual**: German, English, French
- **Compliance Mapping**: Show ISO 27001/27701, NIST, BSI mappings
- **Export**: PDF, CSV, JSON reports
- **Client-Side**: No backend required, privacy-first

**User Personas**:
- **Citizen (Bürger)**: Wants to know "What are my rights?" in simple German
- **Data Protection Officer**: Needs full technical details and mappings
- **Auditor**: Reviews compliance evidence
- **Developer**: Integrates via URL parameters

**Current Status** (See [ROADMAP.md](ROADMAP.md)):
- ✅ Alpha: Core catalog loading, tree navigation, control display
- 🚧 Beta: Filtering, search, multilingual, export
- 📅 v1.0: Profile resolution, SSP support, RoPA integration

**Relationships**:
- Reads: `privacy-oscal`, `security-oscal`, `privacy-mappings`
- Embedded in: `privacy-app` (future), `oscal-workbench` (preview mode)
- Deployed as: Standalone app + embeddable component

---

### 8️⃣ opengov-privacy-gateway
**Type**: REST API (Data Access Layer)
**Status**: 🟡 Planned
**Primary Maintainer**: Backend team
**Tech Stack**: Node.js/Python + Express/FastAPI

**Purpose**:
Centralized API for accessing OSCAL artifacts and RoPA data.

**Endpoints**:
```
GET /api/v1/catalogs                    # List all catalogs
GET /api/v1/catalogs/{id}               # Get specific catalog
GET /api/v1/profiles/{id}/resolve       # Resolve profile with imports

GET /api/v1/controls/search?q={query}   # Search controls
GET /api/v1/controls/{id}/mappings      # Get ISO/NIST mappings

GET /api/v1/ropa/activities             # List processing activities
POST /api/v1/ropa/activities            # Create new activity

GET /api/v1/compliance/matrix           # Get compliance status
GET /api/v1/export/pdf?catalog={id}     # Generate PDF report
```

**Features**:
- **Caching**: Redis for frequently accessed catalogs
- **Validation**: OSCAL schema validation
- **Authentication**: OAuth2 for RoPA access
- **Rate Limiting**: Prevent abuse
- **Versioning**: Support multiple OSCAL versions

**Relationships**:
- Serves: `privacy-oscal`, `security-oscal`, `privacy-data`
- Used by: `privacy-app`, `oscal-privacy-viewer`, external integrations
- Depends on: `oscal-pyprivacy` (processing logic)

---

### 9️⃣ opengov-oscal-pyprivacy
**Type**: Python Library (Utilities)
**Status**: 🟢 Active - Core utility
**Primary Maintainer**: Backend team
**Tech Stack**: Python 3.10+

**Purpose**:
Lightweight Python utilities for working with OpenGov OSCAL Privacy artifacts.

**Features**:
```python
from opengov_oscal_pyprivacy import (
    CatalogLoader,
    ProfileResolver,
    ControlMapper,
    OSCALValidator
)

# Load and validate catalog
catalog = CatalogLoader.from_url(
    "https://.../sdm_privacy_catalog.json"
)
validator = OSCALValidator(schema_version="1.1.2")
validator.validate(catalog)

# Resolve profile
profile = ProfileResolver.resolve(
    profile_url="https://.../profile-melderegister.json",
    auto_fetch_imports=True
)

# Get ISO mappings
mapper = ControlMapper.load_mappings(
    "https://.../oscal_to_iso27001.json"
)
iso_controls = mapper.get_iso27001("SDM-TOM-AC-01")
# Returns: ["A.9.2.1", "A.9.2.2"]
```

**Use Cases**:
- Backend processing in `privacy-gateway`
- Validation in `oscal-workbench`
- Batch processing scripts
- CI/CD pipelines

**Relationships**:
- Uses: `pylegal-utils` (legal text normalization)
- Used by: `privacy-gateway`, `oscal-workbench`
- Publishes: PyPI package

---

### 🔟 opengov-pylegal-utils
**Type**: Python Library (Legal Text Processing)
**Status**: 🟡 Planned/Utility
**Primary Maintainer**: Compliance team
**Tech Stack**: Python 3.10+

**Purpose**:
Normalize and handle legal references (GDPR, national laws).

**Features**:
```python
from opengov_pylegal_utils import (
    GDPRParser,
    LegalReferenceNormalizer,
    ArticleExtractor
)

# Parse GDPR article references
parser = GDPRParser()
articles = parser.extract_articles(
    "This control implements Art. 15, 16 and 17 GDPR"
)
# Returns: [Article(number=15), Article(number=16), Article(number=17)]

# Normalize legal references
normalizer = LegalReferenceNormalizer(language="de")
normalized = normalizer.normalize("Artikel 15 DSGVO")
# Returns: "Art. 15 GDPR"

# Get article text
extractor = ArticleExtractor(language="de")
text = extractor.get_article_text("Art. 15 GDPR")
# Returns: "Die betroffene Person hat das Recht, von dem Verantwortlichen..."
```

**Use Cases**:
- Extract GDPR articles from control descriptions
- Normalize legal references across languages
- Generate citizen-friendly explanations
- Validate legal basis references in RoPA

**Relationships**:
- Used by: `oscal-pyprivacy`, `privacy-app`, `privacy-gateway`
- Independent utility library

---

## 🔗 Integration Architecture

### Data Flow Diagram

```
┌──────────────┐
│   Citizens   │  View rights in plain language
└──────┬───────┘
       │
       ↓
┌─────────────────────────────────────────────────────────────┐
│           opengov-oscal-privacy-viewer (Frontend)           │
│  - Catalog browser                                          │
│  - Citizen vs DPO view toggle                               │
│  - Multilingual (DE/EN/FR)                                  │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ↓ Reads OSCAL files
┌─────────────────────────────────────────────────────────────┐
│  opengov-privacy-oscal       opengov-privacy-mappings       │
│  - Catalogs (JSON)           - ISO/NIST/BSI mappings        │
│  - Profiles                  - Machine-readable             │
│  - Components                                               │
└─────────────────────────────────────────────────────────────┘
                 ↑
                 │ Maintains
                 │
┌─────────────────────────────────────────────────────────────┐
│          opengov-oscal-workbench (Authoring Tool)           │
│  - Visual OSCAL editor                                      │
│  - Profile builder                                          │
│  - Mapping editor                                           │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ↓ Git commits
                 │
           [Version Control]
                 │
                 ↑ Reads/Writes
┌─────────────────────────────────────────────────────────────┐
│            opengov-privacy-app (RoPA Manager)               │
│  - Processing activities (GDPR Art. 30)                     │
│  - Control mapping                                          │
│  - DSR workflow                                             │
│  - Compliance dashboard                                     │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ↓ Stores data
┌─────────────────────────────────────────────────────────────┐
│           opengov-privacy-data (Data Storage)               │
│  - RoPA records                                             │
│  - DPIA assessments                                         │
│  - Breach logs                                              │
└─────────────────────────────────────────────────────────────┘
                 ↑
                 │ Accessed via API
                 │
┌─────────────────────────────────────────────────────────────┐
│          opengov-privacy-gateway (REST API)                 │
│  - Unified API for all data sources                         │
│  - Authentication & authorization                           │
│  - Rate limiting & caching                                  │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ↓ Uses utilities
┌─────────────────────────────────────────────────────────────┐
│  opengov-oscal-pyprivacy    opengov-pylegal-utils           │
│  - OSCAL parsing            - Legal text processing         │
│  - Profile resolution       - GDPR article extraction       │
│  - Validation               - Reference normalization       │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 Use Cases & User Journeys

### Use Case 1: Citizen Transparency
**Actor**: German citizen (Bürger)
**Goal**: Understand what data is processed and what rights they have

**Journey**:
1. Agency publishes OSCAL catalog to public URL
2. Citizen opens `oscal-privacy-viewer` in browser
3. Clicks "Bürgeransicht" (Citizen View)
4. Sees simple German language:
   - "Ihre Rechte" (Your Rights)
   - "Recht auf Auskunft - Sie können fragen, welche Daten wir über Sie gespeichert haben"
5. Clicks on specific right → sees GDPR article reference explained
6. Downloads PDF summary in plain language

**Technical Flow**:
- Viewer → `privacy-oscal` catalog (public URL)
- Extracts `citizen-title-de` properties
- Maps GDPR articles using `pylegal-utils`
- Generates citizen-friendly view

---

### Use Case 2: DPO Compliance Management
**Actor**: Data Protection Officer
**Goal**: Manage RoPA and demonstrate ISO 27001/27701 compliance

**Journey**:
1. DPO opens `privacy-app` and navigates to RoPA module
2. Creates new processing activity: "Citizen Registration System"
3. Selects data categories: Name, Address, Birthdate
4. System suggests required controls based on risk:
   - SDM-TOM-AC-01 (Access Control) - Implementation Level: Standard
   - SDM-TOM-LG-01 (Logging) - Implementation Level: Standard
   - SDM-TOM-DEL-01 (Deletion) - Implementation Level: Baseline
5. DPO assigns controls to IT team
6. IT team marks controls as implemented with evidence
7. DPO generates compliance matrix showing:
   - ISO 27001: 85% coverage
   - ISO 27701: 78% coverage
   - GDPR: 100% coverage
8. Exports audit report as PDF

**Technical Flow**:
- `privacy-app` → reads `privacy-oscal` catalog
- Risk calculator → determines required controls
- Stores data → `privacy-data` repository
- Mapping lookup → `privacy-mappings` for ISO/NIST
- Report generation → `privacy-gateway` API

---

### Use Case 3: Standards Team - Catalog Maintenance
**Actor**: Compliance Standards Expert
**Goal**: Update OSCAL catalog with new BSI Grundschutz mappings

**Journey**:
1. Expert opens `oscal-workbench`
2. Loads `sdm_privacy_catalog.json`
3. Selects control SDM-TOM-CR-01 (Encryption)
4. Opens mapping editor
5. Adds new BSI mapping:
   - BSI Control: CON.1.A8 "Verschlüsselung"
   - Mapping Type: Equivalent
6. Validates against OSCAL schema (passes)
7. Previews in embedded viewer (looks good)
8. Commits to `privacy-oscal` repository
9. CI/CD pipeline:
   - Runs `oscal-pyprivacy` validation
   - Updates `privacy-mappings` repository
   - Publishes new version
10. `privacy-app` automatically shows new BSI mapping

**Technical Flow**:
- `oscal-workbench` → edits `privacy-oscal` JSON files
- Validation → `oscal-pyprivacy` library
- Git commit → triggers CI/CD
- Webhook → notifies `privacy-app` of new version

---

### Use Case 4: Auditor Review
**Actor**: External auditor (ISO 27001 certification)
**Goal**: Verify agency's privacy control implementation

**Journey**:
1. Auditor receives link to agency's catalog in `oscal-privacy-viewer`
2. Switches to DPO view (professional mode)
3. Filters controls by:
   - ISO 27001: A.9.* (Access Control)
   - Implementation Level: Standard or higher
4. Reviews 12 matching controls
5. For each control, clicks "Show Mappings" to see ISO 27001 Annex A reference
6. Clicks "View Implementation" → links to `privacy-app` showing:
   - Which processing activities use this control
   - Implementation evidence (documents, screenshots)
   - Last review date
7. Exports filtered controls as CSV for audit report
8. Marks audit as complete in certification tracker

**Technical Flow**:
- `oscal-privacy-viewer` → reads `privacy-oscal` + `privacy-mappings`
- Filtering → client-side JavaScript
- Implementation link → API call to `privacy-gateway`
- Export → client-side CSV generation

---

## 📋 Development Priorities

### MVP Status (Current)
**Goal**: Demonstrate the concept works end-to-end

| Repository | Status | Priority | Notes |
|------------|--------|----------|-------|
| opengov-privacy-oscal | 🟢 Active | Critical | Core data source, regularly updated |
| opengov-oscal-privacy-viewer | 🟢 Alpha | High | This repo - see [ROADMAP.md](ROADMAP.md) |
| opengov-privacy-app | 🟡 MVP | High | Basic RoPA functionality working |
| opengov-oscal-pyprivacy | 🟢 Active | Medium | Core utilities available |
| opengov-privacy-mappings | 🟡 Partial | Medium | ISO 27001/27701 mappings exist |
| opengov-security-oscal | 🔴 Planned | Low | Not yet started |
| opengov-oscal-workbench | 🔴 Planned | Low | Future enhancement |
| opengov-privacy-gateway | 🔴 Planned | Low | Not needed for MVP |
| opengov-privacy-data | 🟡 Embedded | Medium | Currently part of privacy-app |
| opengov-pylegal-utils | 🔴 Planned | Low | Nice-to-have utility |

---

### Short-Term Roadmap (Next 3 Months)

#### Phase 1: Complete Viewer (THIS REPO)
**Priority**: 🔴 Critical
**Timeline**: 4-6 weeks

Tasks from [ROADMAP.md](ROADMAP.md):
1. ✅ Wire up catalog detail page (Task 2.1)
2. ✅ Risk-based filtering (Task 2.3)
3. ✅ Multilingual support DE/EN (Task 2.6)
4. ✅ Citizen view toggle (Task 2.7)
5. ✅ PDF/CSV export (Task 2.8)

**Outcome**: Beta release ready for user testing

---

#### Phase 2: Enhance RoPA App
**Priority**: 🟠 High
**Timeline**: 6-8 weeks

Tasks:
1. Complete processing activity CRUD
2. Implement control assignment workflow
3. Build compliance dashboard with ISO/NIST mappings
4. Add DPIA wizard
5. Integrate viewer as embedded component

**Outcome**: Usable RoPA tool for pilot agencies

---

#### Phase 3: Formalize Mappings
**Priority**: 🟠 High
**Timeline**: 4-6 weeks

Tasks:
1. Complete ISO 27001:2022 Annex A mappings
2. Add ISO 27701:2019 PIMS mappings
3. Add BSI IT-Grundschutz mappings
4. Create mapping methodology documentation
5. Set up validation process

**Outcome**: Certified mappings ready for audit

---

### Medium-Term Roadmap (6-12 Months)

#### Phase 4: Profile Support
**Priority**: 🟡 Medium
**Timeline**: 2-3 months

Tasks from [ROADMAP.md](ROADMAP.md):
1. ProfileService implementation (Task 3.1)
2. Profile viewer UI (Task 3.2)
3. Profile comparison (Task 3.3)
4. Component viewer (Tasks 3.4-3.5)

**Outcome**: Agencies can create tailored control sets

---

#### Phase 5: Workbench Development
**Priority**: 🟡 Medium
**Timeline**: 3-4 months

Tasks:
1. Design workbench architecture
2. Build catalog editor
3. Build profile builder
4. Add mapping editor
5. Integrate version control (Git)

**Outcome**: Standards team can maintain catalogs independently

---

#### Phase 6: API & Integration Layer
**Priority**: 🟢 Low (deferred)
**Timeline**: 2-3 months

Tasks:
1. Design API specification (OpenAPI)
2. Implement privacy-gateway with auth
3. Extract privacy-data to separate repo
4. Add webhooks for real-time updates
5. Create API documentation

**Outcome**: External systems can integrate

---

## 🎓 Success Criteria

### MVP Success (Q2 2026)
- ✅ At least 2 pilot agencies using the system
- ✅ Citizen view tested with real users (usability > 80%)
- ✅ DPO can create RoPA entries and assign controls
- ✅ Compliance matrix shows ISO 27001/27701 coverage
- ✅ Viewer deployed to public URL
- ✅ All OSCAL catalogs validated against schema 1.1.2

### v1.0 Success (Q4 2026)
- ✅ 10+ agencies actively using the system
- ✅ Profile resolution fully functional
- ✅ Workbench in production use
- ✅ ISO 27001 certification achieved using the tool
- ✅ WCAG 2.1 AA accessibility compliance
- ✅ 90%+ test coverage across all repositories

### Long-Term Vision (2027+)
- ✅ 100+ European government agencies using the ecosystem
- ✅ Recognized by EU data protection authorities
- ✅ Integration with national e-government frameworks
- ✅ Community-driven catalog maintenance
- ✅ Commercial support available
- ✅ Additional languages (FR, IT, ES, PL)

---

## 🛠️ Technology Stack Overview

| Repository | Frontend | Backend | Data | CI/CD |
|------------|----------|---------|------|-------|
| privacy-viewer | React 18, TypeScript, Vite, Tailwind | - | OSCAL JSON | GitHub Actions |
| privacy-app | React/Vue | Node.js/Express | PostgreSQL | GitHub Actions |
| oscal-workbench | React, Monaco Editor | Node.js | OSCAL JSON | GitHub Actions |
| privacy-gateway | - | FastAPI/Express | Redis (cache) | GitHub Actions |
| oscal-pyprivacy | - | Python 3.10+ | - | GitHub Actions |
| pylegal-utils | - | Python 3.10+ | - | GitHub Actions |

**Shared Standards**:
- OSCAL 1.1.2 (JSON Schema)
- OpenAPI 3.0 (API specs)
- TypeScript strict mode
- Git flow (feature branches)
- Semantic versioning
- Automated testing (>80% coverage)

---

## 📞 Governance & Collaboration

### Repository Ownership
| Repo | Primary Team | Secondary Team | Review Required |
|------|--------------|----------------|-----------------|
| privacy-oscal | Compliance | Standards | Yes (DPO + InfoSec) |
| security-oscal | InfoSec | Compliance | Yes (2 reviewers) |
| privacy-mappings | Standards | Compliance | Yes (External audit) |
| privacy-viewer | Frontend | UX/Accessibility | Yes (1 reviewer) |
| privacy-app | Full-stack | Backend + Frontend | Yes (1 reviewer) |
| oscal-workbench | Frontend | Compliance | Yes (1 reviewer) |
| privacy-gateway | Backend | DevOps | Yes (1 reviewer) |
| oscal-pyprivacy | Backend | Standards | Yes (1 reviewer) |

### Communication Channels
- **Weekly Sync**: All teams, architecture decisions
- **Bi-weekly Demo**: Stakeholders, progress showcase
- **Monthly Review**: External advisors, compliance audit
- **Slack/Teams**: `#opengov-privacy` channel
- **GitHub Issues**: Technical tasks, bugs
- **GitHub Discussions**: Architecture proposals, RFCs

---

## 📚 Further Reading

### Internal Documentation
- [ROADMAP.md](ROADMAP.md) - Detailed viewer roadmap (THIS REPO)
- [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md) - Technical OSCAL details
- [ai-context/ARCHITECTURE.md](ai-context/ARCHITECTURE.md) - Viewer architecture
- [ai-context/CODE_STYLE.md](ai-context/CODE_STYLE.md) - TypeScript conventions

### External Resources
- [NIST OSCAL Documentation](https://pages.nist.gov/OSCAL/)
- [GDPR Official Text](https://gdpr-info.eu/)
- [Standard-Datenschutzmodell (SDM)](https://www.datenschutzzentrum.de/sdm/)
- [ISO/IEC 27701:2019 PIMS](https://www.iso.org/standard/71670.html)
- [BSI IT-Grundschutz](https://www.bsi.bund.de/EN/Topics/ITGrundschutz/itgrundschutz_node.html)

---

**Last Updated**: 2026-01-27
**Document Owner**: Project Architecture Team
**Next Review**: 2026-02-27

**Questions or suggestions?** Open a GitHub Discussion or contact the architecture team.
