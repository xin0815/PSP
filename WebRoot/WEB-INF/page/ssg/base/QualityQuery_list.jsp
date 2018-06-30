<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>申请学年度素质评价汇总</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
<script type="text/javascript">
	$(function(){
	  	$("#tj").click(function(){
	  		swal({title: "温馨提示",text: "把学院所有班级整体提交学校审核，您确定提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
				window.location.href="<%=basePath%>qualityQuery/tijiao?classID="+ $("#classID").val();
			});
	  	});
	  	$("#_exprot").click(function() {
			window.location.href='<%=basePath%>qualityQuery/exportExcel?classID='+ $("#classID").val();
		});
	  	$("#th").click(function(){
	  		swal({title: "警告",text: "你确定整班退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
	  			$("#shForm").submit();
	  		});
	  	});
	});
</script>
</head>
<body>
	<legend> 申请年度素质评价汇总 </legend>
	<c:if test="${empty classList}">
		<div class="alert alert-warning" role="alert">
			<h4>暂无审核通过的班级。</h4>
		</div>
	</c:if>
	<form action="qualityQuery/list" method="post" class="form-inline">
		<div class="well form-search">
			<div class="form-group">
				<label for="schoolYear.syname">素质评价年度</label> <input name="schoolYear.syname"
					value="${bs.schoolYear.syname}" readonly="readonly"
					class="form-control" />
			</div>
			<div class="form-group">
				<label>学院：</label>${acade.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div class="form-group">
				<label>班级：</label> <select name="classID" id="classID" class="form-control">
					<c:forEach var="cc" items="${classList}">
						<option value="${cc.cid }"
							<c:if test="${classID eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
					</c:forEach>
				</select>
			</div>
			<input type="submit" class="btn btn-primary" value="查询" />
			<button type="button" class="btn btn-warning" id="tj" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>学院整体提交</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			<input type="button" class="btn btn-primary" id="_exprot" value="信息导出" />
		</div>
	</form>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
			<th rowspan="2">序号</th>
			<th rowspan="2">学号</th>
			<th rowspan="2">姓名</th>
			<th colspan="4">思想品德</th>
			<th colspan="2">学业</th>
			<th colspan="4">身体素质</th>
			<th colspan="2">日常表现</th>
			<th rowspan="2">
				备注
			</th>
		</tr>
		<th>优秀</th>
		<th>良好</th>
		<th>较好</th>
		<th>一般</th>
		<th>成绩</th>
		<th>排名</th>
		<th>优秀</th>
		<th>良好</th>
		<th>及格</th>
		<th>不及格</th>
		<th>成绩</th>
		<th>排名</th>

		<c:forEach var="qt" items="${qtList}" varStatus="st">
			<tr>
				<td>${st.index+1 }</td>
				<td>${qt.student.sstudentCode}</td>
				<td>${qt.student.sname}
				</th>
				<td><c:if test="${qt.qmRankType eq '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '良好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '较好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '一般'}">√</c:if></td>
				<td>${qt.qsAvgScore}
				</th>
				<td>${qt.qsRank}
				</th>
				<td><c:if test="${qt.qbRankType eq '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '良好'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '及格'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '不及格'}">√</c:if></td>
				<td>${qt.qdTotalScore}</td>
				<td>${qt.qdRank}</td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.remark}</p></td>
			</tr>
		</c:forEach>
	</table>
	<form action="qualityQuery/cancel" id="shForm">
		<input type="hidden" id="classid" name="classid" value="${classID}" />
	</form>
</body>
<script language="javascript">
	$(document).ready(function() {
		$("#classID").select2();
	});
</script>
</html>
