
<!-- 密码修改 -->
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>密码修改</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
        <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
$(function(){
	$("#baocun").click(function(){
		if(checkOldPassword() == false){
			return false;
		}
		if(checkPassword() == false){
			return false;
		}
		if(checkConfirmPassword() == false){
			return false;
		}
        $("#form1").submit();
        document.all.baocun.disabled = true;
	});
});

function checkOldPassword(){
	var userId = document.all.userId.value;
	var oldPass = document.all.oldPassword.value;
	if(oldPass == "" || !ajaxCommonCheck("sysUser/checkOldPass?userId="+userId+"&oldPassword="+oldPass)){
		swal("错误提示", "请填写正确的原密码", "error");
		return false;
	}
	return true;
}

function checkPassword(){
    var str = document.all.password.value;
	var reg = /^[a-zA-Z\d]\w{4,13}[a-zA-Z\d]$/;//正则
	if(!reg.test(str)){
		swal("错误提示", "新密码格式不正确", "error");
		return false;
	}
	return true;
}

function checkConfirmPassword(){
    var pass = document.all.password;
    var passConfirm = document.all.passwordConfirm;
	if(pass.value != passConfirm.value){
		swal("错误提示", "确认密码不正确", "error");
		return false;
	}
	return true;
}
</script>
	</head>
	<body>
		<legend>
			密码修改
		</legend>
		<container>
		<form action="sysUser/editPass" method="post" id="form1" class="form-horizontal">
			<input type="hidden" name="userId" value="${user.userId }" />
			<c:if test="${not empty successInfo }">
				<div class="alert alert-success" role="alert"><h4>${successInfo }</h4></div>
			</c:if>
			<div class="form-group row" id="oldPasswordDIV">
				<label class="control-label col-sm-1 text-right" for="oldPassword">原密码</label>
				<div class="col-sm-3">
					<input type="password" name="oldPassword" class="form-control" maxlength="16" />
				</div>
				<div class="col-sm-8">
					
				</div>
			</div>
			<div class="form-group row" id="passwordDIV">
				<label class="control-label col-sm-1 text-right" for="password">新密码</label>
				<div class="col-sm-3">
					<input type="password" name="password" class="form-control" maxlength="16" />
				</div>
				<div class="col-sm-8">
					<span class="help-inline">密码必须6~16位长度，且只能包含英文字母、数字和下划线。</span>
				</div>
			</div>
			<div class="form-group row" id="passwordConfirmDIV">
				<label class="control-label col-sm-1 text-right" for="passwordConfirm">确认密码</label>
				<div class="col-sm-3">
					<input type="password" name="passwordConfirm" class="form-control" maxlength="16" />
				</div>
				<div class="col-sm-8">
					
				</div>
			</div>
			<center>
				<button type="button" class="btn btn-primary" id="baocun">
					保存
				</button>
			</center>
		</form>
		</container>
	</body>
</html>