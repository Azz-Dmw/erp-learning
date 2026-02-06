# Prog. Version..: '1.0.0(00000)'
# Pattern name...: aooi888.4gl
# Descriptions...: 签核人员资料维护作业
# Date & Author..: 2026/02/04 By dmw
# Note...........: 本程序为训练测试程序（空壳版）

DATABASE ds --连接ds数据库

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

    DECLARE i010_cl CURSOR FROM g_forupd_sql    --为 FOR UPDATE 准备游标，只有 DECLARE，真正执行是在 OPEN / FETCH

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
# 以下全部是【空壳函数】
# 目的：让 linker 找得到
# =========================


FUNCTION i010_menu()

    MENU ""

    --各功能按钮
        BEFORE MENU     --预设第一笔、上笔、指定笔、下笔、末一笔五个功能关闭
            CALL cl_navigator_setting(g_curs_index, g_row_count)

        --新增功能按钮
        ON ACTION INSERT
            CALL i888_insert()   --调用新增功能函数
            
            --MESSAGE "insert (empty)"
            {  菜单 INSERT
                  ↓
                i888_insert()
                  ├─ 清变量 / 清画面
                  ├─ INPUT BY NAME 输入
                  ├─ 主键即时检查（AFTER FIELD azb01）
                  ├─ 整体检查（i888_chk_insert）
                  ├─ 确认
                  ├─ INSERT INTO azb_file (...)
                  ├─ COMMIT
                  └─ 重新显示画面

             }

        --查新功能按钮
        ON ACTION query
             CALL i888_show()   ----调用查询功能函数
             MESSAGE "query (empty)"

        --修改功能按钮
        ON ACTION modify
            MESSAGE "modify (empty)"

        --删除功能按钮
        ON ACTION delete
            MESSAGE "delete (empty)"

        ON ACTION FIRST
            CALL i010_fetch('F')

        --说明功能按钮
        ON ACTION help
            CALL cl_show_help()     ------调用说明功能函数

        --退出功能按钮
        ON ACTION exit
            EXIT MENU

        ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE MENU


    END MENU

END FUNCTION




--新增功能函数
FUNCTION i888_insert()  

    DEFINE l_ok LIKE type_file.num5

    --初始化变量
    INITIALIZE g_azb.* TO NULL 

    --清画面
    CLEAR FORM 

    --注意：INITIALIZE、CLEAR FORM作用和区别
    --INITIALIZE：清变量，INITIALIZE g_azb.* TO NULL，画面不会自动清除。
    --CLEAR FORM：清画面,变量还在，只是画面清理了

    --输入资料
    INPUT BY NAME g_azb.*
        BEFORE INPUT 
            MESSAGE "请输入新增资料" 
    END INPUT 


    --主键检查
    IF NOT i888_chk_pk() THEN 
        MESSAGE "主键检查失败，新增取消！"
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
    --主键重复、NOT NULL 违反、触发器错误
    --全局错误处理模式
    --WHENEVER ERROR CALL cl_err_msg_log 

    --插入数据库
    --INSERT INTO azb_file VALUES (g_azb.*)
    INSERT INTO azb_file (
    azb01,
    azboriu,
    azbdate
    )
    VALUES (
        TRIM(g_azb.azb01),
        TRIM(g_azb.azboriu),
        TRIM(g_azb.azbdate)
    )


    --关闭全局错误处理模式
    --WHENEVER ERROR STOP 

    IF SQLCA.SQLCODE <> 0 THEN
        MESSAGE "新增失败，SQLCODE = " || SQLCA.SQLCODE
        ROLLBACK WORK 
        RETURN  
    END IF

    COMMIT WORK 
    MESSAGE "新增成功"

    --显示新增后的资料
    CALL i888_show() 
    
    
END FUNCTION 


--检查主键是否合法
FUNCTION i888_chk_pk() 


    DEFINE l_cnt LIKE type_file.num10


    --主键不能为空
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = "" THEN 
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


FUNCTION i888_chk_insert()
        -- 这里以后可以放：
        -- 必填栏位检查
        -- 逻辑检查（日期大小、状态组合等）

        IF g_azb.azboriu IS NULL OR g_azb.azboriu CLIPPED = "" THEN 
            MESSAGE "人员名称不能为空"
            RETURN FALSE 
        END IF 

        RETURN TRUE 
        
END FUNCTION 


FUNCTION i888_show()

    --模拟一笔查询到的资料
    --LET g_azb.azb01 = "0000"
    --LET g_azb.azboriu = "测试人员"
    --LET g_azb.AZBDATE = TODAY 

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









