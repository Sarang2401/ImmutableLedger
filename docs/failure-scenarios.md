# Failure Scenarios & System Behavior

This document describes how the system behaves under failure conditions.

---

## Scenario 1: Application Compromise

**Event**
- Attacker gains EC2 access

**Outcome**
- Cannot delete or alter existing audit logs
- No S3 permissions available
- Past evidence remains intact

---

## Scenario 2: Lambda Failure

**Event**
- Lambda invocation errors

**Outcome**
- EventBridge retries
- Failed executions visible in CloudWatch
- No silent data loss

---

## Scenario 3: IAM Misconfiguration

**Event**
- Lambda loses PutObject permission

**Outcome**
- Writes fail loudly
- Errors logged
- No partial or corrupted data

---

## Scenario 4: Malicious Admin Attempt

**Event**
- Admin attempts to delete evidence

**Outcome**
- S3 Object Lock blocks deletion
- AccessDenied returned
- Retention policy enforced

---

## Scenario 5: Region or Service Outage

**Event**
- Temporary AWS service outage

**Outcome**
- No data mutation
- Evidence remains preserved
- System resumes without data integrity loss
