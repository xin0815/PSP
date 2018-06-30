<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<title>My JSP 'xsxxxxb.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
<script language="javascript">
	$(function() {
		$("#update").click(function() {//跳到更新页，进行更新操作
			$("#updateForm").submit();
		});
	})
</script>
</head>

<body>
	<legend>学生基本信息</legend>
	<table class="table table-bordered table-condensed table-striped">
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>曾用名</th>
			<th>出生年月</th>
			<th>性别</th>
			<th>民族</th>
			<th>政治面貌</th>
			<th>加入时间</th>
			<th>宿舍号</th>
			<th>学院</th>
			<th rowspan="4" width="150px;">
				<c:if test="${not empty stu.pictureUrl}">
					<img alt="一寸相" src="<%=basePath %>stuPicture/${stu.pictureUrl}" width="148" height="148" />
				</c:if>
			</th>
		</tr>
		<tr>
			<td>${stu.sstudentCode}</td>
			<td>${stu.sname}</td>
			<td>${stu.soldName}</td>
			<td>${stu.sbirthDate}</td>
			<td>${stu.ssex}</td>
			<td>${stu.snation.name}</td>
			<td>${stu.spolitical}</td>
			<td>${stu.joinDate}</td>
			<td>${stu.sdormNum}</td>
			<td>${stu.cclass.academyInfo.aname}</td>
		</tr>
		<tr>
			<th >本人联系方式</th>
			
			<th>邮编</th>
			<th>籍贯</th>
			<th>是否孤儿</th>
			<th>是否残疾</th>
			<th>残疾等级</th>
			<th>联系人1</th>
			<th>与本人关系</th>
			<th>联系人1电话</th>
			<th>专业</th>
		</tr>
		<tr>
			<td >${stu.sphoneNum}</td>
			
			<td>${stu.spostcode}</td>
			<td>${stu.sorigin}</td>
			<td>
				<c:if test="${stu.sisOrphan eq 'true' }">是</c:if>
				<c:if test="${stu.sisOrphan eq 'false' }">否</c:if>
			</td>
			<td>
				<c:if test="${stu.sisDisable eq 'true' }">是</c:if>
				<c:if test="${stu.sisDisable eq 'false' }">否</c:if>
			</td>
			<td>${stu.sdisableLevel}</td>
			<td>${stu.srelation1}</td>
			<td>${stu.srelationship1}</td>
			<td>${stu.srelationPhone1}</td>
			<td>${stu.cclass.cmajor}</td>
		</tr>
		<tr>
			<th colspan="2">家庭详细地址</th>
			<th colspan="2">生源地</th>
			<th colspan="1">入学前所在学校</th>
			<th colspan="1">校发农业银行卡卡号</th>
			<th>联系人2</th>
			<th>与本人关系</th>
			<th>联系人2电话</th>
			<th>年级</th>
			<th>身份证号</th>
		</tr>
		<tr>
			<td colspan="2">${stu.shomeAdd}</td>
			<td colspan="2">${stu.soriginHome}</td>
			<td colspan="1">${stu.soldSchool}</td>
			<td colspan="1">${stu.sCard}</td>
			<td>${stu.srelation2}</td>
			<td>${stu.srelationship2}</td>
			<td>${stu.srelationPhone2}</td>
			<td>${stu.cclass.cgrade }</td>
			<td>${stu.sidCard}</td>
		</tr>
	</table>
	<table class="table table-bordered table-condensed table-striped">
		<tr>
			<th rowspan="4" style="width: 30px; vertical-align: middle;">家</br>庭</br>成</br>员
			</th>
			<th>称呼</th>
			<th>姓名</th>
			<th>年龄</th>
			<th>政治面貌</th>
			<th>所在单位</th>
			<th>职务</th>
		</tr>
		<tr>
			<td>${stu.sfamilyRel1}</td>
			<td>${stu.sfamilyName1}</td>
			<td>${stu.sfamilyAge1}</td>
			<td>${stu.sfamilyPolitical1}</td>
			<td>${stu.sfamilyWork1}</td>
			<td>${stu.sfamilyWorkDuty1}</td>
		</tr>
		<tr>
			<td>${stu.sfamilyRel2}</td>
			<td>${stu.sfamilyName2}</td>
			<td>${stu.sfamilyAge2}</td>
			<td>${stu.sfamilyPolitical2}</td>
			<td>${stu.sfamilyWork2}</td>
			<td>${stu.sfamilyWorkDuty2}</td>
		</tr>
		<tr>
			<td>${stu.sfamilyRel3}</td>
			<td>${stu.sfamilyName3}</td>
			<td>${stu.sfamilyAge3}</td>
			<td>${stu.sfamilyPolitical3}</td>
			<td>${stu.sfamilyWork3}</td>
			<td>${stu.sfamilyWorkDuty3}</td>
		</tr>
	</table>
	<table class="table table-bordered table-condensed table-striped">
		<tr>
			<th rowspan="3" style="width: 30px; vertical-align: middle;">本</br>人</br>简</br>历
			</th>
			<th>时间</th>
			<th>单位</th>
			<th>证明人</th>
			<th>时间</th>
			<th>单位</th>
			<th>证明人</th>
		</tr>
		<tr>
			<td>${stu.sresumeDate1}</td>
			<td>${stu.soldSchool1}</td>
			<td>${stu.sresCertifier1}</td>
			<td>${stu.sresumeDate2}</td>
			<td>${stu.soldSchool2}</td>
			<td>${stu.sresCertifier2}</td>
		</tr>
		<tr>
			<td>${stu.sresumeDate3}</td>
			<td>${stu.soldSchool3}</td>
			<td>${stu.sresCertifier3}</td>
			<td>${stu.sresumeDate4}</td>
			<td>${stu.soldSchool4}</td>
			<td>${stu.sresCertifier4}</td>
		</tr>
	</table>
	<table class="table table-condensed table-bordered table-hover">
		<tr>
			<th colspan="3" style="text-align: center;">大学期间受表彰情况</th>
		</tr>
		<tr>
			<th>奖励名称</th>
			<th>奖励等级</th>
			<th>获奖时间</th>
		</tr>
		<c:forEach var="scholarship" items="${scholarshipList}">
			<tr>
				<td>
					校内奖学金
				</td>
				<td>
					<c:if test="${scholarship.satlevel eq '1'}">一等</c:if>
					<c:if test="${scholarship.satlevel eq '2'}">二等</c:if>
					<c:if test="${scholarship.satlevel eq '3'}">三等</c:if>
				</td>
				<td>
					${scholarship.scholarshipInfo.schoolYear.syname }
				</td>
			</tr>
		</c:forEach>
		<c:forEach var="mingde" items="${mingdeList}">
			<tr>
				<td>
					明德奖学金
				</td>
				<td>
					
				</td>
				<td>
					${mingde.mingdeInfo.schoolYear.syname }
				</td>
			</tr>
		</c:forEach>
	</table>
	<table class="table table-condensed table-bordered table-hover">
		<tr>
			<th colspan="3" style="text-align: center;">大学期间受资助情况</th>
		</tr>
		<tr>
			<th>资助名称</th>
			<th>金额</th>
			<th>受资助时间</th>
		</tr>
		<c:forEach var="lizhi" items="${lizhiList}">
			<tr>
				<td>
					励志奖学金
				</td>
				<td>
					${lizhi.lamoney}
				</td>
				<td>
					${lizhi.lizhiInfo.schoolYear.syname }
				</td>
			</tr>
		</c:forEach>
		<c:forEach var="grant" items="${grantList}">
			<tr>
				<td>
					国家助学金
				</td>
				<td>
					${grant.gamoney}
				</td>
				<td>
					${grant.lizhiInfo.schoolYear.syname }
				</td>
			</tr>
		</c:forEach>
		<c:forEach var="jianmian" items="${jianmianList}">
			<tr>
				<td>
					减免学费
				</td>
				<td>
					${jianmian.jamoney}
				</td>
				<td>
					${jianmian.jianmianInfo.schoolYear.syname }
				</td>
			</tr>
		</c:forEach>
	</table>
	<table class="table table-condensed table-bordered table-hover">
		<tr>
			<th colspan="8" style="text-align: center;">大学期间违纪情况</th>
		</tr>
		<tr>
			<th>违纪日期</th>
			<th>处分原因</th>
			<th>处分级别</th>
			<th>处分日期</th>
			<th>处分文号</th>
			<th>处分是否撤销</th>
			<th>撤销日期</th>
			<th>撤销理由</th>
		</tr>
		<c:forEach var="discipline" items="${disciplineList}">
			<tr>
				<td>
					${discipline.ddisDate }
				</td>
				<td>
					${discipline.dreason }
				</td>
				<td>
					${discipline.dlevel }
				</td>
				<td>
					${discipline.doccurDate }
				</td>
				<td>
					${discipline.dcode }
				</td>
				<td>
					<c:if test="${discipline.disCancel eq true}">
						是
					</c:if>
					<c:if test="${discipline.disCancel eq true}">
						否
					</c:if>
				</td>
				<td>
					${discipline.dcancelDate}
				</td>
				<td>
					${discipline.dcancelReason}
				</td>
			</tr>
		</c:forEach>
	</table>
	<table class="table table-condensed table-bordered table-hover">
		<tr>
			<th colspan="3" style="text-align: center;">参加社会实践活动</th>
		</tr>
		<tr>
			<th>参加社会实践活动名称</th>
			<th>角色</th>
			<th>参加日期</th>
		</tr>
	</table>
	<div align="center">
		<c:if test="${user.userType eq '01'}">
			<button type="button" class="btn btn-info" id="update">修改</button>
		</c:if>
		<c:if test="${user.userType ne '01'}">
		<button type="button" class="btn btn-info" onclick="history.back()" id="fhBtn">返回</button>
		</c:if>
	</div>
	<form action="student/toEdit" method="post" id="updateForm">
		<input type="hidden" name="stuCode" id="_updId"
			value="${stu.sstudentCode }" />
	</form>
</body>
</html>
