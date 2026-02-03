# Privacy Gateway - API-Spezifikation

**Version**: 1.0.0-draft
**Stand**: 2026-02-02
**Status**: Entwurf
**Base URL**: `https://api.opengov-privacy.eu/v1`

---

## Übersicht

Der Privacy Gateway ist die zentrale REST-API für das OpenGov Privacy Ecosystem. Er bietet einheitlichen Zugriff auf OSCAL-Kataloge, Mappings, RoPA-Daten und Compliance-Funktionen.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         Privacy Gateway                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   /catalogs     /profiles     /controls     /ropa     /compliance       │
│       │             │             │           │            │            │
│       ▼             ▼             ▼           ▼            ▼            │
│   ┌─────────────────────────────────────────────────────────────────┐  │
│   │                    FastAPI + Uvicorn                             │  │
│   └─────────────────────────────────────────────────────────────────┘  │
│       │                                                     │          │
│       ▼                                                     ▼          │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────────────────────┐ │
│   │ pyprivacy   │     │ Redis Cache │     │ PostgreSQL (optional)   │ │
│   └─────────────┘     └─────────────┘     └─────────────────────────┘ │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Authentifizierung

### Öffentliche Endpoints (kein Auth)
- `GET /catalogs` - Katalog-Liste
- `GET /catalogs/{id}` - Katalog-Details
- `GET /controls/{id}` - Control-Details

### Geschützte Endpoints (OAuth2)
- Alle `/ropa/*` Endpoints
- `POST /export/*` Endpoints
- Admin-Endpoints

### API-Key (für Integrationen)
```http
Authorization: Bearer <api-key>
X-API-Key: <api-key>
```

### OAuth2 Scopes
| Scope | Beschreibung |
|-------|-------------|
| `read:catalogs` | Kataloge lesen |
| `read:ropa` | RoPA-Daten lesen |
| `write:ropa` | RoPA-Daten schreiben |
| `admin` | Administratorzugriff |

---

## Endpoints

### 1. Catalogs

#### Liste aller Kataloge
```http
GET /catalogs
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `type` | string | Filter: `privacy`, `security`, `all` |
| `language` | string | Sprache: `de`, `en`, `fr` |
| `limit` | integer | Max. Ergebnisse (default: 50) |
| `offset` | integer | Pagination Offset |

**Response:**
```json
{
  "data": [
    {
      "id": "sdm_privacy_catalog",
      "title": "SDM Privacy Catalog",
      "version": "1.0.0",
      "type": "privacy",
      "control_count": 45,
      "last_modified": "2026-01-15T10:30:00Z",
      "links": {
        "self": "/catalogs/sdm_privacy_catalog",
        "controls": "/catalogs/sdm_privacy_catalog/controls"
      }
    }
  ],
  "meta": {
    "total": 3,
    "limit": 50,
    "offset": 0
  }
}
```

#### Einzelner Katalog
```http
GET /catalogs/{catalog_id}
```

**Response:**
```json
{
  "data": {
    "id": "sdm_privacy_catalog",
    "metadata": {
      "title": "SDM Privacy Catalog",
      "version": "1.0.0",
      "last_modified": "2026-01-15T10:30:00Z",
      "oscal_version": "1.1.2"
    },
    "groups": [
      {
        "id": "tom",
        "title": "Technische und organisatorische Maßnahmen",
        "control_count": 25
      }
    ],
    "controls": [
      {
        "id": "SDM-TOM-AC-01",
        "title": "Role-based Access Control",
        "class": "technical"
      }
    ]
  }
}
```

#### Katalog-Controls
```http
GET /catalogs/{catalog_id}/controls
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `group` | string | Filter nach Gruppe |
| `class` | string | Filter: `technical`, `organizational` |
| `gdpr_article` | string | Filter nach DSGVO-Artikel |
| `implementation_level` | string | `baseline`, `standard`, `enhanced` |
| `search` | string | Volltextsuche |

**Response:**
```json
{
  "data": [
    {
      "id": "SDM-TOM-AC-01",
      "title": "Role-based Access Control",
      "description": "Implementierung rollenbasierter Zugriffskontrolle...",
      "class": "technical",
      "props": {
        "citizen_title_de": "Zugriffskontrolle",
        "citizen_title_en": "Access Control",
        "gdpr_article": ["Art. 25", "Art. 32"],
        "implementation_level": "standard",
        "dp_risk_impact": 4,
        "dp_likelihood": 3
      },
      "links": {
        "self": "/controls/SDM-TOM-AC-01",
        "mappings": "/controls/SDM-TOM-AC-01/mappings"
      }
    }
  ],
  "meta": {
    "total": 45,
    "filtered": 12
  }
}
```

---

### 2. Profiles

#### Profil auflösen
```http
GET /profiles/{profile_id}/resolve
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `include_withdrawn` | boolean | Auch zurückgezogene Controls |
| `format` | string | `full`, `summary`, `ids_only` |

**Response:**
```json
{
  "data": {
    "id": "profile-melderegister",
    "title": "Melderegister Privacy Profile",
    "imports": [
      {
        "catalog_id": "sdm_privacy_catalog",
        "included_controls": ["SDM-TOM-AC-01", "SDM-TOM-LG-01"]
      }
    ],
    "resolved_controls": [
      {
        "id": "SDM-TOM-AC-01",
        "title": "Role-based Access Control",
        "modifications": {
          "implementation_level": "enhanced"
        }
      }
    ],
    "control_count": 15
  }
}
```

---

### 3. Controls

#### Control-Details
```http
GET /controls/{control_id}
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `language` | string | Sprache für citizen_title |
| `include_mappings` | boolean | Mappings einschließen |

**Response:**
```json
{
  "data": {
    "id": "SDM-TOM-AC-01",
    "title": "Role-based Access Control",
    "description": "Die Organisation implementiert...",
    "props": {
      "citizen_title": "Zugriffskontrolle",
      "gdpr_article": ["Art. 25", "Art. 32"],
      "implementation_level": "standard"
    },
    "parts": [
      {
        "name": "guidance",
        "prose": "Implementierungshinweise..."
      }
    ],
    "mappings": [
      {
        "framework": "ISO 27001:2022",
        "control_id": "A.9.2.1",
        "type": "equivalent"
      }
    ]
  }
}
```

#### Control-Mappings
```http
GET /controls/{control_id}/mappings
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `framework` | string | Filter: `iso27001`, `iso27701`, `bsi`, `nist` |
| `type` | string | `equivalent`, `related`, `partial` |

**Response:**
```json
{
  "data": {
    "control_id": "SDM-TOM-AC-01",
    "mappings": [
      {
        "framework": "ISO/IEC 27001:2022",
        "controls": [
          {
            "id": "A.9.2.1",
            "title": "User registration and de-registration",
            "mapping_type": "equivalent",
            "confidence": 0.95,
            "notes": "Direktes Mapping"
          }
        ]
      },
      {
        "framework": "BSI IT-Grundschutz",
        "controls": [
          {
            "id": "ORP.4.A1",
            "title": "Regelung für die Einrichtung von Benutzern",
            "mapping_type": "related",
            "confidence": 0.85
          }
        ]
      }
    ]
  }
}
```

---

### 4. Controls Search

#### Volltextsuche
```http
GET /controls/search
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `q` | string | Suchbegriff (required) |
| `catalogs` | string[] | Katalog-Filter |
| `gdpr_article` | string | DSGVO-Artikel-Filter |
| `language` | string | Suchsprache |

**Response:**
```json
{
  "data": [
    {
      "id": "SDM-TOM-AC-01",
      "catalog_id": "sdm_privacy_catalog",
      "title": "Role-based Access Control",
      "snippet": "...implementiert <em>Zugriffskontrolle</em> basierend auf...",
      "score": 0.95
    }
  ],
  "meta": {
    "query": "Zugriffskontrolle",
    "total": 5,
    "search_time_ms": 42
  }
}
```

---

### 5. RoPA (Records of Processing Activities)

#### Liste der Verarbeitungstätigkeiten
```http
GET /ropa/activities
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `status` | string | `active`, `archived`, `draft` |
| `department` | string | Abteilungs-Filter |
| `search` | string | Volltextsuche |

**Response:**
```json
{
  "data": [
    {
      "id": "proc-001",
      "name": "Bürgerregistrierung",
      "purpose": "Führung des Melderegisters",
      "legal_basis": "Art. 6 Abs. 1 lit. e DSGVO",
      "status": "active",
      "data_categories": ["Name", "Adresse", "Geburtsdatum"],
      "assigned_controls": 12,
      "compliance_status": {
        "gdpr": 0.95,
        "iso27001": 0.78
      },
      "last_review": "2026-01-10T14:00:00Z"
    }
  ]
}
```

#### Neue Verarbeitungstätigkeit
```http
POST /ropa/activities
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Newsletter-Versand",
  "purpose": "Information der Bürger über kommunale Ereignisse",
  "legal_basis": "Art. 6 Abs. 1 lit. a DSGVO",
  "data_categories": ["E-Mail", "Name"],
  "recipients": ["E-Mail-Dienstleister"],
  "retention_period": "Bis zum Widerruf",
  "department": "Öffentlichkeitsarbeit"
}
```

**Response:**
```json
{
  "data": {
    "id": "proc-042",
    "name": "Newsletter-Versand",
    "status": "draft",
    "created_at": "2026-02-02T10:00:00Z",
    "suggested_controls": [
      {
        "id": "SDM-TOM-AC-01",
        "reason": "E-Mail-Adressen erfordern Zugriffskontrolle",
        "implementation_level": "baseline"
      }
    ]
  }
}
```

#### Control-Zuweisung
```http
POST /ropa/activities/{activity_id}/controls
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "control_id": "SDM-TOM-AC-01",
  "implementation_status": "implemented",
  "evidence": {
    "description": "Rollenbasierte Berechtigungen in SAP konfiguriert",
    "document_url": "/documents/access-control-config.pdf"
  },
  "assigned_to": "it-security@gemeinde.de"
}
```

---

### 6. Compliance

#### Compliance-Matrix
```http
GET /compliance/matrix
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| `frameworks` | string[] | `gdpr`, `iso27001`, `iso27701`, `bsi` |
| `scope` | string | `organization`, `activity:{id}` |

**Response:**
```json
{
  "data": {
    "organization": "Stadtverwaltung Musterstadt",
    "generated_at": "2026-02-02T10:30:00Z",
    "frameworks": [
      {
        "name": "GDPR",
        "compliance_rate": 0.92,
        "controls_total": 45,
        "controls_implemented": 41,
        "controls_partial": 3,
        "controls_missing": 1
      },
      {
        "name": "ISO 27001:2022",
        "compliance_rate": 0.78,
        "controls_total": 93,
        "controls_implemented": 72
      }
    ],
    "gaps": [
      {
        "control_id": "SDM-TOM-DEL-01",
        "title": "Datenlöschung",
        "status": "not_implemented",
        "recommendation": "Löschkonzept erstellen"
      }
    ]
  }
}
```

---

### 7. Export

#### PDF-Export
```http
POST /export/pdf
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "type": "catalog",
  "catalog_id": "sdm_privacy_catalog",
  "options": {
    "language": "de",
    "include_mappings": true,
    "view": "professional"
  }
}
```

**Response:**
```json
{
  "data": {
    "job_id": "export-12345",
    "status": "processing",
    "estimated_time_seconds": 30
  }
}
```

#### Export-Status
```http
GET /export/{job_id}
```

**Response:**
```json
{
  "data": {
    "job_id": "export-12345",
    "status": "completed",
    "download_url": "/downloads/export-12345.pdf",
    "expires_at": "2026-02-02T11:00:00Z"
  }
}
```

---

## Fehlerbehandlung

### Fehlerformat
```json
{
  "error": {
    "code": "CONTROL_NOT_FOUND",
    "message": "Control with ID 'XYZ' not found",
    "details": {
      "control_id": "XYZ",
      "searched_catalogs": ["sdm_privacy_catalog"]
    },
    "request_id": "req-abc-123"
  }
}
```

### HTTP Status Codes

| Code | Bedeutung |
|------|-----------|
| 200 | Erfolg |
| 201 | Erstellt |
| 400 | Ungültige Anfrage |
| 401 | Nicht authentifiziert |
| 403 | Keine Berechtigung |
| 404 | Nicht gefunden |
| 429 | Rate Limit erreicht |
| 500 | Server-Fehler |

---

## Rate Limiting

| Endpoint-Typ | Limit |
|--------------|-------|
| Öffentlich (anonym) | 100/min |
| Authentifiziert | 1000/min |
| Export | 10/min |

**Headers:**
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 950
X-RateLimit-Reset: 1706868000
```

---

## Versionierung

- API-Version im Pfad: `/v1/`, `/v2/`
- Deprecation via Header: `Deprecation: true`
- Mindestens 6 Monate Support für alte Versionen

---

## OpenAPI-Spezifikation

Die vollständige OpenAPI 3.0 Spezifikation ist verfügbar unter:
- Swagger UI: `https://api.opengov-privacy.eu/docs`
- OpenAPI JSON: `https://api.opengov-privacy.eu/openapi.json`
- OpenAPI YAML: `https://api.opengov-privacy.eu/openapi.yaml`

---

**Nächste Review**: 2026-03-01
**Verantwortlich**: Backend Team
