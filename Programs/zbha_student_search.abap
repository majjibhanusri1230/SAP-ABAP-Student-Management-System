*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_SEARCH
*&---------------------------------------------------------------------*
*& Search Student Records by ID from ZBHA_STUDENT table
*&---------------------------------------------------------------------*
REPORT zbha_student_search.

* Selection screen to search by Student ID
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id TYPE zbhade_stid OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  " Declare work area for data retrieval
  DATA: wa_student TYPE zbha_student.

  " Fetch matching record from custom table
  SELECT SINGLE * 
    FROM zbha_student 
    INTO wa_student 
   WHERE student_id = p_id.

  " Output the retrieved information
  IF sy-subrc = 0.
    WRITE: / '--- Student Record Found ---'.
    WRITE: / 'Student ID  :', wa_student-student_id.
    WRITE: / 'Student Name:', wa_student-student_name.
    WRITE: / 'Total Marks :', wa_student-student_marks.
  ELSE.
    WRITE: / 'Error: No record found for Student ID:', p_id.
  ENDIF.
