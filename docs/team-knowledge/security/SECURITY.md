# Security Policy

## Reporting a Vulnerability

**DO NOT** open a public issue for security vulnerabilities.

Instead, please email: security@open-gov-group.org

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

We will respond within 48 hours.

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Security Best Practices

- All OSCAL processing happens client-side
- No user data sent to external servers
- HTTPS-only for fetching OSCAL files
- Regular dependency updates via Dependabot
- Security scanning via GitHub CodeQL