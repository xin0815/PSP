<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>权限管理</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="<%=basePath %>js/system/all.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="STYLESHEET" type="text/css"
			href="<%=basePath %>css/system/dhtmlxtree.css"></link>
		<script src="<%=basePath %>js/system/dhtmlxcommon.js"></script>
		<script src="<%=basePath %>js/system/dhtmlxtree_imnu.js"> </script>
		<script src="<%=basePath %>js/system/dhtmlXTree_xw.js"></script>
		<script language="javascript" src="<%=basePath %>js/jquery-1.6.4.js"></script>
		<style type="text/css">
* {
	margin: 0;
	padding: 0
}

ul,li {
	list-style: none
}

.box {
	width: 100%;
	height: 540;
	border: 1px solid #ccc;
	margin: 10px;
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif
}

.tagMenu {
	height: 28px;
	line-height: 28px;
	background: #efefef;
	position: relative;
	border-bottom: 1px solid #999
}

.tagMenu h2 {
	font-size: 12px;
	padding-left: 10px;
}

.tagMenu ul {
	position: absolute;
	left: 100px;
	bottom: -1px;
	height: 26px;
}

ul.menu li {
	float: left;
	margin-bottom: 1px;
	line-height: 16px;
	height: 14px;
	margin: 5px 0 0 -1px;
	border-left: 1px solid #999;
	text-align: center;
	padding: 0 12px;
	cursor: pointer
}

ul.menu li.current {
	border: 1px solid #999;
	border-bottom: none;
	background: #fff;
	height: 25px;
	line-height: 26px;
	margin: 0
}

.content {
	padding: 10px
}
</style>

		<script type="text/javascript">
		//tab
	$(document).ready(function(){
	    $("ul.menu li:first-child").addClass("current");
	    $("div.content").find("div.layout:not(:first-child)").hide();
	    $("div.content div.layout").attr("id", function(){return idNumber("No")+ $("div.content div.layout").index(this)});
	    $("ul.menu li").click(function(){
	        var c = $("ul.menu li");
	        var index = c.index(this);
	        var p = idNumber("No");
	        show(c,index,p);
	    });
	    function show(controlMenu,num,prefix){
	        var content= prefix + num;
	        $('#'+content).siblings().hide();
	        $('#'+content).show();
	        controlMenu.eq(num).addClass("current").siblings().removeClass("current");
	    };
	    function idNumber(prefix){
	        var idNum = prefix;
	        return idNum;
	    };
	 });
        </script>
	</head>
	<body>
		<form action="Power/main" method="post">
			<div class="box">
				<div class="tagMenu">
					<h2></h2>
					<ul class="menu">
						<li>
							按角色分配权限
						</li>
						<li>
							按用户分配权限
						</li>
					</ul>
				</div>
				<div class="content">
					<div class="layout">
						<iframe id="left" name="left" src="power/role"
							class="leftMenuFrame" frameBorder="0" scrolling="auto"
							height="450" width="100%"></iframe>
					</div>
					<div class="layout">
						<iframe id="left" name="left" src="power/user"
							class="leftMenuFrame" frameBorder="0" scrolling="auto"
							height="450" width="100%">
					</div>
				</div>
			</div>
		</form>
	</body>
</html>
