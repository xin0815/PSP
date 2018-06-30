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
    <title>国家助学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "国家助学金名称不能为空", "error");
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
		国家助学金指标分配
	</legend>
	<form action="grantDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="gid" id="gid" value="${grantInfo.gid}"/>
		<input type="hidden" name="schoolYear.syid" value="${grantInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				<label>国家助学金年度:</label>
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${grantInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				<label>国家助学金名称:</label>
				<input type="text" id="name" name="name" class="form-control" value="${grantInfo.name}" />
			</div>
			
			<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
			<button type="button" class="btn btn-primary" <c:if test="${empty grantInfo.gid}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty grantInfo.gid or grantInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-primary" id="_export" value="信息导出" <c:if test="${empty grantInfo.gid}">disabled="disabled"</c:if> />
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>名额</th>
  			<th>金额</th>
  		</tr>
  		<form action="grantDistribution/update" method="post" id="zcForm">
  		<c:forEach var="gd" items="${gdList}" varStatus="st">
  			<input type="hidden" name="gdid" class="form-control" value="${gd.gdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${gd.academy.aname}</td>
		  		 <td>${gd.acaStudentNum}</td>
		  		 <td><input type="text" name="gdnumber" class="form-control" value="${gd.gdnumber}" /></td>
		  		 <td><input type="text" name="gdmoney" class="form-control" value="${gd.gdmoney}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	</fieldset>
	<div class="alert alert-info" role="alert"><h4>注：国家助学金暂未确定自动分配算法，默认分配名额和金额为0。</h4></div>
	<form action="grantDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="gid" value="${grantInfo.gid}" >
	</form>
	<form action="grantDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
