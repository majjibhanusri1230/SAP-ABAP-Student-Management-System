*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_VALIDATE
*&---------------------------------------------------------------------*
*& Validate Student Input Marks using Reusable Logic
*&---------------------------------------------------------------------*
REPORT zbha_student_validate.

* Include selection screen fields to input data for verification
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id   TYPE zbhade_stid OBLIGATORY,
            p_name TYPE zbhade_name OBLIGATORY,
            p_mark TYPE zbhade_marks OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  DATA: lv_is_valid TYPE c VALUE 'N'.

  " Call verification form block from reusable logic program
  PERFORM check_student_marks(zbha_student_reusable_validate)
    USING p_mark
    CHANGING lv_is_valid.

  " Output evaluation response summary
  IF lv_is_valid = 'Y'.
    WRITE: / 'Validation Result: SUCCESS'.
    WRITE: / 'The entry values pass all rules.'.
    WRITE: / 'Marks entered:', p_mark.
  ELSE.
    WRITE: / 'Validation Result: FAILED'.
    WRITE: / 'Error: Marks must be between 0 and 100!'.
    WRITE: / 'Invalid marks specified:', p_mark.
  ENDIF.
