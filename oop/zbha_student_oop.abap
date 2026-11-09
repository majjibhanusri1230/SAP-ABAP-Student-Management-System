*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_OOP
*&---------------------------------------------------------------------*
*& Object-Oriented ABAP (OOP) Implementation for Student Management
*&---------------------------------------------------------------------*
REPORT zbha_student_oop.

*----------------------------------------------------------------------*
* CLASS lcl_student_manager DEFINITION (Blueprint)
*----------------------------------------------------------------------*
CLASS lcl_student_manager DEFINITION.
  PUBLIC SECTION.
    " Method declaration to read and display a student record by ID
    METHODS: display_student_info IMPORTING iv_id TYPE zbhade_stid.
ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_student_manager IMPLEMENTATION (Actual Execution Logic)
*----------------------------------------------------------------------*
CLASS lcl_student_manager IMPLEMENTATION.
  METHOD display_student_info.
    DATA: wa_student TYPE zbha_student.

    " Database selection inside an OOP Method
    SELECT SINGLE * 
      FROM zbha_student 
      INTO wa_student 
     WHERE student_id = iv_id.

    IF sy-subrc = 0.
      WRITE: / '--- OOP Fetch: Student Information ---'.
      WRITE: / 'ID   :', wa_student-student_id.
      WRITE: / 'Name :', wa_student-student_name.
      WRITE: / 'Marks:', wa_student-student_marks.
    ELSE.
      WRITE: / 'OOP Error: Student record not found for ID:', iv_id.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------*
* Selection Screen Fields
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_id TYPE zbhade_stid OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Application Runtime Engine Events
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Object variables declaration
  DATA: lo_manager TYPE REF TO lcl_student_manager.

  " Instantiate the ABAP Class Object
  CREATE OBJECT lo_manager.

  " Trigger OOP logic by calling method
  lo_manager->display_student_info( iv_id = p_id ).
