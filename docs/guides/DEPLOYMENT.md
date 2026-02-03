# 🚀 Deployment Guide - OpenGov OSCAL Privacy Viewer

**Target Environment**: Production
**Platform**: GitHub Pages / Static Hosting
**Version**: Beta (v0.2.0)

---

## Table of Contents
1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Build Configuration](#build-configuration)
3. [GitHub Pages Deployment](#github-pages-deployment)
4. [Alternative Hosting](#alternative-hosting)
5. [Environment Configuration](#environment-configuration)
6. [Monitoring & Observability](#monitoring--observability)
7. [Rollback Procedures](#rollback-procedures)
8. [Post-Deployment Verification](#post-deployment-verification)

---

## Pre-Deployment Checklist

### Code Quality

- [ ] **All tests passing**
  ```bash
  npm run test
  npm run test:coverage  # Must be >80%
  ```

- [ ] **Linting clean**
  ```bash
  npm run lint
  npm run type-check
  ```

- [ ] **Build succeeds**
  ```bash
  npm run build
  ```

- [ ] **Bundle size acceptable**
  ```bash
  npm run build
  # Check dist/ folder size: Should be <2MB total
  ```

### Documentation

- [ ] **README.md updated** with current features
- [ ] **CHANGELOG.md** has version entry
- [ ] **API documentation** current (if applicable)
- [ ] **User guide** reflects new features

### Security

- [ ] **No hardcoded secrets** in codebase
  ```bash
  git grep -i "password\|secret\|api_key\|token"
  ```

- [ ] **Dependencies updated**
  ```bash
  npm audit
  npm audit fix  # If vulnerabilities found
  ```

- [ ] **HTTPS enforced** for all external resources
- [ ] **Content Security Policy** configured
- [ ] **No console.log statements** in production code

### Performance

- [ ] **Lighthouse score** >90
  ```bash
  npm run lighthouse
  ```

- [ ] **Bundle analysis** shows no unexpected large dependencies
  ```bash
  npm run build -- --mode analyze
  ```

- [ ] **Images optimized** (use WebP, compression)
- [ ] **Fonts subset** for used characters

### Accessibility

- [ ] **WCAG 2.1 AA compliance** verified
  ```bash
  npm run test:a11y
  ```

- [ ] **Screen reader tested** (NVDA, JAWS, VoiceOver)
- [ ] **Keyboard navigation** works for all features
- [ ] **Color contrast** meets standards (4.5:1)

### Legal & Compliance

- [ ] **License file** present and correct
- [ ] **Privacy policy** linked (if collecting any data)
- [ ] **GDPR compliance** verified (EU users)
- [ ] **Third-party licenses** documented

---

## Build Configuration

### Production Build

**Command**:
```bash
npm run build
```

**Output**: `dist/` directory

### Vite Configuration

[vite.config.ts](../../vite.config.ts):

```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig(({ mode }) => ({
  plugins: [react()],

  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },

  build: {
    outDir: 'dist',
    sourcemap: mode === 'development',

    // Optimize bundle
    rollupOptions: {
      output: {
        manualChunks: {
          // Vendor chunks
          'react-vendor': ['react', 'react-dom', 'react-router-dom'],
          'i18n-vendor': ['i18next', 'react-i18next'],

          // Feature chunks
          'catalog-services': ['./src/services/CatalogService'],
          'catalog-components': [
            './src/features/catalogs/components/CatalogTreeNavigation',
            './src/features/catalogs/components/ControlCard',
          ],
        },
      },
    },

    // Compression
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,  // Remove console.log in production
        drop_debugger: true,
      },
    },
  },

  // GitHub Pages base path (if deployed to subpath)
  base: process.env.BASE_URL || '/',

  // Dev server
  server: {
    port: 3000,
    open: true,
  },

  // Preview server
  preview: {
    port: 4173,
  },
}));
```

---

## GitHub Pages Deployment

### Automated Deployment (Recommended)

#### 1. Create GitHub Actions Workflow

[.github/workflows/deploy.yml](../../.github/workflows/deploy.yml):

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  # Build job
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm run test:ci

      - name: Run linter
        run: npm run lint

      - name: Type check
        run: npm run type-check

      - name: Build
        run: npm run build
        env:
          BASE_URL: /opengov-oscal-privacy-viewer/  # Adjust for your repo

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './dist'

  # Deploy job
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

#### 2. Enable GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Source: **GitHub Actions**
3. Branch: **main** (or your default branch)
4. Save

#### 3. Trigger Deployment

```bash
git add .
git commit -m "feat: deploy to GitHub Pages"
git push origin main
```

**Result**: Site available at `https://[username].github.io/opengov-oscal-privacy-viewer/`

---

### Manual Deployment

#### 1. Build Production Assets

```bash
npm run build
```

#### 2. Deploy with gh-pages

```bash
# Install gh-pages
npm install -D gh-pages

# Deploy
npx gh-pages -d dist
```

#### 3. Configure package.json

Add deploy script:

```json
{
  "scripts": {
    "deploy": "npm run build && gh-pages -d dist"
  }
}
```

Then deploy:

```bash
npm run deploy
```

---

## Alternative Hosting

### Netlify

#### Automatic Deployment

1. Connect GitHub repository to Netlify
2. Build settings:
   - **Build command**: `npm run build`
   - **Publish directory**: `dist`
   - **Node version**: 20

3. Environment variables (if needed):
   - `BASE_URL=/`

#### netlify.toml

Create [netlify.toml](../../netlify.toml):

```toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "20"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"
    Permissions-Policy = "geolocation=(), microphone=(), camera=()"

[[headers]]
  for = "/assets/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
```

**Deploy URL**: `https://[site-name].netlify.app`

---

### Vercel

#### Automatic Deployment

1. Import repository to Vercel
2. Framework: **Vite**
3. Build command: `npm run build`
4. Output directory: `dist`

#### vercel.json

Create [vercel.json](../../vercel.json):

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "vite",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ],
  "headers": [
    {
      "source": "/assets/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    }
  ]
}
```

**Deploy URL**: `https://[project-name].vercel.app`

---

### Cloudflare Pages

#### Automatic Deployment

1. Connect GitHub repository
2. Build settings:
   - **Framework preset**: Vite
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`

3. Add custom domain (optional)

**Deploy URL**: `https://[project-name].pages.dev`

---

### Static Hosting (Apache/Nginx)

#### Build Assets

```bash
npm run build
```

#### Apache Configuration

[.htaccess](../../dist/.htaccess):

```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /

  # Redirect HTTP to HTTPS
  RewriteCond %{HTTPS} off
  RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

  # Handle SPA routing
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>

# Security Headers
<IfModule mod_headers.c>
  Header set X-Frame-Options "DENY"
  Header set X-Content-Type-Options "nosniff"
  Header set Referrer-Policy "strict-origin-when-cross-origin"
  Header set Permissions-Policy "geolocation=(), microphone=(), camera=()"
</IfModule>

# Caching
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType text/html "access plus 0 seconds"
  ExpiresByType image/jpg "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/webp "access plus 1 year"
  ExpiresByType text/css "access plus 1 year"
  ExpiresByType application/javascript "access plus 1 year"
  ExpiresByType application/x-font-woff "access plus 1 year"
</IfModule>
```

#### Nginx Configuration

```nginx
server {
    listen 80;
    server_name oscal-viewer.example.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name oscal-viewer.example.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    root /var/www/oscal-viewer/dist;
    index index.html;

    # Security headers
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Permissions-Policy "geolocation=(), microphone=(), camera=()" always;

    # SPA routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # No cache for HTML
    location ~* \.html$ {
        expires -1;
        add_header Cache-Control "no-cache, no-store, must-revalidate";
    }

    # Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
    gzip_vary on;
}
```

---

## Environment Configuration

### Production Environment Variables

Create [.env.production](../../.env.production):

```bash
# Base URL (for subpath deployment)
VITE_BASE_URL=/

# API Endpoint (if backend exists)
# VITE_API_URL=https://api.example.com

# Feature Flags
VITE_ENABLE_ANALYTICS=true
VITE_ENABLE_ERROR_TRACKING=true

# Catalog URLs (default examples)
VITE_DEFAULT_CATALOG_SDM=https://raw.githubusercontent.com/open-gov-group/opengov-privacy-oscal/main/oscal/catalog/sdm_privacy_catalog.json
VITE_DEFAULT_CATALOG_DSGVO=https://raw.githubusercontent.com/open-gov-group/opengov-privacy-oscal/main/oscal/catalog/open_privacy_catalog_risk.json
```

**Important**: Do NOT commit `.env.production` with secrets!

---

## Monitoring & Observability

### Error Tracking (Sentry)

#### 1. Install Sentry

```bash
npm install @sentry/react
```

#### 2. Configure Sentry

[src/utils/sentry.ts](../../src/utils/sentry.ts):

```typescript
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';

export function initSentry() {
  if (import.meta.env.PROD && import.meta.env.VITE_SENTRY_DSN) {
    Sentry.init({
      dsn: import.meta.env.VITE_SENTRY_DSN,
      integrations: [new BrowserTracing()],
      tracesSampleRate: 0.1,
      environment: import.meta.env.MODE,

      // Don't send errors from localhost
      beforeSend(event) {
        if (window.location.hostname === 'localhost') {
          return null;
        }
        return event;
      },
    });
  }
}
```

#### 3. Initialize in main.tsx

```typescript
import { initSentry } from './utils/sentry';

initSentry();

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

---

### Analytics (Optional)

#### Privacy-Friendly Analytics (Plausible)

```html
<!-- In index.html -->
<script defer data-domain="oscal-viewer.example.com" src="https://plausible.io/js/script.js"></script>
```

**Why Plausible?**
- GDPR compliant (no cookies)
- No personal data collected
- Lightweight (<1KB)
- EU-hosted

---

### Performance Monitoring

#### Web Vitals

[src/utils/webVitals.ts](../../src/utils/webVitals.ts):

```typescript
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

export function reportWebVitals() {
  getCLS(console.log);
  getFID(console.log);
  getFCP(console.log);
  getLCP(console.log);
  getTTFB(console.log);
}
```

Use in [main.tsx](../../src/main.tsx):

```typescript
import { reportWebVitals } from './utils/webVitals';

if (import.meta.env.PROD) {
  reportWebVitals();
}
```

---

## Rollback Procedures

### GitHub Pages Rollback

#### Option 1: Revert Commit

```bash
# Find commit to revert
git log --oneline

# Revert to previous version
git revert <commit-hash>
git push origin main
```

#### Option 2: Deploy Previous Build

```bash
# Checkout previous version
git checkout <previous-commit-hash>

# Build and deploy
npm run build
npx gh-pages -d dist

# Return to main
git checkout main
```

---

### Netlify/Vercel Rollback

1. Go to **Deployments** tab
2. Find previous successful deployment
3. Click **"Publish deploy"** or **"Promote to production"**

**Rollback time**: ~30 seconds

---

## Post-Deployment Verification

### Automated Smoke Tests

[scripts/smoke-test.sh](../../scripts/smoke-test.sh):

```bash
#!/bin/bash

SITE_URL=$1

echo "🔍 Running smoke tests for $SITE_URL"

# Test 1: Site is reachable
if curl -f -s -o /dev/null "$SITE_URL"; then
  echo "✅ Site is reachable"
else
  echo "❌ Site is not reachable"
  exit 1
fi

# Test 2: Catalog page loads
if curl -f -s -o /dev/null "$SITE_URL/catalogs"; then
  echo "✅ Catalog page loads"
else
  echo "❌ Catalog page failed"
  exit 1
fi

# Test 3: Assets load (check for main JS)
if curl -f -s -o /dev/null "$SITE_URL/assets/index.*.js"; then
  echo "✅ JavaScript assets load"
else
  echo "❌ JavaScript assets missing"
  exit 1
fi

echo "🎉 All smoke tests passed!"
```

Run after deployment:

```bash
bash scripts/smoke-test.sh https://oscal-viewer.example.com
```

---

### Manual Verification Checklist

- [ ] **Homepage loads** without errors
- [ ] **Navigation works** (all links functional)
- [ ] **Catalog loading** works with test URL
- [ ] **Tree navigation** expands/collapses
- [ ] **Control display** shows all properties
- [ ] **Search function** returns results
- [ ] **Filter function** works correctly
- [ ] **Export function** generates files
- [ ] **Mobile view** responsive (test on device)
- [ ] **Browser compatibility**:
  - [ ] Chrome (latest)
  - [ ] Firefox (latest)
  - [ ] Safari (latest)
  - [ ] Edge (latest)
- [ ] **No console errors** in browser DevTools
- [ ] **HTTPS enabled** (green padlock)
- [ ] **Performance acceptable** (Lighthouse >90)

---

### Health Check Endpoint

Create [public/health.json](../../public/health.json):

```json
{
  "status": "ok",
  "version": "0.2.0",
  "timestamp": "2026-01-27T10:00:00Z"
}
```

Check health:

```bash
curl https://oscal-viewer.example.com/health.json
```

---

## Deployment Checklist Summary

### Pre-Deployment
- [ ] All tests passing
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Security audit complete
- [ ] Performance benchmarks met

### Deployment
- [ ] Production build created
- [ ] Assets uploaded to hosting
- [ ] DNS configured (if custom domain)
- [ ] SSL certificate active
- [ ] CDN configured (if applicable)

### Post-Deployment
- [ ] Smoke tests passed
- [ ] Manual verification complete
- [ ] Monitoring active
- [ ] Error tracking configured
- [ ] Team notified
- [ ] Changelog updated
- [ ] GitHub release created

---

## Troubleshooting

### Common Issues

#### 1. "404 Not Found" on Refresh

**Cause**: SPA routing not configured on server

**Fix**: Add rewrite rules (see Nginx/Apache config above)

---

#### 2. Assets Not Loading (404)

**Cause**: Incorrect `base` path in Vite config

**Fix**: Update `vite.config.ts`:

```typescript
base: '/opengov-oscal-privacy-viewer/',  // For GitHub Pages subpath
```

---

#### 3. CORS Errors Loading Catalogs

**Cause**: Catalog server doesn't allow cross-origin requests

**Fix**:
- Contact catalog host to enable CORS
- Or proxy through backend
- Or use same-origin catalogs

---

#### 4. Large Bundle Size

**Cause**: Unnecessary dependencies included

**Fix**:

```bash
# Analyze bundle
npm run build -- --mode analyze

# Remove unused dependencies
npm uninstall <package>

# Use dynamic imports for large libraries
const module = await import('./large-module');
```

---

## Contact & Support

**Deployment Issues**: DevOps Team
**Application Errors**: Frontend Team
**Infrastructure**: Platform Team

**On-Call**: See team schedule

---

**Last Updated**: 2026-01-27
**Maintained By**: DevOps Team
**Review Cycle**: Every deployment
