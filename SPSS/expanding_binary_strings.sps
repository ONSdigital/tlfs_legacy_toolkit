* Encoding: windows-1252.

*******************************************************************************************************************************
**
**    EXPANDING BINARY STRING VARIABLES ON TLFS DATASETS
**
**    This guidance will enable SPSS data users to expand the binary string variables that
**    are provided on TLFS microdatasets.
**
*******************************************************************************************************************************.

**    In this code:
**
**    multi_code_variable_name is the name of the source variable that we will be using in the dataset.
**    It should be replaced by the name of the variable in the dataset that you are interested in
**    expanding.
**
**    The number of available response options is equal to the length of the binary string variable
((    (if the binary string variable has 5 characters, then 5 response options are available).
**
**    multi_code_variable_name1 is the variable derived from multi_code_variable_name that indicates whether
**    the first response option was selected.
**
**    multi_code_variable_name2 is the variable derived from multi_code_variable_name that indicates whether
**    the second response option was selected.
**
**    The chunks of code can be copied and updated to accommodate additional response options. To do this, copy
**    the code and apply the following updates:
**        
**    (1) Amend the variable suffix to reflect the response option number you are interested in (so if we were looking
**        at the 4th response option, after each COMPUTE statement we would replace multi_code_variable_name1 with
**        multi_code_variable_name4)
**
**    (2) Amend the second argument in the CHAR.SUBSTR function to reflect the number of the response option that you
**        are interested in:
**            DO IF CHAR.SUBSTR(multi_code_variable_name,1,1) = "1" becomes DO IF CHAR.SUBSTR(multi_code_variable_name,4,1) = "1"
**
**    (3) Update the text in quotation makrs for the variable labels to match the correct response option







MISSING VALUES multi_code_variable_name ().


***    Code to expand string for response option 1 (copy this chunk and apply the steps at the top of this document to add
***    further response options).

DO IF (multi_code_variable_name = "-10").
    COMPUTE multi_code_variable_name1 = 2.
ELSE IF (multi_code_variable_name = "-9").
    COMPUTE multi_code_variable_name1 = -9.
ELSE IF ((multi_code_variable_name = "-8") OR (multi_code_variable_name = "-7") OR (multi_code_variable_name = "-6")).
    COMPUTE multi_code_variable_name1 = -8.
ELSE.
    DO IF CHAR.SUBSTR(multi_code_variable_name,1,1) = "1".
        COMPUTE multi_code_variable_name1 = 1.
    ELSE IF CHAR.SUBSTR(multi_code_variable_name,1,1) = "0".
        COMPUTE multi_code_variable_name1 = 2.
    END IF.
END IF.

FORMAT multi_code_variable_name1 (F3).
VARIABLE LABELS
    multi_code_variable_name1 "Whether option 1 was selected for the multi_code_variable_name multi-code variable".
VALUE LABELS
    multi_code_variable_name1
        -9    "Not asked / routed"
        -8    "Skipped / missing"
        1    "Yes"
        2    "No".

FREQUENCIES multi_code_variable_name1.





***    Code to expand string for response option 2.

DO IF (multi_code_variable_name = "-10").
    COMPUTE multi_code_variable_name2 = 2.
ELSE IF (multi_code_variable_name = "-9").
    COMPUTE multi_code_variable_name2 = -9.
ELSE IF ((multi_code_variable_name = "-8") OR (multi_code_variable_name = "-7") OR (multi_code_variable_name = "-6")).
    COMPUTE multi_code_variable_name2 = -8.
ELSE.
    DO IF CHAR.SUBSTR(multi_code_variable_name,2,1) = "1".
        COMPUTE multi_code_variable_name2 = 1.
    ELSE IF CHAR.SUBSTR(multi_code_variable_name,2,1) = "0".
        COMPUTE multi_code_variable_name2 = 2.
    END IF.
END IF.

FORMAT multi_code_variable_name2 (F3).
VARIABLE LABELS
    multi_code_variable_name2 "Whether option 2 was selected for the multi_code_variable_name multi-code variable".
VALUE LABELS
    multi_code_variable_name2
        -9    "Not asked / routed"
        -8    "Skipped / missing"
        1    "Yes"
        2    "No".

FREQUENCIES multi_code_variable_name2.
