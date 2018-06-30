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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>网络综合信息</title>
		<link href="<%=basePath %>css/login.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=basePath %>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath %>js/jquery.ajax.form.js"></script>
		<script language="javascript">
$(function(){
    //登录
	$("#dengluBtn").click(function(){
         if($("#username").val() == "" || $("#password").val() == "")
             {
                 alert("用户名或密码为空!");
                 return false;
             }else//验证用户名是否存在
                 {
                   $("#uname").val($("#username").val());
                   $("#pass").val($("#password").val());
                   $("#yzmtext").val($("#yzm").val());
                   $.postJSON4Form($("#checkform"),function(d) {
            		
            			if(d['result'] == '2')
                			{
                               alert('用户不存在');
                               return false;
                			}else if(d['result'] == '3')
                    			{
                				  alert('密码不正确');
                                  return false;
                    			}else if(d['result'] == '5')
                    			{
	                  				  alert('验证码不正确');
	                                  return false;
	                      		}
                			else if(d['result'] == '4')//进行登录操作
                			{
                				 $.postJSON4Form($("#loginform"),function(d) {
                						if(d['result'] == '0')
                    						{
                							  window.location.href='<%=basePath%>main/index';
                    						}
                					});
                					
                					return false;
                			}
            		});
            		
            		return false;
                 }
	});
});
</script>
	</head>
	<body>
		<form action="<%=path%>/lg/login" id="loginform" method="post">
			<input type="hidden" name="method" value="login" />
			<div id="header">
				<div id="pic">
					<img src="<%=basePath %>images/01.png">
				</div>
				<div id="pics">
					<img src="<%=basePath %>images/13.png">
				</div>
				<div id="picss">
				</div>
				<div class="denglu">
					<table width="280" border="0" cellspacing="20" cellpadding="0"
						style="color: #ffffff">
						<tr>
							<td width="29%" height="22">
								<span class="STYLE4">用户名:</span>
							</td>
							<td width="71%" height="22">
								<input type="text" name="username" value="" id="username"
									style="width: 150px; height: 22px; border: solid 1px #ffffff; color: #000">
							</td>
						</tr>

						<tr>
							<br />
							<td height="22">
								<span class="STYLE4">密&nbsp;码:</span>&nbsp;
							</td>
							<td height="22">
								<input type="password" value="" name="password" id="password"
									style="width: 150px; height: 22px; border: solid 1px #ffffff; color: #000">
							</td>
						</tr>
						<tr>
					        <td><span class="STYLE2">验证码：</span></td>
					        <td><div class="div2">
					          <input name="yzm" type="text" id="yzm" style="height:22px;width:150px;outline:none;vertical-align:middle;"/>
					        </div></td>
					        <td align="right">
					      	<img src="<%=basePath%>ImageRandServlet" />
					      	</td>
					     </tr>
						<tr>
							<td height="25">
								&nbsp;
							</td>
							<td height="25">
								<div id="dengluBtn">
									<img src="<%=basePath %>images/anniu.png" width="65"
										height="25" border="0"></img>
								</div>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
			</div>


			<div id="footer">
				<div class="lianjie">
					<div id="tu">
						<a><img src="<%=basePath %>images/05.png">
						</a>
						<a><img src="<%=basePath %>images/07.png">
						</a>
					</div>
				</div>
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
		</form>
		<form action="<%=path%>/lg/login" id="checkform">
			<input type="hidden" name="method" value="ajaxCheck" />
			<input type="hidden" name="username" id="uname" />
			<input type="hidden" name="password" id="pass" />
			<input type="hidden" name="yzm" id="yzmtext"/>
		</form>
		<script type="text/javascript">
		<c:if test="${result=='1'}">window.parent.location.href='<%=basePath%>main/login';</c:if>
</script>
	</body>
</html>
</html>