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
<title>历年贫困认定归档资料汇总</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript">
	function ajaxGetClass(){
		initAjaxXmlHttpRequest();
		var src = "<%=basePath%>poorHistory/ajaxGetClass?academyCode="+$("#academyCode").val()+"&syid="+$("#syid").val();
		xmlhttp.open("POST", src, false);
		xmlhttp.onreadystatechange = function() {
			var obj = document.getElementById("classId");
			obj.options.length = 0;
			var message = xmlhttp.responseText;
			obj.options.add(new Option("——全部——",""));
			if (message != "") {
				var classes = message.split(",");
				for (var i = 0; i < classes.length; i += 2) {
					if (classes[i] != "") {
						obj.options.add(new Option(classes[i], classes[i + 1]));
					}
				}
			}
			$(".multiSelect").select2();
		};
		xmlhttp.send();
	}

	$(function() {
		$("#_exprot").click(function() {
	        $("#exportForm").submit();
		});
	})
</script>
</head>

<body>
	<legend>历年贫困认定归档资料</legend>
	<form action="poorHistory/list" method="post" class="form-inline" id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">学年</label>
				<select id="syid" name="syid" class="form-control">
					<c:forEach var="sy" items="${syList}">
						<option value="${sy.syid}" <c:if test="${sy.syid eq bean.syid }">selected="selected"</c:if>>${sy.syname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学院</label>
				<select id="academyCode" name="academyCode" onchange="ajaxGetClass();" class="multiSelect ">
					<c:if test="${teacher.isSchoolTeacher == true}">
						<option value="">——全部——</option>
					</c:if>
					<c:forEach var="acade" items="${acadeList}">
						<option value="${acade.aacademyCode}" <c:if test="${acade.aacademyCode eq bean.academyCode }">selected="selected"</c:if>>${acade.aname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">班级</label>
				<select id="classId" name="classId" class="multiSelect">
					<option value="">——全部——</option>
					<c:forEach var="classList" items="${classList}">
						<option value="${classList.cid}" <c:if test="${classList.cid eq bean.classId}">selected="selected"</c:if>>${classList.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学号</label>
				<input type="text" name="studentCode" value="${bean.studentCode }" class="form-control" />
			</div>
			<div class="form-group">
				<label for="">姓名</label>
				<input type="text" name="studentName" value="${bean.studentName }" class="form-control" />
			</div>
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-primary" id="_exprot" value="信息导出" />
		</div>
		<jsp:include page="../../common/Page.jsp" />
	</form>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
			<th>序号</th>
			<th>院系</th>
			<th>专业</th>
			<th>年级</th>
			<th>班级名称</th>
			<th>学号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>贫困认定等级</th>
		</tr>
		<c:forEach var="ph" items="${pager.data}" varStatus="vs">
			<tr>
				<td>${vs.index+1 }</td>
				<td>${ph.bclass.academyInfo.aname}</td>
				<td>${ph.bclass.cmajor}</td>
				<td>${ph.bclass.cgrade}</td>
				<td>${ph.bclass.cclassName}</td>
				<td>${ph.student.sstudentCode}</td>
				<td>${ph.student.sname}</td>
				<td>${ph.student.ssex}</td>
				<td>
					<c:if test="${ph.pgrade eq '1' }">特殊困难</c:if>
					<c:if test="${ph.pgrade eq '2' }">困难</c:if>
					<c:if test="${ph.pgrade eq '3' }">一般困难</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<form action="poorHistory/exportExcel" method="post" id="exportForm">
		<input type="hidden" name="academyCode" value="${bean.academyCode}">
		<input type="hidden" name="classId" value="${bean.classId}">
		<input type="hidden" name="syid" value="${bean.syid}">
		<input type="hidden" name="studentCode" value="${bean.studentCode}">
		<input type="hidden" name="studentName" value="${bean.studentName}">
	</form>
</body>
<script language="javascript">
	$(document).ready(function() {
		$(".multiSelect").select2();
	});
</script>
</html>