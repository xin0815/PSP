<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap-4.0.0-alpha/acss/bootstrap.acss" />
					<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
<title>Insert title here</title>
</head>
<body><div class="dropdown open">
 <select id="categoryId" name="class_type" class="input-medium">
			<c:forEach var="academy" items="${academy}">
					<option
						value="${academy.aacademyCode}">
						${academy.aname}
					</option>
				</c:forEach>
			</select>
</div>
</body>
</html>