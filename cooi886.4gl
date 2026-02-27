# Prog. Version..: '5.30.15-14.10.14(00010)' 
# Descriptions...: 料件單位換算資料維護作業(aooi886)
# Date & Author..: 2026/02/25 By Azz

DATABASE ds                             # 指定数据库连接

GLOBALS "../../config/top.global"       # 引入全局变量

#----------------------------#
# 变量定义
#----------------------------#
DEFINE
    g_ima       RECORD LIKE ima_file.*,   # 当前料件基本资料
    g_smd       DYNAMIC ARRAY OF RECORD   # 程序变量数组
        smd04   LIKE smd_file.smd04,     # 甲单位数量
        smd02   LIKE smd_file.smd02,     # 甲单位
        smd06   LIKE smd_file.smd06,     # 乙单位数量
        smd03   LIKE smd_file.smd03,     # 乙单位
        smdacti LIKE smd_file.smdacti,   # 数据有效码
        smdpos  LIKE smd_file.smdpos,    
        smddate LIKE smd_file.smddate    # 最近修改日期 
    END RECORD,
    
    g_sql         STRING,                # SQL语句/临时字符串
    g_argv1       LIKE ima_file.ima01,       # 程序参数（料号）
    g_rec_b       LIKE type_file.num5,       # 单身笔数
    g_msg         LIKE ze_file.ze03,
    g_row_count   LIKE type_file.num10,       
    g_curs_index  LIKE type_file.num10,
    g_forupd_sql  STRING,                    # SELECT FOR UPDATE
    l_table       STRING                     # 临时表名
 
   
    
#----------------------------#
# 主程序
#----------------------------#
MAIN
    DEFINE p_row,p_col LIKE type_file.num5     # 窗口行列

    OPTIONS
        INPUT NO WRAP                           # 输入不换行
        DEFER INTERRUPT                          # 拦截中断键

    # 用户验证
    IF (NOT cl_user()) THEN
        EXIT PROGRAM
    END IF

    # 全局错误处理
    WHENEVER ERROR CALL cl_err_msg_log

    # 系统初始化
    IF (NOT cl_setup("COO")) THEN
        EXIT PROGRAM
    END IF

    # 获取程序参数
    LET g_argv1 = ARG_VAL(1)

    # 程序进入时间统计
    CALL cl_used(g_prog,g_time,1) RETURNING g_time
    

#----------------------------#
# 临时表创建
#----------------------------#
    
    #作用：为临时表定义列结构
    LET g_sql = "smd01.smd_file.smd01,",
                "smd02.smd_file.smd02,",
                "smd03.smd_file.smd03,",
                "smd04.smd_file.smd04,",
                "smd06.smd_file.smd06,",
                "smd05.smd_file.smd05,",
                "smdacti.smd_file.smdacti,",
                "ima02.ima_file.ima02"

    #根据字段列表创建一个临时表，并把临时表名赋给变量 l_table，方便后续操作临时数据。
    LET l_table = cl_prt_temptable("cooi886", g_sql) CLIPPED

    #检查是否创建成功,cl_prt_temptable 如果创建失败会返回 -1,判断失败时，直接退出程序。
    IF l_table = -1 THEN 
        EXIT PROGRAM 
    END IF

    #构造一条 插入临时表的 SQL，后续使用预处理插入数据
    LET g_sql = "INSERT INTO ", g_cr_db_str CLIPPED, l_table CLIPPED,
                " VALUES(?,?,?,?,?,?,?,?)"

    {生成一个预处理语句 insert_prep,可以在后续循环中多次执行 EXECUTE insert_prep USING ... 插入多条数据
    优点：提高性能、减少重复 SQL 编译开销}
    PREPARE insert_prep FROM g_sql

    {STATUS：检查上一条命令是否报错,如果报错，调用 cl_err 打印错误信息
        作用：保证 SQL 语句成功准备，避免后续插入数据报错}
    IF STATUS THEN
        CALL cl_err("insert_prep:",status,1)
    END IF

#----------------------------#
# 打开窗口
#----------------------------#
    LET p_row = 4 LET p_col = 32

    OPEN WINDOW i886_w AT p_row,p_col
        WITH FORM "coo/42f/cooi886" ATTRIBUTE (STYLE = g_win_style CLIPPED)

    CALL cl_ui_init()  # 初始化UI控件

    # 调用子菜单界面
    CALL i886_mu_ui()
    CALL cl_set_comp_visible('smdpos',FALSE)

    #----------------------------#
    # 数据查询及锁定
    #----------------------------#
    LET g_forupd_sql = "SELECT * FROM ima_file WHERE ima01 = ? FOR UPDATE"  #FOR UPDATE 锁定这条记录
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)  #将FOR UPDATE自动转换成数据库适配语法

    #声明游标
    DECLARE i103_cl CURSOR FROM g_forupd_sql

    #如果用户启动程序时指定料号：自动查询，不用手动输入
    IF NOT cl_null(g_argv1) THEN 
        CALL i886_q() 
    END IF

    #进入主操作菜单
    CALL i103_menu()

    #----------------------------#
    # 关闭窗口及退出
    #----------------------------#
    CLOSE WINDOW i886_w
    
    CALL cl_used(g_prog,g_time,2) RETURNING g_time
    
END MAIN
 
#----------------------------#
# 主菜单
#----------------------------#
FUNCTION i103_menu()

   WHILE TRUE
      CALL i103_bp("G")
      CASE g_action_choice

      #新增功能按钮
        WHEN "insert"
           IF cl_chk_act_auth() THEN
              CALL i103_a()
           END IF

      #查询功能按钮
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i886_q()
            END IF

         #复制功能按钮
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               MESSAGE "复制功能！"
            END IF

         #离开功能按钮
        WHEN "exit"
            EXIT WHILE

         WHEN "controlg"
            CALL cl_cmdask()
         
         #相关附件功能按钮
          WHEN "related_document"  #No.MOD-470515
            IF cl_chk_act_auth() THEN
               IF g_ima.ima01 IS NOT NULL THEN
                  LET g_doc.column1 = "ima01"
                  LET g_doc.value1 = g_ima.ima01
                  CALL cl_doc()
               END IF
            END IF
 
      END CASE
   END WHILE
END FUNCTION
 
#----------------------------#
# 菜单显示及操作
#----------------------------#
FUNCTION i103_bp(p_ud)

   DEFINE   p_ud   LIKE type_file.chr1          
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_smd TO s_smd.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      {BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )}

      #新增
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY      
 
      #查询
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

      #复制       
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
 
      #语言
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   
         CALL i886_mu_ui()   
 
      #退出
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      #查询窗口
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
 
      #放弃
      ON ACTION cancel
             LET INT_FLAG=FALSE 		
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY  
 
       #ON ACTION 相关文件
       ON ACTION related_document  
         LET g_action_choice="related_document"
         EXIT DISPLAY
 
      AFTER DISPLAY
         CONTINUE DISPLAY
                                                                                           
     ON ACTION controls                                                                                                             
         CALL cl_set_head_visible("","AUTO")                                                                                        

      &include "qry_string.4gl"
   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION
 
#----------------------------#
# 界面显示控制
#----------------------------#
{界面显示控制：根据配置或权限控制哪些控件可见。
动态文本提示：根据配置或状态动态显示提示信息。
UI 初始化或刷新时调用：在主程序里，每次打开窗口或切换语言时会调用 i886_mu_ui()，保证界面显示正确。}
FUNCTION i886_mu_ui()
      {cl_set_comp_visible(控件名, 条件) 用来设置某个界面控件是否可见。
      g_sma.sma115 是全局配置或权限标志，如果等于 'Y'，就显示对应控件，否则隐藏。
      也就是说，这里根据 用户权限或系统参数 决定界面上哪些输入框或分组显示}
    CALL cl_set_comp_visible("ima906",g_sma.sma115 = 'Y')
    CALL cl_set_comp_visible("group043",g_sma.sma115 = 'Y')
    CALL cl_set_comp_visible("ima907",g_sma.sma115 = 'Y')
    CALL cl_set_comp_visible("group044",g_sma.sma115='Y')

    IF g_sma.sma122='1' THEN
       CALL cl_getmsg('asm-302',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("ima907",g_msg CLIPPED)
    END IF

    IF g_sma.sma122='2' THEN
       CALL cl_getmsg('asm-304',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("ima907",g_msg CLIPPED)
    END IF

END FUNCTION

#====================================================
# 新增功能实现
#====================================================
FUNCTION i103_a()

   MESSAGE "新增功能！"

END FUNCTION 


#----------------------------#
# 查詢功能实现主流程
#----------------------------#
FUNCTION i886_q()

    #1.输入查询条件
    CALL i886_cs()
    IF cl_null(g_argv1) THEN 
        RETURN 
    END IF 

    #2.读取主档
    CALL i886_fetch()
    IF STATUS THEN 
        CALL cl_msg("查无资料！")
        RETURN 
    END IF 

    #3.查询单身资料
    CALL i886_b_fill()

    # 4. 刷新画面显示
    CALL i886_show()  # 显示主档


END FUNCTION

#-------------------------------------------------
# 查询条件输入
#-------------------------------------------------
FUNCTION i886_cs()

    CLEAR FORM  #输入查询条件之前清除画面档form

    #开窗输入
    INPUT BY NAME g_ima.ima01 WITHOUT DEFAULTS 

    #主键变量赋值
    LET g_argv1 = g_ima.ima01

    DISPLAY "你输入的料件编号：",g_argv1

END FUNCTION 

#-------------------------------------------------
# 读取主档
#-------------------------------------------------
FUNCTION i886_fetch()

    DEFINE l_cnt LIKE type_file.num5    #声明局部变量记录单头是否有数据

    SELECT COUNT(*)
      INTO l_cnt
      FROM ima_file
     WHERE ima01 = g_argv1

    DISPLAY  "COUNT = ", l_cnt

    #单头没数据直接退出
    IF l_cnt = 0 THEN
        RETURN
    END IF

    #有数据将数据赋值给g_ima.*
    SELECT *
      INTO g_ima.*
      FROM ima_file
     WHERE ima01 = g_argv1

     DISPLAY "单头数据：",g_ima.*
     DISPLAY "品名=", g_ima.ima02

END FUNCTION


#-------------------------------------------------
# 单身资料遍历填充
#-------------------------------------------------
FUNCTION i886_b_fill()

    DEFINE l_cnt LIKE type_file.num5
    DEFINE l_smd_rec RECORD
        smd04   LIKE smd_file.smd04,
        smd02   LIKE smd_file.smd02,
        smd06   LIKE smd_file.smd06,
        smd03   LIKE smd_file.smd03,
        smdacti LIKE smd_file.smdacti,
        smdpos  LIKE smd_file.smdpos,
        smddate LIKE smd_file.smddate
    END RECORD

    # 清空数组
    LET g_smd = NULL    # 重置数组长度为0
    LET g_rec_b = 0

    # 查询循环遍历单身资料
    #声明游标
    DECLARE smd_cur CURSOR FOR
        SELECT smd04,smd02,smd06,smd03,smdacti,smdpos,smddate
        FROM smd_file
        WHERE smd01 = g_argv1
        ORDER BY smdpos

    LET l_cnt = 0
    #循环遍历
    FOREACH smd_cur INTO l_smd_rec.*
        LET l_cnt = l_cnt + 1
        LET g_smd[l_cnt].smd04   = l_smd_rec.smd04
        LET g_smd[l_cnt].smd02   = l_smd_rec.smd02
        LET g_smd[l_cnt].smd06   = l_smd_rec.smd06
        LET g_smd[l_cnt].smd03   = l_smd_rec.smd03
        LET g_smd[l_cnt].smdacti = l_smd_rec.smdacti
        LET g_smd[l_cnt].smdpos  = l_smd_rec.smdpos
        LET g_smd[l_cnt].smddate = l_smd_rec.smddate
    END FOREACH

    LET g_rec_b = l_cnt

    DISPLAY "单身条数： ",g_rec_b

END FUNCTION

#-------------------------------------------------
# 显示主档资料
#-------------------------------------------------
FUNCTION i886_show()

    CLEAR FORM  #显示主档之前先清理画面档form

    #显示单头数据
    DISPLAY BY NAME g_ima.ima01,g_ima.ima02,g_ima.ima08,g_ima.ima06,g_ima.ima05,g_ima.ima25
    DISPLAY BY NAME g_ima.ima44,g_ima.ima31,g_ima.ima63,g_ima.ima55
    
END FUNCTION 

