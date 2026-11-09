*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_COUNT
*&---------------------------------------------------------------------*
*& Count Total Registered Student Records in ZBHA_STUDENT
*&---------------------------------------------------------------------*
REPORT zbha_student_count.

START-OF-SELECTION.

  " Declare a variable to store the calculated total
  DATA: lv_total_students TYPE i.

  " Use Open SQL aggregate function to count lines directly in database
  SELECT COUNT(*) 
    FROM zbha_student 
    INTO lv_total_students.

  " Check system return code and output total summary count
  IF sy-subrc = 0.
    WRITE: / '========================================'.
    WRITE: / '      BHA STUDENT MANAGEMENT SYSTEM     '.
    WRITE: / '========================================'.
    WRITE: / 'Total Registered Students:', lv_total_students.
    WRITE: / '========================================'.
  ELSE.
    WRITE: / 'Error: Could not retrieve student database count.'.
  ENDIF.
