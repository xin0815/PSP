<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html lang="true">
	<base target="_self">
	<head>
		<title>按角色分配权限</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath %>css/system/treeStyle.css"></link>
		<link rel="STYLESHEET" type="text/css"
			href="<%=basePath %>css/system/dhtmlxtree.css"></link>
		<script src="<%=basePath %>js/system/dhtmlxcommon.js"> </script>
		<script src="<%=basePath %>js/system/dhtmlxtree.js"> </script>
		<script language="javascript" src="<%=basePath %>js/system/all.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
	</head>
	<script language="javascript">
		$(function(){
			$("#_save_img").click(function(){
				document.getElementById("id").value = tree.getAllChecked();
		        $("#powerUserForm").submit();
			});
		});
		function loadTree(id){
			document.all.treeboxbox_tree.innerHTML = "";
			tree = new dhtmlXTreeObject("treeboxbox_tree", "100%", "100%", 0);
            tree.setImagePath("<%=path%>/images/treeImg/bluebooks/");
            tree.enableCheckBoxes(1); 
            tree.enableThreeStateCheckboxes(true);
			tree.loadXML("<%=path%>/power/downloadTree?id="+id+"&type=user");
			document.all._save_img.style.display = "";
		}
	</script>

	<body>
		<form action="power/pageUpdate" method="post" id="powerUserForm">
			<input type="hidden" id="id" name="id" value="" />
			<input type="hidden" id="SysObjID" name="SysObjID" />
			<input type="hidden" id="type" name="type" value="user">
			<span style="color: red">${errorInfo}</span>
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="75%" valign="top">
						<iframe id="left" name="left" src="power/findUser"
							class="leftMenuFrame" frameBorder="0" scrolling="auto"
							height="350" width="93%"></iframe>
					</td>
					<td width="25%" valign="top">
						<div align="center">
							<div id="treeboxbox_tree"
								style="width: 93%; height: 350; overflow: auto;" align="left">
							</div>
						</div>
					</td>
				</tr>
			</table>
			<div class="form-actions" align="center">
				<button type="button" class="btn btn-primary" style="display: none"
					id="_save_img">
					保存
				</button>
			</div>
		</form>
	</body>
</html>
