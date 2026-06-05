//引入所需使用的 Ajax Service 档案
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_DatabaseAccessor.js"></script>');
//自己客制的常用js（常用代码块）
document.write('<script type= "text/javascript" src="../../js/CustomFunctions.js?.ran=Math.rand()"></script>');
//开窗相关
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_ExtOrgAccessor.js"></script>');
document.write('<script type="text/javascript" src="../../CustomJsLib/EFGPShareMethod.js"></script>');
document.write('<script type="text/javascript" src="../../CustomJsLib/prefixAction/formComponentAction.js"></script>');

var hdnMaterials =  document.getElementById("hdnMaterials");

//变量定义
var dliAprUser_txt =  document.getElementById("dliAprUser_txt"); //申请人:(txt)
var dliAprUser_lbl =  document.getElementById("dliAprUser_lbl"); //申请人:(lbl)
var dliAprUser_hdn =  document.getElementById("dliAprUser_hdn"); //申请人:(hdn)
var dliAprDep_txt =  document.getElementById("dliAprDep_txt"); //申请人部门:(txt)
var dliAprDep_lbl =  document.getElementById("dliAprDep_lbl"); //申请人部门:(lbl)
var dliAprDep_hdn =  document.getElementById("dliAprDep_hdn"); //申请人部门:(hdn)
var dateApr_txt = document.getElementById("dateApr_txt");//申请日期

var txtF01 =  document.getElementById("txtF01"); //库位:
var txtF02 =  document.getElementById("txtF02"); //客户:
var txtF03 =  document.getElementById("txtF03"); //物料编号:
var txtF04 =  document.getElementById("txtF04"); //物料名称:
var txtF05_txt =  document.getElementById("txtF05_txt"); //入库日期:
var txtF06 =  document.getElementById("txtF06"); //数量:
var txtF07 =  document.getElementById("txtF07"); //呆滞天数:
var txtF08 =  document.getElementById("txtF08"); //重量(KG):
var txtF09 =  document.getElementById("txtF09"); //成本价:
var txtF10 =  document.getElementById("txtF10"); //成本金额:
var txtF11 =  document.getElementById("txtF11"); //减值比例:
var txtF12 =  document.getElementById("txtF12"); //减值金额:
var txtF13 =  document.getElementById("txtF13"); //呆滞原因:
var txtF14 =  document.getElementById("txtF14"); //业务处理方案:
var txtF15 =  document.getElementById("txtF15"); //备注
var txtF16 =  document.getElementById("txtF16"); //ERP导入年度
var txtF17 =  document.getElementById("txtF17"); //ERP导入月份

//按钮
var btnAdds =  document.getElementById("btnAdds"); //连续新增
var btnAdd =  document.getElementById("btnAdd"); //新增
var btnEdit =  document.getElementById("btnEdit"); //修改
var addButton =  document.getElementById("addButton"); //增加
var delButton =  document.getElementById("delButton"); //删除
var editButton =  document.getElementById("editButton"); //修改资料
var Attachment =  document.getElementById("Attachment"); //上传附件
var fromERP=  document.getElementById("fromERP"); //ERP导入

//连接数据库
var connect = new DataSource(formId, "sqlBPM");

//隐藏栏位
var hdnManager = document.getElementById("hdnManager");

function formCreate(){
  
    dliAprUser_txt.value = userId;
    dliAprUser_lbl.value = userName;
    dliAprDep_txt.value = mainOrgUnitIds;
    dliAprDep_lbl.value = mainOrgUnitNames;
    dateApr_txt.value = systemDateTime;

    var parts = systemDateTime.split('/');
    var currentYear  = parseInt(parts[0], 10);   // 获取当前年2026
    var currentMonth = parseInt(parts[1], 10);   // 获取当前月6
  
      // 計算上個月
    var lastMonth = currentMonth - 1;
    var lastYear  = currentYear;

    if (lastMonth === 0) {
        lastMonth = 12;
        lastYear  = currentYear - 1;
    }

    // 補零（確保月份是兩位數，如 01、09）
    var lastMonthStr = lastMonth < 10 ? '0' + lastMonth : lastMonth;

    // 賦值
    txtF16.value = lastYear;          // 年
    txtF17.value = lastMonthStr;      // 月（帶補零）
  
  return true;
  
}

function formOpen(){

    jq = jQuery.noConflict();
      FormUtil.transToDialog({
        gridId: 'grid_score', //Grid的代号
        inputId: 'SubTab' //输入元件摆放的「分页元件」代号
    });
 
    //如有Grid 此为必须存在的，用来传递表格数据
    if (typeof (grid_scoreObj) != "undefined") {
        if (grid_score.value.length > 0) {
            grid_scoreObj.reload(eval(grid_score.value));
        }
    }

    
	if(activityId == "UserTask_3"){
      fromERP.disabled= false;
      txtF16.disabled=false;
      txtF16.readOnly=false;
      txtF17.disabled=false;
      txtF17.readOnly=false;
      txtF17.style.backgroundColor = "white";
    }
    

    /*
    FormUtil.transToDialog({
        gridId: 'grid_score', //Grid的代号
        inputId: 'SubTab' //输入元件摆放的「分页元件」代号
    });
    */

    setBgColor("dliAprUser,dliAprDep,dateApr,txtF01,txtF02,txtF03,txtF04,txtF05,txtF06,txtF07,txtF08,txtF09,txtF10,txtF11,txtF12,txtF13,txtF14");
  	setGridStyle("60,60,80,100,100,60,60,60,150,150,100", grid_scoreObj);

  return true;
}

function formSave() {

    //用于存放弹窗值
    var str = "";
    // 发起人关卡
    var gData = grid_scoreObj.getData();
    if (activityId == "UserTask_3") {
        str += getAlertBoolean("dliAprUser_txt", "请选择申请人！");
        str += getAlertBoolean("dliAprDep_txt", "请选择申请人部门！");
        str += getAlertBoolean("dateApr_txt", "请填写日期！");

        var sqlBPM = new DataSource(formId, "sqlBPM");

        if(gData.length==0){
         str+="请新增呆滞转仓资料！";
        }

        //抓出申请人的直属主管
        hdnManager.value = getManager("dliAprUser_txt", "dliAprDep_txt", "sqlBPM");
       
    }
 
  //console.log(str);
    if (str != "") {
        alert(str);
        return false;
    }

    if (gData.length == 0) {
        alert("至少填入一行资料！");
        return false;
    }

    grid_scoreObj.clearBinding();

    return true;

}

function formClose() {
    return true;
}

//申请人改变时，申请人部门随着改变
function dliAprUser_onchange() {
    var arr = getMainDep("dliAprUser_txt", "sqlBPM");
    dliAprDep_txt.value = arr[0][0];
    dliAprDep_lbl.value = arr[0][1];
}

//申请人部门客制开窗
function dliAprDep_btn_onclick() {
    openDepWindow("dliAprUser_txt", "dliAprDep_txt", "dliAprDep_lbl");
}


//新增资料按钮
function addButton_onclick() {

    FormUtil.showGridDialog('grid_score');//显示弹窗
    grid_scoreObj.clearBinding();
}

//修改资料按钮
function editButton_onclick() {
    if (grid_scoreObj.getRowIndex() != -1) {
        FormUtil.showGridDialog('grid_score');
    }
}

//删除资料按钮
function delButton_onclick() { 
    var gridData = grid_scoreObj.getData();
    if (grid_scoreObj.getRowIndex() != -1) {
        var index = parseInt(grid_scoreObj.getRowIndex());
        grid_scoreObj.deleteRow();
        grid_scoreObj.clearBinding();
        if (index < gridData.length - 1) {
            grid_scoreObj.setRowIndex(index);
        }
        return true;
    } else {
        return false;
    }
}

//连续新增按钮
function btnAdds_onclick(){

     var str = "";
        str += getAlertBoolean("txtF01", "请填写库位！");
        str += getAlertBoolean("txtF02", "请填写客户！");
        str += getAlertBoolean("txtF03", "请填写物料编号！");
        str += getAlertBoolean("txtF04", "请填写物料名称！");
        str += getAlertBoolean("txtF05_txt", "请填写入库日期！");
        str += getAlertBoolean("txtF06", "请填写数量！");
        str += getAlertBoolean("txtF07", "请填写呆滞天数！");
        str += getAlertBoolean("txtF08", "请填写重量！");
        str += getAlertBoolean("txtF09", "请填写成本价！");
        str += getAlertBoolean("txtF10", "请填写成本金额！");
        str += getAlertBoolean("txtF11", "请填写减值比例！");
        str += getAlertBoolean("txtF12", "请填写减值金额！");
        str += getAlertBoolean("txtF13", "请填写呆滞原因！");
        str += getAlertBoolean("txtF14", "请填写业务处理方案！");  
     if (str == "") {
        grid_scoreObj.addRow();
        grid_scoreObj.clearBinding(); 
        return true;
    } else {
        alert(str);
        return false;
    }
  
}

//新增按钮
function btnAdd_onclick(){
      var str = "";
        str += getAlertBoolean("txtF01", "请填写库位！");
        str += getAlertBoolean("txtF02", "请填写客户！");
        str += getAlertBoolean("txtF03", "请填写物料编号！");
        str += getAlertBoolean("txtF04", "请填写物料名称！");
        str += getAlertBoolean("txtF05_txt", "请填写入库日期！");
        str += getAlertBoolean("txtF06", "请填写数量！");
        str += getAlertBoolean("txtF07", "请填写呆滞天数！");
        str += getAlertBoolean("txtF08", "请填写重量！");
        str += getAlertBoolean("txtF09", "请填写成本价！");
        str += getAlertBoolean("txtF10", "请填写成本金额！");
        str += getAlertBoolean("txtF11", "请填写减值比例！");
        str += getAlertBoolean("txtF12", "请填写减值金额！");
        str += getAlertBoolean("txtF13", "请填写呆滞原因！");
        str += getAlertBoolean("txtF14", "请填写业务处理方案！");  
    if (str == "") {
        grid_scoreObj.addRow();
        grid_scoreObj.clearBinding();
        FormUtil.hideGridDialog('grid_score');
        return true;
    } else {
        alert(str);
        return false;
    }
  
}

//修改按钮
function btnEdit_onclick(){
   var str = "";
        str += getAlertBoolean("txtF01", "请填写库位！");
        str += getAlertBoolean("txtF02", "请填写客户！");
        str += getAlertBoolean("txtF03", "请填写物料编号！");
        str += getAlertBoolean("txtF04", "请填写物料名称！");
        str += getAlertBoolean("txtF05_txt", "请填写入库日期！");
        str += getAlertBoolean("txtF06", "请填写数量！");
        str += getAlertBoolean("txtF07", "请填写呆滞天数！");
        str += getAlertBoolean("txtF08", "请填写重量！");
        str += getAlertBoolean("txtF09", "请填写成本价！");
        str += getAlertBoolean("txtF10", "请填写成本金额！");
        str += getAlertBoolean("txtF11", "请填写减值比例！");
        str += getAlertBoolean("txtF12", "请填写减值金额！");
        str += getAlertBoolean("txtF13", "请填写呆滞原因！");
        str += getAlertBoolean("txtF14", "请填写业务处理方案！");  
   var gData = grid_scoreObj.getData(); 
   var index = parseInt(grid_scoreObj.getRowIndex());
   if (str == "") {
        grid_scoreObj.editRow();
        grid_scoreObj.clearBinding();
        if (index < gData.length - 1) {
            grid_scoreObj.setRowIndex(index + 1);
        }
        return true;
    } else {
        alert(str);
        return false;
    }
  
}

//ERP导入按钮
function fromERP_onclick(){
  
    var tDs = new DataSource(formId, "sqlJFERP");
	var year = txtF16.value;
	var month = txtF17.value;
    var tFileName = "PluralityOpenWin";

    //查询SQL语句
    var tSql =
        "SELECT tc_jcz03 || NVL2(NULLIF(TRIM(tc_jcz04), ''), ':' || tc_jcz04, '') tc_jcz03, " +
        "NVL(tc_jcz13,' ') tc_jcz13, tc_jcz06, ima02, TO_CHAR(tc_jcz09,'yyyy/mm/dd') tc_jcz09, tc_jcz12, " +
        "ROUND(LAST_DAY(TO_DATE('" + year + "-" + month + "-01', 'YYYY-MM-DD')) - tc_jcz09, 0) AS stockage, " +
        "IMA18 AS IMA18, " +
        /* ✅ 成本价（防 NULL） */
        "NVL(CCC23,0) AS CCC23, " +
        /* ✅ 成本金额 */
        "NVL(CCC23,0) * NVL(tc_jcz12,0) AS cost, " +
        /* ✅ 减值比例 */
        "CASE tc_jcz16 " +
        "WHEN '34' THEN '30%' " +
        "WHEN '36' THEN '60%' " +
        "WHEN '37' THEN '60%' " +
        "WHEN '33' THEN '90%' " +
        "WHEN '41' THEN '90%' " +
        "ELSE '0%' END AS rate, " +
        /* ✅ 减值金额 */
        "(NVL(CCC23,0) * NVL(tc_jcz12,0)) * " +
        "CASE tc_jcz16 " +
        "WHEN '34' THEN 0.3 " +
        "WHEN '36' THEN 0.6 " +
        "WHEN '37' THEN 0.6 " +
        "WHEN '33' THEN 0.9 " +
        "WHEN '41' THEN 0.9 " +
        "ELSE 0 END AS imp, " +
        "CASE tc_jcz16 " +
        "WHEN '33' THEN '33:转仓-呆滞品仓，损耗多出，后续订单冲销' " +
        "WHEN '34' THEN '34:转仓-呆滞品仓，客人正式订单排程延后' " +
        "WHEN '36' THEN '36:转仓-呆滞品仓，业务备料，后续订单冲销' " +
        "WHEN '37' THEN '37:转仓-呆滞品仓，资材业务生管备料，后续订单冲销' " +
        "WHEN '41' THEN '41:转仓-客供品仓，已立帐' " +
        "ELSE '' END AS tc_jcz16, " +
        "NVL(tc_jcz22,' ') tc_jcz22 " +
        "FROM jd.tc_jcz_file " +
        "LEFT JOIN jd.IMD_FILE ON imd01 = tc_jcz03 " +
        "LEFT JOIN jd.IME_FILE ON ime01 = tc_jcz03 AND ime02 = tc_jcz04 " +
        "LEFT JOIN jd.IMA_FILE ON ima01 = tc_jcz06 " +
        "LEFT JOIN jd.GEM_FILE ON gem01 = tc_jcz27 " +
        "LEFT JOIN jd.CCC_FILE ON tc_jcz06 = CCC01 AND CCC02 = '" + year + "' AND CCC03 = '" + month + "' " +
        "WHERE tc_jcz01 = " + year + " " +
        "AND tc_jcz02 = " + month + " " +
        "AND tc_jcz16 IN ('33','34','36','37','41')";

  		console.log(tSql);//输出SQL语句到控制台，方便调试

  		var tSQLClaused = new Array(tSql);
        var tSQLLabel = new Array("库位", "客户", "物料编号", "物料名称", "入库日期", "数量", "呆滞天数", "重量","成本价","成本金额","减值比例","减值金额", "呆滞原因", "业务处理方案");//客製開窗的Grid Label
        var tQBEField = new Array("tc_jcz03", "tc_jcz13",  "tc_jcz06",  "ima02", "tc_jcz09", "tc_jcz12","stockage","IMA18","CCC23","cost","rate","imp","tc_jcz16","tc_jcz22");//客製開窗的查詢條件模糊查詢,須和DB Table欄位名稱相同
        var tQBELabel = new Array("库位", "客户", "物料编号", "物料名称", "入库日期", "数量", "呆滞天数", "重量","成本价","成本金额","减值比例","减值金额", "呆滞原因", "业务处理方案");//客製開窗的查詢條件模糊查詢的Label
        //資料在放入前要先整理

        var tReturnId = new Array("hdnMaterials");//表單回傳畫面上的欄位

        pluralityOpenWin(tFileName, "JFERP", tSQLClaused, tSQLLabel, tQBEField, tQBELabel, tReturnId, 900, 730);
        

}  


/*
 * 客製開窗關閉後的事件檢查點
 */
function checkPointOnClose(pReturnId) {
    console.log(pReturnId);
    if (pReturnId == 'hdnMaterials') {
      console.log(hdnMaterials.value);
      var t=hdnMaterials.value;
      hdnMaterials.value="";
      var tData =splitEvalArrayString(t);
        console.log(t.length);
        console.log(tData);
    var str = "[";
    //添加汇入Excel 的验证
    for (var i = 0; i < tData.length; i++) {
                    str += "['"
                + tData[i][1] + "','"  // 库位
                + tData[i][2] + "','"  // 客户
                + tData[i][3] + "','"  // 物料编号
                + tData[i][4] + "','"  // 物料名称
                + tData[i][5] + "','"  // 入库日期
                + tData[i][6] + "','"  // 数量
                + tData[i][7] + "','"  // 呆滞天数
                + tData[i][8] + "','"  // 重量
                + tData[i][9] + "','"  // 成本价
                + tData[i][10] + "','"  // 成本金额
                + tData[i][11] + "','" // 减值比例
                + tData[i][12] + "','" // 减值金额
                + tData[i][13] + "','" // 呆滞原因
                + tData[i][14] + "','" // 业务处理方案
                + "'],";               // 备注先空白
    }

    // 可逐条打印详细内容
    tData.forEach((row, index) => {
        console.log("第 " + index + " 行：", row);
    });

    str = str.substring(0, str.length - 1);
    str += "]";
    if(str=="]"){
        alert("ERP当月并无资料！");
        return;
    }
    //将取得的数据再处理
    grid_scoreObj.reload(eval(str));
    }

}


// 專門用來處理超長資料字串的函式
// 分段解析超長的 [ [...], [...], ... ] 格式資料
function splitEvalArrayString(bigStr) {
    var result = [];

    if (typeof bigStr !== 'string' || bigStr.length < 10) {
        return result;
    }

    // 去掉最外層 [ 和 ]，並清理前後空白
    bigStr = bigStr.trim();
    if (bigStr.charAt(0) === '[') bigStr = bigStr.substring(1);
    if (bigStr.charAt(bigStr.length - 1) === ']') bigStr = bigStr.substring(0, bigStr.length - 1);
    bigStr = bigStr.trim();

    var current = '';
    var depth = 0;
    var inString = false;
    var success = 0;
    var fail = 0;

    for (var i = 0; i < bigStr.length; i++) {
        var char = bigStr.charAt(i);
        current += char;

        // 處理引號內的內容（避免逗號被誤判）
        if (char === "'" && (i === 0 || bigStr.charAt(i - 1) !== '\\')) {
            inString = !inString;
        }

        if (!inString) {
            if (char === '[' || char === '{' || char === '(') depth++;
            if (char === ']' || char === '}' || char === ')') depth--;

            // 找到一筆完整的項目（深度回到0，且遇到逗號）
            if (char === ',' && depth === 0) {
                var itemStr = current.substring(0, current.length - 1).trim();

                if (itemStr) {
                    try {
                        // 因為是單引號陣列，直接 eval 這一小段
                        var item = eval(itemStr);
                        if (item && item.length >= 10) {  // 你的資料每筆約11個欄位
                            result.push(item);
                            success++;
                        }
                    } catch (e) {
                        fail++;
                        // console.log("這筆失敗:", itemStr.substring(0, 60) + "...", e.message);
                    }
                }
                current = '';  // 重置
            }
        }
    }

    // 最後一筆（沒有後面的逗號）
    if (current.trim()) {
        try {
            var lastItem = eval(current.trim());
            if (lastItem && lastItem.length >= 10) {
                result.push(lastItem);
                success++;
            }
        } catch (e) {
            fail++;
            // console.log("最後一筆失敗:", current.substring(0, 60) + "...");
        }
    }

    // console.log("成功:", success, "失敗:", fail, "總計:", result.length);
    return result;
}