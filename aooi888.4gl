# Prog. Version..: '1.0.0(00000)'
# Pattern name...: aooi888.4gl
# Descriptions...: 签核人员资料维护作业
# Date & Author..: 2026/02/04 By dmw
# Note...........: 本程序为训练测试程序

DATABASE jf --连接ds数据库

GLOBALS "../../config/top.global" 
--把 top.global 这个文件里的 全局变量 / 函数 引进来
{
通常里面会有：
g_prog（程序名）、
g_time（时间记录）、
g_win_style（窗口风格）
共用 function（
cl_user()(权限检查)、
cl_setup()(环境初始化)、
cl_used()（使用记录）等）
}


--定义全局变量
DEFINE
    g_azb        RECORD LIKE azb_file.*, --一整笔 azb_file 表的数据结构跟数据库表一模一样
    g_azb_t      RECORD LIKE azb_file.*,
    g_azb01_t    LIKE azb_file.azb01,
    g_wc         STRING,--动态where条件（SQL 条件）
    g_sql        STRING,--动态 SQL 字串
    g_azb_rowid  LIKE type_file.chr18    --存 rowid，用来 FOR UPDATE


--控制用变量
DEFINE
    g_forupd_sql         STRING,                --FOR UPDATE 用的 SQL
    g_before_input_done  LIKE type_file.num5,   --控制 INPUT 前后逻辑用
    g_chr                LIKE type_file.chr1,   --计数、循环、判断用
    g_cnt                LIKE type_file.num10,  --计数、循环、判断用
    g_i                  LIKE type_file.num5,   --for / loop 计数
    g_msg                LIKE type_file.chr1000,--MESSAGE 显示用
    g_curs_index         LIKE type_file.num10,  --导航条（上一笔 / 下一笔）cl_navigator_setting() 会用到
    g_row_count          LIKE type_file.num10,  --导航条
    g_jump               LIKE type_file.num10,  --菜单跳转
    mi_no_ask            LIKE type_file.num5    --是否跳过确认

DEFINE g_query_ok LIKE type_file.num5   --是否查询成功
    
--程序入口
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
    IF NOT cl_setup("A00") THEN
        EXIT PROGRAM
    END IF

    -- ★ 第四步：使用记录 ★
    -- 记录程序开始使用时间，用于系统审计和使用统计分析
    -- 参数：程序名, 时间戳, 1(开始) 或 2(结束)
    CALL cl_used(g_prog, g_time, 1) RETURNING g_time

    -- 初始化全局人员资料记录，清空所有字段
    INITIALIZE g_azb.* TO NULL

    -- 准备 FOR UPDATE SQL 语句，用于修改和删除时的行级锁定
    -- NOWAIT：如果资料已被其他用户锁定，立即报错（不等待释放）
    LET g_forupd_sql =
        "SELECT * FROM azb_file WHERE rowid = ? FOR UPDATE NOWAIT"

    -- 声明游标但不执行：真正的 OPEN 和 FETCH 操作在修改/删除函数中进行
    DECLARE i888_cl CURSOR FROM g_forupd_sql

    -- ★ 第五步：打开主窗口 ★
    -- 设定窗口显示位置
    LET p_row = 5
    LET p_col = 10

    -- 打开主窗口，使用指定的表单文件和系统统一风格
    OPEN WINDOW i010_w AT p_row, p_col
        WITH FORM "aoo/42f/aooi888"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)

    -- 初始化 UI 样式：快捷键、颜色、状态列等
    CALL cl_ui_init()

    -- ★ 第六步：显示主菜单 ★
    -- 所有功能入口都从这个菜单开始
    LET g_action_choice = ""
    CALL i010_menu()

    -- ★ 第七步：清理资源 ★
    -- 关闭主窗口
    CLOSE WINDOW i010_w

    -- 记录程序结束使用时间
    CALL cl_used(g_prog, g_time, 2) RETURNING g_time
    
END MAIN


# ====================================
# 主菜单函数 - 功能导航和流程控制
# ====================================
# 功能说明：
#   - 定义所有主要功能按钮（新增、查询、修改、删除、复制）
#   - 管理菜单事件和用户交互
#   - 控制导航条状态和闲置超时

FUNCTION i010_menu()

    MENU ""

        -- 菜单初始化：设置导航条(首/上/下/末)按钮的启用状态
        BEFORE MENU
            CALL cl_navigator_setting(g_curs_index, g_row_count)

        -- 【新增】按钮：添加新的人员记录
        ON ACTION INSERT
            CALL i888_insert()
            
        -- 【查询】按钮：按条件查询人员记录
        ON ACTION query
             CALL i888_query()

        -- 【修改】按钮：修改已查询的人员记录
        ON ACTION modify
            CALL i888_modify()

        -- 【删除】按钮：删除指定的人员记录
        ON ACTION DELETE
            CALL i888_delete()

        -- 【复制】按钮：复制已查询的人员记录为新记录
        ON ACTION reproduce
            CALL i888_copy()


    END MENU

END FUNCTION



--========================
--  新增人员记录函数
--  功能说明：获取用户输入 → 验证数据 → 用户确认 → 插入数据库
--========================

FUNCTION i888_insert()  

    DEFINE l_ok LIKE type_file.num5

    -- 清空变量（内存中的数据）
    INITIALIZE g_azb.* TO NULL 

    -- 清空显示界面（屏幕上的数据）
    CLEAR FORM 

    -- 获取用户输入的新人员资料
    INPUT BY NAME g_azb.*
        BEFORE INPUT 
            MESSAGE "请输入新增资料" 
    END INPUT 

    -- 设置记录日期为当前日期
    LET g_azb.AZBDATE = TODAY

    -- ▼ 第一步：数据验证 ▼
    -- 验证 1：检查主键是否已存在
    IF NOT i888_chk_pk() THEN 
        MESSAGE "主键重复，新增取消！"
        RETURN 
    END IF 

    -- 验证 2：检查必填项和业务规则
    IF NOT i888_chk_insert() THEN 
        MESSAGE "资料检查失败，新增取消"
        RETURN
    END IF 

    -- ▼ 第二步：用户二次确认 ▼
    LET l_ok = cl_confirm("是否确认新增此笔资料？")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消新增"
        RETURN 
    END IF 

    -- ▼ 第三步：提交数据库 ▼
    -- 开启事务，确保数据一致性
    BEGIN WORK 

    -- 【调试】显示即将执行的 INSERT 语句和参数值
    LET g_sql = 
            "INSERT INTO azb_file (" ||
        "azb01, azboriu, azb02, azborig, azb06, azbdate, azbuser" ||
        ") VALUES (?, ?, ?, ?, ?, ?, ?)"

    DISPLAY "INSERT SQL => " || g_sql
    DISPLAY "PARAM azb01   = [" || g_azb.azb01 || "]"
    DISPLAY "PARAM azboriu = [" || g_azb.azboriu || "]"
    DISPLAY "PARAM azb02   = [" || g_azb.azb02 || "]"
    DISPLAY "PARAM azborig = [" || g_azb.azborig || "]"
    DISPLAY "PARAM azb06   = [" || g_azb.azb06 || "]"
    DISPLAY "PARAM azbdate = [" || g_azb.azbdate || "]"
    DISPLAY "PARAM azbuser = [" || g_user || "]"

    -- 预编译 SQL 语句（提高执行效率，防止 SQL 注入）
    PREPARE s_ins FROM g_sql

    -- 执行 INSERT 语句，将新人员记录插入数据库
    EXECUTE s_ins USING 
            g_azb.azb01,    -- 人员编号（主键）
            g_azb.azboriu,  -- 人员姓名
            g_azb.azb02,    -- 登录密码
            g_azb.azborig,  -- 所属部门
            g_azb.azb06,    -- 授权金额
            g_azb.azbdate,  --最近更改日
            g_user

    -- 检查执行结果：影响行数
    DISPLAY  "INSERT 影响行数 ： " || SQLCA.SQLERRD[3]

    -- ★ 错误处理 ★
    IF SQLCA.SQLCODE <> 0 THEN
        MESSAGE "新增失败，SQLCODE = " || SQLCA.SQLCODE
        ROLLBACK WORK       -- 回滚事务，取消所有操作
        RETURN  
    END IF

    -- 验证影响行数是否正确（应该为1）
    IF SQLCA.SQLERRD[3] <> 1 THEN
        MESSAGE "新增影响行数异常 = " || SQLCA.SQLERRD[3]
        ROLLBACK WORK
        RETURN
    END IF

    -- 事务提交：确认所有操作，保存到数据库
    COMMIT WORK
    
    MESSAGE "新增成功"

    -- 显示新增后的完整人员资料
    CALL i888_show() 
    
    
END FUNCTION    -- 新增功能函数结束



--====================================
-- 主键验证函数 - 检查编号唯一性
--====================================
-- 返回值：TRUE(主键合法) / FALSE(主键重复或为空)
FUNCTION i888_chk_pk() 

    DEFINE l_cnt LIKE type_file.num10  -- 计数器：用于统计主键重复数

    -- 检查 1：主键不能为空
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN 
        MESSAGE "主键不能为空！"
        RETURN FALSE 
    END IF 

    -- 检查 2：查询数据库中是否已存在该编号
    SELECT COUNT(*) 
    INTO l_cnt 
    FROM azb_file
    WHERE TRIM(azb01) = TRIM(g_azb.azb01)

    -- 如果计数大于0，表示编号已存在
    IF l_cnt > 0 THEN 
        MESSAGE "编号已存在无法新增"
        RETURN FALSE
    END IF 

    -- 所有检查都通过
    RETURN TRUE 

END FUNCTION



-- ====================================
-- 新增数据验证函数 - 检查业务规则
-- ====================================
-- 验证内容：
--   - 必填项检查
--   - 业务规则检查（可扩展：日期大小、状态组合等）
-- 返回值：TRUE(验证成功) / FALSE(验证失败)
FUNCTION i888_chk_insert()

        -- 必填项 1：人员名称不能为空
        IF g_azb.azboriu IS NULL OR g_azb.azboriu CLIPPED = " " THEN 
            MESSAGE "人员名称不能为空"
            RETURN FALSE 
        END IF 
        
        -- 其他验证项可在此处添加
        -- 例如：日期范围检查、金额合理性检查、部门代码有效性检查等
        
        RETURN TRUE 
        
END FUNCTION    



-- ====================================
-- 查询人员记录函数 - 支持多条件组合查询
-- ====================================
-- 功能说明：
--   1. 获取用户输入的查询条件
--   2. 动态拼接 SQL WHERE 子句
--   3. 执行查询并显示结果
--   4. 设置查询成功标志（用于修改/删除的前置条件）
-- 
-- 查询条件支持：人员编号、姓名、密码、部门、金额、日期等
-- 
-- 数据流向：输入条件 → SQL拼接 → 查询执行 → 显示结果 → 设置标志
FUNCTION i888_query()

    DEFINE l_where STRING  -- 存放动态 WHERE 条件
    DEFINE l_sql STRING    -- 存放完整的 SELECT 语句

    -- 重置查询成功标志
    LET g_query_ok = 0

    -- 清空上一次查询的数据和显示界面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    -- 获取用户输入的查询条件（支持多字段组合查询）
    INPUT BY NAME 
        g_azb.azb01,    -- 人员编号
        g_azb.azboriu,  -- 人员姓名
        g_azb.azb02,    -- 密码
        g_azb.azborig,  -- 部门编号
        g_azb.azb06,    -- 授权金额
        g_azb.azbdate   -- 修改日期
        BEFORE INPUT 
            MESSAGE "请输入查询条件"
    END INPUT 

    DISPLAY "DEBUG INPUT azb01=[" || g_azb.azb01 || "]"

    -- ▼ 动态 SQL 拼接阶段 ▼
    -- 初始化 WHERE 条件（1=1 总是真，作为基础条件）
    LET l_where = " WHERE 1 = 1 "
    LET l_sql   = "SELECT rowid,A.* FROM azb_file A "

    DISPLAY "DEBUG INPUT l_where=[" || l_where || "]"
    DISPLAY "DEBUG INPUT l_sql=[" || l_sql || "]"
    DISPLAY "DEBUG2 BEFORE IF azb01=[" || g_azb.azb01 || "]"

    -- ▼ 条件拼接：如果字段有值，则加入 WHERE 条件 ▼
    
    -- 条件 1：人员编号（精确匹配）
    IF g_azb.azb01 IS NOT NULL AND g_azb.azb01 CLIPPED <> " " THEN 
        LET l_where = l_where || " AND TRIM(azb01) = '" || g_azb.azb01 CLIPPED || "'"
    END IF 
    
    -- 条件 2：人员姓名（模糊匹配，支持部分名字搜索）
    IF g_azb.azboriu IS NOT NULL AND g_azb.azboriu CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azboriu like '%" || g_azb.azboriu CLIPPED || "%'"
    END IF 

    -- 条件 3：密码（精确匹配）
    IF g_azb.azb02 IS NOT NULL AND g_azb.azb02 CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azb02 = '" || g_azb.azb02 CLIPPED || "'"
    END IF 

    -- 条件 4：部门编号（精确匹配）
    IF g_azb.azborig IS NOT NULL AND g_azb.azborig CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azborig = '" || g_azb.azborig CLIPPED || "'"
    END IF 

    -- 条件 5：授权金额（精确匹配）
    IF g_azb.azb06 IS NOT NULL AND g_azb.azb06 CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azb06 = '" || g_azb.azb06 CLIPPED || "'"
    END IF

    -- 条件 6：修改日期（精确匹配）
    IF g_azb.azbdate IS NOT NULL AND g_azb.azbdate CLIPPED <> " " THEN 
        LET l_where = l_where ||
            " AND azbdate = '" || g_azb.azbdate CLIPPED || "'"
    END IF

    -- 拼接完整 SQL 语句，按人员编号排序
    LET l_sql = l_sql || l_where || " ORDER BY azb01"
                                                    
    -- 【调试输出】显示最终生成的 SQL 语句
    DISPLAY "DEBUG SQL => " || l_sql

    -- ▼ 查询执行阶段 ▼
    -- 预编译并准备游标
    PREPARE s_qry FROM l_sql
    DECLARE c_qry CURSOR FOR s_qry
    OPEN c_qry

    -- 取出查询结果的第一行
    FETCH c_qry INTO g_azb_rowid,g_azb.*
    
    -- 检查是否查到数据
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "查无资料"
        CLOSE c_qry
        RETURN
    END IF 

    -- ▼ 查询成功，显示结果 ▼
    -- 将查询结果显示在界面上
    DISPLAY BY NAME g_azb.*

    -- 设置查询成功标志，允许后续的修改和删除操作
    LET g_query_ok = 1

    MESSAGE "查询成功！"

    -- 关闭游标
    CLOSE c_qry

END FUNCTION    -- 查询功能函数结束



-- ====================================
-- 修改人员记录函数
-- ====================================
-- 前置条件：必须先执行 i888_query() 函数查询数据
-- 功能说明：
--   1. 检查是否已查询数据
--   2. 对数据行进行锁定（防止并发修改）
--   3. 允许用户修改数据（主键除外）
--   4. 验证修改后的数据
--   5. 用户确认后提交数据库
--
-- 数据流向：查询 → 行锁 → 编辑 → 验证 → 确认 → UPDATE → 提交
FUNCTION i888_modify()

    DEFINE l_ok LIKE type_file.num5
    DEFINE l_today DATE  -- 存放当前修改日期

    -- ▼ 第一步：前置条件检查 ▼
    -- 必须先执行查询，确保 g_query_ok = 1
    IF g_query_ok <> 1 THEN 
        MESSAGE "请先查询资料,再进行修改！"
        RETURN 
    END IF 

    -- 设置当前日期为修改日期
    LET l_today = TODAY

    -- ▼ 第二步：行级锁定（并发控制） ▼
    -- 开启事务，确保修改操作的原子性
    BEGIN WORK 

    -- 打开游标并使用 FOR UPDATE 锁定该行数据
    -- 防止其他用户同时修改同一条记录
    OPEN i888_cl USING g_azb_rowid
    
    FETCH i888_cl INTO g_azb.*

    -- 如果无法锁定（数据被其他用户占用），则报错
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料被其他人使用中，无法修改！"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN
    END IF 

    -- 显示锁定后的原始数据
    DISPLAY BY NAME g_azb.*

    -- ▼ 第三步：用户修改输入（主键不可修改） ▼
    INPUT BY NAME 
        g_azb.azboriu,  -- 人员姓名
        g_azb.azb02,    -- 登录密码
        g_azb.azborig,  -- 所属部门
        g_azb.azb06,    -- 授权金额
        g_azb.azbdate   -- 最近更改日期
        BEFORE INPUT 
            MESSAGE "请修改资料（主键不可修改）"
    END INPUT 

    -- ▼ 第四步：修改数据验证 ▼
    IF NOT i888_chk_modify() THEN 
        MESSAGE "资料检查失败,修改取消"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN
    END IF 

    -- ▼ 第五步：用户确认修改 ▼
    LET l_ok = cl_confirm("是否确认修改此笔资料？")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消修改！"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN 
    END IF 

    -- ▼ 第六步：执行 UPDATE 语句 ▼
    -- 构建 UPDATE SQL 语句
    LET g_sql =
        "UPDATE azb_file SET " ||
        "azboriu = ?, " ||
        "azb02   = ?, " ||
        "azborig = ?, " ||
        "azb06   = ?, " ||
        "azbuser = ?, " ||
        "azbdate = ? "  ||
        "WHERE rowid = ?"

    DISPLAY "UPDATE SQL => " || g_sql

    -- 预编译 SQL 语句
    PREPARE s_upd FROM g_sql

    -- 执行 UPDATE 语句，提交修改
    EXECUTE s_upd USING
        g_azb.azboriu,  -- 更新后的姓名
        g_azb.azb02,    -- 更新后的密码
        g_azb.azborig,  -- 更新后的部门
        g_azb.azb06,    -- 更新后的金额
        g_user,         -- 修改人
        l_today,        -- 修改时间
        g_azb_rowid     -- 定位条件

    -- 显示本次 UPDATE 影响的行数
    DISPLAY "update更新影响行数 ： " || SQLCA.SQLERRD[3]

    -- ★ 错误处理 ★
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "修改失败,SQLCODE = " || SQLCA.SQLCODE
        CLOSE i888_cl
        ROLLBACK WORK
        RETURN 
    END IF 

    -- 释放行锁并提交事务
    CLOSE i888_cl
    COMMIT WORK 

    MESSAGE "修改成功!"

    -- 修改后不自动刷新显示（可取消注释来启用自动刷新）
    -- CALL i888_show()

END FUNCTION    -- 修改功能函数结束


-- ====================================
-- 修改数据验证函数 - 检查业务规则
-- ====================================
-- 返回值：TRUE(验证成功) / FALSE(验证失败)
FUNCTION i888_chk_modify()

    -- 必填项 1：人员名称不能为空
    IF g_azb.azboriu IS NULL OR g_azb.azboriu CLIPPED = " " THEN 
        MESSAGE "人员名称不能为空！"
        RETURN FALSE 
    END IF

    -- 其他验证可在此处添加
    
    RETURN TRUE 

END FUNCTION    -- 修改数据检查函数结束



-- ====================================
-- 删除人员记录函数
-- ====================================
-- 功能说明：
--   1. 获取用户输入的删除条件（人员编号）
--   2. 查询并显示将要删除的数据（二次确认）
--   3. 对数据行进行锁定（防止并发删除）
--   4. 执行 DELETE 语句删除数据
--   5. 清空显示界面
--
-- 特点：需要二次确认，删除后无法恢复
-- 
-- 数据流向：输入编号 → 查询显示 → 用户确认 → 行锁 → DELETE → 清空显示
FUNCTION i888_delete()

    DEFINE l_ok LIKE type_file.num5
    DEFINE l_sql STRING 

    -- ▼ 第一步：清空显示并获取删除条件 ▼
    -- 清空上一次的数据和显示界面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

    -- 获取用户输入的人员编号（删除条件）
    INPUT BY NAME g_azb.azb01
        BEFORE INPUT 
            MESSAGE "请输入要删除的人员编号"
    END INPUT 

    -- 验证人员编号不能为空
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN 
        MESSAGE "人员编号不能为空！"
        RETURN 
    END IF 

    -- ▼ 第二步：查询将要删除的数据 ▼
    -- 根据编号查找 rowid（用于定位删除）
    SELECT ROWID
        INTO g_azb_rowid
        FROM azb_file
        WHERE TRIM(azb01) = TRIM(g_azb.azb01)

    -- 如果未找到数据
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料不存在,无法删除！"
        RETURN 
    END IF 

    -- 查询完整的人员记录
    SELECT *
        INTO g_azb.*
        FROM azb_file
        WHERE ROWID = g_azb_rowid

    -- 显示将要删除的数据，让用户确认
    DISPLAY BY NAME g_azb.*

    -- ▼ 第三步：用户二次确认 ▼
    -- 删除操作不可逆，需要用户二次确认
    LET l_ok = cl_confirm("确认要删除此笔资料吗？(删除后无法恢复！)")

    IF l_ok <> 1 THEN 
        MESSAGE "已取消删除"
        RETURN 
    END IF 

    -- ▼ 第四步：删除数据库记录 ▼
    -- 开启事务，确保删除的原子性
    BEGIN WORK 

    -- 对数据行进行锁定（防止其他用户同时删除同一条记录）
    OPEN i888_cl USING g_azb_rowid
    FETCH i888_cl INTO g_azb.*

    -- 如果无法锁定（数据被其他用户占用）
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "资料被其他人使用中,无法删除！"
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN 
    END IF

    -- 构建 DELETE SQL 语句
    LET l_sql = "DELETE FROM azb_file WHERE rowid = ?"

    DISPLAY "DELETE SQL => " || l_sql
    DISPLAY "ROWID = [" || g_azb_rowid || "]"

    -- 执行删除操作
    DELETE FROM azb_file
        WHERE ROWID = g_azb_rowid

    -- 显示本次 DELETE 影响的行数
    DISPLAY "DELETE ROW COUNT = " || SQLCA.SQLERRD[3]

    -- ★ 错误处理 ★
    IF SQLCA.SQLCODE <> 0 THEN 
        MESSAGE "删除失败,SQLCODE = " || SQLCA.SQLCODE
        CLOSE i888_cl
        ROLLBACK WORK 
        RETURN 
    END IF 

    -- 释放行锁并提交事务
    CLOSE i888_cl
    COMMIT WORK 

    MESSAGE "删除成功！"

    -- ▼ 第五步：清空显示 ▼
    -- 删除成功后清空变量和显示界面
    INITIALIZE g_azb.* TO NULL 
    CLEAR FORM 

END FUNCTION    -- 删除功能函数结束


-- ====================================
-- 复制人员记录函数
-- ====================================
-- 功能说明：
--   1. 检查是否已查询数据
--   2. 清除主键和自动字段，保留其他数据
--   3. 获取用户输入新的人员编号
--   4. 验证新编号的唯一性
--   5. 作为新记录插入数据库
--
-- 应用场景：批量创建相似配置的人员记录
FUNCTION i888_copy()

    DEFINE l_ok LIKE type_file.num5
    DEFINE g_debug STRING

    -- 检查是否已查询数据
    IF g_azb.azb01 IS NULL OR g_azb.azb01 CLIPPED = " " THEN
        MESSAGE "请先查询一笔资料，再执行复制！"
        RETURN
    END IF

    -- ▼ 第一步：清除主键和自动字段，保留其他数据 ▼
    -- 清空主键，让用户输入新编号
    LET g_azb.azb01   = NULL
    -- 设置日期为当前日期
    LET g_azb.azbdate = TODAY
    -- 设置操作人为当前登录用户
    LET g_azb.azbuser = g_user

    -- 显示即将复制的数据
    DISPLAY BY NAME g_azb.*

    -- ▼ 第二步：获取新的人员编号 ▼
    INPUT BY NAME
        g_azb.azb01,      -- 新人员编号（必填，需唯一）
        g_azb.azboriu,    -- 人员姓名（可编辑）
        g_azb.azb02,      -- 密码（可编辑）
        g_azb.azbacti,    -- 其他字段（可编辑）
        g_azb.azbgrup     -- 其他字段（可编辑）
        BEFORE INPUT
            MESSAGE "复制资料：请输入新人员编号"
    END INPUT

    -- ▼ 第三步：数据验证 ▼
    -- 检查新编号是否已存在
    IF NOT i888_chk_pk() THEN
        MESSAGE "主键检查失败，复制取消！"
        RETURN
    END IF

    -- 检查必填项和业务规则
    IF NOT i888_chk_insert() THEN
        MESSAGE "资料检查失败，复制取消！"
        RETURN
    END IF

    -- ▼ 第四步：用户确认 ▼
    LET l_ok = cl_confirm("是否确认复制此笔资料？")
    IF l_ok <> 1 THEN
        MESSAGE "已取消复制"
        RETURN
    END IF

    -- ▼ 第五步：插入新记录到数据库 ▼
    BEGIN WORK

    -- 执行 INSERT 语句，将复制的记录作为新记录插入
    INSERT INTO azb_file
        (azb01, azboriu, azb02, azborig, azb06, azbdate, azbuser)
    VALUES
        (g_azb.azb01,     -- 新的人员编号
         g_azb.azboriu,   -- 人员姓名
         g_azb.azb02,     -- 密码
         g_azb.azborig,   -- 部门编号
         g_azb.azb06,     -- 授权金额
         g_azb.azbdate,   -- 创建日期
         g_user)          -- 创建人


    -- ★ 错误处理 ★
    IF SQLCA.SQLCODE <> 0 THEN
        MESSAGE "复制新增失败，SQLCODE = " || SQLCA.SQLCODE
        ROLLBACK WORK
        RETURN
    END IF

    COMMIT WORK

    MESSAGE "复制成功！"

    -- 显示复制成功后的新记录
    CALL i888_show()

END FUNCTION    -- 复制功能函数结束


-- ====================================
-- 显示记录函数 - 在表单上显示数据
-- ====================================
-- 功能说明：将 g_azb 记录中的数据显示在界面的输入框上
-- 参数说明：无（直接使用全局变量 g_azb）
FUNCTION i888_show()

    -- 使用 BY NAME 方式显示：根据变量名匹配表单控件
    -- 自动将 g_azb.* 中的数据显示到对应的表单字段上
    DISPLAY BY NAME g_azb.*
    -- 备注：使用 DISPLAY g_azb.* 会输出到 Linux 终端（调试用）
    
END FUNCTION    -- 显示记录函数结束


-- ====================================
-- 导航跳转函数 - 处理导航按钮事件
-- ====================================
-- 功能说明：处理用户点击导航按钮（首笔/末笔等）的事件
-- 参数：p_mode - 'F'(首笔) / 'L'(末笔) / 其他
FUNCTION i010_fetch(p_mode)

    DEFINE p_mode CHAR(1)  -- 导航模式参数

    -- 根据不同的导航模式进行处理
    CASE p_mode 
        WHEN 'F'
            -- 导航到首笔记录
            LET g_azb.azb01 = "FIRST"
        WHEN 'L'
            -- 导航到末笔记录
            LET g_azb.azb01 = "LAST"
        OTHERWISE 
            -- 其他导航模式
            LET g_azb.azb01 = "OTHER"
    END CASE 

    -- 显示跳转后的记录
    CALL i888_show()
    
END FUNCTION    -- 导航跳转函数结束 

