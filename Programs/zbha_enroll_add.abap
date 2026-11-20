*&---------------------------------------------------------------------*
*& Report ZBHA_ENROLL_ADD
*&---------------------------------------------------------------------*
*& Enroll Student in Course & Fee Management
*& Validates Student Existence in Master Table (ZBHA_STUDENT)
*&---------------------------------------------------------------------*
REPORT zbha_enroll_add.

* Selection screen parameters for Course Enrollment
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_enrid  TYPE zbhade_enrid  OBLIGATORY,
            p_stid   TYPE zbhade_stid   OBLIGATORY,
            p_course TYPE zbhade_course OBLIGATORY,
            p_fee    TYPE zbhade_fee    OBLIGATORY,
            p_curr   TYPE waers         DEFAULT 'INR' OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA: ls_student TYPE zbha_student,
      ls_enroll  TYPE zbha_enrollment.

START-OF-SELECTION.

  " 1. Check if Student ID exists in Master Table (Foreign Key Integrity Check)
  SELECT SINGLE * 
    FROM zbha_student
    INTO ls_student
   WHERE student_id = p_stid.

  IF sy-subrc <> 0.
    WRITE: / 'Error: Student ID', p_stid, 'does not exist in ZBHA_STUDENT master table!'.
    STOP.
  ENDIF.

  " 2. Prepare and insert Enrollment record
  ls_enroll-mandt       = sy-mandt.
  ls_enroll-enroll_id   = p_enrid.
  ls_enroll-student_id  = p_stid.
  ls_enroll-course_name = p_course.
  ls_enroll-fee_paid    = p_fee.
  ls_enroll-currency    = p_curr.

  INSERT zbha_enrollment FROM ls_enroll.

  IF sy-subrc = 0.
    WRITE: / '=================================================='.
    WRITE: / '     COURSE ENROLLMENT SUCCESSFUL!                '.
    WRITE: / '=================================================='.
    WRITE: / 'Enrollment ID :', ls_enroll-enroll_id.
    WRITE: / 'Student ID    :', ls_enroll-student_id.
    WRITE: / 'Student Name  :', ls_student-student_name.
    WRITE: / 'Course Name   :', ls_enroll-course_name.
    WRITE: / 'Fee Paid      :', ls_enroll-fee_paid, ls_enroll-currency.
    WRITE: / '=================================================='.
  ELSE.
    WRITE: / 'Error: Enrollment ID', p_enrid, 'already exists in database.'.
  ENDIF.
