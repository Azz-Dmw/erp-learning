# Prog. Version..: '5.30.15-14.10.14(00000)'     # 
# 
# Pattern name...: cxmt033.4gl 
# Descriptions...: JWS分润对账单
# Date & Author..: By mo240904

# MODIFY...... By MO241212 过滤cxmi032料号不存在的数据
# MODIFY...... By dmw20260429 增加客户代码(tc_jgd23)和汇率(tc_jgd24)字段
# MODIFY...... By dmw20260507 增加应付JWS(转换后)(tc_jgd25)和JF应收(转换后)(tc_jgd26)字段
# MODIFY...... By dmw20260515 增加客户代码(tc_jgd23)开窗查询以及输入后的处理逻辑

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE   g_tc_jgd     DYNAMIC ARRAY OF RECORD
                        tc_jgd01     LIKE tc_jgd_file.tc_jgd01,#出退货单号
                        tc_jgd02     LIKE tc_jgd_file.tc_jgd02,#出退货项次
                        tc_jgd03     LIKE tc_jgd_file.tc_jgd03,#出退货日期 
                        tc_jgd04     LIKE tc_jgd_file.tc_jgd04,#客户编号 
                        occ02        LIKE occ_file.occ02,  #客户简称
                        tc_jgd05     LIKE tc_jgd_file.tc_jgd05,#客户料号
                        tc_jgd18     LIKE  tc_jgd_file.tc_jgd18,#客户订单号
                        tc_jgd06     LIKE tc_jgd_file.tc_jgd06,#ERP料号 
                        tc_jgd17     LIKE tc_jgd_file.tc_jgd17,#币别
                        tc_jgd07     LIKE tc_jgd_file.tc_jgd07,#交货地(简称) 
                        tc_jgd08     LIKE tc_jgd_file.tc_jgd08,#出货数量
                        tc_jgd09     LIKE tc_jgd_file.tc_jgd09, #成本价(0%利润)
                        tc_jgd10     LIKE tc_jgd_file.tc_jgd10,#确认价(售价) 
                        tc_jgd11     LIKE tc_jgd_file.tc_jgd11,#JF分润率%  
                        tc_jgd12     LIKE tc_jgd_file.tc_jgd12,#JWS分润率%
                        tc_jgd13     LIKE tc_jgd_file.tc_jgd13,#出货营销额
                        tc_jgd14     LIKE tc_jgd_file.tc_jgd14,#应付JWS 
                        tc_jgd15     LIKE tc_jgd_file.tc_jgd15,#JF应收原币
                        tc_jgd16     LIKE tc_jgd_file.tc_jgd16,#JF应收HKD  
                        tc_jgd19     LIKE tc_jgd_file.tc_jgd19,#出货方式
                        tc_jgd20     LIKE tc_jgd_file.tc_jgd20,#分配方式
                        tc_jgd25     LIKE tc_jgd_file.tc_jgd25,#应付JWS(转换后)  add by dmw20260507
                        tc_jgd26     LIKE tc_jgd_file.tc_jgd26 #JF应收(转换后)   add by dmw20260507
                      END RECORD  

DEFINE g_wc,g_sql                STRING
DEFINE l_ac                      INT
DEFINE g_cnt,g_rec_b,g_rec_b1    LIKE type_file.num10
DEFINE tc_jgd21                 LIKE tc_jgd_file.tc_jgd21
DEFINE tc_jgd22                 LIKE tc_jgd_file.tc_jgd22
#DEFINE l_curr,l_curr1            LIKE type_file.num5
DEFINE l_plant                   LIKE type_file.chr10
DEFINE l_occ01                   LIKE occ_file.occ01
DEFINE l_occ02                   LIKE occ_file.occ02
DEFINE l_time LIKE type_file.chr8        #計算被使用時間    # VARCHAR(8) 
DEFINE tc_jgd23     LIKE tc_jgd_file.tc_jgd23#客户代码
DEFINE tc_jgd24     LIKE tc_jgd_file.tc_jgd24 #汇率
DEFINE l_rate LIKE tc_jgd_file.tc_jgd24 # add...... By dmw20260507 用于保存汇率(tc_jgd24)字段
DEFINE g_occ02  LIKE occ_file.occ02 # add...... By dmw20260515 用于保存客户编号对应的客户简称
DEFINE l_jgc12                   LIKE tc_jgc_file.tc_jgc12   # 公司
DEFINE l_jgc01                   LIKE tc_jgc_file.tc_jgc01   # 客户编号


MAIN
      OPTIONS #改變一些系統預設值 
      INPUT NO WRAP 
      DEFER INTERRUPT                       #擷取中斷鍵, 由程式處理 

      IF (NOT cl_user()) THEN 
         EXIT PROGRAM 
      END IF 

      WHENEVER ERROR CALL cl_err_msg_log 

      IF (NOT cl_setup("CXM")) THEN 
         EXIT PROGRAM 
      END IF 

      CALL cl_used(g_prog,l_time,1)         #計算使用時間 (進入時間) 
         RETURNING l_time

      OPEN WINDOW t033_w WITH FORM "cxm/42f/cxmt033" 
         ATTRIBUTE (STYLE = g_win_style CLIPPED)

      CALL cl_ui_init()
      CALL cl_set_comp_visible("l_plant,l_occ01,l_occ02,tc_jgd19",false)
      CALL t033_menu() 

      CLOSE WINDOW t033_w                   #結束畫面
      CALL cl_used(g_prog,l_time,2) RETURNING l_time

END MAIN

#QBE 查詢資料 
FUNCTION t033_cs()

# add...... By dmw20260429 增加客户代码(tc_jgd23)、汇率(tc_jgd24)字段、应付JWS(转换后)(tc_jgd25)和JF应收(转换后)(tc_jgd26)字段
  CONSTRUCT g_wc ON  tc_jgd21,tc_jgd22,tc_jgd01,tc_jgd02,tc_jgd03,tc_jgd04,tc_jgd05,tc_jgd18,tc_jgd06,tc_jgd17,tc_jgd07,tc_jgd08,tc_jgd09,tc_jgd10,
                    tc_jgd11,tc_jgd12,tc_jgd13,tc_jgd14,tc_jgd15,tc_jgd16,tc_jgd19,tc_jgd20,tc_jgd04,tc_jgd25,tc_jgd26
         FROM tc_jgd21,tc_jgd22,g_tc_jgd[1].tc_jgd01,g_tc_jgd[1].tc_jgd02,g_tc_jgd[1].tc_jgd03,g_tc_jgd[1].tc_jgd04,g_tc_jgd[1].tc_jgd05,g_tc_jgd[1].tc_jgd18,
              g_tc_jgd[1].tc_jgd06,g_tc_jgd[1].tc_jgd17,g_tc_jgd[1].tc_jgd07,g_tc_jgd[1].tc_jgd08,g_tc_jgd[1].tc_jgd09,g_tc_jgd[1].tc_jgd10,
              g_tc_jgd[1].tc_jgd11,g_tc_jgd[1].tc_jgd12,g_tc_jgd[1].tc_jgd13,g_tc_jgd[1].tc_jgd14,g_tc_jgd[1].tc_jgd15,g_tc_jgd[1].tc_jgd16,
              g_tc_jgd[1].tc_jgd19,g_tc_jgd[1].tc_jgd20,tc_jgd23,g_tc_jgd[1].tc_jgd25,g_tc_jgd[1].tc_jgd26
                              # 螢幕上取單頭條件
                    
         BEFORE CONSTRUCT 
            CALL cl_qbe_init() 


         ON ACTION CONTROLP 
            CASE
            WHEN INFIELD(tc_jgd01) #退货单号                                                                                                      
               CALL cl_init_qry_var() 
               LET g_qryparam.state = 'c'                                                                                                
               LET g_qryparam.form="q_oga101"  #add-by TQC-7C0074        
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO g_tc_jgd[1].tc_jgd01
               NEXT FIELD tc_jgd01

            WHEN INFIELD(tc_jgd06) #物料编号
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ima"
                  LET g_qryparam.state = 'c'                                                                                                
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO g_tc_jgd[1].tc_jgd06
                  NEXT FIELD tc_jgd06

            WHEN INFIELD(tc_jgd17) #币种
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_azi"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO g_tc_jgd[1].tc_jgd17
                  NEXT FIELD tc_jgd17

             WHEN INFIELD(tc_jgd04) 
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_occ02"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO g_tc_jgd[1].tc_jgd04
                  NEXT FIELD tc_jgd04

            #add by dmw20260515 增加客户代码(tc_jgd23)的开窗查询
               WHEN INFIELD(tc_jgd23)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "cq_occ"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret

                  LET tc_jgd23 = g_qryparam.multiret
                  DISPLAY BY NAME tc_jgd23

                  NEXT FIELD tc_jgd23

            END CASE

########  add by dmw20260515 增加客户代码(tc_jgd23)输入后的处理逻辑 start  #########
         AFTER FIELD tc_jgd23
         IF cl_null(tc_jgd23) THEN
            LET g_occ02 = ""
            DISPLAY g_occ02 TO occ02
            RETURN
         END IF

         SELECT occ02 INTO g_occ02 FROM occ_file WHERE occ01 = tc_jgd23

         IF SQLCA.SQLCODE != 0 THEN
            CALL cl_err("tc_jgd23","客户不存在",0)
            LET g_occ02 = ""
            DISPLAY g_occ02 TO occ02
            NEXT FIELD tc_jgd23
         END IF

         DISPLAY g_occ02 TO occ02
###########################            end        #############################

            ON ACTION qbe_select                           #查詢提供條件選擇，選擇後直接帶入畫面 
               CALL cl_qbe_select() 

            ON ACTION qbe_save 
               CALL cl_qbe_save()


         ON ACTION controlg
            CALL cl_cmdask()
            
         ON ACTION about
            CALL cl_about() 

         ON ACTION locale
            CALL cl_dynamic_locale() 
            CALL cl_show_fld_cont()

         ON IDLE g_idle_seconds 
            CALL cl_on_idle() 

         ON ACTION ACCEPT 
            EXIT CONSTRUCT
            
         ON ACTION CANCEL 
            LET INT_FLAG = TRUE 
            EXIT CONSTRUCT
      END CONSTRUCT


      IF INT_FLAG THEN 
         RETURN 
      END IF 


      LET g_wc = g_wc CLIPPED #,cl_get_extra_cond('tc_jgduser', 'tc_jgdgrup') 

      IF cl_null(g_wc) OR g_wc = "" THEN
         LET g_wc = "1=1"
      END IF

      DISPLAY  g_wc

      {IF NOT cl_null(tc_jgd24) THEN
         LET g_wc = g_wc, " AND tc_jgd24 = ", tc_jgd24
      END IF
      }
      # add...... By dmw20260511 增加汇率(tc_jgd24)字段、应付JWS(转换后)(tc_jgd25)和JF应收(转换后)(tc_jgd26)字段
      LET g_sql =  "SELECT  tc_jgd01,tc_jgd02,tc_jgd03,tc_jgd04,occ02,tc_jgd05,tc_jgd18,tc_jgd06,tc_jgd17,tc_jgd07,tc_jgd08,tc_jgd09,tc_jgd10,tc_jgd11,
                   tc_jgd12,tc_jgd13,tc_jgd14,tc_jgd15,tc_jgd16,tc_jgd19,tc_jgd20,tc_jgd25,tc_jgd26
                   FROM tc_jgd_file LEFT JOIN occ_file on occ01=tc_jgd04
                   WHERE  ", g_wc ," ORDER BY 1"

      DISPLAY g_sql

      DECLARE t033_bcs CURSOR FROM g_sql 

END FUNCTION 

FUNCTION t033_menu()

      WHILE TRUE 
      
         CALL t033_bp("G") 

         CASE g_action_choice 

            WHEN "query" 
               IF cl_chk_act_auth() THEN 
                  CALL t033_q() 
               END IF 
            WHEN "insert"
               IF cl_chk_act_auth() THEN
                  CALL t033_a()
               END IF
            WHEN "exit" 
               EXIT WHILE 

            WHEN "controlg" 
               CALL cl_cmdask() 

            WHEN "exporttoexcel" 
               IF cl_chk_act_auth() THEN 
                  CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_jgd),'','') 
               END IF 
         END CASE 
      END WHILE 

END FUNCTION 


#Query 查詢 
FUNCTION t033_q() 

      CALL cl_opmsg('q') 
      MESSAGE "" 
      CLEAR FORM 
      CALL g_tc_jgd.clear() 

      CALL t033_cs()                      #取得查詢條件 

      IF INT_FLAG THEN                    #使用者不玩了 
         LET INT_FLAG = 0 
         RETURN 
      END IF 
      
      CALL t033_b_fill() 

END FUNCTION 

FUNCTION t033_b_fill()

      CALL g_tc_jgd.clear() 
      OPEN t033_bcs
      LET g_cnt = 1 

      DISPLAY "单身填充之后汇率字段为：",l_rate

      FOREACH t033_bcs INTO g_tc_jgd[g_cnt].*           #單身 ARRAY 填充

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

      CALL g_tc_jgd.deleteElement(g_cnt)     #移除指定位置记录，并将指定位置后之数据往上移，动态数组（Dynamic Array）的笔数减1 
      LET g_rec_b = g_cnt - 1

      DISPLAY g_rec_b TO cnt

END FUNCTION 

FUNCTION t033_bp(p_ud) 

   DEFINE p_ud LIKE type_file.chr1 

      IF p_ud <> "G" THEN 
         RETURN 
      END IF 

      LET g_action_choice = " " 

      CALL cl_set_act_visible("accept,cancel", FALSE)

         DISPLAY ARRAY g_tc_jgd TO g_tc_jgd.* ATTRIBUTE(COUNT=g_rec_b)
 
         
         ON ACTION query 
            LET g_action_choice="query" 
            EXIT  DISPLAY 

          ON ACTION insert 
            LET g_action_choice="insert" 
            EXIT DISPLAY 

         ON ACTION ACCEPT          #使双击单身无响应 
            #LET g_action_choice = "schedule"
            #LET l_ac = 1
            #EXIT DIALOG

         ON ACTION CANCEL 
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT  DISPLAY 

         ON ACTION locale 
            CALL cl_dynamic_locale() 
            CALL cl_show_fld_cont() 

         ON ACTION EXIT 
            LET g_action_choice = "exit"
            EXIT DISPLAY 

         ON ACTION controlg 
            LET g_action_choice = "controlg"
            EXIT DISPLAY 

         ON IDLE g_idle_seconds 
            CALL cl_on_idle() 
            CONTINUE DISPLAY 

         ON ACTION about 
            CALL cl_about() 

         ON ACTION exporttoexcel 
            LET g_action_choice = 'exporttoexcel' 
            EXIT DISPLAY 


END DISPLAY
      CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

FUNCTION t033_a()

      CALL cl_opmsg('q') 
      MESSAGE "" 
      CLEAR FORM 

      CALL g_tc_jgd.clear() 
      CALL t033_i()
      IF INT_FLAG THEN                    #使用者不玩了 
         LET INT_FLAG = 0
         RETURN 
      END IF 
      
END FUNCTION

FUNCTION t033_i()

      DEFINE currs  LIKE azj_file.azj04
      DEFINE l_i    LIKE type_file.num5

      LET g_cnt = 1 
      
      # add...... By dmw20260429 增加客户代码(tc_jgd23)和汇率(tc_jgd24)字段
      INITIALIZE l_plant,l_occ01,tc_jgd21,tc_jgd22,l_occ02,tc_jgd23,tc_jgd24 TO NULL
      INPUT BY NAME tc_jgd21,tc_jgd22,tc_jgd23,tc_jgd24  WITHOUT DEFAULTS #l_plant,l_occ01,

########add by dmw20260515 增加客户代码(tc_jgd23)输入后的处理逻辑 start#########
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(tc_jgd23)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form = "cq_occ"
               CALL cl_create_qry() RETURNING g_qryparam.multiret

               LET tc_jgd23 = g_qryparam.multiret
               DISPLAY BY NAME tc_jgd23

               NEXT FIELD tc_jgd23
         END CASE

      AFTER FIELD tc_jgd23
         IF cl_null(tc_jgd23) THEN
            LET g_occ02 = ""
            DISPLAY g_occ02 TO occ02
            RETURN
         END IF

         SELECT occ02 INTO g_occ02 FROM occ_file WHERE occ01 = tc_jgd23

         IF SQLCA.SQLCODE != 0 THEN
            CALL cl_err("tc_jgd23","客户不存在",0)
            LET g_occ02 = ""
            DISPLAY g_occ02 TO occ02
            NEXT FIELD tc_jgd23
         END IF

         DISPLAY g_occ02 TO occ02
###########################            end            #############################

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION EXIT                        #加離開功能
         LET INT_FLAG = 1
         EXIT INPUT  
         RETURN

   #   ON ACTION CONTROLP
   # CASE 
   # WHEN INFIELD (l_occ01)
   #    CALL cl_init_qry_var()
   #    LET g_qryparam.form = "cq_occ01"
   #    LET g_qryparam.state = 'i'
   #    CALL cl_create_qry() RETURNING l_occ01,l_occ02
   #    DISPLAY BY NAME l_occ01,l_occ02
   #    NEXT FIELD l_occ01

    # WHEN INFIELD (l_plant)
    #    CALL cl_init_qry_var()
    #    LET g_qryparam.form = "q_zxy"
    #    LET g_qryparam.state = 'i'
    #    LET g_qryparam.arg1=g_user
    #    CALL cl_create_qry() RETURNING l_plant
    #   DISPLAY BY NAME l_plant
    #    NEXT FIELD l_plant
    # END CASE

    # AFTER FIELD l_occ01
    #    SELECT occ02 INTO l_occ02 FROM occ_file WHERE  occ01=l_occ01
    #    IF cl_null(l_occ02)  THEN
    #       CALL cl_err('','axm-456',0)
    #       NEXT FIELD l_occ01
    #    END IF
    #    DISPLAY BY NAME l_occ02 
    #    LET l_occ02=null
    #  AFTER FIELD l_plant
    #     LET l_plant = upshift(l_plant)  
    #     SELECT count(1) INTO l_i FROM zxy_file WHERE  zxy03=l_plant AND zxy01=g_user
    #     IF l_i<1 THEN 
    #        CALL cl_err('l_plant','axm-274',0)
    #        NEXT FIELD l_plant
    #     END IF
    #     DISPLAY BY NAME l_Plant

      LET l_rate = tc_jgd24 # add...... By dmw20260511 将输入的汇率值保存到l_rate变量中，后续使用
      DISPLAY "输入的汇率值为：",l_rate

      END INPUT



      BEGIN WORK


         -- FOR l_i=1  TO 6
         --    CASE 
         --       WHEN l_i=1 
         --          LET l_occ01='M2196'
         --          LET l_plant='JF'
         --       WHEN l_i=2
         --          LET l_occ01='M2193'
         --          LET l_plant='YC'
         --       WHEN l_i=3 
         --          LET l_occ01='NM3166'
         --          LET l_plant='JF'

         --       WHEN l_i=4
         --          LET l_occ01='NM2121'
         --          LET l_plant='JF'
         --       WHEN l_i=5
         --          LET l_occ01='NM2122'
         --          LET l_plant='JF'
         --       WHEN l_i=6
         --          LET l_occ01='NM2125'
         --          LET l_plant='JF'
         --    END CASE

         --DISPLAY "循环次数：",l_i


################### add by dmw 20260515 优化循环逻辑改为动态读取  start ######################### 
   DECLARE c_jgc CURSOR FOR
   SELECT DISTINCT tc_jgc01, tc_jgc12
     FROM tc_jgc_file         #从程式cxmi032的客户代码tc_jgc01字段和公司tc_jgc12字段读取
    WHERE tc_jgc12 IS NOT NULL
      AND (tc_jgc01 = tc_jgd23 OR tc_jgd23 IS NULL)   #限制只查当前输入客户

      OPEN c_jgc

      FOREACH c_jgc INTO l_jgc01, l_jgc12

         LET l_occ01 = l_jgc01
         LET l_plant = l_jgc12
         LET l_plant = upshift(l_plant)   #公司tc_jgc12字段转换成大写后赋值给l_plant变量

      DISPLAY "客户=", l_occ01, " 公司=", l_plant
################### add by dmw 20260515 优化循环逻辑改为动态读取  end ######################### 


         LET g_sql ="DELETE FROM tc_jgd_file WHERE  tc_jgd21=",tc_jgd21," AND  tc_jgd22=",tc_jgd22," AND tc_jgd04='",l_occ01,"'"

         # add...... By dmw202605011 拼接删除SQL的客户代码(tc_jgd23)条件
         IF NOT cl_null(tc_jgd23) THEN
            LET g_sql = g_sql," AND tc_jgd23='",tc_jgd23,"'"
         END IF

         DISPLAY "执行的删除SQL为:",g_sql
         PREPARE t033_des FROM g_sql
         EXECUTE t033_des
         
         LET g_sql = "SELECT tc_jcw03,tc_jcw04,tc_jcw06,tc_jcw22,tc_jcv06,tc_jcw10,tc_jcw07,tc_jcw08,tc_jcw13,oga044,tc_jcw17,tc_jcw14,tc_jcw18,'','','',
                      '','','',ogaud03,'',azj04,'','' from ",cl_get_target_table(l_plant,'tc_jcw_file')," LEFT JOIN ",cl_get_target_table(l_plant,'tc_jcv_file')," on tc_jcv01=tc_jcw01  
                       LEFT JOIN wf.azj_file on azj02=to_char(tc_jcw06,'YYYYMM') AND azj01=tc_jcw13 LEFT JOIN ",cl_get_target_table(l_plant,'oga_file'),"  on oga01=tc_jcw03
                       LEFT JOIN ",cl_get_target_table(l_plant,'ogb_file')," on ogb01=tc_jcw03 and ogb03=tc_jcw04 
                       LEFT JOIN ",cl_get_target_table(l_plant,'oeb_file'),"  on oeb01=ogb31 and oeb03=ogb32 
                       where tc_jcvconf='K' AND tc_jcv07=",tc_jgd21," AND  tc_jcv08=",tc_jgd22," 
                       AND tc_jcv05='",l_occ01,"' AND tc_jcw08!='MISC' AND ((oebud02!='6' and oebud02!='7') or oebud02 is null) AND tc_jcw17 !=0
                       AND  EXISTS (SELECT 1 FROM tc_jgc_file WHERE tc_jgc01=tc_jcv05 and tc_jgc02=tc_jcw08)" 

         # add...... By dmw202605011 拼接查询SQL的客户代码(tc_jgd23)条件
         IF NOT cl_null(tc_jgd23) THEN
            LET g_sql = g_sql," AND TC_JCW22='",tc_jgd23,"'"
         END IF

         DISPLAY "执行的查询SQL为:",g_sql 

         DECLARE t033_bcs1 CURSOR FROM g_sql 
         OPEN t033_bcs1
         FOREACH t033_bcs1 INTO g_tc_jgd[g_cnt].*,currs           #單身 ARRAY 填充

            IF SQLCA.sqlcode THEN 
               CALL cl_err('FOREACH:',SQLCA.sqlcode,1) 
               EXIT FOREACH 
            END IF 
            SELECT occ02 INTO g_tc_jgd[g_cnt].occ02 FROM occ_file WHERE  occ01=g_tc_jgd[g_cnt].tc_jgd04
            SELECT tc_jgc03,tc_jgc04,tc_jgc05,tc_jgc08 INTO g_tc_jgd[g_cnt].tc_jgd09,g_tc_jgd[g_cnt].tc_jgd11,g_tc_jgd[g_cnt].tc_jgd12,g_tc_jgd[g_cnt].tc_jgd20 FROM tc_jgc_file WHERE   g_tc_jgd[g_cnt].tc_jgd04=tc_jgc01 AND  tc_jgc02=g_tc_jgd[g_cnt].tc_jgd06 AND 
            g_tc_jgd[g_cnt].tc_jgd03>=tc_jgc06 AND g_tc_jgd[g_cnt].tc_jgd10=tc_jgc09  ORDER BY tc_jgc06 DESC

            LET g_tc_jgd[g_cnt].tc_jgd13=g_tc_jgd[g_cnt].tc_jgd08*g_tc_jgd[g_cnt].tc_jgd10

            IF g_tc_jgd[g_cnt].tc_jgd20='B' THEN
               LET g_tc_jgd[g_cnt].tc_jgd14=(g_tc_jgd[g_cnt].tc_jgd10- g_tc_jgd[g_cnt].tc_jgd09)*g_tc_jgd[g_cnt].tc_jgd08*g_tc_jgd[g_cnt].tc_jgd12/100
            ELSE 
               LET g_tc_jgd[g_cnt].tc_jgd14=g_tc_jgd[g_cnt].tc_jgd08*g_tc_jgd[g_cnt].tc_jgd12
            END IF 

            LET g_tc_jgd[g_cnt].tc_jgd15=g_tc_jgd[g_cnt].tc_jgd13-g_tc_jgd[g_cnt].tc_jgd14

            # add...... By dmw20260507 汇率转换逻辑
            IF NOT cl_null(tc_jgd24) AND tc_jgd24 <> 0 THEN
               # 应付JWS(转换后)
               LET g_tc_jgd[g_cnt].tc_jgd25 =
                  cl_digcut(g_tc_jgd[g_cnt].tc_jgd14 * tc_jgd24,4)
               # JF应收(转换后)
               LET g_tc_jgd[g_cnt].tc_jgd26 =
                  cl_digcut(g_tc_jgd[g_cnt].tc_jgd15 * tc_jgd24,4)
            ELSE
               LET g_tc_jgd[g_cnt].tc_jgd25 = 0
               LET g_tc_jgd[g_cnt].tc_jgd26 = 0
            END IF

            #CALL s_curr3(g_tc_jgd[g_cnt].tc_jgd17,g_tc_jgd[g_cnt].tc_jgd03,'S')RETURNING l_curr#币种，日期，买入/卖出 人民币转成《币种》的汇率
            #CALL s_curr3('HKD',g_tc_jgd[g_cnt].tc_jgd03,'S')RETURNING l_curr1#币种，日期，买入/卖出
            # LET g_tc_jgd[g_cnt].tc_jgd16=g_tc_jgd[g_cnt].tc_jgd15/l_curr*l_curr1
            LET g_tc_jgd[g_cnt].tc_jgd16=cl_digcut(g_tc_jgd[g_cnt].tc_jgd15*currs,4)

            DISPLAY "应付JWS(转换后)和JF应收(转换后)的值为：",g_tc_jgd[g_cnt].tc_jgd25,g_tc_jgd[g_cnt].tc_jgd26

            # add...... By dmw20260429 增加客户代码(tc_jgd23)、汇率(tc_jgd24)字段、应付JWS(转换后)(tc_jgd25)和JF应收(转换后)(tc_jgd26)字段
            INSERT INTO tc_jgd_file VALUES(g_tc_jgd[g_cnt].tc_jgd01,g_tc_jgd[g_cnt].tc_jgd02,g_tc_jgd[g_cnt].tc_jgd03,g_tc_jgd[g_cnt].tc_jgd04,g_tc_jgd[g_cnt].tc_jgd05,g_tc_jgd[g_cnt].tc_jgd06,
               g_tc_jgd[g_cnt].tc_jgd07,g_tc_jgd[g_cnt].tc_jgd08,g_tc_jgd[g_cnt].tc_jgd09,g_tc_jgd[g_cnt].tc_jgd10,g_tc_jgd[g_cnt].tc_jgd11,
               g_tc_jgd[g_cnt].tc_jgd12,g_tc_jgd[g_cnt].tc_jgd13,g_tc_jgd[g_cnt].tc_jgd14,g_tc_jgd[g_cnt].tc_jgd15,g_tc_jgd[g_cnt].tc_jgd16,
               g_tc_jgd[g_cnt].tc_jgd17, g_tc_jgd[g_cnt].tc_jgd18,g_tc_jgd[g_cnt].tc_jgd19, g_tc_jgd[g_cnt].tc_jgd20,tc_jgd21,tc_jgd22,
               tc_jgd23,tc_jgd24,g_tc_jgd[g_cnt].tc_jgd25,g_tc_jgd[g_cnt].tc_jgd26)

            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <= 0 THEN
               ROLLBACK WORK
               CALL cl_err3("ins","tc_jgd_file",g_tc_jgd[g_cnt].tc_jgd01,"",SQLCA.sqlcode,"","",0)   
               RETURN 
            END IF 

            LET g_cnt = g_cnt + 1

         -- END FOREACH
         -- END FOR

         END FOREACH   -- t033_bcs1
         END FOREACH   -- c_jgc
         CLOSE c_jgc    #add by dmw20260515 关闭客户公司游标

      COMMIT WORK
      CLOSE t033_bcs1
      CALL g_tc_jgd.deleteElement(g_cnt)     #移除指定位置记录，并将指定位置后之数据往上移，动态数组（Dynamic Array）的笔数减1 
      LET g_rec_b = g_cnt - 1
      DISPLAY g_rec_b TO cnt
END FUNCTION
