      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  dec2hex
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> CONVERTS A DECIMAL TO A HEXADECIMAL
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DEC2HEX.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-DECIMAL          PIC 9(8) VALUE 0.
       01  WS-REMAINDER        PIC 9(2) VALUE 0.
       01  WS-RESULT           PIC X(8) VALUE SPACES.
       01  WS-INDEX            PIC 9(1) VALUE 8.
       01  HEX-TABLE           PIC X(16) VALUE "0123456789ABCDEF".
       01  WS-TEMP-CHAR        PIC X VALUE SPACES.
       01  WS-START-INDEX      PIC 9(1) VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter a decimal number: " WITH NO ADVANCING
           ACCEPT WS-DECIMAL

           IF WS-DECIMAL = 0
               MOVE "0" TO WS-RESULT(8:1)
           ELSE
               PERFORM UNTIL WS-DECIMAL = 0
                   COMPUTE WS-REMAINDER = FUNCTION MOD(WS-DECIMAL 16)
                   MOVE HEX-TABLE(WS-REMAINDER + 1:1) TO WS-TEMP-CHAR
                   MOVE WS-TEMP-CHAR TO WS-RESULT(WS-INDEX:1)
                   SUBTRACT 1 FROM WS-INDEX
                   DIVIDE WS-DECIMAL BY 16 GIVING WS-DECIMAL
               END-PERFORM
           END-IF

           INSPECT WS-RESULT TALLYING WS-START-INDEX FOR LEADING SPACES
           ADD 1 TO WS-START-INDEX

           DISPLAY "Hexadecimal Representation: " WS-RESULT(WS-START-INDEX:8 - WS-START-INDEX + 1)

           STOP RUN.
