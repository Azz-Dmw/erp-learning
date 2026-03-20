# Prog. Version..: '5.30.15-14.10.14(00010)'     #
#
# Pattern name...: cfai012.4gl
# Descriptions...: 模具档案卡
# Date & Author..: By wang 180125



# Modify.........: By Teval 210910 单头添加两个字段：有弹簧否（tc_jbc19）、最近更新弹簧日（tc_jbc20）
# Modify.........: By Teval 211109 额外添加一个单身，用于展示需要寿命管制的重要零部件
# Modify.........: By Teval 211118 零部件采用下拉框选择
# Modify.........: By Teval 211123 零部件寿命自动带出
# Modify.........: By Teval 220303 添加功能按钮：更换弹簧
# Modify.........: By Teval 230113 添加一栏：tc_jbc22 适用零点定位
# Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
# Modify.........: By li240313 新增 tc_jbc24模具类型栏位
# Modify.........: By li240416 添加 tc_jbc25 字段
# Modify.........: By li240418 添加栏位: tc_jbc26 光纤感应
# Modify.........: By li250522 添加栏位: tc_jbc27建档类型
# Modify.........: By dmw 添加栏位: tc_jbc28做样员字段
# Modify.........: By dmw 添加栏位: tc_jbc29做样员姓名字段  20260320
# Modify.........: By dmw 增加根据做样员带出做样员姓名函数i012_tc_jbc28()  20260320

DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"

DEFINE g_detail STRING 

DEFINE g_tc_jbc     RECORD LIKE tc_jbc_file.*,       
       g_tc_jbc_t   RECORD LIKE tc_jbc_file.*,        
       g_tc_jbc01_t        LIKE tc_jbc_file.tc_jbc01,
       g_imz02             LIKE imz_file.imz02
       
DEFINE  g_cnt_ac    DYNAMIC ARRAY OF RECORD            
                ac         LIKE type_file.num10,       #主画面对应清单第几笔
                cnt        LIKE type_file.num10        #清单对应主画面第几笔
                    END RECORD
                
DEFINE  g_tc_jbd    DYNAMIC ARRAY OF RECORD
                tc_jbd02   LIKE tc_jbd_file.tc_jbd02,  #项次
                tc_jbd03   LIKE tc_jbd_file.tc_jbd03,  #适用客户tc_jbc08after input
                tc_jbd04   LIKE tc_jbd_file.tc_jbd04,  #产品编号
                tc_jbd05   LIKE tc_jbd_file.tc_jbd05,  #适用机种
                tc_jbd07   LIKE tc_jbd_file.tc_jbd07,  #状态
                tc_jbd06   LIKE tc_jbd_file.tc_jbd06   #备注
                    END RECORD
DEFINE  g_tc_jbd_t  RECORD
                tc_jbd02   LIKE tc_jbd_file.tc_jbd02,  #项次
                tc_jbd03   LIKE tc_jbd_file.tc_jbd03,  #适用客户
                tc_jbd04   LIKE tc_jbd_file.tc_jbd04,  #产品编号
                tc_jbd05   LIKE tc_jbd_file.tc_jbd05,  #适用机种
                tc_jbd07   LIKE tc_jbd_file.tc_jbd07,  #状态
                tc_jbd06   LIKE tc_jbd_file.tc_jbd06   #备注
                    END RECORD

TYPE tc_jcl RECORD 
         tc_jcl02 LIKE     tc_jcl_file.tc_jcl02,   #项次
         tc_jcl03 LIKE     tc_jcl_file.tc_jcl03,   #部件名称
         tc_jcl04 LIKE     tc_jcl_file.tc_jcl04,   #部件寿命
         tc_jcl08 LIKE     tc_jcl_file.tc_jcl08,   #部件数量
         tc_jcl05 LIKE     tc_jcl_file.tc_jcl05,   #累计生产
         tc_jcl06 LIKE     tc_jcl_file.tc_jcl06,   #最近更换
         tc_jcl07 LIKE     tc_jcl_file.tc_jcl07,   #更换后生产
         tc_jcl09 LIKE     tc_jcl_file.tc_jcl09    #更换后生产
            END RECORD 

DEFINE g_tc_jcl DYNAMIC ARRAY OF tc_jcl

DEFINE g_tc_jcl_t tc_jcl
                
DEFINE g_tc_jbc_l   DYNAMIC ARRAY OF RECORD
                tc_jbc01   LIKE tc_jbc_file.tc_jbc01, #
                tc_jbc21   LIKE tc_jbc_file.tc_jbc21, #
                tc_jbc02   LIKE tc_jbc_file.tc_jbc02, #
                tc_jbc03   LIKE tc_jbc_file.tc_jbc03, #
                tc_jbc04   LIKE tc_jbc_file.tc_jbc04, #
                imz02      LIKE imz_file.imz02,       #
                tc_jbc05   LIKE tc_jbc_file.tc_jbc05, #
                tc_jbc06   LIKE type_file.chr100,     #
                tc_jbc08   LIKE tc_jbc_file.tc_jbc08, #
                tc_jbc10   LIKE tc_jbc_file.tc_jbc10, #
                tc_jbc11   LIKE tc_jbc_file.tc_jbc11, #
                tc_jbc12   LIKE tc_jbc_file.tc_jbc12, #
                tc_jbc13   LIKE tc_jbc_file.tc_jbc13, #
                tc_jbc14   LIKE tc_jbc_file.tc_jbc14, #
                tc_jbc15   LIKE tc_jbc_file.tc_jbc15, #
                tc_jbc16   LIKE tc_jbc_file.tc_jbc16, #
                tc_jbc17   LIKE tc_jbc_file.tc_jbc17, #
                tc_jbc22   LIKE tc_jbc_file.tc_jbc22, #
                tc_jbc23   LIKE tc_jbc_file.tc_jbc23, # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
                tc_jbc18   LIKE tc_jbc_file.tc_jbc18, #
                tc_jbc24   LIKE tc_jbc_file.tc_jbc24, # Modify.........: By li240313 新增 tc_jbc24模具类型栏位
                tc_jbc25   LIKE tc_jbc_file.tc_jbc25, # 做样      # Modify.........: By li240416 添加 tc_jbc25 字段
                tc_jbc26   LIKE tc_jbc_file.tc_jbc26, # 光纤感应
                tc_jbc27   LIKE tc_jbc_file.tc_jbc27, # 建档类型  # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
                tc_jbc28   LIKE tc_jbc_file.tc_jbc28, # 做样员Modify.........: By dmw 添加栏位: tc_jbc28做样员
                tc_jbc29   LIKE tc_jbc_file.tc_jbc29, # 做样员Modify.........: By dmw 添加栏位: tc_jbc29做样员姓名
                #tc_jbc20   LIKE tc_jbc_file.tc_jbc20, #
                tc_jbd02   LIKE tc_jbd_file.tc_jbd02, #
                tc_jbd03   LIKE tc_jbd_file.tc_jbd03, #
                tc_jbd04   LIKE tc_jbd_file.tc_jbd04, #
                tc_jbd05   LIKE tc_jbd_file.tc_jbd05, #
                tc_jbd07   LIKE tc_jbd_file.tc_jbd07, #
                tc_jbd06   LIKE tc_jbd_file.tc_jbd06, #
                tc_jbcacti LIKE tc_jbc_file.tc_jbcacti,#
                tc_jbcconf LIKE tc_jbc_file.tc_jbcconf#
                     END RECORD 
                     
DEFINE  g_tc_jbg    DYNAMIC ARRAY OF RECORD
                tc_jbg01   LIKE tc_jbg_file.tc_jbg01,  #码别
                tc_jbg02   LIKE tc_jbg_file.tc_jbg02,  #名称
                tc_jbg03   LIKE tc_jbg_file.tc_jbg03,  #备注
                tc_jbguser LIKE tc_jbg_file.tc_jbguser,  #
                tc_jbggrup LIKE tc_jbg_file.tc_jbggrup,  #
                tc_jbgmodu LIKE tc_jbg_file.tc_jbgmodu,  #
                tc_jbgdate LIKE tc_jbg_file.tc_jbgdate   #
                    END RECORD
                
DEFINE  g_tc_jbg_t  RECORD
                tc_jbg01   LIKE tc_jbg_file.tc_jbg01,  #码别
                tc_jbg02   LIKE tc_jbg_file.tc_jbg02,  #名称
                tc_jbg03   LIKE tc_jbg_file.tc_jbg03,  #备注
                tc_jbguser LIKE tc_jbg_file.tc_jbguser,  #
                tc_jbggrup LIKE tc_jbg_file.tc_jbggrup,  #
                tc_jbgmodu LIKE tc_jbg_file.tc_jbgmodu,  #
                tc_jbgdate LIKE tc_jbg_file.tc_jbgdate   #
                    END RECORD
                  
DEFINE g_sql               STRING,                       #CURSOR暫存
       g_wc                STRING,                       #單頭CONSTRUCT結果
       g_wc1               STRING,                       #單頭CONSTRUCT結果
       g_wc2               STRING,                       #單身CONSTRUCT結果
       g_wc3               STRING,                       #單身CONSTRUCT結果
       g_rec_b             LIKE type_file.num5,          #單身筆數 
       l_ac                LIKE type_file.num5,          #目前處理的ARRAY CNT
       g_rec_b1            LIKE type_file.num5,          #资料清单笔数
       l_ac1               LIKE type_file.num5,          #目前處理的ARRAY CNT
       g_rec_b2            LIKE type_file.num5,          #资料清单笔数
       l_ac2               LIKE type_file.num5           #目前處理的ARRAY CNT
DEFINE g_action_flag       STRING                  #判断主画面与资料清单
DEFINE g_forupd_sql        STRING                  #SELECT ... FOR UPDATE  SQL
DEFINE g_before_input_done LIKE type_file.num5     
DEFINE g_chr               LIKE type_file.chr1     #切换无效时备份原有效码
DEFINE g_chr1              LIKE type_file.chr1     #显示无效图片的判断
DEFINE g_chr2              LIKE type_file.chr1     #显示审核图片的判断
DEFINE g_cnt               LIKE type_file.num10    #用于b_fill()
DEFINE g_msg               LIKE ze_file.ze03      
DEFINE g_curs_index        LIKE type_file.num10    #主画面第几笔
DEFINE g_row_count         LIKE type_file.num10    #總筆數 
DEFINE g_jump              LIKE type_file.num10    #查詢指定的筆數
DEFINE mi_no_ask           LIKE type_file.num5     #是否開啟指定筆視窗  

DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode

          
MAIN

#  IF FGL_GETENV("FGLGUI") <> "0" THEN      #若為整合EF自動簽核功能: 需抑制此段落 此處不適用
      OPTIONS                               #改變一些系統預設值
         INPUT NO WRAP
      DEFER INTERRUPT                       #擷取中斷鍵, 由程式處理
#  END IF
 
   IF (NOT cl_user()) THEN                  #預設部份參數(g_prog,g_user,...)
      EXIT PROGRAM                          #切換成使用者預設的營運中心
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log       #遇錯則記錄log檔
 
   IF (NOT cl_setup("CFA")) THEN            #抓取權限共用變數及模組變數(g_aza.*...)
      EXIT PROGRAM                          #判斷使用者執行程式權限
   END IF

   CALL cl_used(g_prog,g_time,1) RETURNING g_time     #計算使用時間 (進入時間)
 
   LET g_forupd_sql = "SELECT * FROM tc_jbc_file WHERE tc_jbc01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)     #轉換不同資料庫語法
   DECLARE i012_cl CURSOR FROM g_forupd_sql           #單頭Lock Cursor

   OPEN WINDOW i012_w WITH FORM "cfa/42f/cfai012"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)
         
   CALL cl_ui_init()                                  #轉換介面語言別、匯入ToolBar、Action...等資訊
   CALL cl_set_comp_required("tc_jbc01,tc_jbc03,tc_jbc22,tc_jbc18,tc_jbc19,tc_jbd02,tc_jbd03",TRUE)
   CALL cl_set_comp_entry("tc_jbc09,tc_jbc11,tc_jbc13,tc_jbc14,tc_jbc15,tc_jbc17,tc_jbc18,tc_jbc19,tc_jbc20,tc_jcl05,tc_jcl06,tc_jcl07",FALSE)
   CALL cl_set_comp_visible("tc_jbc19,tc_jbc20", FALSE)
   
   
   CALL i012_combobox('tc_jcl03','cfa-115','cfa-114')

   
   LET g_action_choice=""

   
   
   CALL i012_menu()                                   #進入主視窗選單
   
   CLOSE WINDOW i012_w                                #結束畫面
   CALL cl_used(g_prog,g_time,2) RETURNING g_time     #計算使用時間 (退出時間)
   
END MAIN
 
#QBE 查詢資料
FUNCTION i012_cs()

   DEFINE lc_qbe_sn   LIKE gbm_file.gbm01    
 
   CLEAR FORM 
   CALL g_tc_jbd.clear()
   CALL g_tc_jcl.clear()
   INITIALIZE g_tc_jbc.* TO NULL  

   DIALOG 
   # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数 
   # Modify.........: By li240416 添加 tc_jbc25 字段
   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
   # Modify.........: By dmw       添加栏位: tc_jbc28做样员、tc_jbc29做样员姓名
   CONSTRUCT BY NAME g_wc ON tc_jbc01,tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,
                              tc_jbc06,tc_jbc07,tc_jbc08,tc_jbc09,tc_jbc10,
                              tc_jbc11,tc_jbc12,tc_jbc13,tc_jbc14,tc_jbc15,
                              tc_jbc16,tc_jbc17,tc_jbc22,tc_jbc23,tc_jbc18, 
                              tc_jbc24,tc_jbc25, tc_jbc26,tc_jbc27,tc_jbc28, tc_jbc29, #By dmw 20260320                        
                              tc_jbc19,tc_jbc20, #Teval 210910
                              tc_jbcconf,
                              tc_jbcacti,tc_jbcuser,
                              tc_jbcgrup,tc_jbcmodu,tc_jbcdate
         BEFORE CONSTRUCT
            CALL cl_qbe_init()

      END CONSTRUCT 

      
            
      CONSTRUCT g_wc2 ON tc_jbd02,tc_jbd03,tc_jbd04,tc_jbd05,tc_jbd07,tc_jbd06
                    FROM s_tc_jbd[1].tc_jbd02,s_tc_jbd[1].tc_jbd03,
                         s_tc_jbd[1].tc_jbd04,s_tc_jbd[1].tc_jbd05,
                         s_tc_jbd[1].tc_jbd07,s_tc_jbd[1].tc_jbd06
                   
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)    #再次顯示查詢條件，因為進入單身後會將原顯示值清空

      END CONSTRUCT 

      
            
      CONSTRUCT BY NAME g_wc3 ON tc_jcl02,tc_jcl03,tc_jcl04,tc_jcl08,tc_jcl05,tc_jcl06,tc_jcl07,tc_jcl09
                   
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)    #再次顯示查詢條件，因為進入單身後會將原顯示值清空

      END CONSTRUCT 
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(tc_jbc01) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form = "cq_tc_jbc"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_jbc01
               NEXT FIELD tc_jbc01
               
            WHEN INFIELD(tc_jbc04) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.where = "imz01 like 'A%'"
               LET g_qryparam.form = "cq_imz"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_jbc04
               NEXT FIELD tc_jbc04
               
            WHEN INFIELD(tc_jbd03) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form = "cq_tc_jbc1"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_jbd03
               NEXT FIELD tc_jbd03
         END CASE
   
      ON IDLE g_idle_seconds                         #每個交談指令必備以下四個功能
         CALL cl_on_idle()                           #idle、about、help、controlg
         CONTINUE DIALOG 
   
      ON ACTION about       
         CALL cl_about()   
   
#      ON ACTION help         
#         CALL cl_show_help() 
   
      ON ACTION controlg    
         CALL cl_cmdask()
   
      ON ACTION qbe_select                           #查詢提供條件選擇，選擇後直接帶入畫面
         CALL cl_qbe_list() RETURNING lc_qbe_sn      #提供列表選擇
         CALL cl_qbe_display_condition(lc_qbe_sn)    #顯示條件
 
      ON ACTION qbe_save                   # 條件儲存
         CALL cl_qbe_save()

      ON ACTION ACCEPT 
         ACCEPT DIALOG 

      ON ACTION CANCEL 
         EXIT DIALOG 
 
   END DIALOG 
 
   IF INT_FLAG THEN
      RETURN
   END IF

   LET g_sql = "select distinct tc_jbc01 
               from tc_jbc_file
               left join tc_jbd_file on tc_jbc01 = tc_jbd01
               left join tc_jcl_file on tc_jbc01 = tc_jcl01",
               " where ", g_wc CLIPPED,
               " and ", g_wc2 CLIPPED,
               " and ", g_wc3 CLIPPED,
               " order by tc_jbc01"
 
   PREPARE i012_prepare FROM g_sql
   DECLARE i012_cs                            #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR i012_prepare
   DECLARE i012_fill_cs
       CURSOR FOR i012_prepare

   LET g_sql = "select count(distinct tc_jbc01)
               from tc_jbc_file
               left join tc_jbd_file on tc_jbc01 = tc_jbd01
               left join tc_jcl_file on tc_jbc01 = tc_jcl01",
               " where ", g_wc CLIPPED,
               " and ", g_wc2 CLIPPED,
               " and ", g_wc3 CLIPPED,
               " order by tc_jbc01"
 
   PREPARE i012_precount FROM g_sql
   DECLARE i012_count CURSOR FOR i012_precount
 
END FUNCTION
 
FUNCTION i012_menu()

   WHILE TRUE
   
    CASE 
      WHEN (g_action_flag IS NULL) OR (g_action_flag = "main")
        CALL i012_bp("G")
        
      WHEN g_action_flag = "info_list"
        CALL i012_list_fill()
        CALL i012_bp1("G")
      END CASE
      
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i012_a()
            END IF
 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i012_q()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i012_r()
            END IF
 
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i012_u('')
            END IF
 
         WHEN "invalid"
            IF cl_chk_act_auth() THEN
               CALL i012_x()
            END IF
 
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL i012_copy()
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               IF g_detail = "1" THEN 
                  CALL i012_b()
               ELSE 
                  CALL i012_b2('0')
               END IF 
            ELSE
               LET g_action_choice = NULL
            END IF

         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
            
         WHEN "exporttoexcel"                       #單身匯出最多可匯三個Table資料
            IF cl_chk_act_auth() THEN
               LET w = ui.Window.getCurrent()
               LET f = w.getForm()                                                                 
               CASE                                                                                     
                  WHEN (g_action_flag IS NULL) OR (g_action_flag = 'main')                            
                     LET page = f.FindNode("Page","page3")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_tc_jbd),'','')                                                               
                  WHEN g_action_flag = "info_list"                                                  
                     LET page = f.FindNode("Page","page4")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_tc_jbc_l),'','')
               END CASE
               LET g_action_choice = NULL
            END IF
 
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
              CALL i012_confirm()
            END IF    

         WHEN "unconfirm"
            IF cl_chk_act_auth() THEN
              CALL i012_unconfirm()
            END IF  

         WHEN "upd_state"  
            IF cl_chk_act_auth() THEN
              CALL i012_u("s")
            END IF       

         WHEN "replace_spring"  
            IF cl_chk_act_auth() THEN
              --CALL i012_u("r")
              CALL i012_b2("1")
            END IF       

         WHEN 'mould_position'
            IF cl_chk_act_auth() THEN
              CALL i012_mould_position()
            END IF

         WHEN "maintenance"
            IF cl_chk_act_auth() THEN
              CALL cl_cmdrun('cfai013 '||g_tc_jbc.tc_jbc01)
            END IF

         WHEN "repair"
            IF cl_chk_act_auth() THEN
              CALL cl_cmdrun('cfai014 '||g_tc_jbc.tc_jbc01)
            END IF

         WHEN "related_document"                    #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_tc_jbc.tc_jbc01 IS NOT NULL THEN
                   LET g_doc.column1 = "tc_jbc01"
                   LET g_doc.value1 = g_tc_jbc.tc_jbc01
                   CALL cl_doc()
                 ELSE 
                   CALL cl_err('',-400,0)
                 END IF
              END IF

      END CASE
   END WHILE
   CLOSE i012_cs
   CLOSE i012_count
END FUNCTION
 
FUNCTION i012_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1 
   
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
   
   LET g_action_choice = " "
   
   CALL cl_set_act_visible("accept,cancel", FALSE)

   DIALOG ATTRIBUTES(UNBUFFERED)
   
      DISPLAY ARRAY g_tc_jbd TO s_tc_jbd.* ATTRIBUTE(COUNT=g_rec_b)
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL cl_show_fld_cont()    
         
         ON ACTION accept
            LET g_action_choice="detail"
            LET l_ac = ARR_CURR()
            LET g_detail = "1"
            EXIT DIALOG
            
      END DISPLAY 
   
      DISPLAY ARRAY g_tc_jcl TO s_tc_jcl.* ATTRIBUTE(COUNT=g_rec_b2)
            
         BEFORE ROW
            LET l_ac2 = ARR_CURR()
            CALL cl_show_fld_cont()     
         
         ON ACTION accept
            LET g_action_choice="detail"
            LET l_ac2 = ARR_CURR()
            LET g_detail = "2"
            EXIT DIALOG
            
      END DISPLAY 

      BEFORE DIALOG 
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DIALOG
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG
 
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DIALOG
 
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DIALOG
 
      ON ACTION first
         CALL i012_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG  
 
      ON ACTION previous
         CALL i012_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   
 
      ON ACTION jump
         CALL cl_set_act_visible("accept", TRUE)  #跳笔显示确定按扭
         CALL i012_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         CALL cl_set_act_visible("accept", FALSE)
         ACCEPT DIALOG   
 
      ON ACTION next
         CALL i012_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   
 
      ON ACTION last
         CALL i012_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG  
 
      ON ACTION invalid
         LET g_action_choice="invalid"
         EXIT DIALOG
 
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DIALOG
 
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DIALOG

      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG
 
      ON ACTION locale                             #畫面上欄位的工具提示轉換語言別
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()       
         LET g_action_choice = 'locale'
         EXIT DIALOG
         
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG=FALSE                        #利用單身驅動menu時，cancel代表右上角的"X"
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
 
      ON ACTION about         
         CALL cl_about()    
 
      ON ACTION exporttoexcel                      #匯出Excel      
         LET g_action_choice = 'exporttoexcel'
         EXIT DIALOG

      ON ACTION confirm
         LET g_action_choice = 'confirm'
         EXIT DIALOG  

      ON ACTION unconfirm
         LET g_action_choice = 'unconfirm'
         EXIT DIALOG 
 
      ON ACTION upd_state                          #修改状态   
         LET g_action_choice = 'upd_state'
         EXIT DIALOG 
 
      ON ACTION replace_spring                     #更换弹簧   
         LET g_action_choice = 'replace_spring'
         EXIT DIALOG 
         --IF g_tc_jbc.tc_jbc19 = 'Y' THEN 
            --LET g_action_choice = 'replace_spring'
            --EXIT DIALOG 
         --ELSE 
            --IF cl_null(g_tc_jbc.tc_jbc01) THEN 
               --CALL cl_err('',-400,0)
            --ELSE 
               --CALL i012_msg('提示','该模具无弹簧，不需要更换弹簧','')
            --END IF 
         --END IF 

      ON ACTION mould_position
         LET g_action_choice = 'mould_position'
         EXIT DIALOG
         
#     ON ACTION controls                          #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭區塊
#        CALL cl_set_head_visible("Page01,Page02","AUTO")

      ON ACTION info_list
         LET g_action_flag = "info_list"
         EXIT DIALOG
         
      ON ACTION maintenance
         LET g_action_choice="maintenance"
         EXIT DIALOG

      ON ACTION repair
         LET g_action_choice="repair"
         EXIT DIALOG

      ON ACTION related_document                   #相關文件
         LET g_action_choice="related_document"          
         EXIT DIALOG

   END DIALOG 
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION i012_bp1(p_ud)

   DEFINE   p_ud   LIKE type_file.chr1 
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DISPLAY ARRAY g_tc_jbc_l TO s_tc_jbc_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
 
      BEFORE DISPLAY
         IF g_rec_b1 > 0 AND g_curs_index > 0 THEN 
           CALL fgl_set_arr_curr(g_cnt_ac[g_curs_index].ac)
         END IF 

      BEFORE ROW
         LET l_ac1 = ARR_CURR()

  #    ON ACTION help
  #       LET g_action_choice="help"
  #       EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #畫面上欄位的工具提示轉換語言別 
         LET g_action_choice = 'locale'
         EXIT DISPLAY 
         
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
         
      ON ACTION main
         LET g_action_flag = 'main'
         IF g_rec_b1 > 0 THEN 
           LET g_jump = g_cnt_ac[l_ac1].cnt
           LET mi_no_ask = TRUE
           CALL i012_fetch('/')
         END IF 
         EXIT DISPLAY
         
      ON ACTION ACCEPT
         LET g_action_flag = 'main'
         IF g_rec_b1 > 0 THEN 
           LET g_jump = g_cnt_ac[l_ac1].cnt
           LET mi_no_ask = TRUE
           CALL i012_fetch('/')
         END IF 
         EXIT DISPLAY
  
      ON ACTION cancel
         LET INT_FLAG=FALSE                        #利用單身驅動menu時，cancel代表右上角的"X"
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         
         CALL cl_about()    
 
      ON ACTION exporttoexcel                      #匯出Excel      
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
         
    #  ON ACTION controls                                  # 單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭區塊
    #     CALL cl_set_head_visible("Page01,Page02","AUTO") # 资料清单无单头，不需此功能
    
    #  ON ACTION related_document                          #相關文件
    #     LET g_action_choice="related_document"          
    #     EXIT DISPLAY
                                                   
       AFTER DISPLAY
         CONTINUE DISPLAY
         
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
FUNCTION i012_bp_refresh()

  DISPLAY ARRAY g_tc_jbd TO s_tc_jbd.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
    BEFORE DISPLAY
    
     EXIT DISPLAY
     
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE DISPLAY
        
  END DISPLAY
 
END FUNCTION 

FUNCTION i012_a()

   MESSAGE ""
   CLEAR FORM
   CALL g_tc_jbd.clear()
   LET  g_wc = NULL 
   LET  g_wc2= NULL 
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   INITIALIZE g_tc_jbc.* LIKE tc_jbc_file.*    #DEFAULT 設定
   LET g_tc_jbc01_t = NULL
   LET g_tc_jbc_t.* = g_tc_jbc.*
   CALL cl_opmsg('a')
 
   WHILE TRUE

      LET g_tc_jbc.tc_jbc23 = 1 
      LET g_tc_jbc.tc_jbc14=g_today
      LET g_tc_jbc.tc_jbc18='0'
      LET g_tc_jbc.tc_jbc19 = 'N'
      LET g_tc_jbc.tc_jbc22 = 'N'
      LET g_tc_jbc.tc_jbcuser=g_user
      LET g_tc_jbc.tc_jbcgrup=g_grup
      LET g_tc_jbc.tc_jbcoriu=g_user
      LET g_tc_jbc.tc_jbcorig=g_grup
      LET g_tc_jbc.tc_jbcdate=g_today
      LET g_tc_jbc.tc_jbcacti='Y'              #資料有效
      LET g_tc_jbc.tc_jbcconf='N'              #資料有效
      CALL i012_i("a")                         #輸入單頭
 
      IF INT_FLAG THEN                         #使用者不玩了
         INITIALIZE g_tc_jbc.* TO NULL
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF

      IF cl_null(g_tc_jbc.tc_jbc01) THEN       # KEY 不可空白
         CONTINUE WHILE
      END IF
 
      BEGIN WORK

      DISPLAY BY NAME g_tc_jbc.tc_jbc01
      
      INSERT INTO tc_jbc_file VALUES (g_tc_jbc.*)
 
      IF SQLCA.sqlcode THEN                             #置入資料庫不成功
         CALL cl_err3("ins","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1) 
         ROLLBACK WORK     
         CONTINUE WHILE
      ELSE
         COMMIT WORK  
         MESSAGE 'Insert O.K.'                          #新增成功後，設定流程通知
      END IF                                            #此功能適用單據程式
 
      SELECT tc_jbc01 INTO g_tc_jbc.tc_jbc01 FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01

      LET g_tc_jbc01_t = g_tc_jbc.tc_jbc01              #保留舊值
      LET g_tc_jbc_t.* = g_tc_jbc.*
      CALL g_tc_jbd.clear()
 
      LET g_rec_b = 0  
      CALL i012_b()                                     #輸入單身
      CALL i012_b2('0')                                     #輸入單身
      EXIT WHILE
      
   END WHILE
   
END FUNCTION
 
FUNCTION i012_u(p_cmd2)
 DEFINE p_cmd2     LIKE type_file.chr1
 DEFINE l_tc_jbc18 LIKE tc_jbc_file.tc_jbc18
 
        
   IF s_shut(0) THEN
      RETURN
   END IF

   IF cl_null(p_cmd2) THEN 
     LET p_cmd2 = "u"
   ELSE 
     IF p_cmd2 <> 'c' THEN 
       MESSAGE ""
     END IF 
   END IF
   
   IF g_tc_jbc.tc_jbc01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   IF g_tc_jbc.tc_jbcconf != 'N' THEN
      CALL cl_err('','0001',0)
      RETURN
   END IF
 
   SELECT tc_jbcacti,tc_jbcconf INTO g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcconf FROM tc_jbc_file WHERE tc_jbc01=g_tc_jbc.tc_jbc01
   
   IF g_tc_jbc.tc_jbcacti ='N' THEN                  #檢查資料是否為無效
      CALL cl_err('','mfg1000',0)
      RETURN
   END IF
    
   IF p_cmd2 <> 's' AND p_cmd2 <> 'r' THEN 
     IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
       CALL cl_err('','aap-005',0)                    #此笔资料已审核，不可更改
       RETURN 
     END IF 
   ELSE 
     LET l_tc_jbc18 = g_tc_jbc.tc_jbc18
   END IF
   
   CALL cl_opmsg('u')
   LET g_tc_jbc01_t = g_tc_jbc.tc_jbc01
   
   BEGIN WORK
 
   OPEN i012_cl USING g_tc_jbc.tc_jbc01
   IF STATUS THEN
      CALL cl_err("OPEN i012_cl:", STATUS, 1)
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH i012_cl INTO g_tc_jbc.*                      # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0) # 資料被他人LOCK
       CLOSE i012_cl
       ROLLBACK WORK
       RETURN
   END IF
 
   CALL i012_show()
 
   WHILE TRUE
      LET g_tc_jbc01_t = g_tc_jbc.tc_jbc01
 
      CALL i012_i(p_cmd2)                      #欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_tc_jbc.*=g_tc_jbc_t.*
         CALL i012_show()
         CALL cl_err('','9001',0)
         ROLLBACK WORK 
         EXIT WHILE
      END IF
      
      IF p_cmd2 = 's' THEN 
        IF l_tc_jbc18 = g_tc_jbc.tc_jbc18 THEN 
        ELSE 
          LET g_tc_jbc.tc_jbc14 = g_today
        END IF 
      END IF 

        IF cl_null(g_tc_jbc.tc_jbc23) THEN 
            LET g_tc_jbc.tc_jbc23 = 1
        END IF                                                  
        LET g_tc_jbc.tc_jbcmodu = g_user
        LET g_tc_jbc.tc_jbcdate = g_today  
        
        UPDATE tc_jbc_file SET tc_jbc02 = g_tc_jbc.tc_jbc02,
                               tc_jbc03 = g_tc_jbc.tc_jbc03,
                               tc_jbc04 = g_tc_jbc.tc_jbc04,
                               tc_jbc05 = g_tc_jbc.tc_jbc05,
                               tc_jbc06 = g_tc_jbc.tc_jbc06,
                               tc_jbc07 = g_tc_jbc.tc_jbc07,
                               tc_jbc08 = g_tc_jbc.tc_jbc08,
                               tc_jbc09 = g_tc_jbc.tc_jbc09,
                               tc_jbc10 = g_tc_jbc.tc_jbc10,
                               tc_jbc11 = g_tc_jbc.tc_jbc11,
                               tc_jbc12 = g_tc_jbc.tc_jbc12,
                               tc_jbc13 = g_tc_jbc.tc_jbc13,
                               tc_jbc14 = g_tc_jbc.tc_jbc14,
                               tc_jbc15 = g_tc_jbc.tc_jbc15,
                               tc_jbc16 = g_tc_jbc.tc_jbc16,
                               tc_jbc17 = g_tc_jbc.tc_jbc17,
                               tc_jbc22 = g_tc_jbc.tc_jbc22,
                               tc_jbc23 = g_tc_jbc.tc_jbc23,   # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
                               tc_jbc18 = g_tc_jbc.tc_jbc18,
                               tc_jbc24 = g_tc_jbc.tc_jbc24,   #li240313
                               tc_jbc25 = g_tc_jbc.tc_jbc25,   # Modify.........: By li240416 添加 tc_jbc25 字段
                               tc_jbc26 = g_tc_jbc.tc_jbc26,   
                               tc_jbc27 = g_tc_jbc.tc_jbc27,   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
                               tc_jbc28 = g_tc_jbc.tc_jbc28,   # Modify.........: By dmw 添加栏位: tc_jbc28做样员字段
                               tc_jbc29 = g_tc_jbc.tc_jbc29,   # Modify.........: By dmw 添加栏位: tc_jbc29做样员姓名字段
                               tc_jbc19 = g_tc_jbc.tc_jbc19,   #Teval 210910
                               tc_jbc20 = g_tc_jbc.tc_jbc20,   #Teval 210910
                               tc_jbc21 = g_tc_jbc.tc_jbc21,   #Teval 211118
                               tc_jbcmodu = g_tc_jbc.tc_jbcmodu,
                               tc_jbcdate = g_tc_jbc.tc_jbcdate
                         WHERE tc_jbc01 = g_tc_jbc01_t        
           
        IF SQLCA.sqlcode THEN
           CALL cl_err3("upd","tc_jbc_file","","",SQLCA.sqlcode,"","",1) 
           CONTINUE WHILE
        ELSE  
           MESSAGE 'Update O.K.'
           LET g_success = 'Y'   
           IF cl_null(p_cmd2) THEN 
           END IF   
        END IF 
        
   EXIT WHILE
   END WHILE
   
   CLOSE i012_cl
   COMMIT WORK
   
   SELECT * INTO g_tc_jbc.* FROM tc_jbc_file
    WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
    
   CALL i012_show()
   
END FUNCTION
 
FUNCTION i012_i(p_cmd)

   DEFINE p_cmd       LIKE type_file.chr1     #a:輸入 u:更改  
   DEFINE l_n         LIKE type_file.num10
   DEFINE l_old_tc_jbc08 LIKE tc_jbc_file.tc_jbc08 #定义一个变量保存原模具师
   
   IF s_shut(0) THEN
      RETURN
   END IF
   
    
   DISPLAY BY NAME g_tc_jbc.tc_jbc23,g_tc_jbc.tc_jbcconf,g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcuser,g_tc_jbc.tc_jbcdate,g_tc_jbc.tc_jbcgrup,g_tc_jbc.tc_jbcmodu
   # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数 li240313 
   # Modify.........: By li240416 添加 tc_jbc25 字段
   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
   INPUT BY NAME g_tc_jbc.tc_jbc01,g_tc_jbc.tc_jbc21,g_tc_jbc.tc_jbc02,g_tc_jbc.tc_jbc03,g_tc_jbc.tc_jbc04,
                 g_tc_jbc.tc_jbc05,g_tc_jbc.tc_jbc06,g_tc_jbc.tc_jbc07,g_tc_jbc.tc_jbc08,
                 g_tc_jbc.tc_jbc09,g_tc_jbc.tc_jbc10,g_tc_jbc.tc_jbc11,g_tc_jbc.tc_jbc12,
                 g_tc_jbc.tc_jbc13,g_tc_jbc.tc_jbc14,g_tc_jbc.tc_jbc15,g_tc_jbc.tc_jbc16,
                 g_tc_jbc.tc_jbc17,g_tc_jbc.tc_jbc22,g_tc_jbc.tc_jbc23,g_tc_jbc.tc_jbc18,   
                 g_tc_jbc.tc_jbc24,g_tc_jbc.tc_jbc25,g_tc_jbc.tc_jbc26,g_tc_jbc.tc_jbc27,g_tc_jbc.tc_jbc28,g_tc_jbc.tc_jbc29,g_tc_jbc.tc_jbc19,g_tc_jbc.tc_jbc20  
                 #Teval 210910新增做样员和做样员姓名字段g_tc_jbc.tc_jbc28，g_tc_jbc.tc_jbc29
       WITHOUT DEFAULTS
 
      BEFORE INPUT
         LET l_old_tc_jbc08 = g_tc_jbc.tc_jbc08      #保存模具师原值
         LET g_before_input_done = FALSE
         CALL i012_set_entry(p_cmd)
         LET g_before_input_done = TRUE 
         CASE p_cmd 
           WHEN 'u'
             NEXT FIELD tc_jbc21
           WHEN 's'
             NEXT FIELD tc_jbc18
           WHEN 'r'
             NEXT FIELD tc_jbc20
         END CASE 

       AFTER FIELD tc_jbc01
         IF NOT cl_null(g_tc_jbc.tc_jbc01) THEN 
           SELECT COUNT(g_tc_jbc.tc_jbc01) INTO l_n
            FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
           IF l_n > 0 THEN 
             CALL cl_err(g_tc_jbc.tc_jbc01,-239,0)
             NEXT FIELD tc_jbc01
           END IF 
         END IF 

       AFTER FIELD tc_jbc04
         IF NOT cl_null(g_tc_jbc.tc_jbc04) THEN 
           CALL i012_tc_jbc04()
           IF NOT cl_null(g_errno) THEN 
             CALL cl_err('',g_errno,0)
             NEXT FIELD tc_jbc04
           END IF 
         END IF  

      {
       AFTER FIELD tc_jbc08
         IF NOT cl_null(g_tc_jbc.tc_jbc08) THEN 
           CALL i012_tc_jbc08()
           IF NOT cl_null(g_errno) THEN 
             CALL cl_err('',g_errno,0)
             NEXT FIELD tc_jbc08
           END IF 
         ELSE 
           CLEAR tc_jbc09
           INITIALIZE g_tc_jbc.tc_jbc09 TO NULL 
         END IF 
         }

      # Modify.........: By dmw 模具师字段tc_jbc08检查
      AFTER FIELD tc_jbc08
      # 修改时如果没有改模具师，则不检查
      IF NOT (p_cmd='u' AND g_tc_jbc.tc_jbc08 = l_old_tc_jbc08) THEN

         IF NOT cl_null(g_tc_jbc.tc_jbc08) THEN 
            CALL i012_tc_jbc08()
            IF NOT cl_null(g_errno) THEN 
               CALL cl_err('',g_errno,0)
               NEXT FIELD tc_jbc08
            END IF 
         ELSE 
            CLEAR tc_jbc09
            INITIALIZE g_tc_jbc.tc_jbc09 TO NULL 
         END IF
      END IF

      # Modify.........: By dmw 根据做样员带出做样员姓名
      AFTER FIELD tc_jbc28
         IF NOT cl_null(g_tc_jbc.tc_jbc28) THEN 
           CALL i012_tc_jbc28()
           IF NOT cl_null(g_errno) THEN 
             CALL cl_err('',g_errno,0)
             NEXT FIELD tc_jbc28
           END IF 
         ELSE 
           CLEAR tc_jbc29
           INITIALIZE g_tc_jbc.tc_jbc29 TO NULL 
         END IF 

       AFTER FIELD tc_jbc10
         IF NOT cl_null(g_tc_jbc.tc_jbc10) THEN 
           CALL i012_tc_jbc10()
           IF NOT cl_null(g_errno) THEN 
             CALL cl_err('',g_errno,0)
             NEXT FIELD tc_jbc10
           END IF 
         ELSE 
           CLEAR tc_jbc11
           INITIALIZE g_tc_jbc.tc_jbc11 TO NULL 
         END IF 

        AFTER FIELD tc_jbc23    # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
            IF g_tc_jbc.tc_jbc23 < 1 THEN 
                CALL cl_err('','afa1001',0)
                NEXT FIELD tc_jbc23
            END IF 
         
       AFTER INPUT  #判斷必要欄位之值是否有值,若無則反白顯示,並要求重新輸入
         LET g_tc_jbc.tc_jbcuser = s_get_data_owner("tc_jbc_file") 
         LET g_tc_jbc.tc_jbcgrup = s_get_data_group("tc_jbc_file") 

         IF INT_FLAG THEN
            EXIT INPUT
         END IF
         # Modify.........: By li240313 新增 tc_jbc24模具类型栏位
         if cl_null(g_tc_jbc.tc_jbc24) then
            call cl_err('', '1205', '0')
            next field tc_jbc24
         end if 

         # ----------------新增逻辑----------------
         # Modify.........: By dmw 新增条件必填 做样员，根据是否做样，设置做样员。当选择Y是时，做样员为必填;
         IF g_tc_jbc.tc_jbc25 = 'Y' THEN
            IF cl_null(g_tc_jbc.tc_jbc28) THEN
               CALL cl_err('做样员', '1205', '0')
               NEXT FIELD tc_jbc28
            END IF
         END IF
         # --------------------------------------
         
      ON ACTION controlp
         CASE
            WHEN INFIELD(tc_jbc04) 
              CALL cl_init_qry_var()
              LET g_qryparam.where = "imz01 like 'A%'"
              LET g_qryparam.form = "cq_imz"
              LET g_qryparam.default1 = g_tc_jbc.tc_jbc04
              LET g_qryparam.default2 = g_imz02
              CALL cl_create_qry() RETURNING g_tc_jbc.tc_jbc04,g_imz02
              NEXT FIELD tc_jbc04
              
            WHEN INFIELD(tc_jbc08)
              #  CALL cq_hr(true,true,'') RETURNING g_tc_jac.tc_jac12
              CALL cq_hr(FALSE,TRUE,'') RETURNING g_tc_jbc.tc_jbc08
              NEXT FIELD tc_jbc08

            # Modify.........: By dmw 新增做样员字段开窗
            WHEN INFIELD(tc_jbc28)
              CALL cq_hr(FALSE,TRUE,'') RETURNING g_tc_jbc.tc_jbc28
              NEXT FIELD tc_jbc28

            WHEN INFIELD(tc_jbc10)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "cq_tc_jbg"
              LET g_qryparam.default1 = g_tc_jbc.tc_jbc10
              CALL cl_create_qry() RETURNING g_tc_jbc.tc_jbc10
              NEXT FIELD tc_jbc10
         END CASE 
          
      ON ACTION CONTROLR                  #必要字段
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()     
 
      ON ACTION help          
         CALL cl_show_help()  
 
   END INPUT
 
END FUNCTION


FUNCTION i012_tc_jbc04()

  DEFINE l_imzacti   LIKE imz_file.imzacti

    INITIALIZE g_errno,g_imz02 TO NULL 

    SELECT imz02,imzacti INTO g_imz02,l_imzacti FROM imz_file
     WHERE imz01 = g_tc_jbc.tc_jbc04

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3022'
         WHEN l_imzacti = 'N'      LET g_errno = 'aco-172'
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE

    DISPLAY g_imz02 TO imz02
    
END FUNCTION 


FUNCTION i012_tc_jbc08()

    INITIALIZE g_errno,g_tc_jbc.tc_jbc09 TO NULL 

    SELECT hr02 INTO g_tc_jbc.tc_jbc09 FROM hr_view
     WHERE hr01 = g_tc_jbc.tc_jbc08

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'aap-038'
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE

    DISPLAY BY NAME g_tc_jbc.tc_jbc09
    
END FUNCTION 

# Modify.........: By dmw 根据做样员带出做样员姓名
#函数实现
FUNCTION i012_tc_jbc28()

    INITIALIZE g_errno,g_tc_jbc.tc_jbc29 TO NULL 

    SELECT hr02 INTO g_tc_jbc.tc_jbc29 FROM hr_view
     WHERE hr01 = g_tc_jbc.tc_jbc28

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'aap-038'
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE

    DISPLAY BY NAME g_tc_jbc.tc_jbc29
    
END FUNCTION 


FUNCTION i012_tc_jbc10()

    INITIALIZE g_errno,g_tc_jbc.tc_jbc11 TO NULL 

    SELECT tc_jbg02 INTO g_tc_jbc.tc_jbc11 FROM tc_jbg_file
     WHERE tc_jbg01 = g_tc_jbc.tc_jbc10

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'aap990'
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE

    DISPLAY BY NAME g_tc_jbc.tc_jbc11
    
END FUNCTION 


FUNCTION i012_q()
    
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   
   MESSAGE ""   
   CALL cl_opmsg('q')
   CLEAR FORM
   CALL g_tc_jbd.clear()
   DISPLAY ' ' TO FORMONLY.cnt

   CALL i012_cs()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_tc_jbc.* TO NULL
      CLEAR FORM 
      RETURN
   END IF
 
   OPEN i012_cs                             # 從DB產生合乎條件TEMP(0-30秒)
   
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_tc_jbc.* TO NULL
   ELSE
      OPEN i012_count
      FETCH i012_count INTO g_row_count
      IF g_row_count = 0 THEN 
        LET g_row_count = NULL
      END IF 
      DISPLAY g_row_count TO FORMONLY.cnt
      CALL i012_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF
 
END FUNCTION
 
FUNCTION i012_fetch(p_flag)

   DEFINE p_flag          LIKE type_file.chr1                  #處理方式
 
   CASE p_flag
      WHEN 'N' FETCH NEXT     i012_cs INTO g_tc_jbc.tc_jbc01
      WHEN 'P' FETCH PREVIOUS i012_cs INTO g_tc_jbc.tc_jbc01
      WHEN 'F' FETCH FIRST    i012_cs INTO g_tc_jbc.tc_jbc01
      WHEN 'L' FETCH LAST     i012_cs INTO g_tc_jbc.tc_jbc01
      WHEN '/'
            IF (NOT mi_no_ask) THEN      
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0
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
            
            IF cl_null(g_jump) OR g_jump <= 0 OR g_jump > g_row_count THEN 
              CALL cl_err('','agl-11',0)
              RETURN 
              EXIT CASE  
            END IF
            
            FETCH ABSOLUTE g_jump i012_cs INTO g_tc_jbc.tc_jbc01
            LET mi_no_ask = FALSE    
   END CASE
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0)
      INITIALIZE g_tc_jbc.* TO NULL               
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' IF g_jump IS NOT NULL THEN LET g_curs_index = g_jump END IF 
      END CASE
      CALL cl_navigator_setting( g_curs_index, g_row_count )
      DISPLAY g_curs_index TO FORMONLY.idx                  
   END IF
 
   SELECT tc_jbc_file.* INTO g_tc_jbc.* FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
   
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","tc_jbc_file","","",SQLCA.sqlcode,"","",1)  
      INITIALIZE g_tc_jbc.* TO NULL
      RETURN
   END IF
   
       LET g_data_owner = g_tc_jbc.tc_jbcuser  
       LET g_data_group = g_tc_jbc.tc_jbcgrup     
       LET g_data_keyvalue = g_tc_jbc.tc_jbc01  
       
   CALL i012_show()
 
END FUNCTION
 
#將資料顯示在畫面上
FUNCTION i012_show()

 
   LET g_tc_jbc_t.* = g_tc_jbc.*                #保存單頭舊值
   
   IF g_tc_jbc.tc_jbc17 > g_tc_jbc.tc_jbc16 THEN 
     DISPLAY BY NAME g_tc_jbc.tc_jbc17 ATTRIBUTES(RED,REVERSE)
   ELSE 
     DISPLAY BY NAME g_tc_jbc.tc_jbc17
   END IF 
   # Modify.........: By li240416 添加 tc_jbc25 字段
   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
   # Modify.........: By dmw 添加栏位: tc_jbc28做样员、tc_jbc28做样员姓名
   DISPLAY BY NAME g_tc_jbc.tc_jbc01,g_tc_jbc.tc_jbc21,g_tc_jbc.tc_jbc02,g_tc_jbc.tc_jbc03,
                   g_tc_jbc.tc_jbc04,g_tc_jbc.tc_jbc05,g_tc_jbc.tc_jbc06,
                   g_tc_jbc.tc_jbc07,g_tc_jbc.tc_jbc08,g_tc_jbc.tc_jbc09,
                   g_tc_jbc.tc_jbc10,g_tc_jbc.tc_jbc11,g_tc_jbc.tc_jbc12,
                   g_tc_jbc.tc_jbc13,g_tc_jbc.tc_jbc14,g_tc_jbc.tc_jbc15,
                   g_tc_jbc.tc_jbc16,#g_tc_jbc.tc_jbc17,
                   g_tc_jbc.tc_jbc22,g_tc_jbc.tc_jbc23,  # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
                   g_tc_jbc.tc_jbc18,g_tc_jbc.tc_jbc24,g_tc_jbc.tc_jbc25,g_tc_jbc.tc_jbc26,g_tc_jbc.tc_jbc27,g_tc_jbc.tc_jbc28,g_tc_jbc.tc_jbc29,  # dmw20260320
                   g_tc_jbc.tc_jbc19,g_tc_jbc.tc_jbc20,  #Teval 210910
                   g_tc_jbc.tc_jbcconf,g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcuser,
                   g_tc_jbc.tc_jbcgrup,g_tc_jbc.tc_jbcmodu,g_tc_jbc.tc_jbcdate #ATTRIBUTE(GREEN)

    CALL i012_tc_jbc04()
    CALL i012_show_pic()
    CALL i012_b_fill(g_wc2)                     #單身
    CALL i012_b_fill2(g_wc3)                    #單身
    CALL cl_show_fld_cont()                  
    
END FUNCTION

FUNCTION i012_x()

 # DEFINE l_chk_n         LIKE type_file.num10 #判断是否已存在此分类的仪器档案资料
 
   IF s_shut(0) THEN
      RETURN
   END IF

   MESSAGE ""
   
   IF g_tc_jbc.tc_jbc01 IS NULL THEN
      CALL cl_err("",-400,0)
      RETURN
   END IF
   
   SELECT tc_jbcconf INTO g_tc_jbc.tc_jbcconf FROM tc_jbc_file WHERE tc_jbc01=g_tc_jbc.tc_jbc01
   
   IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
      CALL cl_err('','abm-887',0)              #此笔资料已审核，不能置为无效
      RETURN 
   END IF 
   
   BEGIN WORK
 
   OPEN i012_cl USING g_tc_jbc.tc_jbc01
   IF STATUS THEN
      CALL cl_err("OPEN i012_cl:", STATUS, 1)
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH i012_cl INTO g_tc_jbc.*               # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0)         #資料被他人LOCK
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF

   CALL i012_show()
 
   IF cl_exp(0,0,g_tc_jbc.tc_jbcacti) THEN                   #確認一下
      LET g_chr=g_tc_jbc.tc_jbcacti

      IF g_tc_jbc.tc_jbcacti='Y' THEN
         LET g_tc_jbc.tc_jbcacti='N'
      ELSE
         LET g_tc_jbc.tc_jbcacti='Y'
      END IF
 
      UPDATE tc_jbc_file SET tc_jbcacti = g_tc_jbc.tc_jbcacti,
                             tc_jbcmodu = g_user,
                             tc_jbcdate = g_today
                       WHERE tc_jbc01=g_tc_jbc.tc_jbc01
       
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err3("upd","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1)  
         LET g_tc_jbc.tc_jbcacti=g_chr
         CLOSE i012_cl
         ROLLBACK WORK 
         RETURN 
      ELSE 
         COMMIT WORK
         LET g_success = 'Y'
         MESSAGE 'Invalid O.K.'
      END IF
   END IF 
   
   CLOSE i012_cl
   
   SELECT tc_jbc_file.* INTO g_tc_jbc.* FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
   CALL i012_show()
END FUNCTION
 
FUNCTION i012_r()

  DEFINE l_chk_n        LIKE type_file.num10 #判断是否已存在此分类的仪器档案资料
       
   IF s_shut(0) THEN
      RETURN
   END IF
   
   IF g_tc_jbc.tc_jbc01 IS NULL THEN
      CALL cl_err("",-400,0)
      RETURN
   END IF
      
   SELECT tc_jbcacti,tc_jbcconf INTO g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcconf FROM tc_jbc_file WHERE tc_jbc01=g_tc_jbc.tc_jbc01
    
   IF g_tc_jbc.tc_jbcacti = 'N' THEN 
     CALL cl_err("",'aic-201',0)               #此笔资料无效，不可删除
     RETURN 
   END IF 
   
   IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
      CALL cl_err('','alm-551',0)              #此笔资料已审核，不能置为无效
       RETURN 
   END IF 

   BEGIN WORK 

   SELECT COUNT(tc_jac03) INTO l_chk_n FROM tc_jac_file WHERE tc_jac03 = g_tc_jbc.tc_jbc01
   
   IF l_chk_n > 0 THEN 
     CALL cl_err('','cfa-005',1)                        #该分类编号已有仪器资料，不可删除
     RETURN 
   END IF 
   
   OPEN i012_cl USING g_tc_jbc.tc_jbc01
   
   IF STATUS THEN
      CALL cl_err("OPEN i012_cl:", STATUS, 1)
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH i012_cl INTO g_tc_jbc.*                        # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0)    # 資料被他人LOCK
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   CALL i012_show()
 
   IF cl_delh(0,0) THEN              #確認一下
  
       INITIALIZE g_doc.* TO NULL         
       LET g_doc.column1 = "tc_jbc01"       
       LET g_doc.value1 = g_tc_jbc.tc_jbc01    
       CALL cl_del_doc()
     
       DELETE FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
       IF SQLCA.SQLERRD[3]=0 THEN 
          CALL cl_err3("delete","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1)  
          CLOSE i012_cs       
          ROLLBACK WORK 
          RETURN
       ELSE 
          IF g_rec_b < 1 THEN        #若单身少于1笔，以此判断单身有无资料
             COMMIT WORK
             LET g_success = 'Y'
          ELSE  
             DELETE FROM tc_jbd_file WHERE tc_jbd01 = g_tc_jbc.tc_jbc01
             IF SQLCA.SQLERRD[3]=0 THEN 
                CALL cl_err3("delete","tc_jbd_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1)  
                CLOSE i012_cs       
                ROLLBACK WORK 
                RETURN
             ELSE 
                COMMIT WORK
                LET g_success = 'Y'
                MESSAGE 'Delete O.K.'
             END IF 
         END IF 
       END IF 
     
       CLEAR FORM
       CALL g_tc_jbd.clear()
       
    OPEN i012_count
      IF STATUS THEN 
         CLOSE i012_cs
         CLOSE i012_count
         ROLLBACK WORK
         RETURN
      END IF 

      FETCH i012_count INTO g_row_count

      IF STATUS OR (cl_null(g_row_count) OR g_row_count = 0 ) THEN 
         CLOSE i012_cs
         CLOSE i012_count
         ROLLBACK WORK
         RETURN
      END IF  
      
      DISPLAY g_row_count TO FORMONLY.cnt
      
      OPEN i012_cs
      IF g_curs_index = g_row_count + 1 THEN 
         LET g_jump = g_row_count
         CALL i012_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET mi_no_ask = TRUE      
         CALL i012_fetch('/')
      END IF 
      DISPLAY g_jump TO FORMONLY.idx
   END IF 
   
   CLOSE i012_cl
END FUNCTION
 
#單身
FUNCTION i012_b()
  DEFINE          
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT  
    l_n             LIKE type_file.num5,                #檢查重複用  
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住否 
    p_cmd           LIKE type_file.chr1,                #處理狀態                
    l_allow_insert  LIKE type_file.num5,                #可新增否  
    l_allow_delete  LIKE type_file.num5                 #可删除否
    
    LET g_action_choice = ""
 
    IF s_shut(0) THEN
       RETURN
    END IF
    MESSAGE ""
    
    IF g_tc_jbc.tc_jbc01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
    END IF
    
    SELECT tc_jbcacti,tc_jbcconf INTO g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcconf FROM tc_jbc_file WHERE tc_jbc01=g_tc_jbc.tc_jbc01
 
    IF g_tc_jbc.tc_jbcacti ='N' THEN    #檢查資料是否為無效
       CALL cl_err('','alm-150',0)
       RETURN
    END IF
    
    IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
       CALL cl_err('','abm-879',0)      #此笔资料已审核，不能进入单身
       RETURN 
    END IF 

    CALL cl_opmsg('b')
 
    LET g_forupd_sql = "SELECT tc_jbd02,tc_jbd03,tc_jbd04,tc_jbd05,tc_jbd07,tc_jbd06",
                       "  FROM tc_jbd_file",
                       "  WHERE tc_jbd01=? AND tc_jbd02=? ",
                       "  FOR UPDATE " 
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i012_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
 
    INPUT ARRAY g_tc_jbd WITHOUT DEFAULTS FROM s_tc_jbd.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
           DISPLAY "BEFORE INPUT!"
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF
 
        BEFORE ROW
           DISPLAY "BEFORE ROW!"
           LET p_cmd = ''
           LET l_ac = ARR_CURR()
           LET l_lock_sw = 'N'            #DEFAULT
           LET l_n = ARR_COUNT()     
          
           BEGIN WORK     
           OPEN i012_cl USING g_tc_jbc.tc_jbc01
           IF STATUS THEN
              CALL cl_err("OPEN i012_cl:",STATUS,1)
              CLOSE i012_cl
              ROLLBACK WORK
              RETURN
           END IF
 
           FETCH i012_cl INTO g_tc_jbc.*                    # 鎖住將被更改或取消的資料
           IF SQLCA.sqlcode THEN
              CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0)# 資料被他人LOCK
              CLOSE i012_cl
              ROLLBACK WORK
              RETURN
           END IF
 
           IF g_rec_b >= l_ac THEN
              LET p_cmd = 'u'
              LET g_tc_jbd_t.* = g_tc_jbd[l_ac].*       #BACKUP
              OPEN i012_bcl USING g_tc_jbc.tc_jbc01,g_tc_jbd_t.tc_jbd02
              IF STATUS THEN
                 CALL cl_err("OPEN i012_bcl:",STATUS,1)
                 LET l_lock_sw = "Y"
              ELSE
                 FETCH i012_bcl INTO g_tc_jbd[l_ac].*
                 IF SQLCA.sqlcode THEN
                    CALL cl_err(g_tc_jbd_t.tc_jbd02,SQLCA.sqlcode,1)
                    LET l_lock_sw = "Y"
                 END IF
              END IF     

              CALL cl_show_fld_cont() 
           END IF 
 
        BEFORE INSERT
           DISPLAY "BEFORE INSERT!"
           LET l_n = ARR_COUNT()
           LET p_cmd='a'
           LET g_tc_jbd_t.* = g_tc_jbd[l_ac].*         #新輸入資料
           LET g_tc_jbd[l_ac].tc_jbd02 = NULL
           LET g_tc_jbd[l_ac].tc_jbd03 = NULL 
           LET g_tc_jbd[l_ac].tc_jbd04 = NULL 
           LET g_tc_jbd[l_ac].tc_jbd05 = NULL   
           LET g_tc_jbd[l_ac].tc_jbd06 = NULL 
           LET g_tc_jbd[l_ac].tc_jbd07 = '0'            
           CALL cl_show_fld_cont()
           NEXT FIELD tc_jbd02
 
        AFTER INSERT
           DISPLAY "AFTER INSERT!"
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              CANCEL INSERT
           END IF

           INSERT INTO tc_jbd_file(tc_jbd01,
                                   tc_jbd02,
                                   tc_jbd03,
                                   tc_jbd04,
                                   tc_jbd05,
                                   tc_jbd06,
                                   tc_jbd07) 
                            VALUES(g_tc_jbc.tc_jbc01,
                                   g_tc_jbd[l_ac].tc_jbd02,
                                   g_tc_jbd[l_ac].tc_jbd03,
                                   g_tc_jbd[l_ac].tc_jbd04,
                                   g_tc_jbd[l_ac].tc_jbd05,
                                   g_tc_jbd[l_ac].tc_jbd06,
                                   g_tc_jbd[l_ac].tc_jbd07) 
           IF SQLCA.sqlcode THEN
              CALL cl_err3("ins","tc_jbd_file",g_tc_jbc.tc_jbc01,g_tc_jbd[l_ac].tc_jbd02,SQLCA.sqlcode,"","",1)  
              CANCEL INSERT
           ELSE
              COMMIT WORK
              MESSAGE 'Insert O.K.'
              LET g_rec_b=g_rec_b+1
              DISPLAY g_rec_b TO FORMONLY.cn2
           END IF
 
        BEFORE FIELD tc_jbd02                       #default 序號
           IF g_tc_jbd[l_ac].tc_jbd02 IS NULL OR g_tc_jbd[l_ac].tc_jbd02 = 0 THEN
              SELECT max(tc_jbd02)+1
                INTO g_tc_jbd[l_ac].tc_jbd02
                FROM tc_jbd_file
               WHERE tc_jbd01 = g_tc_jbc.tc_jbc01
              IF g_tc_jbd[l_ac].tc_jbd02 IS NULL THEN
                 LET g_tc_jbd[l_ac].tc_jbd02 = 1
              END IF
           END IF 
        
        AFTER FIELD tc_jbd02                        #check 序號是否重複
           IF NOT cl_null(g_tc_jbd[l_ac].tc_jbd02) 
           AND (g_tc_jbd[l_ac].tc_jbd02 != g_tc_jbd_t.tc_jbd02 
           OR cl_null(g_tc_jbd_t.tc_jbd02)) THEN
                 SELECT count(*) INTO l_n FROM tc_jbd_file
                  WHERE tc_jbd01 = g_tc_jbc.tc_jbc01
                    AND tc_jbd02 = g_tc_jbd[l_ac].tc_jbd02
                 IF l_n > 0 THEN
                    CALL cl_err('',-239,0)
                    LET g_tc_jbd[l_ac].tc_jbd02 = g_tc_jbd_t.tc_jbd02
                    NEXT FIELD tc_jbd02
                 END IF
              END IF

        BEFORE DELETE                      #是否取消單身
           DISPLAY "BEFORE DELETE"
           IF g_tc_jbd_t.tc_jbd02 > 0 AND g_tc_jbd_t.tc_jbd02 IS NOT NULL THEN
              IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
              END IF
              IF l_lock_sw = "Y" THEN
                 CALL cl_err("", -263, 1)
                 CANCEL DELETE
              END IF
              DELETE FROM tc_jbd_file
               WHERE tc_jbd01 = g_tc_jbc.tc_jbc01
                 AND tc_jbd02 = g_tc_jbd_t.tc_jbd02
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","tc_jbd_file",g_tc_jbc.tc_jbc01,g_tc_jbd_t.tc_jbd02,SQLCA.sqlcode,"","",1)  
                 ROLLBACK WORK
                 CANCEL DELETE
              END IF
              LET g_rec_b=g_rec_b-1
              DISPLAY g_rec_b TO FORMONLY.cn2
              COMMIT WORK
              MESSAGE 'Delete O.K.'
           END IF
 
        ON ROW CHANGE
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              LET g_tc_jbd[l_ac].* = g_tc_jbd_t.*
              CLOSE i012_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF
           IF l_lock_sw = 'Y' THEN
              CALL cl_err(g_tc_jbd[l_ac].tc_jbd02,'-263',1)
              LET g_tc_jbd[l_ac].* = g_tc_jbd_t.*
           ELSE
              UPDATE tc_jbd_file SET tc_jbd02=g_tc_jbd[l_ac].tc_jbd02,
                                     tc_jbd03=g_tc_jbd[l_ac].tc_jbd03,
                                     tc_jbd04=g_tc_jbd[l_ac].tc_jbd04,
                                     tc_jbd05=g_tc_jbd[l_ac].tc_jbd05,
                                     tc_jbd06=g_tc_jbd[l_ac].tc_jbd06,
                                     tc_jbd07=g_tc_jbd[l_ac].tc_jbd07
               WHERE tc_jbd01=g_tc_jbc.tc_jbc01 AND tc_jbd02=g_tc_jbd_t.tc_jbd02
               
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_jbd_file",g_tc_jbc.tc_jbc01,g_tc_jbd_t.tc_jbd02,SQLCA.sqlcode,"","",1) 
                   LET g_tc_jbd[l_ac].* = g_tc_jbd_t.*
                   ROLLBACK WORK 
               ELSE
                  COMMIT WORK
                  MESSAGE 'Update O.K.'
               END IF
           END IF 
 
        AFTER ROW
           DISPLAY  "AFTER ROW!!"
           LET l_ac = ARR_CURR()
         #  LET l_ac_t = l_ac       
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              IF p_cmd = 'u' THEN
                 LET g_tc_jbd[l_ac].* = g_tc_jbd_t.*
              ELSE
                 CALL g_tc_jbd.deleteElement(l_ac)
                 IF g_rec_b != 0 THEN
                    LET g_action_choice = "detail"
                    LET l_ac = l_ac_t
                 END IF
              END IF
              CLOSE i012_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF
           LET l_ac_t = l_ac    
           CLOSE i012_bcl
 
        ON ACTION CONTROLO                        
           IF INFIELD(tc_jbd02) AND l_ac > 1 THEN
              LET g_tc_jbd[l_ac].* = g_tc_jbd[l_ac-1].*
              LET g_tc_jbd[l_ac].tc_jbd02 = g_rec_b + 1
              NEXT FIELD tc_jbd02
           END IF
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()  

      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()     
 
      ON ACTION help         
         CALL cl_show_help()  
 
      ON ACTION controls                                    
         CALL cl_set_head_visible("Page01,Page02","AUTO")      
    END INPUT
    
    IF p_cmd = 'u' THEN
       LET g_tc_jbc.tc_jbcmodu = g_user
       LET g_tc_jbc.tc_jbcdate = g_today
    
       UPDATE tc_jbc_file SET  tc_jbcmodu = g_tc_jbc.tc_jbcmodu,
                               tc_jbcdate = g_tc_jbc.tc_jbcdate
                         WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
       IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
          CALL cl_err3("upd","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.SQLCODE,"","",1)
          CLOSE i012_bcl
          ROLLBACK WORK 
          RETURN   
       END IF
       DISPLAY BY NAME g_tc_jbc.tc_jbcmodu,g_tc_jbc.tc_jbcdate
    END IF 
    
    CLOSE i012_bcl
    COMMIT WORK
    CALL i012_delHeader()
    
END FUNCTION

#單身 
FUNCTION i012_b2(p_act) 
    DEFINE p_act    STRING                              # 0 普通；1 更新弹簧更换时间
    DEFINE  l_ac2_t LIKE type_file.num5,                # 未取消的ARRAY CNT 
      l_n             LIKE type_file.num5,                #檢查重複用 
      l_lock_sw       LIKE type_file.chr1,                #單身鎖住否 
      p_cmd           LIKE type_file.chr1,                #處理狀態 
      l_allow_insert  LIKE type_file.num5,                #可新增否 
      l_allow_delete  LIKE type_file.num5                 #可删除否 

      LET g_action_choice = "" 

      IF s_shut(0) THEN 
         RETURN 
      END IF 
      MESSAGE "" 

      IF g_tc_jbc.tc_jbcconf != 'N' THEN
         CALL cl_err('','0001',0)
         RETURN
      END IF

      IF g_tc_jbc.tc_jbc01 IS NULL THEN 
         CALL cl_err('',-400,0) 
         RETURN 
      END IF 

      SELECT tc_jbcacti,tc_jbcconf INTO g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcconf FROM tc_jbc_file WHERE tc_jbc01=g_tc_jbc.tc_jbc01 

      IF g_tc_jbc.tc_jbcacti ='N' THEN    #檢查資料是否為無效 
         CALL cl_err('','alm-150',0) 
         RETURN 
      END IF 

     IF p_act = '0' THEN 
        IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
            CALL cl_err('','abm-879',0)      #此笔资料已审核，不能进入单身 
            RETURN 
        END IF 
        CALL cl_set_comp_entry('tc_jcl02,tc_jcl03,tc_jcl04,tc_jcl08', TRUE)
        CALL cl_set_comp_entry('tc_jcl06', FALSE)
     ELSE 
        CALL cl_set_comp_entry('tc_jcl02,tc_jcl03,tc_jcl04,tc_jcl08', FALSE)
        CALL cl_set_comp_entry('tc_jcl06', TRUE)
     END IF 

      CALL cl_opmsg('b') 

      LET g_forupd_sql = "SELECT tc_jcl02,tc_jcl03,tc_jcl04,tc_jcl08,tc_jcl05,tc_jcl06,tc_jcl07,tc_jcl09", 
                         "  FROM tc_jcl_file", 
                         "  WHERE tc_jcl01=? AND tc_jcl02=? ", 
                         "  FOR UPDATE " 
                         
      LET g_forupd_sql = cl_forupd_sql(g_forupd_sql) 
      DECLARE i012_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR 

      LET l_allow_insert = IIF(p_act='0',cl_detail_input_auth("insert"),false) 
      LET l_allow_delete = IIF(p_act='0',cl_detail_input_auth("delete"),false) 

      INPUT ARRAY g_tc_jcl WITHOUT DEFAULTS FROM s_tc_jcl.* 
         ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED, 
         INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete, 
         APPEND ROW=l_allow_insert) 

         BEFORE INPUT 
            DISPLAY "BEFORE INPUT!" 
            IF g_rec_b2 != 0 THEN 
               CALL fgl_set_arr_curr(l_ac2) 
            END IF 

         BEFORE ROW 
            DISPLAY "BEFORE ROW!" 
            LET p_cmd = '' 
            LET l_ac2 = ARR_CURR() 
            LET l_lock_sw = 'N' #DEFAULT 
            LET l_n = ARR_COUNT() 

            BEGIN WORK 
            OPEN i012_cl USING g_tc_jbc.tc_jbc01 
            IF STATUS THEN 
               CALL cl_err("OPEN i012_cl:",STATUS,1) 
               CLOSE i012_cl 
               ROLLBACK WORK 
               RETURN 
            END IF 

            FETCH i012_cl INTO g_tc_jbc.*                    # 鎖住將被更改或取消的資料 
            IF SQLCA.sqlcode THEN 
               CALL cl_err(g_tc_jbc.tc_jbc01,SQLCA.sqlcode,0)# 資料被他人LOCK 
               CLOSE i012_cl 
               ROLLBACK WORK 
               RETURN 
            END IF 

            IF g_rec_b2 >= l_ac2 THEN 
               LET p_cmd = 'u' 
               LET g_tc_jcl_t.* = g_tc_jcl[l_ac2].* #BACKUP 
               OPEN i012_bcl2 USING g_tc_jbc.tc_jbc01,g_tc_jcl_t.tc_jcl02 
               IF STATUS THEN 
                  CALL cl_err("OPEN i012_bcl2:",STATUS,1) 
                  LET l_lock_sw = "Y" 
               ELSE 
                  FETCH i012_bcl2 INTO g_tc_jcl[l_ac2].* 
                  IF SQLCA.sqlcode THEN 
                     CALL cl_err(g_tc_jcl_t.tc_jcl02,SQLCA.sqlcode,1) 
                     LET l_lock_sw = "Y" 
                  END IF 
               END IF 

               CALL cl_show_fld_cont() 
            END IF 

         BEFORE INSERT 
            DISPLAY "BEFORE INSERT!" 
            LET l_n = ARR_COUNT() 
            LET p_cmd='a' 
            LET g_tc_jcl_t.* = g_tc_jcl[l_ac2].* #新輸入資料 
            LET g_tc_jcl[l_ac2].tc_jcl02 = NULL 
            LET g_tc_jcl[l_ac2].tc_jcl03 = NULL 
            LET g_tc_jcl[l_ac2].tc_jcl04 = NULL 
            LET g_tc_jcl[l_ac2].tc_jcl05 = NULL 
            LET g_tc_jcl[l_ac2].tc_jcl06 = NULL 
            CALL cl_show_fld_cont() 
            NEXT FIELD tc_jcl02 

         AFTER INSERT 
            DISPLAY "AFTER INSERT!" 
            IF INT_FLAG THEN 
               CALL cl_err('',9001,0) 
               LET INT_FLAG = 0 
               CANCEL INSERT 
            END IF 

            INSERT INTO tc_jcl_file(tc_jcl01, 
                                    tc_jcl02, 
                                    tc_jcl03, 
                                    tc_jcl04, 
                                    tc_jcl05, 
                                    tc_jcl06,
                                    tc_jcl07,
                                    tc_jcl08,
                                    tc_jcl09) 
                             VALUES(g_tc_jbc.tc_jbc01, 
                                    g_tc_jcl[l_ac2].tc_jcl02, 
                                    g_tc_jcl[l_ac2].tc_jcl03, 
                                    g_tc_jcl[l_ac2].tc_jcl04, 
                                    g_tc_jcl[l_ac2].tc_jcl05, 
                                    g_tc_jcl[l_ac2].tc_jcl06, 
                                    g_tc_jcl[l_ac2].tc_jcl07, 
                                    g_tc_jcl[l_ac2].tc_jcl08, 
                                    g_tc_jcl[l_ac2].tc_jcl09) 
            IF SQLCA.sqlcode THEN 
               CALL cl_err3("ins","tc_jcl_file",g_tc_jbc.tc_jbc01,g_tc_jcl[l_ac2].tc_jcl02,SQLCA.sqlcode,"","",1) 
               CANCEL INSERT 
            ELSE 
               COMMIT WORK 
               MESSAGE 'Insert O.K.' 
               LET g_rec_b2=g_rec_b2+1 
               DISPLAY g_rec_b2 TO FORMONLY.cn3 
            END IF 

         BEFORE FIELD tc_jcl02                       #default 序號 
            IF g_tc_jcl[l_ac2].tc_jcl02 IS NULL OR g_tc_jcl[l_ac2].tc_jcl02 = 0 THEN 
               SELECT max(tc_jcl02)+1 
                INTO g_tc_jcl[l_ac2].tc_jcl02 
                FROM tc_jcl_file 
               WHERE tc_jcl01 = g_tc_jbc.tc_jbc01 
               IF g_tc_jcl[l_ac2].tc_jcl02 IS NULL THEN 
                  LET g_tc_jcl[l_ac2].tc_jcl02 = 1 
               END IF 
            END IF 

         AFTER FIELD tc_jcl02                        #check 序號是否重複 
            IF NOT cl_null(g_tc_jcl[l_ac2].tc_jcl02) 
               AND (g_tc_jcl[l_ac2].tc_jcl02 != g_tc_jcl_t.tc_jcl02 
               OR cl_null(g_tc_jcl_t.tc_jcl02)) THEN 
               SELECT count(*) INTO l_n FROM tc_jcl_file 
                  WHERE tc_jcl01 = g_tc_jbc.tc_jbc01 
                    AND tc_jcl02 = g_tc_jcl[l_ac2].tc_jcl02 
               IF l_n > 0 THEN 
                  CALL cl_err('',-239,0) 
                  LET g_tc_jcl[l_ac2].tc_jcl02 = g_tc_jcl_t.tc_jcl02 
                  NEXT FIELD tc_jcl02 
               END IF 
            END IF 

         ON CHANGE tc_jcl03
            CASE g_tc_jcl[l_ac2].tc_jcl03
               WHEN '1' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '2' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '3' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 300000
               WHEN '4' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '5' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 1000000
               WHEN '6' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 300000
               WHEN '7' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '8' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 1000000
               WHEN '9' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 300000
               WHEN '10' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '11' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 1000000
               WHEN '12' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 300000
               WHEN '13' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
               WHEN '14' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 1000000
               WHEN '15' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 80000
               WHEN '16' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 80000
               WHEN '17' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 80000
               WHEN '18' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 50000
               WHEN '19' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 80000
               WHEN '20' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 50000
               WHEN '21' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 100000
               WHEN '22' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 80000
               WHEN '23' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 1000000
               WHEN '24' 
                  LET g_tc_jcl[l_ac2].tc_jcl04 = 500000
            END CASE
            DISPLAY BY NAME g_tc_jcl[l_ac2].tc_jcl04

         BEFORE DELETE                      #是否取消單身 
            DISPLAY "BEFORE DELETE" 
            IF g_tc_jcl_t.tc_jcl02 > 0 AND g_tc_jcl_t.tc_jcl02 IS NOT NULL THEN 
               IF NOT cl_delb(0,0) THEN 
                  CANCEL DELETE 
               END IF 
               
               IF l_lock_sw = "Y" THEN 
                  CALL cl_err("", -263, 1) 
                  CANCEL DELETE 
               END IF 
               
               DELETE FROM tc_jcl_file 
               WHERE tc_jcl01 = g_tc_jbc.tc_jbc01 
               AND tc_jcl02 = g_tc_jcl_t.tc_jcl02 
               
               IF SQLCA.sqlcode THEN 
                  CALL cl_err3("del","tc_jcl_file",g_tc_jbc.tc_jbc01,g_tc_jcl_t.tc_jcl02,SQLCA.sqlcode,"","",1) 
                  ROLLBACK WORK 
                  CANCEL DELETE 
               END IF 
               LET g_rec_b2=g_rec_b2-1 
               DISPLAY g_rec_b2 TO FORMONLY.cn3 
               COMMIT WORK 
               MESSAGE 'Delete O.K.' 
            END IF 

         ON ROW CHANGE 
            IF INT_FLAG THEN 
               CALL cl_err('',9001,0) 
               LET INT_FLAG = 0 
               LET g_tc_jcl[l_ac2].* = g_tc_jcl_t.* 
               CLOSE i012_bcl2 
               ROLLBACK WORK 
               EXIT INPUT 
            END IF 
            IF l_lock_sw = 'Y' THEN 
               CALL cl_err(g_tc_jcl[l_ac2].tc_jcl02,'-263',1) 
               LET g_tc_jcl[l_ac2].* = g_tc_jcl_t.* 
            ELSE 
               IF cl_null(g_tc_jcl[l_ac2].tc_jcl06) OR g_tc_jcl[l_ac2].tc_jcl06>g_tc_jcl_t.tc_jcl06 THEN 
                  LET g_tc_jcl[l_ac2].tc_jcl07=NULL 
               END IF
               UPDATE tc_jcl_file SET tc_jcl02=g_tc_jcl[l_ac2].tc_jcl02, 
                                      tc_jcl03=g_tc_jcl[l_ac2].tc_jcl03, 
                                      tc_jcl04=g_tc_jcl[l_ac2].tc_jcl04, 
                                      tc_jcl05=g_tc_jcl[l_ac2].tc_jcl05, 
                                      tc_jcl06=g_tc_jcl[l_ac2].tc_jcl06, 
                                      tc_jcl07=g_tc_jcl[l_ac2].tc_jcl07, 
                                      tc_jcl08=g_tc_jcl[l_ac2].tc_jcl08, 
                                      tc_jcl09=g_tc_jcl[l_ac2].tc_jcl09
                                WHERE tc_jcl01=g_tc_jbc.tc_jbc01 AND tc_jcl02=g_tc_jcl_t.tc_jcl02 

               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
                  CALL cl_err3("upd","tc_jcl_file",g_tc_jbc.tc_jbc01,g_tc_jcl_t.tc_jcl02,SQLCA.sqlcode,"","",1) 
                  LET g_tc_jcl[l_ac2].* = g_tc_jcl_t.* 
                  ROLLBACK WORK 
               ELSE 
                  COMMIT WORK 
                  MESSAGE 'Update O.K.' 
               END IF 
            END IF 

         AFTER ROW 
            DISPLAY "AFTER ROW!!" 
            LET l_ac2 = ARR_CURR() 
         #  LET l_ac2_t = l_ac2 
            IF INT_FLAG THEN 
               CALL cl_err('',9001,0) 
               LET INT_FLAG = 0 
               IF p_cmd = 'u' THEN 
                  LET g_tc_jcl[l_ac2].* = g_tc_jcl_t.* 
               ELSE 
                  CALL g_tc_jcl.deleteElement(l_ac2) 
                  IF g_rec_b2 != 0 THEN 
                     LET g_action_choice = "detail" 
                     LET l_ac2 = l_ac2_t 
                  END IF 
               END IF 
               CLOSE i012_bcl2 
               ROLLBACK WORK 
               EXIT INPUT 
            END IF 
            LET l_ac2_t = l_ac2 
            CLOSE i012_bcl2 

         ON ACTION CONTROLO 
            IF INFIELD(tc_jcl02) AND l_ac2 > 1 THEN 
               LET g_tc_jcl[l_ac2].* = g_tc_jcl[l_ac2-1].* 
               LET g_tc_jcl[l_ac2].tc_jcl02 = g_rec_b2 + 1 
               NEXT FIELD tc_jcl02 
            END IF 

         ON ACTION CONTROLR 
            CALL cl_show_req_fields() 

         ON ACTION CONTROLG 
            CALL cl_cmdask() 

         ON ACTION CONTROLF 
            CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
            CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 

         ON IDLE g_idle_seconds 
            CALL cl_on_idle() 
            CONTINUE INPUT 

         ON ACTION about 
            CALL cl_about() 

         ON ACTION help 
            CALL cl_show_help() 

         ON ACTION controls 
            CALL cl_set_head_visible("Page01,Page02","AUTO") 
      END INPUT 

      IF p_cmd = 'u' THEN 
         LET g_tc_jbc.tc_jbcmodu = g_user 
         LET g_tc_jbc.tc_jbcdate = g_today 

         UPDATE tc_jbc_file SET tc_jbcmodu = g_tc_jbc.tc_jbcmodu, 
                                tc_jbcdate = g_tc_jbc.tc_jbcdate 
                          WHERE tc_jbc01 = g_tc_jbc.tc_jbc01 
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN 
            CALL cl_err3("upd","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.SQLCODE,"","",1) 
            CLOSE i012_bcl2 
            ROLLBACK WORK 
            RETURN 
         END IF 
         DISPLAY BY NAME g_tc_jbc.tc_jbcmodu,g_tc_jbc.tc_jbcdate 
      END IF 

      CLOSE i012_bcl2 
      COMMIT WORK 
      CALL i012_delHeader() 

END FUNCTION


FUNCTION i012_delHeader()
   IF g_rec_b = 0 AND g_rec_b2 = 0 THEN
      IF cl_confirm("9042") THEN
         DELETE FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
         IF SQLCA.SQLCODE THEN 
            CALL cl_err3("del","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.SQLCODE,"","",1)
            ROLLBACK WORK
            RETURN   
         ELSE 
            INITIALIZE g_tc_jbc.* TO NULL
            CLEAR FORM
         END IF 
      END IF
   END IF
END FUNCTION

FUNCTION i012_b_fill(p_wc2)
DEFINE p_wc2   STRING
 
   LET g_sql = " SELECT tc_jbd02,tc_jbd03,tc_jbd04,tc_jbd05,tc_jbd07,tc_jbd06 ",
               "  FROM tc_jbd_file",   
               "  WHERE tc_jbd01 ='",g_tc_jbc.tc_jbc01,"'"

   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED," ORDER BY tc_jbd02"
   ELSE 
      LET g_sql=g_sql CLIPPED," ORDER BY tc_jbd01 "
   END IF
   
   DISPLAY g_sql
 
   PREPARE i012_pb FROM g_sql
   DECLARE tc_jbd_cs CURSOR FOR i012_pb
 
   CALL g_tc_jbd.clear()
   
   LET g_cnt = 1
 
   FOREACH tc_jbd_cs INTO g_tc_jbd[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
       
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_jbd.deleteElement(g_cnt)         #删除最后新增的空白列
   LET g_rec_b=g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0
 
END FUNCTION

FUNCTION i012_b_fill2(p_wc2)
DEFINE p_wc2   STRING
 
   LET g_sql = " SELECT tc_jcl02,tc_jcl03,tc_jcl04,tc_jcl08,tc_jcl05,tc_jcl06,tc_jcl07,tc_jcl09 ",
               "  FROM tc_jcl_file",   
               "  WHERE tc_jcl01 ='",g_tc_jbc.tc_jbc01,"'"

   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED," ORDER BY tc_jcl02"
   ELSE 
      LET g_sql=g_sql CLIPPED," ORDER BY tc_jcl02 "
   END IF
   
   DISPLAY g_sql
 
   PREPARE i012_pb_b2 FROM g_sql
   DECLARE tc_jcl_cs CURSOR FOR i012_pb_b2
 
   CALL g_tc_jcl.clear()
   
   LET g_cnt = 1
 
   FOREACH tc_jcl_cs INTO g_tc_jcl[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
       
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_jcl.deleteElement(g_cnt)         #删除最后新增的空白列
   LET g_rec_b2=g_cnt-1
   DISPLAY g_rec_b2 TO FORMONLY.cn3
   LET g_cnt = 0
 
END FUNCTION
 
FUNCTION i012_copy()

   DEFINE l_newno     LIKE tc_jbc_file.tc_jbc01,
          l_oldno     LIKE tc_jbc_file.tc_jbc01

   IF s_shut(0) THEN 
     RETURN
   END IF
   MESSAGE ""
   
   IF g_tc_jbc.tc_jbc01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   LET g_before_input_done = FALSE
   CALL i012_set_entry('c')
   LET g_before_input_done = TRUE 
         
   INPUT l_newno FROM tc_jbc01

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION HELP        
         CALL cl_show_help() 
 
      ON ACTION controlg     
         CALL cl_cmdask()     

   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      DISPLAY BY NAME g_tc_jbc.tc_jbc01
      RETURN
   END IF
   
   DROP TABLE y
 
   SELECT * FROM tc_jbc_file         #單頭複製
       WHERE tc_jbc01=g_tc_jbc.tc_jbc01
       INTO TEMP y
       
   DROP TABLE x
 
   SELECT * FROM tc_jbd_file         #單身複製
       WHERE tc_jbd01 = g_tc_jbc.tc_jbc01
       INTO TEMP x
   
   BEGIN WORK
   
   LET g_success = 'Y'
   
   UPDATE y
       SET tc_jbc01=l_newno,    #新的鍵值
           tc_jbc12=g_today,
           tc_jbc13=NULL,
           tc_jbc14=g_today,
           tc_jbc15=NULL,
           tc_jbc17=NULL,
           tc_jbc22="N",
           tc_jbc18='0',
           tc_jbc19='N',   #Teval 210910
           tc_jbcoriu=g_user,
           tc_jbcorig=g_grup,
           tc_jbcuser=g_user,   #資料所有者
           tc_jbcgrup=g_grup,   #資料所有者所屬群
           tc_jbcmodu=NULL,     #資料修改日期
           tc_jbcdate=g_today,  #資料建立日期
           tc_jbcconf='N',      #审核码
           tc_jbcacti='Y'       #有效資料
           
   INSERT INTO tc_jbc_file SELECT * FROM y
   
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_jbc_file","","",SQLCA.sqlcode,"","",1)  
      LET g_success = 'N'
      ROLLBACK WORK
      RETURN
   END IF

   IF g_success = 'Y' THEN

     UPDATE x SET tc_jbd01=l_newno
     INSERT INTO tc_jbd_file SELECT * FROM x
     IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","tc_jbd_file","","",SQLCA.sqlcode,"","",1)  
       LET g_success = 'N'
       ROLLBACK WORK
       RETURN 
 #   ELSE
 #      LET g_cnt=SQLCA.SQLERRD[3]
 #      MESSAGE '(',g_cnt USING '##&',') ROW of (',l_newno,') O.K'
     END IF
   END IF 
    
   IF g_success = 'Y' THEN
      MESSAGE 'Copy O.K.'
      COMMIT WORK
      LET l_oldno = g_tc_jbc.tc_jbc01
      SELECT tc_jbc_file.* INTO g_tc_jbc.* FROM tc_jbc_file WHERE tc_jbc01 = l_newno
      CALL i012_u("u")
      CALL i012_b()
      CALL i012_b2('0')
   END IF 
      
END FUNCTION

FUNCTION i012_set_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1  
   # Modify.........: By li240416 添加 tc_jbc25 字段
   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
  IF  NOT g_before_input_done THEN 
    CASE  p_cmd 
      WHEN 'a' #append
        CALL cl_set_comp_entry("tc_jbc01,tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,tc_jbc06,tc_jbc07,tc_jbc08
            ,tc_jbc10,tc_jbc12,tc_jbc16,tc_jbc22,tc_jbc18,tc_jbc19,tc_jbc23,tc_jbc24,tc_jbc25,tc_jbc26,tc_jbc27",TRUE)
        CALL cl_set_comp_entry("tc_jbc18",FALSE)
      WHEN 'c' #copy
        CALL cl_set_comp_entry("tc_jbc01",TRUE)
        CALL cl_set_comp_entry("tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,tc_jbc06,tc_jbc07,tc_jbc08,tc_jbc10
            ,tc_jbc12,tc_jbc16,tc_jbc22,tc_jbc18,tc_jbc19,tc_jbc20",FALSE)
      WHEN 'u' #update
        CALL cl_set_comp_entry("tc_jbc01,tc_jbc18",FALSE)
        CALL cl_set_comp_entry("tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,tc_jbc06,tc_jbc07,tc_jbc08,tc_jbc10
            ,tc_jbc12,tc_jbc16,tc_jbc22,tc_jbc19,tc_jbc23,tc_jbc24,tc_jbc25,tc_jbc26,tc_jbc27",TRUE)
      WHEN 's' #status
        CALL cl_set_comp_entry("tc_jbc01,tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,tc_jbc06,tc_jbc07,tc_jbc08
            ,tc_jbc10,tc_jbc12,tc_jbc16,tc_jbc22,tc_jbc19,tc_jbc20,tc_jbc23,tc_jbc24,tc_jbc25,tc_jbc26,tc_jbc27",FALSE)
        CALL cl_set_comp_entry("tc_jbc18",TRUE)
      WHEN 'r' #replace
        CALL cl_set_comp_entry("tc_jbc01,tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,tc_jbc05,tc_jbc06,tc_jbc07,tc_jbc08
            ,tc_jbc10,tc_jbc12, tc_jbc16,tc_jbc22,tc_jbc18,tc_jbc19",FALSE)

        CALL cl_set_comp_entry("tc_jbc20",TRUE)
    END CASE 
  END IF 
    
END FUNCTION

FUNCTION i012_show_pic()   #圖形顯示
     LET g_chr1='N'
     LET g_chr2='N'
     
     IF g_tc_jbc.tc_jbcacti = 'Y' THEN 
         LET g_chr1='Y'
     END IF 
     
     IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
         LET g_chr2='Y'
     END IF 

     CALL cl_set_field_pic(""  ,g_chr2,""  ,""  ,""  ,g_chr1)
                          #確認 ,核准  ,過帳  ,結案 ,作廢 ,有效  ,申請 ,留置
END FUNCTION

FUNCTION i012_list_fill()
DEFINE l_cnt          LIKE type_file.num10
DEFINE l_tc_jbc01     LIKE tc_jbc_file.tc_jbc01

   CALL g_tc_jbc_l.clear()
   CALL g_cnt_ac.clear()
       
   LET l_cnt = 1
   LET g_cnt = 1
   # Modify.........: By li231212     新增栏位: tc_jbc23 模具穴数
   # Modify.........: By li240416 添加 tc_jbc25 字段  
   # Modify.........: By li250522 添加栏位: tc_jbc27建档类型
   # Modify.........: By dmw 添加栏位: tc_jbc28做样员、tc_jbc29做样员姓名
   DECLARE i012_fill_cs1 SCROLL CURSOR FOR
   SELECT tc_jbc01,tc_jbc21,tc_jbc02,tc_jbc03,tc_jbc04,imz02,tc_jbc05,
        #  CONCAT(CONCAT(tc_jbc06,'/'),tc_jbc07),tc_jbc08,tc_jbc10,tc_jbc11,tc_jbc12,
          tc_jbc06||'/'||tc_jbc07,tc_jbc08,tc_jbc10,tc_jbc11,tc_jbc12,
          tc_jbc13,tc_jbc14,tc_jbc15,tc_jbc16,tc_jbc17,tc_jbc22,tc_jbc23, 
          tc_jbc18,tc_jbc24,tc_jbc25,tc_jbc26,tc_jbc27,tc_jbc28,tc_jbc29,#新增做样员、做样员姓名字段 by dmw
          #li240313
          #tc_jbc19,  #Teval 210910
          #tc_jbc20,  #Teval 210910
          tc_jbd02,tc_jbd03,tc_jbd04,tc_jbd05,tc_jbd07,
          tc_jbd06,tc_jbcacti,tc_jbcconf
     FROM tc_jbc_file
     LEFT JOIN tc_jbd_file ON tc_jbd01 = tc_jbc01
     LEFT JOIN imz_file ON tc_jbc04 = imz01
     WHERE tc_jbc01 = ?
   
   FOREACH i012_fill_cs INTO l_tc_jbc01
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach i012_fill_cs',SQLCA.sqlcode,1)
         CONTINUE FOREACH
      END IF
      LET g_cnt_ac[g_cnt].ac = l_cnt
     
       FOREACH i012_fill_cs1 USING l_tc_jbc01 INTO g_tc_jbc_l[l_cnt].*
       
         LET g_cnt_ac[l_cnt].cnt = g_cnt
         LET l_cnt = l_cnt + 1
         
         IF l_cnt > g_max_rec THEN
           IF g_action_choice ="query"  THEN
             CALL cl_err( '',9035, 0 )
           END IF
           EXIT FOREACH
         END IF
         
       END FOREACH
      LET g_cnt = g_cnt + 1 
    END FOREACH
    CALL g_tc_jbc_l.deleteElement(l_cnt)
    LET g_rec_b1 = l_cnt - 1
    DISPLAY g_rec_b1 TO cnt1
    
END FUNCTION



FUNCTION i012_confirm()

  DEFINE l_continue      LIKE type_file.chr1

   LET l_continue = 'Y'
  
   IF (g_tc_jbc.tc_jbc01 IS NULL) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   MESSAGE ""
   
   SELECT tc_jbcacti,tc_jbcconf INTO g_tc_jbc.tc_jbcacti,g_tc_jbc.tc_jbcconf 
    FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
   
   IF g_tc_jbc.tc_jbcacti='N' THEN
      CALL cl_err('','alm1068',0)     #本笔资料无效，不可执行审核
      RETURN
   END IF

   IF g_tc_jbc.tc_jbcconf = 'Y' THEN 
      CALL cl_err('','atm-158',0)     #此笔资料已审核，不可再次审核
      RETURN 
   END IF 
      
   IF g_rec_b IS NULL OR g_rec_b = 0 THEN 
      CALL cl_err('','cfa-015',0)     #无单身资料，不可审核
      RETURN 
   END IF 

   IF NOT cl_confirm('aap-222') THEN 
      RETURN 
   END IF

  LET g_success = 'Y'                               

  BEGIN WORK

   OPEN i012_cl USING g_tc_jbc.tc_jbc01
   IF STATUS THEN
       CALL cl_err("OPEN i012_cl:", STATUS, 1)
       CLOSE i012_cl
       ROLLBACK WORK
       RETURN
   END IF
   
   FETCH i012_cl INTO g_tc_jbc.*
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,1)
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
   
   CALL i012_show()
   LET g_tc_jbc.tc_jbcconf = 'Y'
   
   UPDATE tc_jbc_file
      SET tc_jbcconf=g_tc_jbc.tc_jbcconf
    WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
    
   IF SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1)                                                     
      LET g_success = 'N'    
   ELSE 
      LET g_success = 'Y' 
   END IF

   CLOSE i012_cl

   IF g_success = 'N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF
   
   SELECT * INTO g_tc_jbc.* FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
   
   CALL i012_show()

END FUNCTION

FUNCTION i012_unconfirm()


   IF (g_tc_jbc.tc_jbc01 IS NULL) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   
   MESSAGE ""
   SELECT tc_jbcconf INTO g_tc_jbc.tc_jbcconf FROM tc_jbc_file 
    WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
    
   IF g_tc_jbc.tc_jbcconf='N' THEN   #非審核狀態 不能取消審核
     CALL cl_err('','9025',0)
     RETURN
   END IF 
      
   IF NOT cl_confirm('aap-224') THEN 
     RETURN 
   END IF    

   LET g_success = 'Y'       
   
   BEGIN WORK

   OPEN i012_cl USING g_tc_jbc.tc_jbc01
   IF STATUS THEN
       CALL cl_err("OPEN i012_cl:", STATUS, 1)
       CLOSE i012_cl
       ROLLBACK WORK
       RETURN
   END IF
   
   FETCH i012_cl INTO g_tc_jbc.*
   
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,1)
      CLOSE i012_cl
      ROLLBACK WORK
      RETURN
   END IF
   
   CALL i012_show()
   
   UPDATE tc_jbc_file
      SET  tc_jbcconf='N'
    WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
    
   IF SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","tc_jbc_file",g_tc_jbc.tc_jbc01,"",SQLCA.sqlcode,"","",1)        
      LET g_success = 'N'  
   ELSE 
      LET g_success = 'Y'        
   END IF

   CLOSE i012_cl

   IF g_success = 'N' THEN
     ROLLBACK WORK
   ELSE
     COMMIT WORK
   END IF
   
   SELECT * INTO g_tc_jbc.* FROM tc_jbc_file WHERE tc_jbc01 = g_tc_jbc.tc_jbc01
   
   CALL i012_show()
   
END FUNCTION


FUNCTION i012_mould_position()

   LET g_forupd_sql = "SELECT * FROM tc_jbg_file WHERE tc_jbg01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i012_a_cl CURSOR FROM g_forupd_sql

   OPEN WINDOW i012_a_w WITH FORM "cfa/42f/cfai012_a"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)
         
  # CALL cl_ui_init()
   CALL cl_ui_locale('cfai012_a')

   CALL cl_set_comp_entry("tc_jbguser,tc_jbggrup,tc_jbgmodu,tc_jbgdate",FALSE)
   CALL cl_set_comp_required("tc_jbg02",TRUE)
   
   LET g_action_choice=""
   
   CALL i012_a_menu()
   
   CLOSE WINDOW i012_a_w

   IF INT_FLAG THEN 
     LET INT_FLAG = FALSE 
   END IF 
   
   LET g_action_choice=""
   
END FUNCTION 
 
#QBE 查詢資料
FUNCTION i012_a_cs()

   DEFINE lc_qbe_sn   LIKE gbm_file.gbm01    
 
   CLEAR FORM 
   CALL g_tc_jbg.clear()
   
      CONSTRUCT BY NAME g_wc1 ON tc_jbg01,tc_jbg02,tc_jbg03,tc_jbguser,tc_jbggrup,tc_jbgmodu,tc_jbgdate
                   
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)    #再次顯示查詢條件，因為進入單身後會將原顯示值清空
   
          ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT
    
          ON ACTION about         
             CALL cl_about()      
    
     #    ON ACTION help          
     #       CALL cl_show_help()  
     
          ON ACTION controlg     
            CALL cl_cmdask()     
    
          ON ACTION qbe_save                   # 條件儲存
            CALL cl_qbe_save()
 
      END CONSTRUCT
 
END FUNCTION
 
FUNCTION i012_a_menu()

   WHILE TRUE
   
      CALL i012_a_b_fill(g_wc1)
      CALL i012_a_bp("G")
   
      CASE g_action_choice
 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i012_a_q()
            END IF
            
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i012_a_b()
            ELSE
               LET g_action_choice = NULL
            END IF

         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
            
         WHEN "exporttoexcel"                       #單身匯出最多可匯三個Table資料
            IF cl_chk_act_auth() THEN
              LET w = ui.Window.getCurrent()
              LET page = w.getNode()
              CALL cl_export_to_excel(page,base.TypeInfo.create(g_tc_jbg),'','')
            END IF
 
         WHEN "related_document"                    #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_tc_jbg[l_ac].tc_jbg01 IS NOT NULL THEN
                   LET g_doc.column1 = "tc_jbg01"
                   LET g_doc.value1 = g_tc_jbg[l_ac].tc_jbg01
                   CALL cl_doc()
                 ELSE 
                   CALL cl_err('',-400,0)
                 END IF
              END IF

      END CASE
   END WHILE
   
END FUNCTION
 
FUNCTION i012_a_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1 
   
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
   
   LET g_action_choice = " "
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DISPLAY ARRAY g_tc_jbg TO s_tc_jbg.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
   
      BEFORE DISPLAY
         IF l_ac > 0 THEN 
           CALL fgl_set_arr_curr(l_ac)
         ELSE 
           CALL fgl_set_arr_curr(1)
         END IF 
         
      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                 
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
 
 
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY

      ON ACTION locale                             #畫面上欄位的工具提示轉換語言別
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()       
         LET g_action_choice = 'locale'
         EXIT DISPLAY
         
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
         LET INT_FLAG=FALSE                        #利用單身驅動menu時，cancel代表右上角的"X"
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         
         CALL cl_about()    
 
      ON ACTION exporttoexcel                      #匯出Excel      
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
      AFTER DISPLAY
         CONTINUE DISPLAY

#      ON ACTION controls                          #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭區塊
#         CALL cl_set_head_visible("Page01,Page02","AUTO")

    #  ON ACTION related_document                   #相關文件
    #     LET g_action_choice="related_document"          
    #     EXIT DISPLAY
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION i012_a_bp_refresh()

  DISPLAY ARRAY g_tc_jbg TO s_tc_jbg.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
    BEFORE DISPLAY
    
     EXIT DISPLAY
     
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE DISPLAY
        
  END DISPLAY
 
END FUNCTION 

FUNCTION i012_a_q()
    
   MESSAGE ""   
   CALL cl_opmsg('q')
   CLEAR FORM
   CALL g_tc_jbg.clear()
   DISPLAY ' ' TO FORMONLY.cnt

   CALL i012_a_cs()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL g_tc_jbg.clear()
      CLEAR FORM 
      RETURN
   END IF
   
   CALL i012_a_b_fill(g_wc1)
END FUNCTION
 
#單身
FUNCTION i012_a_b()
  DEFINE          
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT  
    l_n             LIKE type_file.num5,                #檢查重複用  
    l_n1            LIKE type_file.num5,                #檢查重複用 
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住否 
    p_cmd           LIKE type_file.chr1,                #處理狀態                
    l_allow_insert  LIKE type_file.num5,                #可新增否  
    l_allow_delete  LIKE type_file.num5                 #可删除否
    
    
    LET g_action_choice = ""
 
    IF s_shut(0) THEN
       RETURN
    END IF
    
    MESSAGE ""
    
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = "SELECT * FROM tc_jbg_file",
                       "  WHERE tc_jbg01=?",
                       "  FOR UPDATE " 
                       
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i012_a_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
 
    INPUT ARRAY g_tc_jbg WITHOUT DEFAULTS FROM s_tc_jbg.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
           DISPLAY "BEFORE INPUT!"
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF
 
        BEFORE ROW
           DISPLAY "BEFORE ROW!"
           LET p_cmd = ''
           LET l_ac = ARR_CURR()
           LET l_lock_sw = 'N'            #DEFAULT
           LET l_n = ARR_COUNT()     
          
           BEGIN WORK     
           OPEN i012_a_cl USING g_tc_jbg[l_ac].tc_jbg01
           IF STATUS THEN
              CALL cl_err("OPEN i012_a_cl:",STATUS,1)
              CLOSE i012_a_cl
              ROLLBACK WORK
              RETURN
           END IF
 
           IF g_rec_b >= l_ac THEN
              LET p_cmd = 'u'
              
              SELECT COUNT(tc_jbc10) INTO l_n1 FROM tc_jbc_file
               WHERE tc_jbc10 = g_tc_jbg[l_ac].tc_jbg01

              IF l_n1 > 0 THEN 
                CALL cl_set_comp_entry("tc_jbg01",FALSE)
              ELSE 
                CALL cl_set_comp_entry("tc_jbg01",TRUE)
              END IF 
              
              LET g_tc_jbg_t.* = g_tc_jbg[l_ac].*       #BACKUP
              OPEN i012_a_bcl USING g_tc_jbg_t.tc_jbg01
              IF STATUS THEN
                 CALL cl_err("OPEN i012_a_bcl:",STATUS,1)
                 LET l_lock_sw = "Y"
              ELSE
                 FETCH i012_a_bcl INTO g_tc_jbg[l_ac].*
                 IF SQLCA.sqlcode THEN
                    CALL cl_err(g_tc_jbg_t.tc_jbg01,SQLCA.sqlcode,1)
                    LET l_lock_sw = "Y"
                 END IF
              END IF     

              CALL cl_show_fld_cont() 
           END IF 
 
        BEFORE INSERT
           DISPLAY "BEFORE INSERT!"
           LET l_n = ARR_COUNT()
           LET p_cmd='a'
           CALL cl_set_comp_entry("tc_jbg01",TRUE)
           LET g_tc_jbg_t.* = g_tc_jbg[l_ac].*         #新輸入資料
           LET g_tc_jbg[l_ac].tc_jbg01 = NULL
           LET g_tc_jbg[l_ac].tc_jbg02 = NULL 
           LET g_tc_jbg[l_ac].tc_jbg03 = NULL    
           LET g_tc_jbg[l_ac].tc_jbguser = g_user 
           LET g_tc_jbg[l_ac].tc_jbggrup = g_grup
           LET g_tc_jbg[l_ac].tc_jbgmodu = NULL   
           LET g_tc_jbg[l_ac].tc_jbgdate = g_today     
           CALL cl_show_fld_cont()
           NEXT FIELD tc_jbg01
 
        AFTER INSERT
           DISPLAY "AFTER INSERT!"
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              CANCEL INSERT
           END IF

           INSERT INTO tc_jbg_file(tc_jbg01,
                                   tc_jbg02,
                                   tc_jbg03,
                                   tc_jbguser,
                                   tc_jbggrup,
                                   tc_jbgmodu,
                                   tc_jbgdate) 
                            VALUES(g_tc_jbg[l_ac].tc_jbg01,
                                   g_tc_jbg[l_ac].tc_jbg02,
                                   g_tc_jbg[l_ac].tc_jbg03,
                                   g_tc_jbg[l_ac].tc_jbguser,
                                   g_tc_jbg[l_ac].tc_jbggrup,
                                   g_tc_jbg[l_ac].tc_jbgmodu,
                                   g_tc_jbg[l_ac].tc_jbgdate) 
           IF SQLCA.sqlcode THEN
              CALL cl_err3("ins","tc_jbg_file",g_tc_jbg[l_ac].tc_jbg01,g_tc_jbg[l_ac].tc_jbg01,SQLCA.sqlcode,"","",1)  
              CANCEL INSERT
           ELSE
              COMMIT WORK
              MESSAGE 'Insert O.K.'
              LET g_rec_b=g_rec_b+1
              DISPLAY g_rec_b TO FORMONLY.cn2
           END IF
        
        AFTER FIELD tc_jbg01                        #check 码别是否重複
           IF cl_null(g_tc_jbg[l_ac].tc_jbg01) THEN 
             CALL cl_err('','alm-917',0)     #此字段不可为空
             NEXT FIELD tc_jbg01
           ELSE 
             IF (g_tc_jbg[l_ac].tc_jbg01 != g_tc_jbg_t.tc_jbg01 
             OR cl_null(g_tc_jbg_t.tc_jbg01)) THEN
                 LET g_tc_jbg[l_ac].tc_jbg01 = cl_replace_str(g_tc_jbg[l_ac].tc_jbg01," ",NULL)
                 DISPLAY BY NAME g_tc_jbg[l_ac].tc_jbg01
                 SELECT count(*) INTO l_n FROM tc_jbg_file
                  WHERE tc_jbg01 = g_tc_jbg[l_ac].tc_jbg01
                 IF l_n > 0 THEN
                    CALL cl_err('',-239,0)
                    LET g_tc_jbg[l_ac].tc_jbg01 = g_tc_jbg_t.tc_jbg01
                    NEXT FIELD tc_jbg01
                 END IF
             END IF
           END IF 
           
        BEFORE DELETE                       #是否取消單身
           DISPLAY "BEFORE DELETE"
           IF g_tc_jbg_t.tc_jbg01 IS NOT NULL THEN
              
              SELECT COUNT(tc_jbc10) INTO l_n1 FROM tc_jbc_file
               WHERE tc_jbc10 = g_tc_jbg[l_ac].tc_jbg01

              IF l_n1 > 0 THEN 
                CALL cl_err('','cfa-113',0)
                CANCEL DELETE 
              END IF 
               
              IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
              END IF
              IF l_lock_sw = "Y" THEN
                 CALL cl_err("", -263, 1)
                 CANCEL DELETE
              END IF
              DELETE FROM tc_jbg_file
               WHERE tc_jbg01 = g_tc_jbg_t.tc_jbg01
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","tc_jbg_file","",g_tc_jbg_t.tc_jbg01,SQLCA.sqlcode,"","",1)  
                 ROLLBACK WORK
                 CANCEL DELETE
              END IF
              LET g_rec_b=g_rec_b-1
              DISPLAY g_rec_b TO FORMONLY.cnt
              COMMIT WORK
              MESSAGE 'Delete O.K.'
           END IF
 
        ON ROW CHANGE
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              LET g_tc_jbg[l_ac].* = g_tc_jbg_t.*
              CLOSE i012_a_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF
           
           IF l_lock_sw = 'Y' THEN
              CALL cl_err(g_tc_jbg[l_ac].tc_jbg01,'-263',1)
              LET g_tc_jbg[l_ac].* = g_tc_jbg_t.*
           ELSE
              UPDATE tc_jbg_file SET tc_jbg01=g_tc_jbg[l_ac].tc_jbg01,
                                     tc_jbg02=g_tc_jbg[l_ac].tc_jbg02,
                                     tc_jbg03=g_tc_jbg[l_ac].tc_jbg03,
                                     tc_jbgmodu=g_user
                WHERE tc_jbg01=g_tc_jbg_t.tc_jbg01
                
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_jbg_file","",g_tc_jbg_t.tc_jbg01,SQLCA.sqlcode,"","",1) 
                   LET g_tc_jbg[l_ac].* = g_tc_jbg_t.*
                   ROLLBACK WORK 
               ELSE
                  COMMIT WORK
                  MESSAGE 'Update O.K.'
               END IF
           END IF 
 
        AFTER ROW
           DISPLAY  "AFTER ROW!!"
           LET l_ac = ARR_CURR()
         #  LET l_ac_t = l_ac       
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              IF p_cmd = 'u' THEN
                 LET g_tc_jbg[l_ac].* = g_tc_jbg_t.*
              ELSE
                 CALL g_tc_jbg.deleteElement(l_ac)
                 IF g_rec_b != 0 THEN
                    LET g_action_choice = "detail"
                    LET l_ac = l_ac_t
                 END IF
              END IF
              CLOSE i012_a_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF
           LET l_ac_t = l_ac    
           CLOSE i012_a_bcl
 
       ON ACTION CONTROLO                        
           IF INFIELD(tc_jbg01) AND l_ac > 1 THEN
              LET g_tc_jbg[l_ac].* = g_tc_jbg[l_ac-1].*
              NEXT FIELD tc_jbg01
           END IF
 
       ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
       ON ACTION CONTROLG
           CALL cl_cmdask()  
           
       ON ACTION CONTROLF
           CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
           CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
       ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT
 
       ON ACTION about         
           CALL cl_about()     
 
    END INPUT
    
    CLOSE i012_a_bcl
    COMMIT WORK
    CALL i012_a_b_fill('1=1')             #单身修改完成后呼叫b_fill()，用以刷新单身的条件格式
END FUNCTION


FUNCTION i012_a_b_fill(p_wc)

DEFINE p_wc   STRING
 
   IF p_wc IS NULL THEN 
     LET g_sql = "SELECT * ",
                 " FROM tc_jbg_file",
                 " ORDER BY tc_jbg01 "
   ELSE 
     LET g_sql = "SELECT * ",
                 " FROM tc_jbg_file",
                 "  WHERE ",p_wc,
                 " ORDER BY tc_jbg01 "
   END IF 

   DISPLAY g_sql
 
   PREPARE i012_a_pb FROM g_sql
   DECLARE tc_jbg_cs CURSOR FOR i012_a_pb
 
   CALL g_tc_jbg.clear()
   
   LET g_cnt = 1
 
   FOREACH tc_jbg_cs INTO g_tc_jbg[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
       
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_tc_jbg.deleteElement(g_cnt)         #删除最后新增的空白列
   LET g_rec_b=g_cnt-1
   
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET g_cnt = 0
 
END FUNCTION


FUNCTION i012_msg(p_tit,p_msg,p_ico)

   DEFINE p_tit,p_msg,p_ico   STRING

      MENU p_tit 
         ATTRIBUTES(STYLE = "dialog",
                    COMMENT = p_msg,
                    IMAGE = IIF(p_ico="info","information",p_ico))

         COMMAND "确定"
            EXIT MENU

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE MENU

         ON ACTION CLOSE
            LET INT_FLAG = FALSE
            EXIT MENU 

      END MENU

END FUNCTION


FUNCTION i012_combobox(p_cobo, p_item_code, p_text_code)

   DEFINE p_cobo        LIKE ze_file.ze03
   DEFINE p_item_code   LIKE ze_file.ze01
   DEFINE p_text_code   LIKE ze_file.ze01
   DEFINE tok_item      base.StringTokenizer
   DEFINE tok_text      base.StringTokenizer
   DEFINE cb            ui.ComboBox

      LET cb = ui.ComboBox.forName(p_cobo)
      LET tok_item = base.StringTokenizer.create(cl_getmsg(p_item_code,g_lang),',')
      LET tok_text = base.StringTokenizer.create(cl_getmsg(p_text_code,g_lang),',')

      WHILE tok_item.hasMoreTokens() AND tok_text.hasMoreTokens()
         CALL cb.addItem(tok_item.nextToken(),tok_text.nextToken())
      END WHILE

END FUNCTION 
