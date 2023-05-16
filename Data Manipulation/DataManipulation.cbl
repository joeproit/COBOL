IDENTIFICATION DIVISION.
PROGRAM-ID. DataManipulation.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ReceiptFile ASSIGN TO 'RECEIPT.DAT'
           ORGANIZATION IS LINE SEQUENTIAL.

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
01 ReceiptString PIC X(80) VALUE SPACES.

PROCEDURE DIVISION.
Begin.

    DISPLAY "Enter the customer name: "
    ACCEPT CustomerName.

    DISPLAY "Enter the current account balance: "
    ACCEPT AccountBalance.

    DISPLAY "Enter the deposit amount: "
    ACCEPT DepositAmount.

    * Arithmetic operations
    COMPUTE UpdatedBalance = AccountBalance + DepositAmount

    * String manipulation
    STRING "Customer: " CustomerName
           ", Deposit Amount: " DepositAmount
           ", New Balance: " INTO ReceiptString

    * Data conversion
    * TO-DO: Convert the updated balance to a string and include it in the receipt string

    * Write the receipt to a file
    OPEN OUTPUT ReceiptFile
    MOVE ReceiptString TO ReceiptRecord
    WRITE ReceiptRecord
    CLOSE ReceiptFile

    STOP RUN.
