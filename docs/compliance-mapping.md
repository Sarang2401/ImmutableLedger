# Compliance Mapping – Banking & Fintech Controls

This document maps platform features to common regulatory expectations.

---

## PCI-DSS (v4.0 – Beginner Correct)

### Requirement 10 – Track and Monitor All Access

| Control | Implementation |
|------|---------------|
| Audit logging | Structured JSON events |
| Time synchronization | UTC timestamps |
| Actor attribution | Actor field in event |
| Log integrity | S3 Object Lock (COMPLIANCE) |

---

## SOC 2 – Security & Availability

| Principle | Implementation |
|--------|----------------|
| Change tracking | Event-based audit trail |
| Evidence immutability | WORM storage |
| Least privilege | IAM-scoped roles |
| Incident reconstruction | Centralized evidence |

---

## SOX / Internal Controls

| Control | Implementation |
|------|----------------|
| Administrative actions logged | EventBridge audit events |
| Evidence retention | Enforced at storage layer |
| Manual tampering prevention | No delete permissions |

---

## Auditor Talking Point

> “Evidence integrity is enforced by AWS storage controls, not application logic.”

This statement alone satisfies multiple audit requirements.
