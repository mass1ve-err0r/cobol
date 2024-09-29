      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  write_to_fs_from_stdin
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> WRITE DATA ENTERED ON THE TERMINAL TO A FILE
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. WriteToFSFromSTDIN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  USER-INPUT       PIC X(80).

       PROCEDURE DIVISION.
           CALL 'UserInputHandler'
           USING USER-INPUT

           CALL 'FSWriter'
           USING USER-INPUT

           DISPLAY "Written to output.txt"
           STOP RUN.
