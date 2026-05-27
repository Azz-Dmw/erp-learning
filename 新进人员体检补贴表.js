//自己客制的常用js（常用代码块）
document.write('<script type= "text/javascript" src="../../js/CustomFunctions.js?.ran=Math.rand()"></script>');
//HR系统接口文件
document.write('<script type="text/javascript" src="/zhrAjax/dwrCustom/interface/ajax_hrAjax.js"></script>');

//变量定义

var dliAprUser_txt = document.getElementById("dliAprUser_txt");//申请人(txt)
var dliAprUser_lbl = document.getElementById("dliAprUser_lbl");//申请人(lbl)
var dliAprDep_txt = document.getElementById("dliAprDep_txt");//申请部门(txt)
var dliAprDep_lbl = document.getElementById("dliAprDep_lbl");//申请部门(lbl)
var dateApr = document.getElementById("dateApr_txt");//申请日期
var txtA01 = document.getElementById("txtA01");//厂区
var txtA02 = document.getElementById("txtA02");//年月
var txtA03 = document.getElementById("txtA03_txt");//奖罚日期
var txtA03_txt = document.getElementById("txtA03_txt");//奖罚日期(txt)

var txtA04_txt = document.getElementById("txtA04_txt");//部门编号(txt)
var txtA04_lbl = document.getElementById("txtA04_lbl");//部门名称(lbl)
var txtA05_txt = document.getElementById("txtA05_txt");//工号
var txtA05_lbl = document.getElementById("txtA05_lbl");//姓名
var txtA06 = document.getElementById("txtA06");//入职日期
var txtA07 = document.getElementById("txtA07");//性别
var txtA08 = document.getElementById("txtA08");//体检补贴(分)

//连接数据库
var connect = new DataSource(formId, "sqlBPM");

//隐藏栏位
var hdnManager = document.getElementById("hdnManager");

//打开表单时自动赋值
function formCreate(){
  dliAprUser_txt.value = userId;
  dliAprUser_lbl.value = userName;
  dliAprDep_txt.value = mainOrgUnitIds;
  dliAprDep_lbl.value = mainOrgUnitNames;
  dateApr.value = systemDateTime;
  
  return true;
}

function formOpen(){

    grid_scoreObj.setHeight(400);

    grid_scoreObj.setDataAlign("txtA08","right");

    setBgColor("dliAprUser,dliAprDep,dateApr,txtA01,txtA02,txtA09");

    return true;
}

//保存时校验
function formSave(){

    var str = "";

  	hdnManager.value = getManager("dliAprUser_txt", "dliAprDep_txt", "sqlBPM"); // 自动获取直属主管
    str += getAlertBoolean("dliAprUser_txt","请选择申请人！");
    str += getAlertBoolean("dliAprDep_txt","请选择申请部门！");
    str += getAlertBoolean("txtA01","请选择厂区！");
    str += getAlertBoolean("txtA02","请选择年月！");
    str += getAlertBoolean("txtA03_txt","请选择奖罚日期！");

    if(grid_scoreObj.getData().length == 0){
        str += "明细不能为空！";
    }

    //人资录入HR系统
    if (activityId == "UserTask_20") {
        if (txtA03_txt.value == "") {
            alert("请选择奖罚日期！");
            return false;
        }
        if (confirm("确认不修改奖罚日期了？")) {

        } else {
            return false;
        }
    }

    if(str != ""){
        alert(str);
        return false;
    }

    return true;
}

function formClose(){
  return true;
}
function formDispatch(){
  return true;
}

//1、增加事件触发
function txtA01_onchange(){
    if(txtA01.value != "" && txtA02.value != ""){
        getData();
    }
}

function txtA02_onchange(){

    // 年月不能为空
    if(txtA02.value == ""){
        return;
    }

    // 格式必须为6位数字
    var reg = /^\d{6}$/;

    if(!reg.test(txtA02.value)){
        alert("年月格式错误，格式必须为：YYYYMM");
        txtA02.value = "";
        return false;
    }

    // 月份检查
    var month = txtA02.value.substring(4,6);

    if(Number(month) < 1 || Number(month) > 12){
        alert("月份必须在01~12之间！");
        txtA02.value = "";
        return false;
    }

    // 厂区和年月都有值才抓数据
    if(txtA01.value != ""){
        getData();
    }
}


//2、核心查询函数（重点）
function getData(){

    var tDs = new DataSource(formId,"sqlJFHR");

    var unit = "";

    // 厂区映射
    if(txtA01.value == "智富"){
        unit = "JF";
    }else{
        unit = "JH";
    }

  	//根据厂区和年月查询HR系统：数据抓取路径：HR系统——人员档案管理——新进人员体检补贴表
    var sql = ""
        + "select "
        + "ROW_NUMBER() OVER(ORDER BY PartNo) as A03,"
        + "PartNo as A04,"
        + "PartName as A04Name,"
        + "EmpNo as A05,"
        + "EmpName as A05Name,"
        + "CONVERT(VARCHAR(10),ComeDate,120) as A06,"
        + "SexName as A07,"
        + "case "
        + "when CONVERT(VARCHAR(8),ComeDate,112)<'20241101' then '3.5' "
        + "else '4' "
        + "end as A08 "
        + "from PerEmployee with(nolock) "
        + "where CONVERT(VARCHAR(6),ComeDate,112)= "
        + "CONVERT(VARCHAR(6),DATEADD(mm,-2,'"+txtA02.value+"01'),112) "
        + "and IsPerField4='1' "
        + "and InCumbency='1' "
        + "and CompanyNo='"+unit+"' "
        + "order by PartNo";

    console.log(sql);

    var tData = tDs.query(sql);

    var t = [];

    for(var i=0;i<tData.length;i++){

        var arr = {
            "txtA03": tData[i][0],
            "txtA04_txt": tData[i][1],
            "txtA04_lbl": tData[i][2],
            "txtA05_txt": tData[i][3],
            "txtA05_lbl": tData[i][4],
            "txtA06": tData[i][5],
            "txtA07": tData[i][6],
            "txtA08": tData[i][7]
        };

        t.push(arr);
    }

    console.log(t);

    grid_scoreObj.reload(t);
}

