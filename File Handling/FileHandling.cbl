IDENTIFICATION DIVISION.
PROGRAM-ID. FileHandling.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT InputFile ASSIGN TO 'INPUT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-InputStatus.
    SELECT OutputFile ASSIGN TO 'OUTPUT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-OutputStatus.

DATA DIVISION.
FILE SECTION.
FD InputFile.
01 InputRecord PIC X(80).
FD OutputFile.
01 OutputRecord PIC X(80).

WORKING-STORAGE SECTION.
01 WS-InputStatus PIC 9(2) VALUE ZEROS.
01 WS-OutputStatus PIC 9(2) VALUE ZEROS.
01 END-OF-FILE PIC X VALUE 'N'.

PROCEDURE DIVISION.
Begin.
    OPEN INPUT InputFile
    IF WS-InputStatus NOT EQUAL ZERO
        DISPLAY 'Error opening INPUT.DAT. File Status: ' WS-InputStatus
        STOP RUN
    END-IF

    OPEN OUTPUT OutputFile
    IF WS-OutputStatus NOT EQUAL ZERO
        DISPLAY 'Error opening OUTPUT.DAT. File Status: ' WS-OutputStatus
        STOP RUN
    END-IF

    PERFORM UNTIL END-OF-FILE = 'Y'
        READ InputFile
            AT END SET END-OF-FILE TO TRUE
            NOT AT END
                MOVE InputRecord TO OutputRecord
                WRITE OutputRecord
                DISPLAY OutputRecord
        END-READ
    END-PERFORM

    CLOSE InputFile
    CLOSE OutputFile

    STOP RUN.
