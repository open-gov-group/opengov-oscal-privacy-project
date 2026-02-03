# 🏗️ OSCAL Privacy Viewer - Software Architecture

## Project Overview

Professional OSCAL viewer for privacy and data protection compliance.

**Version**: 1.0.0  
**Stack**: React 18 + TypeScript + Vite  
**Standards**: OSCAL 1.1.2, GDPR, SDM, BSI  
**Users**: DPOs, Compliance Teams, Citizens

---

## 🎯 Core Principles

### 1. **Separation of Concerns**
- **Views**: User-facing pages
- **Components**: Reusable UI
- **Services**: Business logic
- **Types**: TypeScript definitions
- **Utils**: Helpers

### 2. **Clean Code**
- ✅ Single Responsibility
- ✅ DRY (Don't Repeat Yourself)
- ✅ KISS (Keep It Simple)
- ✅ Full Documentation
- ✅ Type Safety

### 3. **OOP Principles**
- Encapsulation
- Inheritance
- Polymorphism
- Abstraction

---

## 📁 Directory Structure

```
src/
├── views/              # Pages
│   ├── landing/
│   ├── catalogs/
│   ├── profiles/
│   ├── components/
│   └── ssp/
├── components/         # Shared UI
│   ├── common/
│   ├── oscal/
│   └── filters/
├── services/           # Business logic
│   ├── oscal/
│   ├── api/
│   └── storage/
├── types/              # TypeScript
├── utils/              # Helpers
└── config/             # Configuration
```

---

## 🔀 Navigation

```
/ (Landing)
├── About
├── User Groups
└── Entry Points:
    ├── /catalogs
    ├── /profiles
    ├── /components
    └── /ssp

/catalogs
└── /catalogs/:id
    ├── Tree (left)
    ├── Content (center)
    └── Filters (right)
```

---

**Status**: ✅ Ready for implementation
