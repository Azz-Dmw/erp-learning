# Prog. Version..: '1.0.0(00000)'
# Pattern name...: aooi888.4gl
# Descriptions...: 签核人员资料维护作业
# Date & Author..: 2026/02/04 By dmw
# Note...........: 本程序为训练测试程序（空壳版）

DATABASE ds --连接ds数据库

GLOBALS "../../config/top.global" 
--把 top.global 这个文件里的 全局变量 / 函数 引进来
{通常里面会有：g_prog（程序名）、g_time（时间记录）、g_win_style（窗口风格）
共用 function（cl_user()、cl_setup() 等）}


--定义全局变量
DEFINE
    g_azb        RECORD LIKE azb_file.*, --一整笔 azb_file 表的数据结构跟数据库表一模一样
    g_azb_t      RECORD LIKE azb_file.*,
    g_azb01_t    LIKE azb_file.azb01,
    g_wc         STRING,--where condition（SQL 条件）
    g_sql        STRING,--动态 SQL 字串
    g_azb_rowid  LIKE type_file.chr18--存 rowid，用来 FOR UPDATE

DEFINE
    g_forupd_sql         STRING,
    g_before_input_done LIKE type_file.num5,
    g_chr               LIKE type_file.chr1,
    g_cnt               LIKE type_file.num10,
    g_i                 LIKE type_file.num5,
    g_msg               LIKE type_file.chr1000,
    g_curs_index        LIKE type_file.num10,
    g_row_count         LIKE type_file.num10,
    g_jump              LIKE type_file.num10,
    mi_no_ask           LIKE type_file.num5

--程序入口
MAIN
    DEFINE p_row, p_col LIKE type_file.num5

    OPTIONS INPUT NO WRAP
    DEFER INTERRUPT

    IF NOT cl_user() THEN
        EXIT PROGRAM
    END IF

    WHENEVER ERROR CALL cl_err_msg_log

    IF NOT cl_setup("A00") THEN
        EXIT PROGRAM
    END IF

    CALL cl_used(g_prog, g_time, 1) RETURNING g_time

    INITIALIZE g_azb.* TO NULL

    LET g_forupd_sql =
        "SELECT * FROM azb_file WHERE rowid = ? FOR UPDATE NOWAIT"

    DECLARE i010_cl CURSOR FROM g_forupd_sql

    LET p_row = 5
    LET p_col = 10

    OPEN WINDOW i010_w AT p_row, p_col
        WITH FORM "aoo/42f/aooi010"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)

    CALL cl_ui_init()

    LET g_action_choice = ""
    CALL i010_menu()     -- 空壳菜单

    CLOSE WINDOW i010_w

    CALL cl_used(g_prog, g_time, 2) RETURNING g_time
END MAIN


# =========================
# 以下全部是【空壳函数】
# 目的：让 linker 找得到
# =========================

FUNCTION i010_menu()
    -- 暂不实现任何逻辑
END FUNCTION

{
FUNCTION cl_validate_fun01() END FUNCTION
FUNCTION cl_validate_fun02() END FUNCTION
FUNCTION cl_validate_fun03() END FUNCTION
FUNCTION cl_validate_fun04() END FUNCTION
FUNCTION cl_validate_fun05() END FUNCTION
FUNCTION cl_validate_fun06() END FUNCTION
FUNCTION cl_validate_fun07() END FUNCTION
FUNCTION cl_validate_fun08() END FUNCTION
FUNCTION cl_validate_fun09() END FUNCTION
FUNCTION cl_validate_fun10() END FUNCTION
FUNCTION cl_validate_fun11() END FUNCTION
FUNCTION cl_validate_fun12() END FUNCTION
FUNCTION cl_validate_fun13() END FUNCTION
FUNCTION cl_validate_fun14() END FUNCTION
FUNCTION cl_validate_fun15() END FUNCTION
FUNCTION cl_validate_fun16() END FUNCTION
FUNCTION cl_validate_fun17() END FUNCTION
FUNCTION cl_validate_fun18() END FUNCTION
FUNCTION cl_validate_fun19() END FUNCTION
FUNCTION cl_validate_fun20() END FUNCTION

FUNCTION cl_set_data_mask_detail()

END FUNCTION}
