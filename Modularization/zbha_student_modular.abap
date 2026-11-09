*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_MODULAR
*&---------------------------------------------------------------------*
*& Modular Programming Implementation using Subroutines (FORMs)
*&---------------------------------------------------------------------*
REPORT zbha_student_modular.

DATA:
  gt_students TYPE STANDARD TABLE OF zbha_student WITH DEFAULT KEY,
  gs_student  TYPE zbha_student.

START-OF-SELECTION.

  PERFORM get_students.
  PERFORM display_students.
  PERFORM display_total.

*--------------------------------------------------*
* FORM 1: Retrieve student records
*--------------------------------------------------*
FORM get_students.
  SELECT *
    FROM zbha_student
    INTO TABLE gt_students.
ENDFORM.

*--------------------------------------------------*
* FORM 2: Display student records
*--------------------------------------------------*
FORM display_students.
  IF gt_students IS INITIAL.
    WRITE: / 'No student records found in ZBHA_STUDENT.'.
  ELSE.
    ULINE.
    WRITE: / 'BHA STUDENT MANAGEMENT SYSTEM - MODULAR REPORT'.
    ULINE.

    LOOP AT gt_students INTO gs_student.
      WRITE: / 'Student ID   :', gs_student-student_id.
      WRITE: / 'Student Name :', gs_student-student_name.
      WRITE: / 'Student Marks:', gs_student-student_marks.
      ULINE.
    ENDLOOP.
  ENDIF.
ENDFORM.

*--------------------------------------------------*
* FORM 3: Display total student count
*--------------------------------------------------*
FORM display_total.
  WRITE: / 'Total Students:', lines( gt_students ).
ENDFORM.
