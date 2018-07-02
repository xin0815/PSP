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
		<title>贫困认定指标查看</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	</head>
	<body>
		 <legend>
			临时伙食补贴指标查看
	     </legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年减免学费指标分配情况，请等待发布并再进行查询。</h4></div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<form action="poorDistribution/list" method="post" class="form-inline" id="PoorTargetForm">
				<nav class="navbar navbar-default" role="navigation" style="background-color: rgb(241, 240, 240)">
					<div class="form-group">
						贫困认定年度
						<input type="text" name="schoolYear.syname" class="form-control" value="${huoshiInfo.schoolYear.syname}" readonly="readonly" />
					</div>	
					<div class="form-group">
						贫困认定名称
						<input type="text" name="pname" class="form-control"  readonly="readonly" value="${poorInfo.pname}" />
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
				</nav>
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
						特困生
					</th>
					<th>
						困难生
					</th>
					<th>
						一般困难生
					</th>
				</tr>
				<c:forEach var="pd" items="${pdList}" varStatus="st">
					<tr>
						<td>
							${st.index + 1}
						</td>
						<td>
							${pd.academy.aname}
						</td>
						<td>
							${pd.acaStudentNum}
						</td>
						<td>
							${pd.pdspecialDifficultyN}
						</td>
						<td>
							${pd.pddifficultyN}
						</td>
						<td>
							${pd.pdgeneralDiffcultyN}
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</body>
</html>