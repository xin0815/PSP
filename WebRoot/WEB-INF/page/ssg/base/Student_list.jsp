<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
	<html>
		<head>
		<base href="<%=basePath%>">
	    <title>学生基本信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
		<script language="javascript">
			function ajaxQueryClass(){
	 			var acae = $("#aacademyCode").val();
	 			initAjaxXmlHttpRequest();
	 			var src = "<%=basePath%>student/ajaxQueryClass?acae="+acae;
				xmlhttp.open("POST", src, false);
				xmlhttp.onreadystatechange = function() {
					var obj = document.getElementById("classId");
					obj.options.length = 0;
					var message = xmlhttp.responseText;
					if (message != "") {
						var classes = message.split(",");
						for (var i = 0; i < classes.length; i += 2) {
							if (classes[i] != "") {
								obj.options.add(new Option(classes[i], classes[i + 1]));
							}
						}
						$("#classId").select2();
					}
				};
				xmlhttp.send();
			}
			$(function(){
				$("#detail").click(function(){
					var size =  $("input[name='_radio']:checked").size();
					if(size != 1){
						swal("错误提示", "请选择且只选一条记录", "error");
		                return;
					}
					$("#detailId").val($("input[name='_radio']:checked").val());
					$("#detailForm").submit();
				});
				$("#_exprot").click(function() {
					$("#exportForm").submit();
				});			
				$("#_exprotAll").click(function(){
					$("#exprotAllForm").submit();
				});
				 $("#resetPass").click(function(){
					var size =  $("input[name='_radio']:checked").size();
					if(size != 1){
						swal("错误提示", "请选择且只选一条记录", "error");
		                return;
					}
					swal({title: "温馨提示",text: "密码将重置为默认密码，您确定重置吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#resetPassId").val($("input[name='_radio']:checked").val());
						$("#resetPassForm").submit();
					});
		        });
			})
			
		</script>
	</head>
	<body>
		<legend>
			学生基本信息
		</legend>
	  	<form action="student/list" method="post" class="form-inline">
			<div class="well form-search">
				<div class="form-group">
	    			<label for="aacademyCode">学院：</label>
	    			<select class="form-control" name="aacademyCode" id="aacademyCode" onchange="ajaxQueryClass()">
	            		<c:if test="${bt.isSchoolTeacher eq true}">
	            			<option value="">
	            			全部
	            		</option>
	            			<c:forEach var="acc" items="${academyList}">
	            				<option value="${acc.aacademyCode}" <c:if test="${queryBean.aacademyCode eq acc.aacademyCode}">selected="selected"</c:if>>${acc.aname}</option>
	            			</c:forEach>
	            		</c:if>
	            		<c:if test="${bt.isAcademyTeacher eq true or bt.isClassTeacher eq true}">
	            			<option value="${bt.aacademy.aacademyCode}">${bt.aacademy.aname}</option>
	            		</c:if>
	            	</select>
	 			</div>
	 			<c:if test="${bt.isSchoolTeacher eq true or bt.isAcademyTeacher eq true}">
				<div class="form-group">
	    			<label for="cgrade">年级：</label>
	           		<input type="text" name="cgrade" id="cgrade" value="${queryBean.cgrade }" class="form-control"  >
	 			</div>
	 			</c:if>
				<div class="form-group">
					<label for="cid">班级：</label>
					<select class="form-control" name="classId" id="classId">
						<c:if test="${bt.isSchoolTeacher eq true or bt.isAcademyTeacher eq true}">
	           			<option value="">
	           			全部
	           			</option>
	           			</c:if>
	           			<c:forEach var="cl" items="${classList}">
	           				<option value="${cl.cid}" <c:if test="${queryBean.classId eq cl.cid}">selected="selected"</c:if>>${cl.cclassName}(${cl.cclassCode})</option>
	           			</c:forEach>
	            	</select>
				</div>
				<div class="form-group">
					<label for="nationId">民族：</label>
					<select class="form-control" name="nationId" id="nationId">
	           			<option value="">
	           			全部
	           			</option>
	           			<c:forEach var="nation" items="${nationList}">
	           				<option value="${nation.nid}" <c:if test="${nation.nid eq queryBean.nationId}">selected="selected"</c:if>>${nation.name}</option>
	           			</c:forEach>
	            	</select>
				</div>
				<div class="form-group">
	    			<label for="studentCode">学号：</label>
	           		<input type="text" name="studentCode" id="studentCode" value="${queryBean.studentCode }" class="form-control"  >
	 			</div>
				<div class="form-group">
	    			<label for="studentName">姓名：</label>
	           		<input type="text" name="studentName" id="studentName" value="${queryBean.studentName }" class="form-control"  >
	 			</div>
				<button type="submit" class="btn btn-primary">查询</button>
				<input type="button" class="btn btn-primary" id="_exprot" value="导出Excel" />
				<input type="button" class="btn btn-primary" id="_exprotAll" value="导出全部学生信息" />
			</div>
			<jsp:include page="../../common/Page.jsp" />
		</form>
		<table class="table table-bordered table-hover">
			<tr>
				<th class="text-center"></th>
	 			<th>序号</th>
	   			<th>学号</th>
	   			<th>姓名</th>
	   			<th>学院</th>
	   			<th>专业</th>
	   			<th>年级</th>
	   			<th>出生年月</th>
	   			<th>性别</th>
	   			<th>民族</th>
	   			<th>政治面貌</th>
	   			<th>宿舍号</th>
	   			<th>本人联系方式</th>
	 		</tr>
			<c:forEach var="stu" items="${pager.data}" varStatus="st">
				<tr>
					<td class="text-center"><input type="radio" name="_radio" value="${stu.sstudentCode}"></td>
					 <td>${st.index + 1}</td>
					 <td>${stu.sstudentCode}</td>
					 <td>${stu.sname} </td>
					 <td>${stu.cclass.academyInfo.aname}</td>
					 <td>${stu.cclass.cmajor}</td>
					 <td>${stu.cclass.cgrade }</td>
					 <td>${stu.sbirthDate}</td>
					 <td>${stu.ssex} </td>
					 <td>${stu.snation.name}</td>
					 <td>${stu.spolitical}</td>
					 <td>${stu.sdormNum} </td>
					 <td>${stu.sphoneNum}</td>
				</tr>
	 		</c:forEach>
		</table>
		<center>
			<button type="button" class="btn btn-primary" id="detail">查看详情</button>
			<button type="button" class="btn btn-danger" id="resetPass">
					重置密码
			</button>
		</center>
		<form action="student/info" method="post" id="detailForm">
			<input type="hidden" name="stuCode" id="detailId"/>
		</form>
		<form action="student/exportExcel" method="post" id="exportForm">
			<input type="hidden" name="aacademyCode" value="${queryBean.aacademyCode}">
			<input type="hidden" name="cgrade" value="${queryBean.cgrade}">
			<input type="hidden" name="classId" value="${queryBean.classId}">
			<input type="hidden" name="nationId" value="${queryBean.nationId}">
			<input type="hidden" name="studentCode" value="${queryBean.studentCode}">
			<input type="hidden" name="studentName" value="${queryBean.studentName}">
		</form>
		<form action="student/resetPass" method="post" id="resetPassForm">
			<input type="hidden" value="" id="resetPassId" name="studentCode" />
		</form>
		<form action="student/exportAll" method = "post" id = "exprotAllForm">
		</form>
	</body>
	<script language="javascript">
	$("#aacademyCode").select2();
	$("#cid").select2();
	</script>
</html>
