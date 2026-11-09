*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_DELETE
*&---------------------------------------------------------------------*
*& Delete Student Record from ZBHA_STUDENT table
*&---------------------------------------------------------------------*
REPORT zbha_student_delete.

* Selection screen to specify which student record to remove
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id TYPE zbhade_stid OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  " First, check if student record exists before attempting deletion
  DATA: lv_id TYPE zbhade_stid.

  SELECT SINGLE student_id 
    FROM zbha_student 
    INTO lv_id 
   WHERE student_id = p_id.

  IF sy-subrc = 0.
    " Delete record directly from custom database table
    DELETE FROM zbha_student WHERE student_id = p_id.

    IF sy-subrc = 0.
      WRITE: / 'Success: Student record with ID', p_id, 'has been deleted completely.'.
    ELSE.
      WRITE: / 'Error: Failed to clear record from database.'.
    ENDIF.
  ELSE.
    WRITE: / 'Error: Student ID', p_id, 'does not exist in the system.'.
  ENDIF.
