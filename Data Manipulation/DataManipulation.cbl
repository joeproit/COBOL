IDENTIFICATION DIVISION.
PROGRAM-ID. DataManipulation.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ReceiptFile ASSIGN TO 'RECEIPT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FileStatus.

DATA DIVISION.
FILE SECTION.
FD ReceiptFile.
01 ReceiptRecord PIC X(80).

WORKING-STORAGE SECTION.
01 CustomerAccount.
   05 CustomerName PIC X(20) VALUE SPACES.
   05 AccountBalance PIC 9(7)V99 VALUE ZEROS.
01 DepositAmount PIC 9(7)V99 VALUE ZEROS.
01 UpdatedBalance PIC 9(7)V99 VALUE ZEROS.
01 UpdatedBalanceString PIC X(10) VALUE SPACES.
01 ReceiptString PIC X(80) VALUE SPACES.
01 WS-FileStatus PIC 9(2) VALUE ZEROS.

PROCEDURE DIVISION.
Begin.

    DISPLAY "Enter the customer name: "
    ACCEPT CustomerName
    IF FUNCTION NUMVAL-C(CustomerName) > 0
        DISPLAY "Error: Customer name cannot be a number. Please try again."
        STOP RUN
    END-IF.

    DISPLAY "Enter the current account balance: "
    ACCEPT AccountBalance
    IF FUNCTION NUMVAL-C(AccountBalance) = 0
        DISPLAY "Error: Invalid account balance. Please enter a number."
        STOP RUN
    END-IF.

    DISPLAY "Enter the deposit amount: "
    ACCEPT DepositAmount
    IF FUNCTION NUMVAL-C(DepositAmount) = 0
        DISPLAY "Error: Invalid deposit amount. Please enter a number."
        STOP RUN
    END-IF.

    * Arithmetic operations
    COMPUTE UpdatedBalance = AccountBalance + DepositAmount

    * Data conversion
    MOVE UpdatedBalance TO UpdatedBalanceString

    * String manipulation
    STRING "Customer: " CustomerName
           ", Deposit Amount: " DepositAmount
           ", New Balance: " UpdatedBalanceString
           INTO ReceiptString

    * Write the receipt to a file
    OPEN OUTPUT ReceiptFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to open RECEIPT.DAT. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    MOVE ReceiptString TO ReceiptRecord
    WRITE ReceiptRecord
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to write to RECEIPT.DAT. File Status: " WS-FileStatus
        CLOSE ReceiptFile
        STOP RUN
    END-IF.

    CLOSE ReceiptFile
    IF WS-FileStatus NOT EQUAL ZERO
        DISPLAY "Error: Unable to close RECEIPT.DAT. File Status: " WS-FileStatus
        STOP RUN
    END-IF.

    STOP RUN.
