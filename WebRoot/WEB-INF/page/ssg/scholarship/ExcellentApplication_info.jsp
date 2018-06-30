<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <base href="<%=basePath%>">    
	    <title>三优奖学金申请</title>    
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	</head>
	<body>
		<div class="well form-search">
			<label>年度：${excellentApplication.excellentInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名称：${excellentApplication.excellentInfo.ename}</label>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
			    <th>学号</th>
			    <th>姓名</th>
			    <th>学院</th>
			    <th>年级</th>
			    <th>班级</th>
			    <th>奖金类别</th>
		    <tr>
			    <td>${excellentApplication.student.sstudentCode}</td>
			    <td>${excellentApplication.student.sname}</td>
				<td>${excellentApplication.bclass.academyInfo.aname}</td>
			    <td>${excellentApplication.bclass.cgrade}</td>
			    <td>${excellentApplication.bclass.cclassName}</td>
			    <td>
					<c:if test="${excellentApplication.etype eq 1}">三好学生</c:if>
					<c:if test="${excellentApplication.etype eq 2}">优秀班干部</c:if>
					<c:if test="${excellentApplication.etype eq 3}">优秀毕业生</c:if>
				</td>
			</tr>
			<tr>
		    	<th colspan="7">个人总结</th>
			</tr>
			<tr>
			    <td colspan="7" rowspan="5">${excellentApplication.personalSummary}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-primary" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
