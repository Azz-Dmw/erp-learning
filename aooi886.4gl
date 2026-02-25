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
    g_ima_t     RECORD LIKE ima_file.*,   # 旧料件基本资料
    g_ima01_t   LIKE ima_file.ima01,      # 旧料件编号
    g_smd       DYNAMIC ARRAY OF RECORD   # 程序变量数组
        smd04   LIKE smd_file.smd04,     # 甲单位数量
        smd02   LIKE smd_file.smd02,     # 甲单位
        smd06   LIKE smd_file.smd06,     # 乙单位数量
        smd03   LIKE smd_file.smd03,     # 乙单位
        smdacti LIKE smd_file.smdacti,   # 数据有效码
        smdpos  LIKE smd_file.smdpos,    
        smddate LIKE smd_file.smddate    # 最近修改日期 
    END RECORD,

    g_smd_t    RECORD                       # 程序变量旧值
        smd04   LIKE smd_file.smd04,
        smd02   LIKE smd_file.smd02,
        smd06   LIKE smd_file.smd06,
        smd03   LIKE smd_file.smd03,
        smdacti LIKE smd_file.smdacti,
        smdpos  LIKE smd_file.smdpos,
        smddate LIKE smd_file.smddate
    END RECORD,
    
    g_smd_tm   RECORD                       # 临时旧值
        smd04   LIKE smd_file.smd04,
        smd02   LIKE smd_file.smd02,
        smd06   LIKE smd_file.smd06,
        smd03   LIKE smd_file.smd03,
        smdacti LIKE smd_file.smdacti,
        smdpos  LIKE smd_file.smdpos,
        smddate LIKE smd_file.smddate
    END RECORD,
    
    g_wc,g_wc2,g_sql STRING,                # SQL语句/临时字符串
    
    g_argv1      LIKE ima_file.ima01,       # 程序参数（料号）
    g_rec_b      LIKE type_file.num5,       # 单身笔数
    i            LIKE type_file.num5,       # 索引
    l_ac         LIKE type_file.num5        # 当前数组计数
    
DEFINE
    g_cnt        LIKE type_file.num10,      # 通用计数器
    g_i          LIKE type_file.num5,
    g_msg        LIKE type_file.chr1000,    # 消息
    g_forupd_sql STRING,                     # SELECT FOR UPDATE
    g_row_count  LIKE type_file.num10,
    g_curs_index LIKE type_file.num10,
    g_jump       LIKE type_file.num10,
    mi_no_ask    LIKE type_file.num5,
    l_table      STRING,                     # 临时表名
    g_str        STRING,
    g_smd02_t    LIKE smd_file.smd02,
    g_smd03_t    LIKE smd_file.smd03,
    g_sw         LIKE type_file.num5

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
    IF (NOT cl_setup("AOO")) THEN
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
    LET l_table = cl_prt_temptable("aooi103", g_sql) CLIPPED

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
    LET p_row = 4 LET p_col = 26
    OPEN WINDOW i103_w AT p_row,p_col
        WITH FORM "aoo/42f/aooi103" ATTRIBUTE (STYLE = g_win_style CLIPPED)

    CALL cl_ui_init()  # 初始化UI控件

    # 控制字段显示
    IF g_aza.aza88 = 'N' THEN
        CALL cl_set_comp_visible('smdpos',FALSE)
    END IF

    # 调用子菜单界面
    CALL i103_mu_ui()
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
        CALL i103_q() 
    END IF

    #进入主操作菜单
    CALL i103_menu()

    #----------------------------#
    # 关闭窗口及退出
    #----------------------------#
    CLOSE WINDOW i103_w
    
    CALL cl_used(g_prog,g_time,2) RETURNING g_time
    
END MAIN
 
#查询资料
FUNCTION i103_cs()

    DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    
 
    IF cl_null(g_argv1) THEN
    
       CLEAR FORM                             #清除畫面
       CALL g_smd.clear()
       CALL cl_set_head_visible("","YES")   
       INITIALIZE g_ima.* TO NULL    
       CONSTRUCT BY NAME g_wc ON 
                 ima01,ima02,ima08,ima06,ima05,ima25,ima44,ima63,ima55  
                ,ima906,ima907,ima31 
               BEFORE CONSTRUCT
               
                  CALL cl_qbe_init()

          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
          ON ACTION CONTROLP
             CASE
               WHEN INFIELD(ima01)

                 CALL q_sel_ima( TRUE, "q_ima","",g_ima.ima01,"","","","","",'')  RETURNING  g_qryparam.multiret

                 DISPLAY g_qryparam.multiret TO ima01
                 NEXT FIELD ima01
              OTHERWISE
                 EXIT CASE
             END CASE
 
          ON ACTION about         
             CALL cl_about()     
 
          ON ACTION help          
             CALL cl_show_help() 
 
          ON ACTION controlg      
             CALL cl_cmdask()    
 
          ON ACTION qbe_select
             CALL cl_qbe_list() RETURNING lc_qbe_sn
             CALL cl_qbe_display_condition(lc_qbe_sn)

       END CONSTRUCT
       
       IF INT_FLAG THEN
          RETURN
       END IF
 
       CONSTRUCT g_wc2 ON smd02,smd03,smddate                               
            FROM s_smd[1].smd02,s_smd[1].smd03,s_smd[1].smddate            
		BEFORE CONSTRUCT
        
		   CALL cl_qbe_display_condition(lc_qbe_sn)

          ON ACTION controlp
             CASE
                WHEN INFIELD(smd02)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gfe"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO smd02
                   NEXT FIELD smd02
                   
                WHEN INFIELD(smd03)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gfe"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO smd03
                   NEXT FIELD smd03
                OTHERWISE EXIT CASE
             END CASE
             
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
          ON ACTION about         
             CALL cl_about()      
 
          ON ACTION help         
             CALL cl_show_help()  
 
          ON ACTION controlg      
             CALL cl_cmdask()     
 
          ON ACTION qbe_save
             CALL cl_qbe_save()

       END CONSTRUCT
       
      IF INT_FLAG THEN
            RETURN
      END IF
      ELSE
         LET g_wc=" ima01='",g_argv1,"'"
         LET g_wc2=' 1=1'

   END IF

    LET g_wc = g_wc CLIPPED,cl_get_extra_cond('imauser', 'imagrup')
 
 
    IF g_wc2 = " 1=1" THEN			# 若單身未輸入條件
       LET g_sql = "SELECT  ima01 FROM ima_file ",
                   " WHERE ", g_wc CLIPPED,
                   " ORDER BY ima01"
    ELSE					# 若單身有輸入條件
       LET g_sql = "SELECT UNIQUE ima_file. ima01 ",
                   "  FROM ima_file, smd_file ",
                   " WHERE ima01 = smd01",
                   "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                   " ORDER BY ima01"
    END IF
 
    PREPARE i103_prepare FROM g_sql
    DECLARE i103_cs                        
        SCROLL CURSOR WITH HOLD FOR i103_prepare
 
    IF g_wc2 = " 1=1" THEN			# 取合乎條件筆數
        LET g_sql="SELECT COUNT(*) FROM ima_file WHERE ",g_wc CLIPPED
    ELSE
        LET g_sql="SELECT COUNT(DISTINCT ima01)",
                  " FROM ima_file,smd_file WHERE ",
                  "smd01=ima01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
    END IF
    
    PREPARE i103_precount FROM g_sql
    
    DECLARE i103_count CURSOR FOR i103_precount
    
END FUNCTION
 
FUNCTION i103_menu()
 
   WHILE TRUE
      CALL i103_bp("G")
      CASE g_action_choice

      #查询功能按钮
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i103_q()
            END IF

         #复制功能按钮
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               #CALL i103_copy()
               MESSAGE "复制功能！"
            END IF

         #单身功能按钮
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i103_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         
         #列印功能按钮
         WHEN "output"
            IF cl_chk_act_auth() THEN 
               CALL i103_out()
            END IF

         WHEN "help"
            CALL cl_show_help()
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

         #相导出Excel功能按钮
         WHEN "exporttoexcel"   
            IF cl_chk_act_auth() THEN
              #CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_smd),'','')
              MESSAGE "导出Excel功能！"
            END IF
 
      END CASE
   END WHILE
END FUNCTION
 
#Query 查詢
FUNCTION i103_q()
      MESSAGE "查询功能！"
END FUNCTION
 
#處理資料的讀取
FUNCTION i103_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,                 #處理方式        
    l_abso          LIKE type_file.num10                 #絕對的筆數    
 
    CASE p_flag
        WHEN 'N' FETCH NEXT     i103_cs INTO g_ima.ima01
        WHEN 'P' FETCH PREVIOUS i103_cs INTO g_ima.ima01
        WHEN 'F' FETCH FIRST    i103_cs INTO g_ima.ima01
        WHEN 'L' FETCH LAST     i103_cs INTO g_ima.ima01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
               PROMPT g_msg CLIPPED,': ' FOR g_jump
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()
 
      ON ACTION about         
         CALL cl_about()            
 
      ON ACTION help          
         CALL cl_show_help()  
 
      ON ACTION controlg      
         CALL cl_cmdask()                                                                    
 
               END PROMPT
               IF INT_FLAG THEN
                   LET INT_FLAG = 0
                   EXIT CASE
               END IF
            END IF
            FETCH ABSOLUTE g_jump i103_cs INTO g_ima.ima01
            LET mi_no_ask = FALSE
    END CASE
 
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_ima.ima01,SQLCA.sqlcode,0)
       INITIALIZE g_ima.* TO NULL              
       RETURN
    ELSE
       CASE p_flag
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
 
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF

    SELECT * INTO g_ima.* FROM ima_file WHERE ima01 = g_ima.ima01

    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","ima_file",g_ima.ima01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660131
       INITIALIZE g_ima.* TO NULL
       RETURN
    END IF
 
    CALL i103_show()

END FUNCTION
 
#將資料顯示在畫面上
FUNCTION i103_show()
   LET g_ima_t.* = g_ima.*                #保存單頭舊值
   DISPLAY BY NAME                              # 顯示單頭值
       g_ima.ima01,g_ima.ima05,g_ima.ima08,g_ima.ima02,g_ima.ima06,
       g_ima.ima25,g_ima.ima44,g_ima.ima63,g_ima.ima55
      ,g_ima.ima906,g_ima.ima907,g_ima.ima31   

   CALL i103_b_fill()                 #单身
   CALL cl_show_fld_cont()                 
END FUNCTION
 
#单身
FUNCTION i103_b()
      MESSAGE "单身功能！"
END FUNCTION


FUNCTION i103_ins_smd()
 DEFINE l_imx000 LIKE imx_file.imx000
 DEFINE l_sql    STRING
 DEFINE l_smd    RECORD LIKE smd_file.*
 DEFINE l_fac    LIKE ima_file.ima31_fac        

   DECLARE smd_ins_upd CURSOR FOR SELECT * FROM smd_file WHERE smd01=g_ima.ima01
   DECLARE smd_ins1_upd CURSOR FOR SELECT imx000 FROM imx_file WHERE imx00=g_ima.ima01

   DELETE FROM smd_file WHERE smd01 IN (SELECT imx000 FROM imx_file WHERE imx00=g_ima.ima01)
   IF SQLCA.sqlcode THEN
      CALL cl_err3("del","smd_file","","",SQLCA.sqlcode,"","",1)
   END IF

   FOREACH smd_ins_upd INTO l_smd.*
      FOREACH smd_ins1_upd INTO l_imx000
         LET l_smd.smd01=l_imx000
         INSERT INTO smd_file VALUES(l_smd.*)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","smd_file",l_smd.smd01,"",SQLCA.sqlcode,"","",1)
            CONTINUE FOREACH
         END IF
      END FOREACH

   END FOREACH

   IF g_ima.ima31 <> g_ima.ima25 THEN
      CALL s_umfchk(g_ima.ima01,g_ima.ima31,g_ima.ima25)
           RETURNING g_sw,l_fac
      IF g_sw = '0' AND l_fac <> g_ima.ima31_fac THEN
         UPDATE ima_file
            SET ima31_fac = l_fac
          WHERE ima01 = g_ima.ima01
      END IF
   END IF
   IF g_ima.ima44 <> g_ima.ima25 THEN
      CALL s_umfchk(g_ima.ima01,g_ima.ima44,g_ima.ima25)
           RETURNING g_sw,l_fac
      IF g_sw = '0' AND l_fac <> g_ima.ima44_fac THEN
         UPDATE ima_file
            SET ima44_fac = l_fac
          WHERE ima01 = g_ima.ima01
      END IF
   END IF
   IF g_ima.ima55 <> g_ima.ima25 THEN
      CALL s_umfchk(g_ima.ima01,g_ima.ima55,g_ima.ima25)
           RETURNING g_sw,l_fac
      IF g_sw = '0' AND l_fac <> g_ima.ima55_fac THEN
         UPDATE ima_file
            SET ima55_fac = l_fac
          WHERE ima01 = g_ima.ima01
      END IF
   END IF
   IF g_ima.ima63 <> g_ima.ima25 THEN
      CALL s_umfchk(g_ima.ima01,g_ima.ima63,g_ima.ima25)
           RETURNING g_sw,l_fac
      IF g_sw = '0' AND l_fac <> g_ima.ima63_fac THEN
         UPDATE ima_file
            SET ima63_fac = l_fac
          WHERE ima01 = g_ima.ima01
       END IF
   END IF
   IF g_ima.ima86 <> g_ima.ima25 THEN
      CALL s_umfchk(g_ima.ima01,g_ima.ima86,g_ima.ima25)
           RETURNING g_sw,l_fac
      IF g_sw = '0' AND l_fac <> g_ima.ima86_fac THEN
         UPDATE ima_file
            SET ima86_fac = l_fac
          WHERE ima01 = g_ima.ima01
      END IF
   END IF

END FUNCTION

 
FUNCTION i103_b_askkey()
DEFINE
    l_wc2    LIKE type_file.chr1000       
 
    CONSTRUCT l_wc2 ON smd04,smd02,smd06,smd03,smdacti  
         FROM s_smd[1].smd04,s_smd[1].smd02,s_smd[1].smd06,s_smd[1].smd03,
              s_smd[1].smdacti  

              BEFORE CONSTRUCT
                 CALL cl_qbe_init()

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION help          
         CALL cl_show_help()  
 
      ON ACTION controlg      
         CALL cl_cmdask()    
 
 

                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()

    END CONSTRUCT
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       RETURN
    END IF
    CALL i103_b_fill()
END FUNCTION
 
FUNCTION i103_b_fill()             
      MESSAGE "单身功能！"
END FUNCTION
 
 
FUNCTION i103_bp(p_ud)

   DEFINE   p_ud   LIKE type_file.chr1          
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_smd TO s_smd.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

      ON ACTION first
         CALL i103_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   

         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  
         END IF
         ACCEPT DISPLAY                   
 
      ON ACTION previous
         CALL i103_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  

         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  
         END IF
	      ACCEPT DISPLAY                   
 
 
      ON ACTION jump
         CALL i103_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   

         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  
         END IF
	      ACCEPT DISPLAY                   
 
 
      ON ACTION next
         CALL i103_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  

         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  
         END IF
	      ACCEPT DISPLAY                   
 
 
      ON ACTION last
         CALL i103_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  
         END IF
	      ACCEPT DISPLAY                   
 
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY

      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY

      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   
         CALL i103_mu_ui()   
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
 
      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY
 
      ON ACTION cancel
             LET INT_FLAG=FALSE 		
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about        
         CALL cl_about()      
 
       #ON ACTION 相关文件
       ON ACTION related_document  
         LET g_action_choice="related_document"
         EXIT DISPLAY
 
      ON ACTION exporttoexcel   
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
      AFTER DISPLAY
         CONTINUE DISPLAY
                                                                                           
     ON ACTION controls                                                                                                             
         CALL cl_set_head_visible("","AUTO")                                                                                        

      &include "qry_string.4gl"
   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION
 
 
FUNCTION i103_out()
         MESSAGE "打印功能！"
END FUNCTION
 
 
FUNCTION i103_mu_ui()

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


FUNCTION i103_smd06_check()

   IF NOT cl_null(g_smd[l_ac].smd06) AND NOT cl_null(g_smd[l_ac].smd03) THEN
      IF cl_null(g_smd_t.smd06) OR cl_null(g_smd03_t) OR g_smd_t.smd06 != g_smd[l_ac].smd06 OR g_smd03_t != g_smd[l_ac].smd03 THEN  
         LET g_smd[l_ac].smd06=s_digqty(g_smd[l_ac].smd06,g_smd[l_ac].smd03)
         DISPLAY BY NAME g_smd[l_ac].smd06
      END IF
   END IF

   IF NOT cl_null(g_smd[l_ac].smd06) THEN
      IF g_smd[l_ac].smd06 <=0 THEN
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE

END FUNCTION

FUNCTION i103_smd04_check()

   IF NOT cl_null(g_smd[l_ac].smd04) AND NOT cl_null(g_smd[l_ac].smd02) THEN
      IF cl_null(g_smd_t.smd04) OR cl_null(g_smd02_t) OR g_smd_t.smd04 != g_smd[l_ac].smd04 OR g_smd02_t != g_smd[l_ac].smd02 THEN       
         LET g_smd[l_ac].smd04=s_digqty(g_smd[l_ac].smd04,g_smd[l_ac].smd02)
         DISPLAY BY NAME g_smd[l_ac].smd04
      END IF
   END IF

END FUNCTION

