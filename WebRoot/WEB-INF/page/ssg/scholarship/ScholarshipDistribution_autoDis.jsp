<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
    <title>校内奖学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#sname").val() == ""){
					swal("错误提示", "校内奖学金名称不能为空", "error");
					return false;
				}
    			$("#zdfpForm").submit();
    		});
			$("#update").click(function(){
				$("#_fieldset").attr("disabled",false);
				$("#zc").attr("disabled",false);
    		}); 
    		$("#zc").click(function(){
    			if(checkInputText()){
    				$("#zcForm").submit();
    			}
    		});   
    		$("#fabu").click(function(){
    			$("#fbForm").submit();
    		});    
    		$("#_export").click(function(){
       			$("#exportForm").submit();
    		});
		});
	</script>
</head>
<body>
	<legend>
		校内奖学金指标分配	
	</legend>
	<form action="scholarshipDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="sid" id="sid" value="${scholarshipInfo.sid}"/>
		<input type="hidden" name="schoolYear.syid" value="${scholarshipInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				<label>校内奖学金年度:</label>
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${scholarshipInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				<label>校内奖学金名称:</label>
				<input type="text" id="sname" name="sname" class="form-control" readonly="readonly" value="${scholarshipInfo.sname}" />
			</div>
			<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
			<button type="button" class="btn btn-primary" <c:if test="${empty scholarshipInfo.sid}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty scholarshipInfo.sid or scholarshipInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-primary" id="_export" <c:if test="${empty scholarshipInfo.sid}">disabled="disabled"</c:if> value="信息导出" />
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>校内一等</th>
  			<th>校内二等</th>
  			<th>校内三等</th>
  			<th>单项</th>
  		</tr>
  		<form action="scholarshipDistribution/update" method="post" id="zcForm">
  		<c:forEach var="sd" items="${ssList}" varStatus="st">
  			<input type="hidden" name="sdid" class="form-control" value="${sd.sdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${sd.academy.aname}</td>
		  		 <td>${sd.acaStudentNum}</td>
		  		 <td><input type="text" name="sdleve1" class="form-control" value="${sd.sdleve1}" /></td>
		  		 <td><input type="text" name="sdleve2" class="form-control" value="${sd.sdleve2}" /></td>
		  		 <td><input type="text" name="sdleve3" class="form-control" value="${sd.sdleve3}" /></td>
		  		 <td><input type="text" name="sdsingle" class="form-control" value="${sd.sdsingle}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	<div class="alert alert-info" role="alert"><h4>注：一等奖学金4%，金额为1500元；二等奖学金7%(含优秀学生干部1.5%)，金额为900元；三等奖学金10%，金额为500元；单项奖按学生人数的4%评定，金额为300元。</h4></div>
	</fieldset>

	<form action="scholarshipDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="sid" value="${scholarshipInfo.sid}" >
	</form>
	<form action="scholarshipDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>

