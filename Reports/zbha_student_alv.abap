*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_ALV
*&---------------------------------------------------------------------*
*& Display Student Records using ALV Grid Report
*&---------------------------------------------------------------------*
REPORT zbha_student_alv.

START-OF-SELECTION.

  " Declare an internal table and work area to store all student data rows
  DATA: it_student TYPE TABLE OF zbha_student,
        wa_student TYPE zbha_student.

  " Fetch all student entries from custom database table
  SELECT * 
    FROM zbha_student 
    INTO TABLE it_student.

  " Verify if there is any data to show in list report
  IF it_student IS NOT INITIAL.
    " Use standard SAP reuse function module to display data grid
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_structure_name = 'ZBHA_STUDENT'
      TABLES
        t_outtab         = it_student
      EXCEPTIONS
        program_error    = 1
        OTHERS           = 2.

    IF sy-subrc <> 0.
      WRITE: / 'Error: Unable to generate ALV report grid layout.'.
    ENDIF.
  ELSE.
    WRITE: / 'Information: The ZBHA_STUDENT database table is currently empty.'.
    WRITE: / 'Please insert some student records first using ZBHA_STUDENT_INSERT.'.
  ENDIF.
