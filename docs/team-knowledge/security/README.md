# Security Team Knowledge Base

**Team**: Security & Compliance
**Focus**: Threat Modeling, Vulnerability Management, Incident Response, Security Audits
**Last Updated**: 2026-01-28

---

## 📋 Quick Links

- [Threat Modeling Notes](threat-modeling-notes.md) - Attack vectors, mitigations
- [Penetration Test Results](penetration-test-results.md) - Pen test findings
- [Vulnerability Tracking](vulnerability-tracking.md) - CVE management
- [Incident Response Log](incident-response-log.md) - Security incidents

---

## 🎯 Security Mission

**Objective**: Ensure the OSCAL Privacy Viewer is secure by design, protecting against common web vulnerabilities while maintaining transparency and openness as an open-source project.

**Target**: Zero critical/high vulnerabilities in production

---

## 🏗️ Security Posture

**Threat Model**: Static web application (no backend, no user data storage)
**Risk Level**: Low-Medium (information disclosure only)
**Compliance**: GDPR Article 32 (Security of processing)

---

## 👥 Team Members

| Name | Role | Focus Area |
|------|------|------------|
| [Name] | Security Lead | Threat modeling, audits |
| [Name] | Security Engineer | Vulnerability management |

---

## 📚 Essential Reading

**For New Team Members**:
1. [SECURITY.md](../../guides/SECURITY.md) - Security practices & threat model (60 min)
2. [Threat Modeling Notes](threat-modeling-notes.md) - Attack surface analysis (30 min)
3. [DEPLOYMENT.md](../../guides/DEPLOYMENT.md) - Security headers, CSP (20 min)

---

## 🛡️ Threat Model

See [threat-modeling-notes.md](threat-modeling-notes.md) for detailed analysis.

### Attack Surface

**Assets**:
- OSCAL catalog JSON files (public data)
- Application code (open-source)
- User browser session (no sensitive data)

**Threat Actors**:
- **Malicious User**: XSS injection, CSRF
- **Supply Chain Attack**: Compromised npm dependency
- **Network Attacker**: MITM, data tampering (mitigated by HTTPS)

### STRIDE Analysis

| Threat | Mitigation | Status |
|--------|------------|--------|
| **Spoofing** | N/A (no authentication) | - |
| **Tampering** | HTTPS only, CSP, SRI | ✅ |
| **Repudiation** | N/A (no user actions logged) | - |
| **Information Disclosure** | Public data only, no secrets | ✅ |
| **Denial of Service** | CDN (Cloudflare), rate limiting | 🔄 |
| **Elevation of Privilege** | N/A (no privilege levels) | - |

---

## 🔒 Security Controls

### 1. Content Security Policy (CSP)

**Current Policy**:
```http
Content-Security-Policy:
  default-src 'self';
  script-src 'self';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data: https:;
  font-src 'self';
  connect-src 'self' https://raw.githubusercontent.com;
  frame-ancestors 'none';
  base-uri 'self';
  form-action 'self';
```

**Rationale**:
- `default-src 'self'`: Only load resources from same origin
- `script-src 'self'`: No inline scripts (XSS mitigation)
- `connect-src ... github.com`: Allow OSCAL catalog fetching
- `frame-ancestors 'none'`: Prevent clickjacking

**Review Schedule**: Monthly

---

### 2. Security Headers

**Required Headers** (see [DEPLOYMENT.md](../../guides/DEPLOYMENT.md)):

```http
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=(), camera=()
```

**Verification**:
- Automated: https://securityheaders.com
- Manual: Browser DevTools Network tab

---

### 3. Dependency Management

**Tools**:
- `npm audit` (weekly)
- Snyk (continuous monitoring)
- Dependabot (GitHub automated PRs)

**Process**:
1. **Weekly Audit**: Run `npm audit` every Monday
2. **Triage**: Review vulnerabilities
   - Critical/High: Patch within 7 days
   - Medium: Patch within 30 days
   - Low: Patch next release
3. **Update**: `npm audit fix` or manual update
4. **Test**: Run full test suite after update
5. **Deploy**: If critical, hotfix deploy

**Current Status**: 0 critical, 0 high, 2 low

See [vulnerability-tracking.md](vulnerability-tracking.md) for active issues.

---

### 4. Input Validation

**Catalog URL Validation** (CatalogService):
```typescript
function validateCatalogUrl(url: string): boolean {
  // Must be HTTPS
  if (!url.startsWith('https://')) return false;

  // Whitelist domains (GitHub raw, known OSCAL repos)
  const allowedDomains = [
    'raw.githubusercontent.com',
    'github.com'
  ];

  try {
    const urlObj = new URL(url);
    return allowedDomains.some(domain =>
      urlObj.hostname.endsWith(domain)
    );
  } catch {
    return false;
  }
}
```

**Rationale**: Prevent SSRF, data exfiltration

---

### 5. XSS Prevention

**Primary Defense**: React auto-escaping

**Additional Layers**:
- No `dangerouslySetInnerHTML` usage (enforced by linter)
- DOMPurify for user-generated content (if added)
- CSP `script-src 'self'` (no inline scripts)

**Testing**:
- Manual: Test common XSS payloads
- Automated: OWASP ZAP scan (monthly)

---

## 🧪 Security Testing

### Automated Tests

**Weekly**:
```bash
# Dependency audit
npm audit

# Linting (security rules)
npm run lint
```

**Monthly**:
```bash
# OWASP ZAP scan
# (Requires OWASP ZAP installed)
zap-cli quick-scan --self-contained https://[staging-url]

# Security headers check
curl -I https://[staging-url] | grep -E "Content-Security-Policy|X-Frame-Options|Strict-Transport-Security"
```

**Continuous** (GitHub Actions):
- Snyk vulnerability scan on every PR
- npm audit in CI pipeline

---

### Manual Penetration Testing

**Frequency**: Quarterly

**Scope**:
- XSS testing (reflected, stored, DOM-based)
- CSRF testing
- Clickjacking testing
- Security header validation
- Dependency vulnerability assessment

**Checklist**:
- [ ] XSS: Test all input fields (catalog URL)
- [ ] CSP: Verify inline scripts blocked
- [ ] Headers: Check all security headers present
- [ ] HTTPS: Verify HTTPS enforced (no HTTP fallback)
- [ ] Dependencies: Review npm audit output
- [ ] Source maps: Verify not exposed in production

See [penetration-test-results.md](penetration-test-results.md) for findings.

---

## 🚨 Incident Response

See [incident-response-log.md](incident-response-log.md) for incident history.

### Incident Classification

**Severity Levels**:
- **Critical**: Active exploitation, data breach → Response: Immediate (1 hour)
- **High**: Vulnerability disclosed, no active exploitation → Response: 24 hours
- **Medium**: Low-impact vulnerability → Response: 7 days
- **Low**: Minor security improvement → Response: 30 days

### Incident Response Process

**Phase 1: Detection** (0-15 min)
1. Incident reported (email, Slack, GitHub)
2. Verify incident (reproduce)
3. Classify severity
4. Notify security team (#security-incidents)

**Phase 2: Containment** (15-60 min)
1. If active exploitation: Take site offline (if critical)
2. Assess impact: What data/systems affected?
3. Notify stakeholders (if critical/high)

**Phase 3: Investigation** (1-4 hours)
1. Root cause analysis
2. Identify all affected components
3. Document timeline of events

**Phase 4: Remediation** (4-24 hours)
1. Develop fix
2. Test fix thoroughly
3. Deploy fix (hotfix process)
4. Verify fix effective

**Phase 5: Post-Incident** (1-7 days)
1. Incident report (template in incident-response-log.md)
2. Post-mortem meeting
3. Update threat model
4. Improve detection/prevention
5. Communicate to users (if necessary)

---

## ✅ Security Audit Checklist

**Pre-Deployment Security Audit**:

**Code Security**:
- [ ] No hardcoded secrets (API keys, tokens)
- [ ] No `dangerouslySetInnerHTML` usage
- [ ] Input validation on all external data
- [ ] No eval() or Function() usage
- [ ] Dependencies up to date (npm audit clean)

**Configuration**:
- [ ] CSP configured correctly
- [ ] Security headers configured
- [ ] HTTPS enforced (HSTS)
- [ ] Source maps disabled in production
- [ ] Error messages don't leak sensitive info

**Infrastructure**:
- [ ] CDN configured (Cloudflare)
- [ ] Rate limiting enabled
- [ ] Monitoring/alerting configured
- [ ] Backup/rollback plan ready

**Compliance**:
- [ ] GDPR Article 32 requirements met
- [ ] Privacy policy published (if needed)
- [ ] Security contact published (security.txt)

---

## 📊 Security Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Critical Vulnerabilities | 0 | 0 | ✅ |
| High Vulnerabilities | 0 | 0 | ✅ |
| Medium Vulnerabilities | <5 | 0 | ✅ |
| Dependency Update Lag | <30 days | 12 days | ✅ |
| Security Header Score | A+ | - | 🔄 Pre-deployment |
| Incident Response Time (Critical) | <1 hour | - | N/A (no incidents) |

---

## 📞 Security Contact

**Report Security Issues**:
- Email: security@[organization].eu
- GitHub: Private security advisory (https://github.com/[repo]/security/advisories)
- PGP Key: [Link to public key]

**Response Time**:
- Critical: 1 hour
- High: 24 hours
- Medium: 7 days

**Responsible Disclosure**: We follow a 90-day disclosure policy.

---

## 🔗 Related Documentation

- [Security Guide](../../guides/SECURITY.md)
- [Deployment Guide](../../guides/DEPLOYMENT.md)
- [Incident Response Playbook](incident-response-log.md)

---

**Last Updated**: 2026-01-28
**Maintained By**: Security Lead
**Questions?** Ask in #security Slack
