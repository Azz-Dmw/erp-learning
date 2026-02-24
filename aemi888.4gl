###############################################################################
# 程序名称: aemi888.4gl
# 功能说明: 人员工种资料维护作业
#
# 功能总结：
#   1. 查询人员资料
#   2. 显示人员资料
#   3. 维护人员对应工种（新增 / 修改 / 删除）
#
# 表关系：
#
#   trw_file  人员主档
#   trx_file  人员工种明细
#   gen_file  工种资料
#
###############################################################################


DATABASE ds

# 引入系统全局变量（鼎捷标准）
GLOBALS "../../config/top.global"



###############################################################################
# 模块变量定义区
###############################################################################

DEFINE

    # 当前主档数据（人员编号）
    g_trw01 LIKE trw_file.trw01,

    # 当前主档数据（人员名称）
    g_trw02 LIKE trw_file.trw02,


    # 明细数组（人员工种）
    g_trx DYNAMIC ARRAY OF RECORD

        trx02 LIKE trx_file.trx02,   # 工种编号

        gen02 LIKE gen_file.gen02,   # 工种名称

        trx03 LIKE trx_file.trx03    # 备注

    END RECORD,


    # 明细备份（用于修改前保存）
    g_trx_t RECORD

        trx02 LIKE trx_file.trx02,

        gen02 LIKE gen_file.gen02,

        trx03 LIKE trx_file.trx03

    END RECORD,


    # 查询条件
    g_wc STRING,

    g_wc2 STRING,


    # SQL语句
    g_sql STRING,


    # 明细笔数
    g_rec_b LIKE type_file.num5,


    # 当前行号
    l_ac LIKE type_file.num5




###############################################################################
# 主程序入口
###############################################################################

MAIN

    DEFINE p_row, p_col LIKE type_file.num5  --定义窗口显示的位置，p_row：第几行，p_col：第几列

    -- 设置输入选项：禁止自动换行，提高用户体验
    OPTIONS INPUT NO WRAP

    -- 延迟 Ctrl+C 中断：防止用户在关键操作中误杀程序，保护数据完整性
    DEFER INTERRUPT

    -- ★ 第一步：权限检查 ★
    -- 调用全局权限检查函数，无权限则直接退出
    IF NOT cl_user() THEN
        EXIT PROGRAM
    END IF

    -- ★ 第二步：全局错误处理 ★
    -- 捕获所有 SQL 错误(主键违反、NULL约束等) 和运行时错误
    -- 自动调用错误日志函数进行处理和记录，整个程序生命周期内仅需声明一次
    WHENEVER ERROR CALL cl_err_msg_log


    -- ★ 第三步：环境初始化 ★
    -- 初始化语言、窗口风格、环境参数等（A00 为此模块的代码）
    IF NOT cl_setup("AEM") THEN
        EXIT PROGRAM
    END IF

    -- ★ 第四步：使用记录 ★
    CALL cl_used(g_prog, g_time, 1) RETURNING g_time  #记录进入时间


    -- ★ 第五步：打开主窗口 ★
    -- 设定窗口显示位置
    LET p_row = 5
    LET p_col = 10

    -- 打开主窗口，使用指定的表单文件和系统统一风格
    OPEN WINDOW i888_w AT p_row, p_col
        WITH FORM "aem/42f/aemi888"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)


    -- 初始化 UI 样式：快捷键、颜色、状态列等
    CALL cl_ui_init()

    -- ★ 第六步：显示主菜单 ★
    -- 所有功能入口都从这个菜单开始

    # 清空数据
    CALL g_trx.clear()

    LET g_action_choice = ""
    CALL i888_menu()

    -- ★ 第七步：清理资源 ★
    -- 关闭主窗口
    CLOSE WINDOW i888_w

    -- 记录程序结束使用时间
    CALL cl_used(g_prog, g_time, 2) RETURNING g_time

END MAIN




###############################################################################
# 主菜单功能
###############################################################################

FUNCTION i888_menu()
{
WHILE TRUE

    CASE g_action_choice


        # 查询
        WHEN "query"

           IF cl_chk_act_auth() THEN
              CALL i888_q()
           END IF


        # 明细维护
        WHEN "detail"

            CALL i888_b()



        # 离开
        WHEN "exit"

            EXIT WHILE


    END CASE


END WHILE
}
#中文的MENU

 
   WHILE TRUE
      CALL i888_bp("G")
      
      CASE g_action_choice
      
        WHEN "query"
           IF cl_chk_act_auth() THEN
              CALL i888_q()
           END IF

        WHEN "exit"
           EXIT WHILE

      END CASE
   END WHILE
END FUNCTION

FUNCTION i888_bp(p_ud)
DEFINE
    p_ud LIKE type_file.chr1          #No.FUN-680072 VARCHAR(1)
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_trx TO s_trx.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY
      ON ACTION cancel
             LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION close
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      # No.FUN-530067 --start--
      AFTER DISPLAY
         CONTINUE DISPLAY
      # No.FUN-530067 ---end---
#No.FUN-6B0029--begin                                             
      ON ACTION controls                                        
         CALL cl_set_head_visible("","AUTO")                    
#No.FUN-6B0029--end
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION




###############################################################################
# 查询功能
###############################################################################
FUNCTION i888_q()
 
    MESSAGE "查询成功"

END FUNCTION




###############################################################################
# 显示功能
###############################################################################

FUNCTION i888_show()


    # 显示主档
    DISPLAY

        g_trw01,

        g_trw02

    TO

        trw01,

        trw02



    # 显示明细
    CALL i888_b_fill()


END FUNCTION




###############################################################################
# 明细加载
###############################################################################

FUNCTION i888_b_fill()


    LET g_sql =" SELECT trx02,gen02,trx03 FROM trx_file " ||
    "LEFT JOIN gen_file ON trx02 = gen01 " ||
    "WHERE trx01='" || g_trw01 || "' "


    PREPARE stmt2 FROM g_sql


    DECLARE cursor2 CURSOR FOR stmt2


    CALL g_trx.clear()


    LET g_rec_b = 0



    FOREACH cursor2

    INTO g_trx[g_rec_b+1].*


        LET g_rec_b = g_rec_b + 1


    END FOREACH


END FUNCTION




###############################################################################
# 明细维护核心
###############################################################################

FUNCTION i888_b()



    INPUT ARRAY g_trx FROM s_trx.* ATTRIBUTE(COUNT=g_rec_b)

    BEFORE ROW
       LET l_ac = ARR_CURR()



###############################################################################
# 新增
###############################################################################

AFTER INSERT


    INSERT INTO trx_file

    VALUES(

        g_trw01,

        g_trx[l_ac].trx02,

        g_trx[l_ac].trx03

    )



###############################################################################
# 修改
###############################################################################

ON ROW CHANGE


    UPDATE trx_file
    SET trx02 = g_trx[l_ac].trx02,trx03 = g_trx[l_ac].trx03
    WHERE trx01 = g_trw01
    AND trx02 = g_trx_t.trx02


###############################################################################
# 删除
###############################################################################

BEFORE DELETE


    DELETE FROM trx_file
    WHERE trx01 = g_trw01
    AND trx02 = g_trx[l_ac].trx02


END INPUT


END FUNCTION
