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
    DEFINE l,i_max,i_min INTEGER --定义最大值和最小值
    DEFINE m INTEGER 
    
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
    LET i_max = 10
    LET i_min = 1
    LET m = 0

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

    DISPLAY "请等待3秒！"
    SLEEP 3 --延迟3秒
    DISPLAY "谢谢！"

    --IF判断语句
    IF i MATCHES "TIPTOP" THEN --判断1
        DISPLAY "The first name TIPTOP displayed."--输出
        IF i MATCHES "GP" THEN --判断2
            DISPLAY "Even the last name TIPTOP displayed."--输出
        END IF --结束判断2
    ELSE --其他情况
        DISPLAY "The name is " , i , "."--输出
    END IF --结束判断1

    CASE salary1 
        WHEN -1000 
            DISPLAY "薪资小于0!"
        WHEN 1000
            DISPLAY "薪资大于0!"
        OTHERWISE 
            DISPLAY "薪资未知!"
    END CASE 

    IF salary2 = -1000 OR salary2 = 1000 OR salary2 = 0 THEN
        IF salary2 = -1000 THEN 
            DISPLAY "薪资小于0!"
        END IF
        IF salary2 = 1000 THEN 
            DISPLAY "薪资大于0!"
        END IF 
        
    ELSE 
        DISPLAY "薪资未知!"
    END IF

    
    CASE WHEN (salary2 = 1000 OR salary1 = 1000)
            DISPLAY "Value is either salary1 or salary2"
         WHEN  (salary = 1000 OR salary1 = 1000)
            DISPLAY "Value is either salary or salary1"
        OTHERWISE 
            DISPLAY "Unexpected value"
    END CASE 

    DISPLAY "从小到大输出"
    FOR l = i_min TO i_max
    DISPLAY l
    END FOR 

    DISPLAY "从大到小输出"
    FOR l = i_max TO i_min STEP-1
    DISPLAY l
    END FOR 

    WHILE i_max > i_min
        DISPLAY i_max,">",i_min
        LET i_min = i_min + 1
    END WHILE 
    
    DISPLAY "--------------------------"
    FOR l=1 TO i_max -1 --STEP -1
        DISPLAY i_max,">",l
    END FOR 

    WHILE m < 5
        LET m = m + 1
        DISPLAY "m=" || m
        CONTINUE WHILE 
        DISPLAY "这一行永远不显示" 
    END WHILE 
        DISPLAY "--------------------------"
        DISPLAY "m1=",m 
        DISPLAY "--------------------------"
        
    WHILE TRUE 
        LET m = m + 1
        DISPLAY "m2=",m 
        IF m = 10 THEN 
            EXIT WHILE 
        END IF
    END WHILE 
    DISPLAY "--------------------------"
    DISPLAY "m3=",m 
    
END MAIN

FUNCTION ins_employee()
    DEFINE g_tty1 SMALLINT --LOCAL变数 局部变量
    DEFINE g_employee1 SMALLINT --LOCAL变数

    LET g_tty1 = 32
    LET g_employee1 = 10

    DISPLAY "输出2:",g_tty1
    DISPLAY "输出2:",g_employee1
    
END FUNCTION 









