# Prog. Version..: '5.30.15-14.10.14(00010)'     #
#
# Descriptions...: 料件單位換算資料維護作業(aooi103)
# Date & Author..: 91/08/10 By Nora
# Date & Author..: 91/09/30 By May  反向單位資料
# Modify.........: 92/05/06 By David Wang
#----------------------------deBUG History------------------------------
# 1992/09/25(Lee):在輸入單身時, 無法按ESC 結束. 單身原輸入時, 在甲單
#    位地方判斷一定要輸入值後, 方可結束該欄位的其餘動作, 造成esc 鍵無
#    效, 故將該判斷改成在after field smd02時判斷若非null, 則為相關的
#    判斷, 在before field smd03時, 先判斷該smd02是否為null, 若null則
#    不允許進入該欄位即可.
# 1992/09/25(Lee): 在單身輸入後, 程式會自動增加一筆反相的資料, 但會將
#    資料insert到第三個line中, 而留第二個line再輸入其他值, 造成困擾.
#    程式原先在insert反相的資料後, 只單純的將資料顯示在第三行, 造成上
#    述現象. 改進的方式為: 在insert該筆資料後, 重填array, exit input
#    再重進input array, 如此便可
# genero  script marked # 1992/09/25(Lee): 在單身按arrow key移動時, arrow的欄位reverse. 原因是
#    雖然在相對的地方有做清除, 但有. 已拿掉該attribute


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
        smdpos  LIKE smd_file.smdpos,    # FUN-870100
        smddate LIKE smd_file.smddate    # 最近修改日期 TQC-B90002
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
 
#QBE 查詢資料
FUNCTION i103_cs()

    DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
 
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
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i103_q()
            END IF
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               #CALL i103_copy()
               MESSAGE "复制功能！"
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i103_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output"
            IF cl_chk_act_auth()
               THEN CALL i103_out()
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
          WHEN "related_document"  #No.MOD-470515
            IF cl_chk_act_auth() THEN
               IF g_ima.ima01 IS NOT NULL THEN
                  LET g_doc.column1 = "ima01"
                  LET g_doc.value1 = g_ima.ima01
                  CALL cl_doc()
               END IF
            END IF
         WHEN "exporttoexcel"   #No.FUN-4B0020
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_smd),'','')
            END IF
 
      END CASE
   END WHILE
END FUNCTION
 
#Query 查詢
FUNCTION i103_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    MESSAGE ""
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL i103_cs()
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       RETURN
    END IF
    OPEN i103_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
       CALL cl_err('',SQLCA.sqlcode,0)
       INITIALIZE g_ima.* TO NULL
    ELSE
       OPEN i103_count
       FETCH i103_count INTO g_row_count
       DISPLAY g_row_count TO FORMONLY.cnt
       CALL i103_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
END FUNCTION
 
#處理資料的讀取
FUNCTION i103_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,                 #處理方式        #No.FUN-680102 VARCHAR(1)
    l_abso          LIKE type_file.num10                 #絕對的筆數        #No.FUN-680102 INTEGER
 
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

   CALL i103_b_fill(g_wc2)                 #单身
   CALL cl_show_fld_cont()                 
END FUNCTION
 
#單身
FUNCTION i103_b()
DEFINE
   l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT        #No.FUN-680102 SMALLINT
   l_n             LIKE type_file.num5,                #檢查重複用        #No.FUN-680102 SMALLINT
   l_lock_sw       LIKE type_file.chr1,                 #單身鎖住否        #No.FUN-680102 VARCHAR(1)
   p_cmd           LIKE type_file.chr1,                 #處理狀態        #No.FUN-680102 VARCHAR(1)
   acti_tm         LIKE type_file.chr1,           # Prog. Version..: '5.30.15-14.10.14(01),             #
   l_sw            LIKE type_file.chr1,           # Prog. Version..: '5.30.15-14.10.14(01),            #可更改否 (含取消)
   sw              LIKE type_file.chr1,           # Prog. Version..: '5.30.15-14.10.14(01),            #可更改否 (含取消)
   l_allow_insert  LIKE type_file.chr1,           # Prog. Version..: '5.30.15-14.10.14(01),           #可新增否
   l_allow_delete  LIKE type_file.chr1,           # Prog. Version..: '5.30.15-14.10.14(01)           #可刪除否
   #l_azo06         LIKE azo_file.azo06,           #No.CHI-BB0048 #FUN-DA0126
   #l_azo05         LIKE azo_file.azo05,           #No.CHI-BB0048 #FUN-DA0126
   l_fac           LIKE ima_file.ima31_fac        #CHI-D90022
 
   LET g_action_choice = ""
   IF s_shut(0) THEN RETURN END IF
   IF g_ima.ima01 IS NULL
      THEN RETURN
   END IF
   SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_ima.ima01
   IF g_ima.imaacti ='N'
      THEN CALL cl_err(g_ima.ima01,'mfg1000',0)     #檢查資料是否為無效
      RETURN
   END IF

#FUN-B90104----add--begin---- 服飾行業，子料件不可更改
   IF s_industry('slk') THEN
      IF g_ima.ima151='N' AND g_ima.imaag='@CHILD' THEN
         CALL cl_err(g_ima.ima01,'axm_665',1)
         RETURN
      END IF
   END IF
#FUN-B90104----add--end---
 
   LET l_allow_insert = cl_detail_input_auth('insert')
   LET l_allow_delete = cl_detail_input_auth('delete')
   LET g_action_choice = ""
 
   CALL cl_opmsg('b')
 
  #LET g_forupd_sql = "SELECT smd04,smd02,smd06,smd03,smdacti,smdpos",   #FUN-870100
   LET g_forupd_sql = "SELECT smd04,smd02,smd06,smd03,smdacti,smdpos,smddate",   #TQC-B90002 add smddate
                      "  FROM smd_file  WHERE smd01=? AND smd02=?",
                      "   AND smd03=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i103_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   INPUT ARRAY g_smd WITHOUT DEFAULTS FROM s_smd.*
         ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
      BEFORE INPUT
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF
         #No.FUN-BB0086--add--begin--
         LET g_smd02_t = NULL   
         LET g_smd03_t = NULL
         #No.FUN-BB0086--add--end--
 
      BEFORE ROW
          LET p_cmd=''
          LET l_ac = ARR_CURR()
          LET l_lock_sw = 'N'            #DEFAULT
          LET l_n  = ARR_COUNT()
          BEGIN WORK
          OPEN i103_cl USING g_ima.ima01
          IF SQLCA.sqlcode
             THEN CALL cl_err(g_ima.ima01,SQLCA.sqlcode,0)
             CLOSE i103_cl
             ROLLBACK WORK
             RETURN
          ELSE
             FETCH i103_cl INTO g_ima.*
             IF SQLCA.sqlcode
                THEN CALL cl_err(g_ima.ima01,SQLCA.sqlcode,0)
                CLOSE i103_cl
                ROLLBACK WORK
                RETURN
              END IF
          END IF
          IF g_rec_b >= l_ac THEN
             LET p_cmd='u'
             LET g_smd_t.* = g_smd[l_ac].*  #BACKUP
             #No.FUN-BB0086--add--begin--
             LET g_smd02_t = g_smd[l_ac].smd02
             LET g_smd03_t = g_smd[l_ac].smd03
             #No.FUN-BB0086--add--end--
             OPEN i103_bcl USING g_ima.ima01,g_smd_t.smd02,g_smd_t.smd03               #表示更改狀態
             IF SQLCA.sqlcode THEN
                CALL cl_err(g_smd_t.smd02,SQLCA.sqlcode,1)
                LET l_lock_sw = "Y"
             ELSE
                FETCH i103_bcl INTO g_smd[l_ac].*
                IF SQLCA.sqlcode THEN
                   CALL cl_err(g_smd_t.smd02,SQLCA.sqlcode,1)
                   LET l_lock_sw="Y"
                END IF
             END IF
             CALL cl_show_fld_cont()     #FUN-550037(smin)
          END IF
 
      BEFORE INSERT
         LET l_n = ARR_COUNT()
         LET p_cmd='a'
         INITIALIZE g_smd[l_ac].* TO NULL      #900423
         LET g_smd[l_ac].smd04=1               #DEFAULT
         LET g_smd[l_ac].smd06=1
         LET g_smd[l_ac].smdacti='Y'
         #LET g_smd[l_ac].smdpos='N'           #FUN-870100 #FUN-B50042 mark 
         #DISPLAY BY NAME g_smd[l_ac].smdpos   #FUN-870100 #FUN-B50042 mark
         LET g_smd[l_ac].smddate=g_today       #TQC-B90002  
         LET g_smd_t.* = g_smd[l_ac].*         #新輸入資料
         CALL cl_show_fld_cont()     #FUN-550037(smin)
         NEXT FIELD smd04
 
      AFTER INSERT
         IF INT_FLAG THEN                      #900423
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         INSERT INTO smd_file (smd01,smd02,smd03,smd04,smd06,smdacti,smddate)      #FUN-870100   #MOD-C30093 add smddate
                       VALUES (g_ima.ima01,g_smd[l_ac].smd02,
                               g_smd[l_ac].smd03,g_smd[l_ac].smd04,
                               g_smd[l_ac].smd06,g_smd[l_ac].smdacti,g_smd[l_ac].smddate)   #FUN-870100 #FUN-B50042 remove POS  ##MOD-C30093 add g_smd[l_ac].smddate
         IF SQLCA.sqlcode THEN
#           CALL cl_err(g_smd[l_ac].smd02,SQLCA.sqlcode,0)   #No.FUN-660131
            CALL cl_err3("ins","smd_file",g_smd[l_ac].smd02,"",SQLCA.sqlcode,"","",1)  #No.FUN-660131
            CANCEL INSERT
         ELSE
            #CHI-D90022---begin
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
            #CHI-D90022---end
            MESSAGE 'INSERT O.K'
            LET g_rec_b=g_rec_b+1
            DISPLAY g_rec_b TO FORMONLY.cn2
            #CHI-DA0034---begin
            IF g_smd[l_ac].smd02 <> g_smd[l_ac].smd03 THEN 
               UPDATE smd_file
                  SET smd04 = g_smd[l_ac].smd06,
                      smd06 = g_smd[l_ac].smd04,
                      smdacti = g_smd[l_ac].smdacti,
                      smddate=g_smd[l_ac].smddate
                WHERE smd02 = g_smd[l_ac].smd03
                  AND smd03 = g_smd[l_ac].smd02
                  AND smd01 = g_ima.ima01
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                  LET l_ac = ARR_CURR()
                  INSERT INTO smd_file (smd01,smd02,smd03,smd04,smd06,smdacti,smddate)     
                                VALUES (g_ima.ima01,g_smd[l_ac].smd03,
                                        g_smd[l_ac].smd02,g_smd[l_ac].smd06,
                                        g_smd[l_ac].smd04,g_smd[l_ac].smdacti,g_smd[l_ac].smddate) 
                  IF SQLCA.sqlcode THEN
                     CALL cl_err3("ins","smd_file",g_smd[l_ac].smd02,"",SQLCA.sqlcode,"","",1) 
                     CANCEL INSERT
                  ELSE
                     MESSAGE 'INSERT O.K'
                     LET g_rec_b = g_rec_b+1
                     LET g_smd[g_rec_b].smd03=g_smd[l_ac].smd02
                     LET g_smd[g_rec_b].smd02=g_smd[l_ac].smd03
                     LET g_smd[g_rec_b].smd04=g_smd[l_ac].smd06
                     LET g_smd[g_rec_b].smd06=g_smd[l_ac].smd04
                     LET g_smd[g_rec_b].smdacti=g_smd[l_ac].smdacti
                     LET g_smd[g_rec_b].smddate=g_smd[l_ac].smddate
                     DISPLAY g_rec_b TO FORMONLY.cn2  
                  END IF 
               ELSE
                  #若update成功且反向資料處於同一螢幕時的DISPLAY
                  FOR i = 1 TO g_smd.getLength()
                     IF g_smd[i].smd03 = g_smd[l_ac].smd02 AND 
                        g_smd[i].smd02 = g_smd[l_ac].smd03 THEN
                        LET g_smd[i].smd03=g_smd[l_ac].smd02
                        LET g_smd[i].smd02=g_smd[l_ac].smd03
                        LET g_smd[i].smd04=g_smd[l_ac].smd06
                        LET g_smd[i].smd06=g_smd[l_ac].smd04
                        LET g_smd[i].smdacti=g_smd[l_ac].smdacti
                        LET g_smd[i].smddate=g_smd[l_ac].smddate
                        EXIT FOR 
                     END IF
                  END FOR  
               END IF 
            END IF     
            #CHI-DA0034---end
         END IF
 
      AFTER FIELD smd02                        #check 甲單位是否重複
         IF NOT cl_null(g_smd[l_ac].smd02) THEN
            IF g_smd[l_ac].smd02 != g_smd_t.smd02 OR g_smd_t.smd02 IS NULL THEN
               SELECT * FROM gfe_file WHERE gfe01 = g_smd[l_ac].smd02
               IF SQLCA.sqlcode THEN
#                 CALL cl_err(g_smd[l_ac].smd02,'aoo-012',0)   #No.FUN-660131
                  CALL cl_err3("sel","gfe_file",g_smd[l_ac].smd02,"","aoo-012","","",1)  #No.FUN-660131
                  LET g_smd[l_ac].smd02 = g_smd_t.smd02
                  NEXT FIELD smd02
               END IF
            END IF
            #No.FUN-BB0086--add--begin--
            CALL i103_smd04_check()
            LET g_smd02_t = g_smd[l_ac].smd02
            #No.FUN-BB0086--add--end--
         END IF

      #No.FUN-BB0086--add--begin--
      AFTER FIELD smd04
         CALL i103_smd04_check()
      #No.FUN-BB0086--add--end--
 
      AFTER FIELD smd06
         IF NOT i103_smd06_check() THEN NEXT FIELD smd06 END IF   #No.FUN-BB0086

 
      AFTER FIELD smd03
        IF g_smd_t.smd03 IS NOT NULL THEN
           IF g_smd[l_ac].smd03 IS NULL THEN  #重要欄位空白,無效
              LET g_smd[l_ac].smd03 = g_smd_t.smd03
              NEXT FIELD smd03
           END IF
        END IF
        IF NOT cl_null(g_smd[l_ac].smd03) THEN
           IF g_smd[l_ac].smd03 != g_smd_t.smd03 OR g_smd_t.smd03 IS NULL THEN
              SELECT * FROM gfe_file WHERE gfe01 = g_smd[l_ac].smd03
              IF SQLCA.sqlcode THEN
#                CALL cl_err(g_smd[l_ac].smd03,'aoo-012',0)   #No.FUN-660131
                 CALL cl_err3("sel","gfe_file",g_smd[l_ac].smd03,"","aoo-012","","",1)  #No.FUN-660131
                 LET g_smd[l_ac].smd03 = g_smd_t.smd03
                 NEXT FIELD smd03
               END IF
             #檢查資料是否重覆(1992/09/25 Lee)
              SELECT COUNT(*) INTO g_cnt FROM smd_file WHERE smd01=g_ima.ima01
                 AND smd02=g_smd[l_ac].smd02 AND smd03=g_smd[l_ac].smd03
              IF g_cnt>0 THEN
                 CALL cl_err(g_smd[l_ac].smd03,-239,0)
                 LET g_smd[l_ac].smd02 = g_smd_t.smd02
                 LET g_smd[l_ac].smd03 = g_smd_t.smd03
                 NEXT FIELD smd03
              END IF
           END IF
           #No.FUN-BB0086--add--begin--
           IF NOT i103_smd06_check() THEN NEXT FIELD smd03 END IF   
           LET g_smd03_t = g_smd[l_ac].smd03
           #No.FUN-BB0086--add--end--
        END IF
 
      BEFORE DELETE                            #是否取消單身
        IF g_smd_t.smd02 != ' ' AND g_smd_t.smd02 IS NOT NULL THEN

 
           IF NOT cl_delb(0,0) THEN
              CANCEL DELETE
           END IF
           IF l_lock_sw = "Y" THEN
              CALL cl_err("", -263, 1)
              CANCEL DELETE
           END IF
           DELETE FROM smd_file
            WHERE smd01 = g_ima.ima01
              AND smd02 = g_smd[l_ac].smd02
              AND smd03 = g_smd[l_ac].smd03
           IF SQLCA.sqlcode THEN
#             CALL cl_err(g_smd_t.smd02,SQLCA.sqlcode,0)   #No.FUN-660131
              CALL cl_err3("del","smd_file",g_smd_t.smd02,"",SQLCA.sqlcode,"","",1)  #No.FUN-660131
              CLOSE i103_bcl
              ROLLBACK WORK
              CANCEL DELETE
           ELSE
              LET g_rec_b=g_rec_b-1
              DISPLAY g_rec_b TO FORMONLY.cn2
              MESSAGE "Delete Ok"
              CLOSE i103_bcl
              COMMIT WORK
           END IF

        END IF

      ON ROW CHANGE
         IF INT_FLAG THEN                 #新增程式段
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            LET g_smd[l_ac].* = g_smd_t.*
            CLOSE i103_bcl
            ROLLBACK WORK
            EXIT INPUT
         END IF

 
         IF l_lock_sw = 'Y' THEN
            CALL cl_err(g_smd[l_ac].smd02,-263,1)
            LET g_smd[l_ac].* = g_smd_t.*
         ELSE
            LET g_smd[l_ac].smddate = g_today   #TQC-B90002
            UPDATE smd_file SET smd02=g_smd[l_ac].smd02,
                                smd03=g_smd[l_ac].smd03,
                                smd04=g_smd[l_ac].smd04,
                                smd06=g_smd[l_ac].smd06,
                                smdacti=g_smd[l_ac].smdacti,
                                #smdpos=g_smd[l_ac].smdpos #FUN-870100 #FUN-B50042 mark
                                smddate=g_smd[l_ac].smddate   #TQC-B90002
             WHERE smd01=g_ima.ima01
               AND smd02=g_smd_t.smd02
               AND smd03=g_smd_t.smd03
            IF SQLCA.sqlcode THEN
#              CALL cl_err(g_smd[l_ac].smd02,SQLCA.sqlcode,0)   #No.FUN-660131
               CALL cl_err3("upd","smd_file",g_ima.ima01,g_smd_t.smd02,SQLCA.sqlcode,"","",1)  #No.FUN-660131
               LET g_smd[l_ac].* = g_smd_t.*
            ELSE
               #CHI-D90022---begin
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
               #CHI-D90022---end
               #CHI-DA0034---begin
               IF g_smd[l_ac].smd02 <> g_smd[l_ac].smd03 THEN 
                  UPDATE smd_file SET smd02=g_smd[l_ac].smd03,
                                      smd04=g_smd[l_ac].smd06,
                                      smd03=g_smd[l_ac].smd02,
                                      smd06=g_smd[l_ac].smd04,
                                      smdacti=g_smd[l_ac].smdacti,
                                      smddate=g_smd[l_ac].smddate
                   WHERE smd03 = g_smd_t.smd02 AND smd02 = g_smd_t.smd03 AND smd01 = g_ima.ima01
                  IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                     LET l_ac = ARR_CURR()
                     INSERT INTO smd_file (smd01,smd02,smd03,smd04,smd06,smdacti,smddate)     
                                   VALUES (g_ima.ima01,g_smd[l_ac].smd03,
                                           g_smd[l_ac].smd02,g_smd[l_ac].smd06,
                                           g_smd[l_ac].smd04,g_smd[l_ac].smdacti,g_smd[l_ac].smddate) 
                     IF SQLCA.sqlcode THEN
                        CALL cl_err3("ins","smd_file",g_smd[l_ac].smd02,"",SQLCA.sqlcode,"","",1) 
                     ELSE
                        MESSAGE 'INSERT O.K'
                        LET g_rec_b = g_rec_b+1
                        LET g_smd[g_rec_b].smd03=g_smd[l_ac].smd02
                        LET g_smd[g_rec_b].smd02=g_smd[l_ac].smd03
                        LET g_smd[g_rec_b].smd04=g_smd[l_ac].smd06
                        LET g_smd[g_rec_b].smd06=g_smd[l_ac].smd04
                        LET g_smd[g_rec_b].smdacti=g_smd[l_ac].smdacti
                        LET g_smd[g_rec_b].smddate=g_smd[l_ac].smddate
                        DISPLAY g_rec_b TO FORMONLY.cn2  
                     END IF 
                  ELSE
                     #若update成功且反向資料處於同一螢幕時的DISPLAY
                     FOR i = 1 TO g_smd.getLength()
                        IF g_smd[i].smd03 = g_smd[l_ac].smd02 AND 
                           g_smd[i].smd02 = g_smd[l_ac].smd03 THEN
                           LET g_smd[i].smd03=g_smd[l_ac].smd02
                           LET g_smd[i].smd02=g_smd[l_ac].smd03
                           LET g_smd[i].smd04=g_smd[l_ac].smd06
                           LET g_smd[i].smd06=g_smd[l_ac].smd04
                           LET g_smd[i].smdacti=g_smd[l_ac].smdacti
                           LET g_smd[i].smddate=g_smd[l_ac].smddate
                           EXIT FOR 
                        END IF
                     END FOR 
                  END IF
               END IF   
               #CHI-DA0034---end
               MESSAGE 'UPDATE O.K'
               COMMIT WORK
            END IF
         END IF
 
      AFTER ROW
          LET l_ac = ARR_CURR()
         #LET l_ac_t = l_ac    #FUN-D40030 Mark
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             IF p_cmd='u' THEN
                LET g_smd[l_ac].* = g_smd_t.*
             #FUN-D40030--add--str--
             ELSE
                CALL g_smd.deleteElement(l_ac)
                IF g_rec_b != 0 THEN
                   LET g_action_choice = "detail"
                   LET l_ac = l_ac_t
                END IF
             #FUN-D40030--add--end--
             END IF
             CLOSE i103_bcl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          LET l_ac_t = l_ac    #FUN-D40030 Add
          CLOSE i103_bcl
          COMMIT WORK
 

 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
          CALL cl_cmdask()
 
      ON ACTION create_unit
          CASE
             WHEN  INFIELD(smd02)
                CALL cl_cmdrun("aooi101")
             WHEN  INFIELD(smd03)
                CALL cl_cmdrun("aooi101")
             OTHERWISE EXIT CASE
          END CASE
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(smd02)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gfe"
               LET g_qryparam.default1 = g_smd[l_ac].smd02
               CALL cl_create_qry() RETURNING g_smd[l_ac].smd02
#               CALL FGL_DIALOG_SETBUFFER( g_smd[l_ac].smd02 )
                DISPLAY BY NAME g_smd[l_ac].smd02             #No.MOD-490344
               NEXT FIELD smd02
            WHEN INFIELD(smd03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gfe"
               LET g_qryparam.default1 = g_smd[l_ac].smd03
               CALL cl_create_qry() RETURNING g_smd[l_ac].smd03
#               CALL FGL_DIALOG_SETBUFFER( g_smd[l_ac].smd03 )
                DISPLAY BY NAME g_smd[l_ac].smd03             #No.MOD-490344
               NEXT FIELD smd03
            OTHERWISE EXIT CASE
         END CASE
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
#No.FUN-6B0030------Begin--------------                                                                                             
     ON ACTION controls                                                                                                             
         CALL cl_set_head_visible("","AUTO")                                                                                        
#No.FUN-6B0030-----End------------------    
 
   END INPUT
 
   CLOSE i103_bcl
#FUN-B90104----add--begin---- 服飾行業，母料件更改后修改，更新子料件資料
   IF s_industry('slk') THEN
      IF g_ima.ima151='Y' THEN
         CALL i103_ins_smd()
      END IF
   END IF
#FUN-B90104----add--end---
   COMMIT WORK
END FUNCTION

#FUN-B90104----add--begin---- 服飾行業，母料件更改后修改，更新子料件資料
FUNCTION i103_ins_smd()
 DEFINE l_imx000 LIKE imx_file.imx000
 DEFINE l_sql    STRING
 DEFINE l_smd    RECORD LIKE smd_file.*
 DEFINE l_fac    LIKE ima_file.ima31_fac        #CHI-D90022

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
   #CHI-D90022---begin
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
   #CHI-D90022---end
END FUNCTION
#FUN-B90104----add--end---
 
FUNCTION i103_b_askkey()
DEFINE
    l_wc2    LIKE type_file.chr1000       #No.FUN-680102 VARCHAR(200)
 
    CONSTRUCT l_wc2 ON smd04,smd02,smd06,smd03,smdacti  #FUN-870100
         FROM s_smd[1].smd04,s_smd[1].smd02,s_smd[1].smd06,s_smd[1].smd03,
              s_smd[1].smdacti  #FUN-870100 #FUN-B50042 remove POS
              #No.FUN-580031 --start--     HCN
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
              #No.FUN-580031 --end--       HCN
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
		#No.FUN-580031 --start--     HCN
                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
		#No.FUN-580031 --end--       HCN
    END CONSTRUCT
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       RETURN
    END IF
    CALL i103_b_fill(l_wc2)
END FUNCTION
 
FUNCTION i103_b_fill(p_wc2)              #BODY FILL UP
DEFINE
    p_wc2           LIKE type_file.chr1000       #No.FUN-680102CHAR(200)
 
    LET g_rec_b = 0
   #LET g_sql = "SELECT smd04,smd02,smd06,smd03,smdacti,smdpos",  #FUN-870100
    LET g_sql = "SELECT smd04,smd02,smd06,smd03,smdacti,smdpos,smddate",  #TQC-B90002
                " FROM smd_file",
                " WHERE smd01 ='",g_ima.ima01,"' AND ",p_wc2 CLIPPED,
                " ORDER BY 1"
    PREPARE i103_pb FROM g_sql
    DECLARE smd_cs                       #SCROLL CURSOR
        CURSOR FOR i103_pb
 
    CALL g_smd.clear()
    LET g_cnt = 1
    FOREACH smd_cs INTO g_smd[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
       LET g_cnt = g_cnt + 1
      # genero shell add g_max_rec check START
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
      # genero shell add g_max_rec check END
    END FOREACH
    CALL g_smd.deleteElement(g_cnt)
    IF SQLCA.sqlcode THEN
       CALL cl_err('foreach:',SQLCA.sqlcode,1)
    END IF
    LET g_rec_b = g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2
    LET g_cnt = 0
END FUNCTION
 
 
FUNCTION i103_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680102 VARCHAR(1)
 
 
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
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION first
         CALL i103_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION previous
         CALL i103_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION jump
         CALL i103_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION next
         CALL i103_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION last
         CALL i103_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
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
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         CALL i103_mu_ui()   #TQC-710032
 
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
             LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
 
#@    ON ACTION 相關文件
       ON ACTION related_document  #No.MOD-470515
         LET g_action_choice="related_document"
         EXIT DISPLAY
 
      ON ACTION exporttoexcel   #No.FUN-4B0020
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
      # No.FUN-530067 --start--
      AFTER DISPLAY
         CONTINUE DISPLAY
      # No.FUN-530067 ---end---
 
#No.FUN-6B0030------Begin--------------                                                                                             
     ON ACTION controls                                                                                                             
         CALL cl_set_head_visible("","AUTO")                                                                                        
#No.FUN-6B0030-----End------------------    
 
      #No.FUN-7C0050 add
      &include "qry_string.4gl"
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
 
FUNCTION i103_out()
DEFINE
    l_i             LIKE type_file.num5,          #No.FUN-680102 SMALLINT
    sr              RECORD
        smd01       LIKE smd_file.smd01,   #料件單號
        smd02       LIKE smd_file.smd02,   #甲單位
        smd03       LIKE smd_file.smd03,   #甲單位數量
        smd04       LIKE smd_file.smd04,   #乙單位
        smd06       LIKE smd_file.smd06,   #乙單位數量
        smd05       LIKE smd_file.smd05,   #說明
        smdacti     LIKE smd_file.smdacti  #說明
                    END RECORD,
    l_name          LIKE type_file.chr20,               #External(Disk) file name        #No.FUN-680102 VARCHAR(20)
    l_za05          LIKE za_file.za05,                   #No.FUN-680102 VARCHAR(40)
    l_ima02         LIKE ima_file.ima02                 #No.FUN-760083
    IF g_wc IS NULL THEN
    #   CALL cl_err('',-400,0)
        CALL cl_err('','9057',0)
        RETURN
    END IF
    CALL cl_wait()
    CALL cl_del_data(l_table)                           #No.FUN-760083
    LET g_str=''                                        #No.FUN-760083
    SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01=g_prog  #No.FUN-760083
#   LET l_name = 'aooi103.out'
    CALL cl_outnam('aooi103') RETURNING l_name
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    LET g_sql="SELECT smd01,smd02,smd03,",
              "smd04,smd06,smd05,smdacti",
              " FROM smd_file,ima_file",
              " WHERE ima01=smd01 AND ",g_wc CLIPPED,
              " AND ",g_wc2 CLIPPED
    PREPARE i103_p1 FROM g_sql                # RUNTIME 編譯
    DECLARE i103_co                         # SCROLL CURSOR
        CURSOR FOR i103_p1
 
    #START REPORT i103_rep TO l_name                        #No.FUN-760083
 
    FOREACH i103_co INTO sr.*
        IF SQLCA.sqlcode THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)    
            EXIT FOREACH
            END IF
        IF sr.smd01 IS NULL THEN LET sr.smd01 = ' ' END IF
        SELECT ima02 INTO l_ima02 FROM ima_file WHERE ima01=sr.smd01     #No.FUN-760083
        EXECUTE insert_prep USING  sr.*,l_ima02             #No.FUN-760083
        #OUTPUT TO REPORT i103_rep(sr.*)                    #No.FUN-760083
    END FOREACH
 
    #FINISH REPORT i103_rep                                 #No.FUN-760083
 
    CLOSE i103_co
    ERROR ""
    #CALL cl_prt(l_name,' ','1',g_len)                        #No.FUN-760083
    LET g_sql="SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED      #No.FUN-760083
    IF g_zz05='Y' THEN                                             #No.FUN-760083
       CALL cl_wcchp(g_wc,'ima01,ima02,ima08,ima06,ima05,ima25,ima44,ima63,ima55,   #No.FUN-760083                                              
                           ima906,ima907')                         #No.FUN-760083
       RETURNING g_wc                                              #No.FUN-760083
    END IF                                                         #No.FUN-760083
    LET g_str=g_wc                                                 #No.FUN-760083
    CALL cl_prt_cs3("aooi103","aooi103",g_sql,g_str)               #No.FUN-760083
END FUNCTION
 
 
#-----TQC-710032---------
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
#-----END TQC-710032-----

#No.FUN-BB0086---add---begin---
FUNCTION i103_smd06_check()
   IF NOT cl_null(g_smd[l_ac].smd06) AND NOT cl_null(g_smd[l_ac].smd03) THEN
      #IF cl_null(g_smd[l_ac].smd06) OR cl_null(g_smd03_t) OR g_smd_t.smd06 != g_smd[l_ac].smd06 OR g_smd03_t != g_smd[l_ac].smd03 THEN    #TQC-C20183
      IF cl_null(g_smd_t.smd06) OR cl_null(g_smd03_t) OR g_smd_t.smd06 != g_smd[l_ac].smd06 OR g_smd03_t != g_smd[l_ac].smd03 THEN         #TQC-C20183
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
      #IF cl_null(g_smd[l_ac].smd04) OR cl_null(g_smd02_t) OR g_smd_t.smd04 != g_smd[l_ac].smd04 OR g_smd02_t != g_smd[l_ac].smd02 THEN   #TQC-C20183
      IF cl_null(g_smd_t.smd04) OR cl_null(g_smd02_t) OR g_smd_t.smd04 != g_smd[l_ac].smd04 OR g_smd02_t != g_smd[l_ac].smd02 THEN        #TQC-C20183
         LET g_smd[l_ac].smd04=s_digqty(g_smd[l_ac].smd04,g_smd[l_ac].smd02)
         DISPLAY BY NAME g_smd[l_ac].smd04
      END IF
   END IF
END FUNCTION
#No.FUN-BB0086---add---end---
