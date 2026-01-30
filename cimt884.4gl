DATABASE ds

GLOBALS
    DEFINE g_employee char(20) --GLOBAL 变数
    --为所 link 使用的 MODULE 的共享变量
END GLOBALS 
    DEFINE g_employee char(10)
    DEFINE g_tty char(32)--MODULE 变数

MAIN
    DEFINE v_date LIKE aaa_file.aaa06
    DEFINE company STRING 
    DEFINE i,j,k char(20)
    DEFINE salary,salary1,salary2 INTEGER
    DEFINE g char(20)
    DEFINE f STRING 
    DEFINE h char(20)
    DEFINE answer CHAR(1) --LOCAL变数
    
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
    LET g_employee = "ERP"
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
    DISPLAY "变量i和j拼接=",i,8 SPACES,g CLIPPED  
    DISPLAY "系统:",g_employee
    
END MAIN

FUNCTION ins_employee()
    DEFINE flag char(1), --LOCAL变数
    change SMALLINT --LOCAL变数
END FUNCTION 









