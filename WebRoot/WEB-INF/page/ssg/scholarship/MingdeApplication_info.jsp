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
	    <title>明德奖学金查看详细</title>    
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
	    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
	</head>
	<body>
		<div class="well form-search">
			<label>明德奖学金学金年度：${mingdeApplication.mingdeInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明德奖学金名称：${mingdeApplication.mingdeInfo.name}</label>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
			    <th>学号</th>
			    <th>姓名</th>
			    <th>学院</th>
			    <th>年级</th>
			    <th>班级</th>
		    <tr>
			    <td>${mingdeApplication.student.sstudentCode}</td>
			    <td>${mingdeApplication.student.sname}</td>
				<td>${mingdeApplication.student.cclass.academyInfo.aname}</td>
			    <td>${mingdeApplication.student.cclass.cgrade}</td>
			    <td>${mingdeApplication.student.cclass.cclassName}</td>
			</tr>
			<tr>
		    	<th colspan="6">申请理由</th>
			</tr>
			<tr>
			    <td colspan="6" rowspan="5">${mingdeApplication.mareason}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-info" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
