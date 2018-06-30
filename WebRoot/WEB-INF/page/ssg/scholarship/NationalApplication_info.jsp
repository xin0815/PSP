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
	    <title>国家奖学金申请信息查看</title>    
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
		<legend>
			国家奖学金申请详情
		</legend>
		<div class="well form-search">
			<h6>学年：<u>${naInfo.nationalInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国家奖学金名称：<u>${naInfo.nationalInfo.name}</u></h6>
		</div>
		<table class="table table-bordered table-condensed table-striped">
			<tr>
				<th rowspan="4">
					基本情况
				</th>
			    <th>姓名</th>
			    <td>${naInfo.student.sname}</td>
			    <th>性别</th>
			    <td>${naInfo.student.ssex}</td>
			    <th>出生年月</th>
			    <td>${naInfo.student.sbirthDate}</td>
			</tr>
			<tr>
				<th>政治面貌</th>
			    <td>${naInfo.student.spolitical}</td>
			    <th>民族</th>
			    <td>${naInfo.student.snation.name}</td>
			    <th>年级</th>
			    <td>${naInfo.student.cclass.cgrade}</td>
			</tr>
			<tr>
				<th>专业</th>
				<td>${naInfo.student.cclass.cmajor}</td>
				<th>联系电话</th>
				<td>${naInfo.student.sphoneNum}</td>
			    <th>班级</th>
			    <td>${naInfo.student.cclass.cclassName}</td>
		    </tr>
		    <tr>
		    	<th>身份证号码</th>
				<td>${naInfo.student.sidCard}</td>
		    </tr>
			<tr>
		    	<th rowspan="5">申请理由</th>
			</tr>
			<tr>
			    <td colspan="6"><textarea class="form-control" id="nareason" name="nareason" rows="5" maxlength="256" readonly="readonly">${naInfo.nareason}</textarea></td>
			</tr>
		</table>
		<div align="center">
			<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">返回</button>
		</div>
	</body>
</html>
