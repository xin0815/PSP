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
	    <title>励志奖学金申请</title>    
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
		<legend>
			励志奖学金申请信息查看
		</legend>
		<div class="well form-search">
			<label>励志奖学金年度：${lizhiApplication.lizhiInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;励志奖学金名称：${lizhiApplication.lizhiInfo.name}</label>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
			    <th>学号</th>
			    <th>姓名</th>
			    <th>学院</th>
			    <th>年级</th>
			    <th>班级</th>
			    <th>贫困认定等级</th>
		    <tr>
			    <td>${lizhiApplication.student.sstudentCode}</td>
			    <td>${lizhiApplication.student.sname}</td>
				<td>${lizhiApplication.student.cclass.academyInfo.aname}</td>
			    <td>${lizhiApplication.student.cclass.cgrade}</td>
			    <td>${lizhiApplication.student.cclass.cclassName}</td>
			    <td>
			    	${paInfo.pgrade }
			    </td>
			</tr>
			<tr>
		    	<th>选择家庭户口</th>
		    	<th>家庭人口总数</th>
		    	<th>家庭月总收入</th>
		    	<th>人均月收入</th>
		    	<th colspan="2">收入来源</th>
			</tr>
			<tr>
				<td>
					<c:if test="${lizhiApplication.lahomeResidence eq '1' }">城镇</c:if>
					<c:if test="${lizhiApplication.lahomeResidence eq '2' }">农业</c:if>
				</td>
				<td>${lizhiApplication.lahomePopulationTotal}</td>
				<td>${lizhiApplication.lahomeIncomePmtotal}</td>
				<td>${lizhiApplication.lahomeIncomePmpp}</td>
				<td colspan="2">${lizhiApplication.lahomeIncomeSource}</td>
			</tr>
			<tr>
		    	<th colspan="3">曾获何种奖励</th>
		    	<th colspan="3">申请理由</th>
			</tr>
			<tr>
			    <td colspan="3" rowspan="5">${lizhiApplication.laoldReward}</td>
			    <td colspan="6" rowspan="5">${lizhiApplication.lareason}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-info" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
