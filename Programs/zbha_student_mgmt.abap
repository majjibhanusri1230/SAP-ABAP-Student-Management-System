*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_MGMT
*&---------------------------------------------------------------------*
*& Master Dashboard & Central Execution Panel
*& Allows launching all 10 modules from a single unified selection screen
*&---------------------------------------------------------------------*
REPORT zbha_student_mgmt.

*----------------------------------------------------------------------*
* Selection Screen Layout: Radio Button Menu Dashboard
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: r_ins  RADIOBUTTON GROUP g1 DEFAULT 'X', " Insert Student Record
              r_src  RADIOBUTTON GROUP g1,             " Search Student Record
              r_upd  RADIOBUTTON GROUP g1,             " Update Student Record
              r_del  RADIOBUTTON GROUP g1,             " Delete Student Record
              r_alv  RADIOBUTTON GROUP g1,             " View All Students (ALV Report)
              r_cnt  RADIOBUTTON GROUP g1,             " Total Registered Students Count
              r_oop  RADIOBUTTON GROUP g1,             " Student Details (OOABAP)
              r_val  RADIOBUTTON GROUP g1,             " Validate Student Marks
              r_enr  RADIOBUTTON GROUP g1,             " Enroll Student in Course
              r_join RADIOBUTTON GROUP g1.             " Student & Course Report (Inner Join)
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Runtime Event: Trigger Module Actions via SUBMIT ... AND RETURN
*----------------------------------------------------------------------*
START-OF-SELECTION.

  CASE 'X'.
    WHEN r_ins.
      SUBMIT zbha_student_insert VIA SELECTION-SCREEN AND RETURN.
    WHEN r_src.
      SUBMIT zbha_student_search VIA SELECTION-SCREEN AND RETURN.
    WHEN r_upd.
      SUBMIT zbha_student_update VIA SELECTION-SCREEN AND RETURN.
    WHEN r_del.
      SUBMIT zbha_student_delete VIA SELECTION-SCREEN AND RETURN.
    WHEN r_alv.
      SUBMIT zbha_student_alv AND RETURN.
    WHEN r_cnt.
      SUBMIT zbha_student_count AND RETURN.
    WHEN r_oop.
      SUBMIT zbha_student_oop VIA SELECTION-SCREEN AND RETURN.
    WHEN r_val.
      SUBMIT zbha_student_validate VIA SELECTION-SCREEN AND RETURN.
    WHEN r_enr.
      SUBMIT zbha_enroll_add VIA SELECTION-SCREEN AND RETURN.
    WHEN r_join.
      SUBMIT zbha_student_join_alv AND RETURN.
  ENDCASE.
