<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<title>班级新建及新生设定</title>
     	<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript">
			$(function(){
			//跳到添加页，进行添加操作
				$("#tjbj").click(function(){
					window.location.href="<%=basePath%>classStudent/create";
				});
		 		$("#update").click(function(){//跳到更新页，进行更新操作
					var size =  $("input[name='checkbox']:checked").size();
					if(size != 1){
						swal("错误提示", "请选择且只选一个修改", "error");
						return;
					}
					$("#updId").val($("input[name='checkbox']:checked").val());
					var cid=$("input[name='checkbox']:checked").val();
		            window.location.href="<%=basePath%>classStudent/toUpdate?classId="+cid;
				});   	
				$("#del").click(function(){//删除
					var checks = $("input[name='checkbox']:checked");
					if(checks.size() == 0){
						swal("错误提示", "请选择且只选一个修改", "error");
						return;
					} else{
  						swal({title: "温馨提示",text: "您确定要删除吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							if(checks.size() == 1){
								$("#delId").val(checks.val());
							}
							var cid=$("input[name='checkbox']:checked").val();
							window.location.href="<%=basePath%>classStudent/delete?id="+cid;
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
					var size =  $("input[name='checkbox']:checked").size();
					if(size != 1){
						swal("错误提示", "请选择且只选一个修改", "error");
						return;
					}
					var cid=$("input[name='checkbox']:checked").val();
		            window.location.href="<%=basePath%>classStudent/info?classId="+cid;
			
				});
				$("#daoru").click(function(){//查询操作
					var size =  $("input[name='checkbox']:checked").size();
					if(size != 1){
						swal("错误提示", "请选择且只选一个修改", "error");
						return;
					}
					var cid=$("input[name='checkbox']:checked").val();
		            window.location.href="<%=basePath%>classStudent/toImportStudent?classId="+cid;
			
				});
			})
		</script>
	</head>
	<body>
		<legend>
			班级维护
		</legend>
		<form action="classStudent/list" class="form-inline" id="baseClassForm" method="post">
			<div class="well form-search">
				<div class="form-group">
					<label for="roleName">学院</label>
					<input type="text" name="academy" class="form-control" value="${academy.aname}" readonly />
				</div>
				<div class="form-group">
					<label for="exampleInputEmail2">学年学期</label>
					<input class="form-control" type="text" name="semester" value="${semester.bname}" readonly />
				</div>
			</div>
			<jsp:include page="../../common/Page.jsp" />
		</form>
		<!-- Contextual button for informational alert messages -->
		<table class="table table-bordered table-condensed table-hover" id="table">
			<tr>
			    <th width="30">
					<input type="checkbox" name="allcheck" id="selectAll" />
				</th>
			    <th nowrap="nowrap">序号</th>
			    <th>班级名称</th>
			    <th>班级编号</th>
			    <th>班主任名称</th>
			    <th>班主任工号</th>
			    <th>年级</th>
			    <th>专业</th>
			    <th>授课语种</th>
			    <th>培养层次</th>
			    <th>是否师范</th>
			    <th>学生人数</th>
			    <th>女生人数</th>
			    <th>男生人数</th>
			</tr>
			<c:forEach var="baseClass" items="${pager.data}" varStatus="status">
				<tr>
					<input type="hidden" name="Id" value="${baseClass.cid }" id="class.cid"  />
				  	<td width="30px" id="updId">
				        <input type="checkbox" name="checkbox" value="${baseClass.cid }" />
				    <td>${status.index + 1}</td>
				    <td>${baseClass.cclassName}</td>
				    <td>${baseClass.cclassCode}</td>
				    <td>${baseClass.currTeacher.tname}</td>
				    <td>${baseClass.currTeacher.bteacherId}</td>
				    <td>${baseClass.cgrade}</td>
				    <td>${baseClass.cmajor}</td>
				    <td>${baseClass.clanguage}</td>
				    <td>${baseClass.clevel}</td>
				    <td>
				    <c:if test="${baseClass.cisTeacher==true}">
				    	是
				    </c:if>
				     <c:if test="${baseClass.cisTeacher==false}">
				    	否
				    </c:if>
				    </td>
				    <td>${baseClass.cstudentNum}</td>
				    <td>${baseClass.cmaleNum}</td>
				    <td>${baseClass.cfemaleNum}</td>
				</tr>
			</c:forEach>
		</table>
		<div style="padding-left:80px;">
			<!-- Standard button -->
			<button type="button" class="btn btn-info" id="chaxun">查看班内详情</button>
			<button type="button" class="btn btn-info" id="tjbj">新增班级</button>
			<button type="button" class="btn btn-info" id="update">班内信息修改</button>
			<button type="button" class="btn btn-info" id="daoru">导入学生信息</button>
			<button type="button" class="btn btn-warning" id="del">删除班级</button>
			
		</div>
	</body>
</html>