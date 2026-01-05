# 🔐 Immutable Audit & Evidence Platform for Regulated Systems

A cloud-native audit logging platform designed to enforce **immutable, write-once audit evidence** for regulated fintech and banking environments. The system ensures audit integrity using AWS-managed controls rather than relying on application-level trust.

---

## 📌 Project Overview

In regulated systems, audit failures often occur due to **mutable or missing logs**, not system outages. This project demonstrates how to design an **audit-defensible architecture** where audit evidence cannot be altered or deleted — even by administrators.

The platform enforces immutability at the **storage layer** using Amazon S3 Object Lock (COMPLIANCE mode) and strict IAM separation of duties.

---

## 🎯 Key Objectives

- Enforce **Write Once, Read Many (WORM)** audit storage
- Prevent applications from directly accessing audit storage
- Apply **least-privilege IAM** and separation of duties
- Decouple audit generation from audit persistence
- Align with PCI-DSS logging and integrity expectations

---

## 🏗️ Architecture Overview

EC2 (Regulated Application)
↓
Amazon EventBridge (Audit Ingestion)
↓
AWS Lambda (Controlled Writer)
↓
Amazon S3 (Object Lock – COMPLIANCE)


### Core Design Principles
- Applications emit events only (no storage access)
- Lambda performs write-only operations
- S3 enforces immutability and retention
- Humans cannot bypass Object Lock

---

## 🧱 Core Components

- **EC2 Application**
  - Emits structured audit events
  - Uses IAM roles (no static credentials)

- **Amazon EventBridge**
  - Centralized audit ingestion bus
  - Decouples producers from storage

- **AWS Lambda (Audit Writer)**
  - Write-only permission to S3
  - No read or delete access

- **Amazon S3 (Evidence Vault)**
  - Object Lock (COMPLIANCE mode)
  - Versioning enabled
  - Immutable audit storage

---

## 🔐 Security & Compliance Considerations

- Separation of duties enforced via IAM
- No direct application → S3 access
- Object deletion and overwrite blocked
- Aligned with **PCI-DSS Requirement 10**
- Audit integrity enforced outside application trust boundary

---

## 🚀 Deployment & Usage

- Infrastructure provisioned using **Terraform**
- AWS Free Tier–compatible services
- EC2 used to simulate a regulated application
- Audit events emitted and persisted automatically

### Verification Steps
- Confirm Lambda execution via CloudWatch Logs
- Verify objects written to S3
- Attempt delete/overwrite → AccessDenied (expected)

---

## ⚠️ Known Failure Scenarios (Handled)

- IAM misconfiguration → AccessDenied (safe failure)
- Lambda logging disabled → fixed via IAM policy
- Service constraints → re-architecture without weakening controls

---

## 📈 Outcome

The platform successfully demonstrates:
- Immutable audit evidence storage
- Least-privilege cloud security design
- Event-driven architecture for compliance use cases
- Real-world audit defensibility

---

## 🧠 Key Learnings

- Audit integrity should not rely on application logic
- Storage-level controls provide stronger guarantees
- IAM scoping errors are a common real-world failure mode
- Decoupling improves reliability and auditability

---

## 📄 Documentation

- Detailed design report available in the repository
- Architecture diagrams included for clarity

---

## 👤 Author

Built by *Sarang Shigwan*  
Focused on cloud security, reliability, and regulated system design.
