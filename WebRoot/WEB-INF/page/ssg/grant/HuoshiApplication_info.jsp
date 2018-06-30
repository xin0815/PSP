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
	    <title>班主任认定查看情况</title>    
		<base href="<%=basePath%>">
	    <title>学生基本信息</title>
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
		<nav class="navbar navbar-default" role="navigation" style="background-color: rgb(241, 240, 240)">
			<label>贫困认定年度：${poolApplication.poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贫困认定名称：${poolApplication.poorInfo.pname}</label>
		</nav>
			<table class="table table-bordered table-condensed table-striped">
				<tr>
				    <th>学号</th>
				    <th>姓名</th>
				    <th>出生年月</th>
				    <th>性别</th>
				    <th>民族</th>
				    <th>政治面貌</th>
			    <tr>
				    <td>${poolApplication.student.sstudentCode}</td>
				    <td>${poolApplication.student.sname}</td>
				    <td>${poolApplication.student.sbirthDate}</td>
				    <td>${poolApplication.student.ssex}</td>
				    <td>${poolApplication.student.snation}</td>
				    <td>${poolApplication.student.spolitical}</td>
				</tr>
				<tr>
					<th>身份证号码</th>
				    <th>学院</th>
				    <th>年级</th>
				    <th>班级</th>
				    <th>专业</th>
				    <th>家庭年总收入</th>
			    </tr>
			    <tr>
			    	<td>${poolApplication.student.sidCard}</td>
				    <td>${poolApplication.student.cclass.academyInfo.aname}</td>
				    <td>${poolApplication.student.cclass.cgrade}</td>
				    <td>${poolApplication.student.cclass.cclassName}</td>
				    <td>${poolApplication.student.cclass.cmajor}</td>
				    <td>${poolApplication.pahaverageIncome}</td>
				</tr>
				<div class="form-group">
				<tr>
			    	<th colspan="3" >中国农业银行卡号</th>
			    	<th colspan="3" >贫困等级</th>
				</tr>
				<tr>
				    <td colspan="3">${poolApplication.pacard}</td>
				    <td colspan="3">
				    	<c:if test="${poolApplication.pgrade eq '1'}">特别困难</c:if>
				    	<c:if test="${poolApplication.pgrade eq '2'}">困难</c:if>
				    	<c:if test="${poolApplication.pgrade eq '3'}">一般困难</c:if>
				    </td>
				</tr>
				<tr>
			    	<th colspan="6">学生申请陈述认定风理由</th>
				</tr>
				<tr>
				    <td colspan="6" rowspan="5">${poolApplication.pareason}</td>
				</tr>
				</div>
			</table>
			<div class="form-group">
				上传学生及家庭情况调查表图片文件：
				<c:if test="${not empty poolApplication.pahomeInvestigation}"><a href="<%=basePath%>pahomeInvestigation/${poolApplication.pahomeInvestigation}">下载原家庭调查表图片文件</a></c:if>
			</div>
			<div class="form-group">
			    家庭困难佐证上传：
			    <c:if test="${not empty poolApplication.paevidence}"><a href="<%=basePath%>pahomeInvestigation/${poolApplication.paevidence}">下载原家庭困难佐证文件</a></c:if>
	  		</div>
			<div align="center">
				<button type="button" class="btn btn-info" id="zcBtn" onclick="history.back();">返回</button>
			</div>
		</form>
		</fieldset>
	</body>
</html>
