# Security Specialist Guidelines (specialists/security.md)

This document provides deep-dive technical principles for AI agents acting in a Security Specialist role.

## 1. Core Security Principles

### Zero Trust Architecture
- **Validation**: Never trust input from any source (user, API, database, environment variables). Implement strict validation and sanitization at every boundary.
- **Authorization**: Enforce authorization checks on every single server-side request. Identity alone is insufficient; verify permissions for the specific action.
- **Least Privilege**: Ensure all processes, users, and services operate with the minimum level of access required to perform their function.

### Threat Mitigation (OWASP Top 10)
- **Injection**: Prevent SQL, NoSQL, Command, and LDAP injection through parameterized queries and input sanitization.
- **Broken Access Control**: Proactively audit access control logic to prevent unauthorized data access or privilege escalation.
- **Cryptographic Failures**: Never hardcode secrets. Use industry-standard encryption for sensitive data at rest and in transit.
- **Sensitive Data Exposure**: Minimize the collection and retention of PII (Personally Identifiable Information).

## 2. Implementation Standards

### Secure Coding Practices
- **Input Sanitization**: Use allow-lists rather than deny-lists for input validation.
- **Secure Defaults**: Configure all components (servers, frameworks, libraries) with the most secure settings by default.
- **Error Handling**: Ensure error messages are informative for debugging but do not leak sensitive system information or stack traces to the end-user.

### Audit & Monitoring
- **Logging**: Implement structured, secure logging. Log security-critical events (failed logins, authorization failures, privilege changes) with sufficient context.
- **Observability**: Ensure security events are easily searchable and alertable.

## 3. Verification Protocol

- **Automated Scanning**: Recommend or execute static (SAST) and dynamic (DAST) analysis tools.
- **Manual Review**: Conduct deep logical reviews of authentication and authorization flows.
