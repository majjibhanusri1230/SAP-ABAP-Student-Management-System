# ZBHA_STUDENT – Database Table Documentation

## 1. Overview

- **Table Name:** `ZBHA_STUDENT`
- **Description:** Student Management Database Table
- **Table Type:** Transparent Table
- **Delivery Class:** `A` (Application table: Master and transaction data)
- **Data Browser / Table View Maint:** Display/Maintenance Allowed
- **Status:** Active
- **Technology:** SAP ABAP Dictionary (SE11)
- **Technical Settings:** Data Class `APPL0`, Size Category `0`

## 2. Table Structure (Fields, Data Elements & Domains)

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Decimals | Short Description |
|---|:---:|:---:|---|---|:---:|---:|---:|---|
| **MANDT** | **X** | **X** | `MANDT` | `MANDT` | CLNT | 3 | 0 | Client |
| **STUDENT_ID** | **X** | **X** | `ZBHADE_STID` | `ZBHAD_STID` | NUMC | 8 | 0 | Student Identification Number |
| **STUDENT_NAME** | | | `ZBHADE_NAME` | `ZBHAD_NAME` | CHAR | 40 | 0 | Full Student Name |
| **STUDENT_MARKS**| | | `ZBHADE_MARKS`| `ZBHAD_MARKS`| INT2 | 3 | 0 | Student Total Marks |

## 3. Primary Key

The composite primary key consists of:
- `MANDT` – SAP Client (ensures client-independence and multi-tenancy)
- `STUDENT_ID` – Unique Student Identification Number

## 4. Purpose

The `ZBHA_STUDENT` custom transparent table serves as the primary data store for the BHA Student Management System.

It supports:
- Student Record Insertion (`ZBHA_STUDENT_INSERT`)
- Student Record Query / Search (`ZBHA_STUDENT_SEARCH`)
- Student Record Update (`ZBHA_STUDENT_UPDATE`)
- Student Record Deletion (`ZBHA_STUDENT_DELETE`)
- Input Marks Validation (`ZBHA_STUDENT_VALIDATE`)
- ALV Grid Reporting (`ZBHA_STUDENT_ALV`)
- Object-Oriented Processing (`ZBHA_STUDENT_OOP`)
- Student Record Aggregation & Counting (`ZBHA_STUDENT_COUNT`)

## 5. Development Environment

- **IDE / Environment:** SAP GUI 770 / ABAP Workbench
- **Data Dictionary:** Transaction `SE11`
- **Editor:** Transaction `SE38`
- **Database Access:** Open SQL
