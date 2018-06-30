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
    <title>三优奖学金指标分配</title>
	<script language="javascript">
		$(function(){
			$("#zdfp").click(function(){//自动分配
				trimAll();
				if($("#ename").val() == ""){
					swal("错误提示", "三优奖学金名称不能为空", "error");
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
		三优奖学金指标分配	
	</legend>
	<form action="excellentDistribution/autoDis" method="post" class="form-inline" id="zdfpForm">
		<input type="hidden" name="eid" id="eid" value="${excellentInfo.eid}"/>
		<input type="hidden" name="schoolYear.syid" value="${excellentInfo.schoolYear.syid}"/>
		<div class="well form-search">
			<div class="form-group">
				<label>年度:</label>
				<input type="text" name="schoolYear.syname" class="form-control" readonly="readonly" value="${excellentInfo.schoolYear.syname}" />
			</div>	
			<div class="form-group">
				<label>名称:</label>
				<input type="text" id="ename" name="ename" class="form-control" value="${excellentInfo.ename}" />
			</div>
			<button type="button" class="btn btn-primary" id="zdfp">自动分配</button>
			<button type="button" class="btn btn-primary" <c:if test="${empty excellentInfo.eid}">disabled="disabled"</c:if> id="update">修改</button>
			<button type="button" class="btn btn-primary" id="zc" disabled="disabled">保存</button>
			<button type="button" class="btn btn-warning" <c:if test="${empty excellentInfo.eid or excellentInfo.publishStatus eq true}">disabled="disabled"</c:if> id="fabu">发布</button>
			<input type="button" class="btn btn-primary" id="_export" <c:if test="${empty excellentInfo.eid}">disabled="disabled"</c:if> value="信息导出" />
		</div>
	</form>
  	<fieldset disabled="disabled" id="_fieldset">
  	<table class="table table-bordered table-hover">
  		<tr>
  			<th>序号</th>
  			<th>学院</th>
  			<th>学生人数</th>
  			<th>三好学生</th>
  			<th>优秀班干部</th>
  			<th>优秀毕业生</th>
  		</tr>
  		<form action="excellentDistribution/update" method="post" id="zcForm">
  		<c:forEach var="ed" items="${edList}" varStatus="st">
  			<input type="hidden" name="edid" class="form-control" value="${ed.edid}" />
	  		<tr>
		  		 <td>${st.index + 1}</td>
		  		 <td>${ed.academy.aname}</td>
		  		 <td>${ed.acaStudentNum}</td>
		  		 <td><input type="text" name="edtype1" class="form-control" value="${ed.edtype1}" /></td>
		  		 <td><input type="text" name="edtype2" class="form-control" value="${ed.edtype2}" /></td>
		  		 <td><input type="text" name="edtype3" class="form-control" value="${ed.edtype3}" /></td>
	  		</tr>
		</c:forEach>
		</form>
	</table>
	<div class="alert alert-info" role="alert"><h4>注：三优奖学金暂无自动分配算法。</h4></div>
	</fieldset>

	<form action="excellentDistribution/publish" method="post" id="fbForm">
		<input type="hidden" name="eid" value="${excellentInfo.eid}" >
	</form>
	<form action="excellentDistribution/exportExcel" method="post" id="exportForm">
	</form>
</body>
</html>

