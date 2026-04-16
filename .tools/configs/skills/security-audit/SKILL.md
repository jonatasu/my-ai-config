---
name: security-audit
description: Security vulnerability checklist and audit procedures for code review
---

## Security Audit Process

1. Review code for common vulnerabilities
2. Check dependencies for known CVEs
3. Verify authentication and authorization
4. Test input validation
5. Review data handling and storage
6. Check configuration and secrets management

## Vulnerability Checklist

### Injection Attacks

#### SQL Injection
```typescript
// VULNERABLE
const query = `SELECT * FROM users WHERE id = ${userId}`;

// SAFE - Use parameterized queries
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

#### XSS (Cross-Site Scripting)
```typescript
// VULNERABLE
element.innerHTML = userInput;

// SAFE - Use textContent or sanitize
element.textContent = userInput;
// Or use DOMPurify for HTML
element.innerHTML = DOMPurify.sanitize(userInput);
```

#### Command Injection
```typescript
// VULNERABLE
exec(`ls ${userInput}`);

// SAFE - Use array arguments, validate input
execFile('ls', [sanitizedPath]);
```

### Authentication & Authorization

- [ ] Passwords hashed with bcrypt/argon2 (not MD5/SHA1)
- [ ] Session tokens are cryptographically random
- [ ] Sessions expire and can be invalidated
- [ ] Rate limiting on login attempts
- [ ] Authorization checked on every protected endpoint
- [ ] No authorization logic in frontend only

### Data Exposure

- [ ] Sensitive data not logged
- [ ] API responses don't leak internal data
- [ ] Error messages don't expose internals
- [ ] Debug mode disabled in production
- [ ] No sensitive data in URLs (use POST body)
- [ ] HTTPS enforced

### Secrets Management

- [ ] No hardcoded secrets in code
- [ ] Secrets not in version control
- [ ] Environment variables or secret manager used
- [ ] API keys have minimal required permissions
- [ ] Secrets rotated periodically

### CSRF (Cross-Site Request Forgery)

- [ ] CSRF tokens on state-changing requests
- [ ] SameSite cookie attribute set
- [ ] Origin/Referer header validated

### Dependencies

```bash
# Check for vulnerabilities
npm audit
# or
yarn audit
# or
snyk test
```

- [ ] No known vulnerabilities in dependencies
- [ ] Dependencies are up to date
- [ ] Lock files committed to version control

## Severity Classification

| Severity | Description | Examples |
|----------|-------------|----------|
| Critical | Immediate exploitation possible | SQL injection, RCE, auth bypass |
| High | Significant impact, exploitable | Stored XSS, IDOR, privilege escalation |
| Medium | Limited impact or harder to exploit | Reflected XSS, CSRF, info disclosure |
| Low | Minimal impact | Missing headers, verbose errors |

## Output Format

```
### [CRITICAL/HIGH/MEDIUM/LOW] Vulnerability Title

**Type**: SQL Injection | XSS | CSRF | Auth Bypass | etc.
**File**: path/to/file.ts
**Line**: 42
**Description**: Clear explanation of the vulnerability
**Impact**: What an attacker could do
**Proof of Concept**: How to exploit (if safe to share)
**Remediation**: How to fix with code example
```
