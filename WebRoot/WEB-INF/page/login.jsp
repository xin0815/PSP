<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>网络综合信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath %>css/style.css" rel="stylesheet" type="text/css" />
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
    <canvas id="myCanvas">
      	请使用Google浏览器
    </canvas>
    <div id="login_bc" class="login_bc">
        <div class="tb">
            <img src="images/tubiao.png">
        </div>
        <div class="szh">
            <img src="images/glxt.png">
        </div>
        <div class="Uform">
            <form action="<%=path%>/lg/login" id="loginform" method="post">
            	<input type="hidden" name="method" value="login" />
                <input type="text" class="username" id="username" name = "username" autocomplete="off"><br>
                <input type="password" class = "password" id="password" name = "password">
                <input  type="text" name="yzm" class="yzm" id="yzm" style="margin-top:15px;background-image: url(<%=basePath %>images/input_password.png);" />
                <td align="right">
					      	<img src="<%=basePath%>ImageRandServlet" />
				</td>
                <button type="button" class="btn_sub" id="dengluBtn"></button>
            </form>
        </div>

        <div>
            <ul>
                <li>
                    <a href="#" class="one"><img src="images/tubiao001.png"></a>
                </li>
                <li>
                    <a href="#" class="two"></a>
                </li>
                <li>
                    <a href="#" class="three"></a>
                </li>
            </ul>
        </div>
    </div>
    <div id="bq" class="bq">
        <span>版权所有内蒙古师范大学网络技术学院蒙ICP备123456789号</span>
    </div>
    
    <form action="<%=path%>/lg/login" id="checkform">
			<input type="hidden" name="method" value="ajaxCheck" />
			<input type="hidden" name="username" id="uname" />
			<input type="hidden" name="password" id="pass" />
			<input type="hidden" name="yzm" id="yzmtext"/>
	</form>
	<script type="text/javascript">
		<c:if test="${result=='1'}">window.parent.location.href='<%=basePath%>main/login';</c:if>
	</script>
	<script type="text/javascript">
        //323*1601   1601 -323 = 1278
        var canvas = document.getElementById("myCanvas");
        canvas.width = document.documentElement.clientWidth;
        canvas.height = document.documentElement.clientHeight;
        var ctx = canvas.getContext("2d");
        var img = new Image();
        img.src = "<%=basePath %>images/bg.png";
        if (canvas.getContext) {
            if (canvas.width <= 1273) {
                img.onload = function() {
                    ctx.drawImage(img, 323, 0, canvas.width, canvas.height, 0, 0, canvas.width, canvas.height);
                };
            } else if (canvas.width < 1915 && canvas.width > 1273) {
                img.onload = function() {
                    var begin = (canvas.width - 1278) / 2;
                    ctx.drawImage(img, 323 - begin, 0, canvas.width, 751, 0, 0, canvas.width, canvas.height);
                };
            } else {
                img.onload = function() {
                    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                };
            }
        }
    </script>
        <script type="text/javascript">
        window.onload = function() {
            var myloginBc = document.getElementById('login_bc');
            var myloginBcHeight = document.documentElement.clientHeight - 3;
            var leftWidth = (document.documentElement.clientWidth - 460) / 2;
            myloginBc.style.height = myloginBcHeight + "px";
            myloginBc.style.top = 3 + "px";
            myloginBc.style.left = leftWidth + "px";
            var mybq = document.getElementById('bq')
            var bqTop = document.documentElement.clientHeight * 0.95;
            var bqLeft = leftWidth * 0.2;
            mybq.style.top = bqTop + "px";
            mybq.style.left = bqLeft + "px";
        }
    </script>
  </body>
</html>
