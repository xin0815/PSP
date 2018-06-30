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
    <title>贫困认定指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#pname").val() == ""){
					swal("错误提示", "贫困认定名称不能为空", "error");
					return false;
				}
				swal({title: "温馨提示",text: "您确定要自动分配吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#zdfpForm").submit();
				});
    		});
			$("#update").click(function(){
				$("#_fieldset").attr("disabled",false);
				$("#zc").attr("disabled",false);
				$("#pname").attr("readOnly","true");
				
				
    		}); 
    		$("#zc").click(function(){
    			if(checkInputText()){
    				$("#zcForm").submit();
    			}
    			$("#pname").attr("readOnly","false");
    		});   
    		$("#fabu").click(function(){
				swal({title: "温馨提示",text: "您确定发布吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#pnameup").val($("#pname").val());
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
		贫困认定指标分配
	</legend>
	<form action="poorDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
	<div class="well form-search">
		<input type="hidden" name="pid" id="pid" value="${poorInfo.pid}"/>
		<input type="hidden" name="schoolYear.syid" id="syid" value="${poorInfo.schoolYear.syid}"/>
		<div class="form-group">
			<label>贫困认定学年</label>
			<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${poorInfo.schoolYear.syname}" />
		</div>	
		<div class="form-group">
			<label>贫困认定名称</label>
			<input type="text" id="pname" name="pname" class="form-control"  value="${poorInfo.pname}" />
		</div>
		
		<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
		<button type="button" class="btn btn-info" <c:if test="${empty poorInfo.pid}">disabled="disabled"</c:if> id="update">修改</button>
		<button type="button" class="btn btn-info" id="zc" disabled="disabled">保存</button>
		<button type="button" class="btn btn-warning" <c:if test="${empty poorInfo.pid}">disabled="disabled"</c:if> id="fabu">发布</button>
		<input type="button" class="btn btn-info" id="_export" value="信息导出" />
  	</div>
  	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover table-condensed">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>特困生</th>
  			<th>困难生</th>
  			<th>一般困难生</th>
  		</tr>
  		<form action="poorDistribution/update" method="post" id="zcForm">
  		<c:forEach var="pd" items="${pdList}" varStatus="st">
  			<input type="hidden" name="pdid" class="form-control" value="${pd.pdid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${pd.academy.aname}</td>
		  		 <td>${pd.acaStudentNum}</td>
		  		 <td><input type="text" name="pdspecialDifficultyN" class="form-control" value="${pd.pdspecialDifficultyN}" /></td>
		  		 <td><input type="text" name="pddifficultyN" class="form-control" value="${pd.pddifficultyN}" /></td>
		  		 <td><input type="text" name="pdgeneralDiffcultyN" class="form-control" value="${pd.pdgeneralDiffcultyN}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	</fieldset>

	<form action="poorDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="pid" value="${poorInfo.pid}" >
		<input type="hidden" id="pnameup" name="pname" value="" >
	</form>
	<form action="poorDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>
