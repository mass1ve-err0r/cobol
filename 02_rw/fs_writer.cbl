      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  fs_writer
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> WRITE BINARY DATA TO A FIXED OUTPUT FILE
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FSWriter.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-FILE ASSIGN TO "output.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  OUTPUT-FILE.
       01  OUTPUT-RECORD    PIC X(80).

       LINKAGE SECTION.
       01  STRING-TO-WRITE  PIC X(80).

       PROCEDURE DIVISION USING STRING-TO-WRITE.
           OPEN OUTPUT OUTPUT-FILE
           MOVE STRING-TO-WRITE TO OUTPUT-RECORD
           WRITE OUTPUT-RECORD
           CLOSE OUTPUT-FILE
           EXIT PROGRAM.
