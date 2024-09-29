      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  simd_caller
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> CALL A C-FUNCTION FROM A DYNAMIC LIBRARY TO PERFORM
      *> SIMD-ASSISTED SUMMARIZATION
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SIMDCaller.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  USER-INPUT-COUNT    PIC 9(4) COMP-5 VALUE 0.
       01  MAX-INTEGERS        PIC 9(4) COMP-5 VALUE 1024.

       01  USER-INTEGERS.
           05  USER-INTEGER    PIC S9(9) COMP-5 OCCURS 1024 TIMES.

       01  TOTAL-SUM           PIC S9(9) COMP-5 VALUE 0.
       01  I                   PIC 9(4) COMP-5 VALUE 1.
       01  DIVISION-RESULT     PIC 9(4) COMP-5 VALUE 0.
       01  MULTIPLE-OF-8       PIC 9(4) COMP-5 VALUE 0.

       01  C-LENGTH            PIC S9(9) COMP-5.
       01  C-TOTAL-SUM         PIC S9(9) COMP-5.

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.
           DISPLAY "Enter number of integers you will supply (must be a multiple of 8):"
           ACCEPT USER-INPUT-COUNT

           DIVIDE USER-INPUT-COUNT BY 8 GIVING DIVISION-RESULT REMAINDER MULTIPLE-OF-8

           IF MULTIPLE-OF-8 NOT = 0
               DISPLAY "Error: Number of integers must be a multiple of 8."
               STOP RUN
           END-IF

           IF USER-INPUT-COUNT > MAX-INTEGERS
               DISPLAY "Error: The count exceeds the maximum allowed (1024)."
               STOP RUN
           END-IF

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > USER-INPUT-COUNT
               DISPLAY "Enter at integer " I " :"
               ACCEPT USER-INTEGER(I)
           END-PERFORM

           MOVE USER-INPUT-COUNT TO C-LENGTH

           *> Debugging statements to check values before the call
           DISPLAY "Debug: user-input-count: " USER-INPUT-COUNT
           DISPLAY "Debug: c-length: " C-LENGTH

           CALL "sum_ints_simd8" USING BY REFERENCE USER-INTEGERS
                                  BY VALUE C-LENGTH
                                  RETURNING C-TOTAL-SUM

           MOVE C-TOTAL-SUM TO TOTAL-SUM
           DISPLAY "Result: " TOTAL-SUM

           STOP RUN.
