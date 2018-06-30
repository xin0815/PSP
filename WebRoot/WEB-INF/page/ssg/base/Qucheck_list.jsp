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
<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/vendor/jquery-2.1.0.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
<script language="javascript">
	function ajaxteac(){
			initAjaxXmlHttpRequest();
			var src = "<%=basePath%>qucheck/ajaxtea?acae="+$("#acade").val()+"&syid="+$("#syid").val();
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
		$("#_checkStatus").click(function(){
    	window.location.href="<%=basePath%>qucheck/checkStatus";
		});
		//学业成绩排序
		$("#savrank").click(function(){
			window.location.href="<%=basePath%>qucheck/savrank?classId="+$("#clases").val()+"&acae="+$("#acade").val()+"&rank="+$("#rankID").val();
		});
		//审核通过
		$("#recall_submit").click(function() {
			swal({
				title : "警告",
				text : "您确定审核通过吗？",
				type : "info",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "ok",
				closeOnConfirm : false
			}, function() {
				$("#check").val(1);
				$("#shForm").submit();
			});
		});
		//审核不通过
		$("#noSubmit").click(function() {
			swal({
				title : "警告",
				text : "您确定审核不通过吗？",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "ok",
				closeOnConfirm : false
			}, function() {
				$("#check").val(2);
				$("#shForm").submit();
			});
		});
		$("#_exprot").click(function() {
        	window.location.href='<%=basePath%>qucheck/exportExcel?aacademyCode='+ $("#aacademyCode").val();
		});
	})
</script>
</head>

<body>
	<legend> 素质评价学校审核 </legend>
	<form action="qucheck/list" method="post" class="form-inline" id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">素质评价年度</label> <input name="schoolYear.syname"
					value="${bs.schoolYear.syname}" readonly="readonly"
					class="form-control" />
					<input id="syid" type="hidden" value="${bs.schoolYear.syid}" />
			</div>
			<div class="form-group">
				<label for="">学院</label> <select id=acade name="aacademyCode" onchange="ajaxteac();" class="multiSelect ">
					<option value="">——全部——</option>
					<c:forEach var="acade" items="${acadeLsit}">
						<option value="${acade.aacademyCode}" <c:if test="${aacademyCode eq acade.aacademyCode }">selected="selected"</c:if> >${acade.aname}</option>
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
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-info" id="_checkStatus" value="审核状态">
			<input type="button" class="btn btn-info" id="_exprot" value="信息导出" />
			<button type="button" class="btn btn-success" id="recall_submit"<%-- <c:if test="${stud.qucheck != 3}">disabled="disabled"</c:if>  --%>   >学院整体审核通过</button>
			<button type="button" class="btn btn-danger" id="noSubmit"<%-- <c:if test="${stud.qucheck != 3}">disabled="disabled"</c:if> --%> >学院整体审核不通过</button>
			<div class="form-group">
				<label for="">班级</label> <select id="rankID" name="rankID" class="multiSelect">
					<option value = "1" <c:if test="${rank eq 1 }">selected="selected"</c:if>>思想品德</option>
					<option value = "2" <c:if test="${rank eq 2 }">selected="selected"</c:if>>学业成绩</option>
					<option value = "3" <c:if test="${rank eq 3 }">selected="selected"</c:if>>日常表现</option>
				</select>
			</div>
			<input type="button" class="btn btn-info" id="savrank" value="排序">
		</div>
		<jsp:include page="../../common/Page.jsp" />
	</form>
	<div align="center">
		<font color="#000000"><h4>内蒙古师范大学学生素质评价情况汇总表</h4> </font>
	</div>

	<table id = "dtable" class="table table-striped table-bordered table-condensed">

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

		<c:forEach var="qt" items="${pageList}" varStatus="vs">
			<tr>
				<td>${vs.index+1 }</td>
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
	<center>
		
	</center>
	<form action="qucheck/check" id="shForm">
		<input type="hidden" id="_aacademyCode" name="aacademyCode" value="${aacademyCode}" />
		<input type="hidden" id="check" name="check" value="" />
	</form>
</body>
<script language="javascript">
	$(document).ready(function() {
		$("#aacademyCode").select2();
	});
</script>
</html>