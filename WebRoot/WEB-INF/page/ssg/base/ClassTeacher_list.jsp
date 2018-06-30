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
		<title>班主任管理</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/vendor/jquery-2.1.0.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
<script language="javascript">
$(function(){

    $("#_export").click(function(){//跳到更新页，进行更新操作
    	   $("#_acaCode").val($("#aacademyCode").val());
    	   $("#_bsCode").val($("#bscode").val());
    	   $("#_cclassName").val($("#cclassName").val());
    	   $("#_cclassCode").val($("#cclassCode").val());
           $("#exportForm").submit();
        }); 
})
</script>
	</head>
	<body>
		<legend>
			班级维护
		</legend>
		<form action="classTeacher/list" method="post" class="form-inline" id="staffForm">
			<div class="well form-search">
			<div class="form-group">
				<label for="bclass.academyInfo.aacademyCode">学院</label>
				<select id="aacademyCode" name="bclass.academyInfo.aacademyCode" style="width: 130px;" class="multiSelect">
					<option value="">——全部——</option>
					<c:forEach var="academy" items="${academyList}">
						<option value="${academy.aacademyCode}" <c:if test="${academy.aacademyCode eq queryCt.bclass.academyInfo.aacademyCode}">selected="selected"</c:if>>
							${academy.aname}
						</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				学年学期<select id="bscode" name="bsemester.bscode" class="multiSelect" style="width: 130px;">
					<option value="">——全部——</option>
					<c:forEach var="semester" items="${semesterList}">
						<option value="${semester.bscode}" <c:if test="${queryCt.bsemester.bscode eq semester.bscode}">selected="selected"</c:if>>
							${semester.bname}
						</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				班级名称
				<input type="text" id="cclassName" name="bclass.cclassName" style="width: 120px;" class="form-control" value="${queryCt.bclass.cclassName}" />
			</div>	
			<div class="form-group">
				班级编码
				<input type="text" id="cclassCode" name="bclass.cclassCode" style="width: 120px;" class="form-control" value="${queryCt.bclass.cclassCode}" />
			</div>
			<input type="submit" class="btn btn-primary" value="查看 " />
			<input type="button" class="btn btn-info" id="_export" value="信息导出" />
			</div>
			<jsp:include page="../../common/Page.jsp" />
	</form>
				<table class="table table-bordered table-condensed ">
					<tr>
						<th width="50">
						</th>
						<th>
							序号
						</th>
						<th>
							教工号
						</th>
						<th>
							姓名
						</th>
						<th>
							出生年月
						</th>
						<th>
							职称
						</th>
						<th>
							学历
						</th>
						<th>
							学年学期
						</th>
						<th>
							所带班级
						</th>
						<th>
							所带班级编号
						</th>
						<th>
							联系电话
						</th>
						<th>
							所在学院
						</th>
					</tr>
					
					<c:forEach var="ct" items="${pager.data}" varStatus="st">
						<tr>
							<td width="30px">
								<input type="radio" " name="_radio" value="${ct.id}" />
							</td>
							<td>
								${st.index + 1}
							</td>
							<td>
								${ct.teacher.bteacherId}
							</td>
							<td>
								${ct.teacher.tname}
							</td>
							<td>
								${ct.teacher.tbirthDay}
							</td>
							<td>
								${ct.teacher.tproTitle}
							</td>
							<td>
								${ct.teacher.teduBackground}
							</td>
							<td>
								${ct.bsemester.bname}
							</td>
							<td>
								${ct.bclass.cclassName}
							</td>
							<td>
							${ct.bclass.cclassCode}
							</td>
							<td>
							${ct.teacher.tphone}
							</td>
							<td>
							${ct.bclass.academyInfo.aname}
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		<form action="classTeacher/exportExcel" method="post" id="exportForm">
				<input type="hidden" id="_acaCode" name="bclass.academyInfo.aacademyCode" value="${queryCt.bclass.academyInfo.aacademyCode}" >
				<input type="hidden" id="_bsCode" name="bsemester.bscode" value="${queryCt.bsemester.bscode}">
				<input type="hidden" id="_cclassName" name="bclass.cclassName"  value="${queryCt.bclass.cclassName}" />
				<input type="hidden" id="_cclassCode" name="bclass.cclassCode" value="${queryCt.bclass.cclassCode}" />
		</form>
</body>
	<script language="javascript">
	$(document).ready(function() {
		  $(".multiSelect").select2();
		});
</script>
</html>
