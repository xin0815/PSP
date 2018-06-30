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
		<title>国家助学金指标查看</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	</head>
	<body>
		<legend>
			国家助学金指标查看
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年国家助学金指标分配情况，请等待发布并再进行查询。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<form action="grantDistribution/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						国家助学金年度
						<input type="text" name="schoolYear.syname" class="form-control" value="${grantInfo.schoolYear.syname}" readonly="readonly" />
					</div>	
					<div class="form-group">
						国家助学金名称
						<input type="text" name="name" class="form-control"  readonly="readonly" value="${grantInfo.name}" />
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
						名额
					</th>
					<th>
						金额
					</th>
				</tr>
				<c:forEach var="gd" items="${gdList}" varStatus="st">
					<tr>
						<td>
							${st.index + 1}
						</td>
						<td>
							${gd.academy.aname}
						</td>
						<td>
							${gd.acaStudentNum}
						</td>
						<td>
							${gd.gdnumber}
						</td>
						<td>
							${gd.gdmoney}
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</body>
</html>
