# MASTER PLAN APPENDIX: SECURITY RISK AND SECRET HYGIENE HARDENING

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-13

---

## 1) Goal

Reduce immediate security exposure in the current Forrest Travels infrastructure by:

- removing hardcoded secrets from tracked operational files
- centralizing secret handling
- reducing secret spread across backups, logs, and helper artifacts
- tightening file permissions on sensitive data
- establishing secret rotation and hygiene procedures
- lowering blast radius between services

This appendix is a planning document only.

---

## 2) Scope

This hardening plan covers:

- `/opt/infra/hermes`
- `/opt/infra/n8n`
- `/opt/infra/brain`
- `/opt/infra/traefik`
- `/opt/infra/backups`
- `/opt/infra/wordpress`
- related operational backups and helper files

This appendix does not yet implement:

- managed external secret stores
- cloud KMS integration
- SSO
- Vault deployment
- full host hardening baseline

---

## 3) Security Findings Summary

## Critical Findings

### C1. Hardcoded secrets in compose files
Sensitive values are currently embedded directly in compose files and helper variants.

Affected classes observed:
- API keys
- bot tokens
- app passwords
- DB passwords
- personal access tokens
- encryption keys

Impact:
- anyone with read access to these files can impersonate services
- backups of these files preserve the same secrets
- accidental copy/paste, logs, screenshots, and repo sync become high risk

### C2. Secrets preserved in backup copies and historical files
Historical `.bak` files and legacy config variants still contain sensitive values.

Impact:
- even if the active compose is cleaned later, old files still expose credentials
- remediation is incomplete unless historical copies are sanitized or removed

### C3. Secret-bearing operational artifacts outside compose
Some operational/support files contain credential material or authenticated URLs.

Impact:
- secret spread exceeds primary config files
- rotation becomes harder
- exposure surface is much larger than expected

---

## High Findings

### H1. No centralized secret segregation
There is currently no visible `.env`-based or equivalent secret separation pattern across the stack.

Impact:
- secrets are mixed with application topology
- high chance of duplication
- difficult safe rotation
- difficult review and audit

### H2. World-readable sensitive files and data candidates
Multiple files under `/opt/infra` are readable broadly at the filesystem level, including:

- compose files
- helper scripts
- logs
- databases
- backups
- WordPress config
- n8n data/logs
- Open WebUI database
- monitoring database

Impact:
- local privilege separation is weak
- any compromised user/process on the host may read sensitive operational material

### H3. Backup artifacts likely contain secrets and live data
Backup archives and SQL dumps are stored locally and readable with broad permissions.

Impact:
- backup directory becomes a high-value target
- secret rotation without backup handling still leaves historical exposure
- DB dumps likely contain customer/business data plus configuration values

### H4. WordPress sensitive config readability
WordPress configuration files are present in readable host paths.

Impact:
- WordPress DB credentials and salts may be exposed to local users/processes
- compromise of one low-trust path may expand into site/database compromise

---

## Medium Findings

### M1. Traefik dashboard/API uses insecure mode
`Traefik` currently enables `--api.insecure=true`, but binds to localhost only.

Impact:
- lower than public exposure
- still avoidable
- increases risk if localhost access is later bridged/tunneled or host access expands

### M2. Cross-service volume coupling
`n8n` mounts `/opt/infra/hermes/data:/data`.

Impact:
- broader lateral exposure across services
- increases chance of unintended data access or corruption
- complicates least-privilege boundaries

### M3. Log and audit retention may contain sensitive traces
Operational logs and audit streams exist across Hermes and backups.

Impact:
- secrets or sensitive metadata may leak into logs over time
- retention without classification increases blast radius

### M4. Historical backup strategy lacks sensitivity classification
Current backup structure appears operationally useful but not yet segmented by sensitivity class.

Impact:
- restores are easy
- controlled exposure is not

---

## 4) Risk Prioritization

## Priority 0: Immediate containment
These must be addressed first:

- rotate exposed credentials
- remove hardcoded secrets from active compose/config
- remove secrets from backup/legacy variants
- restrict file permissions on sensitive paths
- classify and lock down backup artifacts

## Priority 1: Structural hygiene
These should follow immediately after containment:

- adopt env-file based secret handling
- reduce volume sharing between services
- separate config from secrets
- add permission normalization
- define operational secret rotation procedure

## Priority 2: Ongoing hardening
After containment and hygiene:

- improve monitoring around secret misuse
- reduce local exposure of admin surfaces
- tighten retention of logs/backups
- review service-to-service auth boundaries

---

## 5) Target State

The desired state after hardening:

- no live secret hardcoded in compose files
- no live secret in `.bak` or helper artifacts
- secrets stored in restricted env files or equivalent
- sensitive files readable only by intended owner/group
- backups classified and permission-restricted
- secret rotation procedure documented
- services use least privilege
- local-only admin surfaces are explicitly justified or replaced
- operational logs avoid storing credential material

---

## 6) Implementation Strategy

## Phase 1: Secret Inventory and Classification

### Goal
Create an authoritative inventory of all secrets and classify them by system and blast radius.

### Secret classes to inventory
- Hermes provider credentials
- GitHub tokens
- Telegram bot token
- n8n API key
- n8n encryption key
- database credentials
- WordPress application passwords
- Open WebUI/OpenRouter credentials
- any session or webhook signing secrets
- future WhatsApp gateway credentials

### Required output
A classified inventory table with:
- secret name
- owning service
- where used
- where currently stored
- rotation priority
- rotation dependency
- replacement target location

### Checklist
- [ ] Inventory all active secrets by service
- [ ] Inventory all historical secrets found in `.bak` files
- [ ] Inventory all secret-bearing logs/artifacts
- [ ] Mark each secret as active, obsolete, or unknown
- [ ] Assign blast radius and rotation priority

---

## Phase 2: Emergency Rotation Plan

### Goal
Rotate all secrets that are currently exposed in files or artifacts.

### Rotation priority order
1. GitHub tokens
2. bot tokens
3. API keys for provider access
4. WordPress application passwords
5. n8n API key
6. database passwords
7. encryption/signing keys where feasible
8. any authenticated repository URLs
9. any legacy provider keys still present in backup variants

### Important note
Rotation must be sequenced to avoid service downtime.

### Checklist
- [ ] Rotate GitHub-related credentials
- [ ] Rotate Telegram bot credential
- [ ] Rotate model/provider credentials
- [ ] Rotate WordPress app password
- [ ] Rotate n8n API key
- [ ] Rotate database credentials where exposed
- [ ] Review whether n8n encryption key rotation is feasible without migration risk
- [ ] Invalidate obsolete backup-era credentials
- [ ] Confirm all consuming services are updated after each rotation

---

## Phase 3: Secret Storage Refactor

### Goal
Move secrets out of compose files and into restricted env files or equivalent.

### Target pattern
Per stack:
- `docker-compose.yml` contains topology only
- `.env` or stack-specific env file contains secrets
- file permissions restricted to intended admin/group
- secrets not duplicated unless required

### Suggested per-stack pattern
- `/opt/infra/hermes/.env`
- `/opt/infra/n8n/.env`
- `/opt/infra/brain/.env`
- `/opt/infra/wordpress/.env` if applicable
- future `/opt/infra/whatsapp/.env`

### Checklist
- [ ] Define env-file structure per service
- [ ] Remove secrets from active compose files
- [ ] Move secrets to env files
- [ ] Ensure env files are excluded from any future repo sync
- [ ] Ensure env files have strict file permissions
- [ ] Verify service startup with env-based injection

---

## Phase 4: Historical Artifact Cleanup

### Goal
Prevent old files from preserving credential exposure.

### Artifact classes to address
- `.bak` files
- temporary compose variants
- helper scripts containing old credentials
- operational repository clones with embedded auth URLs
- logs with sensitive traces
- generated files and exported configs

### Checklist
- [ ] Enumerate all `.bak` files containing secrets
- [ ] Enumerate all helper scripts containing secrets
- [ ] Enumerate secret-bearing logs
- [ ] Remove, sanitize, or archive securely according to retention policy
- [ ] Sanitize repository-local authenticated remotes if present
- [ ] Re-scan after cleanup to verify no old secret copies remain

---

## Phase 5: Permissions Hardening

### Goal
Reduce local host read exposure for sensitive files and data.

### Priority sensitive paths
- compose/env files containing secrets
- `/opt/infra/backups`
- `/opt/infra/brain/data`
- `/opt/infra/wordpress/data/wp-config.php`
- `/opt/infra/n8n/data`
- Hermes ops logs and audit files
- any future WhatsApp gateway session volume

### Target permission model
- only service owner and required admin group can read/write
- no world-readable sensitive files
- backup directory restricted
- DB files restricted
- logs reviewed individually by sensitivity

### Checklist
- [ ] Classify sensitive paths
- [ ] Remove world-readable permissions from sensitive files
- [ ] Restrict backup directory permissions
- [ ] Restrict DB file permissions
- [ ] Restrict application config permissions
- [ ] Review ownership model per service
- [ ] Validate services still run after permission tightening

---

## Phase 6: Backup Hygiene

### Goal
Ensure backups do not remain the largest standing exposure.

### Backup issues to address
- backup archives likely contain secrets
- SQL dumps likely contain sensitive business and auth data
- cert archives are high sensitivity
- local retention without permission controls increases risk

### Required controls
- permission restriction
- retention policy
- sensitivity labeling
- optional encryption at rest
- restore testing without broad exposure

### Checklist
- [ ] Classify backup artifact sensitivity
- [ ] Restrict read permissions on backup directory
- [ ] Define retention window
- [ ] Define deletion policy for superseded backups
- [ ] Evaluate backup encryption at rest
- [ ] Separate certificate backups from general backups if needed
- [ ] Document restore process with least privilege

---

## Phase 7: Service Boundary Hardening

### Goal
Reduce unnecessary trust and lateral movement between containers/services.

### Items to review
- shared volumes between `n8n` and `Hermes`
- service credentials reused across boundaries
- admin/API endpoints reachable more broadly than needed
- use of root containers where avoidable

### Checklist
- [ ] Review every cross-service volume mount
- [ ] Remove unnecessary shared mounts
- [ ] Reduce privilege where mounts are still needed
- [ ] Review whether containers need `user: root`
- [ ] Review service-to-service credential scope
- [ ] Limit internal endpoint reachability where possible

---

## Phase 8: Traefik and Control Surface Review

### Goal
Reduce exposure of control and admin planes.

### Observed concern
- Traefik dashboard/API uses insecure mode, but is localhost-bound

### Desired state
- dashboard exposure explicitly justified
- if needed, use authenticated or safer access path
- avoid relying on insecure mode long-term

### Checklist
- [ ] Confirm whether Traefik dashboard is operationally required
- [ ] If required, define safer access model
- [ ] If not required, disable insecure API mode
- [ ] Review similar local-only admin surfaces across stacks

---

## Phase 9: Logging and Audit Hygiene

### Goal
Prevent logs from becoming a secret sink.

### Required controls
- classify logs by sensitivity
- avoid logging tokens/passwords
- rotate logs
- define retention
- limit read permissions

### Checklist
- [ ] Identify secret-bearing logs
- [ ] Remove or mask sensitive values in logging paths where possible
- [ ] Add log rotation plan
- [ ] Define retention by log class
- [ ] Restrict log readability on host

---

## Phase 10: Verification and Re-Scan

### Goal
Validate that remediation actually removed exposure.

### Acceptance criteria
- no active hardcoded secrets in compose files
- no exposed secrets in `.bak` and helper artifacts
- no world-readable backup/cfg/db files
- secret inventory matches deployed configuration
- rotated credentials confirmed operational

### Checklist
- [ ] Re-scan compose/config paths
- [ ] Re-scan backup and helper artifacts
- [ ] Re-scan logs for credential material
- [ ] Re-check permissions of sensitive files
- [ ] Confirm all rotated secrets work in production
- [ ] Confirm revoked secrets no longer work

---

## 7) Technical Checklist by Area

## Hermes
- [ ] Move active secrets out of `docker-compose.yml`
- [ ] Remove secrets from backup compose variants
- [ ] review helper scripts and audit artifacts for credential traces
- [ ] add `.env` strategy
- [ ] tighten perms on ops and logs

## n8n
- [ ] remove DB password and encryption key from compose
- [ ] move secrets to restricted env file
- [ ] review whether mounted shared data path is necessary
- [ ] tighten perms on `/opt/infra/n8n/data`

## Brain / Open WebUI
- [ ] remove provider key from compose
- [ ] move to restricted env file
- [ ] tighten perms on database files

## WordPress
- [ ] restrict `wp-config.php`
- [ ] review any other secret-bearing config
- [ ] classify WordPress data path sensitivity

## Backups
- [ ] restrict local backup directory
- [ ] classify cert archives as high sensitivity
- [ ] review whether SQL dumps need separate tighter storage
- [ ] define retention and purge policy

## Traefik
- [ ] review insecure API mode
- [ ] decide keep, protect, or disable

---

## 8) Implementation Order

### Order of execution
- [ ] Build full secret inventory
- [ ] Freeze list of credentials to rotate
- [ ] Rotate highest-risk credentials first
- [ ] Refactor active stacks to env-based secret injection
- [ ] Clean historical artifacts
- [ ] Tighten file permissions
- [ ] Harden backup storage
- [ ] Review service boundaries
- [ ] Review Traefik/admin surfaces
- [ ] Re-scan and validate

---

## 9) Acceptance Test Matrix

### Secret hygiene
- [ ] No active secrets in live compose files
- [ ] No active secrets in backup compose variants
- [ ] No authenticated remote URLs with embedded credentials remain
- [ ] No credential material appears in routine logs

### Permissions
- [ ] Sensitive files are not world-readable
- [ ] Backup directory is not broadly readable
- [ ] DB files are restricted
- [ ] critical config files are restricted

### Rotation
- [ ] Old exposed credentials no longer work
- [ ] New credentials work in production
- [ ] dependent services remain healthy after rotation

### Operational continuity
- [ ] Hermes still starts cleanly
- [ ] n8n still starts cleanly
- [ ] Brain/Open WebUI still starts cleanly
- [ ] WordPress and dependent services remain healthy

---

## 10) Deferred Items

Not part of first hardening pass:
- external secret manager deployment
- full CIS host hardening
- centralized SIEM
- full RBAC redesign
- SSO for internal tools
- host-wide platform redesign

---

## 11) Final First-Pass Scope

### Included
- secret inventory
- credential rotation plan
- env-based secret separation
- cleanup of historical secret-bearing artifacts
- permission hardening
- backup hygiene
- Traefik control-surface review
- re-scan validation

### Excluded
- external secret vault
- enterprise IAM
- host-wide platform redesign
