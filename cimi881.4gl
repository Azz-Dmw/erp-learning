DATABASE ds

GLOBALS "../../config/top.global"

DEFINE
    g_aaa        RECORD LIKE aaa_file.*,
    g_aaa_t      RECORD LIKE aaa_file.*,
    g_forupd_sql STRING

MAIN
    OPTIONS INPUT NO WRAP
    DEFER INTERRUPT

    -- 1. 用户检查
    IF NOT cl_user() THEN
        EXIT PROGRAM
    END IF

    -- 2. 错误统一处理
    WHENEVER ERROR CALL cl_err_msg_log

    -- 3. 模块初始化
    IF NOT cl_setup("CIM") THEN
        EXIT PROGRAM
    END IF

    -- 4. 程序使用开始记录
    CALL cl_used(g_prog, g_time, 1) RETURNING g_time

    -- 5. 初始化数据
    INITIALIZE g_aaa.*   TO NULL
    INITIALIZE g_aaa_t.* TO NULL

    -- 6. FOR UPDATE SQL（先放着，不用也没关系）
    LET g_forupd_sql = "SELECT * FROM aaa_file WHERE aaa01 = ? FOR UPDATE"
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)

    -- 7. 打开画面
    OPEN WINDOW i108_w WITH FORM "cim/42f/cimi881"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)

    CALL cl_ui_init()

    -- 8. 暂时什么都不做，只显示画面
    MESSAGE "画面已打开，按 ESC 退出"

    -- 等用户按 ESC
    WHILE TRUE
        IF INT_FLAG THEN
            EXIT WHILE
        END IF
        PAUSE 1
    END WHILE

    -- 9. 关闭画面
    CLOSE WINDOW i108_w

    -- 10. 程序使用结束记录
    CALL cl_used(g_prog, g_time, 2) RETURNING g_time

END MAIN
