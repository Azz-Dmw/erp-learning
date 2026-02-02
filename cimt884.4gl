DATABASE ds

GLOBALS
    DEFINE g_employee char(20) --GLOBAL 变数 全局变量
    --为所 link 使用的 MODULE 的共享变量
END GLOBALS 

    --DEFINE g_employee char(10)
    DEFINE g_tty char(32)--MODULE 变数 整个模块都能用

MAIN
    DEFINE v_date LIKE aaa_file.aaa06
    DEFINE company STRING 
    DEFINE i,j,k char(20) --局部变量
    DEFINE salary,salary1,salary2 INTEGER
    DEFINE g char(20)
    DEFINE f STRING 
    DEFINE h char(20)
    DEFINE answer CHAR(1) --LOCAL变数局部变量
    
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
    LET g_tty = 'tiptop'
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
    DISPLAY "输出1:",g_tty
    DISPLAY "输出1:",g_employee

    CALL ins_employee()

    DISPLAY "请等待5秒！"
    SLEEP 5 --延迟5秒
    DISPLAY "谢谢！"
    
END MAIN

FUNCTION ins_employee()
    DEFINE g_tty1 SMALLINT --LOCAL变数 局部变量
    DEFINE g_employee1 SMALLINT --LOCAL变数

    LET g_tty1 = 32
    LET g_employee1 = 10

    DISPLAY "输出2:",g_tty1
    DISPLAY "输出2:",g_employee1
    
END FUNCTION 









