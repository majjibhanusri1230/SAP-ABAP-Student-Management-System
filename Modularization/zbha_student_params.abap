*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_PARAMS
*&---------------------------------------------------------------------*
*& Parameter Handling (USING and CHANGING) in Subroutines
*&---------------------------------------------------------------------*
REPORT zbha_student_params.

DATA:
  gv_name  TYPE zbha_student-student_name,
  gv_marks TYPE zbha_student-student_marks.

START-OF-SELECTION.

  gv_name  = 'Bhanu'.
  gv_marks = 85.

  WRITE: / 'BEFORE CALLING FORM'.
  WRITE: / 'Student Name  :', gv_name.
  WRITE: / 'Original Marks:', gv_marks.

  ULINE.

  PERFORM calculate_marks
    USING gv_name
    CHANGING gv_marks.

  WRITE: / 'AFTER CALLING FORM'.
  WRITE: / 'Student Name : ', gv_name.
  WRITE: / 'Updated Marks: ', gv_marks.

* FORM with USING and CHANGING parameters
FORM calculate_marks
  USING p_name      TYPE zbha_student-student_name
  CHANGING p_marks  TYPE zbha_student-student_marks.

  p_marks = p_marks + 10.
  WRITE: / 'Processing student:', p_name.

ENDFORM.
