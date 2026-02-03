# 🚀 Development Setup Guide

## Quick Start

```bash
# 1. Clone repository
git clone https://github.com/open-gov-group/opengov-oscal-privacy-viewer.git
cd opengov-oscal-privacy-viewer

# 2. Install dependencies
npm install

# 3. Start development server
npm run dev

# 4. Open browser
# http://localhost:5173
```

---

## Prerequisites

### Required
- **Node.js**: v18+ (LTS recommended)
- **npm**: v9+
- **Git**: v2.30+

### Recommended
- **VS Code**: Latest version
- **VS Code Extensions**:
  - ESLint
  - Prettier
  - TypeScript and JavaScript Language Features
  - ES7+ React/Redux/React-Native snippets

---

## Project Structure Migration

### Current Structure → New Structure

```
OLD (Example-based)          NEW (Professional)
─────────────────            ──────────────────
src/
├── App.tsx                  src/
├── App.css                  ├── app/
├── components/              │   ├── App.tsx
│   ├── ControlCard.tsx      │   ├── App.css
│   └── RiskFilter.tsx       │   └── Router.tsx
├── utils/                   │
│   └── ProfileResolver.ts   ├── features/
└── types/                   │   ├── landing/
    └── oscal.d.ts           │   ├── catalogs/
                             │   ├── profiles/
                             │   ├── components/
                             │   └── ssp/
                             │
                             ├── shared/
                             │   ├── components/
                             │   ├── services/
                             │   ├── hooks/
                             │   ├── utils/
                             │   └── types/
                             │
                             └── config/
```

---

## Migration Steps

### Step 1: Backup Current Code

```bash
# Create backup branch
git checkout -b backup/before-restructure
git add .
git commit -m "backup: current working state"
git push origin backup/before-restructure

# Return to main
git checkout main
```

### Step 2: Install New Dependencies

```bash
npm install react-router-dom@6
npm install -D @types/react-router-dom
```

### Step 3: Create New Structure

```bash
# Create directories
mkdir -p src/app
mkdir -p src/features/{landing,catalogs,profiles,components,ssp}
mkdir -p src/shared/{components,services,hooks,utils,types}
mkdir -p src/config

# Move existing files (we'll do this incrementally)
```

### Step 4: Migrate Components (One by One)

**Example: Migrate ControlCard**

```bash
# 1. Copy to new location
cp src/components/ControlCard.tsx src/shared/components/oscal/ControlCard.tsx
cp src/components/ControlCard.css src/shared/components/oscal/ControlCard.css

# 2. Update imports in ControlCard.tsx
# Change: import type { Control } from '@/types/oscal'
# To: import type { Control } from '@/shared/types/oscal'

# 3. Test
npm run dev

# 4. If working, remove old file
rm src/components/ControlCard.tsx
```

### Step 5: Setup Routing

```bash
# 1. Copy Router.tsx
cp /path/to/new/Router.tsx src/app/

# 2. Update App.tsx
cp /path/to/new/App.tsx src/app/

# 3. Update main.tsx
```

**Update `src/main.tsx`**:
```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from './app/App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
```

### Step 6: Create Landing Page

```bash
# Copy LandingPage
cp /path/to/LandingPage.tsx src/features/landing/
cp /path/to/LandingPage.css src/features/landing/
```

### Step 7: Refactor Catalog Feature

**Create `src/features/catalogs/CatalogBrowser.tsx`**:
```tsx
import React, { useState } from 'react';
import { useParams } from 'react-router-dom';
import { CatalogTreeNavigation } from './components/CatalogTreeNav';
import { CatalogDetailView } from './components/CatalogDetail';
import { useCatalogLoader } from './hooks/useCatalogLoader';

export const CatalogBrowser: React.FC = () => {
  const { catalogId } = useParams();
  const { catalog, loading, error } = useCatalogLoader(catalogId);
  const [selectedItem, setSelectedItem] = useState(null);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!catalog) return <div>Catalog not found</div>;

  return (
    <div className="catalog-browser">
      <aside className="catalog-nav">
        <CatalogTreeNavigation
          catalog={catalog}
          onSelect={setSelectedItem}
          selectedId={selectedItem?.id}
        />
      </aside>
      <main className="catalog-content">
        <CatalogDetailView item={selectedItem} />
      </main>
    </div>
  );
};
```

---

## TypeScript Path Aliases

**Update `tsconfig.json`**:
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/app/*": ["src/app/*"],
      "@/features/*": ["src/features/*"],
      "@/shared/*": ["src/shared/*"],
      "@/config/*": ["src/config/*"]
    }
  }
}
```

**Update `vite.config.ts`**:
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@/app': path.resolve(__dirname, './src/app'),
      '@/features': path.resolve(__dirname, './src/features'),
      '@/shared': path.resolve(__dirname, './src/shared'),
      '@/config': path.resolve(__dirname, './src/config'),
    },
  },
});
```

---

## Development Workflow

### Daily Development

```bash
# 1. Pull latest changes
git pull origin main

# 2. Create feature branch
git checkout -b feature/catalog-search

# 3. Make changes
# ... code ...

# 4. Test locally
npm run dev

# 5. Run linter
npm run lint

# 6. Run tests (when available)
npm run test

# 7. Commit changes
git add .
git commit -m "feat: add catalog search functionality"

# 8. Push to remote
git push origin feature/catalog-search

# 9. Create Pull Request on GitHub
```

### Code Quality Checks

```bash
# Format code
npm run format

# Lint code
npm run lint

# Type check
npm run type-check

# Build production
npm run build
```

---

## Testing Strategy

### Unit Tests (Services)

**Create `src/shared/services/__tests__/ProfileResolver.test.ts`**:
```typescript
import { describe, it, expect } from 'vitest';
import { ProfileResolver } from '../ProfileResolver';

describe('ProfileResolver', () => {
  it('should resolve profile with imports', async () => {
    const resolver = new ProfileResolver();
    const result = await resolver.resolveProfile(testUrl);
    expect(result).toBeDefined();
  });
});
```

### Component Tests (React Testing Library)

**Create `src/shared/components/oscal/__tests__/ControlCard.test.tsx`**:
```typescript
import { render, screen } from '@testing-library/react';
import { ControlCard } from '../ControlCard';

describe('ControlCard', () => {
  it('renders control title', () => {
    render(<ControlCard control={mockControl} />);
    expect(screen.getByText('Test Control')).toBeInTheDocument();
  });
});
```

---

## Common Issues & Solutions

### Issue: Import paths broken after restructure

**Solution**:
```bash
# Use VS Code "Find and Replace" (Ctrl+Shift+H)
# Find: from './components/
# Replace: from '@/shared/components/
```

### Issue: Type errors after moving files

**Solution**:
```bash
# Restart TypeScript server in VS Code
# Ctrl+Shift+P → "TypeScript: Restart TS Server"
```

### Issue: CSS not loading

**Solution**:
```tsx
// Make sure to import CSS in component
import './ComponentName.css';
```

---

## Incremental Migration Plan

### Phase 1: Setup (Week 1)
- [ ] Create new directory structure
- [ ] Setup TypeScript path aliases
- [ ] Install React Router
- [ ] Create Router configuration
- [ ] Create Landing Page

### Phase 2: Core Migration (Week 2)
- [ ] Move ControlCard to shared/components/oscal
- [ ] Move RiskFilter to shared/components/oscal
- [ ] Move ProfileResolver to shared/services
- [ ] Move types to shared/types
- [ ] Update all imports

### Phase 3: Feature Modules (Week 3)
- [ ] Create Catalog Browser feature
- [ ] Create Profile Manager feature
- [ ] Create Component Library feature
- [ ] Create SSP Builder feature

### Phase 4: Polish (Week 4)
- [ ] Add tests
- [ ] Complete documentation
- [ ] Performance optimization
- [ ] Accessibility audit

---

## Team Collaboration

### Before Starting Work
1. Check #dev-channel for ongoing work
2. Assign yourself to issue on GitHub
3. Create feature branch
4. Update this README if needed

### During Development
1. Commit frequently (small, focused commits)
2. Write descriptive commit messages
3. Push to remote daily
4. Ask questions in #dev-channel

### After Completing Feature
1. Self-review code
2. Run all quality checks
3. Create Pull Request
4. Request review from team member
5. Address review comments
6. Merge after approval

---

## Resources

### Documentation
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Full architecture documentation
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [React Router Docs](https://reactrouter.com/)

### Tools
- [VS Code](https://code.visualstudio.com/)
- [GitHub Desktop](https://desktop.github.com/)
- [Postman](https://www.postman.com/) (API testing)

### Learning
- [React Patterns](https://reactpatterns.com/)
- [TypeScript Best Practices](https://github.com/typescript-cheatsheets/react)
- [Clean Code JavaScript](https://github.com/ryanmcdermott/clean-code-javascript)

---

## Contact

- **Team Lead**: [Name]
- **Dev Channel**: #oscal-privacy-dev
- **Issues**: GitHub Issues
- **Email**: dev-team@opengov.group

---

**Last Updated**: 2025-01-26  
**Maintained By**: Development Team
