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
		<title>分类维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
$(function(){
	$("#baocun").click(function(){
		trimAll();
		var flag = true;
		if(checkName() == false){
			flag = false;
		}
		if(checkURL() == false){
			flag = false;
		}
		if(document.all.isSynchro.checked == true){
			if(checkNULL(document.all.ip.value,document.all.ipDIV,document.all.ipErrorInfo) == false){
				flag = false;
			}
			if(checkNULL(document.all.port.value,document.all.portDIV,document.all.portErrorInfo) == false){
				flag = false;
			}
			if(checkNULL(document.all.dbName.value,document.all.dbNameDIV,document.all.dbNameErrorInfo) == false){
				flag = false;
			}
			if(checkNULL(document.all.dbUserName.value,document.all.dbUserNameDIV,document.all.dbUserNameErrorInfo) == false){
				flag = false;
			}
			if(checkNULL(document.all.dbPassword.value,document.all.dbPasswordDIV,document.all.dbPasswordErrorInfo) == false){
				flag = false;
			}
			if(flag == true){
				$("#form1").submit();
			}
		}
		if(flag == true){
			$("#form1").submit();
			document.all.baocun.disabled = true;
        	document.all._close.disabled = true;	
		}
	});
	$("#_close").click(function(){
        window.location.href='<%=basePath%>sysModule/list';
	});
	$("#isSynchro").click(function(){
        _onClickIsSynchro();
	});
});
function _onClickIsSynchro(){
	var isSynchro = document.all.isSynchro.checked;
    if(isSynchro == true){
    	document.all._SYNCHRO_INFO_TD.style.display="";
    }else{
    	document.all._SYNCHRO_INFO_TD.style.display="none";
    	document.all.ip.value="";
    	document.all.port.value="";
    	document.all.dbName.value="";
    	document.all.dbUserName.value="";
    	document.all.dbPassword.value="";
    }
}
function checkName(){
	var name = document.all.name;
	if(name.value == ""){
		document.all.nameDIV.className="control-group error";
		document.all.nameErrorInfo.innerHTML="不能为空";
		return false;
	}else{
		document.all.nameDIV.className="control-group success";
		document.all.nameErrorInfo.innerHTML="";
	}
	return true;
}
function checkURL(){
	var url = document.all.url;
	if(url.value == ""){
		document.all.urlDIV.className="control-group error";
		document.all.urlErrorInfo.innerHTML="不能为空";
		return false;
	}else{
		document.all.urlDIV.className="control-group success";
		document.all.urlErrorInfo.innerHTML="";
	}
	return true;
}
function checkNULL(objValue,objDIV,objError){
	if(objValue == ""){
		objDIV.className="control-group error";
		objError.innerHTML="不能为空";
		return false;
	}else{
		objDIV.className="control-group success";
		objError.innerHTML="";
	}
	return true;
}
window.onload=function(){
	if(document.all._isSynchro.value == "true"){
		document.all.isSynchro.checked = true;
		_onClickIsSynchro();
	}
}
</script>
	</head>
	<body>
		<form action="sysModule/add" method="post" id="form1"
			class="form-horizontal">
			<input type="hidden" name="moduleId" value="${sysModule.moduleId }" />
			
			<fieldset>
				<legend>
					相关业务系统
				</legend>
				<table>
					<tr>
						<td>
							<div class="control-group" id="nameDIV">
								<label class="control-label" for="name">
									学位
								</label>
								<div class="controls">
									<input type="text" name="name" value="${sysModule.name }"
										maxlength="24" onblur="checkName();" />
									<span class="help-inline" id="nameErrorInfo"></span>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="form-actions">
					<button type="button" class="btn btn-primary" id="baocun">
						保存
					</button>
					<button type="button" class="btn btn-info" id="_close">
						取消
					</button>
				</div>
			</fieldset>
		</form>
	</body>
</html>