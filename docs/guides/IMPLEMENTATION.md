# 🛠️ Implementation Guide - OpenGov OSCAL Privacy Viewer

**For**: Developers joining the project
**Level**: Intermediate to Advanced
**Time**: ~2 hours to complete setup

---

## Table of Contents
1. [Getting Started](#getting-started)
2. [Development Workflow](#development-workflow)
3. [Project Structure](#project-structure)
4. [Adding New Features](#adding-new-features)
5. [Testing Strategy](#testing-strategy)
6. [Code Style & Standards](#code-style--standards)
7. [Troubleshooting](#troubleshooting)

---

## Getting Started

### Prerequisites

**Required**:
- Node.js >= 20.0.0
- npm >= 10.0.0
- Git >= 2.40.0

**Recommended**:
- VS Code with extensions:
  - ESLint
  - Prettier
  - TypeScript Vue Plugin (Volar)
  - Tailwind CSS IntelliSense

### Initial Setup

#### 1. Clone Repository

```bash
git clone https://github.com/open-gov-group/opengov-oscal-privacy-viewer.git
cd opengov-oscal-privacy-viewer
```

#### 2. Install Dependencies

```bash
npm install
```

#### 3. Start Development Server

```bash
npm run dev
```

**Opens at**: http://localhost:3000

#### 4. Run Tests

```bash
npm run test        # Unit tests
npm run test:watch  # Watch mode
npm run type-check  # TypeScript validation
npm run lint        # ESLint check
```

---

## Development Workflow

### Branch Strategy

**Main Branches**:
- `main` - Production-ready code
- `develop` - Integration branch for features

**Feature Branches**:
```bash
# Format: feature/OSCAL-XXX-short-description
git checkout -b feature/OSCAL-002-citizen-view develop
```

### Commit Messages

**Format**: Conventional Commits

```bash
# Feature
git commit -m "feat(catalog): add risk-based filtering"

# Bug fix
git commit -m "fix(tree-nav): resolve keyboard navigation issue"

# Documentation
git commit -m "docs(readme): update installation steps"

# Test
git commit -m "test(catalog-service): add caching tests"

# Refactor
git commit -m "refactor(control-card): extract tab logic to hook"
```

**Types**:
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation only
- `style` - Formatting (no code change)
- `refactor` - Code change (no feature/fix)
- `test` - Adding/updating tests
- `chore` - Build/tooling changes

### Pull Request Process

#### 1. Create PR

```bash
# Push feature branch
git push origin feature/OSCAL-002-citizen-view

# Create PR on GitHub
# Title: "feat(catalog): Add citizen view toggle (OSCAL-002)"
```

#### 2. PR Template

```markdown
## Description
Brief description of changes

## Related Issue
Closes #123

## Type of Change
- [ ] Bug fix
- [x] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [x] Unit tests added/updated
- [x] Manual testing completed
- [x] Accessibility tested

## Checklist
- [x] Code follows style guide
- [x] Self-reviewed code
- [x] Commented complex logic
- [x] Documentation updated
- [x] No console errors
```

#### 3. Code Review

**Reviewers**: At least 1 approval required

**Review Focus**:
- TypeScript strict mode compliance
- Test coverage
- Accessibility (WCAG 2.1 AA)
- Security (no secrets, input validation)
- Performance (no N+1 queries, memoization)

#### 4. Merge

```bash
# Squash merge to main/develop
git checkout develop
git merge --squash feature/OSCAL-002-citizen-view
git commit
git push origin develop
```

---

## Project Structure

### Directory Layout

```
opengov-oscal-privacy-viewer/
├── .github/
│   └── workflows/          # CI/CD pipelines
├── .husky/                 # Git hooks
├── ai-context/             # AI agent documentation
│   ├── ARCHITECTURE.md
│   ├── CODE_STYLE.md
│   └── DEVELOPMENT.md
├── docs/
│   ├── guides/             # Production guides
│   │   ├── DEPLOYMENT.md
│   │   ├── SECURITY.md
│   │   └── IMPLEMENTATION.md (this file)
│   └── architecture/       # Architecture diagrams
├── features/               # Feature specifications
│   └── OSCAL-001-catalog-viewer.md
├── public/                 # Static assets
│   ├── index.html
│   └── health.json
├── src/
│   ├── app/                # Application core
│   │   ├── App.tsx         # Root component
│   │   ├── Router.tsx      # Route configuration
│   │   └── Layout.tsx      # Main layout
│   ├── features/           # Feature modules
│   │   ├── landing/
│   │   ├── catalogs/
│   │   ├── profiles/
│   │   ├── components/
│   │   └── ssp/
│   ├── components/         # Shared UI components
│   │   └── common/
│   ├── services/           # Business logic
│   │   └── CatalogService.ts
│   ├── hooks/              # Custom React hooks
│   ├── utils/              # Utilities
│   ├── types/              # TypeScript definitions
│   │   └── oscal.d.ts
│   ├── i18n/               # Internationalization
│   │   ├── config.ts
│   │   └── locales/
│   ├── styles/             # Global styles
│   ├── main.tsx            # Entry point
│   └── vite-env.d.ts
├── tests/
│   └── integration/
├── PROJECT_CONTEXT.md      # Single source of truth
├── package.json
├── tsconfig.json
├── vite.config.ts
└── tailwind.config.js
```

### Key Files

| File | Purpose |
|------|---------|
| [PROJECT_CONTEXT.md](../../PROJECT_CONTEXT.md) | Project overview, links to all docs |
| [ai-context/CODE_STYLE.md](../../ai-context/CODE_STYLE.md) | TypeScript conventions, patterns |
| [src/types/oscal.d.ts](../../src/types/oscal.d.ts) | OSCAL type definitions |
| [src/services/CatalogService.ts](../../src/services/CatalogService.ts) | Core business logic |

---

## Adding New Features

### Step-by-Step Process

#### 1. Create Feature Spec

Create `features/OSCAL-XXX-feature-name.md`:

```markdown
# Feature: OSCAL-XXX - Feature Name

**Status**: Planning
**Priority**: P1
**Team**: Frontend
**Stakeholders**: DPO

## Overview
What does this feature do?

## Business Requirements
- User story 1
- User story 2

## Technical Specification
How will it work?

## Testing
How will we test it?
```

#### 2. Create Feature Branch

```bash
git checkout -b feature/OSCAL-XXX-feature-name develop
```

#### 3. Implement Feature

**Example**: Adding a new service

[src/services/ProfileService.ts](../../src/services/ProfileService.ts):

```typescript
/**
 * ProfileService - Business logic for OSCAL profile operations
 *
 * @module services/ProfileService
 */

import type { OSCALProfile, OSCALCatalog } from '@/types/oscal';
import { catalogService } from './CatalogService';

export class ProfileService {
  private cache: Map<string, OSCALProfile> = new Map();

  /**
   * Fetch and resolve an OSCAL profile
   *
   * @param url - Profile URL
   * @returns Resolved profile with imported controls
   */
  async fetchProfile(url: string): Promise<OSCALProfile> {
    if (this.cache.has(url)) {
      return this.cache.get(url)!;
    }

    const response = await fetch(url);
    const data = await response.json();
    const profile = this.parseProfile(data);

    // Resolve imports
    const resolvedProfile = await this.resolveProfile(profile);

    this.cache.set(url, resolvedProfile);
    return resolvedProfile;
  }

  private parseProfile(data: unknown): OSCALProfile {
    // Implementation
    return data as OSCALProfile;
  }

  private async resolveProfile(profile: OSCALProfile): Promise<OSCALProfile> {
    // Fetch imported catalogs
    // Apply modify operations
    // Return resolved profile
    return profile;
  }
}

export const profileService = new ProfileService();
```

#### 4. Add Tests

[src/services/ProfileService.test.ts](../../src/services/ProfileService.test.ts):

```typescript
import { describe, it, expect, beforeEach } from 'vitest';
import { ProfileService } from './ProfileService';

describe('ProfileService', () => {
  let service: ProfileService;

  beforeEach(() => {
    service = new ProfileService();
  });

  it('fetches and caches profile', async () => {
    const url = 'https://example.com/profile.json';
    const profile = await service.fetchProfile(url);

    expect(profile).toBeDefined();
    expect(profile.uuid).toBeDefined();
  });

  it('resolves imported catalogs', async () => {
    const profile = await service.fetchProfile(testUrl);
    // Verify controls imported
  });
});
```

#### 5. Add UI Component

[src/features/profiles/ProfileDetailPage.tsx](../../src/features/profiles/ProfileDetailPage.tsx):

```typescript
/**
 * ProfileDetailPage - Display resolved OSCAL profile
 */

import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { profileService } from '@/services/ProfileService';
import type { OSCALProfile } from '@/types/oscal';

export function ProfileDetailPage() {
  const { profileId } = useParams();
  const [profile, setProfile] = useState<OSCALProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!profileId) return;

    const loadProfile = async () => {
      try {
        setLoading(true);
        const url = getProfileUrl(profileId);
        const loadedProfile = await profileService.fetchProfile(url);
        setProfile(loadedProfile);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error');
      } finally {
        setLoading(false);
      }
    };

    loadProfile();
  }, [profileId]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!profile) return <div>Profile not found</div>;

  return (
    <div>
      <h1>{profile.metadata.title}</h1>
      {/* Profile content */}
    </div>
  );
}

function getProfileUrl(id: string): string {
  // Map ID to URL
  return `https://example.com/profiles/${id}.json`;
}
```

#### 6. Update Documentation

Update [features/OSCAL-XXX-feature-name.md](../../features/):
- Change status to "Complete"
- Add implementation notes
- Document any deviations from spec

#### 7. Create Pull Request

See [Pull Request Process](#pull-request-process) above.

---

## Testing Strategy

### Unit Tests

**Framework**: Vitest + React Testing Library

**Location**: `*.test.tsx` or `*.test.ts` alongside component/service

**Example**:

```typescript
import { render, screen } from '@testing-library/react';
import { ControlCard } from './ControlCard';

describe('ControlCard', () => {
  it('renders control title', () => {
    const control = {
      id: 'AC-1',
      title: 'Access Control',
      props: [],
    };

    render(<ControlCard control={control} />);

    expect(screen.getByText('Access Control')).toBeInTheDocument();
  });

  it('displays risk metadata', () => {
    const control = {
      id: 'AC-1',
      title: 'Access Control',
      props: [
        { name: 'dp-risk-impact', value: 'high' },
        { name: 'dp-likelihood', value: 'moderate' },
      ],
    };

    render(<ControlCard control={control} />);

    expect(screen.getByText('high')).toBeInTheDocument();
    expect(screen.getByText('moderate')).toBeInTheDocument();
  });
});
```

**Run**:
```bash
npm run test                # Run once
npm run test:watch          # Watch mode
npm run test:coverage       # With coverage
```

---

### Integration Tests

**Location**: `tests/integration/`

**Example**:

```typescript
import { render, screen, waitFor } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';
import { CatalogDetailPage } from '@/features/catalogs/CatalogDetailPage';

describe('Catalog Viewer Integration', () => {
  it('loads catalog and displays controls', async () => {
    render(
      <BrowserRouter>
        <CatalogDetailPage />
      </BrowserRouter>
    );

    // Wait for catalog to load
    await waitFor(() => {
      expect(screen.getByRole('tree')).toBeInTheDocument();
    });

    // Verify controls displayed
    expect(screen.getByText(/SDM-TOM-AC-01/i)).toBeInTheDocument();
  });
});
```

---

### E2E Tests

**Framework**: Playwright

**Location**: `e2e/`

**Setup**:
```bash
npm install -D @playwright/test
npx playwright install
```

**Example**:

```typescript
import { test, expect } from '@playwright/test';

test('complete catalog viewing flow', async ({ page }) => {
  // Navigate to catalog
  await page.goto('/catalogs/sdm-privacy');

  // Wait for tree navigation
  await page.waitForSelector('[role="tree"]');

  // Expand group
  await page.click('text=Access Control');

  // Click control
  await page.click('text=SDM-TOM-AC-01');

  // Verify control card visible
  await expect(page.locator('.control-card')).toBeVisible();
});
```

**Run**:
```bash
npx playwright test               # Headless
npx playwright test --headed      # With browser
npx playwright test --debug       # Debug mode
```

---

## Code Style & Standards

### TypeScript

**Strict Mode**: Always enabled

```typescript
// ✅ Good - Explicit types
function loadCatalog(url: string): Promise<OSCALCatalog> {
  // ...
}

// ❌ Bad - Implicit any
function loadCatalog(url) {
  // ...
}
```

**Interfaces over Types** for objects:

```typescript
// ✅ Good
interface CatalogProps {
  catalog: OSCALCatalog;
  onSelect: (control: Control) => void;
}

// ❌ Avoid (unless union/intersection)
type CatalogProps = {
  catalog: OSCALCatalog;
  onSelect: (control: Control) => void;
};
```

### React Patterns

**Functional Components Only**:

```typescript
// ✅ Good
export function MyComponent({ prop }: Props) {
  return <div>{prop}</div>;
}

// ❌ Avoid
class MyComponent extends React.Component {
  render() {
    return <div>{this.props.prop}</div>;
  }
}
```

**Props Interfaces**:

```typescript
interface MyComponentProps {
  title: string;
  count: number;
  onUpdate?: (value: number) => void;
}

export function MyComponent({ title, count, onUpdate }: MyComponentProps) {
  // ...
}
```

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Components | PascalCase | `CatalogTreeNavigation` |
| Functions | camelCase | `loadCatalog`, `getUserName` |
| Constants | SCREAMING_SNAKE_CASE | `MAX_RETRY_COUNT` |
| Types/Interfaces | PascalCase | `OSCALCatalog`, `TreeItem` |
| Files (components) | PascalCase | `ControlCard.tsx` |
| Files (utils) | kebab-case | `url-params.ts` |
| CSS classes | kebab-case | `control-card`, `tree-nav` |

---

## Troubleshooting

### Common Issues

#### 1. "Module not found" Error

**Cause**: Path alias not recognized

**Fix**: Restart TypeScript server
- VS Code: Cmd+Shift+P → "TypeScript: Restart TS Server"

#### 2. Tests Fail with "fetch is not defined"

**Cause**: Node.js doesn't have fetch built-in (pre-18)

**Fix**: Add to test setup

```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./tests/setup.ts'],
  },
});
```

```typescript
// tests/setup.ts
import { fetch } from 'cross-fetch';
global.fetch = fetch;
```

#### 3. Build Fails with "Out of Memory"

**Cause**: Large bundle, insufficient Node memory

**Fix**: Increase memory limit

```bash
NODE_OPTIONS=--max-old-space-size=4096 npm run build
```

#### 4. Lint Errors on Save

**Cause**: ESLint auto-fix conflicts with Prettier

**Fix**: Configure VS Code

```json
// .vscode/settings.json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

---

## Development Tools

### VS Code Extensions

**Required**:
- ESLint
- Prettier - Code formatter
- TypeScript Vue Plugin (Volar)

**Recommended**:
- Tailwind CSS IntelliSense
- GitLens
- Error Lens
- Auto Rename Tag
- Import Cost

### Browser Extensions

**Development**:
- React Developer Tools
- axe DevTools (accessibility)
- Lighthouse

---

## Resources

### Documentation
- [PROJECT_CONTEXT.md](../../PROJECT_CONTEXT.md) - Project overview
- [CODE_STYLE.md](../../ai-context/CODE_STYLE.md) - Coding standards
- [ARCHITECTURE.md](../../ai-context/ARCHITECTURE.md) - System design

### External
- [React Docs](https://react.dev)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [Vitest Guide](https://vitest.dev/guide/)
- [OSCAL Documentation](https://pages.nist.gov/OSCAL/)

---

## Getting Help

**Questions?**
- Check [PROJECT_CONTEXT.md](../../PROJECT_CONTEXT.md) first
- Search existing GitHub issues
- Ask in team Slack channel: `#opengov-privacy`
- Tag @frontend-team in PR for review

**Found a Bug?**
- Open GitHub issue with:
  - Steps to reproduce
  - Expected vs actual behavior
  - Screenshots (if UI bug)
  - Environment (browser, OS)

---

**Last Updated**: 2026-01-27
**Maintained By**: Frontend Team
**Feedback**: Open an issue or PR
