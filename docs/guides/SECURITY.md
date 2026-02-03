# 🔒 Security Guide - OpenGov OSCAL Privacy Viewer

**Classification**: Internal
**Last Security Audit**: 2026-01-27
**Next Review**: 2026-04-27

---

## Security Overview

This guide covers security best practices, threat model, and security controls for the OSCAL Privacy Viewer application.

---

## Threat Model

### Assets

1. **User Data**: Minimal - no PII stored
2. **Catalog Data**: Public OSCAL catalogs (considered public)
3. **Application Code**: Open source (public repository)
4. **Infrastructure**: Static hosting (no backend)

### Threats

| Threat | Likelihood | Impact | Mitigation |
|--------|-----------|--------|------------|
| XSS (Cross-Site Scripting) | Medium | High | React auto-escaping, CSP headers |
| CSRF (Cross-Site Request Forgery) | Low | Low | No state-changing operations |
| Malicious Catalog Injection | Medium | Medium | URL validation, HTTPS only |
| Supply Chain Attack | Medium | High | Dependency scanning, lock files |
| DDoS | Low | Low | CDN rate limiting |
| Data Exfiltration | Low | Low | No sensitive data |

---

## Security Controls

### 1. Content Security Policy (CSP)

**Implementation**: HTTP headers via hosting platform

**Policy**:
```
Content-Security-Policy:
  default-src 'self';
  script-src 'self';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data: https:;
  font-src 'self' data:;
  connect-src 'self' https://*.githubusercontent.com;
  frame-ancestors 'none';
  base-uri 'self';
  form-action 'self';
```

**What it prevents**:
- Inline script execution (XSS)
- Loading resources from untrusted domains
- Embedding in iframes (clickjacking)

---

### 2. HTTPS Enforcement

**Required**: All deployments must use HTTPS

**Configuration**:

**Netlify** (automatic):
```toml
# netlify.toml
[[redirects]]
  from = "http://*"
  to = "https://:splat"
  status = 301
  force = true
```

**Nginx**:
```nginx
server {
    listen 80;
    return 301 https://$server_name$request_uri;
}
```

---

### 3. Security Headers

**Implementation**: Set via hosting platform

**Required Headers**:

```
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=(), camera=()
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

**Testing**:
```bash
curl -I https://oscal-viewer.example.com | grep -E "X-|Content-Security"
```

---

### 4. Dependency Security

#### Automated Scanning

**GitHub Dependabot** (enabled):
```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
```

**npm audit**:
```bash
# Run before every deployment
npm audit

# Fix automatically (review changes!)
npm audit fix
```

**Snyk** (optional, recommended):
```bash
npx snyk test
npx snyk monitor
```

#### Dependency Policies

- **No dependencies with known CRITICAL vulnerabilities**
- **HIGH vulnerabilities** must be fixed within 7 days
- **MEDIUM/LOW** reviewed quarterly
- **Direct dependencies only** - minimize transitive deps

---

### 5. Input Validation

#### Catalog URL Validation

[src/services/CatalogService.ts](../../src/services/CatalogService.ts):

```typescript
async fetchCatalog(url: string): Promise<OSCALCatalog> {
  // 1. Validate URL format
  if (!this.isValidUrl(url)) {
    throw new CatalogError(
      CatalogErrorType.INVALID_FORMAT,
      'Invalid URL format'
    );
  }

  // 2. Enforce HTTPS
  if (!url.startsWith('https://')) {
    throw new CatalogError(
      CatalogErrorType.FETCH_FAILED,
      'Only HTTPS URLs are allowed'
    );
  }

  // 3. Fetch with timeout
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 30000);

  try {
    const response = await fetch(url, {
      signal: controller.signal,
      // Prevent credential leakage
      credentials: 'omit',
      // Specify accepted content type
      headers: {
        'Accept': 'application/json',
      },
    });

    clearTimeout(timeoutId);

    // 4. Validate response
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }

    // 5. Validate content type
    const contentType = response.headers.get('content-type');
    if (!contentType?.includes('application/json')) {
      throw new Error('Invalid content type');
    }

    // 6. Parse with size limit (prevent DoS)
    const text = await response.text();
    if (text.length > 10 * 1024 * 1024) { // 10MB limit
      throw new Error('Catalog too large');
    }

    const data = JSON.parse(text);

    // 7. Validate OSCAL structure
    const catalog = this.parseCatalog(data);
    this.validateCatalog(catalog);

    return catalog;
  } catch (error) {
    // Handle errors securely (no stack traces to user)
    console.error('Catalog fetch failed:', error);
    throw new CatalogError(
      CatalogErrorType.FETCH_FAILED,
      'Failed to load catalog'
    );
  }
}

private isValidUrl(url: string): boolean {
  try {
    const parsed = new URL(url);
    return parsed.protocol === 'https:';
  } catch {
    return false;
  }
}
```

---

### 6. XSS Prevention

#### React Auto-Escaping

React automatically escapes JSX content:

```typescript
// ✅ Safe - React escapes automatically
<div>{control.title}</div>

// ❌ NEVER use dangerouslySetInnerHTML without sanitization
<div dangerouslySetInnerHTML={{ __html: userInput }} />
```

#### Sanitizing HTML (if needed)

If you must render HTML from catalogs:

```bash
npm install dompurify
npm install @types/dompurify -D
```

```typescript
import DOMPurify from 'dompurify';

function SafeHTML({ html }: { html: string }) {
  const clean = DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['p', 'strong', 'em', 'ul', 'li'],
    ALLOWED_ATTR: [],
  });

  return <div dangerouslySetInnerHTML={{ __html: clean }} />;
}
```

---

### 7. Secure Local Storage

**Current Usage**: Cache catalog metadata, language preference

**Security Considerations**:
- ✅ No sensitive data stored
- ✅ No authentication tokens
- ✅ Data is public (OSCAL catalogs)
- ✅ Clear on logout (if auth added)

**Best Practices**:
```typescript
// ✅ Store non-sensitive data only
localStorage.setItem('language', 'de');
localStorage.setItem('recent-catalogs', JSON.stringify(urls));

// ❌ NEVER store sensitive data
// localStorage.setItem('token', '...'); // NO!
// localStorage.setItem('password', '...'); // NO!
```

---

## Secure Development Practices

### Code Review Checklist

Security-focused review items:

- [ ] **No hardcoded secrets** (API keys, passwords)
- [ ] **Input validation** on all user inputs
- [ ] **Error messages** don't leak sensitive info
- [ ] **No `eval()` or `Function()` constructor** usage
- [ ] **Dependencies updated** and scanned
- [ ] **HTTPS enforced** for external requests
- [ ] **CSP compliant** (no inline scripts)
- [ ] **Accessibility** maintained (prevents UI redressing)

---

### Secret Management

#### Environment Variables

**Never commit**:
```bash
# ❌ Bad
VITE_API_KEY=abc123

# ✅ Good - use .env.local (gitignored)
VITE_API_KEY=<secret-value>
```

**In CI/CD**:
- Use GitHub Secrets
- Rotate regularly (every 90 days)
- Least privilege access

---

### Git Secrets

**Pre-commit hook** to prevent secret commits:

[.husky/pre-commit](../../.husky/pre-commit):

```bash
#!/bin/sh

# Check for potential secrets
if git grep -E "(password|secret|api_key|token|private_key)" -- ':!*.md' ':!SECURITY.md'; then
  echo "❌ Potential secret detected. Commit rejected."
  echo "If this is a false positive, add to .gitignore or use generic variable names."
  exit 1
fi

echo "✅ No secrets detected"
```

Install:
```bash
npm install -D husky
npx husky install
npx husky add .husky/pre-commit "bash .husky/pre-commit"
```

---

## Incident Response

### Security Incident Process

1. **Detect**: Monitoring, user reports, automated scans
2. **Assess**: Severity (Critical/High/Medium/Low)
3. **Contain**: Take affected systems offline if needed
4. **Remediate**: Fix vulnerability, deploy patch
5. **Communicate**: Notify users if data breach
6. **Post-Mortem**: Document lessons learned

---

### Severity Levels

| Level | Criteria | Response Time | Example |
|-------|----------|---------------|---------|
| **Critical** | Active exploit, data breach | Immediate | XSS allowing account takeover |
| **High** | Exploitable vulnerability | 24 hours | Dependency with known CVE |
| **Medium** | Potential vulnerability | 7 days | Missing security header |
| **Low** | Best practice deviation | 30 days | Outdated dependency (no CVE) |

---

### Reporting Security Issues

**Email**: security@example.com
**PGP Key**: [Public key link]

**What to include**:
- Description of vulnerability
- Steps to reproduce
- Impact assessment
- Suggested fix (if known)

**DO NOT** open public GitHub issues for security vulnerabilities.

---

## Compliance

### GDPR

**Data Processing**:
- ✅ No personal data collected (privacy by design)
- ✅ No cookies (except essential localStorage)
- ✅ No tracking scripts (opt for privacy-friendly analytics)
- ✅ Right to access: N/A (no data stored)
- ✅ Right to erasure: N/A (no data stored)

**Privacy Policy**: Required if any analytics enabled

---

### Accessibility as Security

**WCAG 2.1 AA** compliance prevents:
- UI redressing attacks (clickjacking)
- Social engineering (clear, unambiguous UI)
- Confusion attacks (screen reader support)

**Testing**:
```bash
npm run test:a11y
```

---

## Security Testing

### Automated Testing

#### 1. OWASP ZAP

```bash
# Pull Docker image
docker pull owasp/zap2docker-stable

# Run baseline scan
docker run -t owasp/zap2docker-stable zap-baseline.py \
  -t https://oscal-viewer.example.com
```

#### 2. Lighthouse Security Audit

```bash
npm run lighthouse -- --only-categories=best-practices
```

#### 3. npm audit

```bash
npm audit --production
```

---

### Manual Testing

#### Checklist

- [ ] **XSS**: Try injecting `<script>alert('XSS')</script>` in all inputs
- [ ] **HTTPS**: Verify HTTP redirects to HTTPS
- [ ] **Headers**: Check security headers present
- [ ] **CSP**: Verify CSP header blocks inline scripts
- [ ] **Error Messages**: Ensure no stack traces leak
- [ ] **Source Maps**: Disabled in production (check Network tab)

---

## Security Monitoring

### Error Tracking

**Sentry** (recommended):
- Automatically captures errors
- Strips sensitive data before sending
- Alerts on new error types

**Configuration**:
```typescript
Sentry.init({
  dsn: '...',
  beforeSend(event) {
    // Strip sensitive data
    if (event.request?.headers) {
      delete event.request.headers['Authorization'];
    }
    return event;
  },
});
```

---

### Uptime Monitoring

**Tools**:
- UptimeRobot (free tier: 50 monitors)
- Pingdom
- StatusCake

**What to monitor**:
- Site availability (https://oscal-viewer.example.com)
- Response time (<2s target)
- SSL certificate expiry (alert 30 days before)

---

## Penetration Testing

### Schedule

- **Initial**: Before first production deployment
- **Regular**: Annually or after major changes
- **Ad-hoc**: After security incidents

### Scope

**In Scope**:
- Web application (client-side)
- Deployed infrastructure (CDN, hosting)
- Dependency chain

**Out of Scope**:
- Physical security
- Social engineering
- Catalog source repositories (not controlled by us)

---

## Security Checklist (Deployment)

### Pre-Deployment

- [ ] **Dependency audit** passed (no HIGH/CRITICAL)
- [ ] **Code review** completed (security focus)
- [ ] **Secrets scan** passed (no leaked secrets)
- [ ] **HTTPS** enforced
- [ ] **Security headers** configured
- [ ] **CSP** header set
- [ ] **Error tracking** enabled
- [ ] **Monitoring** active

### Post-Deployment

- [ ] **ZAP scan** passed (no HIGH findings)
- [ ] **Lighthouse audit** >90 (Best Practices)
- [ ] **Manual XSS test** passed
- [ ] **Security headers** verified (securityheaders.com)
- [ ] **SSL test** passed (ssllabs.com)

---

## Resources

### Tools

- **Security Headers Check**: https://securityheaders.com
- **SSL Test**: https://www.ssllabs.com/ssltest/
- **CSP Evaluator**: https://csp-evaluator.withgoogle.com/
- **npm audit**: Built-in to npm
- **Snyk**: https://snyk.io
- **OWASP ZAP**: https://www.zaproxy.org/

### Standards

- **OWASP Top 10**: https://owasp.org/www-project-top-ten/
- **CWE Top 25**: https://cwe.mitre.org/top25/
- **NIST Cybersecurity Framework**: https://www.nist.gov/cyberframework

---

**Last Updated**: 2026-01-27
**Security Contact**: security@example.com
**Next Review**: 2026-04-27
