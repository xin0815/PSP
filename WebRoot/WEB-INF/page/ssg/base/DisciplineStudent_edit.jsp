<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>违纪撤销申请理由</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<script language="javascript">
	window.onload = function(){
		document.getElementById("_span").innerHTML = 256;
	}
$(function(){

    $("#_export").click(function(){//跳到更新页，进行更新操作
    	   $("#_acaCode").val($("#aacademyCode").val());
    	   $("#_bsCode").val($("#bscode").val());
    	   $("#_cclassName").val($("#cclassName").val());
    	   $("#_cclassCode").val($("#cclassCode").val());
           $("#exportForm").submit();
        });
    $("#edit_submit").click(function(){
    	//去掉空格
    	$("#reason").val($("#reason").val().trim());
    	if($("#reason").val() == ""){
    		swal("错误提示", "请填写撤销理由", "error");
    		return ;
    	}
		swal({title: "温馨提示",text: "您确定提交违纪撤销申请吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
	    	$("#_sstudentcode").val($("#sstudentcode").val());
	    	$("#_dcode").val($("#dcode").val());
	    	$("#_reason").val($("#reason").val());
	    	$("#myForm").submit();
		});	
    });	
    
    $("#reason").keyup(function(){
    	var str = document.getElementById("reason").value.length;
    	var st = 256 - str;
    	document.getElementById("_span").innerHTML = st;
    });
    
})
</script>
	</head>
	<body>
		<form action="classTeacher/list" method="post" class="form-inline" id="staffForm">
			<div class="well form-search">
			<div class="form-group">
				<label for="">违纪学生学号</label>
				<input type="text" id="sstudentcode" name="sstudentcode" style="width: 140px;" class="form-control" disabled value="${ds.student.sstudentCode}" />
			</div>
			<div class="form-group">
				<label for="">违纪学生姓名</label>
				<input type="text" id="sname" name="sname" style="width: 100px;" class="form-control" disabled value="${ds.student.sname}" />
			</div>	
			<div class="form-group">
				<label for="">处理文号</label>
				<input type="text" id="dcode" name="dcode" style="width: 120px;" class="form-control" disabled value="${ds.dcode}" />
			</div>
			<div class="form-group">
				<label for="">处分等级</label>
				<input type="text" id="dlevel" name="dlevel" style="width: 120px;" class="form-control" disabled value="${ds.dlevel}" />
			</div>
			<div class="form-group">
				<label for="">处分日期</label>
				<input type="text" id="doccurDate" name="doccurDate" style="width: 120px;" class="form-control" disabled value="${ds.doccurDate}" />
			</div>
			</div>
	</form>
		<h4>撤销理由 </h4>
		<textarea class="form-control" rows="3" id = "reason"></textarea>
		<h4 align="right">剩余字数:<span id = "_span"></span></h4>
		<br/>
		<center><input type="submit" class="btn btn-warning" value = "提交撤销违纪理由" id = "edit_submit" />
			<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">
   					返回
   				</button>
		</center>
		
	 	<form action="disciplineStudent/update" method="post" id="myForm">
	 			<input type="hidden" id="_did" name="did" value="${ds.did}" >
				<input type="hidden" id="_reason" name="reason"  value="" />
		</form>
</body>
</html>
