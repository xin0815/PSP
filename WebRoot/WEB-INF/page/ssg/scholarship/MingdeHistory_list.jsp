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
<title>历年明德奖学金归档资料汇总</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript">
	$(function() {
		$("#_exprot").click(function() {
	        $("#exportForm").submit();
		});
	})
</script>
</head>

<body>
	<legend>历年明德奖学金归档资料</legend>
	<form action="mingdeHistory/list" method="post" class="form-inline" id="staffForm">
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
				<select id="academyCode" name="academyCode" class="multiSelect ">
					<c:if test="${teacher.isSchoolTeacher == true}">
						<option value="">——全部——</option>
					</c:if>
					<c:forEach var="acade" items="${acadeList}">
						<option value="${acade.aacademyCode}" <c:if test="${acade.aacademyCode eq bean.academyCode }">selected="selected"</c:if>>${acade.aname}</option>
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
			<th width="30"></th>
			<th>
				序号
			</th>
			<th>
				姓名
			</th>
			<th>
				院系
			</th>
			<th>
				专业
			</th>
			<th>
				学号
			</th>
			<th>
				性别
			</th>
			<th>
				民族
			</th>
			<th>
				年级
			</th>
			<th>
				生源地
			</th>
			<th>
				手机号码
			</th>
		</tr>
		<c:forEach var="ma" items="${pager.data}" varStatus="st">
			<tr>
				<td width="30px">
					<input type="radio" " name="_radio" value="${ma.maid}" />
				</td>
				<td>
					${st.index + 1}
				</td>
				<td>
					${ma.student.sname}
				</td>
				<td>
					${ma.student.cclass.academyInfo.aname}
				</td>
				<td>
					${ma.student.cclass.cmajor}
				</td>
				<td>
					${ma.student.sstudentCode}
				</td>
				<td>
					${ma.student.ssex}
				</td>
				<td>
					${ma.student.snation.name}
				</td>
				<td>
					${ma.student.cclass.cgrade}
				</td>
				<td>
					${ma.student.soriginHome}
				</td>
				<td>
					${ma.student.sphoneNum}
				</td>
			</tr>
		</c:forEach>
	</table>
	<form action="mingdeHistory/exportExcel" method="post" id="exportForm">
		<input type="hidden" name="academyCode" value="${bean.academyCode}">
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