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
    		trimAll();
             $("#sysUserForm").submit();
        });

   $("#update").click(function(){//跳到更新页，进行更新操作
    	   var size =  $("input[name='checkbox']:checked").size();
    	   if(size != 1)
        	   {
    		   	   swal("错误提示", "请选择且只选一个修改", "error");
                   return;
        	   }
           $("#updId").val($("input[name='checkbox']:checked").val());
           $("#updateForm").submit();
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
		<form action="sysUser/Query" method="post" id="sysUserForm">
		<nav class="navbar navbar-default" role="navigation"
			style="background-color: rgb(241, 240, 240)">
				学院
				<select id="categoryId" name="categoryId" class="input-medium">
					<option value="">
						---- 全部 ----
					</option>
					<c:forEach var="category" items="${categoryList}">
						<option value="${category.id }">
							${category.categoryName }
						</option>
					</c:forEach>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				专业
				<input name="profession	" value="专业"/>
				</select>
					<button type="submit" class="btn btn-primary" id="chaxun">
					           搜索
				   </button>
			</nav>
			
			<center>
			<div class="table-responsive"><!-- 响应式表格 -->
			    <table class="table table-condensed table-hover">
			    	<tr>
			    	<th>对应学院</th>
					<th>专业	</th>
					<th>对应英文</th>
					<th>操作</th>
					
				</tr>
				<c:forEach var="sysUser" items="${pager.data}" varStatus="st">
						<tr>
							<td>
								${sysUser.userName}
							</td>
							<td>
								${sysUser.account}
							</td>
							<td>
								${sysUser.description}
							</td>
							<td>
							<button type="button" class="btn btn-success" id="update">修改</button>
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
		<form action="sysUser/toupdate" method="post" id="updateForm">
			<input type="hidden" value="" id="updId" name="updId" />
		</form>
		<form action="sysUser/resetPass" method="post" id="resetPassForm">
			<input type="hidden" value="" id="resetPassIds" name="ids" />
		</form>
	</body>
</html>
