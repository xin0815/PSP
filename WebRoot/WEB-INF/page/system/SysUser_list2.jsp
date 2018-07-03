<!-- 学院班级管理 -->
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.imnu.cnt.system.util.Constants"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
	<head>
		<title>用户维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
        <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
	</head>
<script language="javascript">
function preview()
{
	
	var bdhtml=window.document.body.innerHTML;//获取当前页的html代码
	var sprnstr="<!--startprint-->";//设置打印开始区域
	var eprnstr="<!--endprint-->";//设置打印结束区域
	var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
	var prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
	window.document.body.innerHTML=prnhtml;
	window.print();
	window.document.body.innerHTML=bdhtml;
}
function changeform()
{

$.post("<%=basePath %>changeform", {uid: $('#score').val()},function(data,status){
	
	if(status == 'success' && data == "1"){
		window.location.href="${basePath}system/SysUser_list2";
		
	}else{
		window.location.href="${basePath}SysUser_list2.jsp";
	}
});
}
</script>


	<body>
	<%=basePath%>system/SysUser_list2
		<form action="sysUser/query" method="post" id="sysUserForm">
		<nav class="navbar navbar-default" role="navigation"
			style="background-color: rgb(241, 240, 240)">
		
				年级
				<select id="categoryId" name="categoryId" class="input-medium">
					<option value="">
						---- 全部 ----
					</option>
					<c:forEach var="category" items="${categoryList}">
						<option value="${category.id }">
							${category.categoryName }
						</option>
					</c:forEach>
				</select>
				学院
				<select id="nstitute" name="institute" class="input-medium">
					<option value="">
						---- 全部 ----
					</option>
					<c:forEach var="category" items="${categoryList}">
						<option value="${category.id }">
							${category.categoryName }
						</option>
					</c:forEach>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				专业
				<input name="profession	" value="专业"/>
				专业方向
				<input name="professiond	" value="专业方向"/>
				学号
				<input name="score" value="学号"/>
				</select>
				选择模式
				<select id="score" class="score" class="input-medium" onchange="changeform()">
					<option value="1">
						中文成绩单
					</option>
					<option value="2">
							英文成绩单
					</option>
				</select>
				<button type="submit" class="btn btn-primary" id="chaxun">
					           搜索
				 </button>
				<center>
				<br/>

				   	<button type="button" class="btn btn-success" id="print">
						导出Excel
					</button>	
				   <button type="button" class="btn btn-success" id="printshow">
				   <a href="<%=basePath %>download">打印证明</a> 	
				   </button>
						
				
					<button type="button" class="btn btn-success" id="printshow">
						打印预览
					</button>
					<button type="button" class="btn btn-success" id="print" onclick=preview()>
						打印
					</button>	
				</center>				
			</nav>
			成绩单参数设置：<br/>			
			不显示不及格:
			<input type="checkbox" name=""value="主修"/>主修&nbsp
			<input type="checkbox" name=""value="辅修"/>辅修&nbsp
			<input type="checkbox" name=""value="任选"/>任选&nbsp
			<input type="checkbox" name=""value="限选"/>限选<br/>
			不显示：
			<input type="checkbox" name=""value="主修"/>主修&nbsp
			<input type="checkbox" name=""value="辅修"/>辅修&nbsp
			<input type="checkbox" name=""value="任选"/>任选&nbsp
			<input type="checkbox" name=""value="限选"/>限选<br/>
			<jsp:include page="../common/Page.jsp" />
			</form>
			
			<div style="width:25%; margin:0 auto;height:600px; float:left;"><!--- 响应式表格 -->
			 <table class="table table-condensed table-hover">
			    <tr>
					<th width="100px">序号</th>
					<th width="50px"><input type="checkbox" name="allcheck" id="selectAll" /></th>
					<th width="100px">学号</th>
					<th width="250px">姓名</th>
				</tr>
				<tr>
					<td>1</td>
					<td width="30px"><input type="checkbox" name="checkbox" value="${sysUser.userId}" /></td>
					<td>200520071</td>
					<td>张婷婷</td>
				</tr>
				<c:forEach var="sysUser" items="${pager.data}" varStatus="st">
						<tr>
							<td ${st.index + 1}></td>
							<td width="30px"><input type="checkbox" name="checkbox" value="${sysUser.userId}" /></td>
							<td>
							
							</td>
							<td>
							12
							</td>
							<td>
								12
							</td>
						</tr>
					</c:forEach>
					
			</table>
		</div>
		<div style="width:75%; margin:0 auto; " >
		
		<!--startprint-->
		<center>
		<table border="1" cellspacing="0"style="width:210mm;" >
		
			<caption style="text-align:center">内蒙古师范大学学生成绩单</caption>
			<tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">姓名</td>
		    <td style="word-break: break-all;  text-align:center;">张婷婷</tdh>
		    <td style="word-break: break-all;  text-align:center;">学号</td>
		     <td style="word-break: break-all;  text-align:center;">200520071</td>
		    <td style="word-break: break-all;  text-align:center;">性别</td>
		     <td style="word-break: break-all;  text-align:center;">女</td>
		    <td style="word-break: break-all;  text-align:center;">班级</td>
		     <td style="word-break: break-all;  text-align:center;">05级人力国交2班</td>
			</tr>
		<table>
		<table border="1" cellspacing="0"style="width:210mm;">
		    <tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">专业</td>
		    <td width="30%"colspan="3" style="word-break: break-all;  text-align:center;">人力资源管理</td>
		    <td style="word-break: break-all;  text-align:center;">专业方向</td>
		    <td width="30%" style="word-break: break-all;  text-align:center;"></td>
		    </tr>
		   	<tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">院系</td>
		    <td width="30%" colspan="3" style="word-break: break-all;  text-align:center;">经济学院<br>11111111111111111111111111111111111111111111111111111111111111111</td>
		    <td style="word-break: break-all;  text-align:center;">培养方案1111111111111111111111111111111111111111</td>
		    <td width="40%"colspan="3" style="word-break: break-all;  text-align:center;">人力资源管理方案（国交）a1111111111111111111111</td>
		    </tr>
		 <table>
		 <table border="1" cellspacing="0"style="width:210mm;">
		   	<tr>
		    <th colspan="2" width="35%" style="word-break: break-all;  text-align:center;">课程名</th>
		    <th   width="7%"  style="word-break: break-all;  text-align:center;">学分</th>
		    <th  width="7%" style="word-break: break-all;  text-align:center;">成绩</th>
		    <th colspan="2"  width="35%" style="word-break: break-all;  text-align:center;">课程名</th>
		    <th  width="7px" style="word-break: break-all;  text-align:center;">学分</th>
		    <th  width="7px" style="word-break: break-all;  text-align:center;">成绩</th>
		    </tr>
		    <tr>
			<td colspan="2" style="word-break: break-all;  text-align:center;">111111111111111111111111111111111111111111111111111111111111111111111111111</td>
			<td style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    <td colspan="2" style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    </tr>
		    <tr>
		   		<td colspan="2"></td>
		    	<td></td>
		    	<td></td>
		    		
		    	<td colspan="2" style="word-break: break-all;  text-align:center;">学位评定</td>
		    	<td colspan="2" style="word-break: break-all; text-align:center;">管理学、经济学学士</td>
		    </tr>
		  </table>
		  <table border="1" cellspacing="0"style="width:210mm;">    
			<tr>
			<td align="right">	 内蒙古师范大学档案馆<br>
			    2017年3月10日</td>
			</tr>
		</table>
		</center>
		<!--endprint-->
		
		</div>
		
		
		<div style="width:75%; margin:0 auto;">
		
		<!--startprint-->
		<center>
		<table border="1" cellspacing="0"style="width:210mm;">
		
			<caption style="text-align:center">内蒙古师范大学学生成绩单<br/>Academic Transcript of Inner Monglia Normal University</caption>
			<tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">姓名 &nbsp Name</td>
		    <td style="word-break: break-all;  text-align:center;">张婷婷</tdh>
		    <td style="word-break: break-all;  text-align:center;">学号 &nbsp Student Number</td>
		     <td style="word-break: break-all;  text-align:center;">200520071</td>
		    <td style="word-break: break-all;  text-align:center;">性别 Gender</td>
		     <td style="word-break: break-all;  text-align:center;">女</td>
		    <td style="word-break: break-all;  text-align:center;">班级 Class</td>
		     <td style="word-break: break-all;  text-align:center;">05级人力国交2班</td>
			</tr>
		<table>
		<table border="1" cellspacing="0"style="width:210mm;">
		    <tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">专业 Major</td>
		    <td width="30%"colspan="3" style="word-break: break-all;  text-align:center;">人力资源管理</td>
		    <td style="word-break: break-all;  text-align:center;">专业方向 Professional direction</td>
		    <td width="30%" style="word-break: break-all;  text-align:center;"></td>
		    </tr>
		   	<tr>
		    <td width="45px" style="word-break: break-all;  text-align:center;">院系 School</td>
		    <td width="30%" colspan="3" style="word-break: break-all;  text-align:center;">经济学院<br>11111111111111111111111111111111111111111111111111111111111111111</td>
		    <td style="word-break: break-all;  text-align:center;">培养方案 Cultivation Scheme</td>
		    <td width="40%"colspan="3" style="word-break: break-all;  text-align:center;">人力资源管理方案（国交）a1111111111111111111111</td>
		    </tr>
		 <table>
		 <table border="1" cellspacing="0"style="width:210mm;">
		   	<tr>
		    <th colspan="2" width="35%" style="word-break: break-all;  text-align:center;">课程名 Course Name</th>
		    <th   width="7%"  style="word-break: break-all;  text-align:center;">学分  Credi</th>
		    <th  width="7%" style="word-break: break-all;  text-align:center;">成绩  Scor</th>
		    <th colspan="2"  width="35%" style="word-break: break-all;  text-align:center;">课程名  Course Name</th>
		    <th  width="7px" style="word-break: break-all;  text-align:center;">学分 Credi</th>
		    <th  width="7px" style="word-break: break-all;  text-align:center;">成绩 Scor</th>
		    </tr>
		    <tr>
			<td colspan="2" style="word-break: break-all;  text-align:center;">111111111111111111111111111111111111111111111111111111111111111111111111111</td>
			<td style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    <td colspan="2" style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    <td style="word-break: break-all;  text-align:center;">1</td>
		    </tr>
		    <tr>
		   		<td colspan="2"></td>
		    	<td></td>
		    	<td></td>
		    		
		    	<td colspan="2" style="word-break: break-all;  text-align:center;">学位评定 Degree awarded</td>
		    	<td colspan="2" style="word-break: break-all; text-align:center;">管理学、经济学学士</td>
		    </tr>
		  </table>
		  <table border="1" cellspacing="0"style="width:210mm;">    
			<tr>
			<td align="right">	 内蒙古师范大学档案馆 Archives of Inner Mongolia Normal University<br>
			    2017年3月10日</td>
			</tr>
		</table>
		</center>
		<!--endprint-->
		
		</div>
	</body>
</html>
