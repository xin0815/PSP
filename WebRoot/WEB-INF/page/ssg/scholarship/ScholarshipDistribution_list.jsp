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
		<title>校内奖学金认定指标查看</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	
	</head>
	<body>
	<legend>
			校内奖学金指标查看
		</legend>
		<c:if test="${empty scholarshipInfo }">
		<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度校内奖学金认定指标分配情况，请等待发布并再进行查询。</h4></div>
		</c:if>
		<c:if test="${not empty scholarshipInfo }">
		<form action="scholarshipDistribution/list" method="post" class="form-inline">
			<div class="well form-search">
				<div class="form-group">
					<label>校内奖学金认定年度</label>
					<input type="text" name="schoolYear.syname" class="form-control" value="${scholarshipInfo.schoolYear.syname}" readonly="readonly" />
				</div>	
				<div class="form-group">
					<label>校内奖学金认定名称</label>
					<input type="text" name="sname" class="form-control"  readonly="readonly" value="${scholarshipInfo.sname}" />
				</div>
				<button type="submit" class="btn btn-primary">查询</button>
			</div>
		</form>
		<table class="table table-bordered table-condensed ">
			<tr>
				<th>
					序号
				</th>
				<th>
					学院
				</th>
				<th>
					学生人数
				</th>
				<th>
					一等奖学金
				</th>
				<th>
					二等奖学金(含优秀学生干部奖)
				</th>
				<th>
					三等奖学金
				</th>
				<th>
					单项奖学金
				</th>
			</tr>
			<c:forEach var="ss" items="${ssList}" varStatus="st">
				<tr>
					<td>
						${st.index + 1}
					</td>
					<td>
						${ss.academy.aname}
					</td>
					<td>
						${ss.acaStudentNum}
					</td>
					<td>
						${ss.sdleve1}
					</td>
					<td>
						${ss.sdleve2}
					</td>
					<td>
						${ss.sdleve3}
					</td>
					<td>
						${ss.sdsingle}
					</td>
				</tr>
			</c:forEach>
		</table>
		</c:if>
	</body>
</html>
