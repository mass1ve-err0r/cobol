      *> ***************************************************************
      *> (C) COPYRIGHT Baig Software 2024. ALL RIGHTS RESERVED
      *> ***************************************************************
      *> PROGRAM:  cxx
      *>
      *> AUTHOR :  Saadat Baig
      *>
      *> A (PROTOTYPE) xxd CLONE
      *> ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CXX.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILE-IN ASSIGN TO WS-FILENAME
           ORGANIZATION IS BINARY SEQUENTIAL
           FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  FILE-IN.
       01  FILE-IN-REC PIC X(16).

       WORKING-STORAGE SECTION.
       01  WS-FILE-PATH       PIC X(1024).
       01  WS-FILENAME        PIC X(255) VALUE SPACES.
       01  WS-FILE-STATUS     PIC XX VALUE SPACES.
       01  WS-OFFSET          PIC 9(8) VALUE 0.
       01  WS-HEX-STRING      PIC X(48) VALUE SPACES.
       01  WS-ASCIILINE       PIC X(16) VALUE SPACES.
       01  WS-EOF-FLAG        PIC X VALUE 'N'.
       01  WS-BYTE            PIC X VALUE SPACES.
       01  WS-POSITION        PIC 9(2) VALUE 0.
       01  WS-HEX-CHARS       PIC XX VALUE SPACES.
       01  WS-NIBBLE          PIC 9(3) VALUE 0.
       01  WS-TMP1            PIC 9(3) VALUE 0.

       01  WS-DECIMAL         PIC 9(3) VALUE 0.
       01  WS-TEMP-CHAR       PIC X VALUE SPACES.
       01  WS-INDEX           PIC 9(1) VALUE 8.
       01  HEX-TABLE          PIC X(16) VALUE "0123456789ABCDEF".
       01  WS-RESULT          PIC X(2) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           ACCEPT WS-FILE-PATH FROM COMMAND-LINE

           IF WS-FILE-PATH = SPACES
             DISPLAY "Usage: cxx <abs_path_to_binary>"
             STOP RUN
           END-IF

           MOVE WS-FILE-PATH TO WS-FILENAME

           OPEN INPUT FILE-IN
           IF WS-FILE-STATUS NOT = "00"
               DISPLAY "Error: Could not open file " WS-FILENAME " with status " WS-FILE-STATUS
               STOP RUN
           END-IF

           PERFORM UNTIL WS-EOF-FLAG = 'Y'
               READ FILE-IN INTO FILE-IN-REC
                   AT END
                       MOVE "Y" TO WS-EOF-FLAG
                   NOT AT END
                       PERFORM PRINT-HEX-LINE
               END-READ
           END-PERFORM

           CLOSE FILE-IN
           STOP RUN.

       PRINT-HEX-LINE.
           MOVE SPACES TO WS-HEX-STRING
           MOVE SPACES TO WS-ASCIILINE

           *> ChatGPT gave me this bruh as routine, oh lord
           PERFORM VARYING WS-POSITION FROM 1 BY 1 UNTIL WS-POSITION > 16
               IF FILE-IN-REC(WS-POSITION:1) NOT EQUAL LOW-VALUE
                   MOVE FILE-IN-REC(WS-POSITION:1) TO WS-BYTE
                   PERFORM CONVERT-BYTE-TO-HEX

                   MOVE WS-RESULT TO WS-HEX-STRING((WS-POSITION - 1) * 3 + 1:2)

                   COMPUTE WS-TMP1 = FUNCTION MOD(WS-POSITION 2)

                   IF WS-TMP1 = 0
                       MOVE " " TO WS-HEX-STRING(WS-POSITION * 3:1)
                   END-IF

                   IF FUNCTION ORD(WS-BYTE) >= 32 AND FUNCTION ORD(WS-BYTE) <= 126
                       MOVE WS-BYTE TO WS-ASCIILINE(WS-POSITION:1)
                   ELSE
                       MOVE "." TO WS-ASCIILINE(WS-POSITION:1)
                   END-IF
               ELSE
                   MOVE "  " TO WS-HEX-STRING((WS-POSITION - 1) * 3 + 1:2)
                   MOVE "." TO WS-ASCIILINE(WS-POSITION:1)
               END-IF
           END-PERFORM

           DISPLAY FUNCTION NUMVAL-C(WS-OFFSET) "  " WS-HEX-STRING " " WS-ASCIILINE
           ADD 16 TO WS-OFFSET.

       CONVERT-BYTE-TO-HEX.
           MOVE FUNCTION ORD(WS-BYTE) TO WS-DECIMAL
           MOVE SPACES TO WS-RESULT
           MOVE 2 TO WS-INDEX

           PERFORM UNTIL WS-DECIMAL = 0
               COMPUTE WS-NIBBLE = FUNCTION MOD(WS-DECIMAL 16)
               MOVE HEX-TABLE(WS-NIBBLE + 1:1) TO WS-TEMP-CHAR
               MOVE WS-TEMP-CHAR TO WS-RESULT(WS-INDEX:1)
               SUBTRACT 1 FROM WS-INDEX
               DIVIDE WS-DECIMAL BY 16 GIVING WS-DECIMAL
           END-PERFORM

           IF WS-RESULT(1:1) = SPACE
               MOVE "0" TO WS-RESULT(1:1)
           END-IF.

       END PROGRAM XXDCLONE.
