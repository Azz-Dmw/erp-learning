DATABASE ds

MAIN
    DEFINE v_date LIKE aaa_file.aaa06
    DEFINE company STRING 
    DEFINE i,j,k char(20)
    DEFINE salary INTEGER
    
    
    LET i = "TIPTOP GP"
    LET j = "Genero BDL123456"
    LET company = "DC","MS"
    LET k = j[1,6]
    LET salary = 1000 
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
    DISPLAY "k:",k
    DISPLAY "薪水：",salary USING "$#,###"
    
END MAIN



--数据库连接成功，读取到：09/12/10
--company:DCMS
--i||jTIPTOP GP           Genero BDL123456    
--i||k
--i,k:TIPTOP GP 





