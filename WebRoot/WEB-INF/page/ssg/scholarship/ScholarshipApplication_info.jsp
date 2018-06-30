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
	    <title>校内奖学金申请</title>    
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
			<label>校内奖学金年度：${scholarshipApplication.scholarshipInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;校内奖学金名称：${scholarshipApplication.scholarshipInfo.sname}</label>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
			    <th>学号</th>
			    <th>姓名</th>
			    <th>学院</th>
			    <th>年级</th>
			    <th>班级</th>
			    <th>学生申请等级</th>
			    <th>学生申请单项奖类型</th>
		    <tr>
			    <td>${scholarshipApplication.student.sstudentCode}</td>
			    <td>${scholarshipApplication.student.sname}</td>
				<td>${scholarshipApplication.bclass.academyInfo.aname}</td>
			    <td>${scholarshipApplication.bclass.cgrade}</td>
			    <td>${scholarshipApplication.bclass.cclassName}</td>
			    <td>
					<c:if test="${scholarshipApplication.saslevel eq 1}">一等</c:if>
					<c:if test="${scholarshipApplication.saslevel eq 2}">二等</c:if>
					<c:if test="${scholarshipApplication.saslevel eq 3}">三等</c:if>
					<c:if test="${scholarshipApplication.saslevel eq 4}">单项奖</c:if>
					<c:if test="${scholarshipApplication.saslevel eq 5}">优秀学生干部奖</c:if>
				</td>
				<td>
					<c:if test="${scholarshipApplication.sassingleLevel eq 1}">道德风尚奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 2}">科技创新奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 3}">民族团结奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 4}">社会公益活动奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 5}">鼓励进步奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 6}">学习优秀奖</c:if>
					<c:if test="${scholarshipApplication.sassingleLevel eq 7}">文体技能奖</c:if>
			    </td>
			</tr>
			<tr>
		    	<th colspan="7">曾获何种奖励</th>
			</tr>
			<tr>
			    <td colspan="7" rowspan="5">${scholarshipApplication.saoldReward}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-primary" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
