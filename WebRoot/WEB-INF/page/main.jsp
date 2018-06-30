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
		<script language="javascript"
			src="<%=basePath%>js/jquery.ajax.form.js"></script>
		<script type="text/javascript">
		
			
		
		
$(function(){
			setInterval(function(){
				document.getElementById("mytime").innerHTML=""+(new Date()).toLocaleString();
				},1000);
	$("#logout").click(function(){
	if(confirm('您确定要退出系统吗？')) {//删除
		$.postJSON4Form($("#logform"),function(d) {
			if(d['result'] == '1')
				{
				  window.location.href='<%=basePath%>main/login';
				  window.parent.location.reload();
				}
		});
		
		return false;
		}
		});
});

function initMenu() {
  $('#sidemenu ul').hide();
  $('#sidemenu ul:first').hide();
  $('#sidemenu li a').click(
    function() {
      var checkElement = $(this).next();
      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
      	  $('#sidemenu ul:visible').slideUp('normal');
        return false;
        }
      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
        $('#sidemenu ul:visible').slideUp('normal');
        checkElement.slideDown('normal');
        return false;
        }
      }
    );
  }
$(document).ready(function() {initMenu();});

</script>
	</head>

	<body>
		<form action="main/index" method="post">
			<div id="header">
				<div id="pic">
					<img src="<%=basePath %>images/tubiao.png">
				</div>
				<div id="pics">
					<img src="<%=basePath %>images/biaoti.png">
				</div>
				<div id="picss">
				</div>
			</div>
			<div id="head">
				<div class="bar_link">
					<a style="float: left;padding-left: 80px;">${user.userName }欢迎您</a><a id="logout"style="float:right;">退出系统</a><a style="float:right;">系统帮助</a><a id="mytime" style="float:right;"></a>
				</div>
			</div>

			<div id="left_content">
				
				<div class="leftbar">
					<ul id="sidemenu">
						<c:forEach var="menu" items="${menuList}">
							<li>
								<a><img src="<%=basePath %>images/${menu.fMenuName}">
								</a>

								<ul>
									<c:forEach var="sysPage" items="${menu.sysPages}">
										<li>
											<c:if test="${sysPage.url != null && sysPage.url != ''}">
												<a href="<%=basePath%>${sysPage.url}" target="rightFrame">${sysPage.pageName}</a>
											</c:if>
											<c:if test="${sysPage.url == null || sysPage.url == ''}">
												<a
													href="<%=basePath%>main/sanJiCaiDan?pageId=${sysPage.pageId}"
													target="rightFrame">${sysPage.pageName}</a>
											</c:if>
										</li>
									</c:forEach>
								</ul>

							</li>
						</c:forEach>

					</ul>
				</div>
			</div>

			<div id="center">
				<div id="center_content">
					<iframe id="rightFrame" name="rightFrame"
						src="<%=basePath%>main/center" height="100%" width="100%"
						frameborder="0">
					</iframe>
				</div>
				<div id="footer">
					<div class="zuihou">
						<p>
							版权所有内蒙古师范大学网络技术学院蒙ICP备123456789号
						</p>
						<p>
							地址：内蒙古呼和浩特市赛罕区昭乌达路81号 内蒙古师范大学网络技术学院
						</p>
						<p>
							电子邮箱：help@imnu.edu.cn
						</p>

					</div>
				</div>
			</div>
		</form>
		<form action="<%=path%>/lg/login" id="logform">
			<input type="hidden" name="method" value="userLogout" />
		</form>
	</body>
</html>