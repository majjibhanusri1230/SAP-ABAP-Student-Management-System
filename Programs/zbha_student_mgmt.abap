*&---------------------------------------------------------------------*
*& Report ZBHA_STUDENT_MGMT
*&---------------------------------------------------------------------*
*& Master Dashboard / Main Menu for BHA Student Management System
*&---------------------------------------------------------------------*
REPORT zbha_student_mgmt.

*----------------------------------------------------------------------*
* Selection Screen Layout: Radio Button Menu Dashboard
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: r_ins RADIOBUTTON GROUP g1 DEFAULT 'X',
            r_src RADIOBUTTON GROUP g1,
            r_upd RADIOBUTTON GROUP g1,
            r_del RADIOBUTTON GROUP g1,
            r_alv RADIOBUTTON GROUP g1,
            r_cnt RADIOBUTTON GROUP g1,
            r_oop RADIOBUTTON GROUP g1,
            r_val RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Runtime Event: Trigger Selection Actions
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
  ENDCASE.
