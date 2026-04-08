# Prog. Version..: '5.30.15-14.10.14(00010)'     #
#
# Pattern name...: cbmi109.4gl
# Descriptions...: 新品报价登记表
# Date & Author..: By Hao230518

# Modify by mo 231218 单据类别为2，3时，为必输项
# Modify by mo 231218 单据类别为1时，取消必输
# ADD by mo 231219 增加新报表
# ADD by mo 231222 打印方式选择
# Modify by li240510 资料库为 jd 时,修改评估料号和报价编号的自动编号格式
# Modify by li240512 添加 tc_jcr40 字段
# Modify by li240514 添加 jd 资料库打印报表
# Modify by MO240925 添加 tc_jcr41 字段
# Modify by li250911 添加tc_jcr42字段
# Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39
# Modify by li251110 添加 tc_jcr43 字段
# Modify by dmw 20260403 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段

DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
 
DEFINE
    g_tc_jcr   RECORD LIKE tc_jcr_file.*,
    g_tc_jcr_t RECORD LIKE tc_jcr_file.*,
    g_tc_jcr_o RECORD LIKE tc_jcr_file.*,
    g_tc_jcr01_t LIKE tc_jcr_file.tc_jcr01,
    g_flag             LIKE type_file.chr1,       #No.FUN-680096 VARCHAR(1)
    g_type             LIKE type_file.chr1,       #No.FUN-680096 VARCHAR(1) 
    g_sw               LIKE type_file.num5,       #No.FUN-680096 SMALLINT
    g_argv1            LIKE tc_jcr_file.tc_jcr01,       #CHI-720014 add
    g_argv2            LIKE type_file.chr10,
   #g_wc,g_sql         STRING #TQC-630166         #No.FUN-680096
    g_wc,g_sql         STRING    #TQC-630166
DEFINE p_row,p_col     LIKE type_file.num5        #No.FUN-680096 SMALLINT
DEFINE g_chr1          LIKE type_file.chr1     #显示无效图片的判断
DEFINE g_chr2          LIKE type_file.chr1     #显示审核图片的判断
 
DEFINE g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done   STRING
DEFINE g_t1            LIKE smy_file.smyslip
DEFINE   g_cnt           LIKE type_file.num10    #No.FUN-680096 INTEGER
DEFINE   g_chr           LIKE type_file.chr1     #No.TQC-740079
DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose    #No.FUN-680096 SMALLINT
DEFINE   g_msg           LIKE ze_file.ze03       #No.FUN-680096 VARCHAR(72)
DEFINE   g_row_count     LIKE type_file.num10    #No.FUN-680096 INTEGER
DEFINE   g_curs_index    LIKE type_file.num10    #No.FUN-680096 INTEGER
DEFINE   g_jump          LIKE type_file.num10    #No.FUN-680096 INTEGER
DEFINE   mi_no_ask       LIKE type_file.num5     #No.FUN-680096 SMALLINT
DEFINE   g_ans           LIKE type_file.chr1     #CHI-720014 modify VARCHAR(1)  #CHI-6B0035 add
DEFINE   g_str           STRING                  #FUN-770052
DEFINE   g_rec_b1,l_ac1  LIKE type_file.num10
DEFINE   g_tc_jcr_l      DYNAMIC ARRAY OF RECORD
            tc_jcrcrat_l LIKE tc_jcr_file.tc_jcrcrat,
            tc_jcr01_l   LIKE tc_jcr_file.tc_jcr01,
            tc_jcr02_l   LIKE tc_jcr_file.tc_jcr02,
            tc_jcr42_l   LIKE tc_jcr_file.tc_jcr42, #主件编号 # Modify by li250911 添加tc_jcr42字段
            tc_jcr08_l   LIKE tc_jcr_file.tc_jcr08,
            tc_jcr09_l   LIKE tc_jcr_file.tc_jcr09,
            tc_jcr05_l   LIKE tc_jcr_file.tc_jcr05,
            tc_jcr06_l   LIKE tc_jcr_file.tc_jcr06,
            tc_jcr44_l   LIKE tc_jcr_file.tc_jcr44,#账款客户 by dmw 20260403 添加 tc_jcr44 字段
            tc_jcr45_l   LIKE tc_jcr_file.tc_jcr45,#账款客户名称 by dmw 20260403 添加 tc_jcr45 字段
            tc_jcr46_l   LIKE tc_jcr_file.tc_jcr46,#品牌客户 by dmw 20260403 添加 tc_jcr46 字段
            tc_jcr47_l   LIKE tc_jcr_file.tc_jcr47,#品牌客户名称 by dmw 20260403 添加 tc_jcr47 字段
            tc_jcr03_l   LIKE tc_jcr_file.tc_jcr03,
            tc_jcr10_l   LIKE tc_jcr_file.tc_jcr10,
            tc_jcr11_l   LIKE tc_jcr_file.tc_jcr11,
            tc_jcr40_l   LIKE tc_jcr_file.tc_jcr40, #热源尺寸及功率
            tc_jcr07_l   LIKE tc_jcr_file.tc_jcr07,
            tc_jcr13_l   LIKE tc_jcr_file.tc_jcr13,
            oba02_l      LIKE oba_file.oba02,
            tc_jcr14_l   LIKE tc_jcr_file.tc_jcr14,
            tc_jcr15_l   LIKE tc_jcr_file.tc_jcr15,
            tc_jcr16_l   LIKE tc_jcr_file.tc_jcr16,
            tc_jcr17_l   LIKE tc_jcr_file.tc_jcr17,
            tc_jcr12_l   LIKE tc_jcr_file.tc_jcr12,
            tc_jcr18_l   LIKE tc_jcr_file.tc_jcr18,
            tc_jcr19_l   LIKE tc_jcr_file.tc_jcr19,
            tc_jcr20_l   LIKE tc_jcr_file.tc_jcr20,
            tc_jcruser_l   LIKE tc_jcr_file.tc_jcruser,
            gen02_l      LIKE gen_file.gen02,
            tc_jcrgrup_l   LIKE tc_jcr_file.tc_jcrgrup,
            gem02_l      LIKE gem_file.gem02,
            tc_jcr21_l   LIKE tc_jcr_file.tc_jcr21,
            tc_jcr22_l   LIKE tc_jcr_file.tc_jcr22,
            tc_jcr23_l   LIKE tc_jcr_file.tc_jcr23,
            tc_jcr27_l   LIKE tc_jcr_file.tc_jcr27,# Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39
            tc_jcr25_l   LIKE tc_jcr_file.tc_jcr25,
            tc_jcr24_l   LIKE tc_jcr_file.tc_jcr24,
            tc_jcr30_l   LIKE tc_jcr_file.tc_jcr30,
            tc_jcr38_l   LIKE tc_jcr_file.tc_jcr38,
            tc_jcr39_l   LIKE tc_jcr_file.tc_jcr39,
            tc_jcr43_l   LIKE tc_jcr_file.tc_jcr43 # Modify by li251110 添加 tc_jcr43 字段
                    END RECORD
 
MAIN

    OPTIONS                                #改變一些系統預設值
        INPUT NO WRAP,
        FIELD ORDER FORM                   #整個畫面會依照p_per所設定的欄位順序(忽略4gl寫的順序)  #FUN-730075
    DEFER INTERRUPT

   LET g_argv1 = ARG_VAL(1)              #报价号  #CHI-720014 add
   LET g_argv2 = ARG_VAL(2)              #功能
   LET g_bgjob = ARG_VAL(3)              
   IF cl_null(g_bgjob) THEN
      LET g_bgjob= "N"
   END IF

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("CBM")) THEN
      EXIT PROGRAM
   END IF
 
    CALL  cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0060

    INITIALIZE g_tc_jcr.* TO NULL
    INITIALIZE g_tc_jcr_t.* TO NULL

    IF cl_null(g_argv1) THEN 
      IF cl_null(g_bgjob) OR g_bgjob='N' THEN 
 
          LET g_forupd_sql = "SELECT * FROM tc_jcr_file WHERE tc_jcr01 = ? FOR UPDATE"
       
          LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
          DECLARE i109_cl CURSOR FROM g_forupd_sql              # LOCK CURSOR
       
          LET p_row = 4 LET p_col = 6
          OPEN WINDOW i109_w AT p_row,p_col WITH FORM "cbm/42f/cbmi109"
           ATTRIBUTE (STYLE = g_win_style CLIPPED)
           
          CALL cl_ui_init()

         # Modify by li240512 添加 tc_jcr40 字段
         IF g_dbs = 'jd' THEN
            CALL cl_set_comp_visible("tc_jcr40,tc_jcr40_l",true)
         ELSE
            CALL cl_set_comp_visible("tc_jcr40,tc_jcr40_l",false)
         END IF
         # Modify by li240512 添加 tc_jcr40 字段

          CALL cl_set_comp_entry("tc_jcr01,tc_jcr18,tc_jcr21",FALSE)
          CALL cl_set_comp_required("tc_jcr03,tc_jcr05,tc_jcr06,tc_jcr07,tc_jcr25,tc_jcr12,tc_jcr10,tc_jcr11,tc_jcr13,tc_jcr14,tc_jcr16,tc_jcr20,tc_jcr23,tc_jcr19",TRUE)

          LET g_action_choice=""
          
          CALL i109_menu()
       
          CLOSE WINDOW i109_w
      ELSE 
         CASE g_argv2
             WHEN "pconfirm"
                CALL i109_pconfirm()
                EXIT PROGRAM
             OTHERWISE
                CALL i109_q()
         END CASE
         
      END IF 
    ELSE 
      CALL i109_q()
    END IF  
    CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0060
END MAIN
 
FUNCTION i109_cs()

   CLEAR FORM
   IF cl_null(g_argv1) THEN                  #CHI-720014 add
      INITIALIZE g_tc_jcr.* TO NULL    #No.FUN-750051 # Modify by li240512 添加 tc_jcr40 字段 # Modify by MO240925 添加 tc_jcr41 字段
      # Modify by li250911 添加tc_jcr42字段
      # Modify by li251110 添加 tc_jcr43 字段
      # Modify by dmw 20260407 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段
      CONSTRUCT BY NAME g_wc ON tc_jcr01,tc_jcr02,tc_jcr09,tc_jcr03,tc_jcr04,tc_jcr05,tc_jcr06,tc_jcr44,tc_jcr45,tc_jcr46,tc_jcr47,
                                tc_jcr07,tc_jcr25,tc_jcr24,tc_jcr08,tc_jcr12,
                                tc_jcr10,tc_jcr11,tc_jcr13,tc_jcr14,tc_jcr15,tc_jcr16,tc_jcr17,tc_jcr18,tc_jcr19,tc_jcr20,
                                tc_jcr21,tc_jcr22,tc_jcr23,tc_jcrconf,tc_jcruser,tc_jcrgrup,tc_jcroriu,tc_jcrorig,tc_jcracti,tc_jcrmodu,
                                tc_jcrdate,tc_jcrcrat,tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32,tc_jcr33,tc_jcr34,
                                tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39,tc_jcr40,tc_jcr41,tc_jcr42,tc_jcr43
         BEFORE CONSTRUCT
           CALL cl_qbe_init()
             
         ON ACTION controlp     #查詢條件
            CASE
              
               WHEN INFIELD(tc_jcr01)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "cq_tc_jcr"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret 
                 DISPLAY g_qryparam.multiret TO tc_jcr01
                 NEXT FIELD tc_jcr01
              
               WHEN INFIELD(tc_jcr05)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_occ"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO tc_jcr05
                 NEXT FIELD tc_jcr05

               #add by dmw 20260403 添加 tc_jcr44、tc_jcr46字段的查询
               WHEN INFIELD(tc_jcr44)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_occ"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO tc_jcr44
                 NEXT FIELD tc_jcr44

               WHEN INFIELD(tc_jcr46)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_occ"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO tc_jcr46
                 NEXT FIELD tc_jcr46

               WHEN INFIELD(tc_jcr07)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_imz"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO tc_jcr07
                 NEXT FIELD tc_jcr07

               WHEN INFIELD(tc_jcr13)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oba"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO tc_jcr13
                 NEXT FIELD tc_jcr13

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

         ON ACTION qbe_select
            CALL cl_qbe_select()
            
         ON ACTION qbe_save
            CALL cl_qbe_save()
            
      END CONSTRUCT

   ELSE
   
      LET g_wc = " tc_jcr01 ='",g_argv1,"'"
      
   END IF 

    LET g_wc = g_wc CLIPPED,cl_get_extra_cond('tc_jcruser', 'tc_jcrgrup')
 
    LET g_sql="SELECT tc_jcr01 FROM tc_jcr_file ",
              " WHERE ",g_wc CLIPPED,
              " ORDER BY tc_jcr01"
    PREPARE i109_prepare FROM g_sql     # RUNTIME 編譯
    DECLARE i109_cs                     # SCROLL CURSOR
        SCROLL CURSOR WITH HOLD FOR i109_prepare
    DECLARE i109_list_cs                     # SCROLL CURSOR
        SCROLL CURSOR WITH HOLD FOR i109_prepare    
    LET g_sql=
        "SELECT COUNT(*) FROM tc_jcr_file WHERE ",g_wc CLIPPED
    PREPARE i109_precount FROM g_sql
    DECLARE i109_count CURSOR FOR i109_precount
END FUNCTION
 
FUNCTION i109_menu()
   DEFINE l_cmd	   LIKE type_file.chr50    #No.FUN-680096   VARCHAR(30)
 
    MENU ""
 
        BEFORE MENU
            CALL cl_navigator_setting( g_curs_index, g_row_count )

        ON ACTION info_list
            LET g_action_choice = ""
            CALL i109_b_menu()
            IF g_action_choice = "exit" THEN
               EXIT MENU
            END IF
            LET g_action_choice = ""
 
        ON ACTION insert
            LET g_action_choice="insert"
            IF cl_chk_act_auth() THEN
               CALL i109_a()
            END IF
            
        ON ACTION query
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN
               CALL i109_q()
            END IF
        
        ON ACTION invalid
            IF cl_chk_act_auth() THEN
               CALL i109_x()
            END IF
        
        ON ACTION next
            CALL i109_fetch('N')
            
        ON ACTION previous
            CALL i109_fetch('P')
            
        ON ACTION modify
            LET g_action_choice="modify"
            IF cl_chk_act_auth() THEN
               CALL i109_u()
            END IF
            
        ON ACTION delete
            LET g_action_choice="delete"
            IF cl_chk_act_auth() THEN
               CALL i109_r()
            END IF
            
        ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_chk_act_auth() THEN
               CALL i109_copy()
            END IF

        ON ACTION output
            LET g_action_choice="output"
            IF cl_chk_act_auth() THEN
               IF g_tc_jcr.tc_jcr01 IS NULL THEN 
                   CALL cl_err('',-400,1)
               ELSE  
                  # Modify by li240514 添加 jd 资料库打印报表 b
                  IF g_dbs = 'jd' THEN    # g_dbs = 'jd'
                     CALL i109_jd_out()
                  ELSE 
                 # Modify by li240514 添加 jd 资料库打印报表 e
                     IF g_tc_jcr.tc_jcr25 ='1' THEN 
                        CALL i109_out() 
                     ELSE 
                        IF g_tc_jcr.tc_jcr25 ='3' THEN 
                           CALL  i109_1_out()
                        ELSE 
                           MENU "" ATTRIBUTE(STYLE="popup")
                              ON ACTION out_i1091
                                 CALL i109_out() 
                              ON ACTION out_i1092
                                 CALL i109_1_out()
                           END MENU
                        END IF 
                      END IF 
                  END IF
               END IF
            END IF
        ON ACTION confirm  
            LET g_action_choice="confirm"
            IF cl_chk_act_auth() THEN
               CALL i109_y()
            END IF

        ON ACTION unconfirm  
            LET g_action_choice="unconfirm"
            IF cl_chk_act_auth() THEN
               CALL i109_z()
            END IF    
            
        ON ACTION help
           CALL cl_show_help()
        ON ACTION locale
           CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           CALL cl_set_field_pic("","","","","",g_tc_jcr.tc_jcracti)
#          EXIT MENU
        ON ACTION exit
           LET g_action_choice = "exit"
           EXIT MENU
        ON ACTION jump
            CALL i109_fetch('/')
        ON ACTION first
            CALL i109_fetch('F')
        ON ACTION last
            CALL i109_fetch('L')
 
        ON ACTION CONTROLG
            CALL cl_cmdask()
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
 
        ON ACTION about         #MOD-4C0121
           CALL cl_about()      #MOD-4C0121
 
           LET g_action_choice = "exit"
           CONTINUE MENU
 
 
        -- for Windows close event trapped
        ON ACTION close   #COMMAND KEY(INTERRUPT) #FUN-9B0145  
            LET INT_FLAG=FALSE 		#MOD-570244	mars
            LET g_action_choice = "exit"
            EXIT MENU

        ON ACTION related_document                   #MOD-470051
            LET g_action_choice="related_document"
            IF cl_chk_act_auth() THEN
               IF g_tc_jcr.tc_jcr01 IS NOT NULL THEN
                  LET g_doc.column1 = "tc_jcr01"
                  LET g_doc.value1  = g_tc_jcr.tc_jcr01
                  CALL cl_doc()
               END IF
            END IF
    END MENU
    CLOSE i109_cs
END FUNCTION
 
 
FUNCTION i109_a()
  DEFINE l_opc      LIKE ze_file.ze03,  #No.FUN-680096 VARCHAR(10)
         l_des      LIKE ze_file.ze03   #No.FUN-680096 VARCHAR(4) #TQC-840066
  DEFINE li_result  LIKE type_file.num5  
  
    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM                                   # 清螢墓欄位內容
    INITIALIZE g_tc_jcr.* LIKE tc_jcr_file.*
    LET g_wc = NULL
    LET g_tc_jcr01_t = NULL
    LET g_tc_jcr_t.*=g_tc_jcr.*
    LET g_tc_jcr_o.*=g_tc_jcr.*

    DISPLAY l_des TO FORMONLY.des
    CALL cl_opmsg('a')
    BEGIN WORK
    WHILE TRUE
        LET g_tc_jcr.tc_jcracti ='Y'
        LET g_tc_jcr.tc_jcrconf ='N'
        LET g_tc_jcr.tc_jcruser = g_user
        LET g_tc_jcr.tc_jcroriu = g_user #FUN-980030
        LET g_tc_jcr.tc_jcrorig = g_grup #FUN-980030
        LET g_tc_jcr.tc_jcrgrup = g_grup
        LET g_tc_jcr.tc_jcrcrat = g_today
        LET g_tc_jcr.tc_jcr25 = '1'
        LET g_tc_jcr.tc_jcr31='N'
        LET g_tc_jcr.tc_jcr32='N'
        LET g_tc_jcr.tc_jcr33='N'
        LET g_tc_jcr.tc_jcr34='N'
        LET g_tc_jcr.tc_jcr35='N'
        LET g_tc_jcr.tc_jcr36='N' 
        LET g_tc_jcr.tc_jcr37='N'
        
        CALL i109_i("a")                         #各欄位輸入
        IF INT_FLAG THEN                         #若按了DEL鍵
            INITIALIZE g_tc_jcr.* TO NULL
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            CLEAR FORM
            ROLLBACK WORK
            EXIT WHILE
        END IF

      CALL i109_auto_set_docno() RETURNING g_tc_jcr.tc_jcr01       
        --CALL s_auto_assign_no("abm",g_tc_jcr.tc_jcr01,g_today,"6","tc_jcr_file","tc_jcr01","","","") 
         --RETURNING li_result,g_tc_jcr.tc_jcr01
        --IF (NOT li_result) THEN
           --CONTINUE WHILE
        --END IF
        DISPLAY BY NAME g_tc_jcr.tc_jcr01

        IF g_tc_jcr.tc_jcr01 IS NULL THEN                # KEY 不可空白 
            IF g_tc_jcr.tc_jcr09 = 1 THEN 
               INITIALIZE g_tc_jcr.tc_jcr02,g_tc_jcr.tc_jcr09 TO NULL 
            END IF 
            CONTINUE WHILE
        END IF

        INSERT INTO tc_jcr_file VALUES(g_tc_jcr.*)       
        IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)   
            CONTINUE WHILE
        END IF
        LET g_tc_jcr_t.* = g_tc_jcr.*                # 保存上筆資料
        SELECT tc_jcr01 INTO g_tc_jcr.tc_jcr01 FROM tc_jcr_file
         WHERE tc_jcr01 = g_tc_jcr.tc_jcr01
        COMMIT WORK
        EXIT WHILE
    END WHILE

END FUNCTION
 
FUNCTION i109_i(p_cmd)
    DEFINE l_sc          LIKE type_file.chr12,     #LIKE cqo_file.cqo12,      #No.FUN-680096 VARCHAR(12)   #TQC-B90211
           l_opc         LIKE ze_file.ze03,        #No.FUN-680096 VARCHAR(10)
           l_des         LIKE ze_file.ze03,        #No.FUN-680096 VARCHAR(4) #TQC-840066
           p_cmd         LIKE type_file.chr1,      #No.FUN-680096 VARCHAR(1)
           l_n           LIKE type_file.num5       #No.FUN-680096 SMALLINT
    DEFINE lc_sma119     LIKE sma_file.sma119,     #FUN-590078
           li_len        LIKE type_file.num5,       #FUN-590078   #No.FUN-680096 SMALLINT
           l_cnt         LIKE type_file.num5,
           l_occ02       LIKE occ_file.occ02,
           l_oba02       LIKE oba_file.oba02
    DEFINE li_result     LIKE type_file.num5
    DEFINE l_imz02       LIKE imz_file.imz02
    DEFINE l_int         LIKE type_file.num5
    DEFINE l_smyslip     LIKE smy_file.smyslip, #单别
           l_smy         LIKE smy_file.smydesc #单据名称
 
    DISPLAY BY NAME g_tc_jcr.tc_jcruser, g_tc_jcr.tc_jcrgrup,g_tc_jcr.tc_jcroriu,g_tc_jcr.tc_jcrorig,
                    g_tc_jcr.tc_jcrcrat,g_tc_jcr.tc_jcrmodu, g_tc_jcr.tc_jcrdate,g_tc_jcr.tc_jcrconf,
                    g_tc_jcr.tc_jcracti,g_tc_jcr.tc_jcr25
                    
    --CALL cl_set_comp_required("tc_jcr03,tc_jcr05,tc_jcr06,tc_jcr07,tc_jcr25,tc_jcr12,tc_jcr13,tc_jcr14",TRUE)
    --IF p_cmd = 'a' THEN
      --SELECT COUNT(*) INTO l_int FROM smy_file WHERE smykind='6'
        --IF l_int=1 THEN     #如只有1种单别,则自动选择单别
           --SELECT smyslip,smydesc INTO l_smyslip,l_smy FROM smy_file WHERE smykind='6'
           --LET g_tc_jcr.tc_jcr01=l_smyslip
           --DISPLAY l_smy TO FORMONLY.tc_jcr01
        --END IF
    --END IF
    # Modify by li250911 添加tc_jcr42字段
    # Modify by li251110 添加 tc_jcr43 字段
    # Modify by dmw 20260403 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段
    INPUT BY NAME g_tc_jcr.tc_jcr01, g_tc_jcr.tc_jcr02, g_tc_jcr.tc_jcr03, g_tc_jcr.tc_jcr04, g_tc_jcr.tc_jcr05, g_tc_jcr.tc_jcr06,
                  g_tc_jcr.tc_jcr44,g_tc_jcr.tc_jcr45,g_tc_jcr.tc_jcr46,g_tc_jcr.tc_jcr47, 
                  g_tc_jcr.tc_jcr07, g_tc_jcr.tc_jcr25, g_tc_jcr.tc_jcr24, g_tc_jcr.tc_jcr08, g_tc_jcr.tc_jcr09, g_tc_jcr.tc_jcr10, 
                  g_tc_jcr.tc_jcr11, g_tc_jcr.tc_jcr12,  
                  g_tc_jcr.tc_jcr13, g_tc_jcr.tc_jcr14, g_tc_jcr.tc_jcr15, g_tc_jcr.tc_jcr16, g_tc_jcr.tc_jcr17,
                  g_tc_jcr.tc_jcr18, g_tc_jcr.tc_jcr19, g_tc_jcr.tc_jcr20, g_tc_jcr.tc_jcr21, g_tc_jcr.tc_jcr22, g_tc_jcr.tc_jcr23,
                  g_tc_jcr.tc_jcr26, g_tc_jcr.tc_jcr27, g_tc_jcr.tc_jcr28, g_tc_jcr.tc_jcr29, g_tc_jcr.tc_jcr30, g_tc_jcr.tc_jcr31, 
                  g_tc_jcr.tc_jcr32, g_tc_jcr.tc_jcr33, g_tc_jcr.tc_jcr34, g_tc_jcr.tc_jcr35, g_tc_jcr.tc_jcr36, g_tc_jcr.tc_jcr37,
                  g_tc_jcr.tc_jcr38, g_tc_jcr.tc_jcr39, g_tc_jcr.tc_jcr40, g_tc_jcr.tc_jcr41, g_tc_jcr.tc_jcr42, g_tc_jcr.tc_jcr43
        WITHOUT DEFAULTS
 
        BEFORE INPUT
            --LET g_before_input_done = FALSE
            --CALL i109_set_entry(p_cmd)
            --CALL i109_set_no_entry(p_cmd)
            --LET g_before_input_done = TRUE
            --CALL cl_chg_comp_att("tc_jcr01","WIDTH|GRIDWIDTH|SCROLL",li_len || "|" || li_len || "|0") 

            CALL cl_set_comp_entry("tc_jcr06,tc_jcr24,tc_jcr08",FALSE)
            CALL cl_set_comp_entry("tc_jcr02,tc_jcr42",TRUE)
            IF NOT cl_null(g_tc_jcr.tc_jcr25) THEN 
               IF g_tc_jcr.tc_jcr25 ='1' THEN 
                  LET g_tc_jcr.tc_jcr24 = NULL
                  CALL cl_set_comp_entry("tc_jcr08",TRUE)
                  CALL cl_set_comp_required("tc_jcr08",TRUE)
                  CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为1时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
                  CALL cl_set_comp_entry("tc_jcr24",FALSE)
                  CALL cl_set_comp_required("tc_jcr24",FALSE)
                  CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",FALSE)# Modify by mo 231218 单据类别为1时，取消必输
                  CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39",FALSE)# Modify by mo 231218 单据类别为1时，取消必输
               ELSE 
                  IF g_tc_jcr.tc_jcr25 ='3' THEN 
                     LET g_tc_jcr.tc_jcr08 = NULL
                     CALL cl_set_comp_entry("tc_jcr24",TRUE)
                     CALL cl_set_comp_required("tc_jcr24",TRUE)
                     CALL cl_set_comp_entry("tc_jcr08",FALSE)
                     CALL cl_set_comp_required("tc_jcr08",FALSE)
                     CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",FALSE)# Modify by dmw 20260408 单据类别为3时，取消tc_jcr13,tc_jcr14,tc_jcr16字段必填
                     CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                     CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39,tc_jcr43",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
               ELSE 
                  IF g_tc_jcr.tc_jcr25 ='4' THEN   
                   CALL cl_set_comp_required("tc_jcr24,tc_jcr08,tc_jcr12,tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr35,tc_jcr43,tc_jcr39,tc_jcr42",FALSE)
                   CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为4时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
                  ELSE 
                     CALL cl_set_comp_entry("tc_jcr08,tc_jcr24",TRUE)
                     CALL cl_set_comp_required("tc_jcr08,tc_jcr24",TRUE)
                     CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为2时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
                     CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                     CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39,tc_jcr43",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                  END IF 
                  END IF 
               END IF 
            END IF 
            IF p_cmd = 'u' THEN
              IF g_tc_jcr.tc_jcr05 MATCHES 'MISC*' THEN
                 CALL cl_set_comp_entry("tc_jcr06",TRUE)
              ELSE
                 CALL cl_set_comp_entry("tc_jcr06",FALSE)
              END IF
              IF g_tc_jcr.tc_jcr09 = 1 THEN 
                 CALL cl_set_comp_entry("tc_jcr02",FALSE)
              ELSE 
                 CALL cl_set_comp_entry("tc_jcr02",TRUE) 
              END IF 
            END IF
            CALL cl_set_comp_required("tc_jcr41",IIF(g_tc_jcr.tc_jcr05='M2121',TRUE,FALSE))
            NEXT FIELD tc_jcr02


 
        AFTER FIELD tc_jcr01
            IF NOT cl_null(g_tc_jcr.tc_jcr01) THEN 
               CALL s_check_no("abm",g_tc_jcr.tc_jcr01,g_tc_jcr_t.tc_jcr01,"6","tc_jcr_file","tc_jcr01","")
               RETURNING li_result,g_tc_jcr.tc_jcr01
               IF(NOT li_result) THEN
                  LET g_tc_jcr.tc_jcr01=g_tc_jcr_t.tc_jcr01
                  DISPLAY BY NAME g_tc_jcr.tc_jcr01
                  NEXT FIELD tc_jcr01
               END IF
            END IF 
         
         AFTER FIELD tc_jcr02
           IF NOT cl_null(g_tc_jcr.tc_jcr02) THEN 
             IF cl_null(g_tc_jcr_o.tc_jcr02) OR g_tc_jcr_o.tc_jcr02<>g_tc_jcr.tc_jcr02 THEN
                LET l_cnt =0 
                SELECT COUNT(*) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcrconf='N' AND tc_jcr25<>'3' AND tc_jcracti='Y'
                IF l_cnt >0 THEN 
                  CALL cl_err('','aap-239',0)
                  NEXT FIELD tc_jcr02
                END IF 
                IF g_tc_jcr.tc_jcr02 MATCHES 'A*' THEN 
                   SELECT * FROM ima_file WHERE ima01=g_tc_jcr.tc_jcr02 AND ima140='N' AND imaacti='Y'
                   IF SQLCA.sqlcode THEN 
                     CALL cl_err('','cbm-005',0)
                     LET g_tc_jcr.tc_jcr02 = g_tc_jcr_o.tc_jcr02
                     NEXT FIELD tc_jcr02
                   END IF 

                   LET l_cnt = 0
                   SELECT MAX(tc_jcr09) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcr25<>'3' AND tc_jcracti='Y' 
                   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                   IF l_cnt = 0 THEN 
                      LET g_tc_jcr.tc_jcr09 = l_cnt+1
                      SELECT ima02,ima021,imaud04,occ02,ima06,imaud02,imaud06,ima131
                           INTO g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,g_tc_jcr.tc_jcr07,
                                g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,g_tc_jcr.tc_jcr13
                      FROM ima_file 
                      LEFT JOIN occ_file ON occ01=imaud04
                      WHERE ima01=g_tc_jcr.tc_jcr02
                      DISPLAY BY NAME g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,g_tc_jcr.tc_jcr07,
                                g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,g_tc_jcr.tc_jcr13,g_tc_jcr.tc_jcr09
                   ELSE 
                      LET g_tc_jcr.tc_jcr09 = l_cnt + 1
                      SELECT tc_jcr03,tc_jcr04,tc_jcr05 ,tc_jcr06,tc_jcr07,tc_jcr08,tc_jcr10,tc_jcr11,
                            tc_jcr12,tc_jcr13,tc_jcr14,tc_jcr15,tc_jcr16,tc_jcr17,tc_jcr19,tc_jcr20
                        INTO g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,
                             g_tc_jcr.tc_jcr07,g_tc_jcr.tc_jcr08,g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,
                             g_tc_jcr.tc_jcr12,g_tc_jcr.tc_jcr13,g_tc_jcr.tc_jcr14,g_tc_jcr.tc_jcr15,
                             g_tc_jcr.tc_jcr16,g_tc_jcr.tc_jcr17,g_tc_jcr.tc_jcr19,g_tc_jcr.tc_jcr20
                      FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcr09=l_cnt
                      DISPLAY BY NAME g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,
                             g_tc_jcr.tc_jcr07,g_tc_jcr.tc_jcr08,g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,
                             g_tc_jcr.tc_jcr12,g_tc_jcr.tc_jcr13,g_tc_jcr.tc_jcr14,g_tc_jcr.tc_jcr15,
                             g_tc_jcr.tc_jcr16,g_tc_jcr.tc_jcr17,g_tc_jcr.tc_jcr19,g_tc_jcr.tc_jcr20,
                             g_tc_jcr.tc_jcr09
                   END IF 
                ELSE 
                   LET l_cnt = 0
                   SELECT MAX(tc_jcr09) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcracti='Y'
                   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF 

                   IF l_cnt = 0 THEN 
                     CALL cl_err('','cbm-005',0)
                     LET g_tc_jcr.tc_jcr02 = g_tc_jcr_o.tc_jcr02
                     NEXT FIELD tc_jcr02
                   ELSE 
                     LET l_cnt = 0
                     SELECT MAX(tc_jcr09) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcracti='Y'
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     LET g_tc_jcr.tc_jcr09 = l_cnt + 1
                     SELECT tc_jcr03,tc_jcr04,tc_jcr05 ,tc_jcr06,tc_jcr07,tc_jcr08,tc_jcr10,tc_jcr11,
                            tc_jcr12,tc_jcr13,tc_jcr14,tc_jcr15,tc_jcr16,tc_jcr17,tc_jcr19,tc_jcr20
                        INTO g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,
                             g_tc_jcr.tc_jcr07,g_tc_jcr.tc_jcr08,g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,
                             g_tc_jcr.tc_jcr12,g_tc_jcr.tc_jcr13,g_tc_jcr.tc_jcr14,g_tc_jcr.tc_jcr15,
                             g_tc_jcr.tc_jcr16,g_tc_jcr.tc_jcr17,g_tc_jcr.tc_jcr19,g_tc_jcr.tc_jcr20
                     FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcr09=l_cnt
                     DISPLAY BY NAME g_tc_jcr.tc_jcr03,g_tc_jcr.tc_jcr04,g_tc_jcr.tc_jcr05,g_tc_jcr.tc_jcr06,
                             g_tc_jcr.tc_jcr07,g_tc_jcr.tc_jcr08,g_tc_jcr.tc_jcr10,g_tc_jcr.tc_jcr11,
                             g_tc_jcr.tc_jcr12,g_tc_jcr.tc_jcr13,g_tc_jcr.tc_jcr14,g_tc_jcr.tc_jcr15,
                             g_tc_jcr.tc_jcr16,g_tc_jcr.tc_jcr17,g_tc_jcr.tc_jcr19,g_tc_jcr.tc_jcr20,
                             g_tc_jcr.tc_jcr09
                   END IF 
                END IF 

                LET g_tc_jcr_o.tc_jcr02 = g_tc_jcr.tc_jcr02
             END IF 
          END IF 
          
        AFTER FIELD tc_jcr05 
          IF NOT cl_null(g_tc_jcr.tc_jcr05) THEN 
            IF cl_null(g_tc_jcr_o.tc_jcr05) OR g_tc_jcr_o.tc_jcr05<>g_tc_jcr.tc_jcr05 THEN
               LET l_occ02 = NULL  
               SELECT occ02 INTO l_occ02 FROM occ_file WHERE occ01=g_tc_jcr.tc_jcr05 AND occacti='Y' AND occ1004='1'
               IF sqlca.sqlcode THEN
                  CALL cl_err(g_tc_jcr.tc_jcr05,sqlca.sqlcode,0)
                  LET g_tc_jcr.tc_jcr05 = g_tc_jcr_o.tc_jcr05
                  DISPLAY BY NAME g_tc_jcr.tc_jcr05
                  NEXT FIELD tc_jcr05
               END IF
               IF g_tc_jcr.tc_jcr05 MATCHES 'MISC*' THEN
                  LET g_tc_jcr.tc_jcr06 = NULL
               ELSE
                  LET g_tc_jcr.tc_jcr06 = l_occ02
               END IF
               DISPLAY BY NAME g_tc_jcr.tc_jcr06
               CALL cl_set_comp_required("tc_jcr41",IIF(g_tc_jcr.tc_jcr05='M2121',TRUE,FALSE))
            END IF 
          END IF 
          CALL i109_set_no_entry(p_cmd)
          LET g_tc_jcr_o.tc_jcr05=g_tc_jcr.tc_jcr05

         #add by dmw 20260403 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段维护逻辑与 tc_jcr05、tc_jcr06 字段相同
         AFTER FIELD tc_jcr44 
          IF NOT cl_null(g_tc_jcr.tc_jcr44) THEN 
            IF cl_null(g_tc_jcr_o.tc_jcr44) OR g_tc_jcr_o.tc_jcr44<>g_tc_jcr.tc_jcr44 THEN
               LET l_occ02 = NULL  
               SELECT occ02 INTO l_occ02 FROM occ_file WHERE occ01=g_tc_jcr.tc_jcr44 AND occacti='Y' AND occ1004='1'
               IF sqlca.sqlcode THEN
                  CALL cl_err(g_tc_jcr.tc_jcr44,sqlca.sqlcode,0)
                  LET g_tc_jcr.tc_jcr44 = g_tc_jcr_o.tc_jcr44  
                  DISPLAY BY NAME g_tc_jcr.tc_jcr44
                  NEXT FIELD tc_jcr44
               END IF
               IF g_tc_jcr.tc_jcr44 MATCHES 'MISC*' THEN
                  LET g_tc_jcr.tc_jcr45 = NULL
               ELSE
                  LET g_tc_jcr.tc_jcr45 = l_occ02
               END IF
               DISPLAY BY NAME g_tc_jcr.tc_jcr45
               CALL cl_set_comp_required("tc_jcr41",IIF(g_tc_jcr.tc_jcr44='M2121',TRUE,FALSE))
            END IF 
          END IF 
          CALL i109_set_no_entry(p_cmd)
          LET g_tc_jcr_o.tc_jcr44=g_tc_jcr.tc_jcr44

         AFTER FIELD tc_jcr46 
          IF NOT cl_null(g_tc_jcr.tc_jcr46) THEN 
            IF cl_null(g_tc_jcr_o.tc_jcr46) OR g_tc_jcr_o.tc_jcr46<>g_tc_jcr.tc_jcr46 THEN
               LET l_occ02 = NULL  
               SELECT occ02 INTO l_occ02 FROM occ_file WHERE occ01=g_tc_jcr.tc_jcr46 AND occacti='Y' AND occ1004='1'
               IF sqlca.sqlcode THEN
                  CALL cl_err(g_tc_jcr.tc_jcr46,sqlca.sqlcode,0)
                  LET g_tc_jcr.tc_jcr46 = g_tc_jcr_o.tc_jcr46  
                  DISPLAY BY NAME g_tc_jcr.tc_jcr46
                  NEXT FIELD tc_jcr46
               END IF
               IF g_tc_jcr.tc_jcr46 MATCHES 'MISC*' THEN
                  LET g_tc_jcr.tc_jcr47 = NULL
               ELSE
                  LET g_tc_jcr.tc_jcr47 = l_occ02
               END IF
               DISPLAY BY NAME g_tc_jcr.tc_jcr47
               CALL cl_set_comp_required("tc_jcr41",IIF(g_tc_jcr.tc_jcr46='M2121',TRUE,FALSE))
            END IF 
          END IF 
          CALL i109_set_no_entry(p_cmd)
          LET g_tc_jcr_o.tc_jcr46=g_tc_jcr.tc_jcr46
          
        AFTER FIELD tc_jcr07                     #分群碼
          IF cl_null(g_tc_jcr_o.tc_jcr07) OR g_tc_jcr_o.tc_jcr07 <> g_tc_jcr.tc_jcr07 THEN
            LET l_imz02 = NULL 
            SELECT imz02 INTO l_imz02 FROM imz_file WHERE imz01=g_tc_jcr.tc_jcr07 AND imzacti='Y'
            IF SQLCA.sqlcode THEN 
               CALL cl_err('','aic-037',0)
               LET g_tc_jcr.tc_jcr07 = g_tc_jcr_o.tc_jcr07
               DISPLAY BY NAME g_tc_jcr.tc_jcr07
               NEXT FIELD tc_jcr07 
            END IF 
            DISPLAY l_imz02 TO FORMONLY.imz02
            
          END IF 
          LET g_tc_jcr_o.tc_jcr07 = g_tc_jcr.tc_jcr07
          
        AFTER FIELD tc_jcr25
          IF cl_null(g_tc_jcr_o.tc_jcr25) OR g_tc_jcr_o.tc_jcr25 <> g_tc_jcr.tc_jcr25 THEN
            IF g_tc_jcr.tc_jcr25 ='1' THEN 
               LET g_tc_jcr.tc_jcr24 = NULL
               CALL cl_set_comp_entry("tc_jcr08",TRUE)
               CALL cl_set_comp_required("tc_jcr08",TRUE)
               CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为1时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
               CALL cl_set_comp_entry("tc_jcr24",FALSE)
               CALL cl_set_comp_required("tc_jcr24",FALSE)
               CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",FALSE)# Modify by mo 231218 单据类别为1时，取消必输
               CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39",FALSE)# Modify by mo 231218 单据类别为1时，取消必输
               DISPLAY BY NAME g_tc_jcr.tc_jcr24
            ELSE 
               IF g_tc_jcr.tc_jcr25 ='3' THEN 
                  LET g_tc_jcr.tc_jcr08 = NULL
                  CALL cl_set_comp_entry("tc_jcr24",TRUE)
                  CALL cl_set_comp_required("tc_jcr24",TRUE)
                  CALL cl_set_comp_entry("tc_jcr08",FALSE)
                  CALL cl_set_comp_required("tc_jcr08",FALSE)
                  CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",FALSE)# Modify by dmw 20260408 单据类别为3时，取消tc_jcr13,tc_jcr14,tc_jcr16字段必填
                  CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                  CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                  
                  DISPLAY BY NAME g_tc_jcr.tc_jcr08
             ELSE 
                  IF g_tc_jcr.tc_jcr25 ='4' THEN   
                   CALL cl_set_comp_required("tc_jcr24,tc_jcr08,tc_jcr12,tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr35,tc_jcr43,tc_jcr39,tc_jcr42",FALSE)
                   CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为4时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
               ELSE 
                  CALL cl_set_comp_entry("tc_jcr08,tc_jcr24",TRUE)
                  CALL cl_set_comp_required("tc_jcr08,tc_jcr24",TRUE)
                  CALL cl_set_comp_required("tc_jcr13,tc_jcr14,tc_jcr16",TRUE)# Modify by dmw 20260408 单据类别为2时，tc_jcr13,tc_jcr14,tc_jcr16字段必填
                  CALL cl_set_comp_required("tc_jcr26,tc_jcr27,tc_jcr28,tc_jcr29,tc_jcr30,tc_jcr31,tc_jcr32",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
                  CALL cl_set_comp_required("tc_jcr33,tc_jcr34,tc_jcr35,tc_jcr36,tc_jcr37,tc_jcr38,tc_jcr39",TRUE)# Modify by mo 231218 单据类别为2，3时，为必输项
               END IF 
            END IF 
            END IF
          END IF 
          LET g_tc_jcr_o.tc_jcr25 = g_tc_jcr.tc_jcr25

         
          
        AFTER FIELD tc_jcr13  
          IF cl_null(g_tc_jcr_o.tc_jcr13) OR g_tc_jcr_o.tc_jcr13 <> g_tc_jcr.tc_jcr13 THEN
             LET l_oba02=NULL 
             SELECT oba02 INTO l_oba02 FROM oba_file WHERE oba01=g_tc_jcr.tc_jcr13 AND obaacti='Y' 
             IF sqlca.sqlcode THEN 
                CALL cl_err('','aim-142',0)
                NEXT FIELD tc_jcr13
             ELSE 
                DISPLAY l_oba02 TO FORMONLY.oba02
             END IF 
          END IF 
          LET g_tc_jcr_o.tc_jcr13=g_tc_jcr.tc_jcr13
 
        AFTER INPUT
           LET g_tc_jcr.tc_jcruser = s_get_data_owner("tc_jcr_file") #FUN-C10039
           LET g_tc_jcr.tc_jcrgrup = s_get_data_group("tc_jcr_file") #FUN-C10039
          
            IF INT_FLAG THEN
               EXIT INPUT
            END IF

            IF cl_null(g_tc_jcr.tc_jcr02) THEN 
               IF g_dbs='jd' THEN 
                  # Modify by li240510 资料库为 jd 时,修改评估料号和报价编号的自动编号格式
                  CALL i109_auto_jcr02no() RETURNING g_tc_jcr.tc_jcr02
                  # Modify by li240510 资料库为 jd 时,修改评估料号和报价编号的自动编号格式
               ELSE
                   CALL i109_auto_docno(g_tc_jcr.tc_jcr07) RETURNING g_tc_jcr.tc_jcr02
               END IF
               LET g_tc_jcr.tc_jcr09 = 1
               DISPLAY BY NAME g_tc_jcr.tc_jcr02,g_tc_jcr.tc_jcr09
            END IF

            IF g_tc_jcr.tc_jcr25 ='3' THEN 
               LET g_tc_jcr.tc_jcr09 = 1
               DISPLAY BY NAME g_tc_jcr.tc_jcr09
            END IF 
            # Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39
            IF (g_tc_jcr.tc_jcr25='2' OR g_tc_jcr.tc_jcr25='3') 
              AND (p_cmd='a' OR (p_cmd='u' AND (g_tc_jcr_t.tc_jcr24<>g_tc_jcr.tc_jcr24 OR g_tc_jcr_t.tc_jcr02<>g_tc_jcr.tc_jcr02
              OR g_tc_jcr_t.tc_jcr25='1'))) THEN 
               SELECT COUNT(1)+1 INTO g_tc_jcr.tc_jcr38 
               FROM tc_jcr_file 
               WHERE tc_jcr02=g_tc_jcr.tc_jcr02 
               AND tc_jcr24=g_tc_jcr.tc_jcr24
               AND tc_jcr25 IN('2','3')
            END IF 
            DISPLAY BY NAME g_tc_jcr.tc_jcr38
            # Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39


        ON ACTION controlp     #查詢條件
            CASE
             #FUN-6B0026-begin-add
              WHEN INFIELD(tc_jcr01)
                  LET g_t1=s_get_doc_no(g_tc_jcr.tc_jcr01)
                  CALL q_smy(FALSE,FALSE,g_t1,'ABM','6') RETURNING g_t1 #TQC-670008
                  LET g_tc_jcr.tc_jcr01 = g_t1
                  DISPLAY BY NAME g_tc_jcr.tc_jcr01
                  NEXT FIELD tc_jcr01
                 
               WHEN INFIELD(tc_jcr07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_imz"
                  LET g_qryparam.default1 = g_tc_jcr.tc_jcr07
                  CALL cl_create_qry() RETURNING g_tc_jcr.tc_jcr07
                  DISPLAY BY NAME g_tc_jcr.tc_jcr07
                  NEXT FIELD tc_jcr07
           
               WHEN INFIELD(tc_jcr05)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_occ"
                  LET g_qryparam.default1 = g_tc_jcr.tc_jcr05
                  CALL cl_create_qry() RETURNING g_tc_jcr.tc_jcr05
                  DISPLAY BY NAME g_tc_jcr.tc_jcr05
                  NEXT FIELD tc_jcr05

            #add by dmw 20260403 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段增加查询功能
               WHEN INFIELD(tc_jcr44)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_occ"
                  LET g_qryparam.default1 = g_tc_jcr.tc_jcr44
                  CALL cl_create_qry() RETURNING g_tc_jcr.tc_jcr44
                  DISPLAY BY NAME g_tc_jcr.tc_jcr44
                  NEXT FIELD tc_jcr44

               WHEN INFIELD(tc_jcr46)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_occ"
                  LET g_qryparam.default1 = g_tc_jcr.tc_jcr46
                  CALL cl_create_qry() RETURNING g_tc_jcr.tc_jcr46
                  DISPLAY BY NAME g_tc_jcr.tc_jcr46
                  NEXT FIELD tc_jcr46

               WHEN INFIELD(tc_jcr13)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_oba"
                  LET g_qryparam.default1 = g_tc_jcr.tc_jcr13
                  CALL cl_create_qry() RETURNING g_tc_jcr.tc_jcr13
                  DISPLAY BY NAME g_tc_jcr.tc_jcr13
                  NEXT FIELD tc_jcr13
             END CASE
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION CONTROLF                        # 欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
    END INPUT
END FUNCTION

FUNCTION i109_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    MESSAGE ""
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL i109_cs()                          # 宣告 SCROLL CURSOR
    IF INT_FLAG THEN
        LET INT_FLAG = 0
        CLEAR FORM
        RETURN
    END IF
    OPEN i109_count
    FETCH i109_count INTO g_row_count
    DISPLAY g_row_count TO FORMONLY.cnt
    OPEN i109_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0)
        INITIALIZE g_tc_jcr.* TO NULL
    ELSE
        CALL i109_fetch('F')                  # 讀出TEMP第一筆並顯示
        
    END IF
END FUNCTION
 
FUNCTION i109_fetch(p_fltc_jcr)
    DEFINE
        p_fltc_jcr    LIKE type_file.chr1      #No.FUN-680096 VARCHAR(1)
 
    CASE p_fltc_jcr
        WHEN 'N' FETCH NEXT     i109_cs INTO g_tc_jcr.tc_jcr01
        WHEN 'P' FETCH PREVIOUS i109_cs INTO g_tc_jcr.tc_jcr01
        WHEN 'F' FETCH FIRST    i109_cs INTO g_tc_jcr.tc_jcr01
        WHEN 'L' FETCH LAST     i109_cs INTO g_tc_jcr.tc_jcr01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0  ######add for prompt bug
                PROMPT g_msg CLIPPED,': ' FOR g_jump
                   ON IDLE g_idle_seconds
                      CALL cl_on_idle()
#                      CONTINUE PROMPT
 
                  ON ACTION about         #MOD-4C0121
                     CALL cl_about()      #MOD-4C0121
             
                  ON ACTION help          #MOD-4C0121
                     CALL cl_show_help()  #MOD-4C0121
             
                  ON ACTION controlg      #MOD-4C0121
                     CALL cl_cmdask()     #MOD-4C0121
 
 
                END PROMPT
                IF INT_FLAG THEN
                    LET INT_FLAG = 0
                    EXIT CASE
                END IF
            END IF
            LET mi_no_ask = FALSE
            FETCH ABSOLUTE g_jump i109_cs INTO g_tc_jcr.tc_jcr01
    END CASE
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0)
        INITIALIZE g_tc_jcr.* TO NULL  #TQC-6B0105
        RETURN
    ELSE
       CASE p_fltc_jcr
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF
    SELECT * INTO g_tc_jcr.* FROM tc_jcr_file
       WHERE tc_jcr01 = g_tc_jcr.tc_jcr01
    IF SQLCA.sqlcode THEN
  #     CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0) #No.TQC-660046
        CALL cl_err3("sel","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)   #No.TQC-660046
    ELSE
         LET g_data_owner = g_tc_jcr.tc_jcruser    #MOD-4C0054
         LET g_data_group = g_tc_jcr.tc_jcrgrup    #MOD-4C0054
         LET g_data_keyvalue = g_tc_jcr.tc_jcr01   #FUN-DA0124 add
        CALL i109_show()
    END IF
END FUNCTION
 
FUNCTION i109_show()
  DEFINE l_sc       LIKE zaa_file.zaa08,  #No.FUN-680096 VARCHAR(12)
         l_opc      LIKE ze_file.ze03,    #No.FUN-680096 VARCHAR(10)
         l_des      LIKE ze_file.ze03,     #No.FUN-680096 VARCHAR(4)
         l_oba02    LIKE oba_file.oba02,
         l_imz02    LIKE imz_file.imz02
 
    LET g_tc_jcr_t.* = g_tc_jcr.*
    # Modify by li250911 添加tc_jcr42字段
    # Modify by li251110 添加 tc_jcr43 字段
    # Modify by dmw 20260407 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段
    DISPLAY BY NAME  g_tc_jcr.tc_jcr01, g_tc_jcr.tc_jcr02, g_tc_jcr.tc_jcr03, g_tc_jcr.tc_jcr04, g_tc_jcr.tc_jcr05, g_tc_jcr.tc_jcr06,
                     g_tc_jcr.tc_jcr44, g_tc_jcr.tc_jcr45, g_tc_jcr.tc_jcr46, g_tc_jcr.tc_jcr47, # Modify by dmw 20260407
                     g_tc_jcr.tc_jcr07, g_tc_jcr.tc_jcr25, g_tc_jcr.tc_jcr24, g_tc_jcr.tc_jcr08, g_tc_jcr.tc_jcr09, g_tc_jcr.tc_jcr10, 
                     g_tc_jcr.tc_jcr11, g_tc_jcr.tc_jcr12,  
                     g_tc_jcr.tc_jcr13, g_tc_jcr.tc_jcr14, g_tc_jcr.tc_jcr15, g_tc_jcr.tc_jcr16, g_tc_jcr.tc_jcr17,
                     g_tc_jcr.tc_jcr18, g_tc_jcr.tc_jcr19, g_tc_jcr.tc_jcr20, g_tc_jcr.tc_jcr21, g_tc_jcr.tc_jcr22, g_tc_jcr.tc_jcr23,
                     g_tc_jcr.tc_jcr26, g_tc_jcr.tc_jcr27, g_tc_jcr.tc_jcr28, g_tc_jcr.tc_jcr29, g_tc_jcr.tc_jcr30, g_tc_jcr.tc_jcr31, 
                     g_tc_jcr.tc_jcr32, g_tc_jcr.tc_jcr33, g_tc_jcr.tc_jcr34, g_tc_jcr.tc_jcr35, g_tc_jcr.tc_jcr36, g_tc_jcr.tc_jcr37,
                     g_tc_jcr.tc_jcr38, g_tc_jcr.tc_jcr39, g_tc_jcr.tc_jcr40, g_tc_jcr.tc_jcr41, g_tc_jcr.tc_jcr42, g_tc_jcr.tc_jcr43,
                     g_tc_jcr.tc_jcruser, g_tc_jcr.tc_jcrgrup, g_tc_jcr.tc_jcroriu, g_tc_jcr.tc_jcrorig,
                     g_tc_jcr.tc_jcrcrat, g_tc_jcr.tc_jcrmodu, g_tc_jcr.tc_jcrdate, g_tc_jcr.tc_jcracti,
                     g_tc_jcr.tc_jcrconf
        #FUN-840042     ----END----

    LET l_oba02=NULL 
    SELECT oba02 INTO l_oba02 FROM oba_file WHERE oba01=g_tc_jcr.tc_jcr13
    DISPLAY l_oba02 TO FORMONLY.oba02

    LET l_imz02=NULL 
    SELECT imz02 INTO l_imz02 FROM imz_file WHERE imz01=g_tc_jcr.tc_jcr07
    DISPLAY l_imz02 TO FORMONLY.imz02

    LET g_chr1='N'
    LET g_chr2='N'
     
    IF g_tc_jcr.tc_jcracti = 'Y' THEN 
      LET g_chr1='Y'
    END IF 

    IF g_tc_jcr.tc_jcrconf = 'Y' THEN 
      LET g_chr2='Y'
    END IF 

    CALL cl_set_field_pic(""  ,g_chr2,""  ,""  ,""  ,g_chr1)
                          #確認 ,核准  ,過帳  ,結案 ,作廢 ,有效  ,申請 ,留置

    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION
 
FUNCTION i109_u()
   DEFINE l_cnt  LIKE type_file.num5
   
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_jcr.tc_jcr01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
    END IF

    SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01=g_tc_jcr.tc_jcr01
    
    #-->檢查資料是否為無效
    IF g_tc_jcr.tc_jcracti ='N' THEN
      CALL cl_err(g_tc_jcr.tc_jcr01,'mfg1000',0)
      RETURN
    END IF

    IF g_tc_jcr.tc_jcrconf ='Y' THEN
      CALL cl_err(g_tc_jcr.tc_jcr01,'aap-005',0)
      RETURN
    END IF

    IF g_tc_jcr.tc_jcr25 <> '3' THEN 
       LET l_cnt = 0
       SELECT max(tc_jcr09) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02 AND tc_jcr25 <> '3' AND tc_jcracti='Y'
       IF l_cnt >g_tc_jcr.tc_jcr09 THEN 
          CALL cl_err('','cbm-006',1)
          RETURN 
       END IF 
    END IF 
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_tc_jcr01_t = g_tc_jcr.tc_jcr01
    
    BEGIN WORK
 
    OPEN i109_cl USING g_tc_jcr.tc_jcr01
 
    IF STATUS THEN
       CALL cl_err("OPEN i109_cl:", STATUS, 1)
       CLOSE i109_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH i109_cl INTO g_tc_jcr.*               # 對DB鎖定
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0)
        RETURN
    END IF
    LET g_tc_jcr.tc_jcrmodu=g_user                     #修改者
    LET g_tc_jcr.tc_jcrdate = g_today                  #修改日期
    CALL i109_show()                          # 顯示最新資料
    WHILE TRUE
        LET g_tc_jcr_o.* = g_tc_jcr.*
        CALL i109_i("u")                      # 欄位更改
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_tc_jcr.*=g_tc_jcr_t.*
            CALL i109_show()
            CALL cl_err(g_tc_jcr.tc_jcr01,9001,0)
            EXIT WHILE
        END IF
        UPDATE tc_jcr_file SET tc_jcr_file.* = g_tc_jcr.*
         WHERE tc_jcr01 = g_tc_jcr01_t
        IF SQLCA.sqlcode THEN
     #      CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0) #No.TQC-660046
            CALL cl_err3("upd","tc_jcr_file",g_tc_jcr01_t,"",SQLCA.sqlcode,"","",1)      #No.TQC-660046
            CONTINUE WHILE
        END IF
        EXIT WHILE
    END WHILE
    CLOSE i109_cl
    COMMIT WORK
END FUNCTION
 
#No.TQC-740079 --begin
FUNCTION i109_x()
   DEFINE l_cnt LIKE type_file.num5
   
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_jcr.tc_jcr01 IS NULL THEN
        CALL cl_err("",-400,0)
        RETURN
    END IF

    SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01=g_tc_jcr.tc_jcr01

    IF g_tc_jcr.tc_jcrconf = 'Y' THEN 
       CALL cl_err('','aap-005',1)
       RETURN 
    END IF 
    
    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt FROM tc_jcr_file WHERE tc_jcr02=g_tc_jcr.tc_jcr02
    IF l_cnt >g_tc_jcr.tc_jcr09 THEN 
       CALL cl_err('','cbm-006',1)
       RETURN 
    END IF 
    
    BEGIN WORK
 
    OPEN i109_cl USING g_tc_jcr.tc_jcr01
    IF STATUS THEN
       CALL cl_err("OPEN i109_cl:", STATUS, 1)
       CLOSE i109_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH i109_cl INTO g_tc_jcr.*               # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0)          #資料被他人LOCK
        RETURN
    END IF
    CALL i109_show()
    IF cl_exp(0,0,g_tc_jcr.tc_jcracti) THEN
        LET g_chr=g_tc_jcr.tc_jcracti
        IF g_tc_jcr.tc_jcracti='Y' THEN
            LET g_tc_jcr.tc_jcracti='N'
        ELSE
            LET g_tc_jcr.tc_jcracti='Y'
        END IF
        UPDATE tc_jcr_file                    #更改有效碼
            SET tc_jcracti=g_tc_jcr.tc_jcracti,
                tc_jcrmodu = g_user,
                tc_jcrdate = g_today
            WHERE tc_jcr01=g_tc_jcr.tc_jcr01
        IF SQLCA.SQLERRD[3]=0 THEN
            CALL cl_err3("upd","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)  #No.TQC-660046
            LET g_tc_jcr.tc_jcracti=g_chr
        END IF
        DISPLAY BY NAME g_tc_jcr.tc_jcracti
    END IF
    CLOSE i109_cl
    COMMIT WORK
END FUNCTION
#No.TQC-740079 --END
 
FUNCTION i109_r()
    DEFINE l_chr LIKE type_file.chr1,         #No.FUN-680096 VARCHAR(1)
           l_cnt LIKE type_file.num5          #No.FUN-680096 SMALLINT
 
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_jcr.tc_jcr01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF

    IF g_tc_jcr.tc_jcracti = 'N' THEN
       CALL cl_err('','abm-950',0)
       RETURN
    END IF

    IF g_tc_jcr.tc_jcrconf = 'Y' THEN
       CALL cl_err('','alm-551',0)
       RETURN
    END IF

    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt FROM tc_jcr_file 
    WHERE tc_jcr02=g_tc_jcr.tc_jcr02 
    AND (
    tc_jcrcrat>g_tc_jcr.tc_jcrcrat OR 
    (tc_jcrcrat=g_tc_jcr.tc_jcrcrat AND tc_jcr01>g_tc_jcr.tc_jcr01)
    )
    IF l_cnt >0 THEN 
      CALL cl_err('','cbm-006',0)
      RETURN 
    END IF 

    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt FROM tc_jfs_file WHERE tc_jfs58=g_tc_jcr.tc_jcr01
    IF l_cnt > 0 THEN CALL cl_err(g_tc_jcr.tc_jcr01,'cbm-001',0) RETURN END IF 

    BEGIN WORK
 
    OPEN i109_cl USING g_tc_jcr.tc_jcr01
 
    IF STATUS THEN
       CALL cl_err("OPEN i109_cl:", STATUS, 1)
       CLOSE i109_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH i109_cl INTO g_tc_jcr.*
    IF SQLCA.sqlcode THEN CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0) RETURN END IF
    CALL i109_show()

    IF cl_delete() THEN
        INITIALIZE g_doc.* TO NULL           #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "tc_jcr01"          #No.FUN-9B0098 10/02/24
        LET g_doc.value1  = g_tc_jcr.tc_jcr01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                          #No.FUN-9B0098 10/02/24
        DELETE FROM tc_jcr_file WHERE tc_jcr01=g_tc_jcr.tc_jcr01
        IF SQLCA.SQLERRD[3]=0 THEN
      #    CALL cl_err(g_tc_jcr.tc_jcr01,SQLCA.sqlcode,0) #No.TQC-660046
           CALL cl_err3("del","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)  #No.TQC-660046
        ELSE
           CLEAR FORM
           INITIALIZE g_tc_jcr.* TO NULL
            OPEN i109_count
            #FUN-B50062-add-start--
            IF STATUS THEN
               CLOSE i109_cs
               CLOSE i109_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50062-add-END--
            FETCH i109_count INTO g_row_count
            #FUN-B50062-add-start--
            IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
               CLOSE i109_cs
               CLOSE i109_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50062-add-END--
            DISPLAY g_row_count TO FORMONLY.cnt
            OPEN i109_cs
            IF g_curs_index = g_row_count + 1 THEN
               LET g_jump = g_row_count
               CALL i109_fetch('L')
            ELSE
               LET g_jump = g_curs_index
               LET mi_no_ask = TRUE
               CALL i109_fetch('/')
            END IF
        END IF
    END IF
    CLOSE i109_cl
    COMMIT WORK
END FUNCTION
 
FUNCTION i109_copy()
    DEFINE
        l_n             LIKE type_file.num5,          #No.FUN-680096 SMALLINT
        l_tc_jcr		RECORD LIKE tc_jcr_file.*,
        l_tc_jcr01         LIKE tc_jcr_file.tc_jcr01,
        l_tc_jcr06         LIKE tc_jcr_file.tc_jcr06,  #By Hao201006
        l_cnt           LIKE type_file.num5,
        li_result       LIKE type_file.num5
 
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_jcr.tc_jcr01 IS NULL THEN
        CALL cl_err('',-400,0)
        RETURN
    END IF
    --LET g_before_input_done = FALSE
    --CALL i109_set_entry('a')
    --LET g_before_input_done = TRUE

    INPUT l_tc_jcr01 FROM tc_jcr01
    
         AFTER FIELD tc_jcr01
            CALL s_check_no("abm",l_tc_jcr01,"","6","tc_jcr_file","tc_jcr01","")
                   RETURNING li_result,l_tc_jcr01
            DISPLAY l_tc_jcr01 to tc_jcr01
            IF (NOT li_result) THEN
               NEXT FIELD tc_jcr01
            END IF
    
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT
 
         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121
 
         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121

         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121
         ON ACTION controlp     #查詢條件
            CASE
               WHEN INFIELD(tc_jcr01)
                 LET g_t1=s_get_doc_no(l_tc_jcr01)
                 CALL q_smy(FALSE,FALSE,g_t1,'ABM','6') RETURNING g_t1 #TQC-670008
                 LET l_tc_jcr01 = g_t1
                 DISPLAY BY NAME l_tc_jcr01
                 NEXT FIELD tc_jcr01
            END CASE
    END INPUT
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       DISPLAY BY NAME g_tc_jcr.tc_jcr01
       RETURN
    END IF

    BEGIN WORK 
    
    LET l_tc_jcr.* = g_tc_jcr.*

    CALL i109_auto_set_docno() RETURNING l_tc_jcr01
    --CALL s_auto_assign_no("abm",l_tc_jcr01,g_today,"6","tc_jcr_file","tc_jcr01","","","") RETURNING li_result,l_tc_jcr01
    --IF (NOT li_result) THEN
      --ROLLBACK WORK 
      --RETURN 
    --END IF
    DISPLAY l_tc_jcr01 TO tc_jcr01

    LET l_tc_jcr.tc_jcr01= l_tc_jcr01

    LET l_tc_jcr.tc_jcruser=g_user    #資料所有者
    LET l_tc_jcr.tc_jcrgrup=g_grup    #資料所有者所屬群
    LET l_tc_jcr.tc_jcrmodu=NULL      #資料修改日期
    LET l_tc_jcr.tc_jcrcrat=g_today   #資料建立日期
    LET l_tc_jcr.tc_jcrdate=NULL 
    LET l_tc_jcr.tc_jcracti='Y'       #有效資料
    LET l_tc_jcr.tc_jcrconf='N' 
    LET l_tc_jcr.tc_jcroriu = g_user      #No.FUN-980030 10/01/04
    LET l_tc_jcr.tc_jcrorig = g_grup      #No.FUN-980030 10/01/04
    LET l_tc_jcr.tc_jcr23  = NULL 
    LET l_tc_jcr.tc_jcr18  = NULL 
    LET l_tc_jcr.tc_jcr21  = NULL 

    # Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39
   IF (g_tc_jcr.tc_jcr25='2' OR g_tc_jcr.tc_jcr25='3')  THEN 
      SELECT COUNT(1)+1 INTO l_tc_jcr.tc_jcr38 
      FROM tc_jcr_file 
      WHERE tc_jcr02=g_tc_jcr.tc_jcr02 
      AND tc_jcr24=g_tc_jcr.tc_jcr24
      AND tc_jcr25 IN('2','3')
   END IF 
   DISPLAY BY NAME g_tc_jcr.tc_jcr38
   # Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39

    SELECT MAX(tc_jcr09)+1 INTO l_tc_jcr.tc_jcr09 FROM tc_jcr_file WHERE tc_jcr02=l_tc_jcr.tc_jcr02
    
    INSERT INTO tc_jcr_file VALUES(l_tc_jcr.*)
    IF SQLCA.sqlcode THEN
        CALL cl_err3("ins","tc_jcr_file",l_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)   #No.TQC-660046
        ROLLBACK WORK 
        RETURN
    ELSE
        MESSAGE 'ROW(',l_tc_jcr.tc_jcr01,') O.K'
        COMMIT WORK 
        SELECT tc_jcr_file.* INTO g_tc_jcr.* FROM tc_jcr_file
                       WHERE tc_jcr01 = l_tc_jcr.tc_jcr01
    END IF
    DISPLAY BY NAME g_tc_jcr.tc_jcr01
    CALL i109_u()
END FUNCTION                            
 
FUNCTION i109_set_entry(p_cmd)
DEFINE   p_cmd   LIKE type_file.chr1      #No.FUN-680096 VARCHAR(1)
 
   IF p_cmd = 'a' AND (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("tc_jcr01",TRUE)  
   END IF

END FUNCTION
 
FUNCTION i109_set_no_entry(p_cmd)
DEFINE   p_cmd   LIKE type_file.chr1      #No.FUN-680096 VARCHAR(1)
 
   --IF p_cmd = 'u' AND g_chkey matches'[Nn]' AND (NOT g_before_input_done) THEN
      --CALL cl_set_comp_entry("tc_jcr01",FALSE) 
   --END IF

   IF INFIELD(tc_jcr05) THEN
      IF g_tc_jcr.tc_jcr05 MATCHES 'MISC*' THEN
         CALL cl_set_comp_entry("tc_jcr06",TRUE)
      ELSE
         CALL cl_set_comp_entry("tc_jcr06",FALSE)
      END IF
   END IF
END FUNCTION

FUNCTION i109_auto_docno(p_tc_jcr07)
   DEFINE p_tc_jcr07    LIKE tc_jcr_file.tc_jcr07
   DEFINE l_yy       LIKE type_file.chr10
   DEFINE l_auto_docno LIKE type_file.chr50
   DEFINE l_no,l_no1,l_no2       LIKE type_file.chr10
   DEFINE l_no_t       LIKE type_file.num10

   LET l_yy = YEAR(g_today)

   LET l_no = 'E',p_tc_jcr07[1,1],l_yy[3,4]
   LET l_no1 = l_no,'%'

   SELECT nvl(MAX(substr(tc_jcr02,-6)),0)+1 INTO l_no_t
     FROM  tc_jcr_file
     WHERE tc_jcr02 LIKE l_no1

   LET l_no2 = l_no_t USING "&&&&&&"
   IF l_no2[6,6]=4 THEN 
      LET l_no_t = l_no_t+1
      LET l_no2 = l_no_t USING "&&&&&&"
   END IF 

   LET l_auto_docno = l_no,l_no2

   RETURN l_auto_docno
END FUNCTION

FUNCTION i109_b_menu()
   WHILE TRUE
      CALL i109_list()
      CALL i109_bp("G")
      IF NOT cl_null(g_action_choice) AND l_ac1>0 THEN #將清單的資料回傳到主畫面
         SELECT tc_jcr_file.*  INTO g_tc_jcr.*
           FROM tc_jcr_file
          WHERE tc_jcr01=g_tc_jcr_l[l_ac1].tc_jcr01_l
      END IF
      IF g_action_choice!= "" THEN
         
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
             CALL i109_fetch('/')
         END IF
         CALL cl_set_comp_visible("page_main", FALSE)
         CALL cl_set_comp_visible("info_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_main", TRUE)
         CALL cl_set_comp_visible("info_list", TRUE)
       END IF
       CASE g_action_choice

           WHEN "query" 
               IF cl_chk_act_auth() THEN
                  CALL i109_q()
               END IF
               EXIT WHILE
           WHEN "exporttoexcel"
              IF cl_chk_act_auth() THEN
                 CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_jcr_l),'','')
              END IF
           WHEN "about"
              CALL cl_about()
           WHEN "help"
              CALL cl_show_help()
           WHEN "exit"
              EXIT WHILE
           WHEN "controlg"
              CALL cl_cmdask()
           WHEN "related_document"
              IF cl_chk_act_auth() THEN
                  IF g_tc_jcr_l[l_ac1].tc_jcr01_l IS NOT NULL THEN
                     LET g_doc.column1 = "tc_jcr01"
                     LET g_doc.value1 = g_tc_jcr_l[l_ac1].tc_jcr01_l
                     CALL cl_doc()
                  END IF
              END IF
           OTHERWISE
              EXIT WHILE 
      END CASE
      
   END WHILE 
END FUNCTION

FUNCTION i109_bp(p_ud)
  DEFINE   p_ud      LIKE type_file.chr1          
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_jcr_l TO s_tc_jcr_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
 
      BEFORE ROW
         LET l_ac1 = ARR_CURR()
         CALL cl_show_fld_cont()
 
      ON ACTION page_main

         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
             CALL i109_fetch('/')
         END IF
         CALL cl_set_comp_visible("page_main", FALSE)
         CALL cl_set_comp_visible("info_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_main", TRUE)
         CALL cl_set_comp_visible("info_list", TRUE)
         EXIT DISPLAY
 
      ON ACTION accept
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE

         CALL i109_fetch('/')
         CALL cl_set_comp_visible("page_main", FALSE)
         CALL cl_set_comp_visible("page_main", TRUE)
         CALL cl_set_comp_visible("info_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("info_list", TRUE)
         EXIT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION controlg
         LET g_action_choice="controlg"  
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
 
      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about
         LET g_action_choice="about"
         EXIT DISPLAY

      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         EXIT DISPLAY

 
      ON ACTION related_document
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY
   
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

FUNCTION i109_list()
  DEFINE l_cnt          LIKE type_file.num10
  DEFINE l_tc_jcr01     LIKE tc_jcr_file.tc_jcr01
  
   CALL g_tc_jcr_l.clear()
   LET l_cnt = 1
   FOREACH i109_list_cs INTO l_tc_jcr01
      IF STATUS THEN
         CALL cl_err('foreach i109_list_cs',STATUS ,1)
         EXIT FOREACH
      END IF
      # Modify by li250911 添加tc_jcr42字段
      # Modify by li250926 资料清单添加tc_jcr27,tc_jcr30,tc_jcr38,tc_jcr39
      # Modify by li251110 添加 tc_jcr43 字段
      # Modify by dmw 20260407 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段
      SELECT tc_jcrcrat,tc_jcr01,tc_jcr02,tc_jcr42,tc_jcr08,tc_jcr09,tc_jcr05,tc_jcr06,tc_jcr44,tc_jcr45,tc_jcr46,tc_jcr47,tc_jcr03,
            tc_jcr10,tc_jcr11,tc_jcr40,tc_jcr07,tc_jcr13,oba02,tc_jcr14,tc_jcr15,tc_jcr16,
            tc_jcr17,tc_jcr12,tc_jcr18,tc_jcr19,tc_jcr20,tc_jcruser,gen02,tc_jcrgrup,gem02,tc_jcr21,tc_jcr22,tc_jcr23
            ,tc_jcr27,tc_jcr25,tc_jcr24,tc_jcr30,tc_jcr38,tc_jcr39,tc_jcr43
         INTO g_tc_jcr_l[l_cnt].*
       FROM tc_jcr_file
       LEFT JOIN oba_file ON oba01=tc_jcr13
       LEFT JOIN gen_file ON gen01=tc_jcruser 
       LEFT JOIN gem_file ON gem01=tc_jcrgrup
       WHERE tc_jcr01=l_tc_jcr01
      LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
          END IF
          EXIT FOREACH
       END IF
   END FOREACH
   LET g_rec_b1 = l_cnt - 1
   DISPLAY ARRAY g_tc_jcr_l TO s_tc_jcr_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
       BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION 

FUNCTION i109_y()

   IF (g_tc_jcr.tc_jcr01 IS NULL) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   MESSAGE ""
   
   SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01 = g_tc_jcr.tc_jcr01
   
   IF g_tc_jcr.tc_jcracti='N' THEN
      CALL cl_err('','alm1068',0)     #本笔资料无效，不可执行审核
      RETURN
   END IF

   IF g_tc_jcr.tc_jcrconf = 'Y' THEN 
      CALL cl_err('','atm-158',0)     #此笔资料已审核，不可再次审核
      RETURN 
   END IF 

   IF NOT cl_confirm('aap-222') THEN 
      RETURN 
   END IF

   LET g_success = 'Y'                               

   BEGIN WORK

   OPEN i109_cl USING g_tc_jcr.tc_jcr01
   IF STATUS THEN
       CALL cl_err("OPEN t004_cl:", STATUS, 1)
       CLOSE i109_cl
       ROLLBACK WORK
       RETURN
   END IF
   
   FETCH i109_cl INTO g_tc_jcr.*
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,1)
      CLOSE i109_cl
      ROLLBACK WORK
      RETURN
   END IF
   
   CALL i109_show()

   LET g_tc_jcr.tc_jcrconf = 'Y'

   UPDATE tc_jcr_file
      SET tc_jcrconf=g_tc_jcr.tc_jcrconf,
          tc_jcrdate=g_today
    WHERE tc_jcr01 = g_tc_jcr.tc_jcr01

   IF SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)                                                     
      LET g_success = 'N'    
   ELSE 
      LET g_success = 'Y'
   END IF

   CLOSE i109_cl

   IF g_success = 'N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF
   
   SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01=g_tc_jcr.tc_jcr01
   
   CALL i109_show()
END FUNCTION 

FUNCTION i109_z()
   DEFINE l_cnt   LIKE type_file.num5

   IF (g_tc_jcr.tc_jcr01 IS NULL) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   MESSAGE ""
   
   SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01 = g_tc_jcr.tc_jcr01

   IF g_tc_jcr.tc_jcrconf = 'N' OR g_tc_jcr.tc_jcracti = 'N'  THEN 
      CALL cl_err('','aec-027',0)     #此笔资料已审核，不可再次审核
      RETURN 
   END IF 

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM tc_jfs_file WHERE tc_jfs71=g_tc_jcr.tc_jcr01
   IF l_cnt >0 THEN 
      CALL cl_err('','cxm-025',1)
      RETURN 
   END IF 

   IF NOT cl_confirm('aap-224') THEN 
      RETURN 
   END IF

   LET g_success = 'Y'                               

   BEGIN WORK

   OPEN i109_cl USING g_tc_jcr.tc_jcr01
   IF STATUS THEN
       CALL cl_err("OPEN t004_cl:", STATUS, 1)
       CLOSE i109_cl
       ROLLBACK WORK
       RETURN
   END IF
   
   FETCH i109_cl INTO g_tc_jcr.*
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,1)
      CLOSE i109_cl
      ROLLBACK WORK
      RETURN
   END IF
   
   CALL i109_show()

   LET g_tc_jcr.tc_jcrconf = 'N'

   UPDATE tc_jcr_file
      SET tc_jcrconf=g_tc_jcr.tc_jcrconf
    WHERE tc_jcr01 = g_tc_jcr.tc_jcr01

   IF SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","tc_jcr_file",g_tc_jcr.tc_jcr01,"",SQLCA.sqlcode,"","",1)                                                     
      LET g_success = 'N'    
   ELSE 
      LET g_success = 'Y'
   END IF

   CLOSE i109_cl

   IF g_success = 'N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF
   
   SELECT * INTO g_tc_jcr.* FROM tc_jcr_file WHERE tc_jcr01=g_tc_jcr.tc_jcr01
   
   CALL i109_show()
END FUNCTION 

FUNCTION i109_auto_set_docno() #自动编号

  DEFINE l_no_t                     LIKE type_file.num5
  DEFINE l_docno                    LIKE type_file.chr50
  DEFINE auto_docno,l_no            STRING 

  DEFINE l_yy,l_mm,l_dd             STRING 
  DEFINE l_n                        LIKE type_file.num5
  DEFINE l_y,l_m,l_d                LIKE type_file.num5 #Add By Wang171107

  DEFINE l_auto_docno               STRING              #Add By Wang171107
    
   LET l_y = YEAR(g_today)
   LET l_m = MONTH(g_today)
   LET l_d = DAY(g_today)

   LET l_yy = l_y USING '&&&&'
   LET l_yy = l_yy.subString(3,4)
   LET l_mm = l_m USING '&&'
   LET l_dd = l_d USING '&&'

   # Modify by li240510 资料库为 jd 时,修改评估料号和报价编号的自动编号格式 b
   IF g_dbs='jd' THEN
      let l_auto_docno = 'JDQ',l_yy,l_mm,l_dd  
   ELSE
      LET l_auto_docno = 'Q',l_yy,l_mm,l_dd
   END IF 
# Modify by li240510 资料库为 jd 时,修改评估料号和报价编号的自动编号格式

   LET l_n = l_auto_docno.getLength()
   LET l_docno = l_auto_docno,'%'

   SELECT nvl(MAX(substr(tc_jcr01,-3)),0) + 1
       INTO l_no_t FROM tc_jcr_file 
       WHERE tc_jcr01 LIKE l_docno 
       AND length(tc_jcr01) = l_n + 3

   LET l_no = l_no_t USING '&&&'
   IF l_no.subString(3,3)=4 THEN 
      LET l_no_t = l_no_t+1
      LET l_no = l_no_t USING '&&&'
   END IF 
   LET l_auto_docno = l_auto_docno,l_no
    
   RETURN  l_auto_docno
   
END FUNCTION 

FUNCTION i109_auto_jcr02no() #自动编号

  DEFINE l_no_t          LIKE type_file.num10
  DEFINE l_docno         LIKE type_file.chr50
  DEFINE l_yy            STRING 
  DEFINE l_y                LIKE type_file.num5 
  DEFINE l_auto_tc_jcr02,l_no               STRING              
    
   LET l_y = YEAR(g_today)

   LET l_yy = l_y USING '&&&&'
   LET l_yy = l_yy.subString(3,4)

   let l_auto_tc_jcr02 = 'JDYP',l_yy
   LET l_docno = l_auto_tc_jcr02,'%'

   SELECT nvl(MAX(substr(tc_jcr02,-4)),0)+1 INTO l_no_t
     FROM  tc_jcr_file
     WHERE tc_jcr02 LIKE l_docno

   LET l_no = l_no_t USING "&&&&"
   IF l_no.subString(4,4)=4 THEN 
      LET l_no_t = l_no_t+1
      LET l_no = l_no_t USING "&&&&"
   END IF 
   LET l_auto_tc_jcr02 = l_auto_tc_jcr02,l_no

   RETURN  l_auto_tc_jcr02

END FUNCTION 

FUNCTION i109_out()
   DEFINE l_sql  STRING 
   DEFINE l_url       LIKE type_file.chr100
   {DEFINE l_table  STRING 
   DEFINE sr   RECORD 
            tc_jcr01    LIKE tc_jcr_file.tc_jcr01,
            tc_jcr02    LIKE tc_jcr_file.tc_jcr02,
            tc_jcr09    LIKE tc_jcr_file.tc_jcr09,
            tc_jcr03    LIKE tc_jcr_file.tc_jcr03,
            tc_jcr04    LIKE tc_jcr_file.tc_jcr04,
            tc_jcr05    LIKE tc_jcr_file.tc_jcr05,
            tc_jcr06    LIKE tc_jcr_file.tc_jcr06,
            tc_jcr07    LIKE tc_jcr_file.tc_jcr07,
            tc_jcr08    LIKE tc_jcr_file.tc_jcr08,
            tc_jcr12    LIKE tc_jcr_file.tc_jcr12,
            tc_jcr10    LIKE tc_jcr_file.tc_jcr10,
            tc_jcr11    LIKE tc_jcr_file.tc_jcr11,
            tc_jcr13    LIKE tc_jcr_file.tc_jcr13,
            tc_jcr14    LIKE tc_jcr_file.tc_jcr14,
            tc_jcr15    LIKE tc_jcr_file.tc_jcr15,
            tc_jcr16    LIKE tc_jcr_file.tc_jcr16,
            tc_jcr17    LIKE tc_jcr_file.tc_jcr17,
            tc_jcr18    LIKE tc_jcr_file.tc_jcr18,
            tc_jcr19    LIKE tc_jcr_file.tc_jcr19,
            tc_jcr20    LIKE tc_jcr_file.tc_jcr20,
            tc_jcr21    LIKE tc_jcr_file.tc_jcr21,
            tc_jcr22    LIKE tc_jcr_file.tc_jcr22,
            tc_jcruser    LIKE tc_jcr_file.tc_jcruser,
            tc_jcrgrup    LIKE tc_jcr_file.tc_jcrgrup
               END RECORD 

   IF g_tc_jcr.tc_jcr01 IS NULL THEN 
      CALL cl_err('',-400,1)
      RETURN 
   END IF 
   
   LET l_sql = "tc_jcr01.tc_jcr_file.tc_jcr01,",
               "tc_jcr02.tc_jcr_file.tc_jcr02,",
               "tc_jcr09.tc_jcr_file.tc_jcr09,",
               "tc_jcr03.tc_jcr_file.tc_jcr03,",
               "tc_jcr04.tc_jcr_file.tc_jcr04,",
               "tc_jcr05.tc_jcr_file.tc_jcr05,",
               "tc_jcr06.tc_jcr_file.tc_jcr06,",
               "tc_jcr07.tc_jcr_file.tc_jcr07,",
               "tc_jcr08.tc_jcr_file.tc_jcr08,",
               "tc_jcr12.tc_jcr_file.tc_jcr12,",
               "tc_jcr10.tc_jcr_file.tc_jcr10,",
               "tc_jcr11.tc_jcr_file.tc_jcr11,",
               "tc_jcr13.tc_jcr_file.tc_jcr13,",
               "tc_jcr14.tc_jcr_file.tc_jcr14,",
               "tc_jcr15.tc_jcr_file.tc_jcr15,",
               "tc_jcr16.tc_jcr_file.tc_jcr16,",
               "tc_jcr17.tc_jcr_file.tc_jcr17,",
               "tc_jcr18.tc_jcr_file.tc_jcr18,",
               "tc_jcr19.tc_jcr_file.tc_jcr19,",
               "tc_jcr20.tc_jcr_file.tc_jcr20,",
               "tc_jcr21.tc_jcr_file.tc_jcr21,",
               "tc_jcr22.tc_jcr_file.tc_jcr22,",
               "tc_jcruser.tc_jcr_file.tc_jcruser,",
               "tc_jcrgrup.tc_jcr_file.tc_jcrgrup"

   LET l_table = cl_prt_temptable('cbmi109',l_sql) CLIPPED
   IF l_table = -1 THEN EXIT PROGRAM END IF
   
   CALL cl_del_data(l_table)
   
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?)"
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN                                                                                                                   
      CALL cl_err('insert_prep',status,1) 
      CALL cl_used(g_prog,g_time,2) RETURNING g_time      #FUN-B30211
      EXIT PROGRAM                                                                              
   END IF
   LET g_sql="SELECT tc_jcr01,tc_jcr02,tc_jcr09,tc_jcr03,tc_jcr04,tc_jcr05,tc_jcr06,tc_jcr07,tc_jcr08,tc_jcr12,",
             " tc_jcr10,tc_jcr11,tc_jcr13,tc_jcr14,tc_jcr15,tc_jcr16,tc_jcr17,tc_jcr18,tc_jcr19,tc_jcr20,",
             " tc_jcr21,tc_jcr22,tc_jcruser,tc_jcrgrup",
             " FROM tc_jcr_file ",  
             " WHERE tc_jcr01='",g_tc_jcr.tc_jcr01,"'"
   PREPARE i109_o FROM g_sql                # RUNTIME 編譯
   IF STATUS THEN
      CALL cl_err('prepare:',STATUS,0)
      RETURN
   END IF
 
   DECLARE i109_o_cs CURSOR FOR i109_o
   FOREACH i109_o_cs INTO sr.*
      IF SQLCA.sqlcode THEN
         CALL cl_err('Foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
 
      EXECUTE insert_prep USING sr.*
   END FOREACH
 
   CLOSE i109_o_cs
   ERROR ""
   LET g_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED
   LET g_str = ''
   CALL cl_prt_cs3('cbmi109','cbmi109',g_sql,g_str)
   }


   IF g_tc_jcr.tc_jcr01 IS NULL THEN 
      CALL cl_err('',-400,1)
      RETURN 
   END IF                                                                                                                         
                                                                                                                                    
   CALL cl_wait()                                                                                                                   
   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang      
   LET l_url = FGL_GETENV('FGLASIP')
   LET l_sql = "select REGEXP_SUBSTR('",l_url,"','^http://(\\d+\.)+\\d+', 1)||':8080/qrcode/qrcode' from dual"
   PREPARE url_pre1 FROM l_sql
   EXECUTE url_pre1 INTO l_url   

# Modify by dmw 20260403 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段                                                                                                                                    
   LET l_sql="SELECT tc_jcr01,tc_jcr02,tc_jcr09,tc_jcr03,tc_jcr04,tc_jcr05,tc_jcr06,tc_jcr44,tc_jcr45,tc_jcr46,tc_jcr47,tc_jcr07,tc_jcr08,tc_jcr12,",
             " tc_jcr10,tc_jcr11,tc_jcr13,tc_jcr14,tc_jcr15,tc_jcr16,tc_jcr17,tc_jcr18,tc_jcr19,tc_jcr20,",
             " tc_jcr21,tc_jcr22,tc_jcr23,tc_jcruser,tc_jcrgrup",
             " FROM tc_jcr_file ",  
             " WHERE tc_jcr01='",g_tc_jcr.tc_jcr01,"'"
             
   LET g_str=l_url CLIPPED    
                                         
   CALL cl_prt_cs1('cbmi109','cbmi109',l_sql,g_str)                                                                                                                                                   

END FUNCTION 
# ADD by mo 231219 增加新报表
# Modify by li251110 添加 tc_jcr43 字段
FUNCTION i109_1_out()
   DEFINE l_sql  STRING 
   DEFINE l_url       LIKE type_file.chr100
   IF g_tc_jcr.tc_jcr01 IS NULL THEN 
      CALL cl_err('',-400,1)
      RETURN 
   END IF                                                                                                                         
                                                                                                                                    
   CALL cl_wait()                                                                                                                   
   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang                                                                      

   LET l_url = FGL_GETENV('FGLASIP')
   LET l_sql = "select REGEXP_SUBSTR('",l_url,"','^http://(\\d+\.)+\\d+', 1)||':8080/qrcode/qrcode' from dual"
   PREPARE url_pre FROM l_sql
   EXECUTE url_pre INTO l_url

# Modify by dmw 20260403 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段                                                                                                                 
   LET l_sql=" SELECT tc_jcr01 ,tc_jcr02 ,tc_jcr09,tc_jcr03 ,tc_jcr04 ,tc_jcr05 ,tc_jcr06 ,tc_jcr44 ,tc_jcr45 ,tc_jcr46 ,tc_jcr47 ,tc_jcr07 ,tc_jcr08 ,tc_jcr12 ,tc_jcr10 ,",
             " tc_jcr11 ,tc_jcr13 ,tc_jcr14 ,tc_jcr15 ,tc_jcr16 ,tc_jcr17 ,tc_jcr18, ",
             " tc_jcr19 ,tc_jcr20 ,tc_jcr21,tc_jcr22 ,tc_jcr23,gen02 as tc_jcruser ,tc_jcrgrup, ",
             " tc_jcr24 ,tc_jcr25 ,tc_jcr26 ,tc_jcr27,tc_jcr28 ,tc_jcr29,tc_jcr30,",
             " NVL(CONCAT(CONCAT(CONCAT(DECODE(tc_jcr31, 'Y', 'FAI/',''), DECODE(tc_jcr32, 'Y','AQO/', '') ), DECODE(tc_jcr33, 'Y', 'CPK/','') ) , DECODE(tc_jcr34, 'Y', 'PPAP/','')),'/')  as tc_jcr31  ,",
             "  tc_jcr32 , tc_jcr33 , tc_jcr34,  ",
             " NVL(CONCAT(CONCAT( DECODE(tc_jcr35, 'Y', '外观/',''), DECODE(tc_jcr36, 'Y', '尺寸/','') ),  DECODE(tc_jcr37, 'Y','性能/','') ),'/') as tc_jcr35, tc_jcr36 ,tc_jcr37 ,tc_jcr38,tc_jcr39,tc_jcr42, tc_jcr43",
             " FROM tc_jcr_file left join gen_file on gen01=tc_jcruser  ",
             " WHERE tc_jcr01='",g_tc_jcr.tc_jcr01,"'"
             
   LET g_str=l_url CLIPPED  
                                         
   CALL cl_prt_cs1('cbmi109','cbmi109_1',l_sql,g_str) 
  LET g_str=SQLERRMESSAGE                                                                                                                                 

END FUNCTION 
# ADD by mo 231219 增加新报表

FUNCTION i109_pconfirm()
   DEFINE l_tc_jcr01  LIKE tc_jcr_file.tc_jcr01

   LET g_sql ="SELECT tc_jcr01 FROM tc_jcr_file WHERE tc_jcracti='Y' AND tc_jcrconf='N' AND (tc_jcrdate=to_date(sysdate) OR tc_jcrcrat=to_date(sysdate))"
   PREPARE up_pre FROM g_sql
   DECLARE up_cs CURSOR FOR up_pre
   LET g_success ='Y'
   BEGIN WORK 
   FOREACH up_cs INTO l_tc_jcr01
      IF STATUS THEN 
         LET g_success='N'
         EXIT FOREACH 
      END IF 

      UPDATE tc_jcr_file SET tc_jcrconf='Y',tc_jcrdate = g_today
      WHERE tc_jcr01=l_tc_jcr01
      IF sqlca.sqlcode OR sqlca.sqlerrd[3]=0 THEN 
         LET g_success='N'
         EXIT FOREACH  
      END IF 
   END FOREACH 
   IF g_success ='Y' THEN 
      COMMIT WORK 
   ELSE 
      ROLLBACK WORK 
   END IF 
END FUNCTION 
 
 FUNCTION i109_jd_out()
   DEFINE l_sql  STRING 
   define l_gen02 like gen_file.gen02

   IF g_tc_jcr.tc_jcr01 IS NULL THEN 
      CALL cl_err('',-400,1)
      RETURN 
   END IF  

   IF g_tc_jcr.tc_jcrconf = 'N' THEN 
      CALL cl_err('','aap-717',1)
      RETURN 
   END IF 

# Modify by dmw 20260403 添加 tc_jcr44、tc_jcr45、tc_jcr46、tc_jcr47 字段
   CALL cl_wait()                                                                                                                   
    LET l_sql="
      SELECT tc_jcr01,tc_jcr02,tc_jcr03,tc_jcr04,tc_jcr05,tc_jcr06,tc_jcr44,tc_jcr45,tc_jcr46,tc_jcr47,tc_jcr07,tc_jcr11,tc_jcr22,tc_jcr23,tc_jcr24, tc_jcr26,tc_jcr27, tc_jcr29,tc_jcr30,
      tc_jcr38,tc_jcr40, NVL(CONCAT(CONCAT(CONCAT(DECODE(tc_jcr31, 'Y', 'FAI/',''), DECODE(tc_jcr32, 'Y','AQO/', '') ),
      DECODE(tc_jcr33, 'Y', 'CPK/','') ) , DECODE(tc_jcr34, 'Y', 'PPAP/','')),'/')  as tc_jcr31, NVL(CONCAT(CONCAT( DECODE(tc_jcr35, 'Y', '外观/',''),
      DECODE(tc_jcr36, 'Y', '尺寸/','') ), DECODE(tc_jcr37, 'Y','性能/','') ),'/') as tc_jcr35,imz02
      FROM tc_jcr_file 
      left join imz_file on imz01=tc_jcr07 AND imzacti = 'Y'
      WHERE tc_jcr01 = '",g_tc_jcr.tc_jcr01,"'"

      select gen02 into l_gen02 from gen_file where gen01= g_tc_jcr.tc_jcruser and genacti = 'Y'
      LET g_str=l_gen02
                                         
   CALL cl_prt_cs1('cbmi109','cbmi109_2',l_sql,g_str)  

END FUNCTION 

