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
    <title>减免学费指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#name").val() == ""){
					swal("错误提示", "减免学费名称不能为空", "error");
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
		减免学费指标分配	
	</legend>
	<form action="jianmianDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="jid" id="jid" value="${jianmianInfo.jid}"/>
		<input type="hidden" name="schoolYear.syid" value="${jianmianInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				<label>减免学费年度:</label>
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${jianmianInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				<label>减免学费名称:</label>
				<input type="text" id="name" name="name" class="form-control" value="${jianmianInfo.name}" />
			</div>
			<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
			<button type="button" class="btn btn-primary" <c:if test="${empty jianmianInfo.jid}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty jianmianInfo.jid or jianmianInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-primary" id="_export" <c:if test="${empty jianmianInfo.jid}">disabled="disabled"</c:if> value="信息导出" />
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
  		</tr>
  		<form action="jianmianDistribution/update" method="post" id="zcForm">
  		<c:forEach var="jd" items="${jdList}" varStatus="st">
  			<input type="hidden" name="jdid" class="form-control" value="${jd.jdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${jd.academy.aname}</td>
		  		 <td>${jd.acaStudentNum}</td>
		  		 <td><input type="text" name="jdleve1" class="form-control" value="${jd.jdleve1}" /></td>
		  		 <td><input type="text" name="jdleve2" class="form-control" value="${jd.jdleve2}" /></td>
		  		 <td><input type="text" name="jdleve3" class="form-control" value="${jd.jdleve3}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	<div class="alert alert-info" role="alert"><h4>注：暂无自动分配算法。</h4></div>
	</fieldset>

	<form action="jianmianDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="jid" value="${jianmianInfo.jid}" >
	</form>
	<form action="jianmianDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
