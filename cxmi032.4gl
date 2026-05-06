# Prog. Version..: '5.30.15-14.10.14(00010)'     #
#
# Pattern name...: cxmi032.4gl
# Descriptions...: JWS分润设定基本资料業
# Date & Author..: BY li240808

# Modify.........: By li241118 新增分配模式和交易价栏位
# Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位

DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
 
DEFINE g_tc_jgc01         LIKE tc_jgc_file.tc_jgc01, #客户代码
       g_tc_jgc01_t       LIKE tc_jgc_file.tc_jgc01,
          
       g_tc_jgc           DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
               tc_jgc02       LIKE tc_jgc_file.tc_jgc02,  #产品编号
               ima02          LIKE ima_file.ima02,
               tc_jgc07       LIKE tc_jgc_file.tc_jgc07, #币别
               tc_jgc03       LIKE tc_jgc_file.tc_jgc03, #成本价
               tc_jgc08       LIKE tc_jgc_file.tc_jgc08, #分配模式
               tc_jgc04       LIKE tc_jgc_file.tc_jgc04, #智富分润比
               tc_jgc05       LIKE tc_jgc_file.tc_jgc05, #JWS分润比
               tc_jgc09       LIKE tc_jgc_file.tc_jgc09, #JWS分润比
               tc_jgc10       LIKE tc_jgc_file.tc_jgc10, #报价汇率
               tc_jgc11       LIKE tc_jgc_file.tc_jgc11, #转换汇率
               tc_jgc06       LIKE tc_jgc_file.tc_jgc06, #生效日期
               tc_jgcuser     LIKE tc_jgc_file.tc_jgcuser,
               tc_jgcgrup     LIKE tc_jgc_file.tc_jgcgrup,
               tc_jgcmodu     LIKE tc_jgc_file.tc_jgcmodu,
               tc_jgcdate     LIKE tc_jgc_file.tc_jgcdate,
               tc_jgcacti     LIKE tc_jgc_file.tc_jgcacti
                       END RECORD,
       g_tc_jgc_t            RECORD    #程式變數(Program Variables)
               tc_jgc02       LIKE tc_jgc_file.tc_jgc02,
               ima02          LIKE ima_file.ima02,
               tc_jgc07       LIKE tc_jgc_file.tc_jgc07,
               tc_jgc03       LIKE tc_jgc_file.tc_jgc03,
               tc_jgc08       LIKE tc_jgc_file.tc_jgc08, #分配模式
               tc_jgc04       LIKE tc_jgc_file.tc_jgc04,
               tc_jgc05       LIKE tc_jgc_file.tc_jgc05,
               tc_jgc09       LIKE tc_jgc_file.tc_jgc09, #交易价
               tc_jgc10       LIKE tc_jgc_file.tc_jgc10, #报价汇率
               tc_jgc11       LIKE tc_jgc_file.tc_jgc11, #转换汇率
               tc_jgc06       LIKE tc_jgc_file.tc_jgc06,
               tc_jgcuser     LIKE tc_jgc_file.tc_jgcuser,
               tc_jgcgrup     LIKE tc_jgc_file.tc_jgcgrup,
               tc_jgcmodu     LIKE tc_jgc_file.tc_jgcmodu,
               tc_jgcdate     LIKE tc_jgc_file.tc_jgcdate,
               tc_jgcacti     LIKE tc_jgc_file.tc_jgcacti
                       END RECORD,
       g_tc_jgc_list           DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
               tc_jgc01_l       LIKE tc_jgc_file.tc_jgc01,
               occ02_l          LIKE occ_file.occ02,
               tc_jgc02_l       LIKE tc_jgc_file.tc_jgc02,
               ima02_l          LIKE ima_file.ima02,
               tc_jgc07_l       LIKE tc_jgc_file.tc_jgc07,
               tc_jgc03_l       LIKE tc_jgc_file.tc_jgc03,
               tc_jgc08_l       LIKE tc_jgc_file.tc_jgc08,
               tc_jgc04_l       LIKE tc_jgc_file.tc_jgc04,
               tc_jgc05_l       LIKE tc_jgc_file.tc_jgc05,
               tc_jgc09_l       LIKE tc_jgc_file.tc_jgc09,
               tc_jgc10_l       LIKE tc_jgc_file.tc_jgc10,#报价汇率
               tc_jgc11_l       LIKE tc_jgc_file.tc_jgc11,#转换汇率
               tc_jgc06_l       LIKE tc_jgc_file.tc_jgc06
                       END RECORD,
       g_occ02  LIKE occ_file.occ02,
       g_wc,g_sql,g_action_flag       STRING,  #No.FUN-580092 HCN
       g_rec_b,g_rec_b1          LIKE type_file.num5,   #單身筆數  #No.FUN-680136 SMALLINT
       l_ac,l_ac1             LIKE type_file.num5    #目前處理的ARRAY CNT  #No.FUN-680136 SMALLINT
DEFINE g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_cnt           LIKE type_file.num10   #No.FUN-680136 INTEGER
DEFINE g_msg           LIKE ze_file.ze03      #No.FUN-680136 VARCHAR(72)
DEFINE g_row_count     LIKE type_file.num10   #No.FUN-680136 INTEGER
DEFINE g_curs_index    LIKE type_file.num10   #No.FUN-680136 INTEGER
DEFINE g_jump          LIKE type_file.num10   #No.FUN-680136 INTEGER
DEFINE g_no_ask        LIKE type_file.num5    #No.FUN-680136 SMALLINT
DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode

MAIN
    OPTIONS                                #改變一些系統預設值
        INPUT NO WRAP
    DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF
 
   CALL cl_used(g_prog,g_time,1) RETURNING g_time
    LET g_forupd_sql ="SELECT tc_jgc01 FROM tc_jgc_file WHERE tc_jgc01 = ? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i032_cl CURSOR FROM g_forupd_sql

   OPEN WINDOW i032_w WITH FORM "cxm/42f/cxmi032"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
   CALL cl_ui_init()

   CALL cl_set_comp_required("tc_jgc08,tc_jgc09",TRUE)
   CALL i032_menu()
   CLOSE WINDOW i032_w                 #結束畫面
 
   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN
 
FUNCTION i032_curs()

    CLEAR FORM                             #清除畫面
    CALL g_tc_jgc.clear()
    LET g_wc=" 1=1"
    INITIALIZE g_tc_jgc01 TO NULL    #No.FUN-750051
   # Modify.........: By li241118 新增分配模式和交易价栏位
   # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位
      CONSTRUCT g_wc ON tc_jgc01,tc_jgc02,tc_jgc03,tc_jgc07,tc_jgc04,tc_jgc05,tc_jgc06,tc_jgc08,tc_jgc09,tc_jgc10,tc_jgc11 #报价汇率、转换汇率栏位
                        ,tc_jgcuser,tc_jgcgrup,tc_jgcmodu,tc_jgcdate,tc_jgcacti
                   FROM tc_jgc01,s_tc_jgc[1].tc_jgc02,s_tc_jgc[1].tc_jgc03,s_tc_jgc[1].tc_jgc07,s_tc_jgc[1].tc_jgc04,s_tc_jgc[1].tc_jgc05
                   ,s_tc_jgc[1].tc_jgc06,s_tc_jgc[1].tc_jgc08,s_tc_jgc[1].tc_jgc09,s_tc_jgc[1].tc_jgc10,s_tc_jgc[1].tc_jgc11
                   ,s_tc_jgc[1].tc_jgcuser,s_tc_jgc[1].tc_jgcgrup,s_tc_jgc[1].tc_jgcmodu, s_tc_jgc[1].tc_jgcdate
                   ,s_tc_jgc[1].tc_jgcacti
 
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
          ON ACTION controlp
             CASE
               WHEN INFIELD(tc_jgc01)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "cq_occ"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret 
                  DISPLAY g_qryparam.multiret TO tc_jgc01                                                                                  
                  NEXT FIELD tc_jgc01  
               WHEN INFIELD(tc_jgc02)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "q_ima"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret 
                  DISPLAY g_qryparam.multiret TO tc_jgc02                                                                                  
                  NEXT FIELD tc_jgc02                
               WHEN INFIELD(tc_jgc07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "q_azi"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret 
                  DISPLAY g_qryparam.multiret TO tc_jgc07                                                                                  
                  NEXT FIELD tc_jgc07                
                  OTHERWISE EXIT CASE
              END CASE

      ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
      ON ACTION qbe_select
         CALL cl_qbe_select()
      ON ACTION qbe_save
         CALL cl_qbe_save()
      END CONSTRUCT

      LET g_wc = g_wc CLIPPED,cl_get_extra_cond('tc_jgcuser', 'tc_jgcgrup') #FUN-980030
 
      IF INT_FLAG THEN
         RETURN
      END IF
 
   LET g_sql= "SELECT DISTINCT tc_jgc01 FROM tc_jgc_file ",
              " WHERE  ", g_wc CLIPPED,
              " ORDER BY tc_jgc01"
   PREPARE i032_prepare FROM g_sql      #預備一下
   DECLARE i032_cs                  #宣告成可捲動的
       SCROLL CURSOR WITH HOLD FOR i032_prepare
 
   LET g_sql = "SELECT COUNT(DISTINCT tc_jgc01) FROM tc_jgc_file WHERE ", g_wc CLIPPED
   PREPARE i032_precount FROM g_sql
   DECLARE i032_count CURSOR FOR i032_precount
 
END FUNCTION
 
FUNCTION i032_menu()
 
   WHILE TRUE
      CASE 
         WHEN (g_action_flag IS NULL ) OR (g_action_flag = "main")
            CALL i032_bp("G")
         WHEN (g_action_flag = "info_list")
            CALL i032_list()
            CALL i032_bp1("G")
      END CASE 
      
      CASE g_action_choice
 
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i032_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i032_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i032_r()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i032_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "jump"
            CALL i032_fetch('/')
         WHEN "next"
            CALL i032_fetch('N')
         WHEN "previous"
            CALL i032_fetch('P')
         WHEN "last"
            CALL i032_fetch('L')
         WHEN "first"
            CALL i032_fetch('f')
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"                     
            IF cl_chk_act_auth() THEN
               LET w = ui.Window.getCurrent()
               LET f = w.getForm()                                                                 
               CASE                                                                                     
                  WHEN g_action_flag = "info_list"                                                  
                     LET page = f.FindNode("Page","page2")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_tc_jgc_list),'','')
               END CASE
               LET g_action_choice = NULL
            END IF

      END CASE
   END WHILE
   
   CLOSE i032_cs
   
END FUNCTION
 
FUNCTION i032_a()

   MESSAGE ""
   CLEAR FORM
   CALL g_tc_jgc.clear()
   INITIALIZE g_tc_jgc01 LIKE tc_jgc_file.tc_jgc01
   LET g_tc_jgc01_t = NULL
   CALL cl_opmsg('a')
 
   WHILE TRUE
      CALL i032_i("a")                #輸入單頭
      IF INT_FLAG THEN                   #使用者不玩了
         LET g_tc_jgc01=NULL
         CLEAR FORM
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
      
      LET g_rec_b = 0
      CALL i032_b()                      #輸入單身
 
      LET g_tc_jgc01_t = g_tc_jgc01            #保留舊值
      EXIT WHILE
      
   END WHILE
 
END FUNCTION
 
FUNCTION i032_i(p_cmd)
    DEFINE p_cmd           LIKE type_file.chr1                #a:輸入 u:更改  #No.FUN-680136 VARCHAR(1)
 
   CALL cl_set_head_visible("","YES")           #No.FUN-6B0032

   INPUT g_tc_jgc01 WITHOUT DEFAULTS FROM tc_jgc01
 
      AFTER FIELD tc_jgc01
         IF NOT cl_null(g_tc_jgc01) THEN
            SELECT COUNT(*) INTO g_cnt FROM occ_file WHERE occacti='Y' AND occ01 = g_tc_jgc01
            IF g_cnt = 0 THEN 
               CALL cl_err('','alm-074',0)
               NEXT FIELD tc_jgc01
            ELSE 
               SELECT occ02 INTO g_occ02 FROM occ_file WHERE occ01 = g_tc_jgc01 
               DISPLAY g_occ02 TO occ02
            END IF
         END IF
            
      ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(tc_jgc01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "cq_occ"
               LET g_qryparam.default1 = g_tc_jgc01
               CALL cl_create_qry() RETURNING g_tc_jgc01
               DISPLAY g_tc_jgc01 TO tc_jgc01
            OTHERWISE EXIT CASE
         END CASE
         
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
   END INPUT
 
END FUNCTION

FUNCTION i032_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_tc_jgc01 TO NULL            #No.FUN-6A0162
 
   MESSAGE ""
   CALL cl_opmsg('q')
 
   CALL i032_curs()                       #取得查詢條件
 
   IF INT_FLAG THEN                       #使用者不玩了
      LET INT_FLAG = 0
      INITIALIZE g_tc_jgc01 TO NULL
      RETURN
   END IF
 
   OPEN i032_cs                    #從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN                         #有問題
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_tc_jgc01 TO NULL
   ELSE
      OPEN i032_count
      FETCH i032_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
      CALL i032_fetch('F')            #讀出TEMP第一筆並顯示
   END IF
 
END FUNCTION
 
FUNCTION i032_fetch(p_flag)
DEFINE
   p_flag          LIKE type_file.chr1                  #處理方式  #No.FUN-680136 VARCHAR(1)
 
   MESSAGE ""
   CASE p_flag
       WHEN 'N' FETCH NEXT     i032_cs INTO g_tc_jgc01
       WHEN 'P' FETCH PREVIOUS i032_cs INTO g_tc_jgc01
       WHEN 'F' FETCH FIRST    i032_cs INTO g_tc_jgc01
       WHEN 'L' FETCH LAST     i032_cs INTO g_tc_jgc01
       WHEN '/'
            IF (NOT g_no_ask) THEN
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                 LET INT_FLAG = 0  ######add for prompt bug
                PROMPT g_msg CLIPPED,': ' FOR g_jump
                   ON IDLE g_idle_seconds
                      CALL cl_on_idle()
 
                  ON ACTION about         #MOD-4C0121
                     CALL cl_about()      #MOD-4C0121
             
                  ON ACTION help          #MOD-4C0121
                     CALL cl_show_help()  #MOD-4C0121
             
                  ON ACTION controlg      #MOD-4C0121
                     CALL cl_cmdask()     #MOD-4C0121
 
 
                END PROMPT
                IF INT_FLAG THEN LET INT_FLAG = 0 EXIT CASE END IF
            END IF
            FETCH ABSOLUTE g_jump i032_cs INTO g_tc_jgc01
            LET g_no_ask = FALSE
   END CASE
 
   IF SQLCA.sqlcode THEN                         #有麻煩
      CALL cl_err(g_tc_jgc01,SQLCA.sqlcode,0)
      INITIALIZE g_tc_jgc01 TO NULL
   ELSE
   
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
 
      CALL cl_navigator_setting( g_curs_index, g_row_count )
      DISPLAY g_curs_index TO FORMONLY.index                 
   END IF
   
    CALL i032_show()
END FUNCTION
 
FUNCTION i032_show()
 
   DISPLAY g_tc_jgc01 TO tc_jgc01               #單頭
   let g_occ02=''
   SELECT occ02 INTO g_occ02 FROM occ_file WHERE occ01 = g_tc_jgc01
   DISPLAY g_occ02 TO occ02

   CALL i032_b_fill(g_wc)                 #單身

   CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION
 
FUNCTION i032_r()
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   IF g_tc_jgc01 IS NULL THEN
      CALL cl_err("",-400,0)                 #No.FUN-6A0162
      RETURN
   END IF

   BEGIN WORK
	OPEN i032_cl USING g_tc_jgc01
	IF STATUS THEN
		CALL cl_err("open i032_cl:",status,0)
		CLOSE i032_cl
		ROLLBACK WORK
		RETURN
	END IF

	FETCH i032_cl INTO g_tc_jgc01
	IF SQLCA.sqlcode THEN
		CALL cl_err(g_tc_jgc01,sqlca.sqlcode,0)
		CLOSE i032_cl
		ROLLBACK WORK
		RETURN
	END IF

   CALL i032_show()

   IF cl_delh(0,0) THEN                   #確認一下

      DELETE FROM tc_jgc_file WHERE tc_jgc01 = g_tc_jgc01 
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_jgc_file","","",SQLCA.sqlcode,"","BODY DELETE:",1)  #No.FUN-660129
         ROLLBACK WORK
         RETURN
      ELSE
         CLEAR FORM
         INITIALIZE g_tc_jgc01 TO NULL
         CALL g_tc_jgc.clear()

         OPEN i032_count
         IF STATUS THEN
            CLOSE i032_cs
            CLOSE i032_count
            COMMIT WORK
            RETURN
         END IF
         
         FETCH i032_count INTO g_row_count
         IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
            CLOSE i032_cs
            CLOSE i032_count
            COMMIT WORK
            RETURN
         END IF
         
         DISPLAY g_row_count TO FORMONLY.cnt
         DISPLAY g_curs_index TO FORMONLY.index
         OPEN i032_cs
         IF g_curs_index = g_row_count + 1 THEN
            LET g_jump = g_row_count
            CALL i032_fetch('L')
         ELSE
            LET g_jump = g_curs_index
            LET g_no_ask = TRUE
            CALL i032_fetch('/')
         END IF
      END IF
   END IF
   CLOSE i032_cl
   COMMIT WORK
END FUNCTION
 
#單身
FUNCTION i032_b()
DEFINE
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT  #No.FUN-680136 SMALLINT
    l_n             LIKE type_file.num5,                #檢查重複用  #No.FUN-680136 SMALLINT
    l_lock_sw       LIKE type_file.chr1,                 #單身鎖住否  #No.FUN-680136 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,                 #處理狀態  #No.FUN-680136 VARCHAR(1)
    l_allow_insert  LIKE type_file.num5,                #可新增否  #No.FUN-680136 SMALLINT
    l_allow_delete  LIKE type_file.num5,                #可刪除否  #No.FUN-680136 SMALLINT
    l_str,l_str2 STRING 

DEFINE l_A, l_B, l_C DECIMAL(16,6)
DEFINE l_tc_jgc11 LIKE tc_jgc_file.tc_jgc11
    
    LET g_action_choice = ""
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_jgc01 IS NULL THEN
       RETURN
    END IF
 
    CALL cl_opmsg('b')
   # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位 
    LET g_forupd_sql = "SELECT tc_jgc02,ima02,tc_jgc07,tc_jgc03,tc_jgc08,tc_jgc04,tc_jgc05,tc_jgc09,tc_jgc10,tc_jgc11,tc_jgc06,tc_jgcuser,tc_jgcgrup,tc_jgcmodu,tc_jgcdate,tc_jgcacti
                         FROM tc_jgc_file LEFT JOIN ima_file on ima01=tc_jgc02",
                       " WHERE tc_jgc01=? AND tc_jgc02=? AND tc_jgc06=? AND tc_jgc09=? FOR UPDATE"  
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i032_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    INPUT ARRAY g_tc_jgc WITHOUT DEFAULTS FROM s_tc_jgc.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF

        BEFORE ROW
           LET p_cmd = ''
           LET l_ac = ARR_CURR()
           LET l_lock_sw = 'N'            #DEFAULT
           LET l_n = ARR_COUNT()
           LET g_success = 'Y'            #FUN-9A0056 add
           BEGIN WORK

           IF g_rec_b >= l_ac THEN
              LET p_cmd='u'
              LET g_tc_jgc_t.* = g_tc_jgc[l_ac].*                #BACKUP
             # CALL cl_set_comp_entry("tc_jgc02,tc_jgc06",false)
              
              OPEN i032_bcl USING g_tc_jgc01,g_tc_jgc_t.tc_jgc02,g_tc_jgc_t.tc_jgc06,g_tc_jgc_t.tc_jgc09
              IF STATUS THEN
                 CALL cl_err("OPEN i032_bcl:", STATUS, 1)
                 LET l_lock_sw = "N"
                 return
              ELSE
                 FETCH i032_bcl INTO g_tc_jgc[l_ac].*
                 IF SQLCA.sqlcode THEN
                    CALL cl_err(g_tc_jgc_t.tc_jgc02,SQLCA.sqlcode,1)
                    LET l_lock_sw = "Y"
                 END IF
              END IF
           END IF
           
        BEFORE INSERT
           LET l_n = ARR_COUNT()
           LET p_cmd='a'
           #CALL cl_set_comp_entry("tc_jgc02,tc_jgc06",true)
           INITIALIZE g_tc_jgc[l_ac].* TO NULL      #900423

            # ====== add by dmw20260506 新增逻辑：报价汇率取上一条转换汇率 ======
{            IF l_ac > 1 THEN
               LET g_tc_jgc[l_ac].tc_jgc10 = g_tc_jgc[l_ac-1].tc_jgc11
            END IF
}

           LET g_tc_jgc_t.* = g_tc_jgc[l_ac].*         #新輸入資料
           LET g_tc_jgc[l_ac].tc_jgcuser = g_user
           LET g_tc_jgc[l_ac].tc_jgcgrup = g_grup
           LET g_tc_jgc[l_ac].tc_jgcdate = g_today
           LET g_tc_jgc[l_ac].tc_jgcacti = 'Y'
 
        AFTER INSERT
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0 
              CANCEL INSERT
           END IF
            SELECT COUNT(*) INTO g_cnt FROM tc_jgc_file 
               WHERE tc_jgc01 = g_tc_jgc01 AND tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02 AND tc_jgc06 = g_tc_jgc[l_ac].tc_jgc06 AND tc_jgc09 = g_tc_jgc[l_ac].tc_jgc09 
            IF g_cnt > 0 THEN  
               CALL cl_err('客户代码:'||g_tc_jgc01||', ' ||'ERP:'||g_tc_jgc[l_ac].tc_jgc02||', '||'交易价:'||g_tc_jgc[l_ac].tc_jgc09||', '||'生效日期:'||g_tc_jgc[l_ac].tc_jgc06 ,'aba-106',1)
               CANCEL INSERT
            END IF           
            # Modify.........: By li241118 新增分配模式和交易价栏位
            # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位
            INSERT INTO tc_jgc_file(tc_jgc01,tc_jgc02,tc_jgc03,tc_jgc04,tc_jgc05,tc_jgc07
             ,tc_jgc06,tc_jgcuser,tc_jgcgrup,tc_jgcdate,tc_jgcacti,tc_jgc08,tc_jgc09,tc_jgc10,tc_jgc11) 
            VALUES(g_tc_jgc01,g_tc_jgc[l_ac].tc_jgc02,g_tc_jgc[l_ac].tc_jgc03,g_tc_jgc[l_ac].tc_jgc04,g_tc_jgc[l_ac].tc_jgc05,g_tc_jgc[l_ac].tc_jgc07
                     ,g_tc_jgc[l_ac].tc_jgc06,g_tc_jgc[l_ac].tc_jgcuser,g_tc_jgc[l_ac].tc_jgcgrup,g_tc_jgc[l_ac].tc_jgcdate,g_tc_jgc[l_ac].tc_jgcacti
                     ,g_tc_jgc[l_ac].tc_jgc08,g_tc_jgc[l_ac].tc_jgc09,g_tc_jgc[l_ac].tc_jgc10,g_tc_jgc[l_ac].tc_jgc11)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_jgc_file","","",SQLCA.sqlcode,"","",1)  #No.FUN-660129
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt2
               COMMIT WORK
            END IF

         AFTER FIELD tc_jgc02
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc02) THEN
            SELECT COUNT(*) INTO g_cnt FROM tc_jgc_file 
               WHERE tc_jgc01 = g_tc_jgc01 AND tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02 AND tc_jgc06 = g_tc_jgc[l_ac].tc_jgc06 AND tc_jgc09 = g_tc_jgc[l_ac].tc_jgc09  
            IF g_cnt > 0 AND g_tc_jgc[l_ac].tc_jgc02 != g_tc_jgc_t.tc_jgc02 THEN
               CALL cl_err('客户代码:'||g_tc_jgc01||', ' ||'ERP:'||g_tc_jgc[l_ac].tc_jgc02||', '||'交易价:'||g_tc_jgc[l_ac].tc_jgc09||', '||'生效日期:'||g_tc_jgc[l_ac].tc_jgc06 ,'aba-106',1)
               NEXT FIELD tc_jgc02
            END IF

            SELECT COUNT(*) INTO g_cnt FROM ima_file WHERE imaacti='Y' AND ima01 = g_tc_jgc[l_ac].tc_jgc02
            IF g_cnt = 0 THEN 
               CALL cl_err('','alm-074',0)
               NEXT FIELD tc_jgc02
               ELSE 
                  SELECT ima02 INTO g_tc_jgc[l_ac].ima02 FROM ima_file WHERE ima01=g_tc_jgc[l_ac].tc_jgc02
                  DISPLAY BY NAME g_tc_jgc[l_ac].ima02
            END IF
            END IF 

            # ===== 新增逻辑：同产品编号带出最近转换汇率 =====
               SELECT tc_jgc11
               INTO l_tc_jgc11
               FROM tc_jgc_file
               WHERE tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02
               AND tc_jgc01 = g_tc_jgc01
               #AND tc_jgc07 = g_tc_jgc[l_ac].tc_jgc07
               AND tc_jgcacti = 'Y'
               AND tc_jgc06 = (
                     SELECT MAX(tc_jgc06)
                     FROM tc_jgc_file
                     WHERE tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02
                        AND tc_jgc01 = g_tc_jgc01
                        #AND tc_jgc07 = g_tc_jgc[l_ac].tc_jgc07
                        AND tc_jgcacti = 'Y'
                  )

               IF SQLCA.sqlcode = 0 THEN
                  LET g_tc_jgc[l_ac].tc_jgc10 = l_tc_jgc11
                  DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc10
               END IF

         AFTER FIELD tc_jgc06
            SELECT COUNT(*) INTO g_cnt FROM tc_jgc_file 
               WHERE tc_jgc01 = g_tc_jgc01 AND tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02 AND tc_jgc06 = g_tc_jgc[l_ac].tc_jgc06 AND tc_jgc09 = g_tc_jgc[l_ac].tc_jgc09 
             IF g_cnt > 0 AND g_tc_jgc[l_ac].tc_jgc06 != g_tc_jgc_t.tc_jgc06 THEN  
               CALL cl_err('客户代码:'||g_tc_jgc01||', ' ||'ERP:'||g_tc_jgc[l_ac].tc_jgc02||', '||'交易价:'||g_tc_jgc[l_ac].tc_jgc09||', '||'生效日期:'||g_tc_jgc[l_ac].tc_jgc06 ,'aba-106',1)
               NEXT FIELD tc_jgc06
            END IF

         AFTER FIELD tc_jgc09
            SELECT COUNT(*) INTO g_cnt FROM tc_jgc_file 
               WHERE tc_jgc01 = g_tc_jgc01 AND tc_jgc02 = g_tc_jgc[l_ac].tc_jgc02 AND tc_jgc06 = g_tc_jgc[l_ac].tc_jgc06 AND tc_jgc09 = g_tc_jgc[l_ac].tc_jgc09 
             IF g_cnt > 0 AND g_tc_jgc[l_ac].tc_jgc09 != g_tc_jgc_t.tc_jgc09 THEN  
               CALL cl_err('客户代码:'||g_tc_jgc01||', ' ||'ERP:'||g_tc_jgc[l_ac].tc_jgc02||', '||'交易价:'||g_tc_jgc[l_ac].tc_jgc09||', '||'生效日期:'||g_tc_jgc[l_ac].tc_jgc06 ,'aba-106',1)
               NEXT FIELD tc_jgc09
            END IF
            #add by dmw20260427
            LET l_A = g_tc_jgc[l_ac].tc_jgc03
            LET l_B = g_tc_jgc[l_ac].tc_jgc09
            IF NOT cl_null(l_A) AND l_A != 0 AND NOT cl_null(l_B) THEN
               LET l_C = l_B / (l_A / 1.1)
               CALL calc_ratio(l_C, l_ac)
            END IF

         AFTER FIELD tc_jgc07
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc07) THEN
               SELECT COUNT(*) INTO g_cnt FROM azi_file WHERE aziacti='Y' AND azi01 = g_tc_jgc[l_ac].tc_jgc07
               IF g_cnt = 0 THEN 
                  CALL cl_err('','alm-074',0)
                  NEXT FIELD tc_jgc07
               END IF
            END IF 
{                    
         AFTER FIELD tc_jgc03
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc03) AND g_tc_jgc[l_ac].tc_jgc03 < 0 THEN
                  CALL cl_err('','aec-992',0)
                  NEXT FIELD tc_jgc03
            END IF         
}
         #add by dmw20260427 
         AFTER FIELD tc_jgc03
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc03) AND g_tc_jgc[l_ac].tc_jgc03 <= 0 THEN
               CALL cl_err('','aec-992',0)
               NEXT FIELD tc_jgc03
            END IF
            LET l_A = g_tc_jgc[l_ac].tc_jgc03
            LET l_B = g_tc_jgc[l_ac].tc_jgc09
            IF NOT cl_null(l_A) AND l_A != 0 AND NOT cl_null(l_B) THEN
               LET l_C = l_B / (l_A / 1.1)
               CALL calc_ratio(l_C, l_ac)
            END IF  
            
         AFTER FIELD tc_jgc04
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc04) THEN
               IF g_tc_jgc[l_ac].tc_jgc08 = 'B' THEN
                  IF g_tc_jgc[l_ac].tc_jgc04 < 0  THEN
                     CALL cl_err('','aec-992',0)
                     NEXT FIELD tc_jgc04
                  END IF
                  IF g_tc_jgc[l_ac].tc_jgc04 > 100 THEN
                     CALL cl_err('','apm-985',0)
                     NEXT FIELD tc_jgc04
                  END IF

                  LET g_tc_jgc[l_ac].tc_jgc05 = 100 - g_tc_jgc[l_ac].tc_jgc04
                  DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc05
               END IF
            END IF        


         AFTER FIELD tc_jgc05
            IF NOT cl_null(g_tc_jgc[l_ac].tc_jgc05) THEN
               IF g_tc_jgc[l_ac].tc_jgc08 = 'B' THEN
                  IF g_tc_jgc[l_ac].tc_jgc05 < 0 THEN
                     CALL cl_err('','aec-992',0)
                     NEXT FIELD tc_jgc05
                  END IF
                  IF g_tc_jgc[l_ac].tc_jgc05 > 100 THEN
                     CALL cl_err('','apm-985',0)
                     NEXT FIELD tc_jgc05
                  END IF

                  LET g_tc_jgc[l_ac].tc_jgc04 = 100 - g_tc_jgc[l_ac].tc_jgc05
                  DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc04
               END IF
            END IF

{         #add by dmw20260427
         AFTER FIELD tc_jgc09
            LET l_A = g_tc_jgc[l_ac].tc_jgc03
            LET l_B = g_tc_jgc[l_ac].tc_jgc09
            IF NOT cl_null(l_A) AND l_A != 0 AND NOT cl_null(l_B) THEN
               LET l_C = l_B / (l_A / 1.1)
               CALL calc_ratio(l_C, l_ac)
            END IF
}
         AFTER FIELD tc_jgc08
            IF g_tc_jgc[l_ac].tc_jgc08 != g_tc_jgc_t.tc_jgc08 THEN 
               LET g_tc_jgc[l_ac].tc_jgc04=NULL 
               LET g_tc_jgc[l_ac].tc_jgc05=NULL 
            END IF
            DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc04, g_tc_jgc[l_ac].tc_jgc05         
            
        ON ROW CHANGE
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              LET g_tc_jgc[l_ac].* = g_tc_jgc_t.*
              CLOSE i032_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF  

           LET g_success = 'Y'                        #FUN-9A0056 add
           IF l_lock_sw = 'Y' THEN
              CALL cl_err(g_tc_jgc[l_ac].tc_jgc02,-263,1)
              LET g_tc_jgc[l_ac].* = g_tc_jgc_t.*
              LET g_success = 'N'                     #FUN-9A0056 add
           ELSE
               # Modify.........: By li241118 新增分配模式和交易价栏位
               # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位
               let g_tc_jgc[l_ac].tc_jgcmodu=g_user
               let g_tc_jgc[l_ac].tc_jgcdate=g_today
               UPDATE tc_jgc_file SET 
                                    tc_jgc02=g_tc_jgc[l_ac].tc_jgc02,
                                    tc_jgc03=g_tc_jgc[l_ac].tc_jgc03,
                                    tc_jgc04=g_tc_jgc[l_ac].tc_jgc04, 
                                    tc_jgc05=g_tc_jgc[l_ac].tc_jgc05, 
                                    tc_jgc06=g_tc_jgc[l_ac].tc_jgc06, 
                                    tc_jgc07=g_tc_jgc[l_ac].tc_jgc07, 
                                    tc_jgc08=g_tc_jgc[l_ac].tc_jgc08, 
                                    tc_jgc09=g_tc_jgc[l_ac].tc_jgc09, 
                                    tc_jgc10=g_tc_jgc[l_ac].tc_jgc10, 
                                    tc_jgc11=g_tc_jgc[l_ac].tc_jgc11,
                                    tc_jgcmodu=g_tc_jgc[l_ac].tc_jgcmodu,
                                    tc_jgcdate=g_tc_jgc[l_ac].tc_jgcdate
                  WHERE tc_jgc01=g_tc_jgc01 AND tc_jgc02=g_tc_jgc_t.tc_jgc02 AND tc_jgc06=g_tc_jgc_t.tc_jgc06 AND tc_jgc09=g_tc_jgc_t.tc_jgc09
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","tc_jgc_file","","",SQLCA.sqlcode,"","",1)  #No.FUN-660129
                  LET g_tc_jgc[l_ac].* = g_tc_jgc_t.*
                  LET g_success = 'N'     
                  ROLLBACK WORK
                  EXIT INPUT
               ELSE
                  COMMIT WORK
                  MESSAGE 'UPDATE O.K'
               END IF
           END IF

         BEFORE DELETE                          
           IF g_tc_jgc01 IS NOT NULL AND g_tc_jgc_t.tc_jgc02 IS NOT NULL AND g_tc_jgc_t.tc_jgc06 IS NOT NULL THEN
              IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
              END IF
              IF l_lock_sw = "Y" THEN
                 CALL cl_err("", -263, 1)
                 CANCEL DELETE
              END IF

              LET g_success = 'Y'                                          
 
              DELETE FROM tc_jgc_file WHERE tc_jgc01=g_tc_jgc01 AND tc_jgc02=g_tc_jgc_t.tc_jgc02 AND tc_jgc06=g_tc_jgc_t.tc_jgc06  
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","tc_jgc_file","","",SQLCA.sqlcode,"","",1)  
                 LET g_success = 'N'                                        
              END IF

              LET g_rec_b=g_rec_b-1
              DISPLAY g_rec_b TO FORMONLY.cn2
           END IF

           IF g_success = 'N' THEN
              ROLLBACK WORK
              CANCEL DELETE
           ELSE
             COMMIT WORK
           END IF                      #FUN-9A0056 add

        AFTER ROW
           LET l_ac = ARR_CURR()
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              IF p_cmd = 'u' THEN
                 LET g_tc_jgc[l_ac].* = g_tc_jgc_t.*
              ELSE
                 CALL g_tc_jgc.deleteElement(l_ac)
                 IF g_rec_b != 0 THEN
                    LET g_action_choice = "detail"
                    LET l_ac = l_ac_t
                 END IF
              END IF
              CLOSE i032_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF

         LET l_ac_t = l_ac           #FUN-D30034 add
         CLOSE i032_bcl
         COMMIT WORK

      AFTER INPUT
         IF g_tc_jgc[l_ac].tc_jgc08 = 'B' AND (g_tc_jgc[l_ac].tc_jgc04 + g_tc_jgc[l_ac].tc_jgc05) != 100 THEN
            CALL cl_err('','agl-107',1)
            NEXT FIELD tc_jgc04
         END IF 

      ON ACTION controlp
         CASE              
            WHEN INFIELD(tc_jgc02)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_ima"
               LET g_qryparam.default1 = g_tc_jgc[l_ac].tc_jgc02
               CALL cl_create_qry() RETURNING g_tc_jgc[l_ac].tc_jgc02
               DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc02
            WHEN INFIELD(tc_jgc07)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_azi"
               LET g_qryparam.default1 = g_tc_jgc[l_ac].tc_jgc07
               CALL cl_create_qry() RETURNING g_tc_jgc[l_ac].tc_jgc07
               DISPLAY BY NAME g_tc_jgc[l_ac].tc_jgc07
         END CASE


        ON ACTION CONTROLO                        #沿用所有欄位
           IF INFIELD(tc_jgc02) AND l_ac > 1 THEN
              LET g_tc_jgc[l_ac].* = g_tc_jgc[l_ac-1].*
              LET g_tc_jgc[l_ac].tc_jgc02 = ''
              NEXT FIELD tc_jgc02
           END IF

        ON ACTION CONTROLR
           CALL cl_show_req_fields()

        ON ACTION CONTROLG
           CALL cl_cmdask()

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

        ON ACTION controls                           #No.FUN-6B0032             
         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032

    END INPUT
 
    CLOSE i032_bcl
    COMMIT WORK
   CALL i032_b_fill(g_wc)

END FUNCTION

 
 
FUNCTION i032_b_fill(p_wc)              #BODY FILL UP
DEFINE p_wc   STRING   #MOD-8B0084
 
    # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位
   LET g_sql = "SELECT tc_jgc02,ima02,tc_jgc07,tc_jgc03,tc_jgc08,tc_jgc04,tc_jgc05,tc_jgc09,tc_jgc10,tc_jgc11,tc_jgc06
               ,tc_jgcuser,tc_jgcgrup,tc_jgcmodu,tc_jgcdate,tc_jgcacti
               FROM TC_JGC_FILE 
               LEFT JOIN IMA_FILE on ima01=tc_jgc02
               WHERE tc_jgc01 = '",g_tc_jgc01,"' AND ",p_wc CLIPPED,
               " ORDER BY tc_jgc02,tc_jgc06 "
   PREPARE i032_prepare2 FROM g_sql      #預備一下
   DECLARE tc_jgc_curs CURSOR FOR i032_prepare2
 
   CALL g_tc_jgc.clear()
   LET g_cnt = 1
 
    FOREACH tc_jgc_curs INTO g_tc_jgc[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
    EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_tc_jgc.deleteElement(g_cnt)
   LET g_rec_b =g_cnt -1
   DISPLAY g_rec_b TO FORMONLY.cnt2
 
END FUNCTION
 
FUNCTION i032_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_jgc TO s_tc_jgc.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION info_list 
         LET g_action_flag = "info_list"
         EXIT DISPLAY 

      ON ACTION first
         CALL i032_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST 
      ON ACTION previous
         CALL i032_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION jump
         CALL i032_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION next
         CALL i032_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION last
         CALL i032_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         IF g_aza.aza71 MATCHES '[Yy]' THEN       
            CALL cl_set_act_visible("gpm_show,gpm_query", TRUE)
         ELSE
            CALL cl_set_act_visible("gpm_show,gpm_query", FALSE)  #N0.TQC-710042
         END IF 
 
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
         LET INT_FLAG=FALSE #MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      AFTER DISPLAY
         CONTINUE DISPLAY
 
      ON ACTION controls                           #No.FUN-6B0032             
         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

 FUNCTION i032_bp1(p_ud)
   DEFINE  p_ud   LIKE   type_file.chr1

    IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
    END IF
    LET g_action_choice = " "
    CALL cl_set_act_visible("accept,cancel", FALSE)
    
    DISPLAY ARRAY g_tc_jgc_list TO s_tc_jgc_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
 
      BEFORE DISPLAY
        CALL fgl_set_arr_curr(l_ac1)
      BEFORE ROW
         LET l_ac1 = ARR_CURR()
         CALL cl_show_fld_cont()               
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY 
      ON ACTION exporttoexcel     
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                  
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION main        
         LET g_action_flag="main"
         LET l_ac1=ARR_CURR()

         IF g_rec_b1 > 0 THEN 
            SELECT tc_jgc01 INTO g_tc_jgc01 FROM tc_jgc_file WHERE tc_jgc01= g_tc_jgc_list[l_ac1].tc_jgc01_l
            CALL i032_show()
         END IF 
         CALL cl_set_comp_visible("page1", FALSE)
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page1", TRUE)
         CALL cl_set_comp_visible("page2", TRUE)
         EXIT DISPLAY
      ON ACTION accept
         LET g_action_flag="main"
         LET l_ac1=ARR_CURR()
         IF g_rec_b1 > 0 THEN
            SELECT tc_jgc01 INTO g_tc_jgc01 FROM tc_jgc_file WHERE tc_jgc01= g_tc_jgc_list[l_ac1].tc_jgc01_l
            CALL i032_show()
         END IF 
         CALL cl_set_comp_visible("page1", FALSE)
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page1", TRUE)
         CALL cl_set_comp_visible("page2", TRUE)
         EXIT DISPLAY
      ON ACTION controlg
         LET g_action_choice="controlg"
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
  
      AFTER DISPLAY
         CONTINUE DISPLAY
 
      ON ACTION controls                           
         CALL cl_set_head_visible("","AUTO")  

    END DISPLAY
    CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION 

 

FUNCTION i032_list()             
 
    # Modify.........: By dmw20260427 新增报价汇率和转换汇率栏位
   LET g_sql = "SELECT tc_jgc01,occ02,tc_jgc02,ima02,tc_jgc07,tc_jgc03,tc_jgc08,tc_jgc04,tc_jgc05,tc_jgc09,tc_jgc10,tc_jgc11,tc_jgc06
               FROM TC_JGC_FILE 
               LEFT JOIN IMA_FILE on ima01=tc_jgc02
               LEFT JOIN occ_file on occ01=tc_jgc01
               WHERE ",g_wc CLIPPED,
               " ORDER BY tc_jgc01,tc_jgc02,tc_jgc06 "
   PREPARE i032_prepare3 FROM g_sql      #預備一下
   DECLARE list_cs CURSOR FOR i032_prepare3
 
   CALL g_tc_jgc_list.clear()
   LET g_cnt = 1
 
   FOREACH list_cs INTO g_tc_jgc_list[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
        IF g_action_choice ="query"  THEN
           CALL cl_err( '', 9035, 0 )
        END IF
        EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_tc_jgc_list.deleteElement(g_cnt)
   LET g_rec_b1 = g_cnt - 1
   
  DISPLAY ARRAY g_tc_jgc_list TO s_tc_jgc_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
      BEFORE DISPLAY
        EXIT DISPLAY
   END DISPLAY

   END function


#add by dmw20260427 核心逻辑：根据报价成本计算分配比例
FUNCTION calc_ratio(p_C, p_idx)
DEFINE p_C DECIMAL(16,6)
DEFINE p_idx LIKE type_file.num5

   IF p_C < 0 THEN
      LET g_tc_jgc[p_idx].tc_jgc04 = 0
      LET g_tc_jgc[p_idx].tc_jgc05 = 0

   ELSE
      IF p_C < 5 THEN
         LET g_tc_jgc[p_idx].tc_jgc04 = 80
         LET g_tc_jgc[p_idx].tc_jgc05 = 20

      ELSE
         IF p_C > 15 THEN
            LET g_tc_jgc[p_idx].tc_jgc04 = 50
            LET g_tc_jgc[p_idx].tc_jgc05 = 50

         ELSE
            LET g_tc_jgc[p_idx].tc_jgc04 = 60
            LET g_tc_jgc[p_idx].tc_jgc05 = 40
         END IF
      END IF
   END IF

   DISPLAY BY NAME g_tc_jgc[p_idx].tc_jgc04, g_tc_jgc[p_idx].tc_jgc05

END FUNCTION
