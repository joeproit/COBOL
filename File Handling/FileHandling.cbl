IDENTIFICATION DIVISION.
PROGRAM-ID. FileHandling.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT InputFile ASSIGN TO 'INPUT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL.
    SELECT OutputFile ASSIGN TO 'OUTPUT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD InputFile.
01 InputRecord PIC X(80).
FD OutputFile.
01 OutputRecord PIC X(80).

PROCEDURE DIVISION.
Begin.
    OPEN INPUT InputFile
    OPEN OUTPUT OutputFile

    PERFORM UNTIL END-OF-FILE
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

END-OF-FILE SECTION.
01 END-OF-FILE PIC X VALUE 'N'.
    
    END PROGRAM FileHandling.