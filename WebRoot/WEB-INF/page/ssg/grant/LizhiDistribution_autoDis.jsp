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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
    <title>励志奖学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "励志奖学金名称不能为空", "error");
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
		励志奖学金指标分配
	</legend>
	<form action="lizhiDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="lid" id="lid" value="${lizhiInfo.lid}"/>
		<input type="hidden" name="schoolYear.syid" value="${lizhiInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				<label>励志奖学金年度:</label>
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${lizhiInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				<label>励志奖学金名称:</label>
				<input type="text" id="name" name="name" class="form-control" value="${lizhiInfo.name}" />
			</div>
		<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
		<button type="button" class="btn btn-primary" <c:if test="${empty lizhiInfo.lid}">disabled="disabled"</c:if> id="update">修改</button>
		<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
		<button type="button" class="btn btn-warning" <c:if test="${empty lizhiInfo.lid or lizhiInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
		<input type="button" class="btn btn-primary" id="_export" value="信息导出" <c:if test="${empty lizhiInfo.lid}">disabled="disabled"</c:if> />
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>励志奖学金名额</th>
  		</tr>
  		<form action="lizhiDistribution/update" method="post" id="zcForm">
  		<c:forEach var="ld" items="${ldList}" varStatus="st">
  			<input type="hidden" name="ldid" class="form-control" value="${ld.ldid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${ld.academy.aname}</td>
		  		 <td>${ld.acaStudentNum}</td>
		  		 <td><input type="text" name="ldnumber" class="form-control" value="${ld.ldnumber}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	</fieldset>
	<div class="alert alert-info" role="alert"><h4>注：励志奖学金名额按学院学生人数的4%比例，四舍五入后自动分配。</h4></div>
	<form action="lizhiDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="lid" value="${lizhiInfo.lid}" >
	</form>
	<form action="lizhiDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
