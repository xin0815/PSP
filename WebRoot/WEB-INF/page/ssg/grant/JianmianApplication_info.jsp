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
	    <title>减免学费申请</title>    
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	</head>
	<body>
		<div class="well form-search">
			<label>减免学费年度：${jianmianApplication.jianmianInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减免学费名称：${jianmianApplication.jianmianInfo.name}</label>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
			    <th>学号</th>
			    <th>姓名</th>
			    <th>学院</th>
			    <th>年级</th>
			    <th>班级</th>
			    <th>学生申请等级</th>
		    <tr>
			    <td>${jianmianApplication.student.sstudentCode}</td>
			    <td>${jianmianApplication.student.sname}</td>
				<td>${jianmianApplication.bclass.academyInfo.aname}</td>
			    <td>${jianmianApplication.bclass.cgrade}</td>
			    <td>${jianmianApplication.bclass.cclassName}</td>
			    <td>
					<c:if test="${jianmianApplication.jasgrade eq 1}">一等</c:if>
					<c:if test="${jianmianApplication.jasgrade eq 2}">二等</c:if>
					<c:if test="${jianmianApplication.jasgrade eq 3}">三等</c:if>
				</td>
			</tr>
			<tr>
		    	<th colspan="7">申请理由</th>
			</tr>
			<tr>
			    <td colspan="7" rowspan="5">${jianmianApplication.jareason}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-primary" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
