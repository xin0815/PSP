<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<title>角色维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
        <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
$(function(){
	$("#baocun").click(function(){
		trimAll();
		if(checkName() == false){
			return false;
		}
        $("#form1").submit();
        document.all.baocun.disabled = true;
        document.all._close.disabled = true;
	});
	$("#_close").click(function(){
        window.location.href='<%=basePath%>sysRole/list';
	});
});
function checkName(){
	var roleName = document.all.roleName;
	var roleId = document.all.roleId.value;
	document.all.roleNameUniqueError.style.display = "none";
	document.all.roleNameErrorInfo.style.display = "";
	if(roleName.value == ""){
		document.all.roleNameDIV.className="control-group error";
		document.all.roleNameErrorInfo.innerHTML="不能为空";
		return false;
	}else{
		document.all.roleNameDIV.className="control-group success";
		document.all.roleNameErrorInfo.innerHTML="";
	}
	if(!ajaxCommonCheck("sysRole/isUniqueRoleName?roleId="+roleId+"&roleName="+roleName.value)){
		document.all.roleNameUniqueError.style.display = "";
		document.all.roleNameErrorInfo.style.display = "none";
		document.all.roleNameDIV.className="control-group error";
		return false;
	}
	return true;
}
</script>
	</head>
	<body>
		<form action="sysRole/add" method="post" id="form1"
			class="form-horizontal">
			<input type="hidden" name="roleId" value="${sysRole.roleId }" />
			<fieldset>
				<legend>
					角色资料
				</legend>
				<div class="control-group" id="roleNameDIV">
					<label class="control-label" for="roleName">
						名称
					</label>
					<div class="controls">
						<input class="form-control" style="width:15%" type="text" name="roleName" value="${sysRole.roleName }"
							maxlength="20" onblur="checkName();" />
						<span class="help-inline" id="roleNameErrorInfo"></span>
						<span class="help-inline" id="roleNameUniqueError"
							style="display: none;">此名称已存在</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="description">
						描述
					</label>
					<div class="controls">
						<textarea class="form-control" style="width:15%"name="description"
							onkeydown="this.value = this.value.substring(0, 128)">${sysRole.description }</textarea>
					</div>
				</div>
				<div class="form-actions"style="margin-left:50px;margin-top:10px">
					<button type="button" class="btn btn-primary" id="baocun">
						保存
					</button>
					<button type="button" style="margin-left:35px" class="btn btn-info" id="_close">
						取消
					</button>
				</div>
			</fieldset>
		</form>
	</body>
</html>