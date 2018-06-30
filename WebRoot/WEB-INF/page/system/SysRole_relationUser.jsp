<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>角色用户关联</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.css" />
			<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>

		<script type="text/javascript">
		$(function(){
			$("#baocun").click(function(){
		    	$("#form1").submit();
			});
			$("#_close").click(function(){
		        window.location.href='<%=basePath%>sysRole/list';
			});
		});
function queryAllGroup(){
	var returnValue = window.showModalDialog('<%=path%>/sysGroup/queryAllGroup',window,'dialogWidth:540px;dialogHeight:400px;status:no;edge:sunken');
}
</script>
	</head>
	<body>
		<form action="sysRole/saveRelationUser" method="post" id="form1">
			<input type="hidden" name="roleId" value="${sysRole.roleId }" />
			<input type="hidden" id="_relationUserId" name="_relationUserId"
				value="${_relationUserIds}">
			<fieldset>
				<table border="0" width="100%" align="left">
					<tr>
						<td valign="top">
							<table border="0" width="100%" align="left">
								<tr>
									<td align="left" valign="top" width="30%">
										已有用户：
										<table id="_relationUserInfo"
											class="table table-striped table-bordered table-condensed">
											<tr>
												<td>
													名称
												</td>
											</tr>
											<c:forEach var="userRole" items="${userRoleList}">
												<tr id="TR_${userRole.sysUser.userId}">
													<td>
														${userRole.sysUser.userName}
													</td>
												</tr>
											</c:forEach>
										</table>
									</td>
									<td valign="top" width="70%" height="480">
										<iframe id="left" name="left" src="sysUser/queryAllUser"
											class="leftMenuFrame" frameBorder="0" scrolling="auto"
											height="480" width="100%"></iframe>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center">
							<button type="button" class="btn btn-primary" id="baocun">
								保存
							</button>
							<button type="button" class="btn btn-info" id="_close">
								取消
							</button>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</body>
</html>