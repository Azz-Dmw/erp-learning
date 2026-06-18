//引入所需使用的 Ajax Service 档案
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_DatabaseAccessor.js"></script>');
//自己客制的常用js（常用代码块）
document.write('<script type= "text/javascript" src="../../js/CustomFunctions.js?.ran=Math.rand()"></script>');
//开窗相关
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_ExtOrgAccessor.js"></script>');
document.write('<script type="text/javascript" src="../../CustomJsLib/EFGPShareMethod.js"></script>');
document.write('<script type="text/javascript" src="../../CustomJsLib/prefixAction/formComponentAction.js"></script>');
document.write('<script type="text/javascript" src="/zzAjaxBPM/dwrCustom/interface/ajax_autoInvokeProcess.js"></script>');

// 直属主管(hdnManager) ：
var hdnManager = document.getElementById("hdnManager");
//申请人 dliAprUser 
var dliAprUser_txt = document.getElementById("dliAprUser_txt");
var dliAprUser_lbl = document.getElementById("dliAprUser_lbl");
//   申请部门(dliAprDep) ：
var dliAprDep_txt = document.getElementById("dliAprDep_txt");
var dliAprDep_lbl = document.getElementById("dliAprDep_lbl");
//   申请日期(dateApr) ：
var dateApr = document.getElementById("dateApr_txt");
// 物料类型(ddlCustomerType) 
var ddlType = document.getElementById("ddlType");
// 业务会签(dliBusiness)
var dliBusiness_txt = document.getElementById("dliBusiness_txt");
var dliBusiness_lbl = document.getElementById("dliBusiness_lbl");
// 资材会签(dliMaterials)
var dliMaterials_txt = document.getElementById("dliMaterials_txt");
var dliMaterials_lbl = document.getElementById("dliMaterials_lbl");
//   组别(dateApr) ：
var ddlGroup = document.getElementById("ddlGroup");
//  签收人(dliSing)
var dliSing_txt = document.getElementById("dliSing_txt");
var dliSing_lbl = document.getElementById("dliSing_lbl");
// 库位(txtStorage)
var txtStorage = document.getElementById("txtStorage");
// 客户(txtCustomer)
var txtCustomer = document.getElementById("txtCustomer");
// 物料编号(txtERP)   
var txtERP = document.getElementById("txtERP");
// 物料名称(txtMaterialName)
var txtMaterialName = document.getElementById("txtMaterialName");
// 入库日期(datePut)
var datePut = document.getElementById("datePut_txt");
//数量(txtNumber)
var txtNumber = document.getElementById("txtNumber");
// 呆滞天数(txtSkyNumber)
var txtSkyNumber = document.getElementById("txtSkyNumber");
// 总量(GK)(txtWeight)
var txtWeight = document.getElementById("txtWeight");
// 呆滞原因(txaCause)
var txaCause = document.getElementById("txaCause");
// 业务处理方案(txaScheme)
var txaScheme = document.getElementById("txaScheme");
// 备注(txtPlannote)
var txtPlannote = document.getElementById("txtPlannote");
//grid 表格
var grid_score = document.getElementById("grid_score");
var hdnMaterials = document.getElementById("hdnMaterials");
var lbl_txtWeight = document.getElementById("lbl_txtWeight");


function formCreate() {
    dliAprUser_txt.value = userId;
    dliAprUser_lbl.value = userName;
    dliAprDep_txt.value = mainOrgUnitIds;
    dliAprDep_lbl.value = mainOrgUnitNames;
    dateApr.value = systemDateTime;
    return true;
}
function formOpen() {
    //如有Grid 此为必须存在的，用来传递表格数据
    if (typeof (grid_scoreObj) != "undefined") {
        if (grid_score.value.length > 0) {
            grid_scoreObj.reload(eval(grid_score.value));
        }
    }
  if(activityId == "UserTask_2"){
    datePut.readOnly=false;
  }
  lbl_txtWeight.innerHTML="总重(KG)";
  document.getElementById("aw36-header-7-box-text").innerHTML="总重(KG)";
  
  //20210222 --add --he 添加业务可修改备注
  if(activityId =="UserTask_11"){
    txtPlannote.readOnly=false;
    editButton.readOnly=false;
    txtPlannote.disabled=false;
    editButton.disabled=false;
  }
        setBgColor("dliAprUser,dliAprDep,dateApr,ddlType,ddlGroup,dliSing,dliBusiness,dliMaterials,addButton,delButton,editButton,toButton,deriveButton,txtStorage,txtCustomer,txtERP,txtMaterialName,txtNumber,txtSkyNumber,txtWeight,txaCause,txaScheme,txtPlannote,datePut");
  	setGridStyle("60,60,80,100,100,60,60,60,150,150,100", grid_scoreObj);
    grid_scoreObj.setSize(920, 180);
    grid_scoreObj.raiseEvent("paint");
    return true;
}
function formSave() {

    //用于存放弹窗值
    var str = "";
    // 发起人关卡
    var gData = grid_scoreObj.getData();
    if (activityId == "UserTask_2") {
        str += getAlertBoolean("dliAprUser_txt", "请选择申请人！");
        str += getAlertBoolean("dliAprDep_txt", "请选择申请人部门！");
        str += getAlertBoolean("dateApr_txt", "请填写日期！");
        str += getAlertBoolean("dliSing_txt", "请选择签收人！");
      
        //抓出申请人的直属主管
        hdnManager.value = getManager("dliAprUser_txt", "dliAprDep_txt", "sqlBPM");
        //if(dliMaterials_txt.value==""){
          
         //  hdnMaterials.value = "0";
        //}
       
      
        if (ddlType.value == 0) {
            str += "请选择物料类型！ \n";
        }
        if (ddlGroup.value == 0) {
            str += "请选择组别！ \n";
        }
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
//增加
function addButton_onclick() {

  var str = "";
    str += getAlertBoolean("txtStorage", "请填写库位！");
    str += getAlertBoolean("txtCustomer", "请填写客户！");
    str += getAlertBoolean("txtERP", "请填物料编号！");
    str += getAlertBoolean("txtMaterialName", "请填写物料名称！");
    str += getAlertBoolean("datePut_txt", "请填写入库日期！");
    str += getAlertBoolean("txtNumber", "请填写数量！");
    str += getAlertBoolean("txtSkyNumber", "请填写呆滞天数！");
    str += getAlertBoolean("txtWeight", "请填写总量(GK)！");
    str += getAlertBoolean("txaCause", "请填写呆滞原因！");
    str += getAlertBoolean("txaScheme", "请填写业务处理方案！");
  if(str!=""){
    alert(str);
    return false;
  }
    grid_scoreObj.addRow();   //将Binding栏位的资料填入Grid中
    grid_scoreObj.clearBinding();  //新增后清除BinDing栏位资料
    grid_score.value = grid_scoreObj.toArrayString();
  document.getElementById("aw36-header-7-box-text").innerHTML="总重(KG)";
}
//修改
function editButton_onclick() {

    grid_scoreObj.editRow();   //将Binding栏位的资料填入Grid中
    grid_scoreObj.clearBinding();  //修改后清除BinDing栏位资料
    grid_score.value = grid_scoreObj.toArrayString();
  document.getElementById("aw36-header-7-box-text").innerHTML="总重(KG)";
}
var excelName = "";
//汇入EXCEL
function toButton_onclick() {
    // 表单 Grid 名称
    var tFormGridName = "grid_score";
    //************************************************
    //请把 所有的 GridId  用"逗号" 组起来存入tFormGridName
    //表单上无论有几个grid 只要一个button执行汇入
    //按下button后，有一下拉组件，选择要汇入的gridID
    //************************************************

    // Excel 对应的域名 (可以设空白)
    var tExcelFieldName = "";
    //此段Code直接使用即可
    var tBatchUploaderString = encodeURI('/NaNaWeb/GP/WMS/PerformWorkItem/CallExcelImporter' + '?hdnMethod=initExcelImporter&excelFieldName=' + tExcelFieldName + '&formGridName=' + tFormGridName);
    var tReturn = true;
    //如果Grid已有数据则弹确认窗口(会清除目前grid的资料)

    if (grid_scoreObj.getData().length > 0) {
        tReturn = confirm('目前已有资料，如上传档案所有已存在数据将被清除，\r\n是否仍继续汇入？');
    }
    if (tReturn) {
        openDialog(tBatchUploaderString, '600', '600', 'titlebar,scrollbars,status,resizable');
    }
}
//删除
function delButton_onclick() {
    grid_scoreObj.deleteRow();  //将Grid某笔资料删除
    grid_scoreObj.clearBinding();  //清除Binding栏位资料
    grid_score.value = grid_scoreObj.toArrayString();
}
/**
* import excel文件的回传资料
*/
function loadExcelData(index, returnData) {
  console.log(returnData);
    fillGrid(returnData);
    return true;
}

/**
* 将取回的excel数据处理好后在汇入grid中
*/
//将取回的Excel数据处理好后再汇入grid中
function fillGrid(returnData) {
    //取得的Excel数据数组，可以再对它做处理
    var strError = "";
    var strErrorNum = 0;
    var returnData1 = eval(returnData);
  console.log(returnData1);
    var str = "[";
    //添加汇入Excel 的验证
     for (var i = 0; i < returnData1.length; i++) {
        str += "['" + returnData1[i][0] + "','" + returnData1[i][1] + "','" + returnData1[i][2] + "','" + returnData1[i][3] + "','" + returnData1[i][4] + "','" + returnData1[i][5] + "','" + returnData1[i][6] + "','" + returnData1[i][7] + "','" + returnData1[i][8] + "','" + returnData1[i][9] + "','" + returnData1[i][10] + "'],";
    }
    if (strError != "") {
        alert(strError);
        return false;
    }
    str = str.substring(0, str.length - 1);
    str += "]";
    //将取得的数据再处理
    grid_scoreObj.reload(eval(str));
    document.getElementById("grid_score").value = grid_scoreObj.toArrayString();
}
function deriveButton_onclick() {
    //用封装好的函数导出
    var gData = grid_scoreObj.getData();
    var tTitle = "库位,客户,物料编号,物料名称,入库日期,数量,呆滞天数,总量(KG),呆滞原因,业务处理方案,备注";
    var tType = "null,null,null,null,null,null,null,null,null,null,null";
    remitExcel(tTitle, tType, gData);
}


// ===============================
// 派送函数
// ===============================
function formDispatch() {

    console.log("派送函数formDispatch已触发，activityId =", activityId);

    if (activityId != "UserTask_61") {
        return true;
    }

    var gData = grid_scoreObj.getData();

    if (!gData || gData.length == 0) {
        alert("明细不能为空！");
        return false;
    }

    var gridXML = "";

    for (var i = 0; i < gData.length; i++) {

        var r = gData[i];

        gridXML +=
            '<record id="grid_score_' + i + '">' +
                "<item id='txtF01' dataType='java.lang.String' perDataProId=''>" + (r[0] || "") + "</item>" +
                "<item id='txtF02' dataType='java.lang.String' perDataProId=''>" + (r[1] || "") + "</item>" +
                "<item id='txtF03' dataType='java.lang.String' perDataProId=''>" + (r[2] || "") + "</item>" +
                "<item id='txtF04' dataType='java.lang.String' perDataProId=''>" + (r[3] || "") + "</item>" +
                "<item id='txtF05_txt' dataType='java.util.Date' perDataProId=''>" + (r[4] || "") + "</item>" +
                "<item id='txtF06' dataType='java.lang.String' perDataProId=''>" + (r[5] || "") + "</item>" +
                "<item id='txtF07' dataType='java.lang.String' perDataProId=''>" + (r[6] || "") + "</item>" +
                "<item id='txtF08' dataType='java.lang.String' perDataProId=''>" + (r[7] || "") + "</item>" +
                "<item id='txtF09' dataType='java.lang.String' perDataProId=''>" + (r[8] || "") + "</item>" +
                "<item id='txtF10' dataType='java.lang.String' perDataProId=''>" + (r[9] || "") + "</item>" +
                "<item id='txtF11' dataType='java.lang.String' perDataProId=''>" + (1 || "") + "</item>" +
                "<item id='txtF12' dataType='java.lang.String' perDataProId=''>" + (2 || "") + "</item>" +
                "<item id='txtF13' dataType='java.lang.String' perDataProId=''>" + (3 || "") + "</item>" +
                "<item id='txtF14' dataType='java.lang.String' perDataProId=''>" + (4 || "") + "</item>" +
                "<item id='txtF15' dataType='java.lang.String' perDataProId=''>" + (5 || "") + "</item>" +
                "<item id='txtF16' dataType='java.lang.String' perDataProId=''>" + (2026 || "") + "</item>" +
                "<item id='txtF17' dataType='java.lang.String' perDataProId=''>" + (6 || "") + "</item>" +
            '</record>';
    }

    var gridXML_FINAL =
        "<records>" +
            gridXML +
        "</records>";

var formXML =
    "<OA124>" +

        "<hdnManager id='hdnManager' dataType='java.lang.String' perDataProId=''>" +
            (hdnManager.value || "") +
        "</hdnManager>" +

        "<hdnMaterials id='hdnMaterials' dataType='java.lang.String' perDataProId=''>" +
            (hdnMaterials.value || "") +
        "</hdnMaterials>" +

        "<SerialNumber id='SerialNumber' dataType='java.lang.String' perDataProId=''>" +
            (typeof SerialNumber !== "undefined" ? SerialNumber : "") +
        "</SerialNumber>" +

        "<dliAprUser id='dliAprUser' list_hidden='' dataType='java.lang.String' " +
            "label='" + (dliAprUser_lbl.value || "") + "' hidden=''>" +
            (dliAprUser_txt.value || "") +
        "</dliAprUser>" +

        "<dliAprDep id='dliAprDep' list_hidden='' dataType='java.lang.String' " +
            "label='" + (dliAprDep_lbl.value || "") + "' hidden=''>" +
            (dliAprDep_txt.value || "") +
        "</dliAprDep>" +

        "<dateApr id='dateApr' list_hidden='' dataType='java.util.Date'>" +
            (dateApr.value || "") +
        "</dateApr>" +

        "<grid_score id='grid_score'>" + gridXML_FINAL + "</grid_score>" +

    "</OA124>";

    console.log("XML生成完成:",formXML);

    var formId = "OA124";
    var processId = "oaJFInvImpairReq";
    var gid = dliAprDep_txt.value;

    DWREngine.setAsync(false);

    var flowId = "";

    ajax_autoInvokeProcess.invoke(
        formXML,
        formId,
        processId,
        dliAprUser_txt.value,
        gid,
        function (data) {

            console.log("返回 =", data);

            if (data && data.indexOf("流程发起成功") > -1) {
                flowId = data.replace("流程发起成功，流程序号为：", "");
                alert("呆滞减值申请单发起成功，流程序号为：" + flowId);
            } else {
                alert("呆滞减值申请单发起失败：" + data);
            }
        }
    );

    DWREngine.setAsync(true);

    // 回写grid
    for (var j = 0; j < gData.length; j++) {
        gData[j].hdnBye = flowId;
    }

    grid_scoreObj.reload(gData);

    return true;
}