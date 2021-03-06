<!-- 修改页面 -->
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.imnu.cnt.system.util.Constants"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>用户维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
        <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		
		<script type="text/javascript"><!--
$(function(){
$("#baocun").click(function(){
		trimAll();
		var flag = true;
		if(flag == true){
			$("#form1").submit();
		}
	});
	$("#_close").click(function(){
        window.location.href='<%=basePath%>sysUser/list?userTypeCode=00';
	});
});
function checkName(){
	var userName = document.all.userName;
	if(userName.value == ""){
		document.all.userNameDIV.className="control-group error";
		document.all.userNameErrorInfo.innerHTML="不能为空";
		return false;
	}else{
		document.all.userNameDIV.className="control-group success";
		document.all.userNameErrorInfo.innerHTML="";
	}
	return true;
}
function checkAccount(){
    var str = document.all.account.value;
    var userId = document.all.userId.value;
	var reg = /^[a-zA-Z\d]\w{0,13}[a-zA-Z\d]$/;//正则
	document.all.accountUniqueError.style.display = "none";
	document.all.accountError.style.display = "";
	if(reg.test(str)){
		document.all.accountDIV.className="control-group success";
	}else{
		document.all.accountDIV.className="control-group error";
		return false;
	}
	if(!ajaxCommonCheck("<%=basePath%>sysUser/checkUniqueAccount?userId="+userId+"&account="+str)){
		document.all.accountUniqueError.style.display = "";
		document.all.accountError.style.display = "none";
		document.all.accountDIV.className="control-group error";
		return false;
	}
	return true;
}
</script>
	</head>
	<body>
		<form action="sysUser/add" method="post" id="form1"
			class="form-horizontal form-inline">
			<input type="hidden" name="code" value="${xiku.code}" />
			<fieldset>
				<legend>
					学院资料
				</legend>
				<div class="control-group" id="userNameDIV">
					<label class="control-label" for="userName">
						学院名称
					</label>
					<div class="controls">
						${xiku.name}
						<input class="form-control" style="width:15%" type="hidden" name="name" value="${xiku.name}"
							maxlength="24" onblur="checkAccount()" />
						<input class="form-control" style="width:15%" type="hidden" name="xuhao" value="${xiku.xuhao}"
							maxlength="24" onblur="checkAccount()" />
						<span class="help-inline" id="userNameErrorInfo"></span>
					</div>
				</div>
				<div class="control-group" id="accountDIV">
					<label class="control-label" for="account">
						英文翻译
					</label>
					<div class="controls">
						<input class="form-control" style="width:15%" type="text" name="enname" value="${xiku.enname}"
							maxlength="24" onblur="checkAccount()" />
						<span class="help-inline" id="accountUniqueError"
							style="display: none;">此账号已存在。</span>
					</div>
				</div>
				
				<div class="form-actions" style="margin-left:50px;margin-top:10px">
					<button  type="button" class="btn btn-primary" id="baocun">
						保存
					</button>
					<button style="margin-left:35px" type="button" class="btn btn-info" id="_close">
						取消
					</button>
				</div>
		</form>
	</body>
</html>