# SAP ABAP Student Management & Course Enrollment System

[![ABAP](https://img.shields.io/badge/Language-ABAP-blue.svg)](https://www.sap.com/)
[![SAP GUI](https://img.shields.io/badge/Platform-SAP%20GUI%20770-orange.svg)](https://www.sap.com/)
[![Database](https://img.shields.io/badge/Database-Relational%20Open%20SQL-yellow.svg)](https://www.sap.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Project Overview

The **SAP ABAP Student Management & Course Enrollment System** is an end-to-end relational database application built from scratch in SAP GUI using the custom **`ZBHA`** namespace. 

Initially developed as a standalone student management tool, the project has been extended into a **multi-table relational enterprise system** featuring Foreign Key referential integrity, Currency/Quantity reference mapping, and advanced Open SQL **`INNER JOIN`** reporting displayed via the ABAP List Viewer (ALV).

A central execution dashboard (`ZBHA_STUDENT_MGMT`) ties all **10 modular programs** together with user-friendly selection texts and `SUBMIT ... AND RETURN` event routing.

---

## Architecture & Database Design

### 1. Master Table: `ZBHA_STUDENT` (`SE11`)
Stores student demographic and academic records:
* Composite Primary Key: `MANDT` + `STUDENT_ID` (`NUMC 8`)
* Non-Key Fields: `STUDENT_NAME` (`CHAR 40`), `STUDENT_MARKS` (`INT2 3`)
* Technical Settings: Data Class `APPL0` (Master data), Size Category `0`

### 2. Transaction / Relational Table: `ZBHA_ENROLLMENT` (`SE11`)
Stores student course registrations and financial details:
* Composite Primary Key: `MANDT` + `ENROLL_ID` (`CHAR 10`)
* **Foreign Key**: `STUDENT_ID` linked directly to check table `ZBHA_STUDENT`
* Course & Fee: `COURSE_NAME` (`CHAR 30`), `FEE_PAID` (`CURR 10,2`)
* **Currency Reference Link**: `FEE_PAID` references `CURRENCY` (`WAERS`, `CUKY 5`)

---

## Key Features & Modules

### 🔹 Core CRUD Operations (`SE38`)
1. **Insert Student (`ZBHA_STUDENT_INSERT`)**: Captures student data with duplicate primary key prevention.
2. **Search Student (`ZBHA_STUDENT_SEARCH`)**: Fast retrieval by Student ID using Open SQL `SELECT SINGLE`.
3. **Update Student (`ZBHA_STUDENT_UPDATE`)**: Safe updates to student details using the `MODIFY` statement.
4. **Delete Student (`ZBHA_STUDENT_DELETE`)**: Existence validation before removing records from the database table.

### 🔹 Course Enrollment & Relational Logic
5. **Course Enrollment (`ZBHA_ENROLL_ADD`)**: Performs pre-validation against the master `ZBHA_STUDENT` table before registering a course and fee payment.
6. **Student & Course Inner Join ALV (`ZBHA_STUDENT_JOIN_ALV`)**: Combines student demographics and enrollment data using Open SQL `INNER JOIN` and renders an interactive ALV grid (`REUSE_ALV_GRID_DISPLAY`) with a custom dynamic field catalog.

### 🔹 Reporting, Validation & Analytics
7. **Single-Table ALV Grid (`ZBHA_STUDENT_ALV`)**: Interactive spreadsheet display for student records with standard SAP toolbar operations (sort, filter, Excel download).
8. **Data Validation (`ZBHA_STUDENT_VALIDATE` & `ZBHA_STUDENT_REUSABLE_VALIDATE`)**: Modular subroutines (`FORM` / `PERFORM`) ensuring marks fall between `0` and `100`.
9. **Aggregate Counter (`ZBHA_STUDENT_COUNT`)**: Instant calculation of total enrolled students using SQL `SELECT COUNT(*)`.

### 🔹 Object-Oriented ABAP (OOABAP)
10. **OOP Student Module (`ZBHA_STUDENT_OOP`)**: Demonstrates class encapsulation using a local class `lcl_student_manager` with method definition, object instantiation (`CREATE OBJECT`), and parameter import.

### 🔹 Master Execution Dashboard
11. **Main Menu (`ZBHA_STUDENT_MGMT`)**: Central execution cockpit featuring 10 radio buttons configured with clean Selection Texts to seamlessly navigate between all modules.

---

## Project Structure

| Directory / File | Description | Transaction |
|---|---|:---:|
| [`database/zbha_student_table.md`](database/zbha_student_table.md) | Master Table schema documentation (`ZBHA_STUDENT`) | `SE11` |
| [`database/zbha_enrollment_table.md`](database/zbha_enrollment_table.md) | Relational Table schema documentation (`ZBHA_ENROLLMENT`) | `SE11` |
| [`Programs/zbha_student_insert.abap`](Programs/zbha_student_insert.abap) | Insert student records | `SE38` |
| [`Programs/zbha_student_search.abap`](Programs/zbha_student_search.abap) | Search student record by ID | `SE38` |
| [`Programs/zbha_student_update.abap`](Programs/zbha_student_update.abap) | Update existing student record | `SE38` |
| [`Programs/zbha_student_delete.abap`](Programs/zbha_student_delete.abap) | Delete student record | `SE38` |
| [`Programs/zbha_enroll_add.abap`](Programs/zbha_enroll_add.abap) | Enroll student in course with foreign key check | `SE38` |
| [`Programs/zbha_student_validate.abap`](Programs/zbha_student_validate.abap) | Marks range validation driver | `SE38` |
| [`Programs/zbha_student_count.abap`](Programs/zbha_student_count.abap) | Real-time SQL count aggregate | `SE38` |
| [`Programs/zbha_student_mgmt.abap`](Programs/zbha_student_mgmt.abap) | Master Dashboard launcher (10 Radio Buttons) | `SE38` |
| [`Reports/zbha_student_alv.abap`](Reports/zbha_student_alv.abap) | ALV Report for student master table | `SE38` |
| [`Reports/zbha_student_join_alv.abap`](Reports/zbha_student_join_alv.abap) | Relational `INNER JOIN` ALV Report with dynamic field catalog | `SE38` |
| [`Modularization/zbha_student_reusable_validate.abap`](Modularization/zbha_student_reusable_validate.abap) | Reusable `FORM` logic for score validation | `SE38` |
| [`Modularization/zbha_student_modular.abap`](Modularization/zbha_student_modular.abap) | Subroutine modularization | `SE38` |
| [`Modularization/zbha_student_params.abap`](Modularization/zbha_student_params.abap) | Parameter passing (`USING` / `CHANGING`) | `SE38` |
| [`oop/zbha_student_oop.abap`](oop/zbha_student_oop.abap) | Object-Oriented ABAP class & method | `SE38` |
| `screenshots/` | Output verification screenshots and demo media | — |

---

## Relational Database Tables Overview

### `ZBHA_STUDENT` (Master Table)
| Field | Key | Data Element | Domain | Type | Length | Description |
|---|:---:|---|---|:---:|---:|---|
| **`MANDT`** | **X** | `MANDT` | `MANDT` | CLNT | 3 | Client |
| **`STUDENT_ID`** | **X** | `ZBHADE_STID` | `ZBHAD_STID` | NUMC | 8 | Student ID |
| **`STUDENT_NAME`** | | `ZBHADE_NAME` | `ZBHAD_NAME` | CHAR | 40 | Student Name |
| **`STUDENT_MARKS`**| | `ZBHADE_MARKS`| `ZBHAD_MARKS`| INT2 | 3 | Student Marks |

### `ZBHA_ENROLLMENT` (Transaction Table)
| Field | Key | Data Element | Domain | Type | Length | Description |
|---|:---:|---|---|:---:|---:|---|
| **`MANDT`** | **X** | `MANDT` | `MANDT` | CLNT | 3 | Client |
| **`ENROLL_ID`** | **X** | `ZBHADE_ENRID` | `ZBHAD_ENRID` | CHAR | 10 | Enrollment ID (PK) |
| **`STUDENT_ID`** | | `ZBHADE_STID` | `ZBHAD_STID` | NUMC | 8 | Student ID (**FK**) |
| **`COURSE_NAME`** | | `ZBHADE_COURSE` | `ZBHAD_COURSE` | CHAR | 30 | Course Name |
| **`FEE_PAID`** | | `ZBHADE_FEE` | `ZBHAD_FEE` | CURR | 10,2 | Fee Paid |
| **`CURRENCY`** | | `WAERS` | `WAERS` | CUKY | 5 | Currency Key |

---

## Key ABAP Concepts Demonstrated

- **Relational Data Dictionary (DDIC):** Custom domains, data elements, foreign keys, currency reference tables, and technical settings (`APPL0`, Size `0`).
- **Open SQL Multi-Table Queries:** Relational SQL `INNER JOIN` statements combining header and line item entities.
- **Dynamic ALV Field Catalogs:** Building custom field catalogs (`slis_t_fieldcat_alv`) with column headers and technical attributes.
- **Foreign Key Validation:** Application-level validation verifying master key existence before writing transaction data.
- **Selection Screen Polish:** Customizing Selection Texts (`Goto -> Text Elements -> Selection Texts`) for clean, enterprise-grade radio-button screens.
- **Modularization & OOP:** Subroutine design (`FORM/PERFORM`), parameter passing (`USING/CHANGING`), and OOABAP Local Classes.
