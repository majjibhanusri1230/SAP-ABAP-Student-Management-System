*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_UPDATE
*&---------------------------------------------------------------------*
*& Update Existing Student Record in ZBHA_STUDENT table
*&---------------------------------------------------------------------*
REPORT zbha_student_update.

* Selection screen to specify which student to update and new details
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id   TYPE zbhade_stid OBLIGATORY,
            p_name TYPE zbhade_name OBLIGATORY,
            p_mark TYPE zbhade_marks OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  " Declare work area
  DATA: wa_student TYPE zbha_student.

  " First, check if the student record actually exists
  SELECT SINGLE * 
    FROM zbha_student 
    INTO wa_student 
   WHERE student_id = p_id.

  IF sy-subrc = 0.
    " Assign the updated details to the work area structure
    wa_student-student_name  = p_name.
    wa_student-student_marks = p_mark.

    " Modify database row using updated work area
    MODIFY zbha_student FROM wa_student.

    IF sy-subrc = 0.
      WRITE: / 'Success: Student record updated successfully!'.
      WRITE: / 'ID       :', p_id.
      WRITE: / 'New Name :', p_name.
      WRITE: / 'New Marks:', p_mark.
    ELSE.
      WRITE: / 'Error: Database update failed.'.
    ENDIF.
  ELSE.
    WRITE: / 'Error: Cannot update. Student ID', p_id, 'does not exist.'.
  ENDIF.
