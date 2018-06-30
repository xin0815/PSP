<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html>
  <head> 
    <title>学工管理</title>
    <base href="<%=basePath%>" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
    

<script language="javascript">
$(function(){
	$("#tj").click(function(){
    	window.location.href="<%=basePath%>leader/toAdd";
	});
	//删除
    $("#del").click(function(){
		var checks = $("input[name='checkbox']:checked");
		if(checks.size() == 0) {
			swal("错误提示", "请至少选择一条记录", "error");
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
 		
 		$("#resetPass").click(function(){//重置密码
     	   var size =  $("input[name='checkbox']:checked").size();
     	   if(size != 1)
         	   {
     		   	   swal("错误提示", "请选择且只选一个修改", "error");
                    return;
         	   }
            $("#resetPassId").val($("input[name='checkbox']:checked").val());
            $("#resetPassForm").submit();
         });
        
        $("#_export").click(function(){
   		$("#_aacademyCode").val($("#aacademyCode").val());
        $("#exportForm").submit();
        });
})
$(document).ready(function() { 
		$("#aacademyCode").select2();
	});
</script>
  </head>
  <body>
  <legend>班主任管理</legend>
  <form action="teacher/list" method="post" class="form-inline">
  	<div class="well form-search">
  		<div class="form-group">
  			<label for="">所在学院</label>
  			<td>
  				<select class="form-control" name="aacademyCode" id="aacademyCode">
            		<c:if test="${teacher.isSchoolTeacher eq true}">
            			<option value="">
            			全部
            		</option>
            			<c:forEach var="acc" items="${aacademyList}">
            				<option value="${acc.aacademyCode}" <c:if test="${aacademyCode eq acc.aacademyCode}">selected="selected"</c:if>>${acc.aname}</option>
            			</c:forEach>
            		</c:if>
            		<c:if test="${teacher.isAcademyTeacher eq true}">
            			<option value="${aacade.aacademyCode}">${aacade.aname}</option>
            		</c:if>
            	</select>
			</td>
  		</div>
  			<button type="submit" class="btn btn-primary">查询</button>
			<button type="button" class="btn btn-info" id="tj">新增</button>
			<button type="button" class="btn btn-info" id="update">修改</button>
			<button type="button" class="btn btn-warning" id="del">删除</button>
			<input type="button" class="btn btn-info" id="_export" value="信息导出" />
			<button type="button" class="btn btn-danger" id="resetPass">重置密码</button>
  	</div>
	<center>
			<table  class="table table-bordered table-hover table-condensed">
				<tr>
					<th width="50">
					</th>
					<th>
							序号
					</th>
					<th >
							姓名
					</th>
					<th>
							教工号
					</th>
					<th >
							行政职务
					</th>
					<th >
							职称
					</th>
					<th >
							出生年月
					</th>
					<th >
							所在处学院
					</th>
					<!-- <td >
							所在科室
					</td> -->
					<th >
							联系电话
					</th>
				</tr>	
					<c:forEach var="t" items="${teacherList}" varStatus="st">
								<tr>
									<td width="30px">
										<input type="checkbox"  name="checkbox" value="${t.tid}" />
									</td>
									<td>
										${st.index + 1}
									</td>
									<td>
										${t.tname}
									</td>
									<td >
										${t.bteacherId} 
									</td>
									<td >
										${t.tduty} 
									</td>
									<td> 
										${t.tproTitle}  
									</td>
									<td >
										${t.tbirthDay}
									</td>
									<td>
										${t.aacademy.aname}
									</td>
									<!--<td>
									</td>-->
									<td >
										${t.tphone}
									</td>
								</tr>
							</c:forEach>
				</table>
	</center>
	</form>
	<form action="leader/delete" method="post" id="delForm">
		<input type="hidden" value="" id="delId" name="ids" /> 
	</form>
	<form action="leader/toUpdate" method="post" id="updateForm">
		<input type="hidden" value="" id="updId" name="updId" />
	</form>
	<form action="teacher/exportExcel" method="post" id="exportForm">
		<input type="hidden" name="aacademyCode" id="_aacademyCode" />
	</form>
	<form action="leader/resetPass" method="post" id="resetPassForm">
			<input type="hidden" value="" id="resetPassId" name="tid" />
			<input type="hidden" value="${aacademyCode}" name="aacademyCode" />
		</form>
  </body>
</html>
