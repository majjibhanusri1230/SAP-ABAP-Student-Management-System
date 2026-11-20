# ZBHA_ENROLLMENT – Database Table Documentation

## 1. Overview

- **Table Name:** `ZBHA_ENROLLMENT`
- **Description:** Student Course Enrollment & Fee Table
- **Table Type:** Transparent Table
- **Delivery Class:** `A` (Application table: Master and transaction data)
- **Data Browser / Table View Maint:** Display/Maintenance Allowed
- **Status:** Active
- **Technology:** SAP ABAP Dictionary (SE11)
- **Technical Settings:** Data Class `APPL0`, Size Category `0`

## 2. Table Structure (Fields, Data Elements & Domains)

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Decimals | Short Description | Notes |
|---|:---:|:---:|---|---|:---:|---:|---:|---|---|
| **MANDT** | **X** | **X** | `MANDT` | `MANDT` | CLNT | 3 | 0 | Client | SAP Client (Multi-Tenancy) |
| **ENROLL_ID** | **X** | **X** | `ZBHADE_ENRID` | `ZBHAD_ENRID` | CHAR | 10 | 0 | Enrollment ID | Primary Key |
| **STUDENT_ID** | | | `ZBHADE_STID` | `ZBHAD_STID` | NUMC | 8 | 0 | Student Identification Number | **Foreign Key** pointing to `ZBHA_STUDENT` |
| **COURSE_NAME** | | | `ZBHADE_COURSE` | `ZBHAD_COURSE` | CHAR | 30 | 0 | Course Name | Name of enrolled course |
| **FEE_PAID** | | | `ZBHADE_FEE` | `ZBHAD_FEE` | CURR | 10 | 2 | Course Fee Paid | Currency amount (Decimals: 2) |
| **CURRENCY** | | | `WAERS` | `WAERS` | CUKY | 5 | 0 | Currency Key | e.g. INR, USD |

## 3. Currency / Quantity Reference Fields

SAP ABAP requires every `CURR` field to have a corresponding reference currency field (`CUKY`):
- **Field:** `FEE_PAID`
- **Reference Table:** `ZBHA_ENROLLMENT`
- **Reference Field:** `CURRENCY`

## 4. Foreign Key Relationship

- **Field:** `STUDENT_ID`
- **Check Table:** `ZBHA_STUDENT`
- **Purpose:** Enforces referential integrity at the database level. An enrollment can only be created if the corresponding `STUDENT_ID` exists in the `ZBHA_STUDENT` master table.

## 5. Associated Programs

- **`ZBHA_ENROLL_ADD`**: Accepts enrollment parameters, performs master table lookup, and inserts new enrollment record.
- **`ZBHA_STUDENT_JOIN_ALV`**: Performs Open SQL `INNER JOIN` between `ZBHA_STUDENT` and `ZBHA_ENROLLMENT` and outputs to ALV Grid.
