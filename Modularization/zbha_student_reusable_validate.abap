*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_REUSABLE_VALIDATE
*&---------------------------------------------------------------------*
*& Reusable Validation Logic for Student Marks Verification
*&---------------------------------------------------------------------*
REPORT zbha_student_reusable_validate.

* This form checks if the student's marks are valid (between 0 and 100)
FORM check_student_marks USING p_mark TYPE zbhade_marks
                         CHANGING p_valid TYPE c.

  IF p_mark >= 0 AND p_mark <= 100.
    p_valid = 'Y'.
  ELSE.
    p_valid = 'N'.
  ENDIF.

ENDFORM.
