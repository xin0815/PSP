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
	    <title>国家助学金查看详细</title>    
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
			国家助学金申请信息查看
		</legend>
		<div class="well form-search">
			<label>国家助学金年度：${grantApplication.grantInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国家助学金名称：${grantApplication.grantInfo.name}</label>
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
			    <td>${grantApplication.student.sstudentCode}</td>
			    <td>${grantApplication.student.sname}</td>
				<td>${grantApplication.student.cclass.academyInfo.aname}</td>
			    <td>${grantApplication.student.cclass.cgrade}</td>
			    <td>${grantApplication.student.cclass.cclassName}</td>
			    <td>
			    	${paInfo.pgrade }
			    </td>
			</tr>
			<tr>
		    	<th>选择家庭户口</th>
		    	<th>家庭人口总数</th>
		    	<th>家庭月总收入</th>
		    	<th>人均月收入</th>
		    	<th>收入来源</th>
		    	<th>申请等级</th>
			</tr>
			<tr>
				<td>
					<c:if test="${grantApplication.gahomeResidence eq '1' }">城镇</c:if>
					<c:if test="${grantApplication.gahomeResidence eq '2' }">农业</c:if>
				</td>
				<td>${grantApplication.gahomePopulationTotal}</td>
				<td>${grantApplication.gahomeIncomePmtotal}</td>
				<td>${grantApplication.gahomeIncomePmpp}</td>
				<td>${grantApplication.gahomeIncomeSource}</td>
			    <td>
		    		<c:if test="${grantApplication.gasgrade eq '1'}">一等助学金</c:if>
		    		<c:if test="${grantApplication.gasgrade eq '2'}">二等助学金</c:if>
		    		<c:if test="${grantApplication.gasgrade eq '3'}">三等助学金</c:if>
				</td>
			</tr>
			<tr>
		    	<th colspan="6">申请理由</th>
			</tr>
			<tr>
			    <td colspan="6" rowspan="5">${grantApplication.gareason}</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-info" id="zcBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
