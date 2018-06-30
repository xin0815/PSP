<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="true">
	<head>
		<title>用户</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.css" />
			<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
	</head>

	<style>
.submit6 {
	background: url(/uploadfile/200807/14/1513200969.gif) 0px 0px;
	border: 1px solid #7AADC8;
	height: 32px;
	font-size: 14px;
	font-weight: bold;
	padding-top: 2px;
	cursor: pointer;
}
文章出处：标准之路


(
http
:
//www


.aa25


.cn
/css_example/463


.shtml


)
</style>

	<script language="javascript">
var _parentDocument = window.parent.document;
$(function(){

    //全选和全不选操作
    $("#selectAll").click(function(){
           var size = $("#selectAll:checked").size();
           if(size == 1)//全选
               {
                     $("input[name='checkbox']").each(function(i,o){
                          o.checked = true;   
                     });
               }
           if(size == 0)//全不选
               {
        	      $("input[name='checkbox']").each(function(i,o){
                       o.checked = false;   
                   });
               }
        });

    $("#chaxun").click(function(){//查询操作
             $("#sysGroupForm").submit();
        });

})
function relationUser(obj,userId,userName){
	if(obj.checked){//选中时
		//表格中增加用户信息
		var _relationUserInfo = _parentDocument.getElementById("_relationUserInfo");
		var _tr = _relationUserInfo.insertRow(1); 
		_tr.id="TR_"+userId;
	    var _td1 = _tr.insertCell(0); 
	     _td1.innerHTML = userName;
//	     var _td3 = _tr.insertCell(); 
//	     _td3.innerHTML = userTypeName;
	     //增加ID
	     var userIds = _parentDocument.getElementById("_relationUserId");
	     if(userIds.value == ""){
	     	userIds.value = userId;
	     }else{
	     	userIds.value += ","+userId;
	     }
	}else{//取消选中时
		//删除表格中内容
		var _tr = _parentDocument.getElementById("TR_"+userId);
		_tr.parentNode.removeChild(_tr);
		//删除hidden中的Id设置
		var userIds = _parentDocument.getElementById("_relationUserId");
		var idArray = userIds.value.split(",");
		var newIds = "";
		for(var i=0;i<idArray.length;i++){
			if(userId != idArray[i]){
				if(newIds == "" ){
					newIds =idArray[i];
				}else{
					newIds +=","+idArray[i];
				}
			}
		}
		userIds.value = newIds;
	}
}
window.onload=function(){
	var userIds = _parentDocument.getElementById("_relationUserId");
	var idArray = userIds.value.split(",");
	var cboxs = $("input[name='checkbox']");
	for(var i=0;i<idArray.length;i++){
		for(var j=0;j<cboxs.length;j++){
			if(cboxs[j].id == idArray[i]){
				cboxs[j].checked=true;
			}
		}
	}
}
</script>
	<body>
		<form action="sysUser/queryAllUser" method="post" id="AllUserForm">
			<div class="well form-search">
				用户名
				<input type="text" name="userName" value="${sysUser.userName }"
					class="input-small" />
				<button type="submit" class="btn btn-info" id="chaxun">
					搜索
				</button>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				<tr>
					<td width="30">
						<input type="checkbox" name="allcheck" id="selectAll" />
					</td>
					<td>
						名称
					</td>
				</tr>
				<c:forEach var="sysUser" items="${pager.data}">
					<tr>
						<td width="30px">
							<input type="checkbox" id="${sysUser.userId}" name="checkbox"
								onclick="relationUser(this,'${sysUser.userId}','${sysUser.userName}')"
								value="${sysUser.userId}" />
						</td>
						<td>
							${sysUser.userName}
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="4"><jsp:include page="../common/Page.jsp" />
					</td>
				</tr>
			</table>
			</fieldset>
		</form>
	</body>
</html>
