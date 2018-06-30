<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="true">
	<base target="_self">
	<head>
		<title>按角色分配权限-查询角色</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		   <link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		   <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	</head>
	<script language="javascript">
		function loadParentTree(id){
			parent.window.document.all.SysObjID.value=id;
			parent.window.loadTree(id);
		}
	</script>

	<body>
		<form action="power/findRole" method="post" id="powerFindRoleForm">
			<div class="well form-search">
				名称
				<input type="text" name="roleName" value="${requestScope.roleName }"
					class="input-medium search-query" />
				<button type="submit" class="btn btn-info" id="chaxun"
					onclick="trimAll();">
					搜索
				</button>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				<tr>
					<td>
						名称
					</td>
				</tr>
				<c:forEach var="sysRole" items="${pagelist.data}">
					<tr onclick="loadParentTree(${sysRole.roleId})">
						<td style="cursor: pointer;">
							${sysRole.roleName}
						</td>
					</tr>
				</c:forEach>
			</table>
			<!-- Page Module Begin -->
			<div class="pageBody">
				<jsp:include page="../common/Page.jsp" />
			</div>
		</form>
	</body>
</html>
