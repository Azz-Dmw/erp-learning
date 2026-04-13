# Prog. Version..: '5.30.15-14.10.14(00000)'     #
#
# Pattern name...: asft705.4gl
# Descriptions...: 單元報工維護作業
# Date & Author..: 08/01/24 By ve007      #No.FUN-810016 
# Modify.........: No.FUN-830088 08/04/01 By hongmei sgdslk01-->sgd14 將行業別字段修改為一般行業字段
# Modify.........: No.FUN-840178 08/04/23 By ve007  debug 810016
# Modify.........: No.FUN-870117 08/08/12 by ve007 刪除自動帶飛票功能
# Modify.........: No.FUN-8A0142 08/10/30 by hongmei g_t1 chr3-->chr5
# Modify.........: No.FUN-8A0151 08/11/01 By Carrier 單身自動生成后,做fill
# Modify.........: No.FUN-8B0123 08/12/01 By hongmei 修改單身顯示問題
# Modify.........: No.FUN-910082 09/02/02 By ve007 wc,sql 定義為STRING
# Modify.........: No.TQC-940183 09/04/30 By Carrier rowid定義規範化
# Modify.........: No.TQC-940121 09/05/08 By mike 畫面中不存在l_sgk01欄位    
# Modify.........: No.TQC-940173 09/05/11 By mike 資料無效后立即顯示圖章  
# Modify.........: No.FUN-980008 09/08/14 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.TQC-9A0130 09/10/26 By liuxqa 修改ROWID. 
# Modify.........: No.FUN-9C0072 10/01/12 By vealxu 精簡程式碼
# Modify.........: No.FUN-A60027 10/06/24 By huangtao 製造功能優化-平行制程（批量修改）
# Modify.........: No.FUN-A60076 10/06/28 By huangtao 製造功能優化-平行制程（批量修改）
# Modify.........: No.FUN-A70131 10/07/29 By destiny 工序为空应插0
# Modify.........: No.FUN-AA0059 10/10/26 By chenying 料號開窗控管 
# Modify.........: No.FUN-B50064 11/06/02 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No:FUN-B80086 11/08/09 By Lujh 模組程序撰寫規範修正
# Modify.........: No:FUN-BB0086 11/12/08 By tanxc 增加數量欄位小數取位
# Modify.........: No:FUN-C20068 12/02/14 By fengrui 數量欄位小數取位處理
# Modify.........: NO.TQC-C50082 12/05/10 By fengrui 把必要字段controlz換成controlr
# Modify.........: No.CHI-C30002 12/05/24 By yuhuabao 離開單身時若單身無資料提示是否刪除單頭資料
# Modify.........: No.CHI-C30107 12/06/12 By yuhuabao  整批修改將確認的詢問窗口放到chk段的前面
# Modify.........: No:FUN-C80046 12/08/20 By bart 複製後停在新資料畫面
# Modify.........: No:CHI-C80041 12/12/28 By bart 1.增加作廢功能 2.刪除單頭
# Modify.........: No:CHI-D20010 13/02/21 By yangtt 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No:FUN-D40030 13/04/08 By xumm 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: By Star151123 增加sgl012平行制程段号，属于系统BUG 
# Modify.........: By hwj151201  增加ta_sgl01-ta_sgl18所有字段的相关功能
# Modify.........: By Hao160422 修改理论标准工时和实际标准工时
# Modify.........: By Hao160422 查询时在单头资料处若放弃查询则不进入单身
# Modify.........: By Hao160422 录入时默认实际标准工时为理论标准工时
# Modify.........: By Hao160422 添加类型、估算金额、不良品数量、超基准不良数、绩效达成率、不良倍数
# Modify.........: By Hao160425 复制时报工单号可自动编码
# Modify.........: By Hao160716 修改工艺编号的开窗，去除工艺编号备注的取值
# Modify.........: By Hao160818 管控类型(ta_sgk01)为必输字段
# Modify.........: By Hao170419 修改员工取值来源于人事资料档
# Modify.........: By Hao170525 添加controlo复制单身
# Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
# Modify.........: By Hao170606 添加字段员工姓名ta_sgl25替换gen02
# Modify.........: By Hao170606 设定sgl07不可输入，由sgl06开窗获取
# Modify.........: By Hao170607 添加字段进厂日期ta_sgl26
# Modify.........: By Hao170613 针对于无工单号的工时输入
# Modify.........: By Wang170620 添加资料清单
# Modify.........: By Hao170704 添加ACTION可以在审核后修改单身资料
# Modify.........: By Hao170725 获取工单的工艺编号
# Modify.........: By Hao170823 设定170825之后金额设定为分
# Modify.........: By Wang170908 资料清单添加部门字段
# Modify.........: By Wang171013 资料清单添加单头备注字段
# Modify.........: By Hao171101 设定超基准数的管控,自动计算良品完成数及不良数量
# Modify.........: By Hao171201 添加工时备注字段ta_sgl27
# Modify.........: By Hao171214 添加工艺备注字段ta_sgl28
# Modify.........: By Hao180113 资料清单中添加工艺备注
# Modify.........: By Teval 180322 单身添加字段：类型（ta_sgl29），单头添加类型提示 
# Modify.........: By Teval 180508 资料清单添加字段：类型（ta_sgl29）
# Modify.........: By Hao180522 复制时因在输入日期后就取单据编号可能导致产生的单据编号有误，故修改为获取编号在输入字段完成后 
# Modify.........: By Teval 180719 添加两个字段：【机台数】、【机台补贴】
# Modify.........: By Teval 190218 1.添加管控：每道工序累计报工数量，不可超过工单工艺数量
# Modify.........: By Teval 190218 2.预设单别：356
# Modify.........: By Teval 190220 部分加工中心(K06,K07,K10,K11,K13,K14,W04,W06,W08)，不需要判断报工数量不可大于工单生产数量
# Modify.........: By Teval 190221 部分加工中心(K08,W05)，不需要判断报工数量不可大于工单生产数量
# Modify.........: By Teval 190308 添加功能按钮【工时分配】：开窗后，带出某员工所有已录资料，根据生产数量平均分配工时
# Modify.........: By Teval 190313 1.工时保留两位小数;2.新增时，生产总数预设为指定工单、工序、工艺、作业的剩余报工数量
# Modify.........: By Hao200417 资料清单中添加"良品完成数量","不良数量","报废数量"
# Modify.........: By Hao200807 修改CNC机台补贴标准
# Modify.........: By Hao210120 添加机台项目
# Modify.........: By Hao210422 添加机台号
# Modify.........: By Hao210429 添加班别[0:早班  1:晚班]
# Modify.........: By Hao220727 添加字段[固定财产编号]和[设备故障时间]
# Modify.........: By Hao220916 添加待料工时便于统计OEE资料
# Modify.........: By Hao230629 应生产部需求修改激励积分计算公式
# Modify.........: By Hao230728 应CNC要求修改机台补贴公式，
#                               原：正常工时*基准
#                               现：上下料基数设定时间(秒)/(实际标准工时*一模多片生产个数)*每台机基准设定*正常工时(H)
#                               如：开2台机：120/(50*4)*0.45*11=2.97
# Modify.........: By li241106 资料清单添加估算积分和进厂日期
# Modify.........: By mo241111 审核后修改实际开工日期(sfb25)为报工日期
# Modify.........: By li251120 添加项次和职位栏位

DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
 
DEFINE g_sgk01_t  LIKE sgk_file.sgk01,
       g_sgk      RECORD LIKE sgk_file.*,
       g_sgk_t    RECORD LIKE sgk_file.*

TYPE sgl          RECORD
       sgl02 LIKE sgl_file.sgl02,
       sgl03 LIKE sgl_file.sgl03,
       sgl04 LIKE sgl_file.sgl04,
       sgl05 LIKE sgl_file.sgl05,
       ima02 LIKE ima_file.ima02,
       ta_sgl06 LIKE sgl_file.ta_sgl06,  #工艺编号
       ta_sgl07 LIKE sgl_file.ta_sgl07,  #工艺编号备注
       ta_sgl18 LIKE sgl_file.ta_sgl18,  #工作站
       sgl012 LIKE sgl_file.sgl012,      #FUN-A60027 add by  huangtao
       sgl06 LIKE sgl_file.sgl06,
       sgl07 LIKE sgl_file.sgl07,
       sga02 LIKE sga_file.sga02,
       ta_sgl28 LIKE sgl_file.ta_sgl28,  # Modify By Hao171214 添加工艺备注字段ta_sgl28
       ta_sgl27 LIKE sgl_file.ta_sgl27,  # Modify By Hao171201 添加工时备注字段ta_sgl27
       ta_sgl29 LIKE sgl_file.ta_sgl29,  # Add By Teval 180322
       ta_sgl33 LIKE sgl_file.ta_sgl33,  # By Hao210422
       ta_sgl34 LIKE sgl_file.ta_sgl34,
       ta_sgl35 LIKE sgl_file.ta_sgl35,
       ta_sgl36 LIKE sgl_file.ta_sgl36,
       ta_sgl32 LIKE sgl_file.ta_sgl32,  # By Hao210120
       ta_sgl19 LIKE sgl_file.ta_sgl19,  #Modify By Hao160422 添加估算金额
       #sgl11 LIKE sgl_file.sgl11,
       #ta_sgl01 LIKE sgl_file.ta_sgl01,  #异常工时
       #ta_sgl02 LIKE sgl_file.ta_sgl02,  #正常工时
       #ta_sgl03 LIKE sgl_file.ta_sgl03,  #理论工时
       #ta_sgl04 LIKE sgl_file.ta_sgl04,  #实际工时
       sgl11    DECIMAL(10,2),           #Mod By Teval 190313
       ta_sgl01 DECIMAL(10,2),           #Mod By Teval 190313
       ta_sgl02 DECIMAL(10,2),           #Mod By Teval 190313
       ta_sgl03 DECIMAL(10,2),           #Mod By Teval 190313
       ta_sgl04 DECIMAL(10,2),           #Mod By Teval 190313
       ta_sgl05 LIKE sgl_file.ta_sgl05,  #生产总数
       sgl08 LIKE sgl_file.sgl08,
       ta_sgl20 LIKE sgl_file.ta_sgl20,  #Modify By Hao160422 添加不良品数量
       sgl09 LIKE sgl_file.sgl09,
       sgl10 LIKE sgl_file.sgl10,        
       ta_sgl08 LIKE sgl_file.ta_sgl08,  #不良率
       ta_sgl09 LIKE sgl_file.ta_sgl09,  #基准
       ta_sgl10 LIKE sgl_file.ta_sgl10,  #应完成数量
       ta_sgl11 LIKE sgl_file.ta_sgl11,  #奖惩单价
       ta_sgl12 LIKE sgl_file.ta_sgl12,  #超基准数
       ta_sgl21 LIKE sgl_file.ta_sgl21,  #Modify By Hao160422 添加超基准不良数
       ta_sgl23 LIKE sgl_file.ta_sgl23,  #Modify By Hao160422 添加不良倍数
       ta_sgl13 LIKE sgl_file.ta_sgl13,  #奖/赔金额
       ta_sgl30 LIKE sgl_file.ta_sgl30,  #Add By Teval 180719
       ta_sgl37 LIKE sgl_file.ta_sgl37,  # Modify.........: By Hao230728
       ta_sgl31 LIKE sgl_file.ta_sgl31,  #Add By Teval 180719
       ta_sgl14 LIKE sgl_file.ta_sgl14,  #低于基准数
       sgl12 LIKE sgl_file.sgl12,
#       gen02 LIKE gen_file.gen02,
       ta_sgl25 LIKE sgl_file.ta_sgl25, # Modify By Hao170606 添加字段员工姓名ta_sgl25替换gen02
       ta_sgl16 LIKE sgl_file.ta_sgl16, #职位
       ta_sgl24 LIKE sgl_file.ta_sgl24, # Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
       ta_sgl26 LIKE sgl_file.ta_sgl26, # Modify By Hao170607 添加字段进厂日期ta_sgl26
       ta_sgl17 LIKE sgl_file.ta_sgl17, #达成率基准
       ta_sgl22 LIKE sgl_file.ta_sgl22, #Modify By Hao160422 添加绩效达成率
       sgl13 LIKE sgl_file.sgl13
                  END RECORD

DEFINE   g_sgl_t        sgl,
         g_sgl        DYNAMIC array OF sgl,
         g_sgl_l      DYNAMIC ARRAY OF RECORD  #程式變數(Program Variables)
            sgk01_l        LIKE   sgk_file.sgk01,    #报工单号
            sgl02_l        LIKE   sgl_file.sgl02,    # Modify.........: By li251120 添加项次和职位栏位
            sgk02_l        LIKE   sgk_file.sgk02,    #报工日期
            ta_sgk03_l     LIKE   sgk_file.ta_sgk03,
            sgl04_l        LIKE   sgl_file.sgl04,    #工单编号
            sgl05_l        LIKE   sgl_file.sgl05,    #产品料号
            ta_sgl18_l     LIKE   sgl_file.ta_sgl18, #工作站和备注
            eca02_l        LIKE   eca_file.eca02,
            sgl07_l        LIKE   sgl_file.sgl07,    #作业单元编号
            sga02_l        LIKE   sga_file.sga02,    #单元名称
            ta_sgl28_l     LIKE   sgl_file.ta_sgl28, # Modify By Hao180113 资料清单中添加工艺备注
            ta_sgl27_l     LIKE   sgl_file.ta_sgl27, # Modify By Hao180113 资料清单中添加工艺备注
            ta_sgl29_l     LIKE   sgl_file.ta_sgl29, #Add By Teval 180508
            ta_sgl33_l     LIKE   sgl_file.ta_sgl33,
            ta_sgl34_l     LIKE   sgl_file.ta_sgl34,
            ta_sgl35_l     LIKE   sgl_file.ta_sgl35,
            ta_sgl36_l     LIKE   sgl_file.ta_sgl36,
            ta_sgl32_l     LIKE   sgl_file.ta_sgl32, # By Hao210120
            ta_sgl19_l     LIKE   sgl_file.ta_sgl19,    #估算积分 # Modify.........: By li241106 资料清单添加估算积分和进厂日期
            sgl11_l        LIKE   sgl_file.sgl11,    #总工时
            ta_sgl01_l     LIKE   sgl_file.ta_sgl01, #异常工时 #Add By Wang 171109 添加异常工时字段
            ta_sgl04_l     LIKE   sgl_file.ta_sgl04, #实际标准工时
            ta_sgl05_l     LIKE   sgl_file.ta_sgl05, #生产总数
            sgl08_l        LIKE   sgl_file.sgl08,    #良品完成数量
            ta_sgl20_l     LIKE   sgl_file.ta_sgl20, #不良数量
            sgl09          LIKE   sgl_file.sgl09,    #报废数量  #By Hao200417
            ta_sgl22_l     LIKE   sgl_file.ta_sgl22, #绩效达成率
            ta_sgl13_l     LIKE   sgl_file.ta_sgl13, #奖/赔金额
            ta_sgl30_l     LIKE   sgl_file.ta_sgl30,   #Add By Teval 180719
            ta_sgl37_l     LIKE   sgl_file.ta_sgl37, # Modify.........: By Hao230728
            ta_sgl31_l     LIKE   sgl_file.ta_sgl31,   #Add By Teval 180719
            sgl12_l        LIKE   sgl_file.sgl12,    #员工编号  
            ta_sgl25_l     LIKE   sgl_file.ta_sgl25, #员工姓名
            ta_sgl16_l     LIKE   sgl_file.ta_sgl16, # Modify.........: By li251120 添加项次和职位栏位
            ta_sgl24_l     LIKE   sgl_file.ta_sgl24, #员工部门 #Add By Wang170908 
            ta_sgl26_l     LIKE   sgl_file.ta_sgl26, #进厂日期 # Modify.........: By li241106 资料清单添加估算积分和进厂日期
            sgk04          LIKE   sgk_file.sgk04,    #Mod By Wang171013 资料清单添加单头备注字段
            sgl13_l        LIKE   sgl_file.sgl13     #备注
                   END RECORD,
   g_wc,g_sql,g_wc2  STRING,
   g_wc3             STRING,
   g_rec_b           LIKE type_file.num5,     #單身筆數   
   g_rec_b1          LIKE type_file.num5,     #Add By Wang170620 资料清单笔数
   l_ac              LIKE type_file.num5,     #目前處理的ARRAY CNT
   l_ac1             LIKE type_file.num5      #Add By Wang170620 资料清单ARRAY CNT
DEFINE g_forupd_sql  STRING                   #SELECT ... FOR UPDATE  SQL
DEFINE g_before_input_done  LIKE type_file.num5
DEFINE   g_cnt           LIKE type_file.num10
DEFINE   g_i             LIKE type_file.num5
DEFINE   g_t1            LIKE type_file.chr5     #No.FUN-8A0142
DEFINE   g_msg           LIKE type_file.chr1000
DEFINE   g_row_count     LIKE type_file.num10
DEFINE   g_curs_index    LIKE type_file.num10
DEFINE   g_curs_index1    LIKE type_file.num10   #Add By Wang170620 资料清单返回主画面，恢复上下笔的功能
DEFINE   g_jump          LIKE type_file.num10
DEFINE   g_no_ask        LIKE type_file.num5
DEFINE   g_delete        LIKE type_file.chr1
DEFINE   g_chr           STRING
DEFINE   g_sgl10_t       LIKE sgl_file.sgl10   #No.FUN-BB0086
DEFINE   w               ui.Window             #Add By Wang170620 用于资料清单汇出Excel
DEFINE   f               ui.Form               #Add By Wang170620 用于资料清单汇出Excel
DEFINE   PAGE            om.DomNode            #Add By Wang170620 用于资料清单汇出Excel
DEFINE g_action_flag     LIKE type_file.chr10  #Add By Wang1706120 判断主画面与资料清单之间切换用
DEFINE g_chr1            LIKE   type_file.chr1 # Modify By Hao170704 添加ACTION可以在审核后修改单身资料 
DEFINE l_uph LIKE type_file.num15_3    # ADD.........: By dmw20260413 变量

DEFINE  g_cnt_ac    DYNAMIC ARRAY OF RECORD            #Add By Wang170908 用于资料清单与主画面资料对应
                ac         LIKE type_file.num10,       #主画面对应清单第几笔
                cnt        LIKE type_file.num10        #清单对应主画面第几笔
                END RECORD

DEFINE g_dummy   STRING #Add By Teval 180322


DEFINE l_a_ac     LIKE type_file.num10
DEFINE g_a_rec_b  LIKE type_file.num10
DEFINE g_a_sum    RECORD
         sgl11_sum      LIKE sgl_file.sgl11,
         ta_sgl01_sum   LIKE sgl_file.ta_sgl01
                  END RECORD
DEFINE g_a_header RECORD      #单头
         sgl12       LIKE sgl_file.sgl12,    #工号
         ta_sgl16    LIKE sgl_file.ta_sgl16, #职位
         ta_sgl24    LIKE sgl_file.ta_sgl24, #部门
         ta_sgl26    LIKE sgl_file.ta_sgl26  #进厂日期
                  END RECORD

DEFINE g_a_body   DYNAMIC ARRAY OF RECORD
         sel         LIKE type_file.chr1,
         sgl02       LIKE sgl_file.sgl02,
         sgl04       LIKE sgl_file.sgl04,
         sgl05       LIKE sgl_file.sgl05,
         sgl05_ima02 LIKE ima_file.ima02,
         ta_sgl06    LIKE sgl_file.ta_sgl06,
         ta_sgl18    LIKE sgl_file.ta_sgl18,
         sgl012      LIKE sgl_file.sgl012,
         sgl06       LIKE sgl_file.sgl06,
         sgl07       LIKE sgl_file.sgl07,
         sga02       LIKE sga_file.sga02,
         ta_sgl28    LIKE sgl_file.ta_sgl28,
         ta_sgl27    LIKE sgl_file.ta_sgl27,
         ta_sgl29    LIKE sgl_file.ta_sgl29,
         ta_sgl19    LIKE sgl_file.ta_sgl19,
         #sgl11       LIKE sgl_file.sgl11,
         #ta_sgl01    LIKE sgl_file.ta_sgl01,
         #ta_sgl02    LIKE sgl_file.ta_sgl02,
         #ta_sgl03    LIKE sgl_file.ta_sgl03,
         #ta_sgl04    LIKE sgl_file.ta_sgl04,
         sgl11       DECIMAL(10,2),           #Mod By Teval 190313
         ta_sgl01    DECIMAL(10,2),           #Mod By Teval 190313
         ta_sgl02    DECIMAL(10,2),           #Mod By Teval 190313
         ta_sgl03    DECIMAL(10,2),           #Mod By Teval 190313
         ta_sgl04    DECIMAL(10,2),           #Mod By Teval 190313
         ta_sgl05    LIKE sgl_file.ta_sgl05,
         sgl08       LIKE sgl_file.sgl08,
         ta_sgl20    LIKE sgl_file.ta_sgl28,
         sgl09       LIKE sgl_file.sgl09
                  END RECORD

MAIN
      OPTIONS
         INPUT NO WRAP,
         FIELD ORDER FORM

      DEFER INTERRUPT

      IF (NOT cl_user()) THEN
         EXIT PROGRAM
      END IF
                                                                        
      WHENEVER ERROR CALL cl_err_msg_log

      IF (NOT cl_setup("CSF")) THEN
         EXIT PROGRAM
      END IF
 
      CALL  cl_used(g_prog,g_time,1) RETURNING g_time

      CALL t705_cur()  #Add By Teval 190218
 
      OPEN WINDOW t705_w WITH FORM "csf/42f/asft705"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)
    
      CALL cl_set_comp_visible("sgk05,sgk06",FALSE)
                                                                         
      CALL cl_ui_init()
      CALL cl_set_comp_visible("sgl012",g_sma.sma541 = 'Y')  # FUN-A60027 add bu huangtao
      CALL cl_set_comp_required("sgl12,ta_sgl29",TRUE)    #Add By Teval 180322
      LET g_dummy = cl_replace_str(cl_getmsg('csf-020',g_lang),',','\n          ') #Add By Teval 180322
      # DISPLAY g_dummy TO dummy1 #Add By Teval 180322
      CALL t705_menu()
                                                                                
      CLOSE WINDOW t705_w

      CALL cl_used(g_prog,g_time,2) RETURNING g_time

END MAIN


FUNCTION t705_cur()  #Add By Teval 190218 定义将会多次调用的游标
 
      LET g_forupd_sql = "SELECT * FROM sgk_file WHERE sgk01 = ?  FOR UPDATE "
      LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
      DECLARE t705_crl CURSOR FROM g_forupd_sql

      DECLARE t705_sfb08_chk_cs CURSOR FOR
         SELECT nvl(sfb08,0),nvl(SUM(ta_sgl05),0)
           FROM sfb_file
      LEFT JOIN sgl_file ON sgl04 = sfb01
                        AND sgl06 = ?
                        AND (sgl07 = ' ' 
                             OR sgl07 = ?)
                        AND sgl012 = ?
                        AND ta_sgl06 = ?
          WHERE sfb01 = ?
       GROUP BY sfb01,sgl04,sgl06,sgl07,sgl012,sfb08

      DECLARE t705_current_ta_sgl05_cs CURSOR FOR
         SELECT nvl((SELECT ta_sgl05 FROM sgl_file
          WHERE sgl01 = ?        #报工单号
            AND sgl02 = ?        #单身项次
            AND sgl04 = ?        #工单号
            AND sgl06 = ?        #工序
            AND (sgl07 = ' ' 
                 OR sgl07 = ?)   #作业编号
            AND sgl012 = ?       #工艺段号
            AND ta_sgl06 = ?),0) #工艺编号
           FROM dual

      DECLARE t705_a_combo_cs CURSOR FOR
         SELECT DISTINCT sgl12,ta_sgl25
           FROM sgl_file
          WHERE sgl01 = ?
          ORDER BY sgl12

      DECLARE t705_a_header_cs CURSOR FOR
         SELECT DISTINCT ta_sgl16,ta_sgl24,ta_sgl26
           FROM sgl_file
          WHERE sgl01 = ? 
            AND sgl12 = ?

      DECLARE t705_a_sgk07_cs CURSOR FOR
         SELECT sgk07 FROM sgk_file WHERE sgk01 = ?

END FUNCTION


FUNCTION t705_sfb08_chk() #Add By Teval 190218 用于检查累计生产总数是否超过在指定工单、工艺序号、工艺段号时，工单的生产数量

   DEFINE l_05_cur   LIKE sgl_file.ta_sgl05  #当前行的生产总数
   DEFINE l_05       LIKE sgl_file.ta_sgl05  #累计报工的生产总数
   DEFINE l_08       LIKE sfb_file.sfb08     #指定工单的生产数量
   DEFINE l_max      LIKE type_file.num10    #累计生产总数可用的最大值

      IF l_ac > 0 THEN
      ELSE
         RETURN TRUE
      END IF

      #Add By Teval 190220 部分加工中心(K06,K07,K10,K11,K13,K14,W04,W06,W08)，不需要判断报工数量不可大于工单生产数量
      #Mod By Teval 190221 部分加工中心(K08,W05)，不需要判断报工数量不可大于工单生产数量
      CASE g_sgl[l_ac].ta_sgl18
         WHEN 'K06'
            RETURN TRUE
         WHEN 'K07'
            RETURN TRUE
         WHEN 'K08'     #Add By Teval 190221
            RETURN TRUE
         WHEN 'K10'
            RETURN TRUE 
         WHEN 'K11'
            RETURN TRUE 
         WHEN 'K13'
            RETURN TRUE 
         WHEN 'K14'
            RETURN TRUE 
         WHEN 'W04'
            RETURN TRUE
         WHEN 'W05'     #Add By Teval 190221
            RETURN TRUE 
         WHEN 'W06'
            RETURN TRUE 
         WHEN 'W08'
            RETURN TRUE 
      END CASE

      IF  NOT cl_null(g_sgl[l_ac].sgl04)
      AND NOT cl_null(g_sgl[l_ac].sgl06)
     #AND NOT cl_null(g_sgl[l_ac].sgl07)  #此字段非必要
      AND NOT cl_null(g_sgl[l_ac].sgl012)
      AND NOT cl_null(g_sgl[l_ac].ta_sgl06)
      THEN
         OPEN t705_current_ta_sgl05_cs USING g_sgk.sgk01,g_sgl_t.sgl02,
                                             g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl06,
                                             g_sgl[l_ac].sgl07,g_sgl[l_ac].sgl012,
                                             g_sgl[l_ac].ta_sgl06
         FETCH t705_current_ta_sgl05_cs INTO l_05_cur
         CLOSE t705_current_ta_sgl05_cs

         OPEN t705_sfb08_chk_cs USING g_sgl[l_ac].sgl06,g_sgl[l_ac].sgl07,
                                      g_sgl[l_ac].sgl012,g_sgl[l_ac].ta_sgl06,
                                      g_sgl[l_ac].sgl04
         FETCH t705_sfb08_chk_cs INTO l_08,l_05
         CLOSE t705_sfb08_chk_cs

         IF l_05 - l_05_cur + IIF(g_sgl[l_ac].ta_sgl05>0,g_sgl[l_ac].ta_sgl05,0) - l_08 > 0 THEN
            LET l_max = l_08 - l_05 + l_05_cur
            CALL cl_err_msg(NULL, "csf-101", l_max, 10)
            RETURN FALSE
         END IF 
      END IF
      
      RETURN TRUE

END FUNCTION

 
FUNCTION t705_cs()
   CLEAR FORM                             #清除畫面
   
   # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
   CONSTRUCT BY NAME g_wc ON sgk01,sgk02,sgk03,sgk04,sgk05,sgk06,sgk07,ta_sgk01,  #By Hao160423 add ta_sgk01
                             ta_sgk02,ta_sgk03,# By Hao210429
                             sgkacti,sgkuser,sgkmodu,sgkgrup,sgkdate
     ON ACTION controlp         #查詢款式料號                                   
          CASE
            WHEN INFIELD(sgk01)
               LET g_t1=g_sgk.sgk01[1,3]                                                 
               CALL cl_init_qry_var()                                           
               LET g_qryparam.state="c"                                    
               LET g_qryparam.form="q_sgk01"
               LET g_qryparam.default1=g_sgk.sgk01                            
               CALL cl_create_qry() RETURNING g_qryparam.multiret               
	             DISPLAY g_qryparam.multiret TO sgk01
	             NEXT FIELD sgk01 
	          WHEN INFIELD(sgk03)                                               
               CALL cl_init_qry_var()                                           
               LET g_qryparam.state="c"                                    
               LET g_qryparam.form="q_gen"
               LET g_qryparam.default1=g_sgk.sgk03                            
               CALL cl_create_qry() RETURNING g_qryparam.multiret               
	             DISPLAY g_qryparam.multiret TO sgk03
               NEXT FIELD sgk03
           # Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
           WHEN INFIELD(ta_sgk02)
               CALL cl_init_qry_var()
               LET g_qryparam.state="c"
               LET g_qryparam.form = "q_gem"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO ta_sgk02
               NEXT FIELD ta_sgk02
           # Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
            OTHERWISE                                                             
               EXIT CASE  
        END CASE 
          
     ON IDLE g_idle_seconds   
         CALL cl_on_idle()                                                 
         CONTINUE CONSTRUCT
   #Modify By Hao160422 查询时可以开启另一程式--begin
     ON ACTION controlg    
         CALL cl_cmdask()
   #Modify By Hao160422 查询时可以开启另一程式--end
     END  CONSTRUCT
   #Modify By Hao160422 查询时在单头资料处若放弃查询则不进入单身--begin
   IF INT_FLAG THEN
      RETURN
   END IF
   #Modify By Hao160422 查询时在单头资料处若放弃查询则不进入单身--end
    CONSTRUCT g_wc2 ON sgl02,sgl12,sgl03,sgl04,sgl05,sgl012,sgl06,        #FUN-A60027 add by huangtao
                       sgl07,
                       ta_sgl29,#Add By Teval 180322
                       ta_sgl33,# By Hao210422
                       ta_sgl34,ta_sgl35,ta_sgl36,
                       ta_sgl32,# By Hao210120
                       ta_sgl19,sgl08,ta_sgl20,sgl09,sgl11,sgl13,ta_sgl17,ta_sgl22
                  FROM s_sgl[1].sgl02,s_sgl[1].sgl12,
                       s_sgl[1].sgl03,s_sgl[1].sgl04,s_sgl[1].sgl05,
                       s_sgl[1].sgl012,s_sgl[1].sgl06,s_sgl[1].sgl07,
                       s_sgl[1].ta_sgl29,#Add By Teval 180322
                       s_sgl[1].ta_sgl33,s_sgl[1].ta_sgl34,s_sgl[1].ta_sgl35,s_sgl[1].ta_sgl36,
                       s_sgl[1].ta_sgl32,# By Hao210120
                       s_sgl[1].ta_sgl19,      #FUN-A60027 add by huangtao
                       s_sgl[1].sgl08,s_sgl[1].ta_sgl20,s_sgl[1].sgl09,
                       s_sgl[1].sgl11,s_sgl[1].sgl13,s_sgl[1].ta_sgl17,s_sgl[1].ta_sgl22
    ON ACTION CONTROLP
          CASE                                                                  
            WHEN INFIELD(sgl12)                                                 
                 CALL cl_init_qry_var()                                         
                 LET g_qryparam.form   = "q_gen"                           
                 LET g_qryparam.state="c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO sgl12
#                 CALL t705_sgl12('d')
                 NEXT FIELD sgl12
            WHEN INFIELD(sgl03)
                 CALL cl_init_qry_var()                                         
                 LET g_qryparam.form   = "q_sgl03"                             
                 LET g_qryparam.state="c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO sgl03                                           
                 NEXT FIELD sgl03
            WHEN INFIELD(sgl04)
                 CALL cl_init_qry_var()                                         
                 LET g_qryparam.form   = "q_sgl04"                             
                 LET g_qryparam.state="c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO sgl04                                           
                 NEXT FIELD sgl04 
            WHEN INFIELD(sgl05)
#FUN-AA0059---------mod------------str-----------------            
#                 CALL cl_init_qry_var()                                         
#                 LET g_qryparam.form   = "q_ima"                             
#                 LET g_qryparam.state="c"
#                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                   CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059---------mod------------end-----------------
                 DISPLAY g_qryparam.multiret TO sgl05                                          
                 NEXT FIELD sgl05
            #FUN-A60027 ---------start------------------------
#            WHEN INFIELD(sgl012)
#                 CALL cl_init_qry_var()                                         
#                 LET g_qryparam.form   = "q_sgl012"                             
#                 LET g_qryparam.state="c"
#                 CALL cl_create_qry() RETURNING g_qryparam.multiret
#                 DISPLAY g_qryparam.multiret TO sgl012                                         
#                 NEXT FIELD sgl012
            #FUN-A60027 -----------end -------------------------
            WHEN INFIELD(sgl07)
                 CALL cl_init_qry_var()                                         
                 LET g_qryparam.form   = "q_sga"                             
                 LET g_qryparam.state="c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO sgl07                                           
                 NEXT FIELD sgl07                    
           END CASE  
                            
    ON IDLE g_idle_seconds                                                     
         CALL cl_on_idle()                                                      
         CONTINUE CONSTRUCT 
   #Modify By Hao160422 查询时可以开启另一程式--begin
    ON ACTION controlg    
         CALL cl_cmdask()
   #Modify By Hao160422 查询时可以开启另一程式--end     
   END  CONSTRUCT
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
   IF g_wc2=" 1=1" THEN
      LET g_sql="SELECT sgk01 FROM sgk_file ",                                        #09/10/21 xiaofeizhu Add
                 " WHERE ",g_wc CLIPPED,
                 " ORDER BY sgk01"
    ELSE
      LET g_sql= "SELECT UNIQUE sgk01 FROM sgk_file,sgl_file",                        #09/10/21 xiaofeizhu Add
                 " WHERE sgk01=sgl01  AND ", g_wc CLIPPED," AND ",g_wc2 CLIPPED,         
                 " ORDER BY sgk01 " 
    END IF                                             
    PREPARE t705_prepare FROM g_sql      #預備一下 
    DECLARE t705_list_cs1 SCROLL CURSOR WITH HOLD FOR t705_prepare
    DECLARE t705_b_cs                  #宣告成可卷動的                          
        SCROLL CURSOR WITH HOLD FOR t705_prepare
    IF g_wc2=" 1=1" THEN
      LET g_sql="SELECT  COUNT(*) ",                                 
                " FROM sgk_file WHERE ", g_wc CLIPPED
    ELSE
      LET g_sql="SELECT  COUNT(UNIQUE sgk01)  ",                                        
                " FROM sgk_file,sgl_file WHERE ", 
                " sgk01=sgl01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED                       
    END IF
    PREPARE t705_precount FROM g_sql                                            
    DECLARE t705_count CURSOR FOR t705_precount                                 
END FUNCTION  
         
FUNCTION t705_menu()
 
    WHILE TRUE
  # Mod By Wang170620 主画面与资料清单切换 begin  
  #    CALL t705_bp("G")
        CASE  
         WHEN (g_action_flag IS NULL ) OR (g_action_flag = "main")
           CALL t705_bp("G") 
         WHEN (g_action_flag = "info_list")
           CALL t705_list_fill()
           CALL t705_bp1("G")
           
     #      IF NOT cl_null(g_action_choice) AND l_ac1>0 THEN #將清單的資料回傳到主畫面
     #        SELECT * INTO g_sgk.* FROM sgk_file  WHERE sgk01 = g_sgl_l[l_ac1].sgk01_l
     #      END IF 
           
     #      IF g_action_choice!= "" THEN
     #        LET g_action_flag = "main"
     #        CALL cl_set_comp_visible("page2", FALSE)
     #        CALL cl_set_comp_visible("page1", FALSE)
     #        CALL ui.interface.refresh()
     #        CALL cl_set_comp_visible("page2", TRUE)
     #        CALL cl_set_comp_visible("page1", TRUE)          
     #     END IF 
       END CASE     
  # Mod By Wang170620 主画面与资料清单切换 end  
  
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN 
               CALL t705_a()
            END IF
 
         WHEN "query"
            IF cl_chk_act_auth() THEN 
               CALL t705_q()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t705_r()
            END IF
 
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL t705_copy()
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN                                           
               CALL t705_b()
            ELSE
               LET g_action_choice = NULL
            END IF
 
         WHEN "invalid" 
            IF cl_chk_act_auth() THEN
               CALL t705_x()
               CALL t705_show()  #TQC-940173     
            END IF
 
         WHEN "modify" 
            IF cl_chk_act_auth() THEN                                           
               CALL t705_u()                                                    
            END IF             
         WHEN "confirm"                                                       
           IF cl_chk_act_auth() THEN                                            
              CALL t705_confirm()                                               
              CALL t705_show()                                                  
           END IF                                                               
                                                                                
         WHEN "notconfirm"                                                    
           IF cl_chk_act_auth() THEN                                            
              CALL t705_notconfirm()                                            
              CALL t705_show()                                                  
           END IF  
                                                                      
         WHEN "help"                                                            
            CALL cl_show_help()   
            
         WHEN "exit"                                                            
            EXIT WHILE      
            
         WHEN "controlg"                                                        
            CALL cl_cmdask()  
            
         WHEN "exporttoexcel"         
            IF cl_chk_act_auth() THEN  
      # Mod By Wang170620 增加资料清单打印 begin 
              LET w = ui.Window.getCurrent()
              LET f = w.getForm()  
            CASE                                                                                     
              WHEN (g_action_flag IS NULL) OR (g_action_flag = 'main')                            
                LET page = f.FindNode("Page","page1")
                CALL cl_export_to_excel(page,base.TypeInfo.create(g_sgl),'','')                                                               
              WHEN g_action_flag = "info_list"                                                  
                LET page = f.FindNode("Page","page2")
                CALL cl_export_to_excel(page,base.TypeInfo.create(g_sgl_l),'','')
            END CASE
               LET g_action_choice = NULL
            END IF                                       
      #        CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_sgl),'','')                                                             
      #      END IF  
            
      # Mod By Wang170620 增加资料清单打印 begin  
            
         #CHI-C80041---begin
         WHEN "void"
            IF cl_chk_act_auth() THEN
              #CALL t705_v()      #CHI-D20010
               CALL t705_v(1)     #CHI-D20010
               CALL t705_show_pic()
            END IF
            
         #CHI-C80041---end 
         #CHI-D20010---begin
         WHEN "undo_void"
            IF cl_chk_act_auth() THEN
               CALL t705_v(2)
               CALL t705_show_pic()
            END IF
         #CHI-D20010---end

        # Modify By Hao170704 添加ACTION可以在审核后修改单身资料--begin
        WHEN "mod_data"
            IF cl_chk_act_auth() THEN
               LET g_chr1='1'
               CALL t705_b()
               LET g_chr1=NULL 
            END IF
        # Modify By Hao170704 添加ACTION可以在审核后修改单身资料--end

        #Add By teval 190308 --start--
        WHEN "distribution"
            IF cl_chk_act_auth() THEN
               CALL t705_a_menu()
               CALL t705_b_fill(g_wc2)
            END IF
        #Add By teval 190308 --end--

      END CASE
    END WHILE
END FUNCTION
 
FUNCTION t705_a()
DEFINE li_result       LIKE type_file.num5
   
    MESSAGE ""                                                                  
    CLEAR FORM                                                                  
    CALL g_sgl.clear()
    
    IF s_shut(0) THEN
       RETURN
    END IF

    INITIALIZE g_sgk.* LIKE sgk_file.*
    LET g_sgk_t.* = g_sgk.*
    LET g_sgk01_t = NULL 
    
    CALL cl_opmsg('a')
 
    WHILE TRUE
       LET g_sgk.sgkuser = g_user                                              
       LET g_sgk.sgkgrup = g_grup               #使用者所屬群                  
       LET g_sgk.sgkdate = g_today                                             
       LET g_sgk.sgkacti = 'Y'
      #LET g_sgk.sgk01  = ' '
       LET g_sgk.sgk01 = '356'   #Add By Teval 190218 预设单别356
       LET g_sgk.sgk03  = ' '
       LET g_sgk.sgk04  = ' '
       LET g_sgk.ta_sgk01=' '    #By Hao160422 add ta_sgk01 
       LET g_sgk.ta_sgk02= NULL 
       LET g_sgk01_t  = ' '                                                        
       LET g_sgk.sgk02=g_today 
       LET g_sgk.sgk05 = 'N'               #No.FUN-810016
       LET g_sgk.sgk06='N'
       LET g_sgk.sgk07='N' 
       
 
       LET g_sgk.sgkplant = g_plant #FUN-980008 add
       LET g_sgk.sgklegal = g_legal #FUN-980008 add
 
       CALL t705_i("a")
        IF INT_FLAG THEN                   #使用者不玩了                        
            LET INT_FLAG = 0
            LET g_sgk.sgk01  = NULL
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF         
 
        IF cl_null(g_sgk.sgk01)   THEN
               CONTINUE WHILE
        END IF
        
        CALL s_auto_assign_no("asf",g_sgk.sgk01,g_today,"O","sgk_file","sgk01","","","") 
        RETURNING li_result,g_sgk.sgk01
        
      IF (NOT li_result) THEN
         CONTINUE WHILE
      END IF
      DISPLAY BY NAME g_sgk.sgk01
      
        BEGIN WORK
           LET g_sgk.sgkoriu = g_user      #No.FUN-980030 10/01/04
           LET g_sgk.sgkorig = g_grup      #No.FUN-980030 10/01/04
           INSERT INTO sgk_file VALUES(g_sgk.*)
           
           IF SQLCA.sqlcode THEN
              CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,1)     #FUN-B80086   ADD
              ROLLBACK WORK
             # CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,1)    #FUN-B80086   MARK
              CONTINUE WHILE
           ELSE
              LET g_sgk01_t = g_sgk.sgk01
              COMMIT WORK 
           END IF
 
        CALL cl_flow_notify(g_sgk.sgk01,'I')
        LET g_rec_b=0
        CALL t705_b_fill('1=1')         #單身 
        CALL t705_b()                   #輸入單身
        EXIT WHILE 
      END WHILE
END FUNCTION
 
FUNCTION t705_i(p_cmd)  
   DEFINE    p_cmd           LIKE type_file.chr1,                 #a:輸入 u:更改
             l_n             LIKE type_file.num5,                 #SMALLINT
             li_result       LIKE type_file.num5

   
                     
   DISPLAY BY NAME g_sgk.sgkuser,g_sgk.sgkgrup,g_sgk.sgkmodu,
                   g_sgk.sgkdate,g_sgk.sgkacti,g_sgk.sgk01,
                   g_sgk.sgk02,g_sgk.sgk03,g_sgk.sgk04,g_sgk.sgk05,
                   g_sgk.sgk06,g_sgk.sgk07
 
   INPUT BY NAME g_sgk.sgk01,g_sgk.sgk02,g_sgk.sgk03,g_sgk.sgk04,
                 g_sgk.sgk05,g_sgk.sgk06,g_sgk.sgk07,g_sgk.ta_sgk01, #By Hao160422 add ta_sgk01 
                 g_sgk.ta_sgk02,g_sgk.ta_sgk03,  # Modify By Hao170603 # By Hao210429
                 g_sgk.sgkuser,g_sgk.sgkgrup,g_sgk.sgkmodu,
                 g_sgk.sgkdate,g_sgk.sgkacti WITHOUT DEFAULTS
 
       BEFORE INPUT
         LET g_before_input_done=FALSE
         CALL t705_set_entry(p_cmd)
         CALL t705_set_no_entry(p_cmd)
         LET g_before_input_done=TRUE
         CALL cl_set_docno_format("sgk01")
 
      AFTER FIELD sgk01
         IF  NOT cl_null(g_sgk.sgk01) THEN
           LET g_t1=g_sgk.sgk01[1,3]
           CALL s_check_no("asf",g_sgk.sgk01,g_sgk01_t,'O',"sgk_file","sgk01","")
                 RETURNING li_result,g_sgk.sgk01
            DISPLAY BY NAME g_sgk.sgk01
            IF (NOT li_result) THEN
               LET g_sgk.sgk01=g_sgk_t.sgk01
               NEXT FIELD sgk01
            END IF
            DISPLAY g_smy.smydesc TO smydesc
          END IF

       AFTER FIELD  sgk03
         IF NOT cl_null(g_sgk.sgk03) THEN
                   SELECT count(*) INTO g_cnt FROM gen_file                    
                     WHERE gen01=g_sgk.sgk03                                    
                           AND  genacti='Y'                               
                 IF g_cnt=0  THEN                      #資料重復                
                 CALL cl_err(g_sgk.sgk03,'ask-008',0)
                 NEXT FIELD sgk03
                 END IF
                 CALL t705_sgk03('d')
         END IF
       #Modify By Hao160423 添加类型字段--begin
       AFTER FIELD ta_sgk01                 
         IF cl_null(g_sgk.ta_sgk01) THEN 
	            NEXT FIELD ta_sgk01
	        END IF 
	 IF p_cmd='u' AND g_sgk_t.ta_sgk01 != g_sgk.ta_sgk01 THEN 
	    FOR l_ac=1 TO g_rec_b
	        CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)   
                UPDATE sgl_file SET ta_sgl13 = g_sgl[l_ac].ta_sgl13 
                      WHERE sgl01 = g_sgk.sgk01 
                       AND sgl02 = g_sgl[l_ac].sgl02
                IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
                   CALL cl_err3("upd","sgl_file",g_sgk.sgk01,g_sgl[l_ac].sgl02,SQLCA.sqlcode,"","",1)  #No.FUN-660129                   
		END IF
	    END FOR 
         END IF 
       #Modify By Hao160423 添加类型字段--end
       # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
       AFTER FIELD ta_sgk02 
          IF NOT cl_null(g_sgk.ta_sgk02)  THEN
             CALL t705_ta_sgk02('a')
             IF NOT cl_null(g_errno)  THEN
                CALL cl_err(g_sgk.ta_sgk02,g_errno,0)
                LET g_sgk.ta_sgk02=g_sgk_t.ta_sgk02
                DISPLAY BY NAME g_sgk.ta_sgk02
                NEXT FIELD ta_sgk02
             END IF
          END IF
       # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
       AFTER INPUT                                                             
            IF INT_FLAG THEN                                                    
               EXIT INPUT                                                       
            END IF 
            #Modify By Hao160818 管控类型(ta_sgk01)为必输字段--begin
            IF g_sgk.ta_sgk01 IS NULL OR g_sgk.ta_sgk01 = ' ' THEN 
                CALL cl_err('','-1305',0)
                NEXT FIELD ta_sgk01
            END IF 
            #Modify By Hao160818 管控类型(ta_sgk01)为必输字段--end
            # By Hao210429
            IF cl_null(g_sgk.ta_sgk03) THEN 
               CALL cl_err('','-1305',0)
               NEXT FIELD ta_sgk03
            END IF  
            

       #ON ACTION controlz  #TQC-C50082 mark
       ON ACTION controlr   #TQC-C50082 add
          CALL cl_show_req_fields()
 
       ON ACTION controlg
          CALL cl_cmdask()
 
       ON ACTION controlp
            CASE
              WHEN INFIELD(sgk01)
                 LET g_t1=s_get_doc_no(g_sgk.sgk01)
                 CALL q_smy(FALSE,FALSE,g_t1,'asf','O') RETURNING g_t1
                 LET g_sgk.sgk01 = g_t1 
                 DISPLAY BY NAME g_sgk.sgk01
                 NEXT FIELD sgk01
              WHEN INFIELD(sgk03)
               CALL cl_init_qry_var()
               LET g_qryparam.form     ="q_gen"
               LET g_qryparam.default1 = g_sgk.sgk03
               CALL cl_create_qry() RETURNING g_sgk.sgk03
               DISPLAY BY NAME g_sgk.sgk03
               CALL t705_sgk03('d')
               NEXT FIELD sgk03  
              # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
              WHEN INFIELD(ta_sgk02)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_gem"
                LET g_qryparam.default1 = g_sgk.ta_sgk02
                CALL cl_create_qry() RETURNING g_sgk.ta_sgk02
                DISPLAY BY NAME g_sgk.ta_sgk02
                CALL t705_ta_sgk02('d')
                NEXT FIELD ta_sgk02
              # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
          END CASE                           
      
       ON IDLE g_idle_seconds                                                   
          CALL cl_on_idle()                                                     
          CONTINUE INPUT                                                        
                                                                                
    END INPUT                                                                   
END FUNCTION               
 
FUNCTION t705_q()
   
    LET g_row_count = 0                                                         
    LET g_curs_index = 0                                                        
    CALL cl_navigator_setting( g_curs_index, g_row_count )                      
    INITIALIZE g_sgk.sgk01 TO NULL
    CALL cl_opmsg('q')                                                          
    MESSAGE ""                                                                  
    CLEAR FORM                                                                  
    CALL g_sgl.clear()                                                          
    CALL t705_cs()
    IF INT_FLAG THEN                         #使用者不玩了                      
        LET INT_FLAG = 0                                                        
        RETURN                                                                  
    END IF                                                                      
    OPEN t705_b_cs                           #從DB產生合乎條件TEMP(0-30秒)      
    IF SQLCA.sqlcode THEN                    #有問題                            
        CALL cl_err('',SQLCA.sqlcode,0)                                         
        INITIALIZE g_sgk.sgk01 TO NULL                             
    ELSE                                                                        
        OPEN t705_count                                                         
        FETCH t705_count INTO g_row_count                                       
#        DISPLAY g_row_count TO FORMONLY.cnt  
        DISPLAY g_row_count TO FORMONLY.cnt2# Modify By Hao170606 显示总笔数 
        CALL t705_fetch('F')                 #讀出TEMP第一筆并顯示                                      
    END IF                                                                      
END FUNCTION
 
FUNCTION t705_fetch(p_flag)                                                     
DEFINE                                                                          
    p_flag          LIKE type_file.chr1                  #處理方式
   
    MESSAGE ""                                                                  
    CASE p_flag                                                                 
        WHEN 'N' FETCH NEXT     t705_b_cs INTO g_sgk.sgk01         #09/10/21 xiaofeizhu Add
        WHEN 'P' FETCH PREVIOUS t705_b_cs INTO g_sgk.sgk01         #09/10/21 xiaofeizhu Add
        WHEN 'F' FETCH FIRST    t705_b_cs INTO g_sgk.sgk01         #09/10/21 xiaofeizhu Add
        WHEN 'L' FETCH LAST     t705_b_cs INTO g_sgk.sgk01         #09/10/21 xiaofeizhu Add
        WHEN '/'                                                                
            IF (NOT g_no_ask) THEN                                             
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg                   
               LET INT_FLAG = 0  ######add for prompt bug                       
               PROMPT g_msg CLIPPED,': ' FOR g_jump                             
                  ON IDLE g_idle_seconds                                        
                     CALL cl_on_idle()                                          
                                                                                
               END PROMPT
               IF INT_FLAG THEN LET INT_FLAG = 0 EXIT CASE END IF
            END IF
            FETCH ABSOLUTE g_jump t705_b_cs INTO g_sgk.sgk01                  #09/10/21 xiaofeizhu Add
            LET g_no_ask = FALSE
    END CASE
    
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)
        INITIALIZE g_sgk.sgk01 TO NULL
        RETURN                            
    ELSE
        CASE p_flag                                                             
           WHEN 'F' LET g_curs_index = 1                                        
           WHEN 'P' LET g_curs_index = g_curs_index - 1                         
           WHEN 'N' LET g_curs_index = g_curs_index + 1                         
           WHEN 'L' LET g_curs_index = g_row_count                              
           WHEN '/' LET g_curs_index = g_jump                                   
        END CASE
        DISPLAY g_curs_index TO FORMONLY.cnt
        CALL cl_navigator_setting( g_curs_index, g_row_count )                 
    END IF
    SELECT * INTO g_sgk.* FROM sgk_file WHERE sgk01=g_sgk.sgk01                #09/10/21 xiaofeizhu Add
    IF SQLCA.sqlcode THEN                         #有麻煩
        CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)
        INITIALIZE g_sgk.sgk01 TO NULL
        RETURN
    END IF
    LET g_data_owner = g_sgk.sgkuser      #FUN-4C0057 add
    LET g_data_group = g_sgk.sgkgrup      #FUN-4C0057 add
    LET g_data_keyvalue = g_sgk.sgk01
    CALL  t705_show()
END FUNCTION 
 
#將資料顯示在畫面上                                                             
FUNCTION t705_show()
   LET g_sgk_t.* = g_sgk.*
   DISPLAY BY NAME g_sgk.sgk01,g_sgk.sgk02,g_sgk.sgk03,g_sgk.sgk04, g_sgk.sgk05,
                   g_sgk.sgk06,g_sgk.sgk07,g_sgk.ta_sgk01,      #By Hao160422 add ta_sgk01                        #單頭
                   g_sgk.ta_sgk02,g_sgk.ta_sgk03,   # Modify By Hao170603 # By Hao210429
                   g_sgk.sgkuser,g_sgk.sgkgrup,g_sgk.sgkmodu,
                   g_sgk.sgkdate,g_sgk.sgkacti
      CALL t705_sgk03('d')
      CALL t705_ta_sgk02('d')
      CALL t705_b_fill(g_wc2)              #單身 
      CALL t705_show_pic()
      CALL cl_show_fld_cont()                                   
END FUNCTION
 
FUNCTION t705_r()                                                               
 
    IF s_shut(0) THEN RETURN END IF
    IF cl_null(g_sgk.sgk01) OR cl_null(g_sgk.sgk03) THEN
        CALL cl_err('',-400,0)
        RETURN
    END IF
 
    SELECT * INTO g_sgk.* FROM sgk_file
        WHERE sgk01=g_sgk.sgk01
 
    IF g_sgk.sgkacti='N' THEN                                                   
         CALL cl_err(g_sgk.sgk01,'mfg1000',0)                                   
         RETURN                                                                 
    END IF 
    IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041
    IF g_sgk.sgk07='Y' THEN 
         CALL  cl_err('',9023,0)
         RETURN
    END IF
   
    BEGIN WORK
    
    OPEN t705_crl USING g_sgk.sgk01                    #09/10/21 xiaofeizhu Add
    IF STATUS THEN
       CALL cl_err("OPEN t705_cl:",STATUS,1)
       CLOSE t705_crl
       ROLLBACK WORK
       RETURN
    END IF
   
    FETCH t705_crl INTO g_sgk.*
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)
        CLOSE t705_crl
        ROLLBACK WORK
        RETURN
    END IF
    
    CALL t705_show()
                                                                     
    IF cl_delh(0,0) THEN                   #確認一下         
         DELETE FROM sgk_file WHERE sgk01=g_sgk.sgk01
         DELETE FROM sgl_file WHERE sgl01=g_sgk.sgk01
         CLEAR FORM
         CALL g_sgl.clear()                                                  
         LET g_cnt=SQLCA.SQLERRD[3]                                          
         LET g_delete = 'Y'                                                  
         MESSAGE 'Remove (',g_cnt USING '####&',') Row(s)'                   
         OPEN t705_count
         #FUN-B50064-add-start--
         IF STATUS THEN
            CLOSE t705_b_cs
            CLOSE t705_count
            COMMIT WORK
            RETURN
         END IF
         #FUN-B50064-add-end-- 
         FETCH t705_count INTO g_row_count
         #FUN-B50064-add-start--
         IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
            CLOSE t705_b_cs
            CLOSE t705_count
            COMMIT WORK
            RETURN
         END IF
         #FUN-B50064-add-end-- 
         DISPLAY g_row_count TO FORMONLY.cnt
         OPEN t705_b_cs
         IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL t705_fetch('L')
         ELSE                                                                
           LET g_jump = g_curs_index                                        
           LET g_no_ask = TRUE
           CALL t705_fetch('/')
         END IF
      END IF
 
   COMMIT WORK 
   CALL cl_flow_notify(g_sgk.sgk01,'D') 
 
END FUNCTION
 
#單身                                                                           
FUNCTION t705_b()
DEFINE
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT
    l_n             LIKE type_file.num5,                #檢查重復用
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住
    p_cmd           LIKE type_file.chr1,                #處理狀態
    l_allow_insert  LIKE type_file.num5,                #可新增
    l_allow_delete  LIKE type_file.num5,                #可刪除
    l_acti          LIKE sgk_file.sgkacti,
    l_str           LIKE type_file.chr20,
    l_sgl05         LIKE sgl_file.sgl05,
    l_sgl06         LIKE sgl_file.sgl06,
    l_sql           STRING,
    l_m,l_m1,l_m2   LIKE type_file.num5,
    l_skh06         LIKE skh_file.skh06,
    l_skh07         LIKE skh_file.skh07,
    l_skh08         LIKE skh_file.skh08,
    l_skh12         LIKE skh_file.skh12,
    l_sfb08         LIKE sfb_file.sfb08,
    l_sfb05         LIKE sfb_file.sfb05,
    l_ima02         LIKE ima_file.ima02,
    l_ima55         LIKE ima_file.ima55
DEFINE l_base,l_base1      LIKE type_file.num15_3
DEFINE l_uph LIKE type_file.num15_3    # ADD.........: By dmw20260413 变量
    
    LET g_action_choice = ""
    IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041   

    # Modify.........: By Hao170704 添加ACTION可以在审核后修改单身资料
    IF s_shut(0) THEN 
#    IF s_shut(0) OR g_sgk.sgk07="Y"  THEN 
       RETURN 
    END IF
    IF g_sgk.sgk07 = 'Y'  THEN
       IF cl_null(g_chr1)  THEN
          RETURN
       END IF
    ELSE 
       IF NOT cl_null(g_chr1)  THEN
          CALL cl_err('','aap-084',0)
          RETURN
       END IF
    END IF
    # Modify.........: By Hao170704 添加ACTION可以在审核后修改单身资料           
   
    IF cl_null(g_sgk.sgk01) THEN
        RETURN
    END IF
 
    SELECT sgkacti INTO l_acti
           FROM sgk_file WHERE sgk01 = g_sgk.sgk01
    IF l_acti = 'N'  OR l_acti = 'n' THEN 
           CALL cl_err(g_sgk.sgk01,'mfg1000',0)                                       
    END IF
 
    CALL cl_opmsg('b')
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

 
#    LET g_forupd_sql="SELECT sgl02,sgl12,gen02,sgl03,sgl04,sgl05,ima02,sgl012,sgl06,",    #Star151123 add sgl012
{    LET g_forupd_sql="SELECT sgl02,sgl03,sgl04,sgl05,ima02,ta_sgl06,ta_sgl07,ta_sgl18,sgl012,sgl06,sgl07,sga02,sgl11,",    #Star151123 add sgl012
                     "ta_sgl01,ta_sgl02,ta_sgl03,ta_sgl04,ta_sgl05,",
                     "sgl08,sgl09,sgl10,",
                     "ta_sgl08,ta_sgl09,ta_sgl10,ta_sgl11,ta_sgl12,",
                     "ta_sgl13,ta_sgl14,ta_sgl15,sgl12,gen02,",
                     "ta_sgl16,ta_sgl17,sgl13",
                     " FROM sgl_file LEFT OUTER JOIN gen_file ON sgl12 = gen01 LEFT OUTER JOIN ima_file ON sgl05 = ima01",  #No.TQC-9A0130
                     " LEFT OUTER JOIN sga_file ON sga01=sgl07 ",
                     " WHERE sgl01=  ? ",
                     " AND sgl02=? FOR UPDATE " } 
     #Modify By Hao160422 add ta_sgl19,ta_sgl20,ta_sgl21,ta_sgl22,ta_sgl23--begin
     # Modify.........: By Hao170607 添加字段进厂日期ta_sgl26  # Modify By Hao171201 添加工时备注字段ta_sgl27 # Modify By Hao171214 添加工艺备注字段ta_sgl28
    LET g_forupd_sql="SELECT sgl02,sgl03,sgl04,sgl05,ima02,ta_sgl06,ta_sgl07,ta_sgl18,sgl012,sgl06,sgl07,sga02,ta_sgl28,ta_sgl27,",
                     "ta_sgl29,ta_sgl33,ta_sgl34,ta_sgl35,ta_sgl36,ta_sgl32,",#Add By Teval 180322
                     "ta_sgl19,sgl11,",    #Star151123 add sgl012
                     "ta_sgl01,ta_sgl02,ta_sgl03,ta_sgl04,ta_sgl05,",
                     "sgl08,ta_sgl20,sgl09,sgl10,",
                     "ta_sgl08,ta_sgl09,ta_sgl10,ta_sgl11,ta_sgl12,ta_sgl21,ta_sgl23,",
                     "ta_sgl13,",
                     "ta_sgl30,ta_sgl37,ta_sgl31,",#Add By Teval 180719 # Modify.........: By Hao230728
                     "ta_sgl14,sgl12,ta_sgl25,",# Modify By Hao170606 添加字段员工姓名ta_sgl25替换gen02
                     "ta_sgl16,ta_sgl24,ta_sgl26,ta_sgl17,ta_sgl22,sgl13",# Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
                     " FROM sgl_file ", #LEFT OUTER JOIN gen_file ON sgl12 = gen01 
                     " LEFT OUTER JOIN ima_file ON sgl05 = ima01",  #No.TQC-9A0130
                     " LEFT OUTER JOIN sga_file ON sga01=sgl07 ",
                     " WHERE sgl01=  ? ",
                     " AND sgl02=? FOR UPDATE "  
    #Modify By Hao160422 add ta_sgl19,ta_sgl20,ta_sgl21,ta_sgl22,ta_sgl23--end
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t705_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
    IF g_rec_b=0 THEN CALL g_sgl.clear() END IF
 
    
    INPUT ARRAY g_sgl WITHOUT DEFAULTS FROM s_sgl.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,
                    DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
    BEFORE INPUT
            IF g_rec_b!=0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            # Modify.........: By Hao170606 设定sgl07不可输入，由sgl06开窗获取
              #屏蔽原设定
#            CALL cl_set_comp_entry("sgl03,sgl04,sgl06,sgl07",TRUE)
            CALL cl_set_comp_entry("sgl03,sgl04,sgl06",TRUE)
            # Modify.........: By Hao170606 设定sgl07不可输入，由sgl06开窗获取
            CALL cl_set_comp_entry("sgl05,ta_sgl31",FALSE)
            IF g_sgk.sgk05='Y' THEN
               CALL cl_set_comp_entry("sgl04,sgl06,sgl07",FALSE)
            ELSE 
            	 CALL cl_set_comp_entry("sgl03",FALSE) 
            END IF
            IF g_sgk.sgk06='Y' THEN
               CALL cl_set_comp_entry("sgl06,sgl07",FALSE)
            END IF
            CALL cl_set_comp_entry("ta_sgl06,sgl012",TRUE)
            
     BEFORE ROW
            LET p_cmd=''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()
 
            BEGIN WORK
            OPEN t705_crl USING g_sgk.sgk01                    #09/10/21 xiaofeizhu Add
            IF STATUS THEN
               CALL cl_err("OPEN t705_crl:",STATUS,1)
               CLOSE t705_crl
               ROLLBACK WORK 
               RETURN
            END IF
 
            FETCH t705_crl INTO g_sgk.*
            IF SQLCA.sqlcode THEN
                CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)
                ROLLBACK WORK
                CLOSE t705_crl
                RETURN
            END IF
 
            IF g_rec_b >= l_ac THEN
                LET p_cmd='u'
                LET g_sgl_t.* = g_sgl[l_ac].*  #BACKUP
                LET g_sgl10_t = g_sgl[l_ac].sgl10   #No.FUN-BB0086
                OPEN t705_bcl USING g_sgk.sgk01,g_sgl_t.sgl02
                IF STATUS THEN
                   CALL cl_err("OPEN t705_bcl:",STATUS,1)
                   LET l_lock_sw = "Y"
                ELSE
                   FETCH t705_bcl INTO g_sgl[l_ac].*
#                   SELECT hr02 INTO g_sgl[l_ac].gen02 
#                   FROM hr_view a WHERE  a.hr01=g_sgl[l_ac].sgl12
                   IF SQLCA.sqlcode THEN
                       CALL cl_err(g_sgl_t.sgl02,SQLCA.sqlcode,1)
                       LET l_lock_sw = "Y" 
                   END IF
                END IF
            END IF
 
       BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_sgl[l_ac].* TO NULL
            LET g_sgl10_t = NULL    #No.FUN-BB0086
            LET g_sgl_t.* = g_sgl[l_ac].*         #新輸入資
            LET g_sgl[l_ac].ta_sgl06='T01'
            LET g_sgl[l_ac].sgl012 = 'D01'
            LET g_sgl[l_ac].sgl08=0
	        LET g_sgl[l_ac].ta_sgl20=0            #Modify By Hao160422 add ta_sgl20
            LET g_sgl[l_ac].sgl09=0
            LET g_sgl[l_ac].sgl03= ' '
	        LET g_sgl[l_ac].ta_sgl21=0
	        LET g_sgl[l_ac].ta_sgl01=0    #Modify By Hao160705 设置初始值
            LET g_sgl[l_ac].ta_sgl23=0
            LET g_sgl[l_ac].ta_sgl37=1
            LET g_sgl[l_ac].ta_sgl29='01' #Add By Teval 180322
	       # LET g_sgl[l_ac].ta_sgl30=0    #Add By Teval 180719
	       # LET g_sgl[l_ac].ta_sgl31=0    #Add By Teval 180719
            CALL cl_show_fld_cont() 
            NEXT FIELD sgl02
 
       AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            SELECT count(*)
                 INTO l_n
                 FROM sgl_file
                 WHERE sgl01=g_sgk.sgk01
                  AND  sgl02=g_sgl[l_ac].sgl02
               IF l_n>0 THEN
                  CALL cl_err('',-239,0)
                  LET g_sgl[l_ac].sgl02=g_sgl_t.sgl02
                  NEXT FIELD sgl02
               END IF
        #FUN-A60076------------------start---------------
           IF g_sgl[l_ac].sgl012 IS NULL THEN
           LET g_sgl[l_ac].sgl012 = ' '
           END IF
        #FUN-A60076 -----------------end----------------  
            #No.FUN-A70131--begin 
            IF  cl_null(g_sgl[l_ac].sgl06) THEN 
               LET g_sgl[l_ac].sgl06=0      
            END IF
            
            #No.FUN-A70131--end  #Modify By Hao160422 add ta_sgl19,ta_sgl20,ta_sgl21,ta_sgl22,ta_sgl23
            # Modify.........: By Hao170607 添加字段进厂日期ta_sgl26 # Modify By Hao171201 添加工时备注字段ta_sgl27 # ModifyBy Hao171214 添加工艺备注字段ta_sgl28
            INSERT INTO sgl_file(sgl01,sgl02,sgl12,sgl03,sgl04,sgl05,             
                                 sgl06,sgl07,ta_sgl19,sgl08,ta_sgl20,sgl09,sgl10,sgl11,sgl13,
#                                 sglplant,sgllegal,sgl012) #FUN-980008 add           #FUN-A60076  add
                                 sglplant,sgllegal,sgl012,ta_sgl01,ta_sgl02,ta_sgl03,
                                 ta_sgl04,ta_sgl05,ta_sgl06,ta_sgl07,ta_sgl08,ta_sgl09,
                                 ta_sgl10,ta_sgl11,ta_sgl12,ta_sgl21,ta_sgl23,ta_sgl13,
                                 ta_sgl30,ta_sgl37,ta_sgl31,#Add By Teval 180719 # Modify.........: By Hao230728
                                 ta_sgl14,
                                 ta_sgl16,ta_sgl24,ta_sgl26,ta_sgl17,ta_sgl22,ta_sgl18,ta_sgl25,ta_sgl27,ta_sgl28,#)# Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24#FUN-980008 add           #FUN-A60076  add
                                 ta_sgl29,ta_sgl32,ta_sgl33,ta_sgl34,ta_sgl35,ta_sgl36)#Add By Teval 180322 
            VALUES(g_sgk.sgk01,g_sgl[l_ac].sgl02,
                   g_sgl[l_ac].sgl12,g_sgl[l_ac].sgl03,
                   g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl05,               
                   g_sgl[l_ac].sgl06,g_sgl[l_ac].sgl07,
		   g_sgl[l_ac].ta_sgl19,g_sgl[l_ac].sgl08,g_sgl[l_ac].ta_sgl20,  
                   g_sgl[l_ac].sgl09,g_sgl[l_ac].sgl10,
                   g_sgl[l_ac].sgl11,g_sgl[l_ac].sgl13,
#                   g_plant,g_legal,g_sgl[l_ac].sgl012 )   #FUN-980008 add         #FUN-A60076  add
                   g_plant,g_legal,g_sgl[l_ac].sgl012,g_sgl[l_ac].ta_sgl01,g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,
                   g_sgl[l_ac].ta_sgl04,g_sgl[l_ac].ta_sgl05,g_sgl[l_ac].ta_sgl06,
                   g_sgl[l_ac].ta_sgl07,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,
                   g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl21,g_sgl[l_ac].ta_sgl23,g_sgl[l_ac].ta_sgl13,
                   g_sgl[l_ac].ta_sgl30,g_sgl[l_ac].ta_sgl37,g_sgl[l_ac].ta_sgl31,#Add By Teval 180719 # Modify.........: By Hao230728
                   g_sgl[l_ac].ta_sgl14,
                   g_sgl[l_ac].ta_sgl16,g_sgl[l_ac].ta_sgl24,g_sgl[l_ac].ta_sgl26,g_sgl[l_ac].ta_sgl17,g_sgl[l_ac].ta_sgl22,g_sgl[l_ac].ta_sgl18,# Modify By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24 #FUN-980008 add         #FUN-A60076  add
                   g_sgl[l_ac].ta_sgl25,g_sgl[l_ac].ta_sgl27,g_sgl[l_ac].ta_sgl28,#)# Modify.........: By Hao170606 添加字段员工姓名ta_sgl25替换gen02  
                   g_sgl[l_ac].ta_sgl29,g_sgl[l_ac].ta_sgl32,g_sgl[l_ac].ta_sgl33,g_sgl[l_ac].ta_sgl34,g_sgl[l_ac].ta_sgl35,g_sgl[l_ac].ta_sgl36)#Add By Teval 180322
                   
#            INSERT INTO sgl_file VALUES(g_sgl[l_ac].*)
            IF SQLCA.sqlcode THEN
               CALL cl_err(l_str,SQLCA.sqlcode,0)
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               COMMIT WORK
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt2
            END IF
            
        BEFORE FIELD sgl02
           IF p_cmd='a'  THEN
              SELECT max(sgl02)+1
                 INTO g_sgl[l_ac].sgl02
              FROM sgl_file
              WHERE sgl01=g_sgk.sgk01
              IF g_sgl[l_ac].sgl02 IS NULL THEN
                LET g_sgl[l_ac].sgl02=1
              END IF
           END IF
  
        AFTER FIELD sgl12
           IF NOT cl_null(g_sgl[l_ac].sgl12) THEN
             IF p_cmd="a" OR (p_cmd="u" ) THEN #AND g_sgl[l_ac].sgl12 !=g_sgl_t.sgl12) THEN
              # Modify By Hao170419 修改员工取值来源于人事资料档
              # 屏蔽原先取值
              { SELECT count(*)
                 INTO l_n
                 FROM gen_file
                 WHERE gen01=g_sgl[l_ac].sgl12
               IF l_n=0 THEN
                  CALL cl_err('','ask-008',0)
                  NEXT FIELD sgl12
               END IF
               CALL t705_sgl12('d')
             END IF}
             # 屏蔽原先取值
             # 获取人事资料    
             # Modify.........: By Hao170606 添加字段员工姓名ta_sgl25替换gen02
             # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
#             SELECT hr02,hr05,hr04 INTO g_sgl[l_ac].gen02,g_sgl[l_ac].ta_sgl16,g_sgl[l_ac].ta_sgl24 
             # Modify By Hao170607 添加进厂日期
             SELECT hr02,hr05,hr04,hr07 INTO g_sgl[l_ac].ta_sgl25,g_sgl[l_ac].ta_sgl16,g_sgl[l_ac].ta_sgl24,
                g_sgl[l_ac].ta_sgl26
             FROM hr_view  WHERE  hr01=g_sgl[l_ac].sgl12
              IF sqlca.sqlcode  THEN
                IF sqlca.sqlcode = 100  THEN
                   CALL cl_err('','aap-038',0)
                   NEXT FIELD sgl12
                ELSE 
                   CALL cl_err('',sqlca.sqlcode,0)
                   NEXT FIELD sgl12
                END IF
              END IF
#              IF cl_null(g_sgl[l_ac].gen02)   THEN 
#                  CALL cl_err('',sqlca.sqlcode,0)
#                  NEXT FIELD sgl12
#              END IF
               DISPLAY BY NAME g_sgl[l_ac].ta_sgl25
               DISPLAY BY NAME g_sgl[l_ac].ta_sgl16
               DISPLAY BY NAME g_sgl[l_ac].ta_sgl24
               DISPLAY BY NAME g_sgl[l_ac].ta_sgl26
             END IF 
             # Modify By Hao170419 修改员工取值来源于人事资料档
           ELSE 
           	 CALL cl_err('','ask-014',0)
           	 NEXT FIELD sgl12  
           END IF
        AFTER FIELD sgl04
          IF g_sgl[l_ac].sgl04 IS NOT NULL THEN
             IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl04 !=g_sgl_t.sgl04) THEN
               # Modify.........: By Hao170613 针对于无工单号的工时输入
               IF g_sgl[l_ac].sgl04 MATCHES 'MISC*'  THEN
                  LET g_sgl[l_ac].sgl05=' '
                  LET g_sgl[l_ac].sgl07=' '
                  LET g_sgl[l_ac].sgl10='PCS'
                  LET g_sgl[l_ac].ta_sgl06=NULL 
                  LET g_sgl[l_ac].sgl012=NULL 
                  LET g_sgl[l_ac].ima02=NULL 
                  LET g_sgl[l_ac].ta_sgl18=NULL 
                  LET g_sgl[l_ac].sgl06=NULL 
                  LET g_sgl[l_ac].sga02=NULL 
                  CALL cl_set_comp_entry("ta_sgl06,sgl012,sgl06",FALSE)
               ELSE # Modify.........: By Hao170613 针对于无工单号的工时输入                  
                  CALL cl_set_comp_entry("ta_sgl06,sgl012,sgl06",TRUE)
                  SELECT COUNT(*) INTO l_m FROM sfb_file
                   WHERE sfb01=g_sgl[l_ac].sgl04 {AND sfb_file.sfb04!='8'} #Modify By Hao170607 去除条件sfb04!='8',以便结案工单可录入
		                 AND sfb_file.sfb04!='1'
                   AND sfb_file.sfbacti='Y'
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('','asf-256',0)
                     NEXT FIELD sgl04
                  END IF  
                  IF l_m=0 THEN
                     CALL cl_err(g_sgl[l_ac].sgl04,'ask-008',0)
                     IF g_sgl[l_ac].sgl04=l_skh06 THEN
                        NEXT FIELD sgl03
                     ELSE    
                        NEXT FIELD sgl04
                     END IF    
                  END IF 
#               SELECT COUNT(*) INTO l_m  FROM skh_file WHERE skh06 = g_sgl[l_ac].sgl04
#                 IF l_m > 0 THEN 
#                    CALL cl_err(g_sgl[l_ac].sgl04,'asf-299',0)
#                    NEXT FIELD sgl04
#                 END IF    
                 IF g_sgk.sgk06 ='Y' THEN
                    LET g_sgl[l_ac].sgl06=' '
                    LET g_sgl[l_ac].sgl07=' '
                 END IF

                {Mark By Teval 190313 --start--
                 CALL t705_sgl08 (g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING g_sgl[l_ac].sgl08    #不作检查    hwj151201
                 CALL t705_sgl08 (g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING g_sgl[l_ac].ta_sgl05
                 Mark　By Teval 190313 --end
                 }

                 CALL t705_sgl08()  #Mod By Teval 190313

	                CALL t705_sgl04('d')
                 # Modify.........: By Hao170725 获取工单的工艺编号
                 SELECT sfb06 INTO g_sgl[l_ac].ta_sgl06 FROM sfb_file WHERE sfb01=g_sgl[l_ac].sgl04
                 DISPLAY BY NAME g_sgl[l_ac].ta_sgl06
                 # Modify.........: By Hao170725 获取工单的工艺编号
             #No.FUN-BB0086--add--begin--
                 LET g_sgl[l_ac].sgl09 = s_digqty(g_sgl[l_ac].sgl09,g_sgl[l_ac].sgl10)
                 DISPLAY BY NAME g_sgl[l_ac].sgl09
#不作飞票检查    hwj151201   start-----
#             IF NOT cl_null(g_sgl[l_ac].sgl08) AND g_sgl[l_ac].sgl08<>0 THEN  #FUN-C20068
#                IF NOT t705_sgl08_check(p_cmd,l_skh12) THEN 
#                   LET g_sgl10_t = g_sgl[l_ac].sgl10
#                   NEXT FIELD sgl08
#                END IF  
#             END IF  
##不作飞票检查    hwj151201  END-----                                                         #FUN-C20068
                LET g_sgl10_t = g_sgl[l_ac].sgl10
              END IF
             #No.FUN-BB0086--add--end--
            END IF             
          ELSE 
            	NEXT FIELD sgl04	
          END IF
          #add by dmw20260413 计算UPH
          CALL t705_calc_uph()
      
          {
        AFTER FIELD ta_sgl06
          IF g_sgl[l_ac].ta_sgl06 IS NOT NULL THEN
             IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].ta_sgl06 !=g_sgl_t.ta_sgl06) THEN
                SELECT COUNT(*) INTO l_m FROM ecm_file
                 WHERE ecm01=g_sgl[l_ac].sgl04 AND ecm_file.ecmacti='Y'
                 AND ecm_file.ecm03=g_sgl[l_ac].ta_sgl06
                 AND ecm012=g_sgl[l_ac].sgl012          
                IF l_m=0 THEN
                   CALL cl_err(g_sgl[l_ac].ta_sgl06,'ask-008',0)
                   NEXT FIELD sgl06
                END IF  
             END IF
             LET g_sgl_t.sgl03 = g_sgl[l_ac].sgl03
            ELSE 
            	NEXT FIELD ta_sgl06
          END IF}
          
        AFTER FIELD sgl06
          IF g_sgl[l_ac].sgl06 IS NOT NULL THEN
             IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl06 !=g_sgl_t.sgl06) THEN
                SELECT COUNT(*) INTO l_m FROM ecm_file
                 WHERE ecm01=g_sgl[l_ac].sgl04 AND ecm_file.ecmacti='Y'
                 AND ecm_file.ecm03=g_sgl[l_ac].sgl06
                 #Star151124 系统BUG
                 #AND ecm012=sgl012           #FUN-A60027 add by huangtao
                 AND ecm012=g_sgl[l_ac].sgl012          
                IF l_m=0 THEN
                   CALL cl_err(g_sgl[l_ac].sgl06,'ask-008',0)
                   NEXT FIELD sgl06
                END IF 
                IF NOT cl_null(g_sgl[l_ac].sgl07)  THEN
                   SELECT sga02 INTO g_sgl[l_ac].sga02 FROM sga_file WHERE sga01=g_sgl[l_ac].sgl07 
                END IF
             END IF
             LET g_sgl_t.sgl03 = g_sgl[l_ac].sgl03

            CALL t705_sgl08()  #Mod By Teval 190313
            ELSE 
            	NEXT FIELD sgl06
          END IF
          
        AFTER FIELD sgl07
          IF g_sgl[l_ac].sgl07 IS NOT NULL THEN
             IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl07 !=g_sgl_t.sgl07) THEN
                SELECT COUNT(*) INTO l_m FROM sgd_file
                 WHERE sgd00=g_sgl[l_ac].sgl04 
                   AND sgd_file.sgd03 = g_sgl[l_ac].sgl06
                   AND sgd_file.sgd14 = 'Y'      #No.FUN-830088
                   AND sgd_file.sgd05 = g_sgl[l_ac].sgl07
                IF l_m=0 THEN
                   CALL cl_err(g_sgl[l_ac].sgl07,'ask-008',0)
                   NEXT FIELD sgl07
                END IF  
                #CALL t705_sgl08(g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING g_sgl[l_ac].sgl08  #不作检查    hwj151201
             END IF
             SELECT sga02 INTO g_sgl[l_ac].sga02 FROM sga_file WHERE sga01=g_sgl[l_ac].sgl07

             CALL t705_sgl08()  #Mod By Teval 190313
          ELSE 
            	NEXT FIELD sgl07
          END IF  
        #Modify By Hao160423 添加估算金额字段--begin

        AFTER FIELD sgl012
            CALL t705_sgl08()  #Mod By Teval 190313

        AFTER FIELD ta_sgl34
            IF NOT cl_null(g_sgl[l_ac].ta_sgl34) THEN 
               IF cl_null(g_sgl_t.ta_sgl34) OR g_sgl[l_ac].ta_sgl34 != g_sgl_t.ta_sgl34 THEN 
                  SELECT * FROM faj_file WHERE fajud03='0' and faj43<>'5' and faj43<>'6' 
                   AND (faj02=g_sgl[l_ac].ta_sgl34 OR fajud02=g_sgl[l_ac].ta_sgl34)
                  IF sqlca.sqlcode THEN 
                     CALL cl_err('',sqlca.sqlcode,0)
                     NEXT FIELD CURRENT 
                  END IF 
               END IF 
            END IF 

        AFTER FIELD ta_sgl19 
           IF g_sgl[l_ac].ta_sgl19<0 THEN
                   CALL cl_err('','aim-223',0)
                   NEXT FIELD ta_sgl19
           END IF 
             CALL t705_b_check_1()
           #Modify By Hao160423 添加估算金额字段--end 
        AFTER FIELD sgl11
          IF g_sgl[l_ac].sgl11<0 THEN
             CALL cl_err('','aim-223',0)
             NEXT FIELD sgl11
          ELSE
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
          END IF 
          #add.........: By dmw20260413 计算UPH并回填理论标准工时和达成率
          CALL t705_calc_uph()
       
        AFTER FIELD ta_sgl01    #正常工时=总工时-异常工时
            IF g_sgl[l_ac].ta_sgl01 >= 0 THEN
            ELSE
               CALL cl_err('','aem-042',0)
            END IF
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)

        AFTER FIELD ta_sgl04    #实际标准工时
            IF g_sgl[l_ac].ta_sgl04 >= 0 THEN
            ELSE
               CALL cl_err('','aem-042',0)
            END IF
             CALL t705_b_check_1()

        AFTER FIELD ta_sgl05    #生产总数
            IF g_sgl[l_ac].ta_sgl05 >= 0 THEN
            ELSE
               CALL cl_err('','aem-042',0)
            END IF
            IF NOT t705_sfb08_chk() THEN #Add By Teval 190218 同一工单、工艺序号、工艺段号，其累计生产总数不可超过ecm_file中的良品转入数量
               NEXT FIELD CURRENT
            END IF
            #add.........: By dmw20260413 计算UPH并回填理论标准工时和达成率
            CALL t705_calc_uph()

             # Modify.........: By Hao171101 自动计算良品完成数及不良数量--begin
             LET g_sgl[l_ac].sgl08=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].sgl09
             # Modify.........: By Hao171101 自动计算良品完成数及不良数量--end
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
             
             # add.........: By dmw20260413 计算UPH并回填理论标准工时和达成率
             CALL t705_calc_uph()

         AFTER FIELD ta_sgl06
            CALL t705_sgl08()  #Mod By Teval 190313

         AFTER FIELD sgl08    #良品数=生产总数-不良品数-工废
             IF cl_null(g_sgl[l_ac].sgl08)  THEN
                LET g_sgl[l_ac].sgl08=0
             END IF
             IF g_sgl[l_ac].sgl08 >= 0 THEN
             ELSE
                CALL cl_err('','aem-042',0)
             END IF
             #IF g_sgl[l_ac].ta_sgl20+g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09 > g_sgl[l_ac].ta_sgl05 THEN
	            #  CALL cl_err('','abm-010',0)
	            #  NEXT FIELD sgl08	      
	            #END IF
             # Modify.........: By Hao171101 自动计算良品完成数及不良数量--begin
             LET g_sgl[l_ac].ta_sgl20=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].sgl08-g_sgl[l_ac].sgl09
             # Modify.........: By Hao171101 自动计算良品完成数及不良数量--end
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
             
#        BEFORE FIELD ta_sgl11    #奖惩单价(元)=估算金额3600秒/实际标准工时
#             LET g_sgl[l_ac].ta_sgl11=g_sgl[l_ac].ta_sgl19/3600/g_sgl[l_ac].ta_sgl04
        AFTER FIELD ta_sgl11
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)

        AFTER FIELD ta_sgl17
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
        #Modify By Hao160423 添加不良倍数字段--begin
	       AFTER FIELD ta_sgl23
	            CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
        #Modify By Hao160423 添加估算金额字段--end

        ON CHANGE ta_sgl32 
         {IF g_sgl[l_ac].ta_sgl32 = '3' OR g_sgl_t.ta_sgl32='3' THEN 
            NEXT FIELD ta_sgl30
         ELSE 
         END IF }
         IF g_sgl[l_ac].ta_sgl32 = '3' THEN 
            CALL cl_set_comp_required("ta_sgl30",TRUE )
         ELSE 
            CALL cl_set_comp_required("ta_sgl30",FALSE )
         END IF

        #Add By Teval 180719 --start-- #By Hao200807 #By Hao211103 修改奖励基准
        AFTER FIELD ta_sgl30
          # Modify.........: By Hao230728
          # 屏蔽原来的
          {CASE
            WHEN g_sgl[l_ac].ta_sgl30 < 2
              LET g_sgl[l_ac].ta_sgl31 = 0
            WHEN g_sgl[l_ac].ta_sgl30 = 2
              LET g_sgl[l_ac].ta_sgl31 = 0.2*(nvl(g_sgl[l_ac].ta_sgl02,0)/60)
            WHEN g_sgl[l_ac].ta_sgl30 = 3
              LET g_sgl[l_ac].ta_sgl31 = 0.25*(nvl(g_sgl[l_ac].ta_sgl02,0)/60)
            WHEN g_sgl[l_ac].ta_sgl30 >= 4
              LET g_sgl[l_ac].ta_sgl31 = 0.3*(nvl(g_sgl[l_ac].ta_sgl02,0)/60)
            OTHERWISE
              INITIALIZE g_sgl[l_ac].ta_sgl31 TO NULL
          END CASE}
          LET g_sgl[l_ac].ta_sgl31 = 0
          IF g_sgl[l_ac].ta_sgl30>0 AND g_sgl[l_ac].ta_sgl37>0 AND g_sgl[l_ac].ta_sgl04>0 THEN 
            LET l_base = 0
            CASE WHEN g_sgl[l_ac].ta_sgl30=1 LET l_base = 0
                 WHEN g_sgl[l_ac].ta_sgl30=2 LET l_base = 0.45
                 WHEN g_sgl[l_ac].ta_sgl30=3 LET l_base = 0.5
                 WHEN g_sgl[l_ac].ta_sgl30=4 LET l_base = 0.6
                 WHEN g_sgl[l_ac].ta_sgl30>4 LET l_base = 0.6+(g_sgl[l_ac].ta_sgl30-4)*0.1
            END CASE 

            IF g_sgl[l_ac].ta_sgl32 = '3' THEN
               LET l_base1 = 0.5
            ELSE 
               LET l_base1 = 1
            END IF 
            LET g_sgl[l_ac].ta_sgl31 = (g_sgl[l_ac].ta_sgl30*60)/(g_sgl[l_ac].ta_sgl04*g_sgl[l_ac].ta_sgl37)*l_base*(g_sgl[l_ac].ta_sgl02/60)*l_base1
          END IF 
          DISPLAY BY NAME g_sgl[l_ac].ta_sgl31
          # Modify.........: By Hao230728
          
        #Add By Teval 180719 --end--

        # Modify.........: By Hao230728
        AFTER FIELD ta_sgl37
           LET g_sgl[l_ac].ta_sgl31 = 0
           IF g_sgl[l_ac].ta_sgl30>0 AND g_sgl[l_ac].ta_sgl37>0 AND g_sgl[l_ac].ta_sgl04>0 THEN 
            LET l_base = 0
            CASE WHEN g_sgl[l_ac].ta_sgl30=1 LET l_base = 0
                 WHEN g_sgl[l_ac].ta_sgl30=2 LET l_base = 0.45
                 WHEN g_sgl[l_ac].ta_sgl30=3 LET l_base = 0.5
                 WHEN g_sgl[l_ac].ta_sgl30=4 LET l_base = 0.6
                 WHEN g_sgl[l_ac].ta_sgl30>4 LET l_base = 0.6+(g_sgl[l_ac].ta_sgl30-4)*0.1
            END CASE 
            IF g_sgl[l_ac].ta_sgl32 = '3' THEN
               LET l_base1 = 0.5
            ELSE 
               LET l_base1 = 1
            END IF 
            LET g_sgl[l_ac].ta_sgl31 = (g_sgl[l_ac].ta_sgl30*60)/(g_sgl[l_ac].ta_sgl04*g_sgl[l_ac].ta_sgl37)*l_base*(g_sgl[l_ac].ta_sgl02/60)*l_base1
          END IF 
          DISPLAY BY NAME g_sgl[l_ac].ta_sgl31
        # Modify.........: By Hao230728

{   
          	LET g_sgl[l_ac].ta_sgl02=g_sgl[l_ac].sgl11-g_sgl[l_ac].ta_sgl01
#        BEFORE FIELD ta_sgl03    #理论标工
        	  SELECT ecb19 INTO g_sgl[l_ac].ta_sgl03 FROM ecb_file
        	     WHERE ecb01=g_sgl[l_ac].sgl05 AND ecb02=g_sgl[l_ac].ta_sgl06
        	       AND ecb03=g_sgl[l_ac].sgl06 AND ecb012=g_sgl[l_ac].sgl012
        AFTER FIELD sgl08       #报废数=生产总数-良品数
          	LET g_sgl[l_ac].sgl09=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].sgl08
#        BEFORE FIELD ta_sgl08    #不良率=不良数/生产总数*100%
          	LET g_sgl[l_ac].ta_sgl08=g_sgl[l_ac].sgl09/g_sgl[l_ac].ta_sgl05*100
#        BEFORE FIELD ta_sgl09    #基准(PCS/H)=3600秒/实际标准工时
          	LET g_sgl[l_ac].ta_sgl09=3600/g_sgl[l_ac].ta_sgl04

        AFTER FIELD ta_sgl17     #达成率基准....更新应完成数量ta_sgl10
#        BEFORE FIELD ta_sgl10    #应完成数量=正常工时(分)*60/实际标准工时*基准
          	LET g_sgl[l_ac].ta_sgl10=g_sgl[l_ac].ta_sgl02*60/g_sgl[l_ac].ta_sgl04*g_sgl[l_ac].ta_sgl17/100
#        BEFORE FIELD ta_sgl11    #奖惩单价(元)=估算金额/8/3600秒/实际标准工时
          	LET g_sgl[l_ac].ta_sgl11=1/8/3600/g_sgl[l_ac].ta_sgl04*(g_sgl[l_ac].sgl08-g_sgl[l_ac].ta_sgl10)
#        BEFORE FIELD ta_sgl12    #超基准数=良品数-应完成数
          	LET g_sgl[l_ac].ta_sgl12=g_sgl[l_ac].sgl08-g_sgl[l_ac].ta_sgl10
#        BEFORE FIELD ta_sgl13    #奖励金额=奖惩单价*超基准数
          	LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12
#        BEFORE FIELD ta_sgl14    #低于基准数=应完成数-良品数
          	LET g_sgl[l_ac].ta_sgl14=g_sgl[l_ac].ta_sgl10-g_sgl[l_ac].sgl08

}
#-------------------#不作检查    hwj151201-------start
#        AFTER FIELD sgl08         
#           IF NOT t705_sgl08_check(p_cmd,l_skh12) THEN NEXT FIELD sgl08 END IF   #No.FUN-BB0086
           #No.FUN-BB0086--mark--start--
           #IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl08 !=g_sgl_t.sgl08) THEN
           #   CALL t705_sgl08(g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING l_skh12
           #    IF g_sgl[l_ac].sgl08 <0  THEN 
           #       CALL cl_err('','aim-223',0)
           #       NEXT FIELD sgl08
           #    END IF
           #    IF g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09>l_skh12  THEN 
           #      CALL cl_err('','asf-252',0)
           #      NEXT FIELD sgl08
           #    END IF
           #END IF  
           #No.FUN-BB0086--mark--end--
          
#-------------------------hwj151201---END--------------------
        #Modify By Hao160423 添加不良数量字段--begin
	      AFTER FIELD ta_sgl20
           IF cl_null(g_sgl[l_ac].ta_sgl20)  THEN
             LET g_sgl[l_ac].ta_sgl20=0
           END IF

           IF g_sgl[l_ac].ta_sgl20<0 THEN 
               CALL cl_err('','aim-223',0)
             NEXT FIELD ta_sgl20
             END IF
             #IF g_sgl[l_ac].ta_sgl20+g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09 > g_sgl[l_ac].ta_sgl05 THEN
             #  CALL cl_err('','abm-010',0)
               #  NEXT FIELD ta_sgl20	      
             #END IF
           LET g_sgl[l_ac].sgl08=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].sgl09
             CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
            
        #Modify By Hao160423 添加不良数量字段--end
        AFTER FIELD sgl09  
          IF cl_null(g_sgl[l_ac].sgl09)  THEN
             LET g_sgl[l_ac].sgl09=0
          END IF
           #No.FUN-BB0086--add--start--
          IF NOT cl_null(g_sgl[l_ac].sgl09) AND NOT cl_null(g_sgl[l_ac].sgl10) THEN
              IF cl_null(g_sgl_t.sgl09) OR g_sgl_t.sgl09 != g_sgl[l_ac].sgl09 THEN
                 LET g_sgl[l_ac].sgl09=s_digqty(g_sgl[l_ac].sgl09, g_sgl[l_ac].sgl10)
                 DISPLAY BY NAME g_sgl[l_ac].sgl09
              END IF
          END IF 
	         #Modify By Hao160423 报废数量更改时更新数据--begin
          IF g_sgl[l_ac].ta_sgl09<0 THEN 
	            CALL cl_err('','aim-223',0)
             NEXT FIELD sgl09
	         END  IF 
          #IF (g_sgl[l_ac].ta_sgl20+g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09) > g_sgl[l_ac].ta_sgl05 THEN
	         #   CALL cl_err('','abm-010',0)
	         #   NEXT FIELD sgl09	      
	         #END IF
          LET g_sgl[l_ac].sgl08=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].sgl09 
          CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
          #Modify By Hao160423 报废数量更改时更新数据--end
	   #No.FUN-BB0086--add--end--
{           IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl09 !=g_sgl_t.sgl09) THEN
             CALL t705_sgl08(g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING l_skh12
               IF g_sgl[l_ac].sgl09 <0  THEN 
                  CALL cl_err('','aim-223',0)
                  NEXT FIELD sgl09
               END IF
               IF g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09>l_skh12 THEN 
                 CALL cl_err('','asf-252',0)
                 NEXT FIELD sgl09
               END IF
           END IF} 
        # Modify.........: By Hao171101 设定超基准数的管控--begin
        AFTER FIELD ta_sgl21
          IF cl_null(g_sgl[l_ac].ta_sgl21)  THEN
             LET g_sgl[l_ac].ta_sgl21 = 0
          END IF
          IF g_sgl[l_ac].ta_sgl21 > g_sgl[l_ac].ta_sgl05 THEN
             CALL cl_err('','abm-010',0)
             NEXT FIELD ta_sgl21
          END IF
          CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
        # Modify.........: By Hao171101 设定超基准数的管控--end
        
        BEFORE DELETE
          IF g_sgl_t.sgl02 IS NOT NULL THEN
             IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
             END IF
             IF l_lock_sw="Y"  THEN
                 CALL cl_err("",-263,1)
                 CANCEL DELETE
             END IF
             DELETE FROM sgl_file
                WHERE  sgl01=g_sgk.sgk01
                AND sgl02=g_sgl_t.sgl02
             IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
                  CALL cl_err('',SQLCA.sqlcode,0)
                  ROLLBACK WORK
                  CANCEL DELETE
             END IF
             LET g_rec_b=g_rec_b-1
        #     DISPLAY g_rec_b TO FORMONLY.cnt2 
          END IF
          COMMIT WORK 
 
        ON ROW CHANGE 
          IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG=0
              LET g_sgl[l_ac].*=g_sgl_t.*
              CLOSE t705_bcl
              ROLLBACK WORK
              EXIT INPUT
          END IF
          IF l_lock_sw='Y' THEN
              CALL cl_err('',-263,1)
              LET g_sgl[l_ac].*=g_sgl_t.* 
          ELSE
              IF g_sgl[l_ac].ta_sgl05 <> g_sgl[l_ac].sgl08+g_sgl[l_ac].ta_sgl20+g_sgl[l_ac].sgl09 THEN
                 CALL cl_err('','abm-010',0)
                 NEXT FIELD sgl08 
              END IF
              UPDATE sgl_file SET sgl02=g_sgl[l_ac].sgl02,
                                  sgl03=g_sgl[l_ac].sgl03,
                                  sgl04=g_sgl[l_ac].sgl04,
                                  sgl05=g_sgl[l_ac].sgl05,
                                  sgl06=g_sgl[l_ac].sgl06,
                                  sgl07=g_sgl[l_ac].sgl07,
                                  ta_sgl19=g_sgl[l_ac].ta_sgl19,
                                  sgl08=g_sgl[l_ac].sgl08,
                                  ta_sgl20=g_sgl[l_ac].ta_sgl20,
                                  sgl09=g_sgl[l_ac].sgl09,
                                  sgl10=g_sgl[l_ac].sgl10,
                                  sgl11=g_sgl[l_ac].sgl11,
                                  sgl12=g_sgl[l_ac].sgl12,
                                  sgl13=g_sgl[l_ac].sgl13,
                                  ta_sgl01=g_sgl[l_ac].ta_sgl01,
                                  ta_sgl02=g_sgl[l_ac].ta_sgl02,
                                  ta_sgl03=g_sgl[l_ac].ta_sgl03,
                                  ta_sgl04=g_sgl[l_ac].ta_sgl04,
                                  ta_sgl05=g_sgl[l_ac].ta_sgl05,
                                  ta_sgl06=g_sgl[l_ac].ta_sgl06,
                                  ta_sgl07=g_sgl[l_ac].ta_sgl07,
                                  ta_sgl08=g_sgl[l_ac].ta_sgl08,
                                  ta_sgl09=g_sgl[l_ac].ta_sgl09,
                                  ta_sgl10=g_sgl[l_ac].ta_sgl10,
                                  ta_sgl11=g_sgl[l_ac].ta_sgl11,
                                  ta_sgl12=g_sgl[l_ac].ta_sgl12,
                                  ta_sgl21=g_sgl[l_ac].ta_sgl21,
                                  ta_sgl23=g_sgl[l_ac].ta_sgl23,
                                  ta_sgl13=g_sgl[l_ac].ta_sgl13,
                                  ta_sgl30=g_sgl[l_ac].ta_sgl30,
                                  ta_sgl37=g_sgl[l_ac].ta_sgl37, # Modify.........: By Hao230728
                                  ta_sgl31=g_sgl[l_ac].ta_sgl31,
                                  ta_sgl14=g_sgl[l_ac].ta_sgl14,
                                  ta_sgl16=g_sgl[l_ac].ta_sgl16,
                                  ta_sgl24=g_sgl[l_ac].ta_sgl24,
                                  ta_sgl17=g_sgl[l_ac].ta_sgl17,
                                  ta_sgl22=g_sgl[l_ac].ta_sgl22,
                                  ta_sgl18=g_sgl[l_ac].ta_sgl18,
                                  ta_sgl25=g_sgl[l_ac].ta_sgl25,# Modify By Hao170606 添加字段员工姓名ta_sgl25替换gen02
                                  ta_sgl26=g_sgl[l_ac].ta_sgl26,# Modify By Hao170607 添加字段进厂日期ta_sgl26
                                  ta_sgl27=g_sgl[l_ac].ta_sgl27,# Modify By Hao171201 添加工时备注字段ta_sgl27
                                  ta_sgl28=g_sgl[l_ac].ta_sgl28,# Modify By Hao171214 添加工艺备注字段ta_sgl28
                                  ta_sgl29=g_sgl[l_ac].ta_sgl29, # Add By Teval 180322
                                  ta_sgl32=g_sgl[l_ac].ta_sgl32, # By Hao210120
                                  ta_sgl33=g_sgl[l_ac].ta_sgl33,
                                  ta_sgl34=g_sgl[l_ac].ta_sgl34,
                                  ta_sgl35=g_sgl[l_ac].ta_sgl35,
                                  ta_sgl36=g_sgl[l_ac].ta_sgl36
              WHERE  sgl01=g_sgk.sgk01 AND sgl02=g_sgl_t.sgl02
              IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
                  CALL cl_err('',SQLCA.sqlcode,0)
                  LET g_sgl[l_ac].*=g_sgl_t.* 
              ELSE
                  MESSAGE 'UPDATE O.K'
                  COMMIT WORK
              END IF
           END IF
 
        AFTER ROW
          LET l_ac=ARR_CURR()
         #LET l_ac_t=l_ac      #FUN-D40030 Mark
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG=0
             IF p_cmd='u' THEN
                LET g_sgl[l_ac].*=g_sgl_t.*
             #FUN-D40030--add--str--
             ELSE
                CALL g_sgl.deleteElement(l_ac)
                IF g_rec_b != 0 THEN
                   LET g_action_choice = "detail"
                   LET l_ac = l_ac_t
                END IF
             #FUN-D40030--add--end--
             END IF
             CLOSE t705_bcl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          
          LET l_ac_t=l_ac      #FUN-D40030 Add
          CLOSE t705_bcl
          COMMIT WORK
 
        ON ACTION CONTROLP
          CASE
            WHEN INFIELD(sgl12)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form      = "q_gen"
                 LET g_qryparam.default1  = g_sgl[l_ac].sgl12
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].sgl12
                 CALL FGL_DIALOG_SETBUFFER(g_sgl[l_ac].sgl12)
#                 CALL t705_sgl12('d')
                 NEXT FIELD sgl12
             WHEN INFIELD(sgl04)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form      = "q_sgl04"
                 LET g_qryparam.default1  = g_sgl[l_ac].sgl04
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].sgl04
                 CALL FGL_DIALOG_SETBUFFER(g_sgl[l_ac].sgl04)
                 CALL t705_sgl04('d')
                 NEXT FIELD sgl04
             WHEN INFIELD(ta_sgl06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form      = "cq_ecu02"
                 LET g_qryparam.construct="N" #不用输查询条件,默认全显示
                 LET g_qryparam.arg1=g_sgl[l_ac].sgl05
                 LET g_qryparam.arg2=g_sgl[l_ac].sgl04  #Modify By Hao160716 传参数工单编号
                 LET g_qryparam.default1  = g_sgl[l_ac].ta_sgl06
                 LET g_qryparam.default2  = g_sgl[l_ac].sgl012
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].ta_sgl06,g_sgl[l_ac].sgl012  #Modify By Hao160716 修改工艺编号的开窗，去除工艺编号备注的取值
                 NEXT FIELD ta_sgl06
             WHEN INFIELD(sgl06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form      = "cq_sgl07"

                 LET g_qryparam.construct="N"
                 LET g_qryparam.arg1=g_sgl[l_ac].sgl04
                 LET g_qryparam.arg2=g_sgl[l_ac].ta_sgl06
                 LET g_qryparam.arg3=g_sgl[l_ac].sgl012
                 LET g_qryparam.default1  = g_sgl[l_ac].sgl06
                 LET g_qryparam.default2  = g_sgl[l_ac].ta_sgl18
                 LET g_qryparam.default3  = g_sgl[l_ac].sgl07
                 LET g_qryparam.default4  = g_sgl[l_ac].ta_sgl27 # Modify By Hao171201 添加工时备注字段ta_sgl27
                 LET g_qryparam.default5  = g_sgl[l_ac].ta_sgl28 # Modify By Hao171214 添加工艺备注字段ta_sgl28
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].sgl06,g_sgl[l_ac].ta_sgl18,g_sgl[l_ac].sgl07,g_sgl[l_ac].ta_sgl28,g_sgl[l_ac].ta_sgl27
                 CALL FGL_DIALOG_SETBUFFER(g_sgl[l_ac].sgl06)
                 NEXT FIELD sgl06
             WHEN INFIELD(sgl07)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form      = "q_sgl07"
                 LET g_qryparam.construct="N" #不用输查询条件,默认全显示
                 LET g_qryparam.arg1=g_sgl[l_ac].sgl04
                 LET g_qryparam.arg2=g_sgl[l_ac].sgl06
                 LET g_qryparam.default1  = g_sgl[l_ac].sgl07
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].sgl07
                 CALL FGL_DIALOG_SETBUFFER(g_sgl[l_ac].sgl07)
                 NEXT FIELD sgl07  
             #FUN-A60027------------------start---------------
             WHEN INFIELD(sgl012)
                 CALL cl_init_qry_var()
#                 LET g_qryparam.form  = "q_sgl012"
                 LET g_qryparam.form  = "q_ecb012_1"
                 LET g_qryparam.construct="N" #不用输查询条件,默认全显示
                 LET g_qryparam.arg1  = g_sgl[l_ac].sgl04
                 LET g_qryparam.default1  = g_sgl[l_ac].sgl012
                 CALL cl_create_qry() RETURNING g_sgl[l_ac].sgl012
                 CALL FGL_DIALOG_SETBUFFER(g_sgl[l_ac].sgl012)
                 NEXT FIELD sgl012
            #FUN-A60027 -----------------end----------------   
           END CASE
 
        #ON ACTION CONTROLZ   #TQC-C50082 mark                                                   
        ON ACTION CONTROLR    #TQC-C50082 add                                                  
           CALL cl_show_req_fields()                                            
        
        # Modify.........: By Hao170525 添加controlo复制单身--begin
        ON ACTION CONTROLO
           IF INFIELD(sgl02) AND l_ac > 1  THEN
              LET g_sgl[l_ac].* = g_sgl[l_ac-1].*
              SELECT MAX(sgl02)+1 INTO g_sgl[l_ac].sgl02 FROM sgl_file
              WHERE sgl01=g_sgk.sgk01
              IF g_sgl[l_ac].sgl02 IS NULL  THEN
                 LET g_sgl[l_ac].sgl02 = 1                        
              END IF  
              NEXT FIELD sgl02
           END IF
        # Modify.........: By Hao170525 添加controlo复制单身--end
                                                                                
        ON ACTION CONTROLG                                                      
           CALL cl_cmdask()
 
        ON IDLE g_idle_seconds                                                   
          CALL cl_on_idle()                                                     
          CONTINUE INPUT                                                        
                                                                                
    END INPUT
    CLOSE t705_bcl
    COMMIT WORK
    
    CALL t705_delHeader()     #CHI-C30002 add
END FUNCTION

#CHI-C30002 -------- add -------- begin
FUNCTION t705_delHeader()
   DEFINE l_action_choice    STRING               #CHI-C80041
   DEFINE l_cho              LIKE type_file.num5  #CHI-C80041
   DEFINE l_num              LIKE type_file.num5  #CHI-C80041
   DEFINE l_slip             LIKE type_file.chr5  #CHI-C80041
   DEFINE l_sql              STRING               #CHI-C80041
   DEFINE l_cnt              LIKE type_file.num5  #CHI-C80041
   
   IF g_rec_b = 0 THEN
      #CHI-C80041---begin
      CALL s_get_doc_no(g_sgk.sgk01) RETURNING l_slip
      LET l_sql = " SELECT COUNT(*) FROM sgk_file ",
                  "  WHERE sgk01 LIKE '",l_slip,"%' ",
                  "    AND sgk01 > '",g_sgk.sgk01,"'"
      PREPARE t705_pb1 FROM l_sql 
      EXECUTE t705_pb1 INTO l_cnt       
      
      LET l_action_choice = g_action_choice
      LET g_action_choice = 'delete'
      IF cl_chk_act_auth() AND l_cnt = 0 THEN
         CALL cl_getmsg('aec-130',g_lang) RETURNING g_msg
         LET l_num = 3
      ELSE
         CALL cl_getmsg('aec-131',g_lang) RETURNING g_msg
         LET l_num = 2
      END IF 
      LET g_action_choice = l_action_choice
      PROMPT g_msg CLIPPED,': ' FOR l_cho
         ON IDLE g_idle_seconds
            CALL cl_on_idle()

         ON ACTION about     
            CALL cl_about()

         ON ACTION help         
            CALL cl_show_help()

         ON ACTION controlg   
            CALL cl_cmdask() 
      END PROMPT
      IF l_cho > l_num THEN LET l_cho = 1 END IF 
      IF l_cho = 2 THEN 
        #CALL t705_v()    #CHI-D20010
         CALL t705_v(1)   #CHI-D20010
         CALL t705_show_pic()
      END IF 
      
      IF l_cho = 3 THEN 
      #CHI-C80041---end
      #IF cl_confirm("9042") THEN  #CHI-C80041
         DELETE FROM sgk_file WHERE sgk01 = g_sgk.sgk01
         INITIALIZE g_sgk.* TO NULL
         CLEAR FORM
      END IF
   END IF
END FUNCTION
#CHI-C30002 -------- add -------- end


FUNCTION t705_b_asfkey()
DEFINE
    l_wc           STRING      #NO.FUN-910082
 
    CONSTRUCT l_wc ON sgl02,sgl12,gen02,sgl03,sgl04,sgl05,ima02,sgl012,sgl06,       #FUN-A60027 add by huangtao
                       sgl07,ta_sgl19,sgl08,ta_sgl20,sgl09,sgl10,sgl11,sgl13
                  FROM s_sgl[1].sgl02,s_sgl[1].sgl12,s_sgl[1].gen02,
                       s_sgl[1].sgl03,s_sgl[1].sgl04,s_sgl[1].sgl05,
                       s_sgl[1].ima02,s_sgl[1].sgl012,s_sgl[1].sgl06,               #FUN-A60027 add by huangtao
                       s_sgl[1].sgl07,s_sgl[1].ta_sgl19,s_sgl[1].sgl08,s_sgl[1].ta_sgl20,s_sgl[1].sgl09,
                       s_sgl[1].sgl10,s_sgl[1].sgl11,s_sgl[1].sgl13                  
   
        ON IDLE g_idle_seconds 
          CALL cl_on_idle() 
          CONTINUE CONSTRUCT
  
    END CONSTRUCT
    LET g_wc = g_wc CLIPPED,cl_get_extra_cond('sgkuser', 'sgkgrup') #FUN-980030
    IF INT_FLAG THEN RETURN END IF 
    CALL t705_b_fill(l_wc)
 
END FUNCTION
 
FUNCTION t705_b_fill(p_wc)              #BODY FILL UP
DEFINE 
     p_wc           STRING      #NO.FUN-910082
   
#    LET g_sql = 
#       "SELECT sgl02,sgl12,gen02,sgl03,sgl04,sgl05,ima02,sgl012,sgl06,sgl07,sgl08,",    #FUN-A60027 add by  huangtao
#       "sgl09,sgl10,sgl11,sgl13",
#       " FROM sgl_file LEFT OUTER JOIN gen_file ON sgl12=gen01 LEFT OUTER JOIN ima_file ON sgl05 = ima01 ", #No.TQC-9A0130
#       " WHERE sgl01='",g_sgk.sgk01,"'"
    {LET g_sql="SELECT sgl02,sgl03,sgl04,sgl05,ima02,ta_sgl06,ta_sgl07,ta_sgl18,sgl012,sgl06,sgl07,sga02,sgl11,",    #Star151123 add sgl012
                     "ta_sgl01,ta_sgl02,ta_sgl03,ta_sgl04,ta_sgl05,",
                     "sgl08,sgl09,sgl10,",
                     "ta_sgl08,ta_sgl09,ta_sgl10,ta_sgl11,ta_sgl12,",
                     "ta_sgl13,ta_sgl14,ta_sgl15,sgl12,gen02,",
                     "ta_sgl16,ta_sgl17,sgl13",
                     " FROM sgl_file LEFT OUTER JOIN gen_file ON sgl12 = gen01 LEFT OUTER JOIN ima_file ON sgl05 = ima01",  #No.TQC-9A0130
                     " LEFT OUTER JOIN sga_file ON sga01=sgl07 ",
                     " WHERE sgl01='",g_sgk.sgk01,"'"}
    # Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
     # Modify.........: By Hao170606 添加字段员工姓名ta_sgl25替换gen02
     # Modify.........: By Hao170607 添加字段进厂日期ta_sgl26    # Modify By Hao171201 添加工时备注字段ta_sgl27 # Modify By Hao171214 添加工艺备注字段ta_sgl28
     LET g_sql="SELECT sgl02,sgl03,sgl04,sgl05,ima02,ta_sgl06,ta_sgl07,ta_sgl18,sgl012,sgl06,sgl07,sga02,ta_sgl28,ta_sgl27,",
                     "ta_sgl29,ta_sgl33,ta_sgl34,ta_sgl35,ta_sgl36,ta_sgl32,",#Add By Teval 180322
                     "ta_sgl19,sgl11,",    #Star151123 add sgl012
                     "ta_sgl01,ta_sgl02,ta_sgl03,ta_sgl04,ta_sgl05,",
                     "sgl08,ta_sgl20,sgl09,sgl10,",
                     "ta_sgl08,ta_sgl09,ta_sgl10,ta_sgl11,ta_sgl12,ta_sgl21,ta_sgl23,",
                     "ta_sgl13,",
                     "ta_sgl30,ta_sgl37,ta_sgl31,",#Add By Teval 180719 # Modify.........: By Hao230728
                     "ta_sgl14,sgl12,ta_sgl25,",
                     "ta_sgl16,ta_sgl24,ta_sgl26,ta_sgl17,ta_sgl22,sgl13",
                     " FROM sgl_file ",#LEFT OUTER JOIN gen_file ON sgl12 = gen01 
                     " LEFT OUTER JOIN ima_file ON sgl05 = ima01",  #No.TQC-9A0130
                     " LEFT OUTER JOIN sga_file ON sga01=sgl07 ",
                     " WHERE sgl01='",g_sgk.sgk01,"'"
    IF NOT cl_null(p_wc) THEN
       LET g_sql=g_sql CLIPPED," AND ",p_wc CLIPPED 
    END IF
    # Modify By Hao170607 按项次排序
    LET g_sql=g_sql clipped," ORDER BY sgl02"
    LET g_sql=g_sql CLIPPED
 
    PREPARE t705_prepare2 FROM g_sql      #預備
    DECLARE sgl_cs CURSOR FOR t705_prepare2
 
    CALL g_sgl.clear()
 
    LET g_cnt = 1
 
    FOREACH sgl_cs INTO g_sgl[g_cnt].*   #單身 ARRAY 填
        IF SQLCA.sqlcode THEN 
            CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
            EXIT FOREACH 
        END IF 
        # Modify By Hao170419 取人事档案资料
#        SELECT hr02 INTO g_sgl[g_cnt].gen02 
#        FROM hr_view a WHERE  a.hr01=g_sgl[g_cnt].sgl12 
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN 
           CALL cl_err('',9035,0)
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_sgl.deleteElement(g_cnt)
    LET g_rec_b=g_cnt-1
 
#    DISPLAY g_rec_b TO FORMONLY.cnt2
    LET g_cnt = 0 
 
END FUNCTION
                  
FUNCTION t705_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN 
      RETURN
   END IF
 
   LET g_action_choice = " " 
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DISPLAY g_dummy TO dummy1 #Add By Teval 180322
    
   DISPLAY ARRAY g_sgl TO s_sgl.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
  
   BEFORE DISPLAY 
       CALL cl_navigator_setting( g_curs_index, g_row_count )
 
   BEFORE ROW
       LET l_ac = ARR_CURR()
 
   ##########################################################################
   # Standard 4ad ACTION 
   ##########################################################################
    ON ACTION insert 
         LET g_action_choice="insert"
         EXIT DISPLAY 
         
    ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
         
    ON ACTION DELETE
         LET g_action_choice="delete" 
         EXIT DISPLAY
          
    ON ACTION FIRST
         CALL t705_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DISPLAY
 
    ON ACTION PREVIOUS
         CALL t705_fetch('P') 
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DISPLAY
 
    ON ACTION reproduce                                                         
         LET g_action_choice="reproduce"                                          
         EXIT DISPLAY 
         
    ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
 
    ON ACTION invalid 
         LET g_action_choice="invalid" 
         EXIT DISPLAY
 
    ON ACTION jump
         CALL t705_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DISPLAY
 
     ON ACTION NEXT
         CALL t705_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DISPLAY
 
     ON ACTION LAST
         CALL t705_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1) 
         ACCEPT DISPLAY
 
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
 
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
 
      ON ACTION notconfirm 
         LET g_action_choice="notconfirm"
         EXIT DISPLAY
      #CHI-C80041---begin
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
      #CHI-C80041---end
      #CHI-D20010---begin
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
      #CHI-D20010---end
      
      # Modify By Hao170704 添加ACTION可以在审核后修改单身资料--begin
      ON ACTION mod_data
         LET g_action_choice="mod_data"
         EXIT DISPLAY 
      # Modify By Hao170704 添加ACTION可以在审核后修改单身资料--end

      #Add By Teval 190308 --start--
      ON ACTION distribution
         LET g_action_choice="distribution"
         EXIT DISPLAY
      #Add By Teval 190308 --end--

      ON ACTION help 
         LET g_action_choice="help"
         EXIT DISPLAY 
 
      ON ACTION locale
         CALL cl_dynamic_locale()
     
      ON ACTION EXIT
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ##########################################################################
      # Special 4ad ACTION                                                      
      ##########################################################################
 
#Add By Wang170620 切换到资料清单 begin
      ON ACTION info_list
         LET g_action_flag = "info_list"  
         EXIT DISPLAY
#Add By Wang170620 切换到资料清单 end 

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
 
      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
    END DISPLAY 
    CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION


# Add _bp1() By Wang170620 begin
FUNCTION t705_bp1(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1  
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_sgl_l TO s_sgl_l.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
 
      BEFORE DISPLAY
         IF g_rec_b1 > 0 AND g_curs_index > 0 THEN 
           CALL fgl_set_arr_curr(g_cnt_ac[g_curs_index].ac)
         ELSE 
           CALL fgl_set_arr_curr(1)
         END IF 
 
      BEFORE ROW
         LET l_ac1 = ARR_CURR()
         CALL cl_show_fld_cont()               
 

      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################
         
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY         

      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()     
          CALL t705_show_pic()           
         EXIT DISPLAY            

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY          

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
    
      ON ACTION main
         LET g_action_flag = "main"
         IF g_rec_b1 > 0 THEN 
           LET g_jump = g_cnt_ac[l_ac1].cnt
           LET g_no_ask = TRUE
           CALL t705_fetch('/')
           DISPLAY g_cnt_ac[l_ac1].cnt TO FORMONLY.cnt
         END IF 
         EXIT DISPLAY

      ON ACTION ACCEPT
         LET g_action_flag = "main"
         IF g_rec_b1 > 0 THEN 
           LET g_jump = g_cnt_ac[l_ac1].cnt
           LET g_no_ask = TRUE
           CALL t705_fetch('/')
           DISPLAY g_cnt_ac[l_ac1].cnt TO FORMONLY.cnt
         END IF  
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

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY                
         
      &include "qry_string.4gl"
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION 
 # Add _bp1() By Wang170620 end 


 
FUNCTION t705_x()
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   IF g_sgk.sgk01 IS NULL OR g_sgk.sgk03 IS NULL  THEN 
      CALL cl_err("",-400,0)
      RETURN 
   END IF
   IF g_sgk.sgk07 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   
   BEGIN WORK
 
   OPEN t705_crl USING g_sgk.sgk01                    #09/10/21 xiaofeizhu Add
   IF STATUS THEN
      CALL cl_err("OPEN t705_crl:", STATUS, 1)
      CLOSE t705_crl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t705_crl INTO g_sgk.*                        #鎖住將被更改或取消的資
   IF SQLCA.sqlcode THEN 
      CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)        #資料被他人LOCK
      ROLLBACK WORK 
      RETURN 
   END IF
 
   LET g_success = 'Y'
 
   CALL t705_show()
 
   IF cl_exp(0,0,g_sgk.sgkacti) THEN                  #確認
      LET g_chr=g_sgk.sgkacti
      IF g_sgk.sgkacti='Y' THEN
         LET g_sgk.sgkacti='N'
      ELSE
         LET g_sgk.sgkacti='Y'
      END IF
 
      UPDATE sgk_file SET sgkacti=g_sgk.sgkacti,
                          sgkmodu=g_user,
                          sgkdate=g_today 
       WHERE sgk01=g_sgk.sgk01 AND sgk03=g_sgk.sgk03
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err3("upd","sgk_file",g_sgk.sgk01,"",SQLCA.sqlcode,"","",1)
         LET g_sgk.sgkacti=g_chr
      END IF
   END IF
 
   IF g_success = 'Y' THEN
      COMMIT WORK
      CALL cl_flow_notify(g_sgk.sgk01,'V')
   ELSE
      ROLLBACK WORK 
   END IF 
 
   SELECT sgkacti,sgkmodu,sgkdate
     INTO g_sgk.sgkacti,g_sgk.sgkmodu,g_sgk.sgkdate FROM sgk_file  
    WHERE sgk01=g_sgk.sgk01 
   DISPLAY BY NAME g_sgk.sgkacti,g_sgk.sgkmodu,g_sgk.sgkdate 
END FUNCTION
 
FUNCTION t705_u()
 DEFINE  l_n    LIKE type_file.num5
 
   IF s_shut(0) THEN
      RETURN 
   END IF 
 
   IF g_sgk.sgk01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_n FROM sgl_file
      WHERE sgl_file.sgl01 = g_sgk.sgk01
   IF l_n >0 THEN 
      CALL cl_set_comp_entry("sgk05,sgk06",FALSE)
   ELSE 
   	  CALL cl_set_comp_entry("sgk05,sgk06",TRUE)
   END IF
   	        
   SELECT * INTO g_sgk.* FROM sgk_file
    WHERE sgk01=g_sgk.sgk01 
                                                                                
   IF g_sgk.sgkacti ='N' THEN    #檢查資料是否為無效
      CALL cl_err(g_sgk.sgk01,'mfg1000',0)
      RETURN
   END IF
 
   IF g_sgk.sgk07 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_sgk01_t = g_sgk.sgk01
 
   BEGIN WORK
 
   OPEN t705_crl USING g_sgk.sgk01                    #09/10/21 xiaofeizhu Add
 
   IF STATUS THEN 
      CALL cl_err("OPEN t705_crl:", STATUS, 1)
      CLOSE t705_crl 
      ROLLBACK WORK
      RETURN 
   END IF
  
    FETCH t705_crl INTO g_sgk.*                      # 鎖住將被更改或取消的資
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)      # 資料被他人LOCK 
       CLOSE t705_crl 
       ROLLBACK WORK
       RETURN 
   END IF
                                                                                
   CALL t705_show()
 
   WHILE TRUE
      LET g_sgk01_t = g_sgk.sgk01
      LET g_sgk.sgkmodu=g_user
      LET g_sgk.sgkdate=g_today
      
      CALL t705_i("u") 
      
      IF g_sgk.sgk01!=g_sgk01_t  THEN
         UPDATE  sgk_file SET sgk01=g_sgk.sgk01
            WHERE sgk01=g_sgk01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
            CALL cl_err3("upd","sgk_file",g_sgk01_t,"",SQLCA.sqlcode,"","sgk",1)
            CONTINUE WHILE
         END IF
      END IF
 
     IF INT_FLAG THEN
         LET INT_FLAG = 0 
         LET g_sgk.*=g_sgk_t.* 
         CALL t705_show() 
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF
 
      UPDATE sgk_file SET sgk_file.* = g_sgk.*                                  
       WHERE sgk01 = g_sgk01_t                          #No.TQC-9A0130 mod
 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         CALL cl_err3("upd","sgk_file","","",SQLCA.sqlcode,"","",1)             
         CONTINUE WHILE 
      END IF 
      EXIT WHILE
   END WHILE
 
   CLOSE t705_crl
   COMMIT WORK
   CALL cl_flow_notify(g_sgk.sgk01,'U')
 
END FUNCTION
 
FUNCTION t705_set_entry(p_cmd)
  DEFINE p_cmd      LIKE type_file.chr10
  
  IF p_cmd='a' AND (NOT g_before_input_done) THEN
     CALL cl_set_comp_entry("sgk01",TRUE)
  END IF
END FUNCTION
 
FUNCTION t705_set_no_entry(p_cmd)
  DEFINE p_cmd      LIKE type_file.chr10
  
  IF p_cmd='u' AND g_chkey='N' AND (NOT g_before_input_done) THEN 
     CALL cl_set_comp_entry("sgk01",FALSE)
  END IF                                                                        
END FUNCTION
 
FUNCTION t705_sgk03(p_cmd)
   DEFINE l_gen02   LIKE gen_file.gen02,
          l_genacti LIKE gen_file.genacti,
          p_cmd     like type_file.chr1
 
   LET g_errno=''
   SELECT gen02,genacti INTO l_gen02,l_genacti FROM gen_file
          WHERE gen01=g_sgk.sgk03
   
   CASE WHEN SQLCA.sqlcode=100 LET g_errno='mfg3006'
                          LET l_gen02=NULL
        WHEN l_genacti='N' LET g_errno='9028'
        OTHERWISE          LET g_errno=SQLCA.sqlcode USING '-------'
   END CASE
 
   IF cl_null(g_errno) OR p_cmd='d' THEN
     DISPLAY l_gen02 TO sgk03_gen02
   END IF
END FUNCTION
 
FUNCTION t705_sgl12(p_cmd)                                                      
   DEFINE l_gen02   LIKE gen_file.gen02,    #員工姓名                               
          l_genacti LIKE gen_file.genacti,                                      
          p_cmd     like type_file.chr1                                         
                                                                                
   LET g_errno=''                                                               
   SELECT gen02 INTO l_gen02 FROM gen_file                        
          WHERE gen01=g_sgl[l_ac].sgl12                                              
                                                                                
   CASE WHEN SQLCA.sqlcode=100 LET g_errno='mfg3006'                            
                          LET l_gen02=NULL                                      
        WHEN l_genacti='N' LET g_errno='9028'                                   
        OTHERWISE          LET g_errno=SQLCA.sqlcode USING '-------'           
   END CASE                                                                     
   
   IF cl_null(g_errno) OR p_cmd='d' THEN 
#   LET g_sgl[l_ac].gen02=l_gen02
   END IF
END FUNCTION 
 
FUNCTION t705_sgl04(p_cmd)                                                      
   DEFINE l_ima02   LIKE ima_file.ima02,
          l_imaacti LIKE ima_file.imaacti,
          l_ima55   LIKE ima_file.ima55,
          l_sfb05   LIKE sfb_file.sfb05,
          p_cmd     like type_file.chr1
 
   LET g_errno=''
   SELECT ima02,ima55,imaacti,sfb05 INTO l_ima02,l_ima55,l_imaacti,l_sfb05 
      FROM ima_file,sfb_file
          WHERE sfb_file.sfb01=g_sgl[l_ac].sgl04
          AND sfb_file.sfb05=ima_file.ima01
 
   CASE WHEN SQLCA.sqlcode=100 LET g_errno='mfg3006'
                          LET l_sfb05=NULL 
                          LET l_ima02=NULL
                          LET l_ima55=NULL
        WHEN l_imaacti='N' LET g_errno='9028'
        OTHERWISE          LET g_errno=SQLCA.sqlcode USING '-------'
   END CASE 
   IF cl_null(g_errno) OR p_cmd='d' THEN
     LET g_sgl[l_ac].sgl05=l_sfb05
     LET g_sgl[l_ac].ima02=l_ima02
     LET g_sgl[l_ac].sgl10=l_ima55
   END IF 
END FUNCTION 
 
FUNCTION t705_show_pic() 
  DEFINE l_chr   LIKE type_file.chr1
  DEFINE l_void  LIKE type_file.chr1  #CHI-C80041
      LET l_chr='N' 
      IF g_sgk.sgk07='Y' THEN
         LET l_chr="Y"
      END IF
      #CHI-C80041---begin
      LET l_void='N'
      IF g_sgk.sgk07='X' THEN
         LET l_void="Y"
      END IF
      #CHI-C80041---end
      #CALL cl_set_field_pic1(l_chr,"","","","",g_sgk.sgkacti,"","")  #CHI-C80041
      CALL cl_set_field_pic1(l_chr,"","","",l_void,g_sgk.sgkacti,"","")  #CHI-C80041
END FUNCTION
 
FUNCTION t705_confirm()
   DEFINE i LIKE type_file.num5
  IF cl_null(g_sgk.sgk01) THEN 
     CALL cl_err('',-400,0) 
     RETURN 
   END IF
#CHI-C30107 ------------- add -------------- begin
    IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041
    IF g_sgk.sgk07="Y" THEN
       CALL cl_err("",9023,1)
       RETURN
    END IF
    IF g_sgk.sgkacti="N" THEN
       CALL cl_err("",'aim-153',1)
    END IF
   IF NOT cl_confirm('aap-222') THEN RETURN END IF
   SELECT * INTO g_sgk.* FROM sgk_file WHERE sgk01 = g_sgk.sgk01
#CHI-C30107 ------------- add -------------- end
    IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041
    IF g_sgk.sgk07="Y" THEN 
       CALL cl_err("",9023,1)
       RETURN
    END IF
    IF g_sgk.sgkacti="N" THEN
       CALL cl_err("",'aim-153',1)
    ELSE 
#       IF cl_confirm('aap-222') THEN  #CHI-C30107 mark
            BEGIN WORK 

            UPDATE sgk_file
            SET sgk07="Y"
            WHERE sgk01=g_sgk.sgk01

        IF SQLCA.sqlcode THEN 
         CALL cl_err3("upd","sgk_file",g_sgk.sgk01,"",SQLCA.sqlcode,"","sgk07",1)
         ROLLBACK WORK
        ELSE 
            # Modify.........: By mo241111 审核后修改实际开工日期(sfb25)为报工日期
            LET g_sql="merge into sfb_file o",
                      " using (select distinct sgl04 from sgl_file where sgl01=?) s",
                      " on (s.sgl04=o.sfb01)",
                      " when matched then ",
                      "  update set sfb25=? ",
                      "   where sfb25 is null "
            PREPARE sfb_upd FROM g_sql
            EXECUTE sfb_upd USING g_sgk.sgk01,g_sgk.sgk02
            IF sqlca.sqlcode THEN 
               CALL cl_err3("upd","sgk_file",g_sgk.sgk01,"",SQLCA.sqlcode,"","sgk07",1)
               ROLLBACK WORK
            ELSE 
            # Modify.........: By mo241111 审核后修改实际开工日期(sfb25)为报工日期   
               COMMIT WORK
               LET g_sgk.sgk07="Y" 
               DISPLAY BY NAME g_sgk.sgk07
            END IF 
        END IF
      #  END IF #CHI-C30107 mark
     END IF
END FUNCTION
 
FUNCTION t705_notconfirm()
   IF cl_null(g_sgk.sgk01)  THEN
     CALL cl_err('',-400,0)
     RETURN 
   END IF
    IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041
    IF g_sgk.sgk07="N" OR g_sgk.sgkacti="N" THEN
       CALL cl_err("",'atm-365',1)
    ELSE 
        IF cl_confirm('aap-224') THEN
            BEGIN WORK
            UPDATE sgk_file
            SET sgk07="N"
            WHERE sgk01=g_sgk.sgk01
        IF SQLCA.sqlcode THEN 
         CALL cl_err3("upd","sgk_file",g_sgk.sgk01,"",SQLCA.sqlcode,"","sgk07",1)
         ROLLBACK WORK
        ELSE
            COMMIT WORK
            LET g_sgk.sgk07="N"
            DISPLAY BY NAME g_sgk.sgk07
        END IF
        END IF
     END IF
END FUNCTION
 
FUNCTION t705_copy()
   DEFINE l_sgk01     LIKE sgk_file.sgk01,
          l_osgk01    LIKE sgk_file.sgk01,
	      l_sgk02     LIKE sgk_file.sgk02
   DEFINE li_result   LIKE type_file.num5    #No.FUN-680136 SMALLINT
 
   IF s_shut(0) THEN RETURN END IF
   
   IF g_sgk.sgk07 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF   
 
   IF (g_sgk.sgk01 IS NULL) OR (g_sgk.sgk02 IS NULL) OR (g_sgk.sgk03 IS NULL) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   LET g_before_input_done = FALSE
   CALL t705_set_entry('a')
   DISPLAY ' ' TO FORMONLY.sgk03_gen02
   CALL cl_set_head_visible("","YES")           #No.FUN-6B0032 
   INPUT l_sgk01,l_sgk02 FROM sgk01,sgk02
      
      BEFORE INPUT
        LET l_sgk01 = '356'      #Add By Teval 190218 预设单别356
        DISPLAY l_sgk01 TO sgk01 #Add By Teval 190218 预设单别356
        
        CALL cl_set_docno_format("sgk01") 
   
      AFTER FIELD sgk01
         IF NOT cl_null(l_sgk01) THEN
           LET g_t1=l_sgk01[1,3]
           CALL s_check_no("asf",l_sgk01,"",'O',"sgk_file","sgk01","")
                 RETURNING li_result,l_sgk01
            DISPLAY l_sgk01 TO sgk01  #TQC-940121   
            IF (NOT li_result) THEN
               LET g_sgk.sgk01=g_sgk_t.sgk01
               NEXT FIELD sgk01
            END IF
            DISPLAY g_smy.smydesc TO smydesc
          END IF
       #Modify By Hao160425 复制时报工单号可以自动编码--begin
       AFTER FIELD sgk02
          IF cl_null(l_sgk02) THEN NEXT FIELD sgk02 END IF
          # Modify.........: By Hao180522 复制时因在输入日期后就取单据编号可能导致产生的单据编号有误，故修改为获取编号在输入字段完成后
           #屏蔽以下取值
          # BEGIN WORK #No:7857
          # CALL s_auto_assign_no("asf",l_sgk01,l_sgk02,"","sgk_file","sgk01","","","") RETURNING li_result,l_sgk01
          # IF (NOT li_result) THEN
          #    NEXT FIELD sgk01
          # END IF
          # DISPLAY l_sgk01 TO sgk01
          # Modify.........: By Hao180522 复制时因在输入日期后就取单据编号可能导致产生的单据编号有误，故修改为获取编号在输入字段完成后
       #Modify By Hao160425 复制时报工单号可以自动编码--end
       ON ACTION controlp
            CASE
              WHEN INFIELD(sgk01)
                 LET g_t1=s_get_doc_no(l_sgk01)
                 CALL q_smy(FALSE,TRUE,g_t1,'ASF','O') RETURNING g_t1
                 LET l_sgk01 = g_t1 
		 DISPLAY BY NAME l_sgk01
                 NEXT FIELD sgk01
              OTHERWISE EXIT CASE
           END CASE
 
     ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
     ON ACTION about 
        CALL cl_about()
 
     ON ACTION help 
        CALL cl_show_help()
 
     ON ACTION controlg
        CALL cl_cmdask()
 
 
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      DISPLAY BY NAME g_sgk.sgk01
      RETURN
   END IF
   # Modify.........: By Hao180522 复制时因在输入日期后就取单据编号可能导致产生的单据编号有误，故修改为获取编号在输入字段完成后
   BEGIN WORK 
   CALL s_auto_assign_no("asf",l_sgk01,l_sgk02,"","sgk_file","sgk01","","","") RETURNING li_result,l_sgk01
    IF (NOT li_result) THEN
       ROLLBACK WORK 
       RETURN  
    END IF
    DISPLAY l_sgk01 TO sgk01
   # Modify.........: By Hao180522 复制时因在输入日期后就取单据编号可能导致产生的单据编号有误，故修改为获取编号在输入字段完成后
   DROP TABLE y
 
   SELECT * FROM sgk_file         #單頭複製
       WHERE sgk01=g_sgk.sgk01
       INTO TEMP y
 
   UPDATE y
       SET sgk01=l_sgk01,    #新的鍵值
           sgk02=l_sgk02,    #报工日期
           sgkuser=g_user,   #資料所有者
           sgkgrup=g_grup,   #資料所有者所屬群
           sgkmodu=NULL,     #資料修改日期
           sgkdate=g_today,  #資料建立日期
           sgkacti='Y'       #有效資料
 
   INSERT INTO sgk_file SELECT * FROM y
 
   DROP TABLE x
 
   SELECT * FROM sgl_file         #單身複製
       WHERE sgl01=g_sgk.sgk01
       INTO TEMP x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","x","","",SQLCA.sqlcode,"","",1)  
      RETURN
   END IF
 
   UPDATE x SET sgl01=l_sgk01
 
   INSERT INTO sgl_file
       SELECT * FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","sgl_file","","",SQLCA.sqlcode,"","",1)     #FUN-B80086    ADD
      ROLLBACK WORK
     # CALL cl_err3("ins","sgl_file","","",SQLCA.sqlcode,"","",1)    #FUN-B80086    MARK
      RETURN
   ELSE
       COMMIT WORK 
   END IF
   LET g_cnt=SQLCA.SQLERRD[3]
   MESSAGE '(',g_cnt USING '##&',') ROW of (',l_sgk01,') O.K'
 
   LET l_osgk01 = g_sgk.sgk01
   SELECT sgk_file.* INTO g_sgk.*                                   #09/10/21 xiaofeizhu Add
     FROM sgk_file WHERE sgk01 = l_sgk01 
   CALL t705_u()
   CALL t705_b()
   #FUN-C80046---begin
   #SELECT sgk_file.* INTO g_sgk.*                                   #09/10/21 xiaofeizhu Add
   #FROM sgk_file WHERE sgk01 = l_osgk01 
   #CALL t705_show()
   #FUN-C80046---end
END FUNCTION					     
#若sgk05='Y',則輸入飛票號碼后，自動從飛票檔skh_file帶出工單編號，工序
#，單元編號，產品料號，產品名稱,良品數量，報工單位字段
FUNCTION t705_auto_b(p_cmd)
DEFINE
     p_cmd           LIKE type_file.chr1, 
     l_skh           RECORD
        skh13        LIKE skh_file.skh13,
        skh02        LIKE skh_file.skh02,
        skh03        LIKE skh_file.skh03,
        skh07        LIKE skh_file.skh07,
        skh08        LIKE skh_file.skh08
                     END RECORD,
     l_sgl           DYNAMIC ARRAY OF RECORD
        sgl01        LIKE sgl_file.sgl01,
        sgl02        LIKE sgl_file.sgl02,
        sgl03        LIKE sgl_file.sgl03,
        sgl04        LIKE sgl_file.sgl04,
        sgl05        LIKE sgl_file.sgl05,
        sgl06        LIKE sgl_file.sgl06,
        sgl07        LIKE sgl_file.sgl07,
        sgl08        LIKE sgl_file.sgl08,
        sgl09        LIKE sgl_file.sgl09,
        sgl10        LIKE sgl_file.sgl10,
        sgl11        LIKE sgl_file.sgl11,
        sgl12        LIKE sgl_file.sgl12
                     END RECORD,
     l_ac,l_n,l_n1            LIKE type_file.num5 
     IF g_sgk.sgk07='X' THEN RETURN END IF  #CHI-C80041
     IF g_sgk.sgk07 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
     
     IF g_sgk.sgk05!='Y' THEN
        CALL cl_err('','asf-257',0)
        RETURN
     END IF
     
     IF p_cmd = 'u' THEN 
       SELECT COUNT(*) INTO l_n FROM sgl_file WHERE sgl01 =g_sgk.sgk01
       IF l_n>0 THEN 
          IF cl_confirm('ask-011') THEN 
             DELETE FROM sgl_file WHERE sgl01=g_sgk.sgk01
          ELSE 
          	 RETURN 
          END IF  	 
        END IF 
     END IF 
        	  	    
     OPEN WINDOW t705_a_w AT 4,3 WITH FORM"asf/42f/asft705a"
        ATTRIBUTE(STYLE=g_win_style CLIPPED)
     CALL cl_ui_locale("asft705a")
 
     IF cl_null(g_sgk.sgk01) THEN 
       RETURN
     END IF
     
     
     IF g_priv2='4' THEN
        LET g_wc3 = g_wc clipped," AND sgkuser = '",g_user,"'"
     END IF
 
     IF g_priv3='4' THEN
        LET g_wc3 = g_wc clipped," AND sgkgrup MATCHES '",g_grup CLIPPED,"*'"
     END IF 
     
     CONSTRUCT BY NAME g_wc3 ON skh13,skh02,skh03,skh07,skh08
     
     ON ACTION controlp
       CASE 
         WHEN INFIELD (skh13)
           CALL cl_init_qry_var()
           LET g_qryparam.state='c'
           LET g_qryparam.form="q_skh13"
           CALL cl_create_qry() RETURNING g_qryparam.multiret
           DISPLAY g_qryparam.multiret TO skh13
           NEXT FIELD skh13
         WHEN INFIELD (skh02)
           CALL cl_init_qry_var()
           LET g_qryparam.state='c'
           LET g_qryparam.form="q_skh02"
           CALL cl_create_qry() RETURNING g_qryparam.multiret
           DISPLAY g_qryparam.multiret TO skh02
           NEXT FIELD skh02
         WHEN INFIELD (skh03)
#FUN-AA0059---------mod------------str-----------------         
#           CALL cl_init_qry_var()
#           LET g_qryparam.state='c'
#           LET g_qryparam.form="q_skh03"
#           CALL cl_create_qry() RETURNING g_qryparam.multiret
            CALL q_sel_ima(TRUE, "q_skh03","","","","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059---------mod------------end-----------------
           DISPLAY g_qryparam.multiret TO skh03
           NEXT FIELD skh03 
         WHEN INFIELD (skh08)
           CALL cl_init_qry_var()
           LET g_qryparam.state='c'
           LET g_qryparam.form="q_skh08"
           CALL cl_create_qry() RETURNING g_qryparam.multiret
           DISPLAY g_qryparam.multiret TO skh08
           NEXT FIELD skh08
         OTHERWISE EXIT CASE 
        END CASE
      
      ON ACTION EXIT
         EXIT CONSTRUCT 
         	  
      ON ACTION cancel
         EXIT CONSTRUCT 
 
      END CONSTRUCT
         
      IF INT_FLAG THEN
         LET INT_FLAG=0 
         RETURN 
      END IF 
      
      CLOSE WINDOW t705_a_w
      
      LET g_sql=" select skh01,skh06,sfb05,skh07,skh08,skh12,ima55",
                " from skh_file,sfb_file,ima_file ",
                " where skh_file.skh06=sfb_file.sfb01",
                " and ima_file.ima01=sfb_file.sfb05" ,
                " and skh_file.skh100 = 'Y' ",
                "  and not exists(select * from sgl_file where skh_file.skh01 = sgl_file.sgl03)" 
      IF g_sgk.sgk06!='Y' THEN 
        LET g_sql=g_sql,
                " and ",g_wc3 CLIPPED,
                " and (skh_file.skh07 is not null and skh_file.skh07!=0) ",
                " and (skh_file.skh08 is not null and skh_file.skh08!=' ')"
 
      ELSE
      	LET g_sql=g_sql,
                " and ",g_wc3 CLIPPED,
                " and (skh_file.skh07 is null or skh_file.skh07=0) ",
                " and (skh_file.skh08 is null or skh_file.skh08=' ')" 
      END IF                  
         
     PREPARE t705_prepare1 FROM g_sql 
     DECLARE t705_auto_b_c1 CURSOR WITH HOLD FOR t705_prepare1 
     	
     LET l_ac = 1
     LET l_n1 = 0
     FOREACH t705_auto_b_c1 INTO l_sgl[l_ac].sgl03,l_sgl[l_ac].sgl04,
                                 l_sgl[l_ac].sgl05,l_sgl[l_ac].sgl06,
                                 l_sgl[l_ac].sgl07,l_sgl[l_ac].sgl08,
                                 l_sgl[l_ac].sgl10
       LET l_sgl[l_ac].sgl08 = s_digqty(l_sgl[l_ac].sgl08,l_sgl[l_ac].sgl10)   #No.FUN-BB0086
       IF STATUS THEN
       EXIT FOREACH                                  		
       END IF              	
       LET l_sgl[l_ac].sgl01=g_sgk.sgk01 					
       LET l_sgl[l_ac].sgl02=l_ac
       LET l_sgl[l_ac].sgl09=0
       LET l_sgl[l_ac].sgl11=0
       LET l_sgl[l_ac].sgl12=' ' 
       IF  cl_null(l_sgl[l_ac].sgl06) THEN 
          #LET l_sgl[l_ac].sgl06 = '  ' #No.FUN-A70131
          LET l_sgl[l_ac].sgl06=0       #No.FUN-A70131
       END IF  
       IF  cl_null(l_sgl[l_ac].sgl07) THEN LET l_sgl[l_ac].sgl07 = ' ' END IF 
       INSERT INTO sgl_file
        VALUES(l_sgl[l_ac].sgl01,l_sgl[l_ac].sgl02,l_sgl[l_ac].sgl03,l_sgl[l_ac].sgl04,l_sgl[l_ac].sgl05,       
               l_sgl[l_ac].sgl06,l_sgl[l_ac].sgl07,l_sgl[l_ac].sgl08,l_sgl[l_ac].sgl09,
               l_sgl[l_ac].sgl10,l_sgl[l_ac].sgl11,l_sgl[l_ac].sgl12,'',
               g_plant,g_legal,' ')   #FUN-980008 add  #FUN-A60076 add ' '
       IF SQLCA.SQLCODE  THEN 
          CALL cl_err('ins sgl',SQLCA.SQLCODE,1)
       END IF
       LET l_ac=l_ac+1
       LET l_n1 = l_n1 + SQLCA.SQLERRD[3]
     END FOREACH	
     IF l_n1 =0 THEN 
        CALL cl_err('','ask-054',0)
     END IF    
     CALL t705_show()
END FUNCTION	


FUNCTION t705_sgl08()   #Mod By Teval 190313

   DEFINE l_05_cur   LIKE sgl_file.ta_sgl05  #当前行的生产总数
   DEFINE l_05       LIKE sgl_file.ta_sgl05  #累计报工的生产总数
   DEFINE l_08       LIKE sfb_file.sfb08     #指定工单的生产数量
   DEFINE l_max      LIKE type_file.num10    #累计生产总数可用的最大值
   
      IF l_ac > 0 THEN
      ELSE
         RETURN
      END IF

      IF NOT cl_null(g_sgl[l_ac].ta_sgl05) THEN #不需要预设
         RETURN
      END IF

      IF  NOT cl_null(g_sgl[l_ac].sgl04)
      AND NOT cl_null(g_sgl[l_ac].sgl06)
     #AND NOT cl_null(g_sgl[l_ac].sgl07)        #此字段非必要
      AND NOT cl_null(g_sgl[l_ac].sgl012)
      AND NOT cl_null(g_sgl[l_ac].ta_sgl06) THEN
         OPEN t705_current_ta_sgl05_cs USING g_sgk.sgk01,g_sgl_t.sgl02,
                                             g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl06,
                                             g_sgl[l_ac].sgl07,g_sgl[l_ac].sgl012,
                                             g_sgl[l_ac].ta_sgl06
         FETCH t705_current_ta_sgl05_cs INTO l_05_cur
         CLOSE t705_current_ta_sgl05_cs

         OPEN t705_sfb08_chk_cs USING g_sgl[l_ac].sgl06,g_sgl[l_ac].sgl07,
                                      g_sgl[l_ac].sgl012,g_sgl[l_ac].ta_sgl06,
                                      g_sgl[l_ac].sgl04
         FETCH t705_sfb08_chk_cs INTO l_08,l_05
         CLOSE t705_sfb08_chk_cs

         LET l_max = l_08 - l_05 + l_05_cur


         LET g_sgl[l_ac].ta_sgl05 = IIF(cl_null(g_sgl[l_ac].ta_sgl05),l_max,g_sgl[l_ac].ta_sgl05)
         LET g_sgl[l_ac].sgl08    = IIF(cl_null(g_sgl[l_ac].sgl08)   ,l_max,g_sgl[l_ac].sgl08)

         DISPLAY BY NAME g_sgl[l_ac].ta_sgl05,g_sgl[l_ac].sgl08

      END IF
   
END FUNCTION


{Mark By Teval 190313 已在上方 ↑ 重写此功能：因为在新增时，工单会于作业编号之前录入，
                      此时的作业编号必定为空，生产总数便会被预设为工单的总生产数量，这并不合理 --start--

FUNCTION t705_sgl08(p_sgl03,p_sgl04,p_sgl07)
DEFINE l_skh12   LIKE skh_file.skh12,
       p_sgl04   LIKE sgl_file.sgl04,
       p_sgl07   LIKE sgl_file.sgl07,
       l_sfb08   LIKE sfb_file.sfb08,
       l_n,l_n1,l_n2  LIKE type_file.num5,
       p_sgl03   LIKE sgl_file.sgl03
    
    IF  cl_null(p_sgl03) THEN  
     SELECT sfb08 INTO l_sfb08 FROM sfb_file
            WHERE sfb01=g_sgl[l_ac].sgl04 #AND sfb_file.sfb04!='8' #Modify By Hao170607 去除条件sfb04!='8'的条件,以便结案工单可以获取其生产数
              AND sfb_file.sfbacti='Y'                
     SELECT COALESCE(SUM(sgl08)+SUM(sgl09),0) INTO l_n
           FROM sgl_file
          WHERE  sgl_file.sgl04 = p_sgl04 AND (sgl_file.sgl07 = ' ' OR sgl_file.sgl03 IS NULL) 
     IF  NOT cl_null(p_sgl07) THEN       
       SELECT COALESCE(SUM(sgl08)+SUM(sgl09),0) INTO l_n1
           FROM sgl_file
          WHERE sgl_file.sgl04 = p_sgl04 
          AND   sgl_file.sgl07 = p_sgl07
          AND sgl_file.sgl03 IS NOT NULL
     ELSE 
     	  LET l_n1 = 0
     END IF 	           
           LET l_skh12=l_sfb08 - l_n -l_n1
     ELSE 
     	   SELECT skh12  INTO l_skh12 FROM skh_file
     	    WHERE skh01= p_sgl03 
     END IF 	            
     RETURN l_skh12
END FUNCTION

Mark By Teval 190313 已在上方 ↑ 重写此功能：因为在新增时，工单会于作业编号之前录入，
                      此时的作业编号必定为空，生产总数便会预设为工单的总生产数量，这并不合理 --end--
}



#------------------不做飞票检查-----start          
#No.FUN-9C0072 精簡程式碼
##No.FUN-BB0086---start---add---
#FUNCTION t705_sgl08_check(p_cmd,l_skh12)
#   DEFINE p_cmd           LIKE type_file.chr1 
#   DEFINE l_skh12   LIKE skh_file.skh12
#   
#   IF NOT cl_null(g_sgl[l_ac].sgl08) AND NOT cl_null(g_sgl[l_ac].sgl10) THEN
#      IF cl_null(g_sgl_t.sgl08) OR cl_null(g_sgl10_t) OR g_sgl10_t != g_sgl[l_ac].sgl10 OR g_sgl_t.sgl08 != g_sgl[l_ac].sgl08 THEN
#         LET g_sgl[l_ac].sgl08=s_digqty(g_sgl[l_ac].sgl08, g_sgl[l_ac].sgl10)
#         DISPLAY BY NAME g_sgl[l_ac].sgl08
#      END IF
#   END IF
#
#   IF p_cmd="a" OR (p_cmd="u" AND g_sgl[l_ac].sgl08 !=g_sgl_t.sgl08) THEN
#      CALL t705_sgl08(g_sgl[l_ac].sgl03,g_sgl[l_ac].sgl04,g_sgl[l_ac].sgl07) RETURNING l_skh12
#       IF g_sgl[l_ac].sgl08 <0  THEN 
#          CALL cl_err('','aim-223',0)
#          RETURN FALSE 
#       END IF
#       IF g_sgl[l_ac].sgl08+g_sgl[l_ac].sgl09>l_skh12  THEN 
#         CALL cl_err('','asf-252',0)
#         RETURN FALSE 
#       END IF
#   END IF  
#   RETURN TRUE
#END FUNCTION
#No.FUN-BB0086---end---add---
#-------------------不做飞票检查-END-------
#CHI-C80041---begin
#FUNCTION t705_v()        #CHI-D20010
FUNCTION t705_v(p_type)   #CHI-D20010
DEFINE l_chr     LIKE type_file.chr1
DEFINE l_flag    LIKE type_file.chr1  #CHI-D20010
DEFINE p_type    LIKE type_file.chr1  #CHI-D20010

   IF s_shut(0) THEN RETURN END IF
   IF cl_null(g_sgk.sgk01) THEN CALL cl_err('',-400,0) RETURN END IF  
 
   #CHI-D20010---begin
   IF p_type = 1 THEN
      IF g_sgk.sgk07 ='X' THEN RETURN END IF
   ELSE
      IF g_sgk.sgk07 <>'X' THEN RETURN END IF
   END IF
   #CHI-D20010---end

   BEGIN WORK
 
   LET g_success='Y'
 
   OPEN t705_crl USING g_sgk.sgk01
   IF STATUS THEN
      CALL cl_err("OPEN t705_crl:", STATUS, 1)
      CLOSE t705_crl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t705_crl INTO g_sgk.*          #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_sgk.sgk01,SQLCA.sqlcode,0)      #資料被他人LOCK
      CLOSE t705_crl ROLLBACK WORK RETURN
   END IF
   #-->確認不可作廢
   IF g_sgk.sgk07 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF 
   IF g_sgk.sgk07 = 'X' THEN  LET l_flag = 'X' ELSE LET l_flag = 'N' END IF #CHI-D20010
  # Prog. Version..: '5.30.15-14.10.14(0,0,g_sgk.sgk07)   THEN  #CHI-D20010
   IF cl_void(0,0,l_flag)   THEN    #CHI-D20010
        LET l_chr=g_sgk.sgk07
       #IF g_sgk.sgk07='N' THEN  #CHI-D20010
        IF p_type = 1 THEN       #CHI-D20010
            LET g_sgk.sgk07='X' 
        ELSE
            LET g_sgk.sgk07='N'
        END IF
        UPDATE sgk_file
            SET sgk07=g_sgk.sgk07,  
                sgkmodu=g_user,
                sgkdate=g_today
            WHERE sgk01=g_sgk.sgk01
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
            CALL cl_err3("upd","sgk_file",g_sgk.sgk01,"",SQLCA.sqlcode,"","",1)  
            LET g_sgk.sgk07=l_chr 
        END IF
        DISPLAY BY NAME g_sgk.sgk07
   END IF
 
   CLOSE t705_crl
   COMMIT WORK
   CALL cl_flow_notify(g_sgk.sgk01,'V')
 
END FUNCTION
#CHI-C80041---end
FUNCTION t705_b_check(l_ta_sgl02,l_ta_sgl03,l_sgl09,l_ta_sgl08,l_ta_sgl09,l_ta_sgl10,l_ta_sgl11,l_ta_sgl12,l_ta_sgl13,l_ta_sgl14,l_ta_sgl17)
DEFINE l_ta_sgl02     LIKE sgl_file.ta_sgl02,
       l_ta_sgl03     LIKE sgl_file.ta_sgl03,
          l_sgl09     LIKE sgl_file.sgl09,
       l_ta_sgl08     LIKE sgl_file.ta_sgl08,
       l_ta_sgl09     LIKE sgl_file.ta_sgl09,
       l_ta_sgl10     LIKE sgl_file.ta_sgl10,
       l_ta_sgl11     LIKE sgl_file.ta_sgl11,
       l_ta_sgl12     LIKE sgl_file.ta_sgl12,
       l_ta_sgl13     LIKE sgl_file.ta_sgl13,
       l_ta_sgl14     LIKE sgl_file.ta_sgl14,
       l_ta_sgl17     LIKE sgl_file.ta_sgl17,
       l_cnt          LIKE sgl_file.ta_sgl12,
       l_n            LIKE sgl_file.ta_sgl22,
       l_m            LIKE type_file.num15_3
      
LET g_sgl[l_ac].ta_sgl02=l_ta_sgl02
LET g_sgl[l_ac].ta_sgl03=l_ta_sgl03
#LET g_sgl[l_ac].sgl09=l_sgl09
LET g_sgl[l_ac].ta_sgl08=l_ta_sgl08
LET g_sgl[l_ac].ta_sgl09=l_ta_sgl09
LET g_sgl[l_ac].ta_sgl10=l_ta_sgl10
LET g_sgl[l_ac].ta_sgl11=l_ta_sgl11
LET g_sgl[l_ac].ta_sgl12=l_ta_sgl12
LET g_sgl[l_ac].ta_sgl13=l_ta_sgl13
LET g_sgl[l_ac].ta_sgl14=l_ta_sgl14
LET g_sgl[l_ac].ta_sgl17=l_ta_sgl17
#        AFTER FIELD ta_sgl01    #正常工时=总工时-异常工时
          	LET g_sgl[l_ac].ta_sgl02=g_sgl[l_ac].sgl11-g_sgl[l_ac].ta_sgl01
          	
#        BEFORE FIELD ta_sgl03    #理论标工
#        	  SELECT ecb19 INTO g_sgl[l_ac].ta_sgl03 FROM ecb_file
#        	     WHERE ecb01=g_sgl[l_ac].sgl05 AND ecb02=g_sgl[l_ac].ta_sgl06
#        	       AND ecb03=g_sgl[l_ac].sgl06 AND ecb012=g_sgl[l_ac].sgl012
         #Modify By Hao160422 修改理论标准工时和实际标准工时--begin
            SELECT sgd08 INTO g_sgl[l_ac].ta_sgl03 FROM sgd_file
              WHERE sgd01=g_sgl[l_ac].sgl05 AND sgd02=g_sgl[l_ac].ta_sgl06
                AND sgd03=g_sgl[l_ac].sgl06 AND sgd012=g_sgl[l_ac].sgl012 
		AND sgd05=g_sgl[l_ac].sgl07 AND sgd00=g_sgl[l_ac].sgl04
            IF g_sgl[l_ac].ta_sgl04 IS NULL OR g_sgl[l_ac].ta_sgl04 = 0 THEN
               LET g_sgl[l_ac].ta_sgl04=g_sgl[l_ac].ta_sgl03
	    END IF 
         #Modify By Hao160422 修改理论标准工时和实际标准工时--end      
          #  LET g_sgl[l_ac].ta_sgl21=0
	#绩效达成率=(实际标准工时*((生产总数-(不良数-超基准不良数))-超基准不良数*不良倍数)-报废数量*5)/(正常工时*60)
#	    LET g_sgl[l_ac].ta_sgl22=cl_digcut((g_sgl[l_ac].ta_sgl04*((g_sgl[l_ac].ta_sgl05-(g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].ta_sgl21))-g_sgl[l_ac].ta_sgl21*g_sgl[l_ac].ta_sgl23)-g_sgl[l_ac].sgl09*5)/(g_sgl[l_ac].ta_sgl02*60)*100,2)
    #绩效达成率=(实际标工 * (生产总数 - 报废 * 5 - (不良 - 超基准不良) - 超基准不良 * 不良倍数)) / (正常工时 * 60) * 100
      LET g_sgl[l_ac].ta_sgl22=cl_digcut((g_sgl[l_ac].ta_sgl04*(g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].sgl09*5-(g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].ta_sgl21)-g_sgl[l_ac].ta_sgl21*g_sgl[l_ac].ta_sgl23))/(g_sgl[l_ac].ta_sgl02*60)*100,2)
#        BEFORE FIELD ta_sgl09    #不良数=生产总数-良品数
#           LET g_sgl[l_ac].sgl09=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].sgl08
#        BEFORE FIELD ta_sgl08    #不良率=不良数/生产总数*100%
            LET g_sgl[l_ac].ta_sgl08=cl_digcut(g_sgl[l_ac].ta_sgl20/g_sgl[l_ac].ta_sgl05*100,2)
#        BEFORE FIELD ta_sgl09    #基准(PCS/H)=3600秒/实际标准工时
            LET g_sgl[l_ac].ta_sgl09=3600/g_sgl[l_ac].ta_sgl04
#        BEFORE FIELD ta_sgl10    #应完成数量=正常工时(分)*60/实际标准工时*达成率
            LET g_sgl[l_ac].ta_sgl10=g_sgl[l_ac].ta_sgl02*60/g_sgl[l_ac].ta_sgl04*g_sgl[l_ac].ta_sgl17/100
#        BEFORE FIELD ta_sgl11    #奖惩单价(元)=估算金额/3600秒/实际标准工时
#          	LET g_sgl[l_ac].ta_sgl11=cl_digcut(g_sgl[l_ac].ta_sgl19/3600/g_sgl[l_ac].ta_sgl04,2)
		
#        BEFORE FIELD ta_sgl12    #超基准数=生产总数-报废数量*5-(不良数-超基准不良数)-超基准不良数*不良倍数-应完成数量
            LET l_cnt=g_sgl[l_ac].ta_sgl05-g_sgl[l_ac].sgl09*5-(g_sgl[l_ac].ta_sgl20-g_sgl[l_ac].ta_sgl21)-g_sgl[l_ac].ta_sgl21*g_sgl[l_ac].ta_sgl23-g_sgl[l_ac].ta_sgl10
#        BEFORE FIELD ta_sgl14    #低于基准数=应完成数量-(生产总数-报废数量*5-(不良数-超基准不良数)-超基准不良数*不良倍数)
            IF l_cnt >= 0 THEN 
               LET g_sgl[l_ac].ta_sgl12 = l_cnt
               LET g_sgl[l_ac].ta_sgl14 = 0
            ELSE 
               LET g_sgl[l_ac].ta_sgl12 = 0
               LET g_sgl[l_ac].ta_sgl14 = l_cnt
            END IF 

            # Modify.........: By Hao230629
            LET l_n = g_sgl[l_ac].ta_sgl22 - g_sgl[l_ac].ta_sgl17
            IF g_sgk.ta_sgk01='0' THEN 
               LET l_m=1
            ELSE 
               IF g_sgk.ta_sgk01='1' THEN
                  LET l_m=1.5
               ELSE 
                  LET l_m =2
               END IF 
            END IF 
            IF l_n <0 THEN 
               LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14*l_m/10
            ELSE 
               IF l_n >=0 AND l_n<=4.999 THEN 
                  LET g_sgl[l_ac].ta_sgl13=0
               ELSE 
                  IF l_n >= 5 AND l_n<=10.999 THEN
                     LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12*l_m/10
                  ELSE 
                     IF l_n >= 11 AND l_n<=20.999 THEN
                        LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12*l_m*1.1/10
                     ELSE 
                        LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12*l_m*1.2/10
                     END IF 
                  END IF 
               END IF 
            END IF
            # Modify.........: By Hao230629
            
            {
#        BEFORE FIELD ta_sgl13    #奖/赔金额=奖/惩单价*超/低基准数(*倍数)
            IF g_sgl[l_ac].ta_sgl12 > 0 THEN 
               # Modify.........: By Hao170823 设定170825之后金额设定为分
              #IF g_sgk.sgk02>'2017/08/25'  THEN
                  LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12/10
              #ELSE
              #    LET g_sgl[l_ac].ta_sgl13=cl_digcut(g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl12,2)
              #END IF
               # Modify.........: By Hao170823 设定170825之后金额设定为分
            ELSE 
	             IF g_sgk.ta_sgk01='0' THEN
                 # Modify.........: By Hao170823 设定170825之后金额设定为分
                #IF g_sgk.sgk02>'2017/08/25'  THEN
                    LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14/10
                #ELSE
	             #   LET g_sgl[l_ac].ta_sgl13=cl_digcut(g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14,2)
                #END IF
                 # Modify.........: By Hao170823 设定170825之后金额设定为分
	             ELSE   
		               IF g_sgk.ta_sgk01='1' THEN
                    # Modify.........: By Hao170823 设定170825之后金额设定为分
		              #IF g_sgk.sgk02>'2017/08/25'  THEN
                       LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14*1.5/10
                    #ELSE
                    #  LET g_sgl[l_ac].ta_sgl13=cl_digcut(g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14*1.5,2)
                    #END IF
                    # Modify.........: By Hao170823 设定170825之后金额设定为分
		               ELSE
		                  IF g_sgk.ta_sgk01='2' THEN 
                       # Modify.........: By Hao170823 设定170825之后金额设定为分
		                 #IF g_sgk.sgk02>'2017/08/25' THEN
                          LET g_sgl[l_ac].ta_sgl13=g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14*2/10
                       #ELSE
                       #  LET g_sgl[l_ac].ta_sgl13=cl_digcut(g_sgl[l_ac].ta_sgl11*g_sgl[l_ac].ta_sgl14*2,2)
                       #END IF
                       # Modify.........: By Hao170823 设定170825之后金额设定为分
		                  END IF 
		               END IF
		            END IF 
            END IF }


          	
DISPLAY BY NAME g_sgl[l_ac].ta_sgl02
DISPLAY BY NAME g_sgl[l_ac].ta_sgl03
#DISPLAY BY NAME g_sgl[l_ac].sgl09
DISPLAY BY NAME g_sgl[l_ac].ta_sgl08
DISPLAY BY NAME g_sgl[l_ac].ta_sgl09
DISPLAY BY NAME g_sgl[l_ac].ta_sgl10
#DISPLAY BY NAME g_sgl[l_ac].ta_sgl11
DISPLAY BY NAME g_sgl[l_ac].ta_sgl12
DISPLAY BY NAME g_sgl[l_ac].ta_sgl13
DISPLAY BY NAME g_sgl[l_ac].ta_sgl14
DISPLAY BY NAME g_sgl[l_ac].ta_sgl21
DISPLAY BY NAME g_sgl[l_ac].ta_sgl22
END FUNCTION

FUNCTION t705_b_check_1()
   #奖惩单价(元)=(估算金额)/(3600秒/实际标准工时)
   LET g_sgl[l_ac].ta_sgl11=cl_digcut((g_sgl[l_ac].ta_sgl19)/(3600/g_sgl[l_ac].ta_sgl04),4)
   CALL t705_b_check(g_sgl[l_ac].ta_sgl02,g_sgl[l_ac].ta_sgl03,g_sgl[l_ac].sgl09,g_sgl[l_ac].ta_sgl08,g_sgl[l_ac].ta_sgl09,g_sgl[l_ac].ta_sgl10,g_sgl[l_ac].ta_sgl11,g_sgl[l_ac].ta_sgl12,g_sgl[l_ac].ta_sgl13,g_sgl[l_ac].ta_sgl14,g_sgl[l_ac].ta_sgl17)
END FUNCTION 

# Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24
FUNCTION t705_ta_sgk02(p_cmd)
  DEFINE  p_cmd     LIKE  type_file.chr1
  DEFINE  l_gem02   LIKE  gem_file.gem02
  DEFINE  l_gemacti LIKE  gem_file.gemacti 
  
  LET g_errno = ' '
  SELECT gem02,gemacti INTO l_gem02,l_gemacti FROM gem_file WHERE gem01=g_sgk.ta_sgk02
  CASE 
     WHEN sqlca.sqlcode = 100 LET g_errno = 'aap-039' LET l_gem02 = NULL 
     WHEN l_gemacti='N' LET g_errno = '9028'
     OTHERWISE   LET g_errno = SQLCA.sqlcode USING '-------'
  END CASE 

  IF cl_null(g_errno)  OR p_cmd='d' THEN
     DISPLAY l_gem02 TO gem02
  END IF

END FUNCTION 
# Modify.........: By Hao170603 添加字段部门编号ta_sgk02和员工部门ta_sgl24


#Add By Wang170620 添加资料清单填充 begin
FUNCTION t705_list_fill() 
  DEFINE l_sgk01       LIKE sgk_file.sgk01  
  DEFINE l_cnt         LIKE type_file.num5  

  
    CALL g_sgl_l.clear()
    CALL g_cnt_ac.clear() #Add By Wang170908 
    
    LET l_cnt = 1
    LET l_ac1 = 1
    
    FOREACH t705_list_cs1 INTO l_sgk01
    
       IF sqlca.sqlcode  THEN
          CALL cl_err('foreach item_cur',sqlca.sqlcode,1)
          CONTINUE  FOREACH 
       END IF

      LET g_cnt_ac[l_cnt].ac = l_ac1
      # Modify.........: By li241106 资料清单添加估算积分和进厂日期
      # Modify.........: By li251120 添加项次和职位栏位
      DECLARE t705_list_cs CURSOR FOR 
      SELECT sgk01,sgl02,sgk02,ta_sgk03,sgl04,sgl05,ta_sgl18,eca02,sgl07,sga02,ta_sgl28,ta_sgl27,# Modify By Hao180113 资料清单中添加工艺备注
             ta_sgl29,#Add By Teval 180508
             ta_sgl33,ta_sgl34,ta_sgl35,ta_sgl36, ta_sgl32,ta_sgl19, sgl11, ta_sgl01,#Add By Wang 171109 添加异常工时字段
             ta_sgl04,ta_sgl05,sgl08,ta_sgl20,sgl09, #By Hao200417
             ta_sgl22,ta_sgl13,
             ta_sgl30,ta_sgl37,ta_sgl31,#Add By Teval 180719 # Modify.........: By Hao230728
             sgl12,ta_sgl25,ta_sgl16,ta_sgl24,ta_sgl26,#Add By Wang 170908 添加员工部门字段  
             sgk04,#Mod By Wang171013 资料清单添加单头备注字段
             sgl13 FROM sgl_file 
             LEFT JOIN sgk_file ON sgk01=sgl01
             LEFT JOIN eca_file ON eca01=ta_sgl18
             LEFT JOIN sga_file ON sga01=sgl07
             WHERE sgk01=l_sgk01 
             ORDER BY sgk01,sgl02
                
      FOREACH t705_list_cs INTO g_sgl_l[l_ac1].*     
        IF SQLCA.sqlcode THEN
           CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF

        LET g_cnt_ac[l_ac1].cnt = l_cnt
        
        LET l_ac1 = l_ac1 + 1
      
        IF l_ac1 > g_max_rec THEN
           IF g_action_flag="info_list"  THEN
             CALL cl_err('',9035,0)
           END IF
           EXIT FOREACH
        END IF
     END FOREACH
     LET l_cnt = l_cnt + 1 
     IF l_ac1 > g_max_rec THEN
        EXIT FOREACH
     END IF
   END FOREACH 
    
   LET g_rec_b1 = l_ac1 - 1
   
   CALL g_sgl_l.deleteElement(l_ac1)   #去除最后一行空行
   DISPLAY g_rec_b1 TO FORMONLY.cnt1   #显示资料清单总笔数

END FUNCTION
#Add By Wang170620 添加资料清单填充 end

#Add By Teval 190308 --start--
FUNCTION t705_a_menu()
      
   DEFINE l_field STRING
   DEFINE l_where STRING
   DEFINE i       LIKE type_file.num10

      IF cl_null(g_sgk.sgk01) THEN
         CALL cl_err('',-400,0)
         RETURN
      END IF
      
      IF l_ac > 0 AND g_rec_b > 0 THEN
      ELSE
         CALL cl_err('','aps-702',10)  #无单身资料可启动
         RETURN
      END IF
      
      OPEN t705_a_sgk07_cs USING g_sgk.sgk01
      FETCH t705_a_sgk07_cs INTO g_sgk.sgk07
      CLOSE t705_a_sgk07_cs
      
      IF g_sgk.sgk07 = 'N' THEN
      ELSE
         CALL cl_err('','coo-107',10)
         RETURN
      END IF

      BEGIN WORK
      
      OPEN t705_crl USING g_sgk.sgk01  #先对资料上锁，防止中途被其它用户修改
      
      IF STATUS THEN
         CALL cl_err("OPEN t705_crl:", STATUS, 1)
         ROLLBACK WORK
         CLOSE t705_crl
         RETURN 
      END IF

      INITIALIZE g_a_header.*,g_a_sum.* TO NULL
      LET g_a_header.sgl12 = g_sgl[l_ac].sgl12  #预设为主画面选中行的人员

      CALL t705_a_header_refresh()     #刷新单头
      CALL t705_a_body_refresh('N')    #刷新单身
      
      OPEN WINDOW t705_a_w WITH FORM 'csf/42f/csft705a'
         ATTRIBUTE (STYLE = "create_qry" CLIPPED)
      
      CALL cl_ui_locale("csft705a")
      
      CALL t705_a_combo()  #加载人员选择的下拉选项
      
      LET l_field = "ta_sgl16,ta_sgl24,ta_sgl26,",
                    "sgl04,sgl05,sgl05_ima02,ta_sgl06,",
                    "ta_sgl18,sgl012,sgl06,sgl07,sga02,",
                    "ta_sgl28,ta_sgl27,ta_sgl29,ta_sgl19,",
                    "sgl11,ta_sgl01,ta_sgl02,ta_sgl03,ta_sgl04,",
                    "ta_sgl05,sgl08,ta_sgl20,sgl09"
      CALL cl_set_comp_entry(l_field,FALSE)
      
      LET l_field = "sgl02,ta_sgl06,ta_sgl18,sgl012,sgl06"
      CALL cl_set_comp_visible(l_field,FALSE)

      LET l_field = "sgl12,sel,sgl11_sum,ta_sgl01_sum"
      CALL cl_set_comp_required(l_field,TRUE)
      
      DIALOG ATTRIBUTES(UNBUFFERED)
         
         INPUT BY NAME g_a_sum.*,g_a_header.* ATTRIBUTES(WITHOUT DEFAULTS)
                       
            ON CHANGE sgl12
               CALL t705_a_header_refresh()
               CALL t705_a_body_refresh('N')
               
         END INPUT
         
         INPUT ARRAY g_a_body FROM s_sgl.*
            ATTRIBUTES(WITHOUT DEFAULTS,
                       INSERT ROW=FALSE,
                       DELETE ROW=FALSE,
                       APPEND ROW=FALSE)
            
            BEFORE ROW
               LET l_a_ac = arr_curr()
                                      
            ON ACTION choice                 #自定义单身行双击为：选择/取消选择
               LET g_a_body[l_a_ac].sel = IIF(g_a_body[l_a_ac].sel='N','Y','N')
                                          
         END INPUT
         
         BEFORE DIALOG
            NEXT FIELD sgl11_sum
            
         ON ACTION select_all
            CALL t705_a_select('Y')
            
         ON ACTION cancel_all
            CALL t705_a_select('N')
            
         ON ACTION ACCEPT
            IF g_a_sum.sgl11_sum >= 0 THEN
            ELSE
               CALL cl_err('','alm-808',0)   #alm-808 此字段必须大于0
               NEXT FIELD sgl11_sum
            END IF

            IF g_a_sum.ta_sgl01_sum >= 0 THEN
            ELSE
               CALL cl_err('','asf-209',0)   #asf-209 必须大于等于0
               NEXT FIELD ta_sgl01_sum
            END IF

            LET l_where = "('"

            FOR i = 1 TO g_a_body.getLength()
               IF g_a_body[i].sel = 'Y' THEN
                  IF l_where = "('" THEN
                  ELSE
                     LET l_where = l_where.append("','")
                  END IF
                  LET l_where = l_where.append(g_a_body[i].sgl02)
               END IF
            END FOR

            IF l_where = "('" THEN
               CALL cl_err('','alm-428',0)
               NEXT FIELD CURRENT 
            END IF

            LET l_where = l_where.append("')")

            LET g_sql = "SELECT sgl_file.*,",
                        "?*(ta_sgl05/SUM(ta_sgl05)OVER(PARTITION BY 1)) sgl11,",
                        "?*(ta_sgl05/SUM(ta_sgl05)OVER(PARTITION BY 1)) ta_sgl01",
                        " FROM sgl_file",
                        " WHERE sgl01 = ?",
                        " AND " || g_wc2 CLIPPED,
                        " AND sgl02 in "||l_where
            DECLARE t705_a_accept_cs CURSOR FROM g_sql
            ACCEPT DIALOG
            
         ON ACTION CANCEL
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION controlg
            CALL cl_cmdask()
            
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG
            
         ON ACTION EXIT
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
      END DIALOG
      
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         ROLLBACK WORK
         CLOSE t705_crl
      ELSE
         IF t705_a_accept() THEN
            COMMIT WORK
            
           #CALL t705_a_body_refresh('S')
            CALL cl_err("", 9062, 2)  #资料更新成功
         ELSE
            ROLLBACK WORK
            CLOSE t705_crl
         END IF
      END IF
      
      CLOSE WINDOW t705_a_w
      
END FUNCTION


FUNCTION t705_a_select(p_cmd)

   DEFINE p_cmd   LIKE type_file.chr1
   DEFINE i       LIKE type_file.num10

      IF p_cmd = 'Y' THEN
      ELSE
         LET p_cmd = 'N'
      END IF

      FOR i = 1 TO g_a_body.getLength()
         LET g_a_body[i].sel = p_cmd
      END FOR

END FUNCTION

FUNCTION t705_a_header_refresh()

      INITIALIZE g_a_header.ta_sgl16,g_a_header.ta_sgl24,g_a_header.ta_sgl26 TO NULL

      OPEN t705_a_header_cs USING g_sgk.sgk01,g_a_header.sgl12
      FETCH t705_a_header_cs INTO g_a_header.ta_sgl16,g_a_header.ta_sgl24,g_a_header.ta_sgl26
      CLOSE t705_a_header_cs

END FUNCTION

FUNCTION t705_a_body_refresh(p_cmd)

   DEFINE p_cmd   LIKE type_file.chr1  #S：保留用户选择；Y：强制全选；N：强制全不选
   DEFINE l_cnt   LIKE type_file.num10
   DEFINE l_sel   LIKE type_file.chr1

      LET l_cnt = 1

      LET g_sql = "SELECT ?, sgl02, sgl04, sgl05, ima02, ta_sgl06",
                  "    , ta_sgl18, sgl012, sgl06, sgl07, sga02, ta_sgl28",
                  "    , ta_sgl27, ta_sgl29, ta_sgl19, sgl11, ta_sgl01",
                  "    , ta_sgl02, ta_sgl03, ta_sgl04, ta_sgl05, sgl08",
                  "    , ta_sgl20, sgl09 ",
                  " FROM sgl_file",
                  " LEFT JOIN ima_file ON ima01 = sgl05",
                  " LEFT JOIN sga_file ON sga01 = sgl07 ",
                  " WHERE sgl01 = ? ",
                  "   AND sgl12 = ? ",
                  "   AND " || g_wc2 CLIPPED,
                  " ORDER BY sgl02"

      DECLARE t705_a_body_cs CURSOR FROM g_sql

      LET p_cmd = upshift(p_cmd)

      CASE p_cmd
         WHEN 'S'
            FOREACH t705_a_body_cs  USING p_cmd,g_sgk.sgk01,g_a_header.sgl12 
                                    INTO  l_sel,
                                          g_a_body[l_cnt].sgl02   ,g_a_body[l_cnt].sgl04,
                                          g_a_body[l_cnt].sgl05   ,g_a_body[l_cnt].sgl05_ima02,
                                          g_a_body[l_cnt].ta_sgl06,g_a_body[l_cnt].ta_sgl18,
                                          g_a_body[l_cnt].sgl012  ,g_a_body[l_cnt].sgl06,
                                          g_a_body[l_cnt].sgl07   ,g_a_body[l_cnt].sga02,
                                          g_a_body[l_cnt].ta_sgl28,g_a_body[l_cnt].ta_sgl27,
                                          g_a_body[l_cnt].ta_sgl29,g_a_body[l_cnt].ta_sgl19,
                                          g_a_body[l_cnt].sgl11   ,g_a_body[l_cnt].ta_sgl01,
                                          g_a_body[l_cnt].ta_sgl02,g_a_body[l_cnt].ta_sgl03,
                                          g_a_body[l_cnt].ta_sgl04,g_a_body[l_cnt].ta_sgl05,
                                          g_a_body[l_cnt].sgl08   ,g_a_body[l_cnt].ta_sgl20,
                                          g_a_body[l_cnt].sgl09
               LET l_cnt = l_cnt + 1
            END FOREACH
         OTHERWISE
            LET p_cmd = IIF(p_cmd='Y','Y','N')
            CALL g_a_body.clear()
            FOREACH t705_a_body_cs USING p_cmd,g_sgk.sgk01,g_a_header.sgl12 INTO g_a_body[l_cnt].*
               LET l_cnt = l_cnt + 1
            END FOREACH
      END CASE

      CALL g_a_body.deleteElement(l_cnt)
      LET g_a_rec_b = l_cnt - 1

END FUNCTION

FUNCTION t705_a_accept()

   DEFINE l_sgl      RECORD LIKE sgl_file.*
   DEFINE l_sgl11    LIKE sgl_file.sgl11
   DEFINE l_ta_sgl01 LIKE sgl_file.ta_sgl01
   DEFINE l_cnt      LIKE sgl_file.ta_sgl12  #用于暂存超基准数

      FOREACH t705_a_accept_cs USING g_a_sum.sgl11_sum,g_a_sum.ta_sgl01_sum,g_sgk.sgk01 INTO l_sgl.*,l_sgl11,l_ta_sgl01

         LET l_sgl.sgl11 = l_sgl11
         LET l_sgl.ta_sgl01 = l_ta_sgl01

         #正常工时=总工时-异常工时
         LET l_sgl.ta_sgl02=l_sgl.sgl11-l_sgl.ta_sgl01
                                                                        
         #绩效达成率=(实际标工 * (生产总数 - 报废 * 5 - (不良 - 超基准不良) - 超基准不良 * 不良倍数)) / (正常工时 * 60) * 100
         LET l_sgl.ta_sgl22=cl_digcut((l_sgl.ta_sgl04*(l_sgl.ta_sgl05-l_sgl.sgl09*5-(l_sgl.ta_sgl20-l_sgl.ta_sgl21)-l_sgl.ta_sgl21*l_sgl.ta_sgl23))/(l_sgl.ta_sgl02*60)*100,2)
                                                                        
         #不良率=不良数/生产总数*100%
         LET l_sgl.ta_sgl08=cl_digcut(l_sgl.ta_sgl20/l_sgl.ta_sgl05*100,2)
                                                                        
         #基准(PCS/H)=3600秒/实际标准工时
         LET l_sgl.ta_sgl09=3600/l_sgl.ta_sgl04
                                                           
         #应完成数量=正常工时(分)*60/实际标准工时*达成率
         LET l_sgl.ta_sgl10=l_sgl.ta_sgl02*60/l_sgl.ta_sgl04*l_sgl.ta_sgl17/100
                                                                                                       
         #超基准数=生产总数-报废数量*5-(不良数-超基准不良数)-超基准不良数*不良倍数-应完成数量
         LET l_cnt=l_sgl.ta_sgl05-l_sgl.sgl09*5-(l_sgl.ta_sgl20-l_sgl.ta_sgl21)-l_sgl.ta_sgl21*l_sgl.ta_sgl23-l_sgl.ta_sgl10
                                                                                                                                                                      
         #低于基准数=应完成数量-(生产总数-报废数量*5-(不良数-超基准不良数)-超基准不良数*不良倍数)
         IF l_cnt >= 0 THEN
            LET l_sgl.ta_sgl12 = l_cnt
            LET l_sgl.ta_sgl14 = 0
         ELSE
            LET l_sgl.ta_sgl12 = 0
            LET l_sgl.ta_sgl14 = l_cnt
         END IF

         #奖惩单价(元)=(估算金额)/(3600秒/实际标准工时)
         LET l_sgl.ta_sgl11=cl_digcut((l_sgl.ta_sgl19)/(3600/l_sgl.ta_sgl04),4)

         #奖/赔金额=奖/惩单价*超/低基准数(*倍数)
         IF l_sgl.ta_sgl12 > 0 THEN
            LET l_sgl.ta_sgl13=l_sgl.ta_sgl11*l_sgl.ta_sgl12
         ELSE
            CASE g_sgk.ta_sgk01
               WHEN '0'
                  LET l_sgl.ta_sgl13=l_sgl.ta_sgl11*l_sgl.ta_sgl14
               WHEN '1'
                  LET l_sgl.ta_sgl13=l_sgl.ta_sgl11*l_sgl.ta_sgl14*1.5
               WHEN '2'
                  LET l_sgl.ta_sgl13=l_sgl.ta_sgl11*l_sgl.ta_sgl14*2
            END CASE
         END IF

        #IF g_sgk.sgk02 > '2017/08/25' THEN
            LET l_sgl.ta_sgl13=l_sgl.ta_sgl13/10
        #END IF

         UPDATE sgl_file SET * = l_sgl.* WHERE sgl01 = l_sgl.sgl01 AND sgl02 = l_sgl.sgl02

         IF sqlca.sqlcode THEN
            CALL cl_err3("upd","sgl_file",l_sgl.sgl01,l_sgl.sgl02,SQLCA.sqlcode,"","",1)
            RETURN FALSE
         END IF

      END FOREACH

      RETURN TRUE

END FUNCTION 

FUNCTION t705_a_combo()

   DEFINE cb      ui.ComboBox
   DEFINE p_item  LIKE sgl_file.sgl12
   DEFINE p_text  LIKE sgl_file.ta_sgl25
      
      LET cb = ui.ComboBox.forName("sgl12")

      FOREACH t705_a_combo_cs USING g_sgk.sgk01 INTO p_item,p_text
         LET p_text = p_item,':',p_text
         CALL cb.addItem(p_item,p_text)
      END FOREACH

END FUNCTION


 # add by dmw20260413 计算UPH并回填理论标准工时和达成率
FUNCTION t705_calc_uph()
DEFINE l_uph_local LIKE type_file.num15_3

   # 1. 判空
   IF cl_null(g_sgl[l_ac].ta_sgl28) THEN
      RETURN
   END IF

   # 2. 判断是否包含UPH（兼容写法）
   IF g_sgl[l_ac].ta_sgl28 MATCHES "*UPH*" OR
      g_sgl[l_ac].ta_sgl28 MATCHES "*uph*" THEN
   ELSE
      RETURN
   END IF

   # 3. 查UPH
   SELECT ecbud08 INTO l_uph_local
   FROM ecb_file
   WHERE ecb01 = g_sgl[l_ac].sgl05
     AND ecb02 = g_sgl[l_ac].ta_sgl06
     AND ecb03 = g_sgl[l_ac].sgl06
     AND ecb012 = g_sgl[l_ac].sgl012

   IF SQLCA.sqlcode THEN
      CALL cl_err('','未找到UPH',0)
      RETURN
   END IF

   IF l_uph_local <= 0 THEN
      RETURN
   END IF

   # 4. 回填理论标准工时
   LET g_sgl[l_ac].ta_sgl03 = l_uph_local

   # 5. 计算达成率
   IF NOT cl_null(g_sgl[l_ac].sgl11) AND 
      NOT cl_null(g_sgl[l_ac].ta_sgl05) THEN

      LET g_sgl[l_ac].ta_sgl17 =
         (g_sgl[l_ac].sgl11 * g_sgl[l_ac].ta_sgl05) / l_uph_local * 100
   END IF

   # 6. 刷新画面
   DISPLAY BY NAME g_sgl[l_ac].ta_sgl03
   DISPLAY BY NAME g_sgl[l_ac].ta_sgl17

END FUNCTION
