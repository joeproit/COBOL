IDENTIFICATION DIVISION.
PROGRAM-ID. BatchProcessing.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT SalesFile ASSIGN TO "SALES.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS WS-FileStatus.
           
DATA DIVISION.
FILE SECTION.
FD SalesFile.
01 SalesRecord.
   05 SaleID PIC 9(5).
   05 SaleDate PIC X(10).
   05 ProductID PIC X(10).
   05 Quantity PIC 9(3).
   05 SalePrice PIC 9(7)V99.

WORKING-STORAGE SECTION.
01 WS-FileStatus PIC 9(2) VALUE ZEROS.
01 WS-EndOfFile PIC X VALUE "N".
01 TotalSales PIC 9(9)V99 VALUE ZEROS.
01 TotalQuantity PIC 9(6) VALUE ZEROS.

PROCEDURE DIVISION.
Begin.

    OPEN INPUT SalesFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to open SALES.DAT. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    READ SalesFile
        AT END SET WS-EndOfFile TO "Y"
        NOT AT END DISPLAY SalesRecord
    END-READ.

    PERFORM UNTIL WS-EndOfFile = "Y"
        COMPUTE TotalSales = TotalSales + (Quantity * SalePrice)
        ADD Quantity TO TotalQuantity

        READ SalesFile
            AT END SET WS-EndOfFile TO "Y"
            NOT AT END DISPLAY SalesRecord
        END-READ
    END-PERFORM.

    DISPLAY "Total Sales: " TotalSales
    DISPLAY "Total Quantity: " TotalQuantity

    CLOSE SalesFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to close SALES.DAT. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    STOP RUN.

END PROGRAM BatchProcessing.
