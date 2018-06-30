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
    <title>明德奖学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "明德奖学金名称不能为空", "error");
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
		明德奖学金指标分配
	</legend>
	<form action="mingdeDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="mid" id="mid" value="${mingdeInfo.mid}"/>
		<input type="hidden" name="schoolYear.syid" value="${mingdeInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				明德奖学金年度：
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${mingdeInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				明德奖学金名称：
				<input type="text" id="name" name="name" class="form-control" value="${mingdeInfo.name}" />
			</div>
			
			<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
			<button type="button" class="btn btn-primary" <c:if test="${empty mingdeInfo.mid}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty mingdeInfo.mid}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-primary" id="_export" <c:if test="${empty mingdeInfo.mid}">disabled="disabled"</c:if> value="信息导出" />
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>师范生人数</th>
  			<th>明德奖学金名额</th>
  			<th>实际名额</th>
  		</tr>
  		<form action="mingdeDistribution/update" method="post" id="zcForm">
  		<c:forEach var="md" items="${mdList}" varStatus="st">
  			<input type="hidden" name="mdid" class="form-control" value="${md.mdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${md.academy.aname}</td>
		  		 <td>${md.mdnstudentNum}</td>
		  		 <td><input type="text" name="mdnumber" class="form-control" value="${md.mdnumber}" /></td>
		  		 <td>${md.submitNum}</td>
		</c:forEach>	
		</form>
	</table>
		<div class="alert alert-info" role="alert"><h4>注：明德奖学金暂无自动分配算法。</h4></div>
	</fieldset>

	<form action="mingdeDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="mid" value="${mingdeInfo.mid}" >
	</form>
	<form action="mingdeDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
