IDENTIFICATION DIVISION.
PROGRAM-ID. BatchProcessing.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT SalesFile ASSIGN TO "SALES.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS WS-FileStatus-Code.
           
DATA DIVISION.
FILE SECTION.
FD SalesFile.
01 SalesRecord PIC X(32).
   05 SaleID PIC 9(5).
   05 SaleDate PIC X(10).
   05 ProductID PIC X(10).
   05 Quantity PIC 9(3).
   05 SalePrice PIC 9(7)V99.

WORKING-STORAGE SECTION.
01 WS-FileStatus-Code PIC 9(2) VALUE ZEROS.
01 WS-EndOfFile PIC X VALUE "N".
01 TotalSales PIC 9(9)V99 VALUE ZEROS.
01 TotalQuantity PIC 9(6) VALUE ZEROS.

01 BlockSalesRecordTable.
   05 BlockSalesRecord OCCURS 100 TIMES.
      10 BlockSaleID PIC 9(5).
      10 BlockSaleDate PIC X(10).
      10 BlockProductID PIC X(10).
      10 BlockQuantity PIC 9(3).
      10 BlockSalePrice PIC 9(7)V99.

PROCEDURE DIVISION.
Begin.
    OPEN INPUT SalesFile
    IF WS-FileStatus-Code NOT EQUAL ZERO
        DISPLAY "Error: Unable to open SALES.DAT. File Status: " WS-FileStatus-Code
        STOP RUN
    END-IF.

    READ SalesFile INTO BlockSalesRecordTable
        AT END SET WS-EndOfFile TO "Y"
        NOT AT END PERFORM DISPLAY-BLOCK-RECORDS
    END-READ.

    PERFORM UNTIL WS-EndOfFile = "Y"
        PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
            COMPUTE TotalSales = TotalSales + (BlockQuantity(WS-INDEX) * BlockSalePrice(WS-INDEX))
            ADD BlockQuantity(WS-INDEX) TO TotalQuantity
        END-PERFORM

        READ SalesFile INTO BlockSalesRecordTable
            AT END SET WS-EndOfFile TO "Y"
            NOT AT END PERFORM DISPLAY-BLOCK-RECORDS
        END-READ
    END-PERFORM.

    DISPLAY "Total Sales: " TotalSales
    DISPLAY "Total Quantity: " TotalQuantity

    CLOSE SalesFile
    IF WS-FileStatus-Code NOT EQUAL ZERO
        DISPLAY "Error: Unable to close SALES.DAT. File Status: " WS-FileStatus-Code
        STOP RUN
    END-IF.

    STOP RUN.

DISPLAY-BLOCK-RECORDS.
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
        DISPLAY BlockSalesRecord(WS-INDEX:32)
    END-PERFORM.

END PROGRAM BatchProcessing.
