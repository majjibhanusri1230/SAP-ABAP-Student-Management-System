*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_JOIN_ALV
*&---------------------------------------------------------------------*
*& Relational Reporting: Open SQL INNER JOIN between ZBHA_STUDENT &
*& ZBHA_ENROLLMENT displayed using REUSE_ALV_GRID_DISPLAY
*&---------------------------------------------------------------------*
REPORT zbha_student_join_alv.

* Structure to hold combined relational data
TYPES: BEGIN OF ty_report,
         student_id    TYPE zbha_student-student_id,
         student_name  TYPE zbha_student-student_name,
         student_marks TYPE zbha_student-student_marks,
         enroll_id     TYPE zbha_enrollment-enroll_id,
         course_name   TYPE zbha_enrollment-course_name,
         fee_paid      TYPE zbha_enrollment-fee_paid,
         currency      TYPE zbha_enrollment-currency,
       END OF ty_report.

DATA: lt_report   TYPE TABLE OF ty_report,
      lt_fieldcat TYPE slis_t_fieldcat_alv,
      ls_fieldcat TYPE slis_fieldcat_alv.

START-OF-SELECTION.

  " Fetch combined relational data using Open SQL INNER JOIN
  SELECT a~student_id
         a~student_name
         a~student_marks
         b~enroll_id
         b~course_name
         b~fee_paid
         b~currency
    INTO TABLE lt_report
    FROM zbha_student AS a
   INNER JOIN zbha_enrollment AS b
      ON a~student_id = b~student_id.

  IF lt_report IS INITIAL.
    WRITE: / 'Information: No enrollment records found to display.'.
    EXIT.
  ENDIF.

  " Build Dynamic Field Catalog for ALV Grid
  PERFORM build_fcat USING 'STUDENT_ID'    'Student ID'.
  PERFORM build_fcat USING 'STUDENT_NAME'  'Student Name'.
  PERFORM build_fcat USING 'STUDENT_MARKS' 'Marks'.
  PERFORM build_fcat USING 'ENROLL_ID'     'Enrollment ID'.
  PERFORM build_fcat USING 'COURSE_NAME'   'Course Name'.
  PERFORM build_fcat USING 'FEE_PAID'      'Fee Paid'.
  PERFORM build_fcat USING 'CURRENCY'      'Currency'.

  " Display ALV Grid with interactive toolbar (sort, filter, export)
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fieldcat
    TABLES
      t_outtab           = lt_report
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    WRITE: / 'Error: Unable to generate ALV report grid.'.
  ENDIF.

*----------------------------------------------------------------------*
* Subroutine to append column properties to Field Catalog
*----------------------------------------------------------------------*
FORM build_fcat USING p_fieldname TYPE slis_fieldname
                      p_seltext   TYPE dd03p-scrtext_m.
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = p_fieldname.
  ls_fieldcat-seltext_m = p_seltext.
  APPEND ls_fieldcat TO lt_fieldcat.
ENDFORM.
