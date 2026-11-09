# SAP ABAP Student Management System

[![ABAP](https://img.shields.io/badge/Language-ABAP-blue.svg)](https://www.sap.com/)
[![SAP GUI](https://img.shields.io/badge/Platform-SAP%20GUI-orange.svg)](https://www.sap.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Project Overview

The **SAP ABAP Student Management System** is an end-to-end database-driven application developed using Core ABAP, the ABAP Data Dictionary (DDIC), Open SQL, Object-Oriented ABAP (OOP), and ALV Reports in SAP GUI.

The system allows users to create, search, update, delete, validate, count, and display student records stored in a custom transparent database table (`ZBHA_STUDENT`). It includes a master dashboard program (`ZBHA_STUDENT_MGMT`) that provides unified access to all modules from a single selection screen.

---

## Technologies Used

- **Language:** SAP ABAP (Advanced Business Application Programming)
- **Environment:** SAP GUI / ABAP Workbench
- **Data Dictionary (DDIC):** Transaction `SE11` (Custom Table, Data Elements, Domains)
- **ABAP Editor:** Transaction `SE38` (Executable Reports)
- **Database Access:** Open SQL (`SELECT`, `INSERT`, `MODIFY`, `DELETE`, `COUNT`)
- **Reporting:** ABAP List Viewer (ALV) via `REUSE_ALV_GRID_DISPLAY`
- **Object-Oriented Programming (OOP):** ABAP Local Classes and Methods
- **Modularization:** Subroutines (`FORM` / `PERFORM` with `USING` and `CHANGING`)

---

## Key Features

1. **Custom Database Table (`ZBHA_STUDENT`)**: Designed with custom data elements and domains in SE11 to ensure proper data typing and client-independence (`MANDT`).
2. **Insert Student Records**: Capture input parameters (`P_ID`, `P_NAME`, `P_MARK`) and insert rows into the database with duplicate prevention.
3. **Search Records**: Fast query by Student ID using Open SQL `SELECT SINGLE` and formatted detail output.
4. **Update Records**: Modify existing student records and update the database safely using `MODIFY`.
5. **Delete Records**: Validate existence and remove records from the database table with `DELETE`.
6. **Data Validation**: Reusable validation logic to verify student marks fall within valid ranges (`0` to `100`).
7. **Modular Programming**: Subroutines (`FORM` / `PERFORM`) with `USING` and `CHANGING` parameters for reusable code.
8. **Object-Oriented ABAP (OOP)**: Class definition and implementation (`lcl_student_manager`) with methods for student data operations.
9. **ALV Grid Reporting**: Interactive spreadsheet-like ALV report grid with sorting, filtering, and export capabilities.
10. **Student Count**: Dynamic calculation of total registered students using Open SQL `SELECT COUNT(*)`.
11. **Master Dashboard Menu**: Central selection screen allowing users to launch any module using radio buttons and `SUBMIT ... AND RETURN`.

---

## Project Structure

| Directory / File | Description | Transaction |
|---|---|:---:|
| [`zbha_student_table.md`](database/zbha_student_table.md) | Table structure, Data Elements, Domains, Technical Settings | `SE11` |
| [`Programs/zbha_student_insert.abap`](Programs/zbha_student_insert.abap) | Insert student records into `ZBHA_STUDENT` | `SE38` |
| [`Programs/zbha_student_search.abap`](Programs/zbha_student_search.abap) | Search student record by `STUDENT_ID` | `SE38` |
| [`Programs/zbha_student_update.abap`](Programs/zbha_student_update.abap) | Modify student details | `SE38` |
| [`Programs/zbha_student_delete.abap`](Programs/zbha_student_delete.abap) | Delete student record with verification | `SE38` |
| [`Programs/zbha_student_validate.abap`](Programs/zbha_student_validate.abap) | Validation screen calling reusable check subroutine | `SE38` |
| [`Programs/zbha_student_count.abap`](Programs/zbha_student_count.abap) | Aggregate query for total registered student count | `SE38` |
| [`Programs/zbha_student_mgmt.abap`](Programs/zbha_student_mgmt.abap) | Master dashboard launcher with radio button navigation | `SE38` |
| [`Reports/zbha_student_alv.abap`](Reports/zbha_student_alv.abap) | Interactive ALV Grid report (`REUSE_ALV_GRID_DISPLAY`) | `SE38` |
| [`Modularization/zbha_student_reusable_validate.abap`](Modularization/zbha_student_reusable_validate.abap) | Reusable `FORM` for input mark boundaries | `SE38` |
| [`Modularization/zbha_student_modular.abap`](Modularization/zbha_student_modular.abap) | Modular subroutines demonstration | `SE38` |
| [`Modularization/zbha_student_params.abap`](Modularization/zbha_student_params.abap) | Parameter handling (`USING` / `CHANGING`) | `SE38` |
| [`oop/zbha_student_oop.abap`](oop/zbha_student_oop.abap) | Object-Oriented ABAP class & method implementation | `SE38` |
| `screenshots/` | Verification output screenshots | — |

---

## Database Table Structure (`ZBHA_STUDENT`)

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Short Description |
|---|:---:|:---:|---|---|:---:|---:|---|
| **MANDT** | **X** | **X** | `MANDT` | `MANDT` | CLNT | 3 | Client |
| **STUDENT_ID** | **X** | **X** | `ZBHADE_STID` | `ZBHAD_STID` | NUMC | 8 | Student ID |
| **STUDENT_NAME** | | | `ZBHADE_NAME` | `ZBHAD_NAME` | CHAR | 40 | Student Name |
| **STUDENT_MARKS**| | | `ZBHADE_MARKS`| `ZBHAD_MARKS`| INT2 | 3 | Student Marks |

- **Delivery Class:** `A` (Application Table)
- **Data Browser / Table View Maint:** Display/Maintenance Allowed
- **Technical Settings:** Data Class `APPL0`, Size Category `0`

---

## Key ABAP Concepts Learned

- **ABAP Data Dictionary (DDIC):** Creating custom domains, data elements, transparent tables, and maintaining technical settings (`APPL0`, Size `0`).
- **Selection Screens:** Designing user input blocks using `SELECTION-SCREEN BEGIN OF BLOCK ...`, `PARAMETERS`, `RADIOBUTTON GROUP`, and `OBLIGATORY`.
- **Open SQL:** Executing transactional and aggregate statements (`SELECT SINGLE`, `SELECT *`, `INSERT`, `MODIFY`, `DELETE`, `SELECT COUNT(*)`).
- **System Fields:** Evaluating `SY-SUBRC` for error handling and operation status verification.
- **ALV Reporting:** Integrating standard SAP function modules (`REUSE_ALV_GRID_DISPLAY`) with dynamic structure binding (`i_structure_name = 'ZBHA_STUDENT'`).
- **Modularization:** Creating reusable subroutines (`FORM ... ENDFORM`) with value passing (`USING`, `CHANGING`).
- **Object-Oriented ABAP (OOP):** Implementing local classes (`CLASS ... DEFINITION / IMPLEMENTATION`), creating instances (`CREATE OBJECT`), and calling methods.
- **Program Flow & Navigation:** Coordinating independent reports using `CASE ... WHEN` and `SUBMIT ... VIA SELECTION-SCREEN AND RETURN`.

---

## Project Outcome

Successfully designed, configured, and tested a complete Student Management System in SAP GUI with full CRUD capabilities, data integrity checks, object-oriented design, and ALV reports under the custom `BHA` namespace.
