# Reports Directory

This directory contains reporting programs for the **BHA Student Management & Course Enrollment System**:

- `zbha_student_alv.abap`: Uses standard SAP reuse function module `REUSE_ALV_GRID_DISPLAY` to present all student records from `ZBHA_STUDENT` in an interactive ALV spreadsheet grid.
- `zbha_student_join_alv.abap`: Multi-table relational ALV report using Open SQL `INNER JOIN` between `ZBHA_STUDENT` and `ZBHA_ENROLLMENT` with a dynamic field catalog (`slis_t_fieldcat_alv`).
