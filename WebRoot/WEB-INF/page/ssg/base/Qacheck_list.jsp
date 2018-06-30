<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>学院审核</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript">
	  $(function(){
	  	$("#recall_submit").click(function(){
			swal({title: "温馨提示",text: "您确定审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
	  			$("#check").val(1);
	  			$("#shForm").submit();
	  		});
	  	});
	  	
	  	$("#noSubmit").click(function(){
	  		swal({title: "警告",text: "你确定整班退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
	  			$("#check").val(2);
	  			$("#shForm").submit();
	  		});
	  	});
		  	
		 $("#clases").change(function() {
			var classes = document.getElementById("clases").value;
			if (classes != null) {
				document.getElementById("_query").disabled = false;
				document.getElementById("_exprot").disabled = false;
			} else {
				document.getElementById("_query").disabled = true;
				document.getElementById("_exprot").disabled = true;
			}
		});
       	$("#_exprot").click(function() {
        	window.location.href='<%=basePath%>qacheck/exportExcel?classID='+ $("#clases").val();
		});
	})
</script>
</head>

<body>
	<legend>学院审核 </legend>
	<form action="qacheck/list" method="post" class="form-inline"
		id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">素质评价年度</label> <input type="text" class="form-control" value="${bs.schoolYear.syname}" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="">学院</label> <input type="text" id="acade" name="" class="form-control" value=${acade.aname} readonly="readonly" />
			</div>
			<div class="form-group">
				<label for="">班级</label> <select id="clases" name="classID" class="form-control ">
					<c:forEach var="classList" items="${classList}">
						<option value="${classList.cid}" <c:if test="${classID eq classList.cid}">selected="selected"</c:if> >${classList.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-info" id="_exprot" value="信息导出" />
		</div>
	</form>
	<div align="center">
		<font color="#000000"><h4>内蒙古师范大学学生素质评价情况汇总表</h4> </font>
	</div>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
			<th rowspan="2">
				序号
			</th>
			<th rowspan="2">
				学号
			</th>
			<th rowspan="2">
				姓名
			</th>
			<th colspan="4">
				思想品德
			</th>
			<th colspan="2">
				学业
			</th>
			<th colspan="4">
				身体素质
			</th>
			<th colspan="2">
				日常表现
			</th>
			<th rowspan="2">
				备注
			</th>
		</tr>
		<th>
			优秀
		</th>
		<th>
			良好
		</th>
		<th>
			较好
		</th>
		<th>
			一般
		</th>
		<th>
			成绩
		</th>
		<th>
			排名
		</th>
		<th>
			优秀
		</th>
		<th>
			良好
		</th>
		<th>
			及格
		</th>
		<th>
			不及格
		</th>
		<th>
			成绩
		</th>
		<th>
			排名
		</th>
		<c:forEach var="qt" items="${qtList}" varStatus="vs">
			<tr>
				<td>${vs.index+1 }</td>
				<td>${qt.student.sstudentCode}</td>
				<td>${qt.student.sname}</td>
				<td><c:if test="${qt.qmRankType == '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType == '良好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType== '较好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType== '一般'}">√</c:if></td>
				<td>${qt.qsAvgScore}</td>
				<td>${qt.qsRank}</td>
				<td><c:if test="${qt.qbRankType == '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType == '良好'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType == '及格'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType == '不及格'}">√</c:if></td>
				<td>${qt.qdTotalScore}</td>
				<td>${qt.qdRank}</td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.remark}</p></td>
			</tr>
		</c:forEach>
	</table>
	<center>
	<c:if test="${not empty qtList}">
		<button type="button" class="btn btn-warning" id="recall_submit">整班通过</button>
		<button type="button" class="btn btn-warning" id="noSubmit">整班退回</button>
	</c:if>
	</center>
	<form action="qacheck/check" id="shForm">
		<input type="hidden" id="classid" name="classid" value="${classID}" />
		<input type="hidden" id="check" name="check" value="" />
	</form>
</body>
<script language="javascript">
	$(document).ready(function() {
		$("#clases").select2();
	});
</script>
</html>