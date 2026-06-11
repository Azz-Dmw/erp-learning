//auto hxw
//date 2018/7 /9
//tableName     客房申请单
document.write('<script type= "text/javascript" src="../../js/CustomFunctions.js?.ran=Math.rand()"></script>');
//工作时数
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_OrgAccessor.js"></script>');
// 流程相关的ajax
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_ProcessAccessor"></script>');// 流程变量
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_DatabaseAccessor"></script>');// 数据库
//客制开窗
document.write('<script type="text/javascript" src="../../CustomJsLib/EFGPShareMethod.js"></script>');
document.write('<script type="text/javascript" src="../../dwrDefault/interface/ajax_ExtOrgAccessor.js"></script>');

//导入自动触发流程的js
document.write('<script type="text/javascript" src="/zzAjaxBPM/dwrCustom/interface/ajax_autoInvokeProcess.js"></script>');
//申请人
var dliAprUser_txt = document.getElementById("dliAprUser_txt");
var dliAprUser_lbl = document.getElementById("dliAprUser_lbl");
//申请部门
var dliAprDep_txt = document.getElementById("dliAprDep_txt");
var dliAprDep_lbl = document.getElementById("dliAprDep_lbl");
var dateApr_txt= document.getElementById("dateApr_txt");
//直属主管
var hdnManager = document.getElementById("hdnManager");
//公司名称
var txtCompany = document.getElementById("txtCompany");
//公司类别
var ddlType = document.getElementById("ddlType");
//男宾
var txtMan = document.getElementById("txtMan");
//女宾
var txtGirl = document.getElementById("txtGirl");
//总人数
var txtNum = document.getElementById("txtNum");
//指定房间
var ddlBoolean = document.getElementById("ddlBoolean");
//入住房间
var ddlFang = document.getElementById("ddlFang");
//入住日期
var dateS = document.getElementById("dateS_txt");
var dateE = document.getElementById("dateE_txt");
//合计天数
var txtDate = document.getElementById("txtDate");
//申请理由
var txaReason = document.getElementById("txaReason");
//20240325 -- add 
var txtA01_0 = document.getElementById("txtA01_0");
var txtA01_1 = document.getElementById("txtA01_1");
var txtA01_2 = document.getElementById("txtA01_2");
var txtA01_3 = document.getElementById("txtA01_3");
var txtA01_4 = document.getElementById("txtA01_4");

var txtA02_txt = document.getElementById("txtA02_txt");
var txtA03_txt = document.getElementById("txtA03_txt");

var txtA04 = document.getElementById("txtA04");

//20260610 by dmw add
var txtA07_txt = document.getElementById("txtA07_txt"); //接待窗口:(txt)
var txtA07_hdn = document.getElementById("txtA07_hdn"); //接待窗口:(hdn)
var txtA08_txt = document.getElementById("txtA08_txt"); //办公地点:(txt)
var txtA08_hdn = document.getElementById("txtA08_hdn"); //办公地点:(hdn)
var txtA09 = document.getElementById("txtA09"); // 到访事由

var txtB01_txt = document.getElementById("txtB01_txt"); //开始日期
var txtB02_txt = document.getElementById("txtB02_txt"); //开始时间
var txtB03_txt = document.getElementById("txtB03_txt"); //预计结束日期
var txtB04_txt = document.getElementById("txtB04_txt"); //预计结束时间
var txtB05 = document.getElementById("txtB05"); //联系人
var txtB06 = document.getElementById("txtB06"); //联系方式
var txtB07 = document.getElementById("txtB07"); //人数
var txtB08 = document.getElementById("txtB08"); //出发地
var txtB09 = document.getElementById("txtB09"); //目的地
var txtB10 = document.getElementById("txtB10"); //用车说明
var txtC01_txt = document.getElementById("txtC01_txt"); //开始日期
var txtC02_txt = document.getElementById("txtC02_txt"); //开始时间
var txtC03_txt = document.getElementById("txtC03_txt"); //预计结束日期
var txtC04_txt = document.getElementById("txtC04_txt"); //预计结束时间
var txtC05 = document.getElementById("txtC05"); //联系人
var txtC06 = document.getElementById("txtC06"); //联系方式
var txtC07 = document.getElementById("txtC07"); //人数
var txtC08 = document.getElementById("txtC08"); //出发地
var txtC09 = document.getElementById("txtC09"); //目的地
var txtC10 = document.getElementById("txtC10"); //用车说明

function formCreate() {
    dliAprUser_txt.value = userId;
    dliAprUser_lbl.value = userName;
    dliAprDep_txt.value = mainOrgUnitIds;
    dliAprDep_lbl.value = mainOrgUnitNames;
    document.getElementById("dateApr_txt").value = systemDateTime;//申请日期
    return true;
}
function formOpen() {
    if (ddlBoolean.value == "是") {
        ddlFang.style.display = "block";
        document.getElementById("lbl_ddlFang").style.display = "block";
    } else {
        ddlFang.style.display = "none";
        document.getElementById("lbl_ddlFang").style.display = "none";
    }

    document.getElementById("lbl_txtA01").innerHTML = "权限类型【需要上传人员姓名，照片附件】";
    document.getElementById("lbl_txtA01").style.color = "red";
  
    if (activityId == "UserTask_5") {
        txtA04.readOnly = false;
        txtA04.disabled = false;
    }

    if (txtA01_3.checked) {
        FormUtil.show(["txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "HorizontalLine25", "HorizontalLine26"]);
    } else {
        FormUtil.hide(["txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "HorizontalLine25", "HorizontalLine26"]);
    }
    if (activityId != "UserTask_2") {
        if (txtB01_txt.value != "") {
            FormUtil.show(["txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "HorizontalLine25"]);
        }else{
             FormUtil.hide(["txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "HorizontalLine25"]);
        }
        if (txtC01_txt.value != "") {
            FormUtil.show(["txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "HorizontalLine26"]);
        }else{
              FormUtil.hide(["txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "HorizontalLine26"]);
        }
    }
   setBgColor("dliAprUser,dliAprDep,dateApr,txtA01,txtA02,txtA03,txtCompany,ddlType,txtMan,txtGirl,txtNum,ddlBoolean,ddlFang,dateS,dateE,txtDate,txtA01,txtA02,txtA03,txtA04,txtA05,txaReason,txtA07,txtA08,txtA09,txtB01,txtB02,txtB03,txtB04,txtB05,txtB06,txtB07,txtB08,txtB09,txtB10,txtC01,txtC02,txtC03,txtC04,txtC05,txtC06,txtC07,txtC08,txtC09,txtC10");

    return true;
}
function formSave() {
    var str = "";
    if (activityName == "发起人") {
        hdnManager.value = getManager("dliAprUser_txt", "dliAprDep_txt", "sqlBPM");
        str += getAlertBoolean("dliAprUser_txt", "请选择申请人！");
        str += getAlertBoolean("dliAprDep_txt", "请选择申请部门！");
        str += getAlertBoolean("dateApr_txt", "请选择申请日期！");
        str += getAlertBoolean("txtCompany", "请输入公司名称！");
        str += getAlertBoolean("txtNum", "请输入男宾与女宾人数！");
        str += getAlertBoolean("dateS_txt", "请选择入住开始日期！");
        str += getAlertBoolean("dateE_txt", "请选择入住结束日期！");
        str += getAlertBoolean("txaReason", "请输入申请理由！");

        if (ddlType.value == "0") {
            alert("请选择公司类别");
            return false;
        }

        if (ddlBoolean.value == "0") {
            alert("是否指定房间");
            return false;
        }
        if (ddlBoolean.value == "是" && ddlFang.value == "0") {
            alert("请选择入住房间");
            return false;
        }

        if (!txtA01_0.checked && !txtA01_1.checked && !txtA01_2.checked && !txtA01_3.checked && !txtA01_4.checked) {
            alert("请选择权限类型");
            return false;
        }
        if (txtA01_0.checked || txtA01_2.checked) {
            str += getAlertBoolean("txtA02_txt", "请选择会签人资！");
        }
        if (txtA01_1.checked) {
            str += getAlertBoolean("txtA02_txt", "请选择会签人资！");
            str += getAlertBoolean("txtA03_txt", "请选择会签资讯中心！");
        }
      if(txtA01_4.checked){
         str += getAlertBoolean("txtA05_txt", "勾选了报餐申请，请选择会签总务，并上传用餐明细附件！");
      }
        if (txtA01_3.checked) {
          
          
            if (txtB01_txt.value == "" && txtB02_txt.value == "" && txtB03_txt.value == "" && txtB04_txt.value == "" && txtC01_txt.value == "" && txtC02_txt.value == "" && txtC03_txt.value == "" && txtC04_txt.value == "") {
                alert("请填写用车(出行)或用车(返程)信息！");
                return false;
            }


            if (txtB01_txt.value != "" || txtB02_txt.value != "" || txtB03_txt.value != "" || txtB04_txt.value != "" || txtB05.value != "" || txtB06.value != "" || txtB07.value != "" || txtB08.value != "" || txtB09.value != "" || txtB10.value != "") {
                str += getAlertBoolean("txtB01_txt", "请选择用车（出行）开始日期");
                str += getAlertBoolean("txtB02_txt", "请选择用车（出行）开始时间");
                str += getAlertBoolean("txtB03_txt", "请选择用车（出行）预计结束日期");
                str += getAlertBoolean("txtB04_txt", "请选择用车（出行）预计结束时间");
                str += getAlertBoolean("txtB05", "请填写用车（出行）联系人");
                str += getAlertBoolean("txtB06", "请填写用车（出行）联系方式");
                str += getAlertBoolean("txtB07", "请填写用车（出行）人数");
                str += getAlertBoolean("txtB08", "请填写用车（出行）出发地");
                str += getAlertBoolean("txtB09", "请填写用车（出行）目的地");
                str += getAlertBoolean("txtB10", "请填写用车（出行）用车说明");
            }
            if (txtC01_txt.value != "" || txtC02_txt.value != "" || txtC03_txt.value != "" || txtC04_txt.value != "" || txtC05.value != "" || txtC06.value != "" || txtC07.value != "" || txtC08.value != "" || txtC09.value != "" || txtC10.value != "") {
                str += getAlertBoolean("txtC01_txt", "请选择用车（返程）开始日期");
                str += getAlertBoolean("txtC02_txt", "请选择用车（返程）开始时间");
                str += getAlertBoolean("txtC03_txt", "请选择用车（返程）预计结束日期");
                str += getAlertBoolean("txtC04_txt", "请选择用车（返程）预计结束时间");
                str += getAlertBoolean("txtC05", "请填写用车（返程）联系人");
                str += getAlertBoolean("txtC06", "请填写用车（返程）联系方式");
                str += getAlertBoolean("txtC07", "请填写用车（返程）人数");
                str += getAlertBoolean("txtC08", "请填写用车（返程）出发地");
                str += getAlertBoolean("txtC09", "请填写用车（返程）目的地");
                str += getAlertBoolean("txtC10", "请填写用车（返程）用车说明");
            }
        }
    }
    if (activityId == "UserTask_5") {
        str += getAlertBoolean("txtA04", "请填写房间数量！");
    }
    getDecision();
    if (str != "") {
        alert(str);
        return false;
    }
    if (activityName == "发起人") {
        if (txtA01_0.checked || txtA01_1.checked || txtA01_2.checked) {
            if (confirm("请确认是否已经上传人员名单，照片等附件！")) {

            } else {
                return false;
            }
        }
    }
  
  

    return true;
}
function formDispatch() {
  
    if (activityId == "UserTask_5") {
        //出行
        if (txtB01_txt.value != "") {
            var tDs = new DataSource(formId, "sqlBPM");
            var tsql = "select o.id , o.organizationunitname  from  users u , functions f,organizationUnit o where u.oid=f.occupantoid and o.oid=f.organizationUnitoid and f.isMain='1' and u.id='" + dliAprUser_txt.value + "'";
            var tData = tDs.query(tsql);
            var gid = tData[0][0];
            var gname = tData[0][1];
            var xml = "<CAMApplication>" +
                "<subject id='subject' dataType='java.lang.String' perDataProId=''>客房申请单申请派车</subject>" +
                "<contact id='contact' dataType='java.lang.String' perDataProId=''>" + dliAprUser_lbl.value + "</contact>" +
                "<reason id='reason' dataType='java.lang.String' perDataProId=''>" + txtB10.value.replace(/\&/g, '&amp;').replace(/\>/g, '&gt;').replace(/\</g, '&lt;') + "</reason>" +
                "<passengers id='passengers' dataType='java.lang.String' perDataProId=''></passengers>" +
                "<description id='description' dataType='java.lang.String' perDataProId=''></description>" +
                "<vehicleName id='vehicleName' dataType='java.lang.String' perDataProId=''></vehicleName>" +
                "<vehicleType id='vehicleType' dataType='java.lang.String' perDataProId=''></vehicleType>" +
                "<licenseNumber id='licenseNumber' dataType='java.lang.String' perDataProId=''></licenseNumber>" +
                "<drivername id='drivername' dataType='java.lang.String' perDataProId=''></drivername>" +
                "<passengerCapacity id='passengerCapacity' dataType='java.lang.String' perDataProId=''></passengerCapacity>" +
                "<passengerNum id='passengerNum' dataType='java.lang.Integer' perDataProId=''>" + txtB07.value + "</passengerNum>" +
                "<endpoint id='endpoint' dataType='java.lang.String' perDataProId=''>" + txtB09.value.replace(/\&/g, '&amp;') + "</endpoint>" +
                "<purpose id='purpose' dataType='java.lang.String' perDataProId=''>出差</purpose>" +
                "<startpoint id='startpoint' dataType='java.lang.String' perDataProId=''>" + txtB08.value + "</startpoint>" +
                "<driverphone id='driverphone' dataType='java.lang.String' perDataProId=''></driverphone>" +
                "<starttime id='starttime' dataType='java.util.Date' perDataProId=''>" + txtB01_txt.value + ' ' + txtB02_txt.value + "</starttime>" +
                "<shared id='shared' dataType='java.lang.String'></shared>" +
                "<endtime id='endtime' dataType='java.util.Date' perDataProId=''>" + txtB03_txt.value + ' ' + txtB04_txt.value + "</endtime>" +
                "<caroid id='caroid' dataType='java.lang.String' perDataProId=''></caroid>" +
                "<driveroid id='driveroid' dataType='java.lang.String' perDataProId=''></driveroid>" +
                "<phone id='phone' dataType='java.lang.String' perDataProId=''>"+txtB06.value+"</phone>" +
                // "<oid id='oid' dataType='java.lang.String' perDataProId=''>85eafd17f15043a68785daa3f3757a10</oid>"+
                "<hdnShared id='hdnShared' dataType='java.lang.String' perDataProId=''>1</hdnShared>" +
                "<hdnTrigger id='hdnTrigger' dataType='java.lang.String' perDataProId=''>" + SerialNumber.innerHTML + "</hdnTrigger>" +
                "<txtA06 id='txtA06' dataType='java.lang.String' perDataProId=''></txtA06>" +
                "</CAMApplication>";
            console.log(xml);
            var formIds = "CAMApplication";//表单代号  
            var processId = "CAM_APPLY";
            DWREngine.setAsync(false);
            ajax_autoInvokeProcess.invoke(xml, formIds, processId, dliAprUser_txt.value, gid, function loaddata(data) {
                if (data.indexOf("流程发起成功") > -1) {
                    hdnByc.value = data.replace("流程发起成功，流程序号为：", "");
                }
            });
            DWREngine.setAsync(true);
            if (hdnByc.value == "") {
                alert("触发用车申请单失败！");
                return false;
            }
        }
        //返程
        if (txtC01_txt.value != "") {
            var tDs = new DataSource(formId, "sqlBPM");
            var tsql = "select o.id , o.organizationunitname  from  users u , functions f,organizationUnit o where u.oid=f.occupantoid and o.oid=f.organizationUnitoid and f.isMain='1' and u.id='" + dliAprUser_txt.value + "'";
            var tData = tDs.query(tsql);
            var gid = tData[0][0];
            var gname = tData[0][1];
            var xml = "<CAMApplication>" +
                "<subject id='subject' dataType='java.lang.String' perDataProId=''>客房申请单申请派车</subject>" +
                "<contact id='contact' dataType='java.lang.String' perDataProId=''>" + dliAprUser_lbl.value + "</contact>" +
                "<reason id='reason' dataType='java.lang.String' perDataProId=''>" + txtC10.value.replace(/\&/g, '&amp;').replace(/\>/g, '&gt;').replace(/\</g, '&lt;') + "</reason>" +
                "<passengers id='passengers' dataType='java.lang.String' perDataProId=''></passengers>" +
                "<description id='description' dataType='java.lang.String' perDataProId=''></description>" +
                "<vehicleName id='vehicleName' dataType='java.lang.String' perDataProId=''></vehicleName>" +
                "<vehicleType id='vehicleType' dataType='java.lang.String' perDataProId=''></vehicleType>" +
                "<licenseNumber id='licenseNumber' dataType='java.lang.String' perDataProId=''></licenseNumber>" +
                "<drivername id='drivername' dataType='java.lang.String' perDataProId=''></drivername>" +
                "<passengerCapacity id='passengerCapacity' dataType='java.lang.String' perDataProId=''></passengerCapacity>" +
                "<passengerNum id='passengerNum' dataType='java.lang.Integer' perDataProId=''>" + txtC07.value + "</passengerNum>" +
                "<endpoint id='endpoint' dataType='java.lang.String' perDataProId=''>" + txtC09.value.replace(/\&/g, '&amp;') + "</endpoint>" +
                "<purpose id='purpose' dataType='java.lang.String' perDataProId=''>出差</purpose>" +
                "<startpoint id='startpoint' dataType='java.lang.String' perDataProId=''>" + txtC08.value + "</startpoint>" +
                "<driverphone id='driverphone' dataType='java.lang.String' perDataProId=''></driverphone>" +
                "<starttime id='starttime' dataType='java.util.Date' perDataProId=''>" + txtC01_txt.value + ' ' + txtC02_txt.value + "</starttime>" +
                "<shared id='shared' dataType='java.lang.String'></shared>" +
                "<endtime id='endtime' dataType='java.util.Date' perDataProId=''>" + txtC03_txt.value + ' ' + txtC04_txt.value + "</endtime>" +
                "<caroid id='caroid' dataType='java.lang.String' perDataProId=''></caroid>" +
                "<driveroid id='driveroid' dataType='java.lang.String' perDataProId=''></driveroid>" +
                 "<phone id='phone' dataType='java.lang.String' perDataProId=''>"+txtC06.value+"</phone>" +
                // "<oid id='oid' dataType='java.lang.String' perDataProId=''>85eafd17f15043a68785daa3f3757a10</oid>"+
                "<hdnShared id='hdnShared' dataType='java.lang.String' perDataProId=''>1</hdnShared>" +
                "<hdnTrigger id='hdnTrigger' dataType='java.lang.String' perDataProId=''>" + SerialNumber.innerHTML + "</hdnTrigger>" +
                "<txtA06 id='txtA06' dataType='java.lang.String' perDataProId=''></txtA06>" +
                "</CAMApplication>";
            console.log(xml);
            var formIds = "CAMApplication";//表单代号  
            var processId = "CAM_APPLY";
            DWREngine.setAsync(false);
            ajax_autoInvokeProcess.invoke(xml, formIds, processId, dliAprUser_txt.value, gid, function loaddata(data) {
                if (data.indexOf("流程发起成功") > -1) {
                    hdnByc.value = data.replace("流程发起成功，流程序号为：", "");
                }
            });
            DWREngine.setAsync(true);
            if (hdnByc.value == "") {
                alert("触发用车申请单失败！");
                return false;
            }
        }

    }
  
    return true;
}
function formClose() {
    return true;
}
//获取needId的主要部门编号，名称
function get_mainDep(needId) {
    var tDs = new DataSource(formId, "sqlBPM");
    var tSql = "select o.id,o.organizationunitname  from users u,functions f,organizationunit o" +
        " where u.oid=f.occupantoid " +
        " and o.oid=f.organizationunitoid " +
        " and u.id='" + needId + "' and f.ismain='1' ";
    var tData = tDs.query(tSql);
    dliAprDep_txt.value = tData[0][0];
    dliAprDep_lbl.value = tData[0][1];
}
//申请人更换事件
function dliAprUser_onchange() {
    get_mainDep(dliAprUser_txt.value);
}
//申请部门开窗事件
function dliAprDep_btn_onclick() {
    var FileName = "SingleOpenWin";//SingleOpenWin.jsp程序
    var tSql = "select o.id , o.organizationunitname  from  users u , functions f,organizationUnit o  " +
        " where u.oid=f.occupantoid and o.oid=f.organizationUnitoid and u.id='" + dliAprUser_txt.value + "' ";
    var SQLClaused = new Array(tSql);
    var SQLLabel = new Array("部门代号", "部门名称");//开窗的Grid栏位字段
    var QBEField = new Array("o.id", "o.organizationunitname");//开窗的Grid栏位对应数据库的字段
    var QBELabel = new Array("部门代号", "部门名称");//开窗的模糊查询的标签以及文本框
    var ReturnId = new Array("dliAprDep_txt", "dliAprDep_lbl");//表单上组件与开窗上对应的代号
    singleOpenWin(FileName, "BPM", SQLClaused, SQLLabel, QBEField, QBELabel, ReturnId, 720, 430);
}

//计算日期相减天数 
function getCountTime() {
    var S = new Date(dateS.value + " 00:00:00");
    var E = new Date(dateE.value + " 00:00:00");
    var days = E.getTime() - S.getTime();
    txtDate.value = parseInt(days / (1000 * 60 * 60 * 24)) + parseInt("1");
    if (isNaN(txtDate.value)) {
        txtDate.value = "";
    }
}

function dateS_onchange() {
    getCountTime();
}

function dateE_onchange() {
    getCountTime();
}

//指定房间选择事件
function ddlBoolean_onchange() {
    if (ddlBoolean.value == "是") {
        ddlFang.style.display = "block";
        document.getElementById("lbl_ddlFang").style.display = "block";
    } else {
        ddlFang.style.display = "none";
        document.getElementById("lbl_ddlFang").style.display = "none";
    }
}

function txtMan_onchange() {
    jisuan();
}

function txtGirl_onchange() {
    jisuan();
}
function jisuan() {
    var m = "0";
    var g = "0";
    if (isNaN(txtMan.value) || txtMan.value == "") {
        m = "0";
        txtMan.value = "";
    } else {
        m = txtMan.value;
    }
    if (isNaN(txtGirl.value) || txtGirl.value == "") {
        g = "0";
        txtGirl.value = "";
    } else {
        g = txtGirl.value;
    }
    txtNum.value = parseInt(m) + parseInt(g);
}
// 流程变量AJAX,判断核决到哪里
function getDecision() {
    var prsInstOID;
    var relevantDataId;
    var relevantDataValue;

    // 將processInstOID放到流程變數
    prsInstOID = processInstOID;
    relevantDataId = "depDecision"; // 流程變數
    if (ddlFang.value == "中信凯旋城") {
        relevantDataValue = "1";// 副总经理
    } else {
        relevantDataValue = "0";
    }
    ajax_ProcessAccessor.assignRelevantData(prsInstOID, relevantDataId, relevantDataValue, loadAssignRelevantData2);
}
function loadAssignRelevantData2(data) { }

function txtA02_btn_onclick() {
    var FileName = "SingleOpenWin";
    //var tSql = "select id,username from users where leaveDate is null order by id asc";
    var tSql = "select u.id,u.username,o.id,o.organizationunitname,u.id||'_'||u.username a  from users u,functions f,organizationunit o where u.oid=f.occupantoid and o.oid=f.organizationunitoid and f.ismain='1' and u.leaveDate is null and o.id like 'J203%' order by u.id asc";
    var SQLClaused = new Array(tSql);
    var SQLLabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var QBEField = new Array("u.id", "u.username", "o.id", "o.organizationunitname");
    var QBELabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var ReturnId = new Array("", "", "", "", "txtA02_txt");
    singleOpenWin(FileName, 'BPM', SQLClaused, SQLLabel, QBEField, QBELabel, ReturnId, 900, 780);
}
function txtA03_btn_onclick() {
    var FileName = "SingleOpenWin";
    //var tSql = "select id,username from users where leaveDate is null order by id asc";
    var tSql = "select u.id,u.username,o.id,o.organizationunitname,u.id||'_'||u.username a  from users u,functions f,organizationunit o where u.oid=f.occupantoid and o.oid=f.organizationunitoid and f.ismain='1' and u.leaveDate is null and o.id like 'J103%' order by u.id asc";
    var SQLClaused = new Array(tSql);
    var SQLLabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var QBEField = new Array("u.id", "u.username", "o.id", "o.organizationunitname");
    var QBELabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var ReturnId = new Array("", "", "", "", "txtA03_txt");
    singleOpenWin(FileName, 'BPM', SQLClaused, SQLLabel, QBEField, QBELabel, ReturnId, 900, 780);
}
function txtA05_btn_onclick() {
    var FileName = "SingleOpenWin";
    //var tSql = "select id,username from users where leaveDate is null order by id asc";
    var tSql = "select u.id,u.username,o.id,o.organizationunitname,u.id||'_'||u.username a  from users u,functions f,organizationunit o where u.oid=f.occupantoid and o.oid=f.organizationunitoid and f.ismain='1' and u.leaveDate is null and o.id like 'J202%' order by u.id asc";
    var SQLClaused = new Array(tSql);
    var SQLLabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var QBEField = new Array("u.id", "u.username", "o.id", "o.organizationunitname");
    var QBELabel = new Array("工号", "姓名", "部门代号", "部门名称");
    var ReturnId = new Array("", "", "", "", "txtA05_txt");
    singleOpenWin(FileName, 'BPM', SQLClaused, SQLLabel, QBEField, QBELabel, ReturnId, 900, 780);
}
function txtA01_onchange() {
    if (txtA01_3.checked) {
        FormUtil.show(["txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "HorizontalLine25", "HorizontalLine26"]);
    } else {
        FormUtil.hide(["txtB01", "txtB02", "txtB03", "txtB04", "txtB05", "txtB06", "txtB07", "txtB08", "txtB09", "txtB10", "txtC01", "txtC02", "txtC03", "txtC04", "txtC05", "txtC06", "txtC07", "txtC08", "txtC09", "txtC10", "HorizontalLine25", "HorizontalLine26"]);
    }
}

function txtB06_onchange(){
  if(!/^1[3-9]\d{9}$/.test(txtB06.value)){
        alert("手机号码验证错误！");
    txtB06.value="";
  }
}

function txtC06_onchange(){
   if(!/^1[3-9]\d{9}$/.test(txtC06.value)){
        alert("手机号码验证错误！");
      txtC06.value="";
  }
}

function validateMobile(phone) {
    return /^1[3-9]\d{9}$/.test(phone);
}


