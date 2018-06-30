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
<title>审核状态</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/vendor/jquery-2.1.0.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
<script type="text/javascript">
$(function() {
$("#_goback").click(function(){
   window.location.href="<%=basePath%>qucheck/list";
});
})
</script>
</head>

<body>
	<input type="button" class="btn btn-info" id="_goback" value="<<返回">
	<table class="table table-striped table-bordered table-condensed">
	<tr>
	<th>序号</th>
	<th>学院</th>
	<th>状态</th>
	</tr>
	<tr >
	<th colspan="3" >审核已通过学院 </th>
	</tr>
	<c:if test="${acadeCheckList}==null" >
	
	</c:if>
	<c:forEach var="qt" items="${acadeCheckList}" varStatus="vs">
	<tr>
	<td>${vs.index+1 } </td>
	<td style="color: red">${qt.aname }</td>
	<td>审核通过</td>
	</tr>
	</c:forEach>
	<tr >
	<th colspan="3" >未审核学院 </th>
	</tr>
	</tr>
	<c:forEach var="qt" items="${acadeUnCheckList}" varStatus="vs">
	
	<tr>
	<td>${vs.index+1 }</td>
	<td>${qt.aname }</td>
	<td>未审核</td>
	</tr>
	</c:forEach>
	<tr >
	<th colspan="3" >审核未通过学院 </th>
	</tr>
	<c:forEach var="qt" items="${acadeUnPassList}" varStatus="vs">
	<tr>
	<td>${vs.index+1 }</td>
	<td>${qt.aname }</td>
	<td>审核未通过</td>
	</tr>
	</c:forEach>
	<tr >
	<th colspan="3" >素质评价未提交学院 </th>
	</tr>
	<c:forEach var="qt" items="${acadeUnSubmitList}" varStatus="vs">
	<tr>
	<td>${vs.index+1 }</td>
	<td>${qt.aname }</td>
	<td>未提交</td>
	</tr>
	</c:forEach>
	</table>
</body>
<script language="javascript">
	$(document).ready(function() {
		$("#aacademyCode").select2();
	});
</script>
</html>