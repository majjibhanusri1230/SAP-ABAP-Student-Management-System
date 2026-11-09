*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_INSERT
*&---------------------------------------------------------------------*
*& Insert Student Records into ZBHA_STUDENT table
*&---------------------------------------------------------------------*
REPORT zbha_student_insert.

* Selection screen to input student details
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id   TYPE zbhade_stid OBLIGATORY,
            p_name TYPE zbhade_name OBLIGATORY,
            p_mark TYPE zbhade_marks.
SELECTION-SCREEN END OF BLOCK b1.

* Start of execution logic
START-OF-SELECTION.

  " Declare a work area matching custom table structure
  DATA: wa_student TYPE zbha_student.

  " Assign input values from screen fields to structure fields
  wa_student-mandt         = sy-mandt.
  wa_student-student_id    = p_id.
  wa_student-student_name  = p_name.
  wa_student-student_marks = p_mark.

  " Insert the record directly into custom database table
  INSERT zbha_student FROM wa_student.

  " Check if database system accepted the row successfully
  IF sy-subrc = 0.
    WRITE: / 'Success: Student record inserted into ZBHA_STUDENT table!'.
    WRITE: / 'ID   :', p_id.
    WRITE: / 'Name :', p_name.
    WRITE: / 'Marks:', p_mark.
  ELSE.
    WRITE: / 'Error: A student with ID', p_id, 'already exists in the system.'.
  ENDIF.
