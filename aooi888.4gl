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
        使用 .per 表单
        套用系统统一风格}
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
        BEFORE MENU
            CALL cl_navigator_setting(g_curs_index, g_row_count)

        --新增功能按钮
        ON ACTION INSERT
            CALL i010_insert()   --调用新增功能函数
            --MESSAGE "insert (empty)"

        --查新功能按钮
        ON ACTION query
             CALL i010_show()   ----调用查询功能函数
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


FUNCTION i010_show()

    --模拟一笔查询到的资料
    --LET g_azb.azb01 = "0000"
    LET g_azb.azboriu = "测试人员"
    LET g_azb.AZBDATE = TODAY 

    DISPLAY BY NAME g_azb.*  --BY NAME 显示在画面档 或者DISPLAY g_azb.* TO FORM *
    DISPLAY g_azb.*             --显示在Linux终端
    
END FUNCTION 


FUNCTION i010_insert()   --新增功能函数

    INITIALIZE g_azb.* TO NULL 

    CLEAR FORM --清画面,变量还在，直接画面清理了
                --清变量，INITIALIZE g_azb.* TO NULL，画面不会自动清除，注意区别和用法
    
    INPUT BY NAME g_azb.*   --输入值 → 自动进 g_azb
        BEFORE INPUT 
        MESSAGE "请输入新增资料"


        --AFTER INPUT 
        --MESSAGE "输入完成"
    END INPUT

   IF NOT i010_chk_insert() THEN 
        RETURN 
    END IF 

    MESSAGE "新增成功（假成功）"

    --显示结果（假装新增成功）
    CALL i010_show()
    
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

    CALL i010_show()
    
END FUNCTION 

--检查主键唯一并且不能为空
FUNCTION i010_chk_insert()

    DEFINE l_cnt LIKE type_file.num10

    --主键不能为空
    IF g_azb.azb01 IS NULL OR g_azb.azb01 = "" THEN 
        MESSAGE "主键不可为空，请输入签核人员编号！"
        RETURN FALSE 
    END IF 

    --检查主键是否存在
    SELECT COUNT(*) INTO l_cnt FROM azb_file
    WHERE azb01 = g_azb.azb01

    IF l_cnt > 0 THEN 
        MESSAGE "编号 [" || g_azb.azb01 || "] 已存在，无法新增"
        RETURN FALSE
    END IF 

    --检查通过
    RETURN TRUE 

END FUNCTION









