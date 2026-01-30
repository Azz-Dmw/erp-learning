DATABASE ds

MAIN
    DEFINE v_date LIKE aaa_file.aaa06
    DEFINE company STRING 
    DEFINE i,j,k char(20)
    DEFINE salary,salary1,salary2 INTEGER
    DEFINE g char(20)
    DEFINE f STRING 
    DEFINE h char(20)
    
    LET i = "TIPTOP GP"
    LET j = "Genero BDL123456"
    LET company = "DC","MS"
    LET k = j[1,6]
    LET salary = 1000 
    LET salary1 = -1000 
    LET salary2 = 1000 
    LET g = "TIPTOP GP                "
    LET f = "      TIPTOP GP          "
    LET h = "Genero BDL"
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
    DISPLAY salary1 USING "--,---"
    DISPLAY salary2 USING "++,+++"
    DISPLAY "日期：",TODAY USING "yyyy-mm-dd"
    DISPLAY "变量g和j拼接并且消除空白:",g CLIPPED,j
    DISPLAY "变量f和h拼接=",f.trim(),h,"123"
    
END MAIN



--数据库连接成功，读取到：09/12/10
--company:DCMS
--i||jTIPTOP GP           Genero BDL123456    
--i||k
--i,k:TIPTOP GP 





