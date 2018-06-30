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
<title>历年校内奖学金归档资料汇总</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<script language="javascript" src="<%=basePath%>js/common.js"></script>
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript">
	function ajaxGetClass(){
		initAjaxXmlHttpRequest();
		var src = "<%=basePath%>scholarshipHistory/ajaxGetClass?academyCode="+$("#academyCode").val()+"&syid="+$("#syid").val();
		xmlhttp.open("POST", src, false);
		xmlhttp.onreadystatechange = function() {
			var obj = document.getElementById("classId");
			obj.options.length = 0;
			var message = xmlhttp.responseText;
			obj.options.add(new Option("——全部——",""));
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
		$("#_exprot").click(function() {
	        $("#exportForm").submit();
		});
	})
</script>
</head>

<body>
	<legend>历年校内奖学金归档资料</legend>
	<!-- <form action="scholarshipHistory/imported" method="post" enctype="multipart/form-data" id="uploadForm">
			请单击此处，下载导入模板：<a href="<%=basePath%>template/DisciplineStudent.xls" class="btn btn-info active" role="button">违纪学生信息导入模版</a>
			<br/>
			<br/>
			<div class="well form-search">
				<div class="a-upload">
					<input type="file" id="filePath" name="filePath" style="width: 400px" onkeydown="return false;" />
				</div>
				<input type="submit" class="btn btn-info"  value="上传" />	
			</div>
			<table class="table table-striped table-bordered table-condensed">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="color: #770000">${error}</span>
				<c:forEach var="errorInfo" items="${errorList}" begin="0" end="0">
					<tr>
						<td style="color: #770000">
							${errorInfo}
						</td>
					</tr>
				</c:forEach>
				<c:forEach var="errorInfo" items="${errorList}" begin="1">
					<tr>
						<td style="color: #770000">
							${errorInfo}
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	 -->
	<form action="scholarshipHistory/list" method="post" class="form-inline" id="staffForm">
		<div class="well form-search">
			<div class="form-group">
				<label for="">学年</label>
				<select id="syid" name="syid" class="form-control">
					<c:forEach var="sy" items="${syList}">
						<option value="${sy.syid}" <c:if test="${sy.syid eq bean.syid }">selected="selected"</c:if>>${sy.syname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学院</label>
				<select id="academyCode" name="academyCode" onchange="ajaxGetClass();" class="multiSelect ">
					<c:if test="${teacher.isSchoolTeacher == true}">
						<option value="">——全部——</option>
					</c:if>
					<c:forEach var="acade" items="${acadeList}">
						<option value="${acade.aacademyCode}" <c:if test="${acade.aacademyCode eq bean.academyCode }">selected="selected"</c:if>>${acade.aname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">班级</label>
				<select id="classId" name="classId" class="multiSelect">
					<option value="">——全部——</option>
					<c:forEach var="classList" items="${classList}">
						<option value="${classList.cid}" <c:if test="${classList.cid eq bean.classId}">selected="selected"</c:if>>${classList.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="">学号</label>
				<input type="text" name="studentCode" value="${bean.studentCode }" class="form-control" />
			</div>
			<div class="form-group">
				<label for="">姓名</label>
				<input type="text" name="studentName" value="${bean.studentName }" class="form-control" />
			</div>
			<input type="submit" class="btn btn-primary" id="_query" value="查询 " />
			<input type="button" class="btn btn-primary" id="_exprot" value="信息导出" />
		</div>
		<jsp:include page="../../common/Page.jsp" />
	</form>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
					<th width="30"></th>
					<th>
						序号
					</th>
					<th>
						学生姓名
					</th>
					<th>
						公民身份证号码
					</th>
					<th>
						专业
					</th>
					<th>
						学号
					</th>
					<th>
						性别
					</th>
					<th>
						民族
					</th>
					<th>
						年级
					</th>
					<th>
						学生申请等级
					</th>
					<th>
						学生申请单项奖类型
					</th>
					<th>
						班级认定等级
					</th>
					<th>
						班级认定单项奖类型
					</th>
					<th>
						学院审核等级
					</th>
					<th>
						学院审核单项奖类型
					</th>
					<th>
						学校审批等级
					</th>
					<th>
						学校审批单项奖类型
					</th>
				</tr>
		<c:forEach var="sa" items="${pager.data}" varStatus="st">
			<tr>
				<td width="30px">
					<input type="radio" " name="_radio" value="${sa.said}" />
				</td>
				<td>
					${st.index + 1}
				</td>
				<td>
					${sa.student.sname}
				</td>
				<td>
					${sa.student.sidCard}
				</td>
				<td>
					${sa.bclass.cmajor}
				</td>
				<td>
					${sa.student.sstudentCode}
				</td>
				<td>
					${sa.student.ssex}
				</td>
				<td>
					${sa.student.snation.name}
				</td>
				<td>
					${sa.bclass.cgrade}
				</td>
				<td>
					<c:if test="${sa.saslevel eq 1}">一等</c:if>
					<c:if test="${sa.saslevel eq 2}">二等</c:if>
					<c:if test="${sa.saslevel eq 3}">三等</c:if>
					<c:if test="${sa.saslevel eq 4}">单项奖</c:if>
					<c:if test="${sa.saslevel eq 5}">优秀学生干部奖</c:if>
				</td>
				<td>
					<c:if test="${sa.sassingleLevel eq 1}">道德风尚奖</c:if>
					<c:if test="${sa.sassingleLevel eq 2}">科技创新奖</c:if>
					<c:if test="${sa.sassingleLevel eq 3}">民族团结奖</c:if>
					<c:if test="${sa.sassingleLevel eq 4}">社会公益活动奖</c:if>
					<c:if test="${sa.sassingleLevel eq 5}">鼓励进步奖</c:if>
					<c:if test="${sa.sassingleLevel eq 6}">学习优秀奖</c:if>
					<c:if test="${sa.sassingleLevel eq 7}">文体技能奖</c:if>
			    </td>
			    <td>
					<c:if test="${sa.satlevel eq 1}">一等</c:if>
					<c:if test="${sa.satlevel eq 2}">二等</c:if>
					<c:if test="${sa.satlevel eq 3}">三等</c:if>
					<c:if test="${sa.satlevel eq 4}">单项奖</c:if>
					<c:if test="${sa.satlevel eq 5}">优秀学生干部奖</c:if>
				</td>
				<td>
					<c:if test="${sa.satsingleLevel eq 1}">道德风尚奖</c:if>
					<c:if test="${sa.satsingleLevel eq 2}">科技创新奖</c:if>
					<c:if test="${sa.satsingleLevel eq 3}">民族团结奖</c:if>
					<c:if test="${sa.satsingleLevel eq 4}">社会公益活动奖</c:if>
					<c:if test="${sa.satsingleLevel eq 5}">鼓励进步奖</c:if>
					<c:if test="${sa.satsingleLevel eq 6}">学习优秀奖</c:if>
					<c:if test="${sa.satsingleLevel eq 7}">文体技能奖</c:if>
			    </td>
			    <td>
					<c:if test="${sa.saalevel eq 1}">一等</c:if>
					<c:if test="${sa.saalevel eq 2}">二等</c:if>
					<c:if test="${sa.saalevel eq 3}">三等</c:if>
					<c:if test="${sa.saalevel eq 4}">单项奖</c:if>
					<c:if test="${sa.saalevel eq 5}">优秀学生干部奖</c:if>
				</td>
				<td>
					<c:if test="${sa.saasingleLevel eq 1}">道德风尚奖</c:if>
					<c:if test="${sa.saasingleLevel eq 2}">科技创新奖</c:if>
					<c:if test="${sa.saasingleLevel eq 3}">民族团结奖</c:if>
					<c:if test="${sa.saasingleLevel eq 4}">社会公益活动奖</c:if>
					<c:if test="${sa.saasingleLevel eq 5}">鼓励进步奖</c:if>
					<c:if test="${sa.saasingleLevel eq 6}">学习优秀奖</c:if>
					<c:if test="${sa.saasingleLevel eq 7}">文体技能奖</c:if>
			    </td>
			    <td>
					<c:if test="${sa.saulevel eq 1}">一等</c:if>
					<c:if test="${sa.saulevel eq 2}">二等</c:if>
					<c:if test="${sa.saulevel eq 3}">三等</c:if>
					<c:if test="${sa.saulevel eq 4}">单项奖</c:if>
					<c:if test="${sa.saulevel eq 5}">优秀学生干部奖</c:if>
				</td>
				<td>
					<c:if test="${sa.sausingleLevel eq 1}">道德风尚奖</c:if>
					<c:if test="${sa.sausingleLevel eq 2}">科技创新奖</c:if>
					<c:if test="${sa.sausingleLevel eq 3}">民族团结奖</c:if>
					<c:if test="${sa.sausingleLevel eq 4}">社会公益活动奖</c:if>
					<c:if test="${sa.sausingleLevel eq 5}">鼓励进步奖</c:if>
					<c:if test="${sa.sausingleLevel eq 6}">学习优秀奖</c:if>
					<c:if test="${sa.sausingleLevel eq 7}">文体技能奖</c:if>
			    </td>
			</tr>
		</c:forEach>
	</table>
	<form action="scholarshipHistory/exportExcel" method="post" id="exportForm">
		<input type="hidden" name="academyCode" value="${bean.academyCode}">
		<input type="hidden" name="classId" value="${bean.classId}">
		<input type="hidden" name="syid" value="${bean.syid}">
		<input type="hidden" name="studentCode" value="${bean.studentCode}">
		<input type="hidden" name="studentName" value="${bean.studentName}">
	</form>
</body>
<script language="javascript">
	$(document).ready(function() {
		$(".multiSelect").select2();
	});
</script>
</html>