# Prog. Version..: '1.0.0(00000)'
# Pattern name...: aooi888.4gl
# Descriptions...: 签核人员资料维护作业
# Date & Author..: 2026/02/04 By dmw
# Note...........: 本程序为训练测试程序（空壳版）

DATABASE jf --连接ds数据库

GLOBALS "../../config/top.global" 
--把 top.global 这个文件里的 全局变量 / 函数 引进来
{
通常里面会有：
g_prog（程序名）、
g_time（时间记录）、
g_win_style（窗口风格）
共用 function（
cl_user()(权限检查)、
cl_setup()(环境初始化)、
cl_used()（使用记录）等）
}


--定义全局变量
DEFINE
    g_azb        RECORD LIKE azb_file.*, --一整笔 azb_file 表的数据结构跟数据库表一模一样
    g_azb_t      RECORD LIKE azb_file.*,
    g_azb01_t    LIKE azb_file.azb01,
    g_wc         STRING,--动态where条件（SQL 条件）
    g_sql        STRING,--动态 SQL 字串
    g_azb_rowid  LIKE type_file.chr18--存 rowid，用来 FOR UPDATE


--控制用变量
DEFINE
    g_forupd_sql         STRING,                --FOR UPDATE 用的 SQL
    g_before_input_done  LIKE type_file.num5,   --控制 INPUT 前后逻辑用
    g_chr                LIKE type_file.chr1,   --计数、循环、判断用
    g_cnt                LIKE type_file.num10,  --计数、循环、判断用
    g_i                  LIKE type_file.num5,   --for / loop 计数
    g_msg                LIKE type_file.chr1000,--MESSAGE 显示用
    g_curs_index         LIKE type_file.num10,  --导航条（上一笔 / 下一笔）cl_navigator_setting() 会用到
    g_row_count          LIKE type_file.num10,  --导航条
    g_jump               LIKE type_file.num10,  --菜单跳转
    mi_no_ask            LIKE type_file.num5    --是否跳过确认

--程序入口
MAIN

    DEFINE p_row, p_col LIKE type_file.num5  --定义窗口显示的位置，p_row：第几行，p_col：第几列

    OPTIONS INPUT NO WRAP   --输入超过栏位 不自动换行
    DEFER INTERRUPT         --延迟 Ctrl+C / 中断，防止用户在关键操作时把程序杀掉，属于保护机制

    IF NOT cl_user() THEN   --判断使用者是否有权限，没权限 → 直接结束程序
        EXIT PROGRAM
    END IF

    WHENEVER ERROR CALL cl_err_msg_log  --只要程序发生 SQL / Runtime Error，👉 自动调用 cl_err_msg_log

    IF NOT cl_setup("A00") THEN     --A00：模块代号，初始化：语言、画面风格、环境参数
        EXIT PROGRAM
    END IF

    --记录开始使用
    CALL cl_used(g_prog, g_time, 1) RETURNING g_time    --记录「程序开始使用」，1 = 开始，2 = 结束，常用于系统审计 / 使用统计

    INITIALIZE g_azb.* TO NULL  --清空记录变量，相当于所有字段 = 空

    LET g_forupd_sql =
        "SELECT * FROM azb_file WHERE rowid = ? FOR UPDATE NOWAIT"  --查询一笔资料，并且 锁住，NOWAIT：有人锁 → 直接报错

    DECLARE i888_cl CURSOR FROM g_forupd_sql    --为 FOR UPDATE 准备游标，只有 DECLARE，真正执行是在 OPEN / FETCH

    --设定窗口位置
    LET p_row = 5
    LET p_col = 10

        {打开一个窗口 i010_w
        使用 .per 表单套用系统统一风格}
    OPEN WINDOW i010_w AT p_row, p_col
        WITH FORM "aoo/42f/aooi888"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)

    --UI 初始化，统一处理：快捷键、颜色、状态列
    CALL cl_ui_init()

    --主菜单
    --所有功能都会从这里开始
    LET g_action_choice = ""
    CALL i010_menu()     -- 空壳菜单

    --关闭窗口
    CLOSE WINDOW i010_w

    --记录结束使用
    CALL cl_used(g_prog, g_time, 2) RETURNING g_time
    
END MAIN


# =========================
# 功能菜单总览
# =========================

FUNCTION i010_menu()

    MENU ""

    --各功能按钮
        BEFORE MENU     --预设第一笔、上笔、指定笔、下笔、末一笔五个功能关闭
            CALL cl_navigator_setting(g_curs_index, g_row_count)

        --新增功能按钮
        ON ACTION INSERT
            CALL i888_insert()   --调用新增功能函数
            
        --查询功能按钮
        ON ACTION query
             CALL i888_query()   --调用查询功能函数

        --修改功能按钮
        ON ACTION modify
            CALL i888_modify()    --调用修改功能函数

        --删除功能按钮
        ON ACTION DELETE
            CALL i888_delete()    --调用删除功能函数

        --复制功能按钮
        ON ACTION reproduce
            --LET g_action_choice="reproduce"
            CALL i888_copy()    --调佣复制功能函数
            --MESSAGE "复制"

        ON ACTION FIRST
            CALL i010_fetch('F')

        --说明功能按钮
        ON ACTION help
            CALL cl_show_help()     --调用说明功能函数

        --退出功能按钮
        ON ACTION exit
            EXIT MENU

        ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE MENU


    END MENU

END FUNCTION



--========================
--  新增功能函数
--========================

FUNCTION i888_insert()  

    DEFINE l_ok LIKE type_file.num5

    --初始化变量
    INITIALIZE g_azb.* TO NULL 

    --清画面
    CLEAR FORM 

    --注意：INITIALIZE与CLEAR FORM作用和区别
    --INITIALIZE：清变量，INITIALIZE g_azb.* TO NULL，画面不会自动清除。
    --CLEAR FORM：清画面,变量还在，只是画面清理了

    --输入资料
    INPUT BY NAME g_azb.*
        BEFORE INPUT 
            MESSAGE "请输入新增资料" 
    END INPUT 

    LET g_azb.AZBDATE = TODAY   --赋值g_azb.AZBDATE日期为今天


    --主键检查
    IF NOT i888_chk_pk() THEN 
        MESSAGE "主键重复，新增取消！"
        RETURN 
    END IF 

    --整体资料检查
    IF NOT i888_chk_insert() THEN 
        MESSAGE "资料检查失败，新增取消"
        RETURN
    END IF 


    --确认
    LET l_ok = cl_confirm("是否确认新增此笔资料？")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消新增"
        RETURN 
    END IF 

    -- === 正式新增到数据库 ===

    --开事务
    BEGIN WORK 
    
    --主键重复、NOT NULL 违反、触发器错误
    --全局错误处理模式
    WHENEVER ERROR CALL cl_err_msg_log 

    --=== 显示 INSERT SQL ===
    LET g_sql = 
            "INSERT INTO azb_file (" ||
        "azb01, azboriu, azb02, azborig, azb06, azbdate, azbuser" ||
        ") VALUES (?, ?, ?, ?, ?, ?, ?)"

    DISPLAY "INSERT SQL => " || g_sql
    DISPLAY "PARAM azb01   = [" || g_azb.azb01 || "]"
    DISPLAY "PARAM azboriu = [" || g_azb.azboriu || "]"
    DISPLAY "PARAM azb02   = [" || g_azb.azb02 || "]"
    DISPLAY "PARAM azborig = [" || g_azb.azborig || "]"
    DISPLAY "PARAM azb06   = [" || g_azb.azb06 || "]"
    DISPLAY "PARAM azbdate = [" || g_azb.azbdate || "]"
    DISPLAY "PARAM azbuser = [" || g_user || "]"

    PREPARE s_ins FROM g_sql

    --执行insert新增SQL
    EXECUTE s_ins USING 
            g_azb.azb01,
            g_azb.azboriu,
            g_azb.azb02,
            g_azb.azborig,
            g_azb.azb06,
            g_azb.azbdate,
            g_user

    --=== 显示影响行数 ===
    DISPLAY  "INSERT ROW COUNT = " || SQLCA.SQLERRD[3]

    --关闭全局错误处理模式
    WHENEVER ERROR STOP 

    IF SQLCA.SQLCODE <> 0 THEN
        MESSAGE "新增失败，SQLCODE = " || SQLCA.SQLCODE
        ROLLBACK WORK       --注意：ROLLBACK后面一定要加WORK
        RETURN  
    END IF

    IF SQLCA.SQLERRD[3] <> 1 THEN
        MESSAGE "新增影响行数异常 = " || SQLCA.SQLERRD[3]
        ROLLBACK WORK
        RETURN
    END IF

    COMMIT WORK             --注意：COMMIT后面一定要加WORK
    
    MESSAGE "新增成功"

    --显示新增后的资料
    CALL i888_show() 
    
    
END FUNCTION 


--检查主键是否合法
FUNCTION i888_chk_pk() 


    DEFINE l_cnt LIKE type_file.num10


    --主键不能为空
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN 
        MESSAGE "主键不能为空！"
        RETURN FALSE 
    END IF 

    --检查主键是否存在
    SELECT COUNT(*) 
    INTO l_cnt 
    FROM azb_file
    WHERE TRIM(azb01) = TRIM(g_azb.azb01)

    IF l_cnt > 0 THEN 
        MESSAGE "编号已存在无法新增"
        RETURN FALSE
    END IF 

    --检查通过
    RETURN TRUE 

END FUNCTION

        -- 这里以后可以放：
        -- 必填栏位检查
        -- 逻辑检查（日期大小、状态组合等）
FUNCTION i888_chk_insert()

        IF g_azb.azboriu IS NULL OR g_azb.azboriu CLIPPED = " " THEN 
            MESSAGE "人员名称不能为空"
            RETURN FALSE 
        END IF 

        RETURN TRUE 
        
END FUNCTION    -- 新增功能函数结束



--========================
-- 查询功能函数
--========================

FUNCTION i888_query()

    DEFINE l_where STRING 
    DEFINE l_sql STRING 


    --清变量 + 清画面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    --输入查询条件（这里只用azb01查询）
    INPUT BY NAME 
        g_azb.azb01,--人员编号
        g_azb.azboriu,--人员名称
        g_azb.azbacti,--有效码
        g_azb.azbuser,--资料所有者
        g_azb.azbgrup --资料群组
        BEFORE INPUT 
            MESSAGE "请输入查询条件"
    END INPUT 

    DISPLAY "DEBUG INPUT azb01=[" || g_azb.azb01 || "]"

    
    --SQL拼接where条件
    LET l_where = " WHERE 1 = 1 "
    LET l_sql   = "SELECT * FROM azb_file "

    DISPLAY "DEBUG INPUT l_where=[" || l_where || "]"
    DISPLAY "DEBUG INPUT l_sql=[" || l_sql || "]"
    DISPLAY "DEBUG2 BEFORE IF azb01=[" || g_azb.azb01 || "]"

    
    --人员编号
    IF g_azb.azb01 IS NOT NULL AND g_azb.azb01 CLIPPED <> " " THEN 
        LET l_where = l_where || " AND TRIM(azb01) = '" || g_azb.azb01 CLIPPED || "'"
    END IF 
    
    --人员名称
    IF g_azb.azboriu IS NOT NULL AND g_azb.azboriu CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azboriu like '%" || g_azb.azboriu CLIPPED || "%'"
    END IF 

    --资料有效码
    IF g_azb.azbacti IS NOT NULL AND g_azb.azbacti CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azbacti = '" || g_azb.azbacti CLIPPED || "'"
    END IF 

    --资料所有者
    IF g_azb.azbuser IS NOT NULL AND g_azb.azbuser CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azbuser = '" || g_azb.azbuser CLIPPED || "'"
    END IF

    --资料群组
    IF g_azb.azbgrup IS NOT NULL AND g_azb.azbgrup CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azbgrup = '" || g_azb.azbgrup CLIPPED || "'"
    END IF

    --拼接完整SQL
    LET l_sql = l_sql || l_where || " ORDER BY azb01"
                                                    
    --★★★ Debug：显示最终 SQL ★★★
    DISPLAY "DEBUG SQL => " || l_sql

    --执行查询
    PREPARE s_qry FROM l_sql
    DECLARE c_qry CURSOR FOR s_qry
    OPEN c_qry

    FETCH c_qry INTO g_azb.*
    


    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "查无资料"
        CLOSE c_qry
        RETURN
    END IF 

    --显示结果
    DISPLAY BY NAME g_azb.*

    MESSAGE "查询成功！"

    CLOSE c_qry

END FUNCTION    -- 查询功能函数结束



--========================
--  修改功能函数
--========================
FUNCTION i888_modify()

    DEFINE l_ok LIKE type_file.num5

    --先将最近修改日的时间赋值
    DEFINE l_today DATE
    LET l_today = TODAY


    --清变量 + 清画面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    --先输入要修改的主键
    INPUT BY NAME g_azb.azb01
        BEFORE INPUT 
            MESSAGE "请输入要修改的人员编号"
    END INPUT 

    --主键检查
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN 
        MESSAGE "人员编号不能为空！"
        RETURN 
    END IF 

    --先取rowid
    SELECT rowid
        INTO g_azb_rowid
        FROM azb_file
        WHERE TRIM(azb01) = TRIM(g_azb.azb01)

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料不存在，无法修改！"
        RETURN
    END IF 

    --再取整笔资料
    SELECT *
        INTO g_azb.*
        FROM azb_file
        WHERE rowid = g_azb_rowid

    --显示原资料
    DISPLAY BY NAME g_azb.*


    --=== 锁资料（FOR UPDATE）===

    --开事务
    BEGIN WORK 

    --开锁定游标
    OPEN i888_cl USING g_azb_rowid
    
    FETCH i888_cl INTO g_azb.*

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料被其他人使用中，无法修改！"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN
    END IF 

    --进入修改输入（主键不可修改）
    INPUT BY NAME 
        g_azb.azboriu,
        g_azb.azb02,
        g_azb.azbacti,
        g_azb.azbgrup
        BEFORE INPUT 
            MESSAGE "请修改资料（ESC取消）"
    END INPUT 

    --资料检查
    IF NOT i888_chk_modify() THEN 
        MESSAGE "资料检查失败,修改取消"
        CLOSE i888_cl
        RETURN
    END IF 

    --确认
    LET l_ok = cl_confirm("是否确认修改此笔资料？")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消修改！"
        CLOSE i888_cl
        RETURN 
    END IF 

    --=== 正式 UPDATE ===
    WHENEVER ERROR CALL cl_err_msg_log

    --拼接SQL
    LET g_sql = 
        "UPDATE azb_file SET " ||
        "azboriu = ?, " ||  --姓名
        "azb02 = ?," ||     --密码
        "azbuser = ?," ||   --资料所有者
        "azbdate = ? " ||   --最近更改日
        "WHERE rowid = ?"

    DISPLAY "FINAL SQL = [" || g_sql || "]" --输出将要执行的SQL
    DISPLAY "FINAL UPDATE SQL = [" || g_sql || "]"  --输出将要执行的SQL
    DISPLAY "ROWID = [" || g_azb_rowid || "]"   --输出行id


    
    PREPARE s_upd FROM g_sql

    EXECUTE s_upd USING
        g_azb.azboriu,   -- 姓名 
        g_azb.azb02,    --人员编号
        g_user,         --资料所有者
        l_today,        --最近更改日
        g_azb_rowid
    

    DISPLAY "DEBUG SQLCA.SQLERRD[3] = " || SQLCA.SQLERRD[3]


    WHENEVER ERROR STOP 

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "修改失败,SQLCODE = " || SQLCA.SQLCODE
        CLOSE i888_cl
        ROLLBACK WORK
        RETURN 
    END IF 

    CLOSE i888_cl
    COMMIT WORK 

    MESSAGE "修改成功!"

    --显示修改后资料
    CALL i888_show()

END FUNCTION    -- 修改功能函数结束


    
--========================
-- 修改资料 检查函数
--========================

FUNCTION i888_chk_modify()

    IF g_azb.azboriu IS NULL OR g_azb.azboriu CLIPPED = " " THEN 
        MESSAGE "人员名称不能为空！"
        RETURN FALSE 
    END IF

    RETURN TRUE 

END FUNCTION    --修改资料检查函数结束



--========================
--  删除功能函数
--========================
FUNCTION i888_delete()

    DEFINE l_ok LIKE type_file.num5
    DEFINE l_sql STRING 

    --清变量 + 清画面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    --输入要删除的主键
    INPUT BY NAME g_azb.azb01
        BEFORE INPUT 
            MESSAGE "请输入要删除的人员编号"
    END INPUT 

    --主键检查
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN 
        MESSAGE "人员编号不能为空！"
        RETURN 
    END IF 

    --先取rowid
    SELECT ROWID
        INTO g_azb_rowid
        FROM azb_file
        WHERE TRIM(azb01) = TRIM(g_azb.azb01)

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料不存在,无法删除！"
        RETURN 
    END IF 

    SELECT *
        INTO g_azb.*
        FROM azb_file
        WHERE ROWID = g_azb_rowid

    --显示将要删除的资料
    DISPLAY BY NAME g_azb.*

    --二次确认
    LET l_ok = cl_confirm("确认要删除此笔资料吗？(删除后无法恢复！)")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消删除"
        RETURN 
    END IF 

    --=== 开始删除 ===
    WHENEVER ERROR CALL cl_err_msg_log

    BEGIN WORK 

    --锁资料
    OPEN i888_cl USING g_azb_rowid
    FETCH i888_cl INTO g_azb.*

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料被其他人使用中,无法删除！"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN 
    END IF

    --删除SQL
    LET l_sql = "DELETE FROM azb_file WHERE rowid = ?"

    DISPLAY "DELETE SQL => " || l_sql
    DISPLAY "ROWID = [" || g_azb_rowid || "]"

   --执行删除
    DELETE FROM azb_file
        WHERE ROWID = g_azb_rowid

    --显示影响行数
    DISPLAY "DELETE ROW COUNT = " || SQLCA.SQLERRD[3]

    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "删除失败,SQLCODE = " || SQLCA.SQLCODE
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN 
    END IF 

    CLOSE i888_cl
    COMMIT WORK 

    MESSAGE "删除成功！"

    --清画面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    WHENEVER ERROR STOP 
        
    
END FUNCTION


--========================
--  复制功能函数
--========================
FUNCTION i888_copy()

    DEFINE l_ok LIKE type_file.num5
    DEFINE g_debug STRING

    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN
        MESSAGE "请先查询一笔资料，再执行复制！"
        RETURN
    END IF

    --清掉不能复制的栏位
    LET g_azb.azb01   = NULL
    LET g_azb.azbdate = TODAY
    LET g_azb.azbuser = g_user

    DISPLAY BY NAME g_azb.*

    INPUT BY NAME
        g_azb.azb01,
        g_azb.azboriu,
        g_azb.azb02,
        g_azb.azbacti,
        g_azb.azbgrup
        BEFORE INPUT
            MESSAGE "复制资料：请输入新人员编号"
    END INPUT

    IF NOT i888_chk_pk() THEN
        MESSAGE "主键检查失败，复制取消！"
        RETURN
    END IF

    IF NOT i888_chk_insert() THEN
        MESSAGE "资料检查失败，复制取消！"
        RETURN
    END IF

    LET l_ok = cl_confirm("是否确认复制此笔资料？")
    IF l_ok <> 1 THEN
        MESSAGE "已取消复制"
        RETURN
    END IF


    BEGIN WORK
    WHENEVER ERROR CALL cl_err_msg_log

    INSERT INTO azb_file
        (azb01, azboriu, azb02, azborig, azb06, azbdate, azbuser)
    VALUES
        (g_azb.azb01,
         g_azb.azboriu,
         g_azb.azb02,
         g_azb.azborig,
         g_azb.azb06,
         g_azb.azbdate,
         g_user)

    WHENEVER ERROR STOP

    IF SQLCA.SQLCODE <> 0 THEN
        MESSAGE "复制新增失败，SQLCODE = " || SQLCA.SQLCODE
        ROLLBACK WORK
        RETURN
    END IF

    COMMIT WORK

    MESSAGE "复制成功！"

    CALL i888_show()

END FUNCTION




FUNCTION i888_show()

    DISPLAY BY NAME g_azb.*  --BY NAME 显示在画面档 或者DISPLAY g_azb.* TO FORM *
    --DISPLAY g_azb.*             --显示在Linux终端
    
END FUNCTION 


FUNCTION i010_fetch(p_mode)

    DEFINE p_mode CHAR(1)

    CASE p_mode 
        WHEN 'F'
            LET g_azb.azb01 = "FIRST"
        WHEN 'L'
            LET g_azb.azb01 = "LAST"
        OTHERWISE 
            LET g_azb.azb01 = "OTHER"
    END CASE 

    CALL i888_show()
    
END FUNCTION 

