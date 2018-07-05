<!-- 学院班级管理 -->
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

<html lang="en">
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
	</head>
<script language="javascript">
function update(code,username)
{	
	console.log(username);
	var name = prompt("学院名称\n"+username+"\n请输入你要修改的英文");
	if(name!=null)
		window.location.href="<%=basePath%>sysUser/toAdd?id="+code+"&name="+name;
}
$(function(){
	//跳到添加页，进行添加操作
	$("#tj").click(function(){
		window.location.href="<%=basePath%>sysUser/toAdd";
	});
	//删除
      $("#del").click(function(){
		var checks = $("input[name='checkbox']:checked");
		if(checks.size() == 0) {
			swal("错误提示", "请选择删除的内容", "error");
            return;
        } else {
        	swal({title: "警告",text: "您确定要删除该角色吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
        		if(checks.size() == 1){
                    $("#delId").val(checks.val());
                }else{
                    var str = "";
                    checks.each(function(i,o){
                    	str = str + $(o).val()+",";
               	 });
                	$("#delId").val(str);
          		 }
           		$("#delForm").submit();
           });
   	 	}
	});
       //重置密码
    $("#resetPass").click(function(){
    	     var checks = $("input[name='checkbox']:checked");
    	     if(checks.size() == 0)
        	     {
                     swal("未选择条件!");
                     return;
        	     } else
            	     {
                         if(swal('您确定要重置密码吗？'))
                             {//删除
                                 if(checks.size() == 1)
                                     {
                                	   $("#resetPassIds").val(checks.val());
                                     }else
                                         {
                                           var str = "";
                                    	   checks.each(function(i,o){
                                                  str = str + $(o).val()+",";
                                        	   });
                                    	   $("#resetPassIds").val(str);
                                         }
                                
                                 $("#resetPassForm").submit();
                             }
            	     }
        });

    $("#chaxun").click(function(){//查询操作
    		trimAll();
             $("#sysUserForm").submit();
        });
})
window.onload=function(){
	var _options = document.all.categoryId.options;
	var _categoryValue = document.all._categoryValue.value;
	for(var i=0;i<_options.length;i++){
		if(_categoryValue == _options[i].value){
			_options[i].selected=true;
		}
	}
}
</script>

	<body>
		<form action="sysUser/query" method="post" id="sysUserForm">
		<nav class="navbar navbar-default" role="navigation"
			style="background-color: rgb(241, 240, 240)">
				学院
				<select id="categoryId" name="id" class="input-medium">
					<option value="">
						${degree}
					</option>
					<c:forEach var="category" items="${pager1.data}">
						<option value="${category.code }">
							${category.name }
						</option>
					</c:forEach>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="submit" class="btn btn-primary" id="chaxun">
					           搜索
				   </button>
			</nav>
			<center>
			<div class="table-responsive"><!-- 响应式表格 -->
			    <table class="table table-condensed table-hover">
			    	<tr>
					<th>学院</th>
					<th>对应英文</th>
					<th>操作</th>
				</tr>
				<c:forEach var="sysUser" items="${pager.data}" varStatus="st">
						<tr>
							<td>
								${sysUser.name}
							</td>
							<td>
								${sysUser.enname}
							</td>
							<td>
							<button type="button" class="btn btn-success" onclick="update(${sysUser.code},'${sysUser.name}')">修改</button>
							</td>
						</tr>
					</c:forEach>					
					</table>
				</div>
				<jsp:include page="../common/Page.jsp" />
     </center>
		</form>
		<form action="sysUser/delete" method="post" id="delForm">
			<input type="hidden" value="" id="delId" name="ids" />
		</form>
		<form action="sysUser/toUpdate" method="post" id="updateForm">
			<input type="hidden" value="" id="updId" name="updId" />
		</form>
		<form action="sysUser/resetPass" method="post" id="resetPassForm">
			<input type="hidden" value="" id="resetPassIds" name="ids" />
		</form>
	</body>
</html>
