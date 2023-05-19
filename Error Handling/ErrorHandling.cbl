IDENTIFICATION DIVISION.
PROGRAM-ID. ErrorHandling.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT MyFile ASSIGN TO "nonexistentfile.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FileStatus.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-FileStatus PIC 9(2) VALUE ZEROS.

PROCEDURE DIVISION.
Begin.
    OPEN INPUT MyFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to open file. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    READ MyFile
    AT END
        DISPLAY "Error: Unexpected end of file. File Status: " WS-FileStatus
    NOT AT END
        DISPLAY "File read successfully."
    END-READ

    CLOSE MyFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to close file. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    STOP RUN.
END PROGRAM ErrorHandling.
