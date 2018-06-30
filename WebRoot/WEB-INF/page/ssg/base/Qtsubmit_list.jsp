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
<title>班主任提交</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<script language="javascript" src="<%=basePath%>bootstrap/js/bootstrap.min.js"></script>
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript">

	$(function() {
		$("#recall_submit").click(function() {
	  		swal({title: "警告",text: "提交后将不能重新导入数据，你确定提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
				window.location.href = "<%=basePath%>qtsubmit/check?classid="+$("#clases").val();
	  		});
		});

		$("#clases").change(function() {
			var classes = document.getElementById("clases").value;
			if (classes != null) {
				document.getElementById("_query").disabled = false;
			} else {
				document.getElementById("_query").disabled = true;
			}
		});
		$("#_import").click(function(){
			var classId = document.getElementById("clases").value;
			window.location.href = "<%=basePath%>qtsubmit/imported?classId="+classId;
		});
	})
</script>
</head>

<body>
	<legend>班主任提交</legend>
	<c:choose>
		<c:when test="${qt.qucheck eq 2}">
			<div class="alert alert-success" role="alert"><h4>您提交的素质评价情况，学校已经审核通过！</h4></div>
		</c:when>
		<c:when test="${qt.qacheck eq 2}">
			<div class="alert alert-success" role="alert"><h4>您已提交素质评价情况，学院已审核通过，请耐心等待学校审核！</h4></div>
		</c:when>
		<c:when test="${qt.qtcheck eq 2}">
			<div class="alert alert-success" role="alert"><h4>您已提交素质评价情况，学院尚未审核，请耐心等待！</h4></div>
		</c:when>
	</c:choose>
	<form action="qtsubmit/list" method="post" class="form-inline" id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">素质评价年度</label>
				<input name="schoolYear.syname" value="${schoolYear.syname}" readonly="readonly" class="form-control" />
			</div>
			<div class="form-group">
				<label for="">学院</label> <select id="acade" name="aacademyCode" class="form-control ">
					<c:forEach var="acade" items="${acadeLsit}">
						<option value="${acade.aacademyCode}">${acade.aname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">班级</label> <select id="clases" name="classID" class="form-control ">
					<c:forEach var="classList" items="${classList}">
						<option value="${classList.cid}" <c:if test="${classList.cid eq classID}">selected="selected"</c:if>>${classList.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-info"<c:if test="${qt.qtcheck eq 2}">disabled="disabled"</c:if> id="_import" value="数据导入" />
		</div>
	</form>
	<table class="table table-bordered table-hover">
		<tr>
			<th style="text-align: center;vertical-align: middle;" rowspan="2" width="25">序号</th>
			<th style="text-align: center;vertical-align: middle;" rowspan="2" nowrap="nowrap">学号</th>
			<th style="text-align: center;vertical-align: middle;" rowspan="2" nowrap="nowrap">姓名</th>
			<th style="text-align: center;vertical-align: middle;" colspan="4">思想品德</th>
			<th style="text-align: center;vertical-align: middle;" colspan="2">学业</th>
			<th style="text-align: center;vertical-align: middle;" colspan="4">身体素质</th>
			<th style="text-align: center;vertical-align: middle;" colspan="7">日常表现</th>
			<th style="text-align: center;vertical-align: middle;" rowspan="2" nowrap="nowrap">备注</th>
		</tr>
		<tr>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">优秀</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">良好</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">较好</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">一般</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">成绩</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">排名</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">优秀</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">良好</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">及格</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">不及格</th>
			<th style="text-align: center;vertical-align: middle;"  nowrap="nowrap">成绩</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">排名</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">基础分数</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">加分</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">减分</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">加分详情</th>
			<th style="text-align: center;vertical-align: middle;" nowrap="nowrap">减分详情</th>
		</tr>
		<c:forEach var="qt" items="${qtList}" varStatus="vs">
			<tr>
				<td style="text-align: center;vertical-align: middle;">${vs.index+1 }</td>
				<td style="text-align: center;vertical-align: middle;">${qt.student.sstudentCode}</td>
				<td  style="text-align: center;vertical-align: middle;" nowrap="nowrap">${qt.student.sname}</td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qmRankType eq '优秀'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qmRankType eq '良好'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qmRankType eq '较好'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qmRankType eq '一般'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;">${qt.qsAvgScore}</th>
				<td style="text-align: center;vertical-align: middle;">${qt.qsRank}</th>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qbRankType eq '优秀'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qbRankType eq '良好'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qbRankType eq '及格'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;"><c:if test="${qt.qbRankType eq '不及格'}">√</c:if></td>
				<td style="text-align: center;vertical-align: middle;">${qt.qdTotalScore}
				</td>
				<td style="text-align: center;vertical-align: middle;">${qt.qdRank}</td>
				<td style="text-align: center;vertical-align: middle;">${qt.qdBasicScore}</td>
				<td style="text-align: center;vertical-align: middle;">${qt.qdAddingScore}</td>
				<td style="text-align: center;vertical-align: middle;">${qt.qdReducingScore}</td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.qdAddingDetail}</p></td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.qdReducingDetail}</p></td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.remark}</p></td>
			</tr>
		</c:forEach>
	</table>
	<center>
		 <button type="button" class="btn btn-warning" id="recall_submit" <c:if test="${empty qtList or qt.qtcheck eq 2}">disabled="disabled"</c:if>>提交</button>
	</center>
</body>
</html>