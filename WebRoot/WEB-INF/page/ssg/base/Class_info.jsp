<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<head>
	<title>班级信息查看</title>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
</head>
<body>
	<container>
		<h5>学院：${cp.academyInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;</h5>
		<table class="table table-bordered table-condensed table-hover">
			<tr>
        		<th nowrap="nowrap">班级名称</th>
				<th nowrap="nowrap">班级编号</th>
				<th nowrap="nowrap">班主任教工号</th>
				<th nowrap="nowrap">班主任姓名</th>
				<th nowrap="nowrap">年级</th>
				<th nowrap="nowrap">专业</th>
				<th nowrap="nowrap">授课语种</th>
				<th nowrap="nowrap">培养层次</th>
				<th nowrap="nowrap">是否师范</th>
			</tr>
			<tr>
				<td>
					${cp.cclassName}
				</td>
				<td>
					${cp.cclassCode}
				</td>
				<td>
					${cp.currTeacher.bteacherId}
				</td>
				<td>
					${cp.currTeacher.tname}
				</td>
				<td>
        			${cp.cgrade}
	          	</td>
        		<td>
        			${cp.cmajor}
         		</td>
        		<td>
        			${cp.clanguage }
		         </td>
				<td>
					${cp.clevel }
				</td>
				<td>
					<c:if test="${cp.cisTeacher == true }">是</c:if>
					<c:if test="${cp.cisTeacher == false }">否</c:if>
				</td>
			</tr>
		</table>
	</container>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#home" data-toggle="tab">班内学生</a>
		</li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="home">
			<table id="_table" class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>
						</th>
						<th>
							序号
						</th>
						<th>
							学号
						</th>
						<th>
							姓名
						</th>
						<th>
							出生年月
						</th>
						<th>
							性别
						</th>
						<th>
							民族
						</th>
						<th>
							政治面貌
						</th>
						<th>
							宿舍号
						</th>
						<th>
							本人联系方式
						</th>
					</tr>
					<c:forEach var="stu" items="${stuList}" varStatus="vs">
						<tr>
							<td width="30px">
								<input type="radio" " name="_radio" value="${stu.sstudentCode}" />
							</td>
							<td>
								${vs.index + 1 }
							</td>
							<td>
								${stu.sstudentCode}
							</td>
							<td>
								${stu.sname}
							</td>
							<td>
								${stu.sbirthDate }
							</td>
							<td>
								${stu.ssex }
							</td>
							<td>
								${stu.snation }
							</td>
							<td>
								${stu.spolitical }
							</td>
							<td>
								${stu.sdormNum }
							</td>
							<td>
								${stu.sphoneNum }
							</td>
						</tr>
					</c:forEach>
				</thead>
			</table>
		</div>
	</div>
	<div align="center">
		<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">
	   		返回
	   	</button>
	</div>
</body>
</html>