IDENTIFICATION DIVISION.
PROGRAM-ID. DBIntegration.

ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-EMPLOYEE-NAME                 PIC X(30).
01  WS-EMPLOYEE-ID                   PIC 9(10).

EXEC SQL INCLUDE SQLCA END-EXEC.    /* Include SQL Communications */

PROCEDURE DIVISION.
MAIN-PARAGRAPH.
    EXEC SQL
        CONNECT TO MYDB
    END-EXEC

    IF SQLCODE NOT EQUAL ZERO
        DISPLAY "Failed to connect to the database"
        STOP RUN
    END-IF

    EXEC SQL
        DECLARE C1 CURSOR FOR
        SELECT EMPLOYEE_ID, EMPLOYEE_NAME FROM EMPLOYEE
    END-EXEC

    EXEC SQL
        OPEN C1
    END-EXEC

    PERFORM UNTIL SQLCODE NOT EQUAL ZERO
        EXEC SQL
            FETCH NEXT FROM C1
            INTO :WS-EMPLOYEE-ID, :WS-EMPLOYEE-NAME
        END-EXEC

        IF SQLCODE EQUAL ZERO
            DISPLAY WS-EMPLOYEE-ID " " WS-EMPLOYEE-NAME
        END-IF
    END-PERFORM

    EXEC SQL
        CLOSE C1
    END-EXEC

    EXEC SQL
        DISCONNECT MYDB
    END-EXEC.

    STOP RUN.
END PROGRAM DBIntegration.
