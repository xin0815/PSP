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
    <title>临时伙食补贴指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "贫困认定名称不能为空", "error");
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
			临时伙食补贴指标分配
	</legend>
	<form action="huoshiDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="hid" id="hid" value="${huoshiInfo.hid}"/>
		<input type="hidden" name="schoolYear.syid" value="${huoshiInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				临时伙食补贴年度:
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${huoshiInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				临时伙食补贴名称:
				<input type="text" id="name" name="name" class="form-control" value="${huoshiInfo.name}" />
			</div>
			
			<button type="button" class="btn btn-primary" <c:if test="${huoshiInfo.publishStatus eq true}">disabled="disabled"</c:if> id="zdfp">自动分配</button>
			<button type="button" class="btn btn-info" <c:if test="${empty huoshiInfo.hid or huoshiInfo.publishStatus eq true}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-info" id="zc" disabled="disabled">暂存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty huoshiInfo.hid or huoshiInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-info" id="_export" <c:if test="${empty huoshiInfo.hid}">disabled="disabled"</c:if> value="信息导出" />	
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>补贴标准</th>
  			<th>补贴人数</th>
  		</tr>
  		<form action="huoshiDistribution/update" method="post" id="zcForm">
  		<c:forEach var="hd" items="${hdList}" varStatus="st">
  			<input type="hidden" name="hdid" class="form-control" value="${hd.hdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${hd.academy.aname}</td>
		  		 <td>${hd.acaStudentNum}</td>
		  		 <td><input type="text" name="hdstandard" class="form-control" value="${hd.hdstandard}" /></td>
		  		 <td><input type="text" name="hdnumber" class="form-control" value="${hd.hdnumber}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	</fieldset>

	<form action="huoshiDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="hid" value="${huoshiInfo.hid}" >
	</form>
	<form action="" method="post" id="exportForm">
	</form>
</body>
</html>
