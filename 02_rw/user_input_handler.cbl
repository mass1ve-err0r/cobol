      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  user_input_handler
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> HANDLE USER INPUT FROM STDIN
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UserInputHandler.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  USER-INPUT       PIC X(80).

       LINKAGE SECTION.
       01  PASSED-INPUT     PIC X(80).

       PROCEDURE DIVISION USING PASSED-INPUT.
           DISPLAY "Content:" WITH NO ADVANCING
           ACCEPT USER-INPUT
           MOVE USER-INPUT TO PASSED-INPUT
           EXIT PROGRAM.
