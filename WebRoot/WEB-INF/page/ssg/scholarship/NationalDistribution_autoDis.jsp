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
    <title>国家奖学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "国家奖学金名称不能为空", "error");
					return false;
				}
				swal({title: "温馨提示",text: "您确定要自动分配吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#zdfpForm").submit();
				});
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
				swal({title: "温馨提示",text: "您确定发布吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#fbForm").submit();
				});
    		});    
    		$("#_export").click(function(){
       			$("#exportForm").submit();
    		});
		});
	</script>
</head>
<body>
	<legend>
		国家奖学金指标分配
	</legend>
	<form action="nationalDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
	<div class="well form-search">
		<input type="hidden" name="nid" id="nid" value="${nationalInfo.nid}"/>
		<input type="hidden" name="schoolYear.syid" id="syid" value="${nationalInfo.schoolYear.syid}"/>
		<div class="form-group">
			<label>学年</label>
			<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${nationalInfo.schoolYear.syname}" />
		</div>	
		<div class="form-group">
			<label>国家奖学金名称</label>
			<input type="text" id="name" name="name" class="form-control" value="${nationalInfo.name}" />
		</div>
		
		<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
		<button type="button" class="btn btn-primary" <c:if test="${empty nationalInfo.nid}">disabled="disabled"</c:if> id="update">修改</button>
		<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
		<button type="button" class="btn btn-warning" <c:if test="${nationalInfo.publishStatus eq true or empty nationalInfo.nid}">disabled="disabled"</c:if> id="fabu">发布</button>
		<input type="button" class="btn btn-primary" id="_export" value="信息导出" />
  	</div>
  	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>名额</th>
  		</tr>
  		<form action="nationalDistribution/update" method="post" id="zcForm">
  		<c:forEach var="nd" items="${ndList}" varStatus="st">
  			<input type="hidden" name="ndid" class="form-control" value="${nd.ndid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${nd.academy.aname}</td>
		  		 <td>${nd.acaStudentNum}</td>
		  		 <td><input type="text" name="ndnumber" class="form-control" value="${nd.ndnumber}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	</fieldset>
	<div class="alert alert-info" role="alert"><h4>注：国家奖学金名额按学院学生人数的0.25%比例，四舍五入后自动分配。</h4></div>

	<form action="nationalDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="nid" value="${nationalInfo.nid}" >
	</form>
	<form action="nationalDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
