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
function update(coursenum,coursename)
{	
	var name = prompt("课设号\n"+coursenum+"\n课程名\n"+coursename+"\n请输入你要修改的英文");
	if(name!=null)
	{
		window.location.href="<%=basePath%>course/update?id="+coursenum+"&name="+name;
	}
}
$(function(){
	//跳到添加页，进行添加操作
	$("#tj").click(function(){
		window.location.href="<%=basePath%>professional/toAdd";
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
})
</script>

	<body>
		<form action="course/query" method="post" id="sysUserForm">
		<nav class="navbar navbar-default" role="navigation"
			style="background-color: rgb(241, 240, 240)">
			课程号
			<input name="coursenum" value="${coursenum}"/>
				专业
				<input name="coursename" value="${coursename}"/>
				</select>
					<button type="submit" class="btn btn-primary" id="chaxun">
					           搜索
				   </button>
			</nav>
			
			<center>
			<div class="table-responsive"><!-- 响应式表格 -->
			    <table class="table table-condensed table-hover">
			    	<tr>
					<th>课程号</th>
					<th>专业</th>
					<th>专业英文</th>
					<th>操作</th>
					
				</tr>
				<c:forEach var="sysUser" items="${pager.data}" varStatus="st">
						<tr>
							<td>
								${sysUser.courseNumber}
							</td>
							<td>
								${sysUser.courseName}
							</td>
							<td>${sysUser.courseEnName}</td>
							<td>
							<button type="button" class="btn btn-success" onclick="update('${sysUser.courseNumber}','${sysUser.courseName} ')">修改</button>
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
