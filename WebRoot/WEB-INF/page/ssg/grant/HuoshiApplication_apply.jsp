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
	    <title>贫困认定申请</title>    
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
	    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>

  		<script>    
  			$(function(){
  				$("#tjBtn").click(function(){//提交
  					$("#isSubmit").val(true);
  					$("#applyForm").submit();
				});
  				$("#zcBtn").click(function(){//暂存
  					$("#isSubmit").val(false);
  					$("#applyForm").submit();
				});
			})   
		</script>      
	</head>
	<body>
		<c:if test="${empty huoshiInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度临时伙食补贴指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty huoshiInfo }">
			<nav class="navbar navbar-default" role="navigation" style="background-color: rgb(241, 240, 240)">
				<label>贫困认定年度：${poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贫困认定名称：${huoshiInfo.pname}</label>
			</nav>
			<fieldset <c:if test="${paInfo.isSubmit eq true}">disabled="disabled"</c:if>>
			<form action="poorApplication/apply" method="post" id="applyForm" class="form-horizontal" enctype="multipart/form-data">
				<input type="hidden" name="paid" value="${paInfo.paid}" />
				<input type="hidden" name="sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="cclassId" value="${stu.cclass.cid}" />
				<input type="hidden" name="isSubmit" id="isSubmit" />
				<table class="table table-bordered table-condensed table-striped">
					<tr>
					    <th>学号</th>
					    <th>姓名</th>
					    <th>出生年月</th>
					    <th>性别</th>
					    <th>民族</th>
					    <th>政治面貌</th>
				    <tr>
					    <td>${stu.sstudentCode}</td>
					    <td>${stu.sname}</td>
					    <td>${stu.sbirthDate}</td>
					    <td>${stu.ssex}</td>
					    <td>${stu.snation}</td>
					    <td>${stu.spolitical}</td>
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
				    	<td>${stu.sidCard}</td>
					    <td>${stu.cclass.academyInfo.aname}</td>
					    <td>${stu.cclass.cgrade}</td>
					    <td>${stu.cclass.cclassName}</td>
					    <td>${stu.cclass.cmajor}</td>
					    <td><input type="text" name="pahaverageIncome" value="${paInfo.pahaverageIncome}" class="form-control"  placeholder="家庭年收入" /></td>
					</tr>
					<div class="form-group">
					<tr>
				    	<th colspan="3" >中国农业银行卡号</th>
				    	<th colspan="3" >贫困等级</th>
					</tr>
					<tr>
					    <td colspan="3"><input type="text" name="pacard" value="${paInfo.pacard}" class="form-control"  placeholder="中国农业银行卡号" /></td>
					    <td colspan="3">
					    	<select name="pgrade" class="form-control">
					    		<option value="1" <c:if test="${paInfo.pgrade eq '1'}">selected="selected"</c:if>>特别困难</option>
					    		<option value="2" <c:if test="${paInfo.pgrade eq '2'}">selected="selected"</c:if>>困难</option>
					    		<option value="3" <c:if test="${paInfo.pgrade eq '3'}">selected="selected"</c:if>>一般困难</option>
					    	</select>	
					    </td>
					</tr>
					<tr>
				    	<th colspan="6">学生申请陈述认定风理由</th>
					</tr>
					<tr>
					    <td colspan="6" rowspan="5"><textarea class="form-control" name="pareason" rows="5">${paInfo.pareason}</textarea></td>
					</tr>
					</div>
				</table>
				<div class="form-group">
					上传学生及家庭情况调查表图片文件：
					<input type="file" name="pahomeInvestigation" id="pahomeInvestigation" />
					<c:if test="${not empty paInfo.pahomeInvestigation}"><a href="<%=basePath%>pahomeInvestigation/${paInfo.pahomeInvestigation}">下载原家庭调查表图片文件</a></c:if>
				</div>
				<div class="form-group">
				    家庭困难佐证上传：
				    <input type="file" id="paevidence" name="paevidence" />
				    <c:if test="${not empty paInfo.paevidence}"><a href="<%=basePath%>pahomeInvestigation/${paInfo.paevidence}">下载原家庭困难佐证文件</a></c:if>
		  		</div>
				<div align="center">
					<button type="button" class="btn btn-info" id="zcBtn">暂存</button>
					<button type="button" class="btn btn-info" id="tjBtn">提交</button>
				</div>
			</form>
			</fieldset>
		</c:if>
	</body>
</html>
