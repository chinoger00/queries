/*
    QUERY THE TABLE COLUMNS NAME AND DATA TYPE
*/

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TABLE_NAME'