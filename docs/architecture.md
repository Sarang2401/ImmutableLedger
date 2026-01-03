# Immutable Audit & Evidence Platform – Architecture

## Overview

This platform implements an immutable, write-once audit evidence pipeline designed for regulated banking and fintech systems.

The primary objective is to ensure:
- Audit logs cannot be altered or deleted
- Evidence integrity survives system compromise
- Audit data is centrally governed and retention-enforced

## Architecture Flow

1. Regulated application emits structured audit events
2. Events are sent to Amazon EventBridge
3. EventBridge triggers a controlled AWS Lambda function
4. Lambda writes events to an S3 Evidence Vault
5. S3 enforces Object Lock in COMPLIANCE mode

## Key Design Principles

### 1. Separation of Duties
- Application cannot access S3
- Lambda can only write, not read or delete
- Humans cannot modify or delete evidence

### 2. Immutability Enforcement
- S3 Object Lock (COMPLIANCE) prevents deletion
- Retention period enforced at storage layer
- Even root users cannot bypass retention

### 3. Least Privilege IAM
- EC2 role: events:PutEvents only
- Lambda role: s3:PutObject only
- No wildcard admin permissions

### 4. Failure Isolation
- Event ingestion decoupled from storage
- Application failures do not impact evidence durability
- Storage remains intact during downstream outages

## Why This Works for Audits

Auditors care about:
- Integrity
- Non-repudiation
- Retention enforcement
- Evidence survivability

This architecture enforces all controls outside application trust boundaries.
