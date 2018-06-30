<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>角色维护</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
</head>

<script language="javascript">
$(function(){
	//跳到添加页，进行添加操作
	$("#tj").click(function(){
    	window.location.href="<%=basePath%>sysRole/toAdd";
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

function relationUser(){//关联用户
	 var size =  $("input[name='checkbox']:checked").size();
	   if(size != 1) {
		     swal("错误提示", "请选择且只选一个修改", "error");
             return;
  	   }
     $("#_roleId").val($("input[name='checkbox']:checked").val());
	$("#relationUserForm").submit();
}

</script>

<body>
	<form action="sysRole/query" method="post" class="form-inline">
		<nav class="navbar navbar-default" role="navigation"
			style="background-color: rgb(241, 240, 240)">
			<div class="form-group">
				<label for="roleName">名称</label> <input type="text" name="roleName"
					class="form-control" value="${requestScope.roleName }"
					maxlength="20" placeholder="请输入..." />
			</div>
			<button type="submit" class="btn btn-primary">查询</button>
			<button type="button" class="btn btn-info" id="tj">新增</button>
			<button type="button" class="btn btn-success" id="update">修改</button>
			<button type="button" class="btn btn-warning" id="del">删除</button>
			<button type="button" class="btn btn-info" id="_relationUser" onclick="relationUser();">关联用户</button>
		</nav>
		<jsp:include page="../common/Page.jsp" />
	</form>
	<center>
		<!-- Page Module Begin -->
		<div class="table-responsive"><!-- 响应式表格 -->
			<table class="table table-condensed table-hover">
				<tr>
					<td width="30">#</td>
					<th width="30"><input type="checkbox" name="allcheck" id="selectAll" /></th>
					<th>名称</th>
					<th>描述</th>
				</tr>
				<c:forEach var="sysRole" items="${pager.data}" varStatus="st">
					<tr>
						<td>${st.index + 1}</td>
						<td width="30px"><input type="checkbox" name="checkbox" value="${sysRole.roleId}" /></td>
						<td>${sysRole.roleName}</td>
						<td>${sysRole.description}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</center>
	</div>
	</div>
	<form action="sysRole/delete" method="post" id="delForm">
		<input type="hidden" value="" id="delId" name="ids" />
	</form>
	<form action="sysRole/toUpdate" method="post" id="updateForm">
		<input type="hidden" value="" id="updId" name="updId" />
	</form>
	<form action="sysRole/queryRelationUser" method="post"
		id="relationUserForm">
		<input type="hidden" value="" id="_roleId" name="_roleId" />
	</form>
</body>
</html>
