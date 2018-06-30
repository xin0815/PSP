<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.imnu.cnt.system.model.SysUser"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	SysUser user = (SysUser)request.getSession().getAttribute("user");
	int isLog = 1;
	if(user == null){
		isLog = 0;
	}
	
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="<%=basePath %>js/jquery/jquery.min.js"></script>
		<link href="<%=basePath %>css/table.css" rel="stylesheet"
			type="text/css" />
		<style type="text/css">
.button {
	display: inline-block;
	zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
	*display: inline;
	vertical-align: baseline;
	margin: 0 2px;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 30px/100% Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
	-webkit-border-radius: .5em;
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
}

.button:hover {
	text-decoration: none;
}

.button:active {
	position: relative;
	top: 1px;
}

/*搜索头部*/
#header {
	min-height: 15px;
	padding: 20px;
}

.page {
	margin-bottom: 0px;
	margin-left: 30px;
	float: bottom;
	bottom: 0px;
	right: 0px;
	margin-right: 0px;
	width: 420px;
	height: 25px;
}

body {
	background-color: #f5f5f5;
}

#contentone {
	position: absolute;
	top: 200px;
	left: 150px;
	margin: 0 0 0 0;
	background-color: #f5f5f5;
}

#contenttwo {
	position: absolute;
	top: 350px;
	left: 150px;
	margin: 0 0 0 0;
	background-color: #f5f5f5;
}

/* blue */
.blue {
	color: #d9eef7;
	border: solid 1px #0076a3;
	background: #0095cd;
	background: -webkit-gradient(linear, left top, left bottom, from(#00adee),
		to(#0078a5) );
	background: -moz-linear-gradient(top, #00adee, #0078a5);
	filter: progid : DXImageTransform.Microsoft.gradient ( startColorstr =
		'#00adee', endColorstr = '#0078a5' );
}

.blue:hover {
	background: #007ead;
	background: -webkit-gradient(linear, left top, left bottom, from(#0095cc),
		to(#00678e) );
	background: -moz-linear-gradient(top, #0095cc, #00678e);
	filter: progid : DXImageTransform.Microsoft.gradient ( startColorstr =
		'#0095cc', endColorstr = '#00678e' );
}

.blue:active {
	color: #80bed6;
	background: -webkit-gradient(linear, left top, left bottom, from(#0078a5),
		to(#00adee) );
	background: -moz-linear-gradient(top, #0078a5, #00adee);
	filter: progid : DXImageTransform.Microsoft.gradient ( startColorstr =
		'#0078a5', endColorstr = '#00adee' );
}
</style>

	</head>

	</head>

	<body>
		<form action="main/sanJiCaiDan" method="post">
			<div id="Layer1">
				<img src="<%=basePath %>images/shang.png" width="100%" height="90" />
			</div>
			<div id="contentone">
				<c:forEach var="sysPage" items="${sysPageList}">
					<a href="<%=basePath%>${sysPage.url}" style=""><div
							class="button blue">
							${sysPage.pageName}
						</div>
					</a>
					<br />
					<br />
				</c:forEach>
				</div>
			</div>

		</form>
	</body>
</html>
