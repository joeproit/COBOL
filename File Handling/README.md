
1. The file declarations are defined correctly, including the file status variables `WS-InputStatus` and `WS-OutputStatus`.

2. The input file (`INPUT.DAT`) and output file (`OUTPUT.DAT`) are opened for reading and writing, respectively. The code checks the file status after each `OPEN` operation.

3. The code enters a `PERFORM UNTIL` loop until the end of the input file is reached.

4. Within the loop, the code reads a record from the input file. If there is an error reading the record, the code displays an error message, closes both input and output files, and stops the program.

5. If the record is successfully read, it is moved to the output record and written to the output file. The code checks the file status after each `WRITE` operation.

6. The output record is displayed to the console.

7. After the loop finishes, both the input and output files are closed. The file status is checked after each `CLOSE` operation.

8. Finally, the program is stopped.
