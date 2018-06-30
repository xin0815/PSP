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
<title>素质评价汇总</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript">
	function ajaxteac(){
		initAjaxXmlHttpRequest();
		var src = "<%=basePath%>qualityTotaly/ajaxtea?acae="+$("#acade").val()+"&syid="+$("#syid").val();
		xmlhttp.open("POST", src, false);
		xmlhttp.onreadystatechange = function() {
			var obj = document.getElementById("clases");
			obj.options.length = 0;
			var message = xmlhttp.responseText;
			if (message != "") {
				var classes = message.split(",");
				for (var i = 0; i < classes.length; i += 2) {
					if (classes[i] != "") {
						obj.options.add(new Option(classes[i], classes[i + 1]));
					}
				}
			}
			$(".multiSelect").select2();
		};
		xmlhttp.send();
	}

	$(function() {
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
	        window.location.href='<%=basePath%>qualityTotaly/exportExcel?classID='+$("#clases").val();
		});
	})
</script>
</head>

<body>
	<legend>历年素质评价归档资料</legend>
	<form action="qualityTotaly/list" method="post" class="form-inline" id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">素质评价年度</label>
				<select id="syid" name="syid" class="form-control">
					<c:forEach var="sy" items="${syList}">
						<option value="${sy.syid}" <c:if test="${sy.syid eq syid }">selected="selected"</c:if>>${sy.syname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学院</label> <select id="acade" name="aacademyCode" onchange="ajaxteac();" class="multiSelect ">
					<c:if test="${teacher.isSchoolTeacher == true}">
						<option value="">——全部——</option>
					</c:if>
					<c:forEach var="acade" items="${acadeLsit}">
						<option value="${acade.aacademyCode}" <c:if test="${acade.aacademyCode eq aacademyCode }">selected="selected"</c:if>>${acade.aname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">班级</label> <select id="clases" name="classID" class="multiSelect">
					<c:forEach var="classList" items="${classList}">
						<option value="${classList.cid}" <c:if test="${classList.cid eq classID}">selected="selected"</c:if>>${classList.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学号</label>
				<input type="text" name="studentCode" value = "${studentCode}"  class="form-control" />
			</div>
			<div class="form-group">
				<label for="">姓名</label>
				<input type="text" name="studentName" value = "${studentName}"  class="form-control" />
			</div>
			<div class="form-group">
				<label for="">班级参评人数</label>
				<input type="text" name="classnum" value="${classnum}" disabled="disabled"   class="form-control" />
			</div>
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-info" id="_exprot" value="信息导出" />
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
		<c:forEach var="qt" items="${qtList}" varStatus="vs">
			<tr>
				<td>${vs.index+1 }</td>
				<td>${qt.student.sstudentCode}</td>
				<td>${qt.student.sname}</th>
				<td><c:if test="${qt.qmRankType eq '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '良好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '较好'}">√</c:if></td>
				<td><c:if test="${qt.qmRankType eq '一般'}">√</c:if></td>
				<td>${qt.qsAvgScore}</th>
				<td>${qt.qsRank}</th>
				<td><c:if test="${qt.qbRankType eq '优秀'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '良好'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '及格'}">√</c:if></td>
				<td><c:if test="${qt.qbRankType eq '不及格'}">√</c:if></td>
				<td>${qt.qdTotalScore}
				</td>
				<td>${qt.qdRank}</td>
				<td style="text-align: center;vertical-align: middle;"><p style="overflow-y:scroll;max-height:60px;">${qt.remark}</p></td>
			</tr>
		</c:forEach>
	</table>
</body>
<script language="javascript">
	$(document).ready(function() {
		$(".multiSelect").select2();
	});
</script>
</html>