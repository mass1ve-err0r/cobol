      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  macho_reader
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> READS THE MACH-O BINARY AND RETURNS THE VALUE FOR THE FIELD
      *> NCMDS
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MachOReader.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BINARY-FILE ASSIGN TO DYNAMIC-FILE.

       DATA DIVISION.
       FILE SECTION.
       FD BINARY-FILE.
       01 BINARY-RECORD.
           05 MACHO-MAGIC       PIC X(4).
           05 CPU-TYPE          PIC X(4).
           05 CPU-SUBTYPE       PIC X(4).
           05 FILE-TYPE         PIC X(4).
           05 N-CMDS            PIC 9(8) COMP-5.
           05 SIZE-CMDS         PIC X(4).
           05 FLAGS             PIC X(4).

       WORKING-STORAGE SECTION.
       01 FILE-PATH PIC X(1024).
       01 WS-FILE-STATUS PIC XX VALUE SPACES.
       01 WS-END-OF-FILE PIC X VALUE 'N'.
       01 DYNAMIC-FILE PIC X(255).

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           ACCEPT FILE-PATH FROM COMMAND-LINE

           IF FILE-PATH = SPACES
               DISPLAY "Usage: macho_reader <abs_path_to_dylib>"
               STOP RUN
           END-IF

           MOVE FILE-PATH TO DYNAMIC-FILE

           OPEN INPUT BINARY-FILE

           IF WS-FILE-STATUS = "35"
               DISPLAY "Error: File does not exist or cannot be opened!"
               STOP RUN
           END-IF

           READ BINARY-FILE
               AT END
                   MOVE "Y" TO WS-END-OF-FILE
           END-READ

           IF WS-END-OF-FILE = "N"
               DISPLAY "Number of commands: " N-CMDS
           ELSE
               DISPLAY "Error reading file or file is empty"
           END-IF

           CLOSE BINARY-FILE
           STOP RUN.
