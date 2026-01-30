DATABASE ds

MAIN
    DEFINE v_date LIKE aaa_file.aaa06
    DEFINE company STRING 
    DEFINE i,j,k char(20)

    LET i = "TIPTOP GP"
    LET j = "Genero BDL123456"
    LET company = "DC","MS"
    SELECT aaa06
        INTO v_date
        FROM aaa_file
        WHERE aaa06 IS NOT NULL
          AND ROWNUM = 1

    DISPLAY "数据库连接成功，读取到：", v_date
    DISPLAY "company:",company
    DISPLAY "i||j:",i||j
    DISPLAY "i||k:",i||k
    DISPLAY "i,k:",i,k
    DISPLAY "这是我的修改"
    
END MAIN



--数据库连接成功，读取到：09/12/10
--company:DCMS
--i||jTIPTOP GP           Genero BDL123456    
--i||k
--i,k:TIPTOP GP 





